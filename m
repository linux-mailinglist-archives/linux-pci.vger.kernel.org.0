Return-Path: <linux-pci+bounces-38991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723FBFB6D3
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DA9189A894
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DB4322C9A;
	Wed, 22 Oct 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLR+JVU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79A315D29;
	Wed, 22 Oct 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129396; cv=fail; b=h+XlGr/IbVTfm65x81etT2VFnSC8KWsWAl75s6D/4xlI1PlqGsKoSND6QmC57UyQuS8j6EcprBcPAnqVXe68SKmcCnJ3ehR7y83GAFqPMUyU86zWCRo+ATBmrAgxeNvSg6nPHa93WERKVztVv3z1U7vW383fpPXyDeR3oHp1wPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129396; c=relaxed/simple;
	bh=Af/Y688x4lDUSuMrat0yv5aGW4QYSkLF1xDhVqMF0cY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kwe116TMkKfQJ898D8E4XajEGx+tn3zzIq70wlVRx5Wqc0cUGtfgL2tdosaCVRDwd7GLTtnc/usFUsAL9a9snjLPUn0vWHgGQ9U2TnQZSb+6mplg+2q4mwk6HnY8SLmXLY6ehC37YCqH5NZiX2yVORecDOQQuCx2bBvOFkIiabQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLR+JVU/; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwO/RqV2Ne8QX9UnsGrBMPP2KmkZbske8yrbxC6xYs55e0Bu0Tap6g0xdAMYcOS7aq5HBWtUBPrnNrOKRAAgp/V4OuiFi36HhzuJS2GknIqbGwX0Ln471FT0vO3d38Q/Ptitc5QlZY7y4onnuu5mBxvNMFjOlP0pPz0gzIRd5npes5Ww8qjLBsWUpSc9UUGD1ceBGPBtV8SuGufvr/0g5DW5UGa5LHL+6vAwN4C1Tn53n++yloMM/T0Qy/LTZ2PY9DdINNW45V0q62MYY32yIRF4jh4pSYzf9llgB8PtX/p1jYX6EtywA9J1fjWTV8vKJSpqzxwjhqqVgcptKEEKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af/Y688x4lDUSuMrat0yv5aGW4QYSkLF1xDhVqMF0cY=;
 b=epqNhbNG+Xd5qtvCXmqs7djizvdhCmOqaL9WHlXqtOIBqJX53cF928cJ41ZJ4msY3WYP1U9bzOPSm/o6NiiO07+LTjpTr9g19DDzYbmb1cwYtpfqBXPDewuoCOmNXD4wsiRILv6x4esv8Mg+DXQRctqJ0F8EM0/5d3PC6WaaRRRxiR6SrENiDqnDwII3fyMJmkk+gFOjDhccdNMFu0ru0Ct6OrIi/sl7DjrCU3SrTg3Ds3cH2E5HTOorAB6T2hWDsY5A/gs2UMEl2KH/bM0AgzyF/lEaK0d6G0xZd94J+IeCDiKrKE+HrlZlzqq+3iVzCDX/5bVY1s/5jNnrgEOibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af/Y688x4lDUSuMrat0yv5aGW4QYSkLF1xDhVqMF0cY=;
 b=kLR+JVU/mI57unSb6kB5RmDXkpj9SR8e2D95PmLbqhUMQGW+0vUvIeRKtMymPtjy7mPAMel8kNlUijf2R8wwUzlDlnwZhq6uxqTkAuRhZ6bOCNHlglQyToCItqoDJA+khDCJPgCtql5zdtgamqBlbFmWK5iVs5SbzoBGpNQgci4=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 10:36:29 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 10:36:29 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "mani@kernel.org" <mani@kernel.org>
CC: Stefan Roese <stefan.roese@mailbox.org>, Bjorn Helgaas
	<helgaas@kernel.org>, "Bandi, Ravi Kumar" <ravib@amazon.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
	"Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>, "Musham, Sai
 Krishna" <sai.krishna.musham@amd.com>
Subject: RE: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Index:
 AQHcKoFZBALFGa/Kqki5vrSD8b1UILTNCbqAgAAGd4CAABdpAIAAHYKAgAAJCICAAJ+fgIAAMSWAgAABJACAAAIPwIAABzEAgAAAhIA=
Date: Wed, 22 Oct 2025 10:36:28 +0000
Message-ID:
 <SN7PR12MB7201C6B5B64F8847DD6D816D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
 <72267a6c-13c7-40bd-babb-f73a28625ca4@mailbox.org>
 <SN7PR12MB7201CF621AF0A38AA905799D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <brekq5jmgnotwpshcksxefpg2adm4vlsbuncazdg32sdpxqjwj@annnvyzshrys>
In-Reply-To: <brekq5jmgnotwpshcksxefpg2adm4vlsbuncazdg32sdpxqjwj@annnvyzshrys>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-22T10:34:14.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SA0PR12MB4349:EE_
x-ms-office365-filtering-correlation-id: 6253c5e5-ed56-4b94-89fe-08de1156dc17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3hHU0pCcFVpSTIrbmNreE9BSWt4b2FQNVk1cTFscnpBc0toTk1oSktNUGMx?=
 =?utf-8?B?US90LzBVaHR0a2pZcWZZeGRCSWsrVTJLQ1NBT1pONm5xMTlmNXlHWDBWdGVm?=
 =?utf-8?B?OUE4VGxLVXlReU5uSkYwVHVMejZad2lCSDBrY0szdWx0U2ZCMUpMSFFZeWVl?=
 =?utf-8?B?WnpaeWVHbnBTdDFad1B0aSszSFpVYWlVTHRxeEZ1empCR3NwbUJqM1plMXRW?=
 =?utf-8?B?dmRnNWFodVBrOTdRd29ZeEVtdEFSY2lNeVdHTzNYMGdaUDg5QS9CV3VCUjZR?=
 =?utf-8?B?RDd5bjRzMTJFTzdkODlBKyt4N1pxbkxIRE00UmRseXF1TTIxSzdodzBOZEJa?=
 =?utf-8?B?UGdYQXIxczV4RmhrbWxJMUZVL1g4RzNNTUUzVzlKQVhMQ0hIUW00STlDRGJt?=
 =?utf-8?B?MnVJMnN2L3hqMFdTMGs4WVhSVWFza21FS29JUHdtMWVUWU9hdldlYXN5M0s5?=
 =?utf-8?B?R2JRVm9mT0xXL2ErZVY2TE5MNXFVbzdDVkwvbkhPM0lENGpwM0RCMUtqdkhp?=
 =?utf-8?B?NzN2VkE1TDdGeWljakZCL3VnNG9IWUd3SFRkb3pKNDY2Q282bk1ldUpxdjRk?=
 =?utf-8?B?UFpHZmtTZmxmWEtjbVBzb1ZkRS9NUFJuYVJlbVNFNEQ2bkVDNm4xaE4rTFpF?=
 =?utf-8?B?MHQ3eS80UVowMlV6RVBPTEozWkcxRzFBU1o1WUZhL2gyTUttdmNBaEJ5bHNJ?=
 =?utf-8?B?R2tObjQvZVp6NWdIWUxyVUxHdG81OVNobk95WVRmMVNDTERsSFJUMDdlcXc1?=
 =?utf-8?B?ZjMxcTBGNHZ2M3hmdDB5UExkYkcvaUVvVHpyUkNxdFhMeVpDQ1piRzlkV1dI?=
 =?utf-8?B?QUVpZXlUM2IyTzlHTHB6YjBTRFVMK3lNaFltWGUwKzUzSTFQWDVnUlhjME9o?=
 =?utf-8?B?Y0pRS01ZV3VqM1RRcFJBRm10TWtveVZSRjdGdDAxdnUybHpMQm94c2h0RStU?=
 =?utf-8?B?bDBvUnFFczhOUzc2NzQ0YTIzTm4wU1RqZGFJTmZjUG5OVW5idkFWWDNOb0dh?=
 =?utf-8?B?c3U3dmxpMmVIUDJEZkVKRVkrMHA3MjJIdU1zL0U4VHdadXFRMFFlUHlUVFdi?=
 =?utf-8?B?OWk5amluRVo0TW5wVUJCeGRHR2M2Mjl0cXNYMFpOdWQ4Q1ovS29rN0J5VWlS?=
 =?utf-8?B?a1Rtd25EQ0ExQWF3OTZTTHVtYlRRUG9nZVV0V2tSV255am5rSHVpM2l3SVBu?=
 =?utf-8?B?Q2Erd3RKaDF4TnNaa05xWTNPeng2Z3JMUHBCZzN3bTR3TnBLb01lYVlSUm9k?=
 =?utf-8?B?MTk0QTViL0MvN3A4L3gyUXBxYWtVR09xQ0xVY3F3MkV1QmVxek4zUXc4WlhU?=
 =?utf-8?B?Z1lRK2dQcHhaQ0JhMURlUXBFZUFmcWFEdDBGcG1TeGhEZDZDcGQ3N0x2ZFFq?=
 =?utf-8?B?ZEVCbmM2L0dPdTB5S2NBTytyb2Y1Nit6NjV3eWFsTC9Ib0owRC95QzNPV2lK?=
 =?utf-8?B?Mk93VndwcmROdTQ2UWlJTjRPS2lDbWhwb2JPWlFpNnkwVW5nY2Rhc1BRbVRl?=
 =?utf-8?B?YS9ucFFQeGFNbEt5cXNoY2s2dDM1TVNxUUlVMm9YSUxsbFpyQTRVemU4bHJm?=
 =?utf-8?B?Q01YQjluVUFERnYvUWdrbUdjeUtPL2JiUDBCL1NqcHIzYVFFSjRqYUcyTnNZ?=
 =?utf-8?B?Z2tPTWJqcVNXVkE3QXlDTFdocVNZdkdhQktUeEhsZFhkU2RnQU1RRlJtMzdi?=
 =?utf-8?B?MlZnNkJBcktydkNBcjdNQUlxQllhYVUvOWJNUW40SlEzeGcvYytiMTB4L2xF?=
 =?utf-8?B?ZlIvSmY5UThQWTREaExmVmRFZ0R3QkNGZzdNZXVjT1hwWDFKWkdUakYwaXV5?=
 =?utf-8?B?K21SeFhOL1gvU2lMM1JlTDBQRG9iUmFzQy93THFhMG9wSHRNb0I3aDZvQmhR?=
 =?utf-8?B?ZjU3RWtrZEg1dmpPVmxCSExtb01vc2d4REV2cHFkYVJQYkpybXJQUXFMNDZs?=
 =?utf-8?B?U3Mwd1VqTUM1MHFFM0VDWmVKdzNweUR3QzhEWmNCTjNYcHN4cGtKcWd0WFFr?=
 =?utf-8?B?eGpDanRYVlBYY0VIS2dsamtsdTlIbDhLeXlwV2Z6WWZYbVhBNVpDemtGdjNO?=
 =?utf-8?B?MW5IbEZ0ZkVxOXpnTHVDcmdzUUdad3A3YWdWUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTNMNzdTSjlFY090c3lrNjlVWUsyNWs5UHFqWHcxUjdvdkJpVWx2bDJzS0Q1?=
 =?utf-8?B?QXdSM1JhNUlPTWRtcFdKZnpnRTZWL3FKYVBIa2Z2SGp5RXZrSWU5eHNISi9Q?=
 =?utf-8?B?TG03RkM0bmorMmtJK2hQczQrV1Qvb2RWUG1GQnN0KzZheEtYYXhaNVFSQkk2?=
 =?utf-8?B?MVZUa3VIWlBVYTRLMUgxUENqdktKVStzRFRXZUtYbWwzMkVkN1dSdmNlUk5K?=
 =?utf-8?B?eUFKb3RRY0tOV0xlcHcvS2tvS3FTUmxRMUZMcGZnTmpLczRsM2NUeFFNOU9t?=
 =?utf-8?B?NHFKaDJjVXZjSmk1VUVZOXhoYWVMNXFiMGZGQUYvbkUzR3hiUUswUFRZY3U2?=
 =?utf-8?B?aCtiS0IrLzk3UlUxbHArVFFBLzBaN0tWd0lWOXFwbmVRcEVCQURLTTltbFpr?=
 =?utf-8?B?ZmxZV2NRc0ZiazJ3YmE4bkl1WHc0WnkzSXljWnMzdE5tTTVVZDNOc2dZRExF?=
 =?utf-8?B?eGxTWGRtZnMweDc5YWNLWVBjeTJmdE9LM3E0cmpIaSszMTg5SHRGclo3aElL?=
 =?utf-8?B?TVNGdUNRZHdpQUFNdDFMTm9hQnU2UGhXM3FWNlg3VmdybzN1aEF6S1pzeUhS?=
 =?utf-8?B?SWdiVWtreS8wYWtDRndCT0luU3hyaEM5MUJWVis2SUZuWEI4UjhSRkRuNk4w?=
 =?utf-8?B?U2lIZDlGcE9hWG84ZExkS2s3MHdyc3lFaVlUY3JITjZYcG1QR3ZpVFlFbU9Q?=
 =?utf-8?B?UVFCSnNRem90VGZaQTVrNUJEV281UHRqVXFUT2VsYllCd01iZVB3Z3BQbzFp?=
 =?utf-8?B?b2QvcERPTmIvdmhWNUtEV1pFRmNReXQ2eVl4azVua2ZWbWMzUExkb0tzemwy?=
 =?utf-8?B?eU9NQTQ3U01CSlk0VGpPbVFaZ3R6QTVFUjNObFc0S2hYeUl1emw1SlE5dk9u?=
 =?utf-8?B?NU5nOGFRamdYT0JkR2psR2lTRFkyd2JRTTQvcFJCS3BkNjZWQ3h1SUJqOXA5?=
 =?utf-8?B?eDExTkRILzZHN2JvRVYxVzRTWk5NL1JsZkV0SWY0emVlb0pqTjFMOUVDWlpm?=
 =?utf-8?B?VSs2Y210SGp4dmZwQ0JkNm9xanlWRkpGUE1jK0NnV0tzTllBS08wWkZja1BU?=
 =?utf-8?B?bWRzdXNvMTdGekZobWx6WE5JeUdhUWZiZi9sQmhhUm9zVFI5SzRDQWlOOWx5?=
 =?utf-8?B?a2hhNGlCckk1M3RyT211Z3ZMVmZGVkc0K05SUGcxN0lEaXJDRUI2ejhTWWhl?=
 =?utf-8?B?UUhJWDJkb1JFWTh6bXpJbUhQSHIwVGs2MnpvRzI2ZFZXclAvQWNrVXFpSmh2?=
 =?utf-8?B?REo5eFRKWW5xSkl4TGZJeHBSZlR2KzhZNkpXNFZTYUpFVjRxa1RPdUtaYTlr?=
 =?utf-8?B?ZmxLKy9iNlc4eE5SUnhqVjJKOSttV1dmYXBXUUYwTzRuQmlvZVFEQlQrQ1dU?=
 =?utf-8?B?UzYyVjFESkszS09MRzJUWk91VmlXbHI3dkdpR0M3Z2I4RXM3YVd3V2JtbElq?=
 =?utf-8?B?cHZIeWxNcnBqbGJBQ1VxMDR2NW9McDVsVW9hdUFDYXlVT2g3eUZJTUN6Z2lW?=
 =?utf-8?B?SWcrdXEvRmVmcS9hRHM2dWgzMDlLaTc3bmJCLzc0c1J5enl5WTFYRk1LcDNV?=
 =?utf-8?B?ekN4VEpVbUtWelFvSUJPcVJ3ay94SHFRRm8vN3J2UWhvbkZ3RGc1NnE0dDUz?=
 =?utf-8?B?U2ZWc3plQnJMNVZlTWlCTm5SRVU3VlJVZ051NkN0Zm1GWS9iRFdaVjAzVDBM?=
 =?utf-8?B?WkdwaCsyeG1USUhMNjA5cnhaaUJKR3ZscmE2NDRWK2xWeGJMamhsQTVVKzQ3?=
 =?utf-8?B?bmZLZGtVZHZlMnA2Sktsd0NZUXQxbE11MDg4TEpodmk1MW9WK3NSbnhFRUR4?=
 =?utf-8?B?STNNVTUvUElpMmc3eUgvaUZZeTJBVEphUW45dnVPdWZ5dno4NHdSQnU5RENT?=
 =?utf-8?B?bVVIcDkyK1YzTERkc1BJUG9HZXFvUnY3Mld1bWJNYkF4Zk95NlpadTgxNGt1?=
 =?utf-8?B?K0YvTlNjdjNDZ0kxYU5oMks3NytqdS9QenFQY0ZOWjZRR2p4NWRKYkt6Rms2?=
 =?utf-8?B?MEQ0TmdWTjhCd01DUGV0K0JYcjhQUnlZN1FTMFdzWDltOUZCelFPSWNuRklR?=
 =?utf-8?B?Qm1lTGVnSlo1ZG9PbE5vTU9DOC9XS055dkdwVllCaFRBWW55UUNFeE5kL3Zp?=
 =?utf-8?Q?Hh6E=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6253c5e5-ed56-4b94-89fe-08de1156dc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 10:36:28.9964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbeaTlq8qL1RApifZwX2DzO6S32+hH+Nhje/DRjH66M96iiOCY69CEAoAYEbUnJz72xxD47qNFQIHaZqnM50Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFuaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBtYW5p
QGtlcm5lbC5vcmcgPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDIyLCAyMDI1IDQ6MDIgUE0NCj4gVG86IEhhdmFsaWdlLCBUaGlwcGVzd2FteSA8dGhpcHBlc3dh
bXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gQ2M6IFN0ZWZhbiBSb2VzZSA8c3RlZmFuLnJvZXNlQG1h
aWxib3gub3JnPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgQmFuZGks
IFJhdmkgS3VtYXIgPHJhdmliQGFtYXpvbi5jb20+Ow0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGt3aWxj
enluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbA0KPiA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3Jn
OyBTZWFuIEFuZGVyc29uDQo+IDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2Ml0gUENJOiB4aWxpbngteGRtYTogRW5hYmxlIElOVHggaW50ZXJydXB0cw0K
Pg0KPiBPbiBXZWQsIE9jdCAyMiwgMjAyNSBhdCAxMDowODo0NEFNICswMDAwLCBIYXZhbGlnZSwg
VGhpcHBlc3dhbXkgd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+IEhpIFN0ZWZhbiwNCj4gPg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFN0ZWZhbiBSb2VzZSA8c3Rl
ZmFuLnJvZXNlQG1haWxib3gub3JnPg0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIy
LCAyMDI1IDM6MjkgUE0NCj4gPiA+IFRvOiBtYW5pQGtlcm5lbC5vcmcNCj4gPiA+IENjOiBCam9y
biBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBCYW5kaSwgUmF2aSBLdW1hcg0KPiA+ID4g
PHJhdmliQGFtYXpvbi5jb20+OyBIYXZhbGlnZSwgVGhpcHBlc3dhbXkNCj4gPiA+IDx0aGlwcGVz
d2FteS5oYXZhbGlnZUBhbWQuY29tPjsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiA+ID4gYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGt3aWxj
enluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbA0KPiA+ID4g
PG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXgtYXJtLSBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc7IFNlYW4gQW5kZXJzb24NCj4gPiA+IDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4N
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogeGlsaW54LXhkbWE6IEVuYWJsZSBJ
TlR4IGludGVycnVwdHMNCj4gPiA+DQo+ID4gPiBPbiAxMC8yMi8yNSAxMTo1NSwgbWFuaUBrZXJu
ZWwub3JnIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIE9jdCAyMiwgMjAyNSBhdCAwODo1OToxOUFN
ICswMjAwLCBTdGVmYW4gUm9lc2Ugd3JvdGU6DQo+ID4gPiA+PiBIaSBCam9ybiwNCj4gPiA+ID4+
IEhpIFJhdmksDQo+ID4gPiA+Pg0KPiA+ID4gPj4gT24gMTAvMjEvMjUgMjM6MjgsIEJqb3JuIEhl
bGdhYXMgd3JvdGU6DQo+ID4gPiA+Pj4gT24gVHVlLCBPY3QgMjEsIDIwMjUgYXQgMDg6NTU6NDFQ
TSArMDAwMCwgQmFuZGksIFJhdmkgS3VtYXIgd3JvdGU6DQo+ID4gPiA+Pj4+PiBPbiBUdWUsIE9j
dCAyMSwgMjAyNSBhdCAwNTo0NjoxN1BNICswMDAwLCBCYW5kaSwgUmF2aSBLdW1hcg0KPiB3cm90
ZToNCj4gPiA+ID4+Pj4+Pj4gT24gT2N0IDIxLCAyMDI1LCBhdCAxMDoyM+KAr0FNLCBCam9ybiBI
ZWxnYWFzDQo+ID4gPiA+Pj4+Pj4+IDxoZWxnYWFzQGtlcm5lbC5vcmc+DQo+ID4gPiB3cm90ZToN
Cj4gPiA+ID4+Pj4+Pj4gT24gU2F0LCBTZXAgMjAsIDIwMjUgYXQgMTA6NTI6MzJQTSArMDAwMCwg
UmF2aSBLdW1hciBCYW5kaQ0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+Pj4+Pj4+PiBUaGUgcGNpZS14
aWxpbngtZG1hLXBsIGRyaXZlciBkb2VzIG5vdCBlbmFibGUgSU5UeA0KPiA+ID4gPj4+Pj4+Pj4g
aW50ZXJydXB0cyBhZnRlciBpbml0aWFsaXppbmcgdGhlIHBvcnQsIHByZXZlbnRpbmcgSU5UeA0K
PiA+ID4gPj4+Pj4+Pj4gaW50ZXJydXB0cyBmcm9tIFBDSWUgZW5kcG9pbnRzIGZyb20gZmxvd2lu
ZyB0aHJvdWdoIHRoZQ0KPiA+ID4gPj4+Pj4+Pj4gWGlsaW54IFhETUEgcm9vdCBwb3J0IGJyaWRn
ZS4gVGhpcyBpc3N1ZSBhZmZlY3RzIGtlcm5lbCA2LjYuMCBhbmQNCj4gbGF0ZXIgdmVyc2lvbnMu
DQo+ID4gPiA+Pj4+Pj4+Pg0KPiA+ID4gPj4+Pj4+Pj4gVGhpcyBwYXRjaCBhbGxvd3MgSU5UeCBp
bnRlcnJ1cHRzIGdlbmVyYXRlZCBieSBQQ0llDQo+ID4gPiA+Pj4+Pj4+PiBlbmRwb2ludHMgdG8g
ZmxvdyB0aHJvdWdoIHRoZSByb290IHBvcnQuIFRlc3RlZCB0aGUgZml4IG9uDQo+ID4gPiA+Pj4+
Pj4+PiBhIGJvYXJkIHdpdGggdHdvIGVuZHBvaW50cyBnZW5lcmF0aW5nIElOVHggaW50ZXJydXB0
cy4NCj4gPiA+ID4+Pj4+Pj4+IEludGVycnVwdHMgYXJlIHByb3Blcmx5IGRldGVjdGVkIGFuZCBz
ZXJ2aWNlZC4gVGhlDQo+ID4gPiA+Pj4+Pj4+PiAvcHJvYy9pbnRlcnJ1cHRzIG91dHB1dA0KPiA+
ID4gPj4+Pj4+Pj4gc2hvd3M6DQo+ID4gPiA+Pj4+Pj4+Pg0KPiA+ID4gPj4+Pj4+Pj4gWy4uLl0N
Cj4gPiA+ID4+Pj4+Pj4+IDMyOiAgICAgICAgMzIwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVu
dCAgMTYgTGV2ZWwgICAgIDQwMDAwMDAwMC5heGktDQo+IHBjaWUsDQo+ID4gPiBhemRydg0KPiA+
ID4gPj4+Pj4+Pj4gNTI6ICAgICAgICA0NzAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAx
NiBMZXZlbCAgICAgNTAwMDAwMDAwLmF4aS0NCj4gcGNpZSwNCj4gPiA+IGF6ZHJ2DQo+ID4gPiA+
Pj4+Pj4+PiBbLi4uXQ0KPiA+ID4gPj4NCj4gPiA+ID4+IEZpcnN0IGEgY29tbWVudCBvbiB0aGlz
IElSUSBsb2dnaW5nOg0KPiA+ID4gPj4NCj4gPiA+ID4+IFRoZXNlIGxpbmVzIGRvIE5PVCByZWZl
ciB0byB0aGUgSU5UeCBJUlEocykgYnV0IHRoZSBjb250cm9sbGVyDQo+ID4gPiA+PiBpbnRlcm5h
bCAiZXZlbnRzIiAoZXJyb3JzIGV0YykuIFBsZWFzZSBzZWUgdGhpcyBsb2cgZm9yIElOVHggb24N
Cj4gPiA+ID4+IG15IFZlcnNhbCBwbGF0Zm9ybSB3aXRoIHBjaV9pcnFkX2ludHhfeGxhdGUgYWRk
ZWQ6DQo+ID4gPiA+Pg0KPiA+ID4gPj4gICAyNDogICAgICAgICAgMCAgICAgICAgICAwICBwbF9k
bWE6UkMtRXZlbnQgICAwIExldmVsICAgICBMSU5LX0RPV04NCj4gPiA+ID4+ICAgMjU6ICAgICAg
ICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAgMyBMZXZlbCAgICAgSE9UX1JFU0VU
DQo+ID4gPiA+PiAgIDI2OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAg
IDggTGV2ZWwgICAgIENGR19USU1FT1VUDQo+ID4gPiA+PiAgIDI3OiAgICAgICAgICAwICAgICAg
ICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgIDkgTGV2ZWwgICAgIENPUlJFQ1RBQkxFDQo+ID4gPiA+
PiAgIDI4OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTAgTGV2ZWwg
ICAgIE5PTkZBVEFMDQo+ID4gPiA+PiAgIDI5OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2Rt
YTpSQy1FdmVudCAgMTEgTGV2ZWwgICAgIEZBVEFMDQo+ID4gPiA+PiAgIDMwOiAgICAgICAgICAw
ICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjAgTGV2ZWwgICAgIFNMVl9VTlNVUFANCj4g
PiA+ID4+ICAgMzE6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAyMSBM
ZXZlbCAgICAgU0xWX1VORVhQDQo+ID4gPiA+PiAgIDMyOiAgICAgICAgICAwICAgICAgICAgIDAg
IHBsX2RtYTpSQy1FdmVudCAgMjIgTGV2ZWwgICAgIFNMVl9DT01QTA0KPiA+ID4gPj4gICAzMzog
ICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgIDIzIExldmVsICAgICBTTFZf
RVJSUA0KPiA+ID4gPj4gICAzNDogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZl
bnQgIDI0IExldmVsICAgICBTTFZfQ01QQUJUDQo+ID4gPiA+PiAgIDM1OiAgICAgICAgICAwICAg
ICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjUgTGV2ZWwgICAgIFNMVl9JTExCVVINCj4gPiA+
ID4+ICAgMzY6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAyNiBMZXZl
bCAgICAgTVNUX0RFQ0VSUg0KPiA+ID4gPj4gICAzNzogICAgICAgICAgMCAgICAgICAgICAwICBw
bF9kbWE6UkMtRXZlbnQgIDI3IExldmVsICAgICBNU1RfU0xWRVJSDQo+ID4gPiA+PiAgIDM4OiAg
ICAgICAgIDk0ICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2ZWwgICAgIDg0MDAw
MDAwLmF4aS1wY2llDQo+ID4gPiA+PiAgIDM5OiAgICAgICAgIDk0ICAgICAgICAgIDAgIHBsX2Rt
YTpJTlR4ICAgMCBMZXZlbCAgICAgbnZtZTBxMCwgbnZtZTBxMQ0KPiA+ID4gPj4NCj4gPiA+ID4+
IFRoZSBsYXN0IGxpbmUgc2hvd3MgdGhlIElOVHggSVJRcyBoZXJlICgncGxfZG1hOklOVHgnIHZz
DQo+ID4gPiA+PiAncGxfZG1hOlJDLSBFdmVudCcpLg0KPiA+ID4gPj4NCj4gPiA+ID4+IE1vcmUg
YmVsb3cuLi4NCj4gPiA+ID4+DQo+ID4gPiA+Pj4+Pj4+Pg0KPiA+ID4gPj4+Pj4+Pj4gQ2hhbmdl
cyBzaW5jZSB2MTo6DQo+ID4gPiA+Pj4+Pj4+PiAtIEZpeGVkIGNvbW1pdCBtZXNzYWdlIHBlciBy
ZXZpZXdlcidzIGNvbW1lbnRzDQo+ID4gPiA+Pj4+Pj4+Pg0KPiA+ID4gPj4+Pj4+Pj4gRml4ZXM6
IDhkNzg2MTQ5ZDc4YyAoIlBDSTogeGlsaW54LXhkbWE6IEFkZCBYaWxpbnggWERNQQ0KPiA+ID4g
Pj4+Pj4+Pj4gUm9vdCBQb3J0IGRyaXZlciIpDQo+ID4gPiA+Pj4+Pj4+PiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiA+ID4gPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUmF2aSBLdW1hciBC
YW5kaSA8cmF2aWJAYW1hem9uLmNvbT4NCj4gPiA+ID4+Pj4+Pj4NCj4gPiA+ID4+Pj4+Pj4gSGkg
UmF2aSwgb2J2aW91c2x5IHlvdSB0ZXN0ZWQgdGhpcywgYnV0IEkgZG9uJ3Qga25vdyBob3cgdG8N
Cj4gPiA+ID4+Pj4+Pj4gcmVjb25jaWxlIHRoaXMgd2l0aCBTdGVmYW4ncyBJTlR4IGZpeCBhdA0K
PiA+ID4gPj4+Pj4+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUxMDIxMTU0MzIyLjk3
MzY0MC0xLQ0KPiA+ID4gc3RlZmFuLnJvZXNlQG0NCj4gPiA+ID4+Pj4+Pj4gYWlsYm94Lm9yZw0K
PiA+ID4gPj4+Pj4+Pg0KPiA+ID4gPj4+Pj4+PiBEb2VzIFN0ZWZhbidzIGZpeCBuZWVkIHRvIGJl
IHNxdWFzaGVkIGludG8gdGhpcyBwYXRjaD8NCj4gPiA+ID4+Pj4+Pg0KPiA+ID4gPj4+Pj4+IFN1
cmUsIHdlIGNhbiBzcXVhc2ggU3RlZmFu4oCZcyBmaXggaW50byB0aGlzLg0KPiA+ID4gPj4+Pj4N
Cj4gPiA+ID4+Pj4+IEkga25vdyB3ZSAqY2FuKiBzcXVhc2ggdGhlbS4NCj4gPiA+ID4+Pj4+DQo+
ID4gPiA+Pj4+PiBJIHdhbnQgdG8ga25vdyB3aHkgdGhpbmdzIHdvcmtlZCBmb3IgeW91IGFuZCBT
dGVmYW4gd2hlbiB0aGV5DQo+ID4gPiA+Pj4+PiAqd2VyZW4ndCogc3F1YXNoZWQ6DQo+ID4gPiA+
Pj4+Pg0KPiA+ID4gPj4+Pj4gICAgLSBXaHkgZGlkIElOVHggd29yayBmb3IgeW91IGV2ZW4gd2l0
aG91dCBTdGVmYW4ncyBwYXRjaC4gIERpZCB5b3UNCj4gPiA+ID4+Pj4+ICAgICAgZ2V0IElOVHgg
aW50ZXJydXB0cyBidXQgbm90IHRoZSByaWdodCBvbmVzLCBlLmcuLCBkaWQgdGhlIGRldmljZQ0K
PiA+ID4gPj4+Pj4gICAgICBzaWduYWwgSU5UQSBidXQgaXQgd2FzIHJlY2VpdmVkIGFzIElOVEI/
DQo+ID4gPiA+Pj4+DQo+ID4gPiA+Pj4+IEkgc2F3IHRoYXQgaW50ZXJydXB0cyB3ZXJlIGJlaW5n
IGdlbmVyYXRlZCBieSB0aGUgZW5kcG9pbnQNCj4gPiA+ID4+Pj4gZGV2aWNlLCBidXQgSSBkaWRu
4oCZdCBzcGVjaWZpY2FsbHkgY2hlY2sgaWYgdGhleSB3ZXJlIGNvcnJlY3RseQ0KPiA+ID4gPj4+
PiB0cmFuc2xhdGVkIGluIHRoZSBjb250cm9sbGVyLiBJIG5vdGljZWQgdGhhdCB0aGUgbmV3IGRy
aXZlcg0KPiA+ID4gPj4+PiB3YXNuJ3QgZXhwbGljaXRseSBlbmFibGluZyB0aGUgaW50ZXJydXB0
cywgc28gbXkgZmlyc3QgYXBwcm9hY2gNCj4gPiA+ID4+Pj4gd2FzIHRvIGVuYWJsZSB0aGVtLCB3
aGljaCBoZWxwZWQgdGhlIGludGVycnVwdHMgZmxvdyB0aHJvdWdoLg0KPiA+ID4gPj4+DQo+ID4g
PiA+Pj4gT0ssIEknbGwgYXNzdW1lIHRoZSBpbnRlcnJ1cHRzIGhhcHBlbmVkIGJ1dCB0aGUgZHJp
dmVyIG1pZ2h0IG5vdA0KPiA+ID4gPj4+IGhhdmUgYmVlbiBhYmxlIHRvIGhhbmRsZSB0aGVtIGNv
cnJlY3RseSwgZS5nLiwgaXQgd2FzIHByZXBhcmVkDQo+ID4gPiA+Pj4gZm9yIElOVEEgYnV0IGdv
dCBJTlRCIG9yIHNpbWlsYXIuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+Pj4+ICAgIC0gV2h5IGRpZCBT
dGVmYW4ncyBwYXRjaCB3b3JrIGZvciBoaW0gZXZlbiB3aXRob3V0IHlvdXIgcGF0Y2guDQo+IEhv
dw0KPiA+ID4gPj4+Pj4gICAgICBjb3VsZCBTdGVmYW4ncyBJTlR4IHdvcmsgd2l0aG91dCB0aGUg
Q1NSIHdyaXRlcyB0byBlbmFibGUNCj4gPiA+ID4+Pj4+ICAgICAgaW50ZXJydXB0cz8NCj4gPiA+
ID4+Pj4NCj4gPiA+ID4+Pj4gSSdtIG5vdCBlbnRpcmVseSBzdXJlIGlmIHRoZXJlIGFyZSBhbnkg
b3RoZXIgZGVwZW5kZW5jaWVzIGluDQo+ID4gPiA+Pj4+IHRoZSBGUEdBIGJpdHN0cmVhbS4gSSds
bCBpbnZlc3RpZ2F0ZSBmdXJ0aGVyIGFuZCBnZXQgYmFjayB0byB5b3UuDQo+ID4gPiA+Pj4NCj4g
PiA+ID4+PiBTdGVmYW4gY2xhcmlmaWVkIGluIGEgcHJpdmF0ZSBtZXNzYWdlIHRoYXQgaGUgaGFk
IGFwcGxpZWQgeW91cg0KPiA+ID4gPj4+IHBhdGNoIGZpcnN0LCBzbyB0aGlzIG15c3RlcnkgaXMg
c29sdmVkLg0KPiA+ID4gPj4NCj4gPiA+ID4+IFllcy4gSSBhcHBsaWVkIFJhdmkncyBwYXRjaCBm
aXJzdCBhbmQgc3RpbGwgZ290IG5vIElOVHggZGVsaXZlcmVkDQo+ID4gPiA+PiB0byB0aGUgbnZt
ZSBkcml2ZXIuIFRoYXQncyB3aGF0IG1lIHRyaWdnZXJlZCB0byBkaWcgZGVlcGVyIGhlcmUNCj4g
PiA+ID4+IGFuZCByZXN1bHRlZCBpbiB0aGlzIHYyIHBhdGNoIHdpdGggcGNpX2lycWRfaW50eF94
bGF0ZSBhZGRlZC4NCj4gPiA+ID4+DQo+ID4gPiA+PiBCVFc6DQo+ID4gPiA+PiBJIHJlLXRlc3Rl
ZCBqdXN0IG5vdyB3L28gUmF2aSdzIHBhdGNoIGFuZCB0aGUgSU5UeCB3b3JrZWQuIFN0aWxsDQo+
ID4gPiA+PiBJIHRoaW5rIFJhdmkncyBwYXRjaCBpcyB2YWxpZCBhbmQgc2hvdWxkIGJlIGFwcGxp
ZWQuLi4NCj4gPiA+ID4NCj4gPiA+ID4gSG93IGNvbWUgSU5UeCBpcyB3b3JraW5nIHdpdGhvdXQg
dGhlIHBhdGNoIGZyb20gUmF2aSB3aGljaCBlbmFibGVkDQo+ID4gPiA+IElOVHggcm91dGluZyBp
biB0aGUgY29udHJvbGxlcj8gV2FzIGl0IGVuYWJsZWQgYnkgZGVmYXVsdCBpbiB0aGUgaGFyZHdh
cmU/DQo+ID4gPg0KPiA+ID4gWWVzLCB0aGlzIGlzIG15IGJlc3QgZ3Vlc3MgcmlnaHQgbm93LiBJ
IGNvdWxkIGRvdWJsZS1jaGVjayBoZXJlLCBidXQNCj4gPiA+IElNSE8gaXQgbWFrZXMgc2Vuc2Ug
dG8gZW5hYmxlIGl0ICJtYW51YWxseSIgYXMgZG9uZSB3aXRoIFJhdmkncw0KPiA+ID4gcGF0Y2gg
dG8gbm90IHJlbHkgb24gdGhpcyBkZWZhdWx0IHNldHVwIGF0IGFsbC4NCj4gPiBIYXJkd2FyZSBk
b2Vzbid0IGVuYWJsZSB0aGlzIGJpdHMgYnkgZGVmYXVsdCwgSU5UeCBkaWRuJ3Qgd29yayBzaW5j
ZSB0aGVyZSBpcyBhDQo+IG1pc3MgbWF0Y2ggaW4gdGhlIERUIHByb3BlcnR5IHdoaWNoIGRvZXNu
J3QgcmVxdWlyZSBwY2lfaXJxZF9pbnR4X3hsYXRlLg0KPiA+DQo+ID4gaW50ZXJydXB0LW1hcCA9
IDwwIDAgMCAxICZwY2llX2ludGNfMCAwPiwNCj4gPiA8MCAwIDAgMiAmcGNpZV9pbnRjXzAgMT4s
DQo+ID4gPDAgMCAwIDMgJnBjaWVfaW50Y18wIDI+LA0KPiA+IDwwIDAgMCA0ICZwY2llX2ludGNf
MCAzPjsNCj4gPg0KPg0KPiBPay4gVGhpcyBtYWtlcyBtZSBiZWxpZXZlIHRoYXQgd2UgZG8gbm90
IG5lZWQgU3RlZmFuJ3MgcGF0Y2ggWzFdIGFuZCBuZWVkDQo+IGp1c3QgdGhpcyBwYXRjaCBmcm9t
IFJhdmkuDQo+DQo+IC0gTWFuaQ0KPg0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtcGNpLzIwMjUxMDIxMTU0MzIyLjk3MzY0MC0xLQ0KPiBzdGVmYW4ucm9lc2VAbWFpbGJveC5v
cmcvDQoNCldlIGV2ZW4gZG9u4oCZdCBuZWVkIHJhdmkgcGF0Y2gsIGFzIHdlIGhhdmUgdGVzdGVk
IHRoaXMgYXQgb3VyIGVuZCBpdCB3b3JrcyBmaW5lIGJ5IGp1c3QgdXBkYXRpbmcgaW50ZXJydXB0
LW1hcA0KUHJvcGVydHkuIFdlIG5lZWQgdG8gbm93IHVuZGVyc3RhbmQgdGhlIGRpZmZlcmVuY2Ug
aW4gZGVzaWduLg0KPg0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k
4K6+4K6a4K6/4K614K6u4K+NDQo=

