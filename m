Return-Path: <linux-pci+bounces-25722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E53A87099
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 06:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93454174B72
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 04:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A474778E;
	Sun, 13 Apr 2025 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lv79tfol"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E420EB;
	Sun, 13 Apr 2025 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744518542; cv=fail; b=iqxSchYG6AoesQ7y1Gu1ZrfDEml7oYAiWYrkuX/O2M1ANq51/7PGp7LtXzcoCkbH9ELg0eCUrmLUD7fdQ/eT30qzkBKkUstoCGmlVdwsyiAOfJDaf7fBt0w6GwrnI7oTMBGYbdfpLdxuBZ7+44tSHcBh+V4itKcgLtdLNku1qTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744518542; c=relaxed/simple;
	bh=6p+csMx17uQM/KjmSKKVauDn06l6lqiz+Y89/csoFlk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLEs+3crPMGQ07Nxl6292SbGDxZph8TMpVVGC+UqzSJw+UCIdFG4o4hYK4R0g+HthWRhUa++QppzN4n8sovzs8j4lMEicfL3v60IIxWSw+y7gKPS9ZeOZdu7rEQKcEdUt+rZiZi8IhanZnQVhM418jG7y/CyWN2jBCx8DGFwiNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lv79tfol; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyRhV1DtR9VUfCecPi0lV/Uco3NqOtYRB7dt8NYz7FPlCwzE9Kng3OyGv1aV3PaSTl6lD1KZc2g/ab19TpYpu4g8xoJEzFZ7RRNmmMQun3i7H0TIffOz3mvfJmiAfTzesMfBNofelRVyX510onBQq46QDRDGDawZ/1XG2MUYS6JLTOrifFOqdCVhUt2kEz10VdZV0XtnqccJr9Mr1kUtOeloM+kusuf4VQ+xspm89DbhRUI1qO+9t7M7dO6FqGl+W9ynNexDlxvoQv+bOQStXawpCLH/mmZGVC0IxZnx0sxoWKO6IZ6CO/liBoGhQzt6ucicaUIl3GcRRT0pwgg/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p+csMx17uQM/KjmSKKVauDn06l6lqiz+Y89/csoFlk=;
 b=zP4JO2uKQLs8C3NOr9q5Z+UzjUvDyim0fEMMDDomzgxnjWDpJoNT+beqfM5Zefq+xJyxW7cr3kqxuWYPFAdjRSTVuDtDQCFPBLke/BivAVuuh2CDv9cVdgRG+kqMsWiaWxz6rXi8CDanLkRp6pbU2RUR7hfgCvuT8yTU6q5EM48tBCGf4VszM3uW5YERVbfVPB/Pi0KMCaNtpgKX4s5+/1vPNryaWWIluXd9mK/tWotW2FXrC5Jdl7HDvQXd4NXaARylBYx5O8ThF+IwtgxBNy+BrLaI84aC8B7ccDKVW8kHcNPewlDYp5kJZCMJFBQTLoQcPHY+zAsRnA0EwLLBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p+csMx17uQM/KjmSKKVauDn06l6lqiz+Y89/csoFlk=;
 b=lv79tfolZaOBmjnkHs/uQdvM2Hu839m+Td4AfDhxiSDvj7uyjbnOUG8vUCwWcxREBGkVnDz1oWENdfzVvrubSku+07HQ8Jse/KssOOh3fIFaWw9U+mXm0tnpkb1G8FbdOj8y0+hNyJ4p66oPDQ6ZxEC41O7inyAkcpCtUkG1QD0=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Sun, 13 Apr 2025 04:28:55 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%7]) with mapi id 15.20.8632.025; Sun, 13 Apr 2025
 04:28:55 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cassel@kernel.org"
	<cassel@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Thread-Topic: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Thread-Index: AQHbnfbpjrXLjxd/8EKiaV/Ed5MZLrOHPpIAgAvQa+CAB+3HAIAGHwqQ
Date: Sun, 13 Apr 2025 04:28:55 +0000
Message-ID:
 <DM4PR12MB6158FAECAA9D3FEFFFCCC95ECDB02@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-3-sai.krishna.musham@amd.com>
 <cjrb3idrj3x7vo4fujl6nakj3foyu64gtxwovmxd4qvovvhwqq@26bpt5b4zjao>
 <DM4PR12MB6158EFFB5F245FAA5CB022A8CDA92@DM4PR12MB6158.namprd12.prod.outlook.com>
 <kjfnox7hefk7ribdhkzj4kbkwyeg7lf62oep7duw6vfarmx5hl@eg5nzkbusm4n>
In-Reply-To: <kjfnox7hefk7ribdhkzj4kbkwyeg7lf62oep7duw6vfarmx5hl@eg5nzkbusm4n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4efb8c73-4166-4f6d-9a01-d608556ba3f0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-13T04:23:55Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|MW4PR12MB6730:EE_
x-ms-office365-filtering-correlation-id: db414a05-d7e6-406f-0fb6-08dd7a43b3d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zzdpd0F2QW8rSkNYeXpCbUYxbFV4ajVHR3pYNVdnN3ZXenNVaTE5cE9GNHEv?=
 =?utf-8?B?Tk8wNmxrZE50V1RneGpZTjdvdWowUURjSXRZSm54bW1jS0VoQ2JEQndlR2Yy?=
 =?utf-8?B?WTRCS2p1MGJtcmxGWGZFcDhtMG5pMk1oQTc4VkxmRHE4cVp1T1pBM09uekRt?=
 =?utf-8?B?SVJLNzdSdDc3cHdlMEUyVVlWQkh0UjVkMFpjRGhnWU54SzNIMDhveDdIVEdR?=
 =?utf-8?B?TGw5bzZzeGdXK0dMTTdPQjNzM0RkRm1idFV4bWZBSHlnVUhJanZsa3ZkbHpJ?=
 =?utf-8?B?UUJOTE5mNGxEdFpqdEpUdHBYZWpiTjY4K09GREVkVE4wT0M5eHRFVW41TXM1?=
 =?utf-8?B?V3VRZU5Ba24xK2t2dWppSjBveitXQ2Y3endvdTBlejJzSythdGc5YXc3cGpo?=
 =?utf-8?B?RkpJalVNME05WWJMTjdDaEVEUStHa01FdnhXVTVUNGJDeE0wNW1lY25ubXlX?=
 =?utf-8?B?WWhnVFFCdE4zWWVNT1RnSGoxMktOZUkvUjYydWUyM3lHdE53Z2h5MWdOMkx0?=
 =?utf-8?B?UFY5b3pXejEyWGRiSDB3ZitUQW5MZEVTdloxL2NtN2lpQWs2M29jRUZPM1hK?=
 =?utf-8?B?SzArSUljQkpkbGphcmpwUklXQjRTZDNpNWprZ1phSXVaQmNmckkvYmpSOXhV?=
 =?utf-8?B?SmxpSHhEdmFJOWcvR3kvc1dSdzloWkhUS2FSQ01ldi9JK1JLSllDWFlhdExk?=
 =?utf-8?B?WTVQeVJsTmwvRkZoRDg1KytTTG1yRFF5bThSTmVoaDhIZ2J3eTI2UTBXVGVO?=
 =?utf-8?B?dDNFMGR5TWpwS3VnVDlJamZiaHJrQlU0VFBqT0JVTkhsL0IvMVQ4TlpuV0wr?=
 =?utf-8?B?MnpUckR4bWNlN3RYUlJFZnhOVmlORjV3RFd1M2ZSVHR2SEM2cGhCdGlDUkZG?=
 =?utf-8?B?cEFxZXF0QTRsMWxTWjZrOCswUHZRMllPUkNIalpyWnJXTVB5SGdvWGxLUmIz?=
 =?utf-8?B?TTdNNFFiL00zYlloTHJOZkNOKzFXckl6UHlXZzNyampkT1V3ZzAremtXVEw5?=
 =?utf-8?B?SFgvUlo1T1lZQzQxa0VJVTdwczl5cnhrR3JCVFh3QU50M1gwdTZCRFZ6dkto?=
 =?utf-8?B?c1FNdlgyblE1VUhQaXcwaFdtRThoSXN3OWhmNzkxS3JSRmVEOGRob1RzTXQ2?=
 =?utf-8?B?Q3hoVXFFNVhkQ3AvRjdLbWFXNGdya1VkUlh6MjNZSWdsckhuVzdrU0YwUS9C?=
 =?utf-8?B?Y1RacC8vOWZCRUt5QytjS0pTZnFSV2ZuMTJ6MlE0VEVkNU0yMnF5M2JOekFk?=
 =?utf-8?B?YjVnZ1hpY2xwdDJyRTROQ0IrMzFpZm9WMEFGOUFVK05WWmRBcEtOS0ZhSEFh?=
 =?utf-8?B?K3YybzF4TjVMS01rTVR5QkNmMXFLaGl6M3MwU3lhUW1RN2FCMzVNWmFMWFEy?=
 =?utf-8?B?Q1VpL1hDdW5kSWRZU1orNTJCUUJwTFNDWlF0L3g5TzMrQjJjUHpUL3ZyY09W?=
 =?utf-8?B?azY3Szc5L3A3YmlKTERQN2NGWFdQMW84d3NZSTk0dThSc0lwYkdnbjdON1dD?=
 =?utf-8?B?b1MvN2s1cU8rMHhSc3QyS2Ixcmh1aFlTZXQ1MkdUMSsvMXlXNm15Tjlvd0h5?=
 =?utf-8?B?WFI2MHhXU0NDdWRaM1JmbzJsVk5PNFZTQmg0bnpnSnJjb213cUpRM1N6b2xh?=
 =?utf-8?B?aUVjeHlOc0pwbGFJN2pDMDJpMEpFbVBUeUhOWTlESzIvRXBCdW5WOGdoNWdt?=
 =?utf-8?B?TGRyN1c0Rlk1OFFReUxKdmxXL2svajNUcjg3STNycVQ1Z0NyOEFKNUIyVi9q?=
 =?utf-8?B?L2pNRnFmajhTSURKUlVDS213MWwzemFCc3FXT0RtUkkzN1FRRlNNc3M0SVhi?=
 =?utf-8?B?QktCem5Ia1J5RDR5RzlRSHNmZ3E0bjZsazZYWVFJYzVkdUp0VHg2eGNqZWZX?=
 =?utf-8?B?MGVVandZSXhwZUVhQVh4aUg4VUpDYzNIbFlZV3FpZmVHYUNPZFE1SzhUS0Qr?=
 =?utf-8?B?SU5qNUxwM0M0R3RXdkhBcEtLdzQzbUJlNjBrR2lmZEZsUE9URkhLL253cEE2?=
 =?utf-8?Q?v6MIKDsxL08VmJsimnELgt+ZP26dLg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFlrUkNDWVNQakc5dTVFR0RBUzVDbzVTUnBVWTBwWENSMGVOSm5VS0ZGR0V6?=
 =?utf-8?B?MGNOMDkxaHNhbGVQRXVGQnc4WWg2TEZNTDVDUkZVWE50RFVXa25zYzIxN3M3?=
 =?utf-8?B?Wmx4VnR1bW92dnpYVHQxZzYrY2JlNDQxeUQ5YmVQVmYwWVYyOENLV0l0ZTJC?=
 =?utf-8?B?QURMdWJYbE9EdjVXNFlWbFNldjNmTFlQUnlmYnlYRkhHbG9uc0p6ZlpacVZQ?=
 =?utf-8?B?dlA5cVJzQXZFaHVBajRRSXFDem1YUUlwNWpUUGh6SGFXSHBOWU5MNHRLN3ht?=
 =?utf-8?B?UDZtQ2psRWpwVWVWQm40Nkt5S0x1eHNVSVNwTnF4WDlGNk9wTmJzQlVjZFJZ?=
 =?utf-8?B?Q1Rydk1KV2YrMjVXTitnd2FpV2ZsWVBFbmxLYXM2YmdiTy9IMDh4NDkzZEdi?=
 =?utf-8?B?UHNkTTZTRVZvbWxETk5FNXBSa3I3a2NnaU1qUDdtQy81aHdGUktwT2phUFdt?=
 =?utf-8?B?QVE3UmlManZremxra05rVXlvWTBSdW54UkFGU3JHazdCYjJpYXFkekdzQWdD?=
 =?utf-8?B?eUNrMiswMDdhUmVGZ21BdWlBdGdUcUFRUmRMQ3AwSmxmL2VHblZLR1B1OGVU?=
 =?utf-8?B?c3VUZGk2TjkzcmpFNjVpaHNDWTN1N3lxbE9jWGlnQ0J2dXp2T2xJbGF5SlJx?=
 =?utf-8?B?Y0FVSmZTZDY2U1VSSytkUFk2OWlobXdpQUhRUjVSdVY2a0xib1RkWXBsd3RM?=
 =?utf-8?B?MkVCWTdVRHh5WVRhM2ZyOXZwSmV4M082RkkzeDBiTERBeTBucnhoenp5Snow?=
 =?utf-8?B?dkpoYUdxU0dwSWx3V3k2MUVtMndwcVg2L2tjMnR5TTE4VGdaTW14cFAvS09a?=
 =?utf-8?B?bGZkM3JFd2pmaCt1SWdaTklZc2VwMTVkZWtVdTZkcXRVSXZlbTMrUnpxUzlJ?=
 =?utf-8?B?Vjd6TElnRGdTaUwrOWhKNmJWNThCVlpETWRkcjZmSytYYXNqWWpWZTZkcnFP?=
 =?utf-8?B?TWJqMEsweEhxcU9oQldSR0Q4R0RsTGxhWVhHZk9zTG44RXNCQVl5d3RacmJD?=
 =?utf-8?B?eVdMalFBUGFqQ2lQMjdtclRMMkNpUXRGU0NPSTdEK016cnp1OHNuTFVuQzNl?=
 =?utf-8?B?Z2lueU54S0ErVWMyNXplZXk5UlgvUWM3S3hEWWZqbVExeVh4RWZsZ3N5Q0NC?=
 =?utf-8?B?aFhPN3hub2xkYjRFRlF2SThvUWF6TXFMZnI4TEZQclVYeFRFQ1dVL25lYzk1?=
 =?utf-8?B?YU1iallSWWMxNWtoYTlPUUFIbm1GRE5kUEYzeVRzVW5LT2pnZW9lRW9BUmlN?=
 =?utf-8?B?TGpvOVF0c0pxSURQb0p3Nmh1elpmSlFSL0hISUF2Wm1rSStjTDM4ZTRqRlNX?=
 =?utf-8?B?U1hjK09Ld09qV2x2Yy9PZ08xU0RQeHgwV0Fsc3RWbkxERFFmZGRRVi8xMks0?=
 =?utf-8?B?aVRWczJPcHpOVHlRaVFlcXpzekVvNVNXVmtpRkg5ajBNY0JmL0Vtc0oybVIx?=
 =?utf-8?B?TXlZUmJWeERMVWN5RVo3VkNPL0o4TFBLem5RcXBQaHQxYkNjU2J2dlBhSTdP?=
 =?utf-8?B?NTA3MjZmWXVqeU15dWgvTjRzOUpuYy9KNzVmbVAxWHdVNDQ1eFZKUUt2TFF3?=
 =?utf-8?B?Y0pOZisvL1N0YVFwRTFkaklCYXdtbGtGZmZTV1BtMnV6R0N5VDFJMzRMak0r?=
 =?utf-8?B?YVgzeE1Vd1JhZnBqTkpkUDd5K1BVZWRvWi9VTnpsYUFNUEk2VExwSTZZVTVn?=
 =?utf-8?B?TTEyb09NdTZtSFYzd3B0OTBNVFUvNWhzejdrbWlia0tad1VuMjVobVlrUnhx?=
 =?utf-8?B?QmlDNW5SQ1BQVTJRMjRYc1NDbHNhM2toV0tVUVJUdmRrOEVLaVNsMmNpbXBH?=
 =?utf-8?B?UlNYY0ZmRVNhdXhqbVpsNk40MmE4OHp1SUEvSXlJM3diN3ZUQ3pHczhBZ1pV?=
 =?utf-8?B?a09LcjJVZlFGS2ZjdlB2STRHL2FlVmFhejgvMlVoaW90K2hKMW9iTDRhM2Vu?=
 =?utf-8?B?dWZOc1pqRjc3WU9GL3k4d0VQdHZDTyt4b3RUQkNpc3NHOW5ISGg5ZXJBQ2Rp?=
 =?utf-8?B?WEptVkRudmJYdHFpdDZYVThrank4T1ZyZnhORVZTeWVHQjBYOUNFK24weWto?=
 =?utf-8?B?clpuNDRKZ2FSV092V1FTMGJmSVFjZ2J2TTJEQ0hINUs3NkRvY1hRY29WSDY0?=
 =?utf-8?Q?c548=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db414a05-d7e6-406f-0fb6-08dd7a43b3d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2025 04:28:55.4194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STw1guQ+RR72I4knI6g7EK1J6SKYaARDaf3HF7SnpMbrwKZXp9YpMOj9XiRbCFgzb7yqHU0VZ/DLH4ByFDl/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFuaXZhbm5hbiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZh
bm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgOSwg
MjAyNSAxMjoyNSBQTQ0KPiBUbzogTXVzaGFtLCBTYWkgS3Jpc2huYSA8c2FpLmtyaXNobmEubXVz
aGFtQGFtZC5jb20+DQo+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5l
bC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3JnOw0KPiBrcnprK2R0QGtlcm5lbC5v
cmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGNhc3NlbEBrZXJuZWwub3JnOyBsaW51eC0NCj4gcGNp
QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29t
PjsgR29nYWRhLCBCaGFyYXQgS3VtYXINCj4gPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47
IEhhdmFsaWdlLCBUaGlwcGVzd2FteQ0KPiA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAyLzJdIFBDSTogeGlsaW54LWNwbTogQWRkIHN1cHBv
cnQgZm9yIFBDSWUgUlAgUEVSU1QjDQo+IHNpZ25hbA0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3Nh
Z2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9u
DQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRp
bmcuDQo+DQo+DQo+IE9uIEZyaSwgQXByIDA0LCAyMDI1IGF0IDA2OjU5OjIzQU0gKzAwMDAsIE11
c2hhbSwgU2FpIEtyaXNobmEgd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFN
RCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+IEhpIE1hbml2YW5uYW4sDQo+
ID4NCj4gPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5u
YW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIE1hcmNoIDI3
LCAyMDI1IDEwOjU2IFBNDQo+ID4gPiBUbzogTXVzaGFtLCBTYWkgS3Jpc2huYSA8c2FpLmtyaXNo
bmEubXVzaGFtQGFtZC5jb20+DQo+ID4gPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJh
bGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207DQo+ID4gPiByb2JoQGtlcm5lbC5vcmc7DQo+
ID4gPiBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGNhc3NlbEBrZXJu
ZWwub3JnOyBsaW51eC0NCj4gPiA+IHBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2ltZWss
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+Ow0KPiA+ID4gR29nYWRhLCBCaGFyYXQgS3Vt
YXIgPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IEhhdmFsaWdlLA0KPiA+ID4gVGhpcHBl
c3dhbXkgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2IDIvMl0gUENJOiB4aWxpbngtY3BtOiBBZGQgc3VwcG9ydCBmb3IgUENJZSBSUA0K
PiA+ID4gUEVSU1QjIHNpZ25hbA0KPiA+ID4NCj4gPiA+IENhdXRpb246IFRoaXMgbWVzc2FnZSBv
cmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+ID4gPiBjYXV0
aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRp
bmcuDQo+ID4gPg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgTWFyIDI2LCAyMDI1IGF0IDA3OjU4OjEx
QU0gKzA1MzAsIFNhaSBLcmlzaG5hIE11c2hhbSB3cm90ZToNCj4gPiA+ID4gQWRkIFBDSWUgSVAg
cmVzZXQgYWxvbmcgd2l0aCBHUElPLWJhc2VkIGNvbnRyb2wgZm9yIHRoZSBQQ0llIFJvb3QNCj4g
PiA+ID4gUG9ydCBQRVJTVCMgc2lnbmFsLiBTeW5jaHJvbml6aW5nIHRoZSBQQ0llIElQIHJlc2V0
IHdpdGggdGhlDQo+ID4gPiA+IFBFUlNUIyBzaWduYWwncyBhc3NlcnRpb24gYW5kIGRlYXNzZXJ0
aW9uIGF2b2lkcyBMaW5rIFRyYWluaW5nIGZhaWx1cmVzLg0KPiA+ID4gPg0KPiA+ID4gPiBBZGFw
dCB0byB1c2UgR1BJTyBmcmFtZXdvcmsgYW5kIG1ha2UgcmVzZXQgb3B0aW9uYWwgdG8gbWFpbnRh
aW4NCj4gPiA+ID4gYmFja3dhcmQgY29tcGF0aWJpbGl0eSB3aXRoIGV4aXN0aW5nIERUQnMuDQo+
ID4gPiA+DQo+ID4gPiA+IEFkZCBjbGVhciBmaXJld2FsbCBhZnRlciBMaW5rIHJlc2V0IGZvciBD
UE01TkMuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNhaSBLcmlzaG5hIE11c2hh
bSA8c2FpLmtyaXNobmEubXVzaGFtQGFtZC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBDaGFu
Z2VzIGZvciB2NjoNCj4gPiA+ID4gLSBDb3JyZWN0IHZlcnNpb24gY2hlY2sgY29uZGl0aW9uIG9m
IENQTTVOQ19IT1NULg0KPiA+ID4gPg0KPiA+ID4gPiBDaGFuZ2VzIGZvciB2NToNCj4gPiA+ID4g
LSBIYW5kbGUgcHJvYmUgZGVmZXIgZm9yIHJlc2V0X2dwaW8uDQo+ID4gPiA+IC0gUmVzb2x2ZSBB
QkkgYnJlYWsuDQo+ID4gPiA+DQo+ID4gPiA+IENoYW5nZXMgZm9yIHY0Og0KPiA+ID4gPiAtIEFk
ZCBQQ0llIFBFUlNUIyBzdXBwb3J0IGZvciBDUE01TkMuDQo+ID4gPiA+IC0gQWRkIFBDSWUgSVAg
cmVzZXQgYWxvbmcgd2l0aCBQRVJTVCMgdG8gYXZvaWQgTGluayBUcmFpbmluZyBFcnJvcnMuDQo+
ID4gPiA+IC0gUmVtb3ZlIFBDSUVfVF9QVlBFUkxfTVMgZGVmaW5lIGFuZCBQQ0lFX1RfUlJTX1JF
QURZX01TIGFmdGVyDQo+ID4gPiA+ICAgUEVSU1QjIGRlYXNzZXJ0Lg0KPiA+ID4gPiAtIE1vdmUg
UENJZSBQRVJTVCMgYXNzZXJ0IGFuZCBkZWFzc2VydCBsb2dpYyB0bw0KPiA+ID4gPiAgIHhpbGlu
eF9jcG1fcGNpZV9pbml0X3BvcnQoKSBiZWZvcmUgY3BtX3BjaWVfbGlua191cCgpLCBzaW5jZQ0K
PiA+ID4gPiAgIEludGVycnVwdHMgZW5hYmxlIGFuZCBQQ0llIFJQIGJyaWRnZSBlbmFibGUgc2hv
dWxkIGJlIGRvbmUgYWZ0ZXINCj4gPiA+ID4gICBMaW5rIHVwLg0KPiA+ID4gPiAtIFVwZGF0ZSBj
b21taXQgbWVzc2FnZS4NCj4gPiA+ID4NCj4gPiA+ID4gQ2hhbmdlcyBmb3IgdjM6DQo+ID4gPiA+
IC0gVXNlIFBDSUVfVF9QVlBFUkxfTVMgZGVmaW5lLg0KPiA+ID4gPg0KPiA+ID4gPiBDaGFuZ2Vz
IGZvciB2MjoNCj4gPiA+ID4gLSBNYWtlIHRoZSByZXF1ZXN0IEdQSU8gb3B0aW9uYWwuDQo+ID4g
PiA+IC0gQ29ycmVjdCB0aGUgcmVzZXQgc2VxdWVuY2UgYXMgcGVyIFBFUlNUIw0KPiA+ID4gPiAt
IFVwZGF0ZSBjb21taXQgbWVzc2FnZQ0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS14aWxpbngtY3BtLmMgfCA4Ng0KPiA+ID4gPiArKysrKysrKysrKysr
KysrKysrKysrLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLXhpbGlueC1jcG0uYw0KPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS14aWxpbngtDQo+ID4gPiBjcG0uYw0KPiA+ID4gPiBpbmRleCBkMGFiMTg3ZDkx
N2YuLmIxMGMwNzUyYTk0ZiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLXhpbGlueC1jcG0uYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUteGlsaW54LWNwbS5jDQo+ID4gPiA+IEBAIC02LDYgKzYsOCBAQA0KPiA+ID4gPiAg
ICovDQo+ID4gPiA+DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4gPiA+
ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2dw
aW8vY29uc3VtZXIuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4g
PiA+ID4gICNpbmNsdWRlIDxsaW51eC9pcnEuaD4NCj4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9p
cnFjaGlwLmg+DQo+ID4gPiA+IEBAIC0yMSw2ICsyMywxMyBAQA0KPiA+ID4gPiAgI2luY2x1ZGUg
InBjaWUteGlsaW54LWNvbW1vbi5oIg0KPiA+ID4gPg0KPiA+ID4gPiAgLyogUmVnaXN0ZXIgZGVm
aW5pdGlvbnMgKi8NCj4gPiA+ID4gKyNkZWZpbmUgWElMSU5YX0NQTV9QQ0lFMF9SU1QgICAgICAg
ICAweDAwMDAwMzA4DQo+ID4gPiA+ICsjZGVmaW5lIFhJTElOWF9DUE01X1BDSUUwX1JTVCAgICAg
ICAgICAgICAgICAweDAwMDAwMzE4DQo+ID4gPiA+ICsjZGVmaW5lIFhJTElOWF9DUE01X1BDSUUx
X1JTVCAgICAgICAgICAgICAgICAweDAwMDAwMzFDDQo+ID4gPiA+ICsjZGVmaW5lIFhJTElOWF9D
UE01TkNfUENJRTBfUlNUICAgICAgICAgICAgICAweDAwMDAwMzI0DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyNkZWZpbmUgWElMSU5YX0NQTTVOQ19QQ0lFMF9GUldBTEwgICAweDAwMDAxMTQwDQo+ID4g
PiA+ICsNCj4gPiA+ID4gICNkZWZpbmUgWElMSU5YX0NQTV9QQ0lFX1JFR19JRFIgICAgICAgICAg
ICAgIDB4MDAwMDBFMTANCj4gPiA+ID4gICNkZWZpbmUgWElMSU5YX0NQTV9QQ0lFX1JFR19JTVIg
ICAgICAgICAgICAgIDB4MDAwMDBFMTQNCj4gPiA+ID4gICNkZWZpbmUgWElMSU5YX0NQTV9QQ0lF
X1JFR19QU0NSICAgICAweDAwMDAwRTFDDQo+ID4gPiA+IEBAIC05OSw2ICsxMDgsNyBAQCBzdHJ1
Y3QgeGlsaW54X2NwbV92YXJpYW50IHsNCj4gPiA+ID4gICAgICAgdTMyIGlyX3N0YXR1czsNCj4g
PiA+ID4gICAgICAgdTMyIGlyX2VuYWJsZTsNCj4gPiA+ID4gICAgICAgdTMyIGlyX21pc2NfdmFs
dWU7DQo+ID4gPiA+ICsgICAgIHUzMiBjcG1fcGNpZV9yc3Q7DQo+ID4gPiA+ICB9Ow0KPiA+ID4g
Pg0KPiA+ID4gPiAgLyoqDQo+ID4gPiA+IEBAIC0xMDYsNiArMTE2LDggQEAgc3RydWN0IHhpbGlu
eF9jcG1fdmFyaWFudCB7DQo+ID4gPiA+ICAgKiBAZGV2OiBEZXZpY2UgcG9pbnRlcg0KPiA+ID4g
PiAgICogQHJlZ19iYXNlOiBCcmlkZ2UgUmVnaXN0ZXIgQmFzZQ0KPiA+ID4gPiAgICogQGNwbV9i
YXNlOiBDUE0gU3lzdGVtIExldmVsIENvbnRyb2wgYW5kIFN0YXR1cyBSZWdpc3RlcihTTENSKQ0K
PiA+ID4gPiBCYXNlDQo+ID4gPiA+ICsgKiBAY3J4X2Jhc2U6IENQTSBDbG9jayBhbmQgUmVzZXQg
Q29udHJvbCBSZWdpc3RlcnMgQmFzZQ0KPiA+ID4gPiArICogQGNwbTVuY19hdHRyX2Jhc2U6IENQ
TTVOQyBDb250cm9sIGFuZCBTdGF0dXMgUmVnaXN0ZXJzIEJhc2UNCj4gPiA+ID4gICAqIEBpbnR4
X2RvbWFpbjogTGVnYWN5IElSUSBkb21haW4gcG9pbnRlcg0KPiA+ID4gPiAgICogQGNwbV9kb21h
aW46IENQTSBJUlEgZG9tYWluIHBvaW50ZXINCj4gPiA+ID4gICAqIEBjZmc6IEhvbGRzIG1hcHBp
bmdzIG9mIGNvbmZpZyBzcGFjZSB3aW5kb3cgQEAgLTExOCw2ICsxMzAsOA0KPiA+ID4gPiBAQCBz
dHJ1Y3QgeGlsaW54X2NwbV9wY2llIHsNCj4gPiA+ID4gICAgICAgc3RydWN0IGRldmljZSAgICAg
ICAgICAgICAgICAgICAqZGV2Ow0KPiA+ID4gPiAgICAgICB2b2lkIF9faW9tZW0gICAgICAgICAg
ICAgICAgICAgICpyZWdfYmFzZTsNCj4gPiA+ID4gICAgICAgdm9pZCBfX2lvbWVtICAgICAgICAg
ICAgICAgICAgICAqY3BtX2Jhc2U7DQo+ID4gPiA+ICsgICAgIHZvaWQgX19pb21lbSAgICAgICAg
ICAgICAgICAgICAgKmNyeF9iYXNlOw0KPiA+ID4gPiArICAgICB2b2lkIF9faW9tZW0gICAgICAg
ICAgICAgICAgICAgICpjcG01bmNfYXR0cl9iYXNlOw0KPiA+ID4gPiAgICAgICBzdHJ1Y3QgaXJx
X2RvbWFpbiAgICAgICAgICAgICAgICppbnR4X2RvbWFpbjsNCj4gPiA+ID4gICAgICAgc3RydWN0
IGlycV9kb21haW4gICAgICAgICAgICAgICAqY3BtX2RvbWFpbjsNCj4gPiA+ID4gICAgICAgc3Ry
dWN0IHBjaV9jb25maWdfd2luZG93ICAgICAgICAqY2ZnOw0KPiA+ID4gPiBAQCAtNDc1LDEyICs0
ODksNDUgQEAgc3RhdGljIGludCB4aWxpbnhfY3BtX3NldHVwX2lycShzdHJ1Y3QNCj4gPiA+ID4g
eGlsaW54X2NwbV9wY2llDQo+ID4gPiAqcG9ydCkNCj4gPiA+ID4gICAqIHhpbGlueF9jcG1fcGNp
ZV9pbml0X3BvcnQgLSBJbml0aWFsaXplIGhhcmR3YXJlDQo+ID4gPiA+ICAgKiBAcG9ydDogUENJ
ZSBwb3J0IGluZm9ybWF0aW9uDQo+ID4gPiA+ICAgKi8NCj4gPiA+ID4gLXN0YXRpYyB2b2lkIHhp
bGlueF9jcG1fcGNpZV9pbml0X3BvcnQoc3RydWN0IHhpbGlueF9jcG1fcGNpZQ0KPiA+ID4gPiAq
cG9ydCkNCj4gPiA+ID4gK3N0YXRpYyBpbnQgeGlsaW54X2NwbV9wY2llX2luaXRfcG9ydChzdHJ1
Y3QgeGlsaW54X2NwbV9wY2llDQo+ID4gPiA+ICsqcG9ydCkNCj4gPiA+ID4gIHsNCj4gPiA+ID4g
ICAgICAgY29uc3Qgc3RydWN0IHhpbGlueF9jcG1fdmFyaWFudCAqdmFyaWFudCA9IHBvcnQtPnZh
cmlhbnQ7DQo+ID4gPiA+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHBvcnQtPmRldjsNCj4g
PiA+ID4gKyAgICAgc3RydWN0IGdwaW9fZGVzYyAqcmVzZXRfZ3BpbzsNCj4gPiA+ID4gKw0KPiA+
ID4gPiArICAgICAvKiBSZXF1ZXN0IHRoZSBHUElPIGZvciBQQ0llIHJlc2V0IHNpZ25hbCAqLw0K
PiA+ID4gPiArICAgICByZXNldF9ncGlvID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAi
cmVzZXQiLCBHUElPRF9PVVRfSElHSCk7DQo+ID4gPiA+ICsgICAgIGlmIChJU19FUlIocmVzZXRf
Z3BpbykpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICBpZiAoUFRSX0VSUihyZXNldF9ncGlvKSAh
PSAtRVBST0JFX0RFRkVSKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycihk
ZXYsICJGYWlsZWQgdG8gcmVxdWVzdCByZXNldCBHUElPXG4iKTsNCj4gPiA+ID4gKyAgICAgICAg
ICAgICByZXR1cm4gUFRSX0VSUihyZXNldF9ncGlvKTsNCj4gPiA+ID4gKyAgICAgfQ0KPiA+ID4g
Pg0KPiA+ID4gPiAtICAgICBpZiAodmFyaWFudC0+dmVyc2lvbiA9PSBDUE01TkNfSE9TVCkNCj4g
PiA+ID4gLSAgICAgICAgICAgICByZXR1cm47DQo+ID4gPiA+ICsgICAgIGlmIChyZXNldF9ncGlv
ICYmIHBvcnQtPmNyeF9iYXNlKSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgLyogQXNzZXJ0IHRo
ZSBQQ0llIElQIHJlc2V0ICovDQo+ID4gPiA+ICsgICAgICAgICAgICAgd3JpdGVsX3JlbGF4ZWQo
MHgxLCBwb3J0LT5jcnhfYmFzZSArDQo+ID4gPiA+ICsgdmFyaWFudC0+Y3BtX3BjaWVfcnN0KTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgIC8qIENvbnRyb2xsZXIgc3BlY2lmaWMg
ZGVsYXkgKi8NCj4gPiA+ID4gKyAgICAgICAgICAgICB1ZGVsYXkoNTApOw0KPiA+ID4gPiArDQo+
ID4gPg0KPiA+ID4gVGhlcmUgc2hvdWxkIGJlIGF0bGVhc3QgMTAwbXMgZGVsYXkgYmVmb3JlIFBF
UlNUIyBkZWFzc2VydCBhcyBwZXINCj4gPiA+IHRoZSBzcGVjLiBTbyB1c2UgUENJRV9UX1BWUEVS
TF9NUy4gSSBrbm93IHRoYXQgeW91IGhhZCBpdCBiZWZvcmUsDQo+ID4gPiBidXQgcmVtb3ZlZCBp
biB2NC4gSSBkb24ndCBzZWUgYSB2YWxpZCByZWFzb24gZm9yIHRoYXQuDQo+ID4NCj4gPiBGb3Ig
Q1BNL0NQTTUvQ1BNNU5DLCB0aGUgIlBvd2VyIFVwIiBzZXF1ZW5jZSBtZW50aW9uZWQgaW4gc2Vj
dGlvbg0KPiA+IDIuMi4xIG9mIFBDSWUgRWxlY3Ryb21lY2hhbmljYWwgU3BlYyBpcyBoYW5kbGVk
IGluIHRoZSBkZXNpZ24uIFRoZQ0KPiA+IFBFUlNUIyB3ZSBhcmUgdXNpbmcgaGVyZSBpcyBhcHBs
aWVkIGFmdGVyIHRoZSBQb3dlciBVcCBzZXF1ZW5jZSBhbmQNCj4gPiB3aWxsIGJlIHVzZWQgZm9y
IHdhcm0gcmVzZXQsIHdoZXJlIHBvd2VyIG9mIHRoZSBzeXN0ZW0gaXMgYWxyZWFkeSBzdGFibGUu
DQo+ID4NCj4NCj4gSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4gYnkgJ3dh
cm0gcmVzZXQnIGhlcmUuIEV2ZW4gaWYgdGhlIHBvd2VyIHdhcw0KPiBhbHJlYWR5IHN0YWJsZSwg
d2hhdCBpcyB0aGUgZ3VhcmFudGVlIHRoYXQgdGhlIDEwMG1zIHRpbWUgaXMgZWxhcHNlZCBiZWZv
cmUNCj4gZGVhc3NlcnRpbmcgdGhlIFBFUlNUIz8gRG9lcyB0aGUgaGFyZHdhcmUgbG9naWMgZW5z
dXJlIDEwMG1zIHRpbWUgaXMgZWxhcHNlZA0KPiBiZWZvcmUgdGhlIGRyaXZlciBpcyBwcm9iZWQ/
DQo+DQoNClRoZSBJbml0aWFsIFBvd2VyIFVwIHNlcXVlbmNlIGlzIGhhbmRsZWQgaW4gaGFyZHdh
cmUgbG9naWMsIGFuZCAxMDBtcw0KKFRfUFZQRVJMKSBkZWxheSBpcyBwcm92aWRlZCBhZnRlciB0
aGUgcG93ZXIgYmVjb21lcyBzdGFibGUuIFllcywgdGhpcyBwYXJ0DQppcyBoYW5kbGVkIGJlZm9y
ZSB0aGUgZHJpdmVyIGlzIHByb2JlZC4NCg0KQnkgIndhcm0gcmVzZXQiIGhlcmUsIEknbSByZWZl
cnJpbmcgdG8gYSByZXNldCB0aGF0IGRvZXMgbm90IGludm9sdmUgcG93ZXINCmN5Y2xpbmcgdGhl
IGRldmljZSwgYXMgcGVyIFBDSWUgc3BlYyBzZWN0aW9uIDYuNi4xLiBUaGUgcG93ZXIgcmFpbHMg
cmVtYWluDQpzdGFibGUsIGFuZCBvbmx5IFBFUlNUIyBpcyB0b2dnbGVkIHRocm91Z2ggdGhlIGRy
aXZlci4NCg0KQXMgcGVyIHRoZSBQQ0llIFNwZWMgcmVwbGFjZWQgNTB1cyB3aXRoIDEwMHVzIChU
X1BFUlNUKSBiZWZvcmUgUEVSU1QjDQpkZWFzc2VydCBpbiBkcml2ZXIsIHdpbGwgc2VuZCBpdCBp
biBuZXh0IHBhdGNoLg0KDQo+ID4gU28sIHdlIGNoYW5nZWQgdGhlIGRlbGF5IGFmdGVyIFBFUlNU
IyBhbmQgSVAgcmVzZXQgYXNzZXJ0aW9uIHRvIDUwdXMNCj4gPiBjb250cm9sbGVyIHNwZWNpZmlj
IGRlbGF5LCBzaW1pbGFyIHRvIFRQRVJTVChQRVJTVCMgYWN0aXZlIHRpbWUgMTAwdXMpDQo+ID4g
ZGVsYXkgaW4gIlBvd2VyIHNlcXVlbmNpbmcgYW5kIFJlc2V0IFNpZ25hbCBUaW1pbmdzIiBvZiBQ
Q0llDQo+ID4gRWxlY3Ryb21lY2hhbmljYWwgU3BlYy4gQWZ0ZXIgZGVhc3NlcnRpb24gb2YgUEVS
U1QjIHNpZ25hbCBhbmQgSVANCj4gPiByZXNldCwgYSBkZWxheSBvZiBQQ0lFX1RfUlJTX1JFQURZ
X01TIGlzIHJlcXVpcmVkIGJlZm9yZSBjaGVja2luZyB0aGUgTGluay4NCj4gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHlvdSBoYXZlIGZ1cnRoZXIgcXVlcmllcy4NCj4gPg0KPg0KPiBUaGlzIHBhcnQg
aXMgZmluZS4NCj4NCj4gPiBUaGFua3MsIEkgd2lsbCB1cGRhdGUgdGhpcyBpbmZvcm1hdGlvbiBp
biBjb21taXQgbWVzc2FnZS4NCj4gPiA+DQo+ID4gPiA+ICsgICAgICAgICAgICAgLyogRGVhc3Nl
cnQgdGhlIFBDSWUgSVAgcmVzZXQgKi8NCj4gPiA+ID4gKyAgICAgICAgICAgICB3cml0ZWxfcmVs
YXhlZCgweDAsIHBvcnQtPmNyeF9iYXNlICsNCj4gPiA+ID4gKyB2YXJpYW50LT5jcG1fcGNpZV9y
c3QpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAgLyogRGVhc3NlcnQgdGhlIHJl
c2V0IHNpZ25hbCAqLw0KPiA+ID4gPiArICAgICAgICAgICAgIGdwaW9kX3NldF92YWx1ZShyZXNl
dF9ncGlvLCAwKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICBtZGVsYXkoUENJRV9UX1JSU19SRUFE
WV9NUyk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAgICAgICBpZiAodmFyaWFudC0+dmVy
c2lvbiA9PSBDUE01TkNfSE9TVCAmJiBwb3J0LQ0KPiA+Y3BtNW5jX2F0dHJfYmFzZSkgew0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgLyogQ2xlYXIgRmlyZXdhbGwgKi8NCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKDB4MDAsIHBvcnQtPmNwbTVuY19h
dHRyX2Jhc2UgKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFhJTElOWF9DUE01TkNfUENJRTBfRlJXQUxMKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIHdyaXRlbF9yZWxheGVkKDB4MDEsIHBvcnQtPmNwbTVuY19hdHRyX2Jhc2UgKw0KPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFhJTElOWF9DUE01TkNfUENJ
RTBfRlJXQUxMKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVk
KDB4MDAsIHBvcnQtPmNwbTVuY19hdHRyX2Jhc2UgKw0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFhJTElOWF9DUE01TkNfUENJRTBfRlJXQUxMKTsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiArICAgICAgICAgICAg
IH0NCj4gPiA+ID4gKyAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICBpZiAoY3BtX3BjaWVf
bGlua191cChwb3J0KSkNCj4gPiA+ID4gICAgICAgICAgICAgICBkZXZfaW5mbyhwb3J0LT5kZXYs
ICJQQ0llIExpbmsgaXMgVVBcbiIpOyBAQCAtNTEyLDYNCj4gPiA+ID4gKzU1OSw4IEBAIHN0YXRp
YyB2b2lkIHhpbGlueF9jcG1fcGNpZV9pbml0X3BvcnQoc3RydWN0DQo+ID4gPiB4aWxpbnhfY3Bt
X3BjaWUgKnBvcnQpDQo+ID4gPiA+ICAgICAgIHBjaWVfd3JpdGUocG9ydCwgcGNpZV9yZWFkKHBv
cnQsIFhJTElOWF9DUE1fUENJRV9SRUdfUlBTQykgfA0KPiA+ID4gPiAgICAgICAgICAgICAgICAg
IFhJTElOWF9DUE1fUENJRV9SRUdfUlBTQ19CRU4sDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAg
WElMSU5YX0NQTV9QQ0lFX1JFR19SUFNDKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICByZXR1
cm4gMDsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gIC8qKg0KPiA+ID4gPiBAQCAtNTUx
LDYgKzYwMCwyNyBAQCBzdGF0aWMgaW50IHhpbGlueF9jcG1fcGNpZV9wYXJzZV9kdChzdHJ1Y3QN
Cj4gPiA+IHhpbGlueF9jcG1fcGNpZSAqcG9ydCwNCj4gPiA+ID4gICAgICAgICAgICAgICBwb3J0
LT5yZWdfYmFzZSA9IHBvcnQtPmNmZy0+d2luOw0KPiA+ID4gPiAgICAgICB9DQo+ID4gPiA+DQo+
ID4gPiA+ICsgICAgIHBvcnQtPmNyeF9iYXNlID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291
cmNlX2J5bmFtZShwZGV2LA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImNwbV9jcngiKTsNCj4gPiA+ID4gKyAgICAg
aWYgKElTX0VSUihwb3J0LT5jcnhfYmFzZSkpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICBpZiAo
UFRSX0VSUihwb3J0LT5jcnhfYmFzZSkgPT0gLUVJTlZBTCkNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHBvcnQtPmNyeF9iYXNlID0gTlVMTDsNCj4gPiA+ID4gKyAgICAgICAgICAgICBl
bHNlDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihwb3J0LT5j
cnhfYmFzZSk7DQo+ID4gPiA+ICsgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBpZiAo
cG9ydC0+dmFyaWFudC0+dmVyc2lvbiA9PSBDUE01TkNfSE9TVCkgew0KPiA+ID4gPiArICAgICAg
ICAgICAgIHBvcnQtPmNwbTVuY19hdHRyX2Jhc2UgPQ0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZShwZGV2LA0KPiA+ID4g
PiArDQo+ID4gPiA+ICsgImNwbTVuY19hdHRyIik7DQo+ID4gPg0KPiA+ID4gV2hlcmUgaXMgdGhp
cyByZXNvdXJjZSBkZWZpbmVkIGluIHRoZSBiaW5kaW5nPw0KPiA+DQo+ID4gVGhpcyBwYXRjaCBp
cyB0ZXN0ZWQgZm9yIG1lbnRpb25lZCBDUE0gdmVyc2lvbnMsIEkgYXBvbG9naXplIHRoYXQgSQ0K
PiA+IG1pc3NlZCBhZGRpbmcgdGhlIGNwbTVuY19hdHRyIHJlc291cmNlIGluIERUIGJpbmRpbmcu
IEkgd2lsbCBub3QNCj4gPiByZXBlYXQgdGhpcyBhZ2Fpbi4gSSB3aWxsIGFkZCB0aGUgcmVzb3Vy
Y2UgaW4gdGhlIG5leHQgcGF0Y2guDQo+ID4gVGhhbmtzIGZvciB5b3VyIHVuZGVyc3RhbmRpbmcu
DQo+ID4gPg0KPiA+ID4gPiArICAgICAgICAgICAgIGlmIChJU19FUlIocG9ydC0+Y3BtNW5jX2F0
dHJfYmFzZSkpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChQVFJfRVJSKHBv
cnQtPmNwbTVuY19hdHRyX2Jhc2UpID09DQo+ID4gPiA+ICsgLUVJTlZBTCkNCj4gPiA+DQo+ID4g
PiBXaHk/DQo+ID4NCj4gPiBUaGlzIGNvbmRpdGlvbiBjaGVjayBpcyBhZGRlZCB0byBtYWtlIGNw
bTVuY19hdHRyX2Jhc2Ugb3B0aW9uYWwsIG9uY2UNCj4gPiBJIGFkZCBtaXNzaW5nIHJlc291cmNl
IGluIERUIHRoaXMgY29uZGl0aW9uIHdpbGwgYmUgYXBwbGljYWJsZS4NCj4NCj4gV2h5IGFyZSB5
b3UgY2hlY2tpbmcgZm9yIC1FSU5WQUw/IFdoYXQgZG9lcyBpdCBjb3JyZXNwb25kIHRvPw0KPg0K
PiBJZiB5b3VyIGludGVudGlvbiBpcyB0byBtYWtlIHRoZSByZXNvdXJjZV9nZXQgb3B0aW9uYWws
IHlvdSBzaG91bGQgdXNlDQo+IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUoKSBmaXJzdC4g
SWYgaXQgcmV0dXJucyBOVUxMLCB0aGVuIGl0IG1lYW5zIHRoZSByZXNvdXJjZQ0KPiBpcyBub3Qg
ZGVmaW5lZCBpbiBEVC4NCj4NCg0KWWVzLCBteSBpbnRlbnRpb24gaXMgdG8gbWFrZSByZXNvdXJj
ZV9nZXQgb3B0aW9uYWwuIFN1cmUsIEkgd2lsbCB1c2UNCnBsYXRmb3JtX2dldF9yZXNvdXJjZV9i
eW5hbWUoKS4gVGhhbmtzLg0KDQo+IC0gTWFuaQ0KPg0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPg
r43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQoNClRoYW5rcywNClNhaSBLcmlz
aG5hDQo=

