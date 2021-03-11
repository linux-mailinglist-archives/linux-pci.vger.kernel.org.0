Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE933731D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 13:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhCKMxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 07:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233160AbhCKMxY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 07:53:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0475664FC3;
        Thu, 11 Mar 2021 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615467204;
        bh=DnEDJvBOcnn+xcMAMBOQVUQFe5m0A2svDeanci8B4pI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kON20EEmW+t2JyhDRhWTaQ6V243h/z55ycqRXoyck3OjbwPq6dq3JKdDGEL/AKgat
         a8I8h7IrB7dJ/sx34bf7DlTCN6HB90EgN3MArOb5M1k4qv/OcRMrRCLhhmLpH0uGmp
         uA+aCG2wk+IP7CR3UQXMuAgGUY8S0SKlaHpzYrHRo5Vi9F3dW7xkVPuRI/swXHNDWd
         2t2/dNyfhf0zEXjOfNsSLytDwS1HwdIWiMimRgvef4Xl0rzIsmCjzCwLXapMtQ6s9D
         hqkxzVIBpYUsMhUoCTt9AFiFril74vAQ1LZ1sZn4cn+5L4KX7ur3b+XObYvfXLTrze
         YRMRTZfLnsnUQ==
Date:   Thu, 11 Mar 2021 06:53:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shirish S <shirish.s@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Julian Schroeder <julian.schroeder@amd.com>,
        Daniel Drake <drake@endlessm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Add AMD RV2 based APUs, such as 3015Ce, to D3hot to
 D3 quirk table.
Message-ID: <20210311125322.GA2122226@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311044135.119942-1-shirish.s@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Daniel, Mika (author, reviewer of 3030df209aa8]

On Thu, Mar 11, 2021 at 10:11:35AM +0530, Shirish S wrote:
> From: Julian Schroeder <julian.schroeder@amd.com>
> 
> This allows for an extra 10ms for the state transition.
> Currently only AMD PCO based APUs are covered by this table.

I'm really glad to see this coming straight from AMD.  Is this a
documented erratum?  Please provide a reference to that.

The point is that quirks are for working around hardware defects.  If
the device is not defective, and it is actually following the spec
correctly, there should be a way to fix this in a generic way that
doesn't require quirks.  That avoids the need to add more quirks for
future devices.

> WIP. Working on commit to kernel.org.

I'm not sure what "WIP. Working on commit to kernel.org." means.  Does
it mean I should ignore this and wait for the final posting?

I'm OCD enough that I like commits doing the same thing to have the
same subject line.  This is an extension of 3030df209aa8 ("PCI:
Increase D3 delay for AMD Ryzen5/7 XHCI controllers"), so it should
look like that.

> Signed-off-by: Julian Schroeder <julian.schroeder@amd.com>

This appears to require an additional signoff from you, Shiresh; see
[1].

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n356

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..7d8f52524ada 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1904,6 +1904,7 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e5, quirk_ryzen_xhci_d3hot);
>  
>  #ifdef CONFIG_X86_IO_APIC
>  static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> -- 
> 2.17.1
> 
