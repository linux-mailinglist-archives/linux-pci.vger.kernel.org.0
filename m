Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2FD2327B2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 00:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgG2WrO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 18:47:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgG2WrO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 18:47:14 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57052065C;
        Wed, 29 Jul 2020 22:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596062833;
        bh=36XtQWEJsEdp+ChV12HZH4Ktm83x8HHkNcFnnHcob2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PfgGQXWhcVjcmVn+Fsc+3rS2CTjz2GQ96wh16M7EoYyF4rZfRXP7OPN6p9p04ccCB
         gpko6RKIYcgGxKiOP8z+6h7gGRuBvJCbQD0xmjXVY//kckJiY+kQ2DNkEWAzCwUl3h
         VqEkuLgYfYXGEJHBuOYXwzKCt1G+Bf9UdgykiP58=
Date:   Wed, 29 Jul 2020 17:47:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [RFC] ASPM L1 link latencies
Message-ID: <20200729224710.GA1971834@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA85sZvJQge6ETwF1GkdvK1Mpwazh_cYJcmeZVAohmt0FjbMZg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 25, 2020 at 09:47:05PM +0200, Ian Kumlien wrote:
> Hi,
> 
> A while ago I realised that I was having all kinds off issues with my
> connection, ~933 mbit had become ~40 mbit
> 
> This only applied on links to the internet (via a linux fw running
> NAT) however while debugging with the help of Alexander Duyck
> we realised that ASPM could be the culprit (at least disabling ASPM on
> the nic it self made things work just fine)...
> 
> So while trying to understand PCIe and such things, I found this:
> 
> The calculations of the max delay looked at "that node" + start latency * "hops"
> 
> But one hop might have a larger latency and break the acceptable delay...
> 
> So after a lot playing around with the code, i ended up with this, and
> it seems to fix my problem and does
> set two pcie bridges to ASPM Disabled that didn't happen before.
> 
> I do however have questions.... Shouldn't the change be applied to
> the endpoint?  Or should it be applied recursively along the path to
> the endpoint?

I don't understand this very well, but I think we do need to consider
the latencies along the entire path.  PCIe r5.0, sec 5.4.1.3, contains
this:

  Power management software, using the latency information reported by
  all components in the Hierarchy, can enable the appropriate level of
  ASPM by comparing exit latency for each given path from Root to
  Endpoint against the acceptable latency that each corresponding
  Endpoint can withstand.

Also this:

  5.4.1.3.1 Software Flow for Enabling or Disabling ASPM

  Following is an example software algorithm that highlights how to
  enable or disable ASPM in a component.

  - PCI Express components power up with an appropriate value in their
    Slot Clock Configuration bit. The method by which they initialize
    this bit is device-specific.

  - PCI Express system software scans the Slot Clock Configuration bit
    in the components on both ends of each Link to determine if both
    are using the same reference clock source or reference clocks from
    separate sources.  If the Slot Clock Configuration bits in both
    devices are Set, they are both using the same reference clock
    source, otherwise they're not.

  - PCI Express software updates the Common Clock Configuration bits
    in the components on both ends of each Link to indicate if those
    devices share the same reference clock and triggers Link
    retraining by writing 1b to the Retrain Link bit in the Link
    Control register of the Upstream component.

  - Devices must reflect the appropriate L0s/L1 exit latency in their
    L0s /L1 Exit Latency fields, per the setting of the Common Clock
    Configuration bit.

  - PCI Express system software then reads and calculates the L0s/L1
    exit latency for each Endpoint based on the latencies reported by
    each Port. Refer to Section 5.4.1.2.2 for an example.

  - For each component with one or more Endpoint Functions, PCI
    Express system software examines the Endpoint L0s/L1 Acceptable
    Latency, as reported by each Endpoint Function in its Link
    Capabilities register, and enables or disables L0s/L1 entry (via
    the ASPM Control field in the Link Control register) accordingly
    in some or all of the intervening device Ports on that hierarchy.

> Also, the L0S checks are only done on the local links, is this
> correct?

ASPM configuration is done on both ends of a link.  I'm not sure it
makes sense to enable any state (L0s, L1, L1.1, L1.2) unless both ends
of the link support it.  In particular, sec 5.4.1.3 says:

  Software must not enable L0s in either direction on a given Link
  unless components on both sides of the Link each support L0s;
  otherwise, the result is undefined.

But I think we do need to consider the entire path when enabling L0s;
from sec 7.5.3.3:

  Endpoint L0s Acceptable Latency - This field indicates the
  acceptable total latency that an Endpoint can withstand due to the
  transition from L0s state to the L0 state. It is essentially an
  indirect measure of the Endpoint’s internal buffering.  Power
  management software uses the reported L0s Acceptable Latency number
  to compare against the L0s exit latencies reported by all components
  comprising the data path from this Endpoint to the Root Complex Root
  Port to determine whether ASPM L0s entry can be used with no loss of
  performance.

Does any of that help answer your question?

Bjorn

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ffd31b1..bd53fba7f382 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,7 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
> 
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -       u32 latency, l1_switch_latency = 0;
> +       u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
>         struct aspm_latency *acceptable;
>         struct pcie_link_state *link;
> 
> @@ -470,8 +470,9 @@ static void pcie_aspm_check_latency(struct pci_dev
> *endpoint)
>                  * substate latencies (and hence do not do any check).
>                  */
>                 latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> +               l1_max_latency = max_t(u32, latency, l1_max_latency);
>                 if ((link->aspm_capable & ASPM_STATE_L1) &&
> -                   (latency + l1_switch_latency > acceptable->l1))
> +                   (l1_max_latency + l1_switch_latency > acceptable->l1))
>                         link->aspm_capable &= ~ASPM_STATE_L1;
>                 l1_switch_latency += 1000;
