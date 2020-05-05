Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707591C5C44
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730563AbgEEPpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 11:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbgEEPpw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 May 2020 11:45:52 -0400
Received: from localhost (mobile-166-175-56-67.mycingular.net [166.175.56.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BCC206B9;
        Tue,  5 May 2020 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588693551;
        bh=TJ5JkssCdhFOYQwFIJPeii3/dV3iPQguY4nuHrVHRrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NFckFzKjcpgEh2s+QWD5+nT9J8r37cN82TjEVJy4G1zSPMFXq7PyBY3j/CLcTlpUJ
         XHJJMclZNs6U5HhS7HLUqXSRxWdK+WGRYWQ5x+7rKRNFCTKKRbRtuBfdIsBybrhEAR
         ZubZo1ixIJKrw7GcbxQoRGpi2a4tsGdpgYUaGnRM=
Date:   Tue, 5 May 2020 10:45:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/ASPM: Enable ASPM for root complex <-> bridge <->
 bridge case
Message-ID: <20200505154549.GA359490@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B6977248-C345-466D-AE8B-600088B73FA8@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 10:00:44PM +0800, Kai-Heng Feng wrote:
> > On May 5, 2020, at 21:38, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, May 05, 2020 at 08:27:59PM +0800, Kai-Heng Feng wrote:
> >> The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
> >> state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
> >> power. On Windows ASPM L1 is enabled on the device and its upstream
> >> bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
> >> power.
> > 
> > The above is a benefit, but leading off with it suggests that this
> > change is specifically for that config, which it isn't.
> 
> Yes, it applies all devices that meet the condition.
> 
> >> Currently, ASPM is disabled if downstream has bridge function. It was
> >> introduced by commit 7d715a6c1ae5 ("PCI: add PCI Express ASPM support").
> >> The commit introduced PCIe ASPM support, but didn't explain why ASPM
> >> needs to be in that case.
> > 
> > s/needs to be in that case/needs to be disabled in that case/ ?
> 
> Yes indeed I missed that word...
> 
> >> So relax the condition a bit to let bridge which connects to root
> >> complex enables ASPM, instead of removing it completely, to avoid
> >> regression.
> > 
> > If this is a regression, that means it used to work correctly.  So are
> > you saying 7d715a6c1ae5^ works correctly?  That seems doubtful since
> > 7d715a6c1ae5 appeared in v2.6.26 and added ASPM support in the first
> > place.
> 
> Clearly I didn't express my intention well enough.
> What I meant was, we can either remove the "disable ASPM on bridge"
> case completely, or do what this patch does.

Ah, that makes sense, thanks.

> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/pci/pcie/aspm.c | 14 ++++++++------
> >> 1 file changed, 8 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> >> index 2378ed692534..af5e22d78101 100644
> >> --- a/drivers/pci/pcie/aspm.c
> >> +++ b/drivers/pci/pcie/aspm.c
> >> @@ -629,13 +629,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> >> 	/* Setup initial capable state. Will be updated later */
> >> 	link->aspm_capable = link->aspm_support;
> >> 	/*
> >> -	 * If the downstream component has pci bridge function, don't
> >> -	 * do ASPM for now.
> > 
> > I agree, that comment is missing the essential information about *why*
> > we don't do ASPM.
> 
> Or missing a part to re-enable ASPM in later time.
> 
> >> +	 * If upstream bridge isn't connected to root complex and the
> >> +	 * downstream component has pci bridge function, don't do ASPM for now.
> > 
> > But this comment just perpetuates it and makes the special case even
> > more special.  I think we should either remove that special case
> > completely or figure out what the real issue is.
> 
> I do prefer remote it completely, but I was afraid of introducing
> any regression so I just made the case more "special".
> 
> > I know we weren't always very good about computing the acceptable
> > latencies (and we still don't handle LTR correctly, though that's an
> > L1 Substates issue that wouldn't have applied in the 7d715a6c1ae5
> > timeframe).
> 
> Seems like Windows doesn't disable ASPM on bridge to bridge case,
> can we take the risk and remove the special case completely?

I think we should remove the special case completely.  The spec
clearly envisions the possibility of ASPM being enabled on links
between switches, e.g., PCIe r5.0, sec 5.4.1.3.1, says:

  software examines the Endpoint L0s/L1 Acceptable Latency ... and
  enables or disables L0s/L1 entry ... in some or all of the
  intervening device Ports on that hierarchy.

We might break something, but if we do, we'll learn something concrete
about what we need to avoid.

> >> 	 */
> >> -	list_for_each_entry(child, &linkbus->devices, bus_list) {
> >> -		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
> >> -			link->aspm_disable = ASPM_STATE_ALL;
> >> -			break;
> >> +	if (parent->bus->parent) {
> >> +		list_for_each_entry(child, &linkbus->devices, bus_list) {
> >> +			if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
> >> +				link->aspm_disable = ASPM_STATE_ALL;
> >> +				break;
> >> +			}
> >> 		}
> >> 	}
> >> 
> >> -- 
> >> 2.17.1
> 
