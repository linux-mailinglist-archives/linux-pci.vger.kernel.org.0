Return-Path: <linux-pci+bounces-30463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADAAE57A1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 00:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD734471A8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 22:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48A1DB124;
	Mon, 23 Jun 2025 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRQonhQ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B64414
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750719519; cv=none; b=GLPiuKdWElMSCp6/t5G7jCfFNK280SB3e5nlrOn/bRdVJIKgx3uhXs1Oqw3pOziFRgS/LmLC8VT+fGdiiVTWLzBwaQ+cszQwwVzo/2ilt3baboNmfs8QWbBgrBCyzHtuy8VWiyWHb5KkSQH79uPlO1nLzutjUvM7HqnXw4L6pr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750719519; c=relaxed/simple;
	bh=CQUIx8rWDyK+10/5O0VSyWL+L1RfmrjuGwyd1FwEcMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eS1uw5vA9Db+6k8CwMa4UBKIiA0u5uICHlQB2tZLGdLcxTGXstqco6gPMiBI8CGLps0xAkpCqQ/h3kdI2AO0nuxw39YpTGRotFjay3eqEU85o5ME5T3rZnQm+HXC8oN4IvzS0RlHbDL0QKLZc5q95XjHIWj9hSK/RsqAuscnRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRQonhQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AEBC4CEED;
	Mon, 23 Jun 2025 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750719516;
	bh=CQUIx8rWDyK+10/5O0VSyWL+L1RfmrjuGwyd1FwEcMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cRQonhQ6nPL8m33GcbA6jwfojGQek8LIo84KVzV6SZ4TiuVFpfS2rpQOGmuKT3aYr
	 IQs7LJJqE3DnnLPJS/4bP6bFnu41QMJJA6Ihi9TbUiUpf+d2S7VmGxX5uHFmbEpwEp
	 8/yciyJA1Bczvm2GoAcVEm2lJU5JWEgVyeD112G6fNLNG5E1FH0jp6365FdFgLcwa5
	 a/1kDx62OSkVoRFtNEQWp+c5xWR1atGWhJQSYlbr8h+D5lNxXQqjAyAxNK2AaKEihj
	 cOziShVIMRHbJ2/Qrw9WIv5jBdX7Z5+RF5ZPEHl61FWIcxd2LNWBdsJPNQX2mRmIZt
	 7tUekCv5phTrg==
Date: Mon, 23 Jun 2025 17:58:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	raphael.norwitz@nutanix.com, alay.shah@nutanix.com,
	suresh.gumpula@nutanix.com, ilpo.jarvinen@linux.intel.com,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable RRS polling for Intel SSDPE2KX020T8 nvme
Message-ID: <20250623225835.GA1449671@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617201255.GA1100556@bhelgaas>

Ping, any chance you could try the patch below to collect a little
more data.  The proposed quirk covers up a deeper problem, and I want
to fix that problem instead of covering it up.

On Tue, Jun 17, 2025 at 03:12:55PM -0500, Bjorn Helgaas wrote:
> [+cc Chaitanya, Ville for possible Intel NVMe contacts]
> 
> On Mon, Jun 16, 2025 at 09:38:25PM +0800, Hui Wang wrote:
> > On 6/16/25 19:55, Hui Wang wrote:
> > > On 6/13/25 00:48, Bjorn Helgaas wrote:
> > > > [+cc VMD folks]
> > > > 
> > > > On Wed, Jun 11, 2025 at 06:14:42PM +0800, Hui Wang wrote:
> > > > > Prior to commit d591f6804e7e ("PCI: Wait for device readiness with
> > > > > Configuration RRS"), this Intel nvme [8086:0a54] works well. Since
> > > > > that patch is merged to the kernel, this nvme stops working.
> > > > > 
> > > > > Through debugging, we found that commit introduces the RRS polling in
> > > > > the pci_dev_wait(), for this nvme, when polling the PCI_VENDOR_ID, it
> > > > > will return ~0 if the config access is not ready yet, but the polling
> > > > > expects a return value of 0x0001 or a valid vendor_id, so the RRS
> > > > > polling doesn't work for this nvme.
> > > >
> > > > Sorry for breaking this, and thanks for all your work in debugging
> > > > this!  Issues like this are really hard to track down.
> > > > 
> > > > I would think we would have heard about this earlier if the NVMe
> > > > device were broken on all systems.  Maybe there's some connection with
> > > > VMD?  From the non-working dmesg log in your bug report
> > > > (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/+attachment/5879970/+files/dmesg-60.txt):
> > > > 
> > > > 
> > > >    DMI: ASUSTeK COMPUTER INC. ESC8000 G4/Z11PG-D24 Series, BIOS 5501
> > > > 04/17/2019
> > > >    vmd 0000:d7:05.5: PCI host bridge to bus 10000:00
> > > >    pci 10000:00:02.0: [8086:2032] type 01 class 0x060400 PCIe Root Port
> > > >    pci 10000:00:02.0: PCI bridge to [bus 01]
> > > >    pci 10000:00:02.0: bridge window [mem 0xf8000000-0xf81fffff]:
> > > > assigned
> > > >    pci 10000:01:00.0: [8086:0a54] type 00 class 0x010802 PCIe Endpoint
> > > >    pci 10000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> > > > 
> > > >    <I think vmd_enable_domain() calls pci_reset_bus() here>
> > > 
> > > Yes, and the pci_dev_wait() is called here. With the RRS polling, will
> > > get a ~0 from PCI_VENDOR_ID, then will get 0xfffffff when configuring
> > > the BAR0 subsequently. With the original polling method, it will get
> > > enough delay in the pci_dev_wait(), so nvme works normally.
> > > 
> > > The line "[   10.193589] hhhhhhhhhhhhhhhhhhhhhhhhhhhh dev->device = 0a54
> > > id = ffffffff" is output from pci_dev_wait(), please refer to
> > > https://launchpadlibrarian.net/798708446/LP2111521-dmesg-test9.txt
> > > 
> > > >    pci 10000:01:00.0: BAR 0 [mem 0xf8010000-0xf8013fff 64bit]: assigned
> > > >    pci 10000:01:00.0: BAR 0: error updating (high 0x00000000 !=
> > > > 0xffffffff)
> > > >    pci 10000:01:00.0: BAR 0 [mem 0xf8010000-0xf8013fff 64bit]: assigned
> > > >    pci 10000:01:00.0: BAR 0: error updating (0xf8010004 != 0xffffffff)
> > > >    nvme nvme0: pci function 10000:01:00.0
> > > >    nvme 10000:01:00.0: enabling device (0000 -> 0002)
> > > > 
> > > > Things I notice:
> > > > 
> > > >    - The 10000:01:00.0 NVMe device is behind a VMD bridge
> > > > 
> > > >    - We successfully read the Vendor & Device IDs (8086:0a54)
> > > > 
> > > >    - The NVMe device is uninitialized.  We successfully sized the BAR,
> > > >      which included successful config reads and writes.  The BAR
> > > >      wasn't assigned by BIOS, which is normal since it's behind VMD.
> > > > 
> > > >    - We allocated space for BAR 0 but the config writes to program the
> > > >      BAR failed.  The read back from the BAR was 0xffffffff; probably a
> > > >      PCIe error, e.g., the NVMe device didn't respond.
> > > > 
> > > >    - The device *did* respond when nvme_probe() enabled it: the
> > > >      "enabling device (0000 -> 0002)" means pci_enable_resources() read
> > > >      PCI_COMMAND and got 0x0000.
> > > > 
> > > >    - The dmesg from the working config doesn't include the "enabling
> > > >      device" line, which suggests that pci_enable_resources() saw
> > > >      PCI_COMMAND_MEMORY (0x0002) already set and didn't bother setting
> > > >      it again.  I don't know why it would already be set.
> > > >      d591f6804e7e really only changes pci_dev_wait(), which is used after
> > > >      device resets.  I think vmd_enable_domain() resets the VMD Root Ports
> > > >      after pci_scan_child_bus(), and maybe we're not waiting long enough
> > > >      afterwards.
> > > > 
> > > > My guess is that we got the ~0 because we did a config read too soon
> > > > after reset and the device didn't respond.  The Root Port would time
> > > > out, log an error, and synthesize ~0 data to complete the CPU read
> > > > (see PCIe r6.0, sec 2.3.2 implementation note).
> > > > 
> > > > It's *possible* that we waited long enough but the NVMe device is
> > > > broken and didn't respond when it should have, but my money is on a
> > > > software defect.
> > > > 
> > > > There are a few pci_dbg() calls about these delays; can you set
> > > > CONFIG_DYNAMIC_DEBUG=y and boot with dyndbg="file drivers/pci/* +p" to
> > > > collect that output?  Please also collect the "sudo lspci -vv" output
> > > > from a working system.
> > > 
> > > Already passed the testing request to bug reporters, wait for their
> > > feedback.
> > > 
> > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/55
> > 
> > This is the dmesg with dyndbg="file drivers/pci/* +p"
> > 
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2111521/comments/56
> 
> Thank you very much!  I'm stumped.
> 
> Both Ports here are capable of 8GT/s, and the Root Port is hot-plug
> capable and supports Data Link Layer Link Active Reporting but not DRS:
> 
>   10000:00:02.0 Intel Sky Lake-E PCI Express Root Port C
>     LnkCap: Port #11, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <16us
>             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
>     LnkSta: Speed 8GT/s, Width x4
>             TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
>     SltCap: AttnBtn- PwrCtrl- MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+
>     LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 2Retimers- DRS-
> 
>   10000:01:00.0 Intel NVMe Datacenter SSD
>     LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s, Exit Latency L0s <64ns
> 
> After a reset, we have to delay before doing config reads.  The wait
> time requirements are in PCIe r6.0, sec 6.6.1:
> 
>   • ... For cases where system software cannot determine that DRS is
>     supported by the attached device, or by the Downstream Port above
>     the attached device [as in this case]:
> 
>     ◦ ...
> 
>     ◦ With a Downstream Port that supports Link speeds greater than
>       5.0 GT/s, software must wait a minimum of 100 ms after Link
>       training completes before sending a Configuration Request to the
>       device immediately below that Port. Software can determine when
>       Link training completes by polling the Data Link Layer Link
>       Active bit or by setting up an associated interrupt (see §
>       Section 6.7.3.3). It is strongly recommended for software to
>       use this mechanism whenever the Downstream Port supports it.
> 
> Since the Port supports 8GT/s, we should wait 100ms after Link training
> completes (PCI_EXP_LNKSTA_DLLLA becomes set), and based on the code
> path below, I think we *do*:
> 
>   pci_bridge_secondary_bus_reset
>     pcibios_reset_secondary_bus
>       pci_reset_secondary_bus
>         # assert PCI_BRIDGE_CTL_BUS_RESET
>     pci_bridge_wait_for_secondary_bus(bridge, "bus reset")
>       pci_dbg("waiting %d ms for downstream link, after activation\n") # 10.86
>       delay = pci_bus_max_d3cold_delay()    # default 100ms
>       pcie_wait_for_link_delay(bridge, active=true, delay=100)
>         pcie_wait_for_link_status(use_lt=false, active=true)
>           end_jiffies = jiffies + PCIE_LINK_RETRAIN_TIMEOUT_MS
>           do {
>             pcie_capability_read_word(PCI_EXP_LNKSTA, &lnksta)
>             if ((lnksta & PCI_EXP_LNKSTA_DLLLA) == PCI_EXP_LNKSTA_DLLLA)
>               return 0
>             msleep(1)                       # likely wait several ms for link active
>           } while (time_before(jiffies, end_jiffies))
>         if (active)                         # (true)
>           msleep(delay)                     # wait 100ms here
>       pci_dev_wait(child, "bus reset", PCIE_RESET_READY_POLL_MS - delay)
>         delay = 1
>         for (;;) {
>           pci_read_config_dword(PCI_VENDOR_ID, &id)
>           if (!pci_bus_rrs_vendor_id(id))   # got 0xffff, assume valid
>             break;
>         }
>         pci_dbg("ready 0ms after bus reset", delay - 1)  # 11.11
> 
> And from the dmesg log:
> 
>   [   10.862226] pci 10000:00:02.0: waiting 100 ms for downstream link, after activation
>   [   11.109581] pci 10000:01:00.0: ready 0ms after bus reset
> 
> it looks like we waited about .25s (250ms) after the link came up
> before trying to read the Vendor ID, which should be plenty.
> 
> I guess maybe this device requires more than 250ms after reset before
> it can respond?  That still seems surprising to me; I *assume* Intel
> would have tested this for spec conformance.  But maybe there's some
> erratum.  I added a couple Intel folks who are mentioned in the nvme
> history in case they have pointers.
> 
> But it *is* also true that pci_dev_wait() doesn't know how to handle
> PCIe errors at all, and maybe there's a way to make it smarter.
> 
> Can you try adding the patch below and collect another dmesg log (with
> dyndbg="file drivers/pci/* +p" as before)?  This isn't a fix, but
> might give a little more insight into what's happening.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..42a36ff5c6cd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1268,6 +1268,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	bool retrain = false;
>  	struct pci_dev *root, *bridge;
>  
> +	pci_dbg(dev, "%s: %s timeout %d\n", __func__, reset_type, timeout);
>  	root = pcie_find_root_port(dev);
>  
>  	if (pci_is_pcie(dev)) {
> @@ -1305,14 +1306,32 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  
>  		if (root && root->config_rrs_sv) {
>  			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> -			if (!pci_bus_rrs_vendor_id(id))
> -				break;
> +			pci_dbg(dev, "%s: vf %d read %#06x\n", __func__,
> +				dev->is_virtfn, id);
> +			if (pci_bus_rrs_vendor_id(id))
> +				goto retry;
> +
> +			/*
> +			 * We might read 0xffff if the device is a VF and
> +			 * the read was successful (the VF Vendor ID is
> +			 * 0xffff per spec).
> +			 *
> +			 * If the device is not a VF, 0xffff likely means
> +			 * there was an error on PCIe.  E.g., maybe the
> +			 * device couldn't even respond with RRS status,
> +			 * and the RC timed out and synthesized ~0 data.
> +			 */
> +			if (PCI_POSSIBLE_ERROR(id) && !dev->is_virtfn)
> +				    goto retry;
> +
> +			break;
>  		} else {
>  			pci_read_config_dword(dev, PCI_COMMAND, &id);
>  			if (!PCI_POSSIBLE_ERROR(id))
>  				break;
>  		}
>  
> +retry:
>  		if (delay > timeout) {
>  			pci_warn(dev, "not ready %dms after %s; giving up\n",
>  				 delay - 1, reset_type);
> @@ -4760,6 +4779,8 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
>  	 * Some controllers might not implement link active reporting. In this
>  	 * case, we wait for 1000 ms + any delay requested by the caller.
>  	 */
> +	pci_dbg(pdev, "%s: active %d delay %d link_active_reporting %d\n",
> +		__func__, active, delay, pdev->link_active_reporting);
>  	if (!pdev->link_active_reporting) {
>  		msleep(PCIE_LINK_RETRAIN_TIMEOUT_MS + delay);
>  		return true;

