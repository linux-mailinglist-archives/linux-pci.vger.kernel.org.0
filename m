Return-Path: <linux-pci+bounces-44387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186AD0B3A6
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 17:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 714C5304EBFE
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616E22B5A3;
	Fri,  9 Jan 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVttAqGb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5315687D;
	Fri,  9 Jan 2026 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975702; cv=none; b=OjQI4HJlpgpUwky8C9muSRAOg9dL/sebGJKlWiA9zqHohjqsGsfKR0U8qLJ/6g+36la8M6YuOb9F/6Ue2Swi7dSAauhWDcUo4l8IvINhvE7EP0xS8qyRSj2uYYjgRhvxtsupTOvRU2o3cIZWq2nl61a6PS6zZ9l6c2UzUBDB7NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975702; c=relaxed/simple;
	bh=cKKjNIn0XScNnu95MMek1PoJNdHTHT5KMNJYkwMNPmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIi8I9xedNqHAM7ckEwroh5GNuQx1hdOH3w0Tpl+HBtku5ZAgtg6XYPNU6hDeWGUAfdxFt6/WghsoemDWmitg6cyfus3t8BN+ad0bavx1+8Qmumvk27yzymLz8Io66wL6JBxODxETcjJ4ODO1y6DSIf7yTkMQTiuhEiZ63/jZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVttAqGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A205FC4CEF1;
	Fri,  9 Jan 2026 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975702;
	bh=cKKjNIn0XScNnu95MMek1PoJNdHTHT5KMNJYkwMNPmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VVttAqGbGuOyXnfFDoXW0iBZCph/jqcu0mwRaWpIxX03ozdTuAmkfGWbIzeifaXKd
	 F8KeuIt/zGu7k3YgKEaZ4nSJ4SkbNEDoHjgbFexM1kBZ9lKpksjXKB2uaEKYi2JPlX
	 Q3A28sCWvOTaMVBMHnzg0C5wxEZf7M89wlSFltx7bfW73SwiYLHjWl366wd04mJXlu
	 yH6Z2ynBhLyB89qGfhwP7NjfI6kRYC4uxjd9MFxaaFDSuru8ho8cHWe4r7AIZC0HA/
	 Zwm3QC09RhpKYjKjJSkQc+VSlwsFHzp1i7xhdA5ZdBbFK06aUJZGuEPco2nb6/2o/+
	 dJEB5FpSYfpQQ==
Date: Fri, 9 Jan 2026 17:21:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	Shawn Lin <shawn.lin@rock-chips.com>, dlemoal@kernel.org
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <aWErEbvByGrxu5s9@ryzen>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <aVezfq-8bTKczYkp@ryzen>
 <mrm7yif2tg7trvsof3jiqbevfldkf7ckkfswtabrnkc4dlgmae@qyp4s23utlid>
 <aV5XI_e3npXHsxk7@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV5XI_e3npXHsxk7@ryzen>

Hello Mani,

On Wed, Jan 07, 2026 at 01:52:57PM +0100, Niklas Cassel wrote:
> On Mon, Jan 05, 2026 at 05:11:42PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jan 02, 2026 at 01:01:02PM +0100, Niklas Cassel wrote:
> > > On Tue, Dec 30, 2025 at 08:37:31PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> >
> > What could be happening here is that since the endpoint is physically connected
> > to the bus, the receiver gets detected during Detect.Active state and LTSSM
> > enters the Polling state. I think the reason why it ended up staying in
> > Poll.Compliance could be due to (as per the spec):
> >
> > a. Not all Lanes from the predetermined set of Lanes from above have
> > detected an exit from Electrical Idle since entering Polling.Active.
> >
> > b. Any Lane that detected a Receiver during Detect received eight consecutive
> > TS1 Ordered Sets (or their complement) with the Lane and Link numbers set to
> > PAD, the Compliance Receive bit (bit 4 of Symbol 5) is 1b, and the Loopback bit
> > (bit 2 of Symbol 5) is 0b that the Compliance Receive bit (bit 4 of Symbol 5) is
> > set.
> >
> > So this is perfectly legal from endpoint perspective.
> >
> > > Perhaps a Kconfig or module param? Suggestions?
> > >
> >
> > There is a DIRECT_POLCOMP_TO_DETECT bit (bit 9) in DBI SD_CONTROL2 register.
> > This bit will ensure that the LTSSM will not stuck in Poll.Compliance and will
> > return back to Detect state. Could you set it on the EP before starting LTSSM
> > and see if it helps?
>
> I will test and get back to you.

Looking at the databook, it appears that the SD_CONTROL2 register only exists
if CX_RAS_DES_ENABLE, and the register is located in RAS_DES capability.

RK3588 implements the RAS_DES capability, so it can set that bit, but most
likely there are some platforms that do not.


Anyway, I tried the following patch:

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c30a2ed324cd..73d3d4bc1886 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -584,6 +584,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
	struct device_node *np = dev->of_node;
	struct pci_host_bridge *bridge;
	int ret;
+	int ras_cap;

	raw_spin_lock_init(&pp->lock);

@@ -670,6 +671,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
	if (ret)
		goto err_remove_edma;

+#define SD_CONTROL2_REG			0xa4
+	ras_cap = dw_pcie_find_rasdes_capability(pci);
+	if (ras_cap) {
+		u32 val;
+		val = dw_pcie_readl_dbi(pci, ras_cap + SD_CONTROL2_REG);
+		val |= BIT(9);
+		dw_pcie_writel_dbi(pci, ras_cap + SD_CONTROL2_REG, val);
+	}
+
	if (!dw_pcie_link_up(pci)) {
		ret = dw_pcie_start_link(pci);
		if (ret)


And now, every second or third boot, LTSSM is no longer in POLL_COMPLIANCE,
instead of every second or third boot, LTSSM is now always in:
[    2.298107] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_ACTIVE


I did comment out goto err_stop_link if dw_pcie_wait_for_link(), so I can dump
LTSSM afterwards, when this happens:

[    2.297916] rockchip-dw-pcie a40000000.pcie: Link failed to come up. LTSSM: POLL_ACTIVE

Then I do:

# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_ACT (0x01)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_ACT (0x01)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
POLL_ACTIVE (0x02)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
DETECT_QUIET (0x00)

So it appears that after setting the DIRECT_POLCOMP_TO_DETECT bit,
instead of LTSSM being stuck in POLL_COMPLIANCE, LTSSM seems to
jump between DETECT_QUIET / DETECT_ACT / POLL_ACTIVE.


And just like before, as soon as I do the configfs writes on the EP board
to start the link:

# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
L0 (0x11)
# cat /sys/kernel/debug/dwc_pcie_a40000000.pcie/ltssm_status
L0 (0x11)

LTSSM transitions out of compliance, and rescan finds my device.


So I don't think that setting the DIRECT_POLCOMP_TO_DETECT bit will
help us PCIe endpoint developers to continue with the workflow where we
can simply do a rescan on the host after starting the link training on
the EP.

Back to finding another alternative. Kconfig? module param? Suggestions?


Kind regards,
Niklas

