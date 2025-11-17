Return-Path: <linux-pci+bounces-41375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB1C63325
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2CF34EEFFB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06B31A57C;
	Mon, 17 Nov 2025 09:31:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023126.outbound.protection.outlook.com [52.101.127.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039925A357;
	Mon, 17 Nov 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763371890; cv=fail; b=IkyiJmWxcVIEMZqOXdnEgt6nDcjAEHtMVe0CPQn95fa5ZwoplxrDseyVZwzG025XksAne/wLi0cHo+j/pPIsZDXTMB/1Ph8JLncWk5TdkRdJMQxRWDdAAqKRML/UGz/eDvHPucTKfyrkBx87dE4OqrJnjfteV+sjqb7D+OD0eiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763371890; c=relaxed/simple;
	bh=RfYtKaOp1asUPfryHIdFe8p0v6w8Hpnm0Yv9WT79Eic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhdgC7DmP/Bg1y5eK7xlHQfhUJEK9hPs/UYSXXELGHGZ+Cn3yHqgVZ507KE2bPr3yufQJYHSnR6bW4s/C5IQ/BE/bmGZhk9SfftbQgix58tRge56Wzw+6CaT/W9IDYX+SeuNi3vjXTYi0v6ikhtM69eKiI+KuwYB+OSgr5tR6zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9xcDUn19WiLA/hLDJFzuTjOfsLzcC7t0MPQgxSOqrR3J8RuWEnuW272vSpkUADxhMX96EEJgK2dnzXr7IeECorf34JoacUmXKjQVmec5WWWB/lYiYeOX07yDM8avvKOkNI3YCgYNwL8QocKk7X3gre8MmHi3pkKhZxMkwM/GrxF1/Sdp7g46AUy+Rn+pjPRdDgJ+CfQzEAhAuuflZn/EiB1TzAMWS4PiyJ2PM6l6jOoTmQoiVoT9jFHOAiUFTr6D5qvLMNzLzg4n09V6p/stf0MZKo+g3iMPKzP8yt2poVVy4fCAlzUcxZhz2E8taDuj6rvEc2O2XUXxSvij8H+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/VmOk9QiJYa8ujqjRRcbESu2Guk4UlCGQvGbtjL9m0=;
 b=JG/gbKhJfiFYYNFY998IVxYmbB4K9k4UIaryBFPLcOhZ4XcLGYex8dotHFsfgSdfJlY6m/B0Jg21BGy1RKhDvn/rhGC5YplPVHgoDDC3UQr55/cI20EjgQ/kTYZ+l1EjnQF/QggBAoPNhWOtl2M1piVMyx2bN1fwDQXXjXQJgkjPwQL+LF6NytfrPbFkR0p8EmyoJprtL5w35aSKNH6XBuAf1jbOd6prKko6IiKc2SVs7aczi0OEwRNAyOlX/xdLyMjul1CmzGhY+hOeFc3rkszPSwKfFAn/6TYcueZiZbKRLJKbhggol4ZVfRKpffpacJ5Yvysws2aQVhBbCdRKHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:4:186::16)
 by KUZPR06MB8250.apcprd06.prod.outlook.com (2603:1096:d10:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 09:31:22 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:186:cafe::20) by SI2PR06CA0011.outlook.office365.com
 (2603:1096:4:186::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 09:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 09:31:21 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 78BFB41C0143;
	Mon, 17 Nov 2025 17:31:20 +0800 (CST)
Date: Mon, 17 Nov 2025 17:31:14 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: hans.zhang@cixtech.com
Cc: <bhelgaas@google.com>, <helgaas@kernel.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <mani@kernel.org>, <robh@kernel.org>,
	<kwilczynski@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <mpillai@cadence.com>,
	<fugang.duan@cixtech.com>, <guoyin.chen@cixtech.com>,
	<cix-kernel-upstream@cixtech.com>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 09/10] arm64: dts: cix: Add PCIe Root Complex on sky1
Message-ID: <aRrrYm-cYTUmUPHI@nchen-desktop>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
 <20251108140305.1120117-10-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108140305.1120117-10-hans.zhang@cixtech.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|KUZPR06MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: dd526f6b-acec-4d54-4126-08de25bc11bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hK+4qjpvmkMPAgC3SU20Py4t/3WMHT435R5g1znvZGPZCJk1bpGutpiwNkWo?=
 =?us-ascii?Q?8OiPGlQft0el/tVpgDv0cbJks0VlunklSz/f2kacK9DD5FPKdiCtusSSgjOz?=
 =?us-ascii?Q?HtCEjrTHUyMWm/oT3YvIdis3yTJTBxgl0KDyccNfnMfJpHFkqQ/5wvDmvmI3?=
 =?us-ascii?Q?WWfRJa10sCp6jejv6M32pk8p8n6DyRzDcUrR1Ej1e090e2m+kAj4qOdqIRxC?=
 =?us-ascii?Q?dazUhJUv6NyHTaQ4eV5hDDw4/pZSthI55atWIMdsiE7GC5ltCMEeSMXVFlAk?=
 =?us-ascii?Q?hGJt8+bvRy2B9gSyyzjUhh4/zFxN4r1UVAWiQoUA/1Zr+3jF/jN7FZlLdGRN?=
 =?us-ascii?Q?9CEenIIiQcpcuwy6w5Llgl2W++uBuMHO94Q9sRJGPZvBjIMj7B2sVxJPWNUN?=
 =?us-ascii?Q?GjNmPUcFo6BHbPmdOmW6SKFnRBSQzCwGAOl75hE7PEJLqds+ymeS99412IO7?=
 =?us-ascii?Q?1Cajtl1XMy897br3EvLPqQGBDBUhZQTb8K/bM1RC/Nz0egTkTABRMuhuli3c?=
 =?us-ascii?Q?MvPKxPkeKKBwWvK2VWAjea+WgRfnlV0+Fq854P1jWYjrZvhLvMPaMaRyboFO?=
 =?us-ascii?Q?QAOcNbrjdmDXLgn0ENbpI4WkE+P331QiqBF8+lJoZChdXK1eyLOzHqA61XkC?=
 =?us-ascii?Q?sZW64YMeV+vR6t9j5maeMq2rSysC5aFqycZiSyKU7LRxc5v067WjUNFDakac?=
 =?us-ascii?Q?wOXwPfCBU0S+UlObgvjLw5T/3YdObne+/wQWSylmAugFz4t3dL9jjndcNzoa?=
 =?us-ascii?Q?7d5dsSx/oSewXtw1YU/q07eidI+duFCmDXtxteGzFTyMKrUsZYnnXnULjS7U?=
 =?us-ascii?Q?NPzUov5/BtVR1pDZhRcanqmRhHiLpDFM+8+AB3yIwdgFrb3eTAn8CIoNHnph?=
 =?us-ascii?Q?xrDB5wWSGhSoqVW9htYVAyLWdDtfFle/qr4KALxDnfPhhOuujZ9R1qp7cRHc?=
 =?us-ascii?Q?ob9YNlFsRpozIig3EZcfcpSw3tiDKAzljemxpJ62/moa749M/23GfdGEMXO5?=
 =?us-ascii?Q?FwBLVsZ6Jmj0B/tNhaVbgUNTE1kfOrFh4kAoUAnorsVOo5xL9ZsxIy0g32g+?=
 =?us-ascii?Q?182x+jEnNBbK8q3a//0PBtdjbPn4vV2txrifB4p29Cw0j8psdHT5AcYjr8eO?=
 =?us-ascii?Q?nwCXwS17WfD3QvAWJJGJdhrfeRt0jKPebpUVOxCO/uVPIYR9pEzwl5Z8RsoH?=
 =?us-ascii?Q?HlJ60Wc/IkIufvQyJNwhSgq/DrVY+u2S//tOPunm1GB2mPieDpIRLcTLzwR+?=
 =?us-ascii?Q?NTB3G03jKOj1GAHsdYM81MqRHyb3b1n89AI3qYBcaJnlHmMKn7NAg4Wptmjd?=
 =?us-ascii?Q?nnAvGbsLCJnnZYqLNvqkeOnbhQFoif6OwfvXKaecVGUEvIXwFoq0JUmz5u+a?=
 =?us-ascii?Q?SMfaN4LyM1wQ6vr2ATSm7jGnNuMOQiN5+sW0F+at+lOMpkCyWrJkB05dM1Ld?=
 =?us-ascii?Q?OUBFjkE2aMrlDKqPwAMbj7NTLQvmBDP+scuiJRoT+Yp/E07fTfHlHtAZ+Djd?=
 =?us-ascii?Q?A0qint7F60aslyCUWvBlSBhtf+rrgZFlcadwMRrOrjCvLLfkckMNmZoHm/uA?=
 =?us-ascii?Q?OBi4LmiqJvNHb/2ZcLQ=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:31:21.2977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd526f6b-acec-4d54-4126-08de25bc11bc
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8250

On 25-11-08 22:03:04, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>

Applied, Thanks.

Peter
> 
> Add pcie_x*_rc node to support Sky1 PCIe driver based on the
> Cadence PCIe core.
> 
> Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
> using the ARM GICv3.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  arch/arm64/boot/dts/cix/sky1.dtsi | 126 ++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> index 2fb2c99c0796..1abafbfc3c9b 100644
> --- a/arch/arm64/boot/dts/cix/sky1.dtsi
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -388,6 +388,132 @@ mbox_ap2sfh: mailbox@80a0000 {
>  			cix,mbox-dir = "tx";
>  		};
>  
> +		pcie_x8_rc: pcie@a010000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a010000 0x00 0x10000>,
> +			      <0x00 0x2c000000 0x00 0x4000000>,
> +			      <0x00 0x0a000300 0x00 0x100>,
> +			      <0x00 0x0a000400 0x00 0x100>,
> +			      <0x00 0x60000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
> +				 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0xc0 0xff>;
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0xc000 &gic_its 0xc000 0x4000>;
> +			status = "disabled";
> +		};
> +
> +		pcie_x4_rc: pcie@a070000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a070000 0x00 0x10000>,
> +			      <0x00 0x29000000 0x00 0x3000000>,
> +			      <0x00 0x0a060300 0x00 0x40>,
> +			      <0x00 0x0a060400 0x00 0x40>,
> +			      <0x00 0x50000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x00 0x50100000 0x00 0x50100000 0x00 0x00100000>,
> +				 <0x02000000 0x00 0x50200000 0x00 0x50200000 0x00 0x0fe00000>,
> +				 <0x43000000 0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0x90 0xbf>;
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0x9000 &gic_its 0x9000 0x3000>;
> +			status = "disabled";
> +		};
> +
> +		pcie_x2_rc: pcie@a0c0000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a0c0000 0x00 0x10000>,
> +			      <0x00 0x26000000 0x00 0x3000000>,
> +			      <0x00 0x0a0600340 0x00 0x20>,
> +			      <0x00 0x0a0600440 0x00 0x20>,
> +			      <0x00 0x40000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x40100000 0x0 0x40100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x40200000 0x0 0x40200000 0x0 0x0fe00000>,
> +				 <0x43000000 0x10 0x00000000 0x10 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0x60 0x8f>;
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0x6000 &gic_its 0x6000 0x3000>;
> +			status = "disabled";
> +		};
> +
> +		pcie_x1_0_rc: pcie@a0d0000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a0d0000 0x00 0x10000>,
> +			      <0x00 0x20000000 0x00 0x3000000>,
> +			      <0x00 0x0a060360 0x00 0x20>,
> +			      <0x00 0x0a060460 0x00 0x20>,
> +			      <0x00 0x30000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x30200000 0x0 0x30200000 0x0 0x07e00000>,
> +				 <0x43000000 0x08 0x00000000 0x08 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0x00 0x2f>;
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0x0000 &gic_its 0x0000 0x3000>;
> +			status = "disabled";
> +		};
> +
> +		pcie_x1_1_rc: pcie@a0e0000 {
> +			compatible = "cix,sky1-pcie-host";
> +			reg = <0x00 0x0a0e0000 0x00 0x10000>,
> +			      <0x00 0x23000000 0x00 0x3000000>,
> +			      <0x00 0x0a060380 0x00 0x20>,
> +			      <0x00 0x0a060480 0x00 0x20>,
> +			      <0x00 0x38000000 0x00 0x00100000>;
> +			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
> +			ranges = <0x01000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000>,
> +				 <0x02000000 0x0 0x38200000 0x0 0x38200000 0x0 0x07e00000>,
> +				 <0x43000000 0x0C 0x00000000 0x0C 0x00000000 0x04 0x00000000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			bus-range = <0x30 0x5f>;
> +			device_type = "pci";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 2 &gic 0 0 GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 3 &gic 0 0 GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH 0>,
> +					<0 0 0 4 &gic 0 0 GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH 0>;
> +			msi-map = <0x3000 &gic_its 0x3000 0x3000>;
> +			status = "disabled";
> +		};
> +
>  		gic: interrupt-controller@e010000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
> -- 
> 2.49.0
> 

-- 

Best regards,
Peter

