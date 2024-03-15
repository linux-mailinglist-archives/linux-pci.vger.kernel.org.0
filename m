Return-Path: <linux-pci+bounces-4857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FABF87D337
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 19:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06811B21534
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 18:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABA44CB28;
	Fri, 15 Mar 2024 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CiopxEoN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3DC4CB41
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525858; cv=fail; b=R+kr7EvKo2/HOEpq6c/4JEdVxaSfifPSjiOn9RRrKJuTgbmVWo4g21/qyYvDoBdR3K5ZaVnL+dGSzaCRlwGaZWGIB+aMjHKHv1s+jzxkT3FX35bK0+yuD/urLP4zjSeJqdPRpdGPd13Fzp7nH0A8rPvNVRRmO3UhcqQowfL9AzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525858; c=relaxed/simple;
	bh=eQw4smUvbf9evJ3vsZA/dVzqe1p/qm/J04AYNb6/r/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JqmqqjgLynW/jRdGb+CeN5ZoGnE/+abfvRdmfnBEd26BDCTlA0J7gdIjjs+EQnGn6UxSblnnb9uZa3wri1m5etNVVvqbAlCVRhPx77AXNnwXJj8SEObIEAx5rsDlElEgnF0KztRTwDlIs1glGqXXO+C2nJPZnpb8aMKMRx0Z068=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CiopxEoN; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOXuAqWWYKUPRPymEVIaOkUBs92CzFZkzqdzSZQbC8+WISibBB+AtVtQpnElEdwGJSA4b8UYMoPInUlm4WmzV/PAAs2zaDWNqkOUgUUIQxKa/EK1MF3FX8oRW4xfzkJHZS7v1JCYjycgdcHp938aEtGUOnkuAq4/fwwX7T+dTdLwxeETY0YuVXQc+BgcFmrEs1OwbbFPiKn9GYuYxpQFqXiDYyj/nwm+W9ZYJXDzlDZG2V1f8sUDwL2rI2tNksb1vQh4dUuAS6CANh6PLH+XwCIu1y3fM2GX2wc0rtDw+4F+DHm520Wu47ZdMC5nRPr9JrJj9+5wLOyJ0ncMSzCXNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=camAhJyyY5kIH92x2JNEiaYYfaWwzToj5H+ZS6WV0ME=;
 b=oKErxTHZ+s70irlNCQnS7f4R3lafIVR60JuruUpdhEeS1qSppYJY+erv6Xleqzb+B9n86MX8SNryRRngCLNS+1ELfedACp0T2GVjuetQX3GZDa90p2VyKsvQQ3uECfgnrw1MRb7w6sFvXWgLRepBtvZDqeDSM3RJiiE1GdPewZYmnoB+kXCIoAsuueqG3/enplk/iztQJWvSz+2J6Oq9t1cb03AsWEPfMW+wrVtWOva42BIHYMkyO769zw5UItRHuaKK9r+J/lLFldndrJUi2k0CJuRUuSpSi7jmLGgvsJGHqUnOC4gk751wTtuG3lSyqa9c0nfgYWc4UMgONUtulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=deepwavedigital.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=camAhJyyY5kIH92x2JNEiaYYfaWwzToj5H+ZS6WV0ME=;
 b=CiopxEoNEVJ5LQpaDxPTlXwLFi0v3y2uH46O379ZACEyTw7eFWk/uPKRgs581sCMG/x/3cAm0v6GIA62r8r6oyS+vNqmW+geCihY/IiGG4VOx+o9DHJoiMdAd6tTx1BKOaQ4085aVnR2YSBKoL9jyQoIpCKvaiwtxKGKcRf36wE=
Received: from CY5PR19CA0024.namprd19.prod.outlook.com (2603:10b6:930:15::17)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 18:04:13 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::54) by CY5PR19CA0024.outlook.office365.com
 (2603:10b6:930:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Fri, 15 Mar 2024 18:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 18:04:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 13:04:11 -0500
Received: from [172.19.74.144] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 15 Mar 2024 13:04:10 -0500
Message-ID: <d0cfb686-7f71-35b6-fad3-0552529991d2@amd.com>
Date: Fri, 15 Mar 2024 11:04:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG] PCI: of: of_pci_make_dev_node() creates ranges that fail
 address translation
Content-Language: en-US
To: Daniel Bryant <dan@deepwavedigital.com>, Rob Herring <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>
References: <CAFgx5J181LSmRzrxsW1Mby2nSmAfepsdpzu6+BjHb=6DiiC_Lw@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAFgx5J181LSmRzrxsW1Mby2nSmAfepsdpzu6+BjHb=6DiiC_Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d82f55d-4791-4ad1-52a4-08dc451a5268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ff0YwQjJ2n5egDa5rK5PZfpZy8xWx711cToO5o0qRZ6zdPrVrC+G7U+HBzEA5/7MjwusDX8fdyN68K0yB2Qf4eFiK69ZOhDoh30nWpaIZmGVnf6FlL6SCDDqke9tR85MU25yz7+KdnPXuQ32n1BD6WymXbRqSlf4gR4zhiXoSXIRbRZT+MhZOFoM9w/Doi0YB53/EpbAm65VbpgjlSu35FrCpJW9tQlnLtXsBWpDkMD8v/x/9X39AsnBI0hEBijieNMi08hLFk3F3+qANtwx5UkIjocm2PDyrHuXRfctDqZndu5LTXjNI75q6AFOyOOkA183ZOMLUEJzJFOBpGDXeLRA2BWsJfZNX8FFaluAgT5zcF34CEORs7gtO69DnqazABhHH8KJTCnn0+YGeG/6NJudC1Jv+woiaU35vPT4y53WtI4yK/EHoiylu9mCySKXwI2soUQ2DYIbYGzKTbi6xKc2blaWdzna17cStUsCD/bd7uFRvQQOOglykGT4wWZZNLMCbIRcOD7NzVy93s4a5uC+kf4CPznso4FZ1YVI0X4jxEb6gH/8QBRPmXUCA22JG+X0Y7fLG6wf6NwuMP3+FEwhjPK8+P8T4mmUgNEk0g5VTXHWJstKj9tTSbkk/qiYnn6YRz2Lp/jRK3RYPYif9PPu0Dmx2FGu8mEUpugZH0p1BBRyKd4jpR2+UeLmdSHt1LR+KEMMnc1wY/1GIP7W1Bkh4DfmsuUFB10fGpib5OB9fzBZlE3q3dXr9ey7OutI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 18:04:13.2396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d82f55d-4791-4ad1-52a4-08dc451a5268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856


On 3/13/24 13:48, Daniel Bryant wrote:
> I'm using the of_pci_make_dev_node() framework to dynamically create
> nodes for the host bridge and attached device, then applying an overlay to
> create a simple-bus and children on the endpoint device. The initial problem
> is that none of the children create any memory resources.  This is on
> a DT-based system, aarch64 hardware.
>
> The overall bus hierarchy is this:
>
> PCIe root port controller -> host bridge -> device -> simple-bus ->
> [subdevices].
>
> 1. Root port controller is defined by static DT blob.
> 2. bridge and device of_nodes are created by of_pci_make_dev_node()
> 3. simple-bus and subdevices are added from a single overlay.
>
> The end result is very similar to the test case in
> drivers/of/unittest-data/tests-address.dtsi. I've traced the failure
> for this hardware to of_translate_address() always returning
> OF_BAD_ADDR for any of the "reg" properties of a subdevice.The
> critical difference between the working unit test and the hardware DT
> is that the hardware PCIe root port controller has a ranges property
> that's not just an identity mapping.
>
> arch/arm64/boot/dts/nvidia/tegra234.dtsi contains the following
> definition, note specifically the second ranges entry:
>
>      pcie@14160000 {
>          compatible = "nvidia,tegra234-pcie";
>          device_type = "pci";
>          // ...
>          ranges = <0x43000000 0x21 0x40000000 0x21 0x40000000 0x2
> 0xe8000000>, /* prefetchable memory (11904 MB) */
>                  <0x02000000 0x0  0x40000000 0x24 0x28000000 0x0
> 0x08000000>, /* non-prefetchable memory (128 MB) */
>                  <0x01000000 0x0  0x36100000 0x00 0x36100000 0x0
> 0x00100000>; /* downstream I/O (1 MB) */
>      };
>
> Then when the child bridge is created, a of_node is created with the
> following properties:
>
>      pci@0,0 {
>              compatible = "pci10de,229c\0pciclass,060400\0pciclass,0604";
>
>              #address-cells = <0x03>;
>              #size-cells = <0x02>;
>              bus-range = <0x01 0xff>;
>              device_type = "pci";
>
>              ranges = <0x82000000 0x24 0x28000000 0x82000000 0x24
> 0x28000000 0x00 0x200000>;
>      };
>
> This ranges entry is a simple passthrough, but it's of the addresses
> already translated to the CPU address space, and not the bus address.

The format of 'range' entry is  <child addr> <parent addr> <size>.

the parent address is (0x82000000 0x24 0x28000000) which is a pci 
address (not CPU address).

This address should match one of the range entry of its parent.

0x82000000 indicates 32-bit iomem. But the offset is  64-bit. (0x24 
0x28000000) which looks odd.

I would suggest to look into lspci -v output as well and debug in 
of_bus_pci_map() to see why it does not match any entry.


Thanks,

Lizhi

> This will cause of_translate_address() to fail when it reaches
> pcie@14160000 and doesn't match.
>
> As a caveat, I'm currently seeing this on hardware on a downstream
> vendor kernel. I'm still working to reproduce on mainline 6.8 (via
> qemu, probably?), but I don't yet see anything that would stop this
> from being any different there.
>
> Dan

