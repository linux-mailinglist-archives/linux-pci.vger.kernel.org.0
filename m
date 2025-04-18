Return-Path: <linux-pci+bounces-26248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA83A93E4A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 21:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6555A445D8E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013161F869E;
	Fri, 18 Apr 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbygk7qp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCE5475E;
	Fri, 18 Apr 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004853; cv=none; b=YDIf9WhssgTW5lV60qxi7gzeExrEdz6GChJuoGFYhCyDwWAaVujV1vwouCg+JAsGduLZVW4j7AhBRQhpvD72mr0+J/zoeAxx3pNSitLG/JdWv3Fqsg7vZXkXI6XzOE9X0by+DHBZUsJocTxVuTz0gOerdjJGK1i9pBeji60mC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004853; c=relaxed/simple;
	bh=D9tqP4q6k4FiJNJriVyf0FBNkmHvdMa/ZWvSnLdctjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dqfNvQYPo+0eZZbg0JdpLJFg4Y8ehLv1aemCKM1ttb8QgwDaVezqiCEc6Ou4r5Fhqy4v1jgEVkyNDPSmwIpPFv4KbzGGsG2sNOId0IRyrWor0E2OnLhhKopxV5bRjhWCyETd/GsRgyDl25FYvMrJY73QilDMfZwgjgcsei57azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbygk7qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA01C4CEE2;
	Fri, 18 Apr 2025 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745004853;
	bh=D9tqP4q6k4FiJNJriVyf0FBNkmHvdMa/ZWvSnLdctjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rbygk7qpQ+aaTPAS9KmJOxGTxcbO0r8DgMEvh2mLlPNP2csSjKGHgYw1wKQaOUrrL
	 CklfbKFdJ4LK+KINSpWWoRQqpIfaocPFNjY6WxNvNJAFP6VCN2wtmDse8YZlnL7RTE
	 ZpVMYIwZ1gtvibrMsRmv7FVgjU3sibVOSphN1aCFuCQ+jWfX8eufRH/K+mhkJzLgkZ
	 x2sZJyLN0kJke8uqa071bFaUyMmS9KAZ1tq5QDWxqIiqgxGC1mOXznTPaeKP/8NJ/E
	 vhhlzhIgBLXrh7HnZVAOiKW+549ONMYdUgEZKK3mVf3kD1lPqzPcja6P6RIWzyFFFM
	 oUDrRW795DUnQ==
Date: Fri, 18 Apr 2025 14:34:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	En-Wei Wu <en-wei.wu@canonical.com>, vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net 3/3] igc: return early when failing to read EECD
 register
Message-ID: <20250418193411.GA168278@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107190150.1758577-4-anthony.l.nguyen@intel.com>

[+cc Kalesh, Przemek, linux-pci]

On Tue, Jan 07, 2025 at 11:01:47AM -0800, Tony Nguyen wrote:
> From: En-Wei Wu <en-wei.wu@canonical.com>
> 
> When booting with a dock connected, the igc driver may get stuck for ~40
> seconds if PCIe link is lost during initialization.
> 
> This happens because the driver access device after EECD register reads
> return all F's, indicating failed reads. Consequently, hw->hw_addr is set
> to NULL, which impacts subsequent rd32() reads. This leads to the driver
> hanging in igc_get_hw_semaphore_i225(), as the invalid hw->hw_addr
> prevents retrieving the expected value.
> 
> To address this, a validation check and a corresponding return value
> catch is added for the EECD register read result. If all F's are
> returned, indicating PCIe link loss, the driver will return -ENXIO
> immediately. This avoids the 40-second hang and significantly improves
> boot time when using a dock with an igc NIC.
> 
> Log before the patch:
> [    0.911913] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    0.912386] igc 0000:70:00.0: PTM enabled, 4ns granularity
> [    1.571098] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
> [   43.449095] igc_get_hw_semaphore_i225: igc 0000:70:00.0 (unnamed net_device) (uninitialized): Driver can't access device - SMBI bit is set.
> [   43.449186] igc 0000:70:00.0: probe with driver igc failed with error -13
> [   46.345701] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [   46.345777] igc 0000:70:00.0: PTM enabled, 4ns granularity
> 
> Log after the patch:
> [    1.031000] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    1.032097] igc 0000:70:00.0: PTM enabled, 4ns granularity
> [    1.642291] igc 0000:70:00.0 (unnamed net_device) (uninitialized): PCIe link lost, device now detached
> [    5.480490] igc 0000:70:00.0: enabling device (0000 -> 0002)
> [    5.480516] igc 0000:70:00.0: PTM enabled, 4ns granularity
> 
> Fixes: ab4056126813 ("igc: Add NVM support")
> Cc: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index 9fae8bdec2a7..1613b562d17c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -68,6 +68,10 @@ static s32 igc_init_nvm_params_base(struct igc_hw *hw)
>  	u32 eecd = rd32(IGC_EECD);
>  	u16 size;
>  
> +	/* failed to read reg and got all F's */
> +	if (!(~eecd))
> +		return -ENXIO;

I don't understand this.  It looks like a band-aid that makes boot
faster but doesn't solve the real problem.

In its defense, I guess that with this patch, the first igc probe
fails, and then for some reason we attempt another a few seconds
later, and the second igc probe works fine, so the NIC actually does
end up working correct, right?

I think the PCI core has some issues with configuring ASPM L1.2, and I
wonder if those are relevant here.  If somebody can repro the problem
(i.e., without this patch, which looks like it appeared in v6.13 as
bd2776e39c2a ("igc: return early when failing to read EECD
register")), I wonder if you could try booting with "pcie_port_pm=off
pcie_aspm.policy=performance" and see if that also avoids the problem?

If so, I'd like to see the dmesg log with "pci=earlydump" and the
"sudo lspci -vv" output when booted with and without "pcie_port_pm=off
pcie_aspm.policy=performance".

>  	size = FIELD_GET(IGC_EECD_SIZE_EX_MASK, eecd);
>  
>  	/* Added to a constant, "size" becomes the left-shift value
> @@ -221,6 +225,8 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
>  
>  	/* NVM initialization */
>  	ret_val = igc_init_nvm_params_base(hw);
> +	if (ret_val)
> +		goto out;
>  	switch (hw->mac.type) {
>  	case igc_i225:
>  		ret_val = igc_init_nvm_params_i225(hw);
> -- 
> 2.47.1
> 

