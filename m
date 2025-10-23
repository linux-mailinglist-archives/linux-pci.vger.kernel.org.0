Return-Path: <linux-pci+bounces-39082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F315FBFF5CB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 08:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14F613577B2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 06:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04DE29B795;
	Thu, 23 Oct 2025 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jUIN1/nH"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CC7080D;
	Thu, 23 Oct 2025 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201353; cv=fail; b=Jm2Vtn6aOjHpPmygDmwmktH3yb6spWBsXd1VlLiQFHKFK/rS4uckdA3WF8kC01WyC7gbfEEC2BRECkVSQQ/R4sTcJDTpEYLokGueHPS7Ilt2kBFIM2feZdyWJ46+X8YW+70VntojXengr0VTlvLjgsUdnbvbRu8IspL2QUtxit0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201353; c=relaxed/simple;
	bh=j5HeHJqWS2mNF1g/LYjmDEaE8978rMjgPUWGeGUMbug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jfDa/aAdzkT6V4ubOwV256hKIkejBWCTVk/wV4nVD6XF/exGXvnIXZTc2kNPkolMfKSHlP+WiHUAgCx/0HhnEW6nLZYefopqvJuRexiSKIT5z+PhcyiYP+VpjO6f0OOmzSShnSoR3wrC4hPPVeLhS61klgLJ9oclZfx2gT46Cv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jUIN1/nH; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujjQh+sc6YtZKTkzvuMiY8EBBhE1DZlIbvKj1tbyQMwjV64D278d7luVex3mDnPYMalb4/MCYACT7Nty4UIsEUEZshrjJxFf6lOgA5gqgX0evf4SrRdm6TZL14LTAqcyb0/ckoZ9jQTAwHt9NCoqMwvP3aPhNfgrUi03ixM4HR3uWwwOWqMP7NMxW/QZJrl6NPaxMYfrqE6xISHeBrGkXEwRcA/YFU7U/sKkdr/Ev7Rj/1qIqanj5FGi56fPgJU1+5oT2bP7zMCTwPCItrxf61uG/fqY8+NoABxGUjE1BoyzzQ1pFzXFyw4RBcN7W1ar+qPYZJV30XoxFzD+GlQcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5HeHJqWS2mNF1g/LYjmDEaE8978rMjgPUWGeGUMbug=;
 b=DxhZQVVMEUhMCzqMy/vxnUzXxgypsORNOZyVGoe27cVjNvJx1j2CHldmeBLwWm8rtKoS7cAWFHDYgBx3CxfV1H5f0eROFYx0Oa+dSDoLofdonAF/2ne6ou6RmZaoojcIJOvkkrnVU310g2CjrqpbhimtmcaQIldbuFAjAdT09igPDk0C8xDKc4YpQW5jsvlOiinuvNKie0EreZVTrvA2dssAIfIXuFdd7phqXGdeP1LS2YKJ+Hl6GmB+4pfqgc0heUNTgKz+FJouhKaX/f1JB5y3Blw9l8WctoXE4kybF4TW65ZoiarKLg0EQzadiGwX9m+UZWVoSPPtVlgCetq29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5HeHJqWS2mNF1g/LYjmDEaE8978rMjgPUWGeGUMbug=;
 b=jUIN1/nHox6YpIUSHGz2s2FRtVs2eS6fz6ehps3tMgvqt23YsDN5Ndn1gIvFYXAKrCGBi1gkyDpLBFSjbWT1h1bv7LaWDC47BGLi7J/PdbuAyXalUZY4zV9nMszkftpkBM00hAqsG1CAsme460Q4Rx9XFn5wDqRtfPIhRp90coo=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Thu, 23 Oct 2025 06:35:47 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:35:47 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Stefan Roese <stefan.roese@mailbox.org>, "mani@kernel.org"
	<mani@kernel.org>, "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "Bandi, Ravi Kumar"
	<ravib@amazon.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
	"Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: RE: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Index:
 AQHcKoFZBALFGa/Kqki5vrSD8b1UILTNCbqAgAAGd4CAABdpAIAAHYKAgAAJCICAAJ+fgIAAMSWAgAABJACAAAIPwIAABzEAgAAAhICAAAatAIAAG+yQgAAQmgCAARqPAA==
Date: Thu, 23 Oct 2025 06:35:47 +0000
Message-ID:
 <DM4PR12MB615855ADA4F81818418FD6EBCDF0A@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
 <72267a6c-13c7-40bd-babb-f73a28625ca4@mailbox.org>
 <SN7PR12MB7201CF621AF0A38AA905799D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <brekq5jmgnotwpshcksxefpg2adm4vlsbuncazdg32sdpxqjwj@annnvyzshrys>
 <SN7PR12MB7201C6B5B64F8847DD6D816D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <zuj6puxpqgjmaa3y3wwyixlru7e7locplnjev37i5fnh6zummw@72t5prkfsrpk>
 <DM4PR12MB6158ACBA7BCEDB99A55ACA03CDF3A@DM4PR12MB6158.namprd12.prod.outlook.com>
 <29bc5e92-04c9-475a-ba3d-a5ea26f1c95a@mailbox.org>
In-Reply-To: <29bc5e92-04c9-475a-ba3d-a5ea26f1c95a@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-23T06:28:48.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|DS2PR12MB9616:EE_
x-ms-office365-filtering-correlation-id: 73117194-6660-4a85-202e-08de11fe6687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MThsM3JZY0R5bmV5SE02SzBQN1F1UWU1Sk5zRkh2VFg3V1Frd00xTzVaZGxw?=
 =?utf-8?B?dzdLbkYyV2gzWEZ2a1pTVytrWFd1bHhTNzJhSjZDMnpBTDU1UWNpbytCYkgv?=
 =?utf-8?B?a3FxN1Nicnh2OS9iVXNGbXUrM003bzZyYUFXVUVLWllXYkZSUjdIOURtTVU0?=
 =?utf-8?B?TjdraS9Vcmx3T1NHNWR6Yy9MWkdzdnBUMEhVY1l4UkQ3SGxVend2bEs4UUhk?=
 =?utf-8?B?SVoyZ2cvY0hNSlZEaHRrOFdZR29Lc1U4KzhDNE5PaVlKaEpSb1VYcThvZFEw?=
 =?utf-8?B?K1F3bzJOQ0VNaGUvdyt3VFRZczNtTGVqQkkvbjBCRjNoNEVqMDNWOTFCU0lP?=
 =?utf-8?B?QzBsMTcwZEVZRGxNbUsrNml5OFRuRFhTdHBaSlRDMTFLcjlwVisreHdma2py?=
 =?utf-8?B?RjR4L1QzWGkrMW91ZTZPRVU4aWNLektvTzhZd1pka08wTEVvTWNvRVhjVDc2?=
 =?utf-8?B?c045a2xDUXQ5WlJaOUlPanJYWDVQZ2NEWEpOUjdRRmxpSlBHUklhb3VHWGNk?=
 =?utf-8?B?VEpKb0Z5L1p6cXZzempERGVRTzNSQ3JOZmpubkYvdlRUeGNJUWt2R3VLUUwv?=
 =?utf-8?B?UExyMlBaWEszUkpqVkVqT3NyeWRqSHB6UnNuMmpuekEzR1ROa3RQWEQzaDdY?=
 =?utf-8?B?by9IZkxTL2sxVElEcWdRYVhwWjFUUUxKTmo5WEY5Q251TEw5UUx6UnRNcmpx?=
 =?utf-8?B?SlI2VDlKSVJBMmt4c0RYWVVEZ2xPb3dBWnVDQ05VZUhrRWVyZTR0ZThXUUhp?=
 =?utf-8?B?US8rMTg1TnphK2dyTk1VMU16SnAxTnJEdEpTZFRnbUU2U054bDNVck5vd2FM?=
 =?utf-8?B?V1YwdVd1NDlDaXUrd3BvekgwNGdrS0hkcFB4SGQrWXAvdWVlTWFOQmxmVXI4?=
 =?utf-8?B?bm9LeFlwSExXL1pyNTJmbDVJSXVJRk1ScHRyMUlZQWxxc0VMNWNoSENudEdL?=
 =?utf-8?B?OG5SMnJWekxGQVRKSnc2WVFsNVVtcVRRZ1V0UDI4NXZGaklVcEY0V1VZK2V0?=
 =?utf-8?B?cU9GWHZJSzdjWndkZjdqakFqNmhidWQvVHpON1hTaEE2dlVFT09OeTZrd0ZR?=
 =?utf-8?B?blZlcjFBMU1jRFhOaUhVbWZNeCtNWitiR0prc2p1bUJKL2dzNWh1aGdsaTRw?=
 =?utf-8?B?cUR0c1NpMW9qK3BIcHliZjlwS21VMm9YUm92bzBEL1ZvNndFOVZsSmNIZG10?=
 =?utf-8?B?R003Y0tJcFYvelVzK3JtYlg2VnFjd3QwNUUvM1FCa3RiZ2x4bHgrQnF5NXF6?=
 =?utf-8?B?YURlOXFaUFc3Sm1FY2NCNWFrQTJhRlpHS1JmeHVmcUJRaVFIKzhqUHBZNEUx?=
 =?utf-8?B?Ykl0L3o2S2lCUThJRHBYb2hiamZ6d2I0b01jSCt6ZUtyNWdqVEk0b0x4K3dQ?=
 =?utf-8?B?Z0VndWRCYmt3bjhwK1I5ZUI4cmk2SnNyMDVOa1h4clNvZEowS09pSk1GUWFo?=
 =?utf-8?B?U2ZEelJDM0p5ZGV6bE9VUElJS2dWV0hyaFB5QWZ4Wlc4N0s1RU9lSHZ1enFl?=
 =?utf-8?B?TE9XSUMzb2NMV29zNmdXUE9kek9aa29LcTNCVGVDcForVTgxNmF2VEVoQ3FW?=
 =?utf-8?B?aU00dUpxY2hrazc5eDhmTmlNQXU2bVF6K0FvYi9EaUNNMlVxOTNCMVBpOHhE?=
 =?utf-8?B?SGRkdEhjMnpVK0pMMzJrbGpmLzhKZ0tMR2FwNmVaT3EwcjRnRmt1alpoVkJF?=
 =?utf-8?B?YTJOSnh3VTVDaTM2T1hGb0JOVkxCYy9EYThBSTJBNVRsL2VFaENZd3dXb0Vq?=
 =?utf-8?B?cFNGR0VjZFhxblNKa1NLclNuY1poMlhuZ2I0bGQ3aEtPbERaU1ZlTTZnS1Rp?=
 =?utf-8?B?aVpxajE3QlNTc0pHSG1OZ0NoVmp1N0RkeGZsNVVLazNHUDZMRGpGN0NrQlo4?=
 =?utf-8?B?by9kRVppaEZianppUzFURDZLZmNMQjdZQ3NweXlXN05IM2w1V044OHdmSHlO?=
 =?utf-8?B?aXBwNmkvTW9iaElQODM5eGVVNEU3VmRDb1BGVU5YZVhGT0VsSm5ETTcvQ2ND?=
 =?utf-8?B?WDdSaGlzbjBqTDZ4dVRZUkh2WVJ1L2JPYnB4NDFBZlAzYjc1YTNRS0toeGZQ?=
 =?utf-8?Q?Bbbg4c?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVlETk9oQ1MwOWRtMGV1bmZxWDdjak40eVlEY2ZGazV1aUNiSDJDeEdIaXNu?=
 =?utf-8?B?dlBLVER0NkdrcUN1aVlZVUtjT2lLNmdYek1ZZHVvMUo3RTdBMzQ0UnUzbmlp?=
 =?utf-8?B?cUpQZUhFR1FRZGNhZjA2SE5HdkRtTDFSc3lIeWE2N0c4RHhKaGhoTFlKd1d5?=
 =?utf-8?B?ZW9OcjRwbzNuSDgvdzFHWEtOUlZhT0dqc09tYUZBL2JueHBLRlRaTENkNndC?=
 =?utf-8?B?eFhESHl1WktvK29FQkpsc0x1enZCZEJlM29XUmZCbHVmR21xN0FKVHB4eWtC?=
 =?utf-8?B?dVdnR1I1YXoxNEkyVTBzc2tGRWdWTFJHSmJDVllhWGl2dDJJSjlXV0hkajRB?=
 =?utf-8?B?b0E1K25JZVBrUFEwMnBubmxEZVhxZ2V5Z2cvUmxwRmlpZzdrZDZjNk13ZFVo?=
 =?utf-8?B?MjlIbkRzeEhVblZYbWZCd1pKdDUvdTB2VE8wSzUyblg1TktCK1h2VUorRmNv?=
 =?utf-8?B?WitoSGR4TDNIWERWNENFYkRFakhJT0FxNEZWSWV0WVJid3RDazF3VjJBcWtn?=
 =?utf-8?B?T0M5R1dXUFNyRUovVUloT1kyT240MTJDZXN3L3FoTHFpYVFiOVhqT1dyMFBk?=
 =?utf-8?B?QSthcy9STHdlYitpQTBabmErYTlBNHVMNE40cTZYaGYvSjNwLzdiTzEwSkth?=
 =?utf-8?B?OXVxR3lHZ2J0dmc1L2UxcEF2MTgzOTJSZ21UbVFSYU9yL1FKVFhuUXA0Rzdt?=
 =?utf-8?B?SXNwS0tmdEsxbU5ET05zOTkrRWtEdTZsZ20zMlJQNEtYRCtueGJ1WnVOd0RU?=
 =?utf-8?B?bXlHbWMyWXdOWjN3WVk1R1JWMEtZQ1BtQ3FJYUwvNURRMEhXTzJaaDRCRUdV?=
 =?utf-8?B?czAvV0JKWmFVQ1ZmVnltMzRVZmJuZkwrZkNzZldOY1F1K0cydVRLVGJObkpj?=
 =?utf-8?B?MUVXU3F2VUZKZ3RGWE9LeEZHUDJBQ2FHQzVDWnNBMFVlaGpLUDBUT1ZPNy8z?=
 =?utf-8?B?ZUdKYTNxT2xSVXNRVldlckJuSEFHL1M5UXVKYXpRSUl2SUc2alFiRlBCTHpt?=
 =?utf-8?B?RTdFZHhUNkpBWUtaTkFBTGRKVCt6ZXg0U0M1ay84R1VFNmlQMXcxbkJKaWg1?=
 =?utf-8?B?dHlYM3lwYVJWTkdteSt3UndLNFlxMGM4NHF0N1dEY2ZVQXd0ejBRNkVPd1A3?=
 =?utf-8?B?YlRxM21adk50WWF6ODRIUG9xdlFaSkpTSWhZVnBjV1N3LytYdXNxUGVrMFFN?=
 =?utf-8?B?UnAyVjlPejJLeWpLNXkvUW9MOTdZQkxvQUxNM3h3dTZtWWlEekRBbTRVVFl5?=
 =?utf-8?B?ZU1zdENPTzgreVZkZXppL2hLL2JuUG5CRWVsR2NWRVlvV1REQXdWdlNUK24v?=
 =?utf-8?B?TTV5RnE4akYrZDVDeFllbG9WcWY5bEpoZGFFNDNWZXE0akpnajNtekFPaWRC?=
 =?utf-8?B?ZWhFZ254d1gxMWI5TjhCU0tVbm9ELzBtNHhFdXk3NlpvMUR1VCsxdWo2TXJh?=
 =?utf-8?B?Mm8yazFrbTVrR2FRYlNydE9tNzE0TXBYaWNGdnhZcVVjNUNIM0lRRWY4K0xH?=
 =?utf-8?B?VU0wRDB6cU9Cc3hWNFlXWUF6SXpxVFdnQi9HYkozSk5wbVpvbHRPSnNobXZJ?=
 =?utf-8?B?T0RVR1VnN2M1Vis0aVdTdGpsUGtycm1oSXA2U2lVaGhQbmpraEdFeGRQV3pQ?=
 =?utf-8?B?eVNhckRWY3oxT284T1JiYlY0OThmTDc5ZzVjRGptQ2FJUUJ0QnZwU1NVaFlQ?=
 =?utf-8?B?N2d2Y3VOWHJETEdqTzdrejFtRFJvS2NYSVhxZXJkQ3NsMlcwQXUwU0VYNUhW?=
 =?utf-8?B?eHJGaDZYNXg0K2V5MFhwNk42V3JNTU44VWlsK0lqWWptZ0lRd3A5V3lEcFpD?=
 =?utf-8?B?aFlxbGx5Y3k1cTRtckZWZW93MEcvRS83MEgxWHZ0cG10THVVcFB6TFZKYmsz?=
 =?utf-8?B?THBvMzd4d2VYQm5BcS9MdkxaM0h3bnJjRFpCK2Q1RmQwWThRSzM5cDVtcW5R?=
 =?utf-8?B?MWd5YkdYdUlEeDRTdmQzMnViRENJYzlIWTB6WGh2V0UxQXplSjM3TTI2NlFW?=
 =?utf-8?B?SjZKME9MNVQ3Qy9Xa2VOQzhJZGhLUFhlZUFXM092Z09STzJkQ1dsa01EaERV?=
 =?utf-8?B?T3NhWEZJNHJybmF2cDdmdzI2Y3A2L29JN3pSUWszc0hoTnZhdVdZWWFJdGZ4?=
 =?utf-8?Q?a0gI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73117194-6660-4a85-202e-08de11fe6687
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 06:35:47.2083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fO2hQqLbDyeGNVZ6eOBZkKkXXAh6AUFm+TKMuUE1xe7aNnKqY80atO+7oMRvnIhVitZRilCoZpaCJpRjUhtrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gUm9lc2UgPHN0
ZWZhbi5yb2VzZUBtYWlsYm94Lm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIyLCAy
MDI1IDc6MDggUE0NCj4gVG86IE11c2hhbSwgU2FpIEtyaXNobmEgPHNhaS5rcmlzaG5hLm11c2hh
bUBhbWQuY29tPjsgbWFuaUBrZXJuZWwub3JnOw0KPiBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgPHRo
aXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+IENjOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFz
QGtlcm5lbC5vcmc+OyBCYW5kaSwgUmF2aSBLdW1hcg0KPiA8cmF2aWJAYW1hem9uLmNvbT47IGxw
aWVyYWxpc2lAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtDQo+IHBjaUB2
Z2VyLmtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsg
U2ltZWssIE1pY2hhbA0KPiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBz
dGFibGVAdmdlci5rZXJuZWwub3JnOyBTZWFuIEFuZGVyc29uDQo+IDxzZWFuLmFuZGVyc29uQGxp
bnV4LmRldj47IFllbGVzd2FyYXB1LCBOYWdhcmFkaGVzaA0KPiA8bmFnYXJhZGhlc2gueWVsZXN3
YXJhcHVAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gUENJOiB4aWxpbngteGRt
YTogRW5hYmxlIElOVHggaW50ZXJydXB0cw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3Jp
Z2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdo
ZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+
DQo+DQo+IE9uIDEwLzIyLzI1IDE0OjQ4LCBNdXNoYW0sIFNhaSBLcmlzaG5hIHdyb3RlOg0KPiA+
IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHld
DQo+DQo+IDxzbmlwPg0KPg0KPiA+Pj4gV2UgZXZlbiBkb27igJl0IG5lZWQgcmF2aSBwYXRjaCwg
YXMgd2UgaGF2ZSB0ZXN0ZWQgdGhpcyBhdCBvdXIgZW5kIGl0DQo+ID4+PiB3b3JrcyBmaW5lIGJ5
IGp1c3QgdXBkYXRpbmcgaW50ZXJydXB0LW1hcCBQcm9wZXJ0eS4gV2UgbmVlZCB0byBub3cNCj4g
Pj4+IHVuZGVyc3RhbmQgdGhlDQo+ID4+IGRpZmZlcmVuY2UgaW4gZGVzaWduLg0KPiA+Pg0KPiA+
PiBPaywgcGxlYXNlIGxldCB1cyBrbm93IHdpdGggeW91ciBmaW5kaW5ncy4gSW4gdGhlIG1lYW50
aW1lLCBJJ2xsIGtlZXANCj4gPj4gUmF2aSdzIHBhdGNoIGluIHRyZWUsIGFzIGl0IHNlZW1zIHRv
IGJlIHJlcXVpcmVkIG9uIGhpcyBzZXR1cC4NCj4gPj4NCj4gPg0KPiA+IFdlIHRlc3RlZCBvbiBM
aW51eCB2ZXJzaW9uIDYuMTIuNDAgd2l0aG91dCBhcHBseWluZyBlaXRoZXIgU3RlZmFuJ3Mgb3Ig
UmF2aSdzDQo+IHBhdGNoZXMuDQo+ID4gSW5zdGVhZCwgd2UgYXBwbGllZCBvbmx5IHRoZSBmb2xs
b3dpbmcgaW50ZXJydXB0LW1hcCBwcm9wZXJ0eSBjaGFuZ2UNCj4gPiAoZW50cmllcyAwLDEsMiwz
KSBhbmQgdmVyaWZpZWQgdGhhdCBsZWdhY3kgaW50ZXJydXB0cyBhcmUgd29ya2luZyBjb3JyZWN0
bHkuDQo+ID4NCj4gPiBpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJnBjaWVfaW50Y18wIDA+LA0K
PiA+IDwwIDAgMCAyICZwY2llX2ludGNfMCAxPiwNCj4gPiA8MCAwIDAgMyAmcGNpZV9pbnRjXzAg
Mj4sDQo+ID4gPDAgMCAwIDQgJnBjaWVfaW50Y18wIDM+Ow0KPiA+DQo+ID4gMzg6ICAgICAgIDEx
NDMgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAxNiBMZXZlbCAgICAgODAwMDAwMDAuYXhp
LXBjaWUNCj4gPiAzOTogICAgICAgMTE0MyAgICAgICAgICAwICBwbF9kbWE6SU5UeCAgIDAgTGV2
ZWwgICAgIG52bWUwcTAsIG52bWUwcTENCj4NCj4gT2theS4gU2FtZSBoZXJlLiBJIGRvbid0IG5l
ZWQgUmF2aSdzIHBhdGNoIGZvciB0aGUgSU5UeCBiaXQgZW5hYmxpbmcuDQo+DQo+IEkgdW5kZXJz
dGFuZCB0aGF0IHlvdSB3YW50IHVzIHRvIGNoYW5nZSB0aGUgaW50ZXJydXB0IG1hcCBpbiB0aGUg
YXV0by0gZ2VuZXJhdGVkDQo+IGRldmljZS10cmVlIGZyb20gVml2YWRvLiBXaGljaCBpcyBJTUhP
IGEgYml0ICJzdWJvcHRpbWFsIi4NCj4NCj4gSSB3b3VsZCBwcmVmZXIgdG8gaGF2ZSBhIHNvbHV0
aW9uIHdoaWNoIHdvcmtzIG91dC1vZi10aGUtYm94LCB3L28gdGhlIG5lZWQgdG8NCj4gbWFudWFs
bHkgY2hhbmdlIERUIHByb3BlcnRpZXMuIElzIGl0IHBsYW5uZWQgdG8gY2hhbmdlIC8gZml4IHRo
aXMgaW50ZXJydXB0IG1hcCBpbg0KPiBwbC5kdHNpIGdlbmVyYXRlZCB3aXRoIGEgbmV3ZXIgdmVy
c2lvbiBvZiBWaXZhZG8/DQo+DQoNClllcyBTdGVmYW4sIHRoaXMgd2lsbCBiZSBmaXhlZCBpbiB0
aGUgbmV3ZXIgdmVyc2lvbnMgYW5kIHRoZSBhdXRvLWdlbmVyYXRlZA0KZGV2aWNlIHRyZWUgd2ls
bCBpbmNsdWRlIHRoZSBjb3JyZWN0IGludGVycnVwdC1tYXAgcHJvcGVydHkgZW50cmllcy4NCg0K
PiBUaGFua3MsDQo+IFN0ZWZhbg0KDQo=

