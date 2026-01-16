Return-Path: <linux-pci+bounces-45028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6C7D2E643
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C73B930AF9F0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A19311C32;
	Fri, 16 Jan 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAfYt7qP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5620B2E0B71;
	Fri, 16 Jan 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553872; cv=none; b=BMdF8NnmqIANx29dCf2YLbWy48TJzfcghnJ8yxzF9DeF3mgrT7MHTPT3qmgeAFRxSUQT2jCLoC5xH4KW3iLyUO+mp4qaEiLA83oE/1x/36OUvMqnSc5drNERym0/TVMoxjMMBPNaybkSDKujYUURfZ1JPEU/vFDLcMsRg0FAyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553872; c=relaxed/simple;
	bh=7v+plz9W/i0/4Z95v/bM+FBpfa/Zny7st/earl5SCr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJOmIVOaVQ/ukyY4jt6fIIkC6TgHK8P/cJnhakbelU6PLbIEgWnRzQ1InZUxSfIdBuInhId5Sx1jK3IGxpakrDsdT6swThkFHGdCnWE8Zq3DHhltPetR5dv5FaSOs070MI/QxfMLgRMsva5xEdAYCyqkXTCgE2Mcvm86YkvxCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAfYt7qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29FFC19423;
	Fri, 16 Jan 2026 08:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768553872;
	bh=7v+plz9W/i0/4Z95v/bM+FBpfa/Zny7st/earl5SCr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAfYt7qPHFm6pJoFATSaulIIg/r37/y7bfEYEYh/bR2baX4t0JnM6LedXXX79/FHg
	 cCJR/MHFqgavGJHfUBu2GQCttayfF+vh5qtSzE/IBvWst4pSEXxICDSBX+qAim4SZq
	 evTKLZIQddWMP1aEbkyYB8MuZC0kZhHoIouoQcFTS7j6a6jlDCk96GyA7WycvbLVKn
	 NG9uuFDbehQg1UP45iKK+HE7aUwX8qVxarkiS7T/F2u/a0k5X+tvesYZL213LcgxOU
	 qVGbjf7iSN0PY5+yn9Rg9I4u8w18t2oVIhxkxNRgBq+EkK6g34LQ6+w/FJ+Wh72O8y
	 MMzTbw/R768yw==
Date: Fri, 16 Jan 2026 14:27:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
	Shawn Lin <shawn.lin@rock-chips.com>, dlemoal@kernel.org
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <ouygfgehh3evllgcibintuer6euyqrrn3otg3ets3frcd7i5wt@nnyjibcrw6ds>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <aVezfq-8bTKczYkp@ryzen>
 <mrm7yif2tg7trvsof3jiqbevfldkf7ckkfswtabrnkc4dlgmae@qyp4s23utlid>
 <aV5XI_e3npXHsxk7@ryzen>
 <aWErEbvByGrxu5s9@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWErEbvByGrxu5s9@ryzen>

On Fri, Jan 09, 2026 at 05:21:37PM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Wed, Jan 07, 2026 at 01:52:57PM +0100, Niklas Cassel wrote:
> > On Mon, Jan 05, 2026 at 05:11:42PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jan 02, 2026 at 01:01:02PM +0100, Niklas Cassel wrote:
> > > > On Tue, Dec 30, 2025 at 08:37:31PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > >
> > > What could be happening here is that since the endpoint is physically connected
> > > to the bus, the receiver gets detected during Detect.Active state and LTSSM
> > > enters the Polling state. I think the reason why it ended up staying in
> > > Poll.Compliance could be due to (as per the spec):
> > >
> > > a. Not all Lanes from the predetermined set of Lanes from above have
> > > detected an exit from Electrical Idle since entering Polling.Active.
> > >
> > > b. Any Lane that detected a Receiver during Detect received eight consecutive
> > > TS1 Ordered Sets (or their complement) with the Lane and Link numbers set to
> > > PAD, the Compliance Receive bit (bit 4 of Symbol 5) is 1b, and the Loopback bit
> > > (bit 2 of Symbol 5) is 0b that the Compliance Receive bit (bit 4 of Symbol 5) is
> > > set.
> > >
> > > So this is perfectly legal from endpoint perspective.
> > >
> > > > Perhaps a Kconfig or module param? Suggestions?
> > > >
> > >
> > > There is a DIRECT_POLCOMP_TO_DETECT bit (bit 9) in DBI SD_CONTROL2 register.
> > > This bit will ensure that the LTSSM will not stuck in Poll.Compliance and will
> > > return back to Detect state. Could you set it on the EP before starting LTSSM
> > > and see if it helps?
> >
> > I will test and get back to you.
> 
> Looking at the databook, it appears that the SD_CONTROL2 register only exists
> if CX_RAS_DES_ENABLE, and the register is located in RAS_DES capability.
> 
> RK3588 implements the RAS_DES capability, so it can set that bit, but most
> likely there are some platforms that do not.
> 

True.

> 
> Anyway, I tried the following patch:
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index c30a2ed324cd..73d3d4bc1886 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -584,6 +584,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> 	struct device_node *np = dev->of_node;
> 	struct pci_host_bridge *bridge;
> 	int ret;
> +	int ras_cap;
> 
> 	raw_spin_lock_init(&pp->lock);
> 
> @@ -670,6 +671,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> 	if (ret)
> 		goto err_remove_edma;
> 
> +#define SD_CONTROL2_REG			0xa4
> +	ras_cap = dw_pcie_find_rasdes_capability(pci);
> +	if (ras_cap) {
> +		u32 val;
> +		val = dw_pcie_readl_dbi(pci, ras_cap + SD_CONTROL2_REG);
> +		val |= BIT(9);
> +		dw_pcie_writel_dbi(pci, ras_cap + SD_CONTROL2_REG, val);
> +	}
> +
> 	if (!dw_pcie_link_up(pci)) {
> 		ret = dw_pcie_start_link(pci);
> 		if (ret)
> 
> 
> And now, every second or third boot, LTSSM is no longer in POLL_COMPLIANCE,
> instead of every second or third boot, LTSSM is now always in:
> [    2.298107] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_ACTIVE
> 
> 
> I did comment out goto err_stop_link if dw_pcie_wait_for_link(), so I can dump
> LTSSM afterwards, when this happens:
> 
> [    2.297916] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_ACTIVE
> 
> Then I do:
> 
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_ACT (0x01)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_ACT (0x01)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> POLL_ACTIVE (0x02)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> DETECT_QUIET (0x00)
> 
> So it appears that after setting the DIRECT_POLCOMP_TO_DETECT bit,
> instead of LTSSM being stuck in POLL_COMPLIANCE, LTSSM seems to
> jump between DETECT_QUIET / DETECT_ACT / POLL_ACTIVE.
> 

Thanks for testing it out. I was expecting the device to just stay in the DETECT
states, but looks like the cycle just continues, which is also fair.

> 
> And just like before, as soon as I do the configfs writes on the EP board
> to start the link:
> 
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> L0 (0x11)
> # cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
> L0 (0x11)
> 
> LTSSM transitions out of compliance, and rescan finds my device.
> 
> 
> So I don't think that setting the DIRECT_POLCOMP_TO_DETECT bit will
> help us PCIe endpoint developers to continue with the workflow where we
> can simply do a rescan on the host after starting the link training on
> the EP.
>
> Back to finding another alternative. Kconfig? module param? Suggestions?
> 

I don't like the user to control this behavior as it is just how the link
behaves. Maybe we can allow the link to stay in POLL and print out a different
message, and still return -ENODEV? Like,

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c2dfadc53d04..21ce206f359b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -774,6 +774,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
                    ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
                        dev_info(pci->dev, "Device not found\n");
                        return -ENODEV;
+               /*
+                * If the link is in POLL.Compliance state, then the device is
+                * found to be connected to the bus, but it is not active i.e.,
+                * the device firmware might not yet initialized.
+                */
+               } else if (ltssm == DW_PCIE_LTSSM_POLL_COMPLIANCE) {
+                       dev_info(pci->dev, "Device found, but not active\n");
+                       return -ENODEV;
                }
 
                dev_err(pci->dev, "Link failed to come up. LTSSM: %s\n",

- Mani

-- 
மணிவண்ணன் சதாசிவம்

