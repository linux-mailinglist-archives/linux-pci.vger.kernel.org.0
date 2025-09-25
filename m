Return-Path: <linux-pci+bounces-36930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02061B9DA4D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 08:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 423FC7B4B37
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB842E9749;
	Thu, 25 Sep 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="dy7gj5s/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958D2A1CA
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781947; cv=fail; b=f2oWxpCxM9SONfQHjDSsXvv5ckNJesrjLfrhb41/Vov42rnVVEMOF7xj8RWuVpXT7yztkD+k4f36WIE/8jdPo5du5VT2KmnDZGUdfzTWXV/e6TTlmbJVmSf8dDX/QZpEeGFWizTc7kDAvq2vuLv1htOMX00nbqHU9PewS8/y0js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781947; c=relaxed/simple;
	bh=L5OwMpq6y8Wz5UIvhAmJLlYhdLoOnun/SNk2ZtAF/CQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CwF8TPzxMsCNErb8N6PgksTLp9itbcf3h29b7t6vUWdtjdOUKuBz6sDjHCgIcFk0dlh7l6gDZKBiLWa2FvMLSUHthiU5fuUAe/r2+JJrH7gyWRpuaLS5x85ue8lIvQnalDIPWChFkCZ2whiTZBTlCbKIQMJ5seSFs763IAvNw6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=dy7gj5s/; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58P3o2rB3207170;
	Thu, 25 Sep 2025 06:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=L5OwMpq6y8Wz5UIvhAmJLlYhdLoOnun/SNk2ZtAF/CQ=; b=
	dy7gj5s/BfHtCRGJHKAGRI9R07MD+8guP6I+nnVrqc4Ej3P42Mr2dCsVu+3D7bcq
	B/5MqtUc+SWitHBr7S82OcmjfmMgvEC4P0h5vUazPpKh5VGVltwcmqEtmPvjCTOT
	zazBPCwvKXJCZIjFmlQCmtbudo66HBsnhDNulOkT1YMy4xsGEUuFrJyHnJzFY6rK
	8F7TrFbG4knNg67BEKm+6OEywhWB90yXbCrYfNeS958e+q+/pHQnK6B5Xnimz01d
	Je7lo8zbYbWzCH+AFjhIpDTlDv5FaNxNjvZpCSaaKFwZV2f3EXsHfJZd33WZjRRs
	LY58trTvXqQrI190G4jM6A==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499hg1nyvr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 06:31:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7kpsb4rRlYlQ+QAdqM8TWUm/AztGtqK4c/0vdluFUMZ5FxMD98JK5g/3DoGr6mzshro8+eY2HMkIHk9DRnPpc8wKkm/UP+uWOr5uq6wTuhCdZEDnT4T6/PkMSgMPwDXMSe1sDPGpRJCrCBebF0z1hEuBGfYoaYrONGkU+xVU6XNK/+tFncmAjo2/teCkYR28bUb/wBEYSPZ3IocsoXLb7g2dEVCgZwe/QCLWed5CgAzut5fqYEoyTJ6um0Zbdh7y8ztTc6P1dnDCnYNhhAf7hgH/Svd58EjPB7CGplsl7+JHc8RbJg2rWDXBU1haFt/digKGPwfcy5vAOo6wEIppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5OwMpq6y8Wz5UIvhAmJLlYhdLoOnun/SNk2ZtAF/CQ=;
 b=PbR8Fzd1TmisUtbIIAUMSdBwtL6yyPa5K7SqATtV1iWA97F68lOEMfeYLexhx1RvqboT0ntlxkQ7cberuOc5kmswmtFHAA00lRoXBilunbKBFTt5H7Gv2W3QbwboPoK8ePQYxHOeatW0uZaUFl5Amfnaj4BJzdjZK5VhojmsJvW1QSX8Akv8zZ93IzIduf/Mmtphv0GPKF5CC3GM6lK4ODNSCDcpZdLOyMgqoXbDDDEtQQWctD7dxNa7TiD1ZtCvR8XpOW6vYj7BT0fiDNCsuZF0EcpAHe0ERiJ1q3N+H6wNqUX0YL+3bdbBbFIZPlysU+869p3K2l9RGwAOtBBIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by IA3PR11MB9038.namprd11.prod.outlook.com (2603:10b6:208:57a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 25 Sep
 2025 06:31:53 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%6]) with mapi id 15.20.9137.017; Thu, 25 Sep 2025
 06:31:53 +0000
From: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx
	<linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "Wang, Xiaolei"
	<Xiaolei.Wang@windriver.com>,
        "Bi, Peng (CN)" <Peng.Bi.CN@windriver.com>
Subject: Re: [i.MX8 PCIe] PCIe link fails after kexec
Thread-Topic: [i.MX8 PCIe] PCIe link fails after kexec
Thread-Index: AQHcLDoWCHKSsTl8kU6/ZHTMf2OTprShYyYAgAIMcfCAAAHQKQ==
Date: Thu, 25 Sep 2025 06:31:53 +0000
Message-ID:
 <CO6PR11MB55864AED6D35CE8EAB62155ACD1FA@CO6PR11MB5586.namprd11.prod.outlook.com>
References:
 <CO6PR11MB558624C238AA9C39C9C6A936CD1DA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <20250923230006.GA2086105@bhelgaas>
 <AS8PR04MB8833C1C2AA31DC32F5B37DC78C1FA@AS8PR04MB8833.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8833C1C2AA31DC32F5B37DC78C1FA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_8f6178a8-b4c1-4a71-93eb-55364c907e8d_Enabled=True;MSIP_Label_8f6178a8-b4c1-4a71-93eb-55364c907e8d_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_8f6178a8-b4c1-4a71-93eb-55364c907e8d_SetDate=2025-09-25T06:32:41.813Z;MSIP_Label_8f6178a8-b4c1-4a71-93eb-55364c907e8d_Name=PUBLIC;MSIP_Label_8f6178a8-b4c1-4a71-93eb-55364c907e8d_ContentBits=1;MSIP_Label_8f6178a8-b4c1-4a71-93eb-55364c907e8d_Method=Privileged;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5586:EE_|IA3PR11MB9038:EE_
x-ms-office365-filtering-correlation-id: 5ec320cd-5675-47b2-2392-08ddfbfd37ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?gb2312?B?NlA5SjRPQnN0Q21NYUF5SUVuZHpYcVNmY1I3ZWwzbmdITEYwc2ZhbUFRd2Vo?=
 =?gb2312?B?cHBNU2dPcXhrYklwd284OUxvdWVZSmQzaVFweGRXSTNxeUFiRVVBa0NncSs1?=
 =?gb2312?B?a3JaTGx1R1hPQXNRRU1wdnYwMHFYV3VTVTFmajBuUUNwMmJFTlM2OHBoM20x?=
 =?gb2312?B?bHRXYTZtV0FmOHcvWk9icmIrY1dwZURBY2hnbEsyc0gydzRFOG01eUNzMzZz?=
 =?gb2312?B?LzRuUUhsV1hEOGwzWFpnWEgvb0RvTEJTZEFFaEd3cGZmTS8vZjFRZUxzajV6?=
 =?gb2312?B?eVo3OVFsOEYxN3JrTDNHL1V0R09XalpCUXU1czRpLytlV1lEM1ZNamZlb282?=
 =?gb2312?B?UGllMjA2Z0V1R2Jid3FwcWVpMUplekhCb2xSbTFUSkd1OTh6TCsxTVdrMGlJ?=
 =?gb2312?B?OGJCbEQ4WHI0Z1Q1M2piODNhcTF4V21LclQ1c1E4YXRDZHpyWmRLdm42VjR2?=
 =?gb2312?B?NmIvaTFCdmxWcDVGOVlqL20vaVY4UzJYZ1ZYaU5OREphdlpsMVFHUEJ4cWNE?=
 =?gb2312?B?SHpzOWdGbmgvNC96UGlqQVRXbEk0SFpQNlRmaVYrT0JCSFB4WUpSbGdFYitK?=
 =?gb2312?B?QzkremtOb1NlejRGY2IzTkJwK0J6WTFyVmVKSlphcloxQmFRL0pqUVpJczNC?=
 =?gb2312?B?YWU4bzIyRDFBeUZ4UzQxZHZhSFdyNENOYnZxdnZZS2tGMDJqMGg3Ulp3T1ZP?=
 =?gb2312?B?NHoyN3pxZkRTUDY4YUNFazhTTmJ1RHpjVW5aa0pOcDVMd3Z1TVM1aVVqaTdM?=
 =?gb2312?B?c0lXRDIrNE41cFdYbU1RRlVpTjBMYU5iWkRkc2FiQWdJdXdqUC9WNlRpNGpW?=
 =?gb2312?B?SHo2aXpWUjRZMHQ5TFlMYUhlaTlCdjVyQkJNbzh0Y2V6VTBGaVpEbG5yWDV0?=
 =?gb2312?B?alFBME83bnBRelpRZ1JpUUY3MjFxeDk0aDJLaVNSM1lIVHc1c1lTUHhENDh4?=
 =?gb2312?B?b3BXaW5QaDhkbzd0NDVDRlBheUtzbWlaSWk1WVcrTDdiajlRY0oxMjROaXdS?=
 =?gb2312?B?MWpxbkxRaW96Z2RheDhVRitnRGZNS3JnL2hHbXFPZVN0RnlqK2JNMHpCYmR4?=
 =?gb2312?B?UWdUNVFHRTdzWVBFbmQ1UVhsaW04NGZCRHVJZ3JEN1Y1WTBiWFV3OUJEWFVn?=
 =?gb2312?B?cnNOL1BTemtMbjRLdEIxSERSZlM1OVp6cUdnQUJqd1d3MFMvWXhKMHpERDZs?=
 =?gb2312?B?TjU1TFBIaENXRmxqSkVST1MrT0NXb0VUL0tIUUhldVp3VFZaQWlNTEpLOVhk?=
 =?gb2312?B?cGRiWFFBOFIyVVNiOUppK3VYWmJnMDdmaENncnpTYVU3MS9QRnFmeExZbVhL?=
 =?gb2312?B?ZGtuUHlUN3hJc2pSNGkyamNFd2pydmQ4Rnlxd3RxZVZjZFRQZkdUQks0aGZ4?=
 =?gb2312?B?d0YwWnpZZGVBR0E0dE5LaFJTaFlVeFQ5RkU4eHhBMXNybEY0c2VTMXVlVHlP?=
 =?gb2312?B?U2U0WUZBWTdiOEpLc0VQNlAwZ21DZm0ra2ZJaWtVTER6aWtxRnlZalpETkJH?=
 =?gb2312?B?eGpLVVZLR2RxajJLWVZTNkIzdmZpOGl1eE85MkcxTHJlSGRjdzMrV1dEcHJl?=
 =?gb2312?B?Z2FGVW9wYXo0S29nQjVpc3BsN2NKRGRYdDBvRW84ZlMzOHhDN2hkZVhhUEhF?=
 =?gb2312?B?T05LcUxONTJ5UkxrT1BTS1ppOW1kTXVxakljMTZaWmpLcUpQMzUySk1IQ1ha?=
 =?gb2312?B?ZDEzSytnTStLYXRaa1RVK2RoZFhSK3ZSMy9qeS94dHJjNk5kcy8vK3IyY05T?=
 =?gb2312?B?REE4MUk3bW4rbG9vdUxSYUJKZmt4NFIrMmh0ODc1blNEQ0ExR2IxRFpZalox?=
 =?gb2312?B?Q3ZiZ0NDUzRjZzhNOTdGaEhYak5lZlIrc2tZemVDcHZsREFzejNJUXZxYytu?=
 =?gb2312?B?cGJYMjdVdWtpVmhndEozek5nWThKVExTNzBTYkF2VCsvdzhzOW1nOU9BTWpY?=
 =?gb2312?Q?NzUewDck5+g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WnE1VlRiRHFzTWJlUFh0ZUU4ajE4amlJOWhGOHpZSVRsMG80ZnhubGlMSjZD?=
 =?gb2312?B?N3YwaU5KL1dpNEs5cEw2VzhpcFk3OUlrbjJzQ1VuQ3JhM2xOemF5MTNtK3Bn?=
 =?gb2312?B?RmRWWkR1YnFiZlVydWM3dDRNN3RXczkyZlNHaVo1NEJYbnBncDk4ZkhQelhs?=
 =?gb2312?B?UHYrNnJ3ejZPVXhFaEZUWjJyVlhhNnNBM0o4cTY3NWpkVGN1d3lSSjVGQzZm?=
 =?gb2312?B?ZmNVWGQwazlScWJRci9nRWRzNlgvMWh4MUNobW42OFBIam5kMDhiUmVJOWo5?=
 =?gb2312?B?Qnkxd09MTjBPNG5GVy9ROGVBaDNUR3d5NjdYY0pXYU4yejRnODBVK1lpdnVQ?=
 =?gb2312?B?SSszVHhpTTM0OW1XTXRZdmY4c1RVeGRWS2xlZ2FwS2prcmVXRlhuRzVxaklU?=
 =?gb2312?B?RUY2SzlySFhpM1ltd21NZUhFcGR1bWwvQS80eEE4Ty9aZDUxUnlSOVA0Nk9K?=
 =?gb2312?B?bS9UaWRLTlhJK3VRTkEzUTM3NHZmRTZDQ3RvcXVzVWtxZ2RQa25tcmpLa2Vo?=
 =?gb2312?B?alJzZUJkUTA2cTEwMnYwM29UVGQxd0FFc1ZPNFVUbzdmVGNJY1JtZ2l2VW1q?=
 =?gb2312?B?ZlRyMC83clRKb1Nld0dHc2N3dC96dWdUZUJQclhzaGhGbmRYYUU5SmlRL1VV?=
 =?gb2312?B?bGQyZlJtU3kzbW5DaXNrWWtScURDMlVxSXIvdFkxd0kyZ0RaZXd2eG5FVlRl?=
 =?gb2312?B?dDZvVVpvNkVYbktCUElXM2FHNjZoQXIxelhnbG9oUFRkd0w0UUl3aUk0dnFH?=
 =?gb2312?B?aVRiQ2pYRWpZZU5FNWg4TDF6ODFYdWU2eWhEbW1DMjdSdXUvL3pDMENWS2pL?=
 =?gb2312?B?WEY1QWRsNWhlUDUydkZ3VjNIaW8vcGFaVldwbTNNcGo0WEFrb1dTckJ5UmNy?=
 =?gb2312?B?dW1vczFCbWVtWnh3cjFkb2JsUERWeFRpYlk3VHVrbytySmRBRi9zM2ZJQUlH?=
 =?gb2312?B?bXk0TUhPTzBqTUlnVlN0SDhsdEk2azk4UkhsT05iWmUzam80bFE5TSszMmhH?=
 =?gb2312?B?eWFVK0VuUEUzVU1hV1NzV3R6NzhDeFBOZy9rMVN0aXJiYzhUWVNvbnJGUHM4?=
 =?gb2312?B?NHYydnFhTzMvbHVadXdaVHlQeUg2NEFCV2pHUVZoLzNZbWdXbDJkYU5ORnZH?=
 =?gb2312?B?bnEyUklZS3NITWI5ZVk0dlc2dWxNZVZ2NGRvVnVyZnpVakhyb0EweUNPVFdU?=
 =?gb2312?B?c0xKb2FFb0czZkY5b3diUmMvcG1GZS9lZGVyVWNpVnBQZUhWOUh6b0IzNEt6?=
 =?gb2312?B?RWlXYW5hOWZ3L3dTTnE2NmhkZFhNWlFJVmhFdWlLSkV4Qnd4VEdWeEo3V1U3?=
 =?gb2312?B?LysrVFAxVEV5Z3BtSkhoVDZ2a2tqWER4bmZINTFFejgzb2ZidXgyVStvcTYz?=
 =?gb2312?B?cm1CbmdRRXZub1JVVTc3Nk40enoyZ1I0Z1B5ekNxM05xUllESGo1cjAvZC8v?=
 =?gb2312?B?eHlJbTNuZXVzbUROUTJFVHpHalV5MGF4ajBGWGdBWnAraDBxNVl6eE84bnR1?=
 =?gb2312?B?NGllQ0t0c0dmVm9UMjNtT3ZTdW1qT3NjREp4RE5xK2s3RFlRbFRGY3JmZGR4?=
 =?gb2312?B?NFNTa0c1OFhuVHFoMEtuTUxudlFodG9UME1iVnc2VU5XQXNtQ3phQ0tyc3RP?=
 =?gb2312?B?R3ovTzBXWFBNSndxZXVCMWtDYlFQc2MvN3lmMEQvVjYzSFVYQ1V4ZUpIS2tG?=
 =?gb2312?B?RkprS2NTT1hRTG5iSSs0cjBKWmhUaDVOcW1LdlNpVkNmZnQ0eURnVWNPR0dw?=
 =?gb2312?B?WkxPL3Fkb1R2VFVWc0xaZkI1ZkExRVk0VERKendDNmM2VEdIMUNYQTkrbmIw?=
 =?gb2312?B?M3Q3U3djVHNZVVR2azlhYWJjQysxZlR2a2JCQW5kWGhZanlmS0JoU3F2SnZw?=
 =?gb2312?B?VTI5dWRHdGpaaTFxRTNFOTBxMFJQUUI2R21YL01nNW5aZ1piZm13ckRrMXBW?=
 =?gb2312?B?aWRZRnNnRTgxQWZ0SjJTQSt4d3p6ekVWWFFaODVaYU1IbUtDd0JaQnl6am5U?=
 =?gb2312?B?bG8zNGlvMG9LaEpkSy9JdDRwQXYwMWdCWWpPWXM2L0EvWmFlTmlQMDl0R1JU?=
 =?gb2312?B?eG9ZYVZESkJMZlQyZVJjUHlKRVE4RkJMM2JvdDBFVmUzT21qSFZpNzVHcEt4?=
 =?gb2312?Q?MgJf2nn8714YnFTNbbNm9ZDMe?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec320cd-5675-47b2-2392-08ddfbfd37ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 06:31:53.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjpoNdQJrK5EOP3JIu7Va31SiKKrxalGCLAeXeoipSm2IR3mpNVbNYhGogJzEl6iw/haGET5OvFlQuYcUa0pB6T796jcuKNnrTHuVO4BkLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9038
X-Proofpoint-GUID: bbFGDahHjJrKO4DUbUBPnUZq0qoM4Wwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA2MCBTYWx0ZWRfX+QtGvYIPvK9A
 UfuTmRzS0h3xENzr4my3JW1r222zo4yb6wZeSvpms3we8UDTKCM6fJOrp0xbTq0uzzCdH6VcpPp
 rA/ZdQpLEtUs8eLWWjGR7srGY7ugw3DCeV7ZyQUgtmbyRPT/tdUmK1Yea9334ajc0mwFa659Gyj
 wDUo3CngtRh1jd7jmxfMGc+H0CWlhgQ3aIk3fLJKOUzvMhplDMmS4Ik5fXbkz+VFUq8HPKDl/tm
 twYDKTMcD6E4xPjaJwFI2G9wMRa+KjrLlPH8Gvlz8UWlgqSTmn2YXNSTk8wan1SlK8cSEVEkOtR
 GwZIAgyfkYxw5EfFRMK+d88QjqQnu98Q6vcaCpQLgKqFDVtB6JztMihLnEWMOw=
X-Authority-Analysis: v=2.4 cv=Yfi95xRf c=1 sm=1 tr=0 ts=68d4e1dc cx=c_pps
 a=3EeCZaq8L1ZepF5DamB/SA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=_l4uJm6h9gAA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=JfrnYn6hAAAA:8
 a=t7CeM3EgAAAA:8 a=NufY4J3AAAAA:8 a=1XWaLZrsAAAA:8 a=scgZtQAgwulBoYZdEN4A:9
 a=mFyHDrcPJccA:10 a=ST-jHhOKWsTCqRlWije3:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=TPcZfFuj8SYsoCJAFAiX:22
X-Proofpoint-ORIG-GUID: bbFGDahHjJrKO4DUbUBPnUZq0qoM4Wwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1011 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

UmljaGFyZCBhbmQgQmpvcm46DQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHJlc3BvbnNl
IGFuZCBlbnRodXNpYXN0aWMgaGVscC4NCg0KVGhlIGlzc3VlIGlzIHN0aWxsIGV4aXN0IG9uIDYu
MTYsIGJ1dCBJbiA2LjE3LCBmcm9tIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29tbWl0Lz9pZD0wYmQwYTQxYTUxMjBmNzg2
ODVhMTMyODM0ODY1YjBhNjMxYjkwMjZhDQp0aGUgaXNzdWUgaXMgZGlzYXBwZWFyZWQuIEkgaGF2
ZSB0cmllZCB0byB1c2UgZ2l0IGJpc2VjdCB0byBmaW5kIHRoZSBjb21taXQgYW5kIGZpbmQgYSBj
b21taXQgb2YgImQzMWViMjE3NDI1NSBQQ0k6IGlteDY6IFJlbW92ZSBhcHBzX3Jlc2V0IHRvZ2ds
aW5nIGZyb20gaW14X3BjaWVfe2Fzc2VydC9kZWFzc2VydH1fY29yZV9yZXNldKGwLg0KSW4gZmFj
dCwgSSBhcHBsaWVkIHRoZSBwYXRjaCB3aGljaCBjcmVhdGVkIGZyb20gZDMxZWIyMTc0MjU1IHRv
IHNvbWV3aGVyZSBvZiA2LjE3LCBpdCB3b3Jrcy4gQnV0IGFwcGxpZWQgdG8gNi4xNiwgaXQgbm90
IHdvcmtzLCBsZXQgYWxvbmUgNi42Lg0KU28gSSBzdXNwZWN0IHRoZSBjb21taXQgdGhhdCBmaXhl
ZCB0aGlzIGlzc3VlIHdhcyBhIGNvbWJpbmF0aW9uIG9mIG11bHRpcGxlIGNvbW1pdHMuDQoNCkkg
d2lsbCBjb21wYXJlIHRoZSBkaWZmZXJlbmNlcyBhbmQgdHJ5IHRvIGlkZW50aWZ5IHdoZXJlIHRo
ZSBpc3N1ZSBsaWVzLg0KDQpHdW9jYWkNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KRnJvbTogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NClNl
bnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjUsIDIwMjUgMjoxOSBQTQ0KVG86IEJqb3JuIEhlbGdh
YXM7IEhlLCBHdW9jYWkgKENOKQ0KQ2M6IEx1Y2FzIFN0YWNoOyBMb3JlbnpvIFBpZXJhbGlzaTsg
S3J6eXN6dG9mIFdpbGN6eai9c2tpOyBSb2IgSGVycmluZzsgQmpvcm4gSGVsZ2FhczsgU2hhd24g
R3VvOyBTYXNjaGEgSGF1ZXI7IFBoaWxpcHAgWmFiZWw7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZGwtbGludXgtaW14OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IFdhbmcsIFhpYW9sZWkNClN1YmplY3Q6IFJFOiBbaS5NWDgg
UENJZV0gUENJZSBsaW5rIGZhaWxzIGFmdGVyIGtleGVjDQoNCkNBVVRJT046IFRoaXMgZW1haWwg
Y29tZXMgZnJvbSBhIG5vbiBXaW5kIFJpdmVyIGVtYWlsIGFjY291bnQhDQpEbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVy
IGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCkhpIEd1b2NhaToNCkkgdHJpZWQgdGhl
IEw2LjE3LXJjMSBvbiBpLk1YOFFNIE1FSyBib2FyZC4NCk5vIHN1Y2gga2luZCBvZiBwcm9ibGVt
Lg0KDQpIZXJlIGFyZSB0aGUgbG9nczoNCnJvb3RAaW14OHFtbWVrOn4jIGtleGVjIC9ydW4vbWVk
aWEvYm9vdC1tbWNibGsxcDEvSW1hZ2UgLS1kdGI9L3J1bi9tZWRpYS9ib290LW1tY2JsazFwMS9p
bXg4cW0tbWVrLmR0YiAtLWNvbW1hbmQtbGluZT0iY29uc29sZT10dHlMUDAsMTE1MjAwIGVhcmx5
Y29uIG5vX2NvbnNvbGVfc3VzcGVuZCByb290PS9kZXYvbW1jYmxrMXAyIHJvb3R3YWl0IHJ3Ig0K
cm9vdEBpbXg4cW1tZWs6fiMgICAgICAgICAgU3RvcHBpbmcgU2Vzc2lvbiBjNiBvZiBVc2VyIHJv
b3QuLi4NClsgIE9LICBdIFJlbW92ZWQgc2xpY2UgU2xpY2UgL3N5c3RlbS9tb2Rwcm9iZS4NClsg
IE9LICBdIFN0b3BwZWQgdGFyZ2V0IEdyYXBoaWNhbCBJbnRlcmZhY2UuDQpbICBPSyAgXSBTdG9w
cGVkIHRhcmdldCBNdWx0aS1Vc2VyIFN5c3RlbS4NCi4uLg0KWyAgIDI4LjY5MzQyNl0ga2V4ZWNf
Y29yZTogU3RhcnRpbmcgbmV3IGtlcm5lbA0KWyAgIDI4Ljc0NDM1OF0gcHNjaTogQ1BVMSBraWxs
ZWQgKHBvbGxlZCAwIG1zKQ0KWyAgIDI4Ljc3NjM2Ml0gcHNjaTogQ1BVMiBraWxsZWQgKHBvbGxl
ZCAwIG1zKQ0KWyAgIDI4Ljc5MTk5Nl0gcHNjaTogQ1BVMyBraWxsZWQgKHBvbGxlZCAwIG1zKQ0K
WyAgIDI4Ljc5NzE1MV0gQnllIQ0KWyAgICAwLjAwMDAwMF0gQm9vdGluZyBMaW51eCBvbiBwaHlz
aWNhbCBDUFUgMHgwMDAwMDAwMDAwIFsweDQxMGZkMDM0XQ0KLi4uDQpbICAgIDIuNDMyNDk1XSBj
bGs6IERpc2FibGluZyB1bnVzZWQgY2xvY2tzDQpbICAgIDIuNDQzMzYwXSBjaGVjayBhY2Nlc3Mg
Zm9yIHJkaW5pdD0vaW5pdCBmYWlsZWQ6IC0yLCBpZ25vcmluZw0KWyAgICAyLjYyOTMxOV0gaW14
NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBpQVRVOiB1bnJvbGwgRiwgNiBvYiwgNiBpYiwgYWxpZ24g
NEssIGxpbWl0IDRHDQpbICAgIDIuNjM3MTM0XSBpbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6IElu
dmFsaWQgZURNQSBJUlFzIGZvdW5kDQpbICAgIDIuNzQ2NTQyXSBtbWMxOiBuZXcgaGlnaCBzcGVl
ZCBTREhDIGNhcmQgYXQgYWRkcmVzcyBhYWFhDQpbICAgIDIuNzUzMDQwXSBtbWNibGsxOiBtbWMx
OmFhYWEgU0ExNkcgMTQuOCBHaUINClsgICAgMi43NjE1MDhdICBtbWNibGsxOiBwMSBwMg0KWyAg
ICAyLjg0MDk3M10gaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBQQ0llIEdlbi4zIHgxIGxpbmsg
dXANClsgICAgMi44NDc3MjRdIGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUENJIGhvc3QgYnJp
ZGdlIHRvIGJ1cyAwMDAwOjAwDQpbICAgIDIuODU0MTM2XSBwY2lfYnVzIDAwMDA6MDA6IHJvb3Qg
YnVzIHJlc291cmNlIFtidXMgMDAtZmZdDQpbICAgIDIuODU5NjU5XSBwY2lfYnVzIDAwMDA6MDA6
IHJvb3QgYnVzIHJlc291cmNlIFtpbyAgMHgwMDAwLTB4ZmZmZl0NCi4uLg0KaW14OHFtbWVrIGxv
Z2luOiByb290DQpyb290QGlteDhxbW1lazp+Iw0Kcm9vdEBpbXg4cW1tZWs6fiMNCnJvb3RAaW14
OHFtbWVrOn4jIHVuYW1lIC1hDQpMaW51eCBpbXg4cW1tZWsgNi4xNy4wLXJjMSAjMyBTTVAgUFJF
RU1QVCBUaHUgU2VwIDI1IDE0OjE0OjUxIENTVCAyMDI1IGFhcmNoNjQgR05VL0xpbnV4DQpyb290
QGlteDhxbW1lazp+IyBsc3BjaQ0KMDA6MDAuMCBQQ0kgYnJpZGdlOiBGcmVlc2NhbGUgU2VtaWNv
bmR1Y3RvciBJbmMgRGV2aWNlIDAwMDAgKHJldiAwMSkNCjAxOjAwLjAgTm9uLVZvbGF0aWxlIG1l
bW9yeSBjb250cm9sbGVyOiBTaGVuemhlbiBVbmlvbm1lbW9yeSBJbmZvcm1hdGlvbiBTeXN0ZW0g
THRkLiBBTTYxMCBQQ0llIDMuMCB4MiBOVk1lIFNTRCAxMjhHQiwgMjU2R0IgKHJldiAwMSkNCg0K
DQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiBTZW50OiAy
MDI1xOo51MIyNMjVIDc6MDANCj4gVG86IEhlLCBHdW9jYWkgKENOKSA8R3VvY2FpLkhlLkNOQHdp
bmRyaXZlci5jb20+DQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsg
THVjYXMgU3RhY2gNCj4gPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+OyBMb3JlbnpvIFBpZXJhbGlz
aSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+IFdpbGN6eai9c2tpIDxrd0Bs
aW51eC5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQmpvcm4gSGVsZ2Fhcw0K
PiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47
IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBoaWxpcHAgWmFiZWwg
PHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IHhpYW9sZWkud2FuZw0KPiA8
eGlhb2xlaS53YW5nQHdpbmRyaXZlci5jb20+DQo+IFN1YmplY3Q6IFJlOiBbaS5NWDggUENJZV0g
UENJZSBsaW5rIGZhaWxzIGFmdGVyIGtleGVjDQo+DQo+IE9uIFR1ZSwgU2VwIDIzLCAyMDI1IGF0
IDAzOjM1OjU2QU0gKzAwMDAsIEhlLCBHdW9jYWkgKENOKSB3cm90ZToNCj4gPiBIaSBhbGwsDQo+
ID4NCj4gPiBXZSBhcmUgc2VlaW5nIGEgUENJZSBpc3N1ZSBvbiBpLk1YOC1iYXNlZCBib2FyZCB3
aGVuIHVzaW5nIGtleGVjIG9uDQo+ID4gTGludXgga2VybmVsIDYuNiwgIHdlIHdvdWxkIGFwcHJl
Y2lhdGUgeW91ciBoZWxwIHRvIGNsYXJpZnkgd2hldGhlcg0KPiA+IHRoaXMgaXMgYSBrbm93biBw
cm9ibGVtIG9yIGlmIHRoZXJlIGlzIGEgcmVjb21tZW5kZWQgZml4Lg0KPg0KPiBDYW4geW91IGJv
b3QgYSByZWNlbnQga2VybmVsLCBlLmcuLCB2Ni4xNiBvciB2Ni4xNy1yYzcsIHRvIG1ha2Ugc3Vy
ZSB5b3UncmUgbm90DQo+IHNlZWluZyBhbiBhbHJlYWR5LWZpeGVkIHByb2JsZW0/DQo+DQo+IElm
IHlvdSBjYW4ndCB0cnkgYSByZWNlbnQga2VybmVsLCBwbGVhc2UgaW5jbHVkZSB5b3VyIGRldmlj
ZXRyZWUgYW5kIHRoZQ0KPiBjb21wbGV0ZSBkbWVzZyBsb2cgaW5jbHVkaW5nIGJvdGggdGhlIGlu
aXRpYWwgYm9vdCBhbmQgdGhlIGtleGVjLg0KPg0KPiA+ICMjIEJvYXJkICYgU2V0dXANCj4gPiBM
aW51eCB2ZXJzaW9uIDYuNi4xMDMteW9jdG8tc3RhbmRhcmQgKG9lLXVzZXJAb2UtaG9zdCkNCj4g
PiAoYWFyY2g2NC13cnMtbGludXgtZ2NjIChHQ0MpIDEzLjQuMCwgR05VIGxkIChHTlUgQmludXRp
bHMpIDINCj4gPiAuNDIuMC4yMDI0MDcyMykgIzEgU01QIFBSRUVNUFQgV2VkIFNlcCAgMyAyMDox
MzozNSBVVEMgMjAyNQ0KPiA+DQo+ID4gTWFjaGluZSBtb2RlbDogRnJlZXNjYWxlIGkuTVg4UU0g
TUVLDQo+ID4gUENJZSBkZXZpY2U6IEludGVsIENvcnBvcmF0aW9uIFdpcmVsZXNzIDcyNjANCj4g
Pg0KPiA+DQo+ID4gIyNCb290IGZsb3c6DQo+ID4gI3N0ZXAgMTogSW5pdGlhbCBib290OiBMaW51
eCBrZXJuZWwgYm9vdCBmcm9tIHRmdHAgLg0KPiA+IHNldGVudiBpcGFkZHIgMTI4LjIyNC4xNjUu
MTIwDQo+ID4gc2V0ZW52IGdhdGV3YXlpcCAxMjguMjI0LjE2NS4xDQo+ID4gc2V0ZW52IG5ldG1h
c2sgMjU1LjI1NS4yNTUuMA0KPiA+IHNldGVudiBzZXJ2ZXJpcCAxMjguMjI0LjE2NS4yMA0KPiA+
DQo+ID4gdGZ0cCAweDhhMDAwMDAwMCB2bG0tYm9hcmRzLzI5MTA2L2tlcm5lbCB0ZnRwIDB4OGQw
MDAwMDAwDQo+ID4gdmxtLWJvYXJkcy8yOTEwNi9kdGIgYm9vdGkgMHg4YTAwMDAwMDAgLSAweDhk
MDAwMDAwMA0KPiA+DQo+ID4NCj4gPiAjc3RlcCAyOiBTd2l0Y2ggdG8gYW5vdGhlciBrZXJuZWwg
b24gZGlzayB1c2luZyBrZXhlYyBSZXByb2R1Y3Rpb24NCj4gPiBzdGVwcyByb290QG54cC1pbXg4
On4jIG1rZGlyIC9tbnQvc2Rpc2sgcm9vdEBueHAtaW14ODp+IyBtb3VudA0KPiA+IC9kZXYvbW1j
YmxrMHAxIC9tbnQvc2Rpc2svDQo+ID4gcm9vdEBueHAtaW14ODp+IyBzY3AgZ2hlLWNuQDEyOC4y
MjQuMTUzLjE1MTovZm9say9naGUtY24vaW1hZ2VzL0ltYWdlDQo+IC9tbnQvc2Rpc2sva2VybmVs
ICAgICAvL3RoZSBpbWFnZXMgaXMgdGhlIHNhbWUuDQo+ID4NCj4gPiByb290QG54cC1pbXg4On4j
IGtleGVjIC1sIC9tbnQvc2Rpc2sva2VybmVsDQo+ID4gLS1hcHBlbmQ9ImNvbnNvbGU9dHR5TFAw
LDExNTIwMCB2aWRlbz1IRE1JLUEtMToxOTIweDEwODAtMzJANjAgcncNCj4gPiByb290PSAvZGV2
L25mcw0KPiA+IG5mc3Jvb3Q9MTI4LjIyNC4xNjUuMjA6L2V4cG9ydC9weGVib290L3ZsbS1ib2Fy
ZHMvMjkxMDUvcm9vdGZzLHRjcCx2Mw0KPiA+IGlwPTEyOC4yMjQuMTY1LjEyMDoxMjguMjI0LjE2
NS4yMDoxMg0KPiA+IDguMjI0LjE2NS4xOjI1NS4yNTUuMjU1LjA6OmV0aDA6b2ZmIHNlbGludXg9
MCBlbmZvcmNpbmc9MCINCj4gPg0KPiA+IHJvb3RAbnhwLWlteDg6fiMga2V4ZWMgLWUNCj4gPg0K
PiA+DQo+ID4gI0FmdGVyIHRoZSBzZWNvbmQga2VybmVsIGJvb3RzLCB0aGUgUENJZSBsaW5rIGRv
ZXMgbm90IGNvbWUgdXAuDQo+ID4gI0tleSBsb2cgZGlmZmVyZW5jZXMNCj4gPg0KPiA+ICMjIyMj
ICBib290IChib290X2NvbGQubG9nKToNCj4gPiBpbXg2cS1wY2llIDVmMDEwMDAwLnBjaWU6IGhv
c3QgYnJpZGdlIC9idXNANWYwMDAwMDAvcGNpZUA1ZjAxMDAwMA0KPiByYW5nZXM6DQo+ID4gaW14
LWRybSBkaXNwbGF5LXN1YnN5c3RlbTogYm91bmQgaW14LWRybS1kcHUtYmxpdGVuZy4yIChvcHMN
Cj4gPiBkcHVfYmxpdGVuZ19vcHMpIGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogaG9zdCBicmlk
Z2UNCj4gL2J1c0A1ZjAwMDAwMC9wY2llQDVmMDAwMDAwIHJhbmdlczoNCj4gPiBpbXg2cS1wY2ll
IDVmMDAwMDAwLnBjaWU6ICAgICAgIElPIDB4MDA2ZmY4MDAwMC4uMHgwMDZmZjhmZmZmIC0+DQo+
IDB4MDAwMDAwMDAwMA0KPiA+IGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogICAgICBNRU0gMHgw
MDYwMDAwMDAwLi4weDAwNmZlZmZmZmYgLT4NCj4gMHgwMDYwMDAwMDAwDQo+ID4gaW14NnEtcGNp
ZSA1ZjAwMDAwMC5wY2llOiBpQVRVOiB1bnJvbGwgRiwgNiBvYiwgNiBpYiwgYWxpZ24gNEssIGxp
bWl0DQo+ID4gNEcgaW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBlRE1BOiB1bnJvbGwgRiwgMSB3
ciwgMSByZCBpbXg2cS1wY2llDQo+ID4gNWYwMDAwMDAucGNpZTogUENJZSBHZW4uMSB4MSBsaW5r
IHVwIGlteDZxLXBjaWUgNWYwMDAwMDAucGNpZTogUENJZQ0KPiA+IEdlbi4xIHgxIGxpbmsgdXAg
aW14NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiBMaW5rIHVwLCBHZW4xIGlteDZxLXBjaWUNCj4gPiA1
ZjAwMDAwMC5wY2llOiBQQ0llIEdlbi4xIHgxIGxpbmsgdXAgaW14NnEtcGNpZSA1ZjAwMDAwMC5w
Y2llOiBQQ0kNCj4gPiBob3N0IGJyaWRnZSB0byBidXMgMDAwMDowMA0KPiA+DQo+ID4gI6H6IExp
bmsgdXAgc3VjY2Vzc2Z1bGx5DQo+ID4NCj4gPiByb290QG54cC1pbXg4On4jIGxzcGNpDQo+ID4g
MDA6MDAuMCBQQ0kgYnJpZGdlOiBGcmVlc2NhbGUgU2VtaWNvbmR1Y3RvciBJbmMgRGV2aWNlIDAw
MDAgKHJldiAwMSkNCj4gPiAwMTowMC4wIE5ldHdvcmsgY29udHJvbGxlcjogSW50ZWwgQ29ycG9y
YXRpb24gV2lyZWxlc3MgNzI2MCAocmV2IDZiKQ0KPiA+IHJvb3RAbnhwLWlteDg6fiMNCj4gPg0K
PiA+DQo+ID4gIyMjIyNBZnRlciBrZXhlYyAoYm9vdF9rZXhlYy5sb2cpOg0KPiA+DQo+ID4gaW14
NnEtcGNpZSA1ZjAwMDAwMC5wY2llOiAgICAgICBJTyAweDAwNmZmODAwMDAuLjB4MDA2ZmY4ZmZm
ZiAtPg0KPiAweDAwMDAwMDAwMDANCj4gPiBpbXg2cS1wY2llIDVmMDAwMDAwLnBjaWU6IGlBVFU6
IHVucm9sbCBGLCA2IG9iLCA2IGliLCBhbGlnbiA0SywgbGltaXQNCj4gPiA0RyBpbXg2cS1wY2ll
IDVmMDAwMDAwLnBjaWU6IGVETUE6IHVucm9sbCBGLCAxIHdyLCAxIHJkDQo+ID4NCj4gPiBpbXg2
cS1wY2llIDVmMDAwMDAwLnBjaWU6IFBoeSBsaW5rIG5ldmVyIGNhbWUgdXAgaW14NnEtcGNpZQ0K
PiA+IDVmMDAwMDAwLnBjaWU6IFBoeSBsaW5rIG5ldmVyIGNhbWUgdXAgaW14NnEtcGNpZSA1ZjAw
MDAwMC5wY2llOiBQQ0kNCj4gPiBob3N0IGJyaWRnZSB0byBidXMgMDAwMDowMA0KPiA+DQo+ID4g
I6H6IExpbmsgbmV2ZXIgY29tZXMgdXAsIG5vIFBDSWUgZGV2aWNlcyBkZXRlY3RlZC4NCj4gPg0K
PiA+IHJvb3RAbnhwLWlteDg6fiMgbHNwY2kNCj4gPiAwMDowMC4wIFBDSSBicmlkZ2U6IEZyZWVz
Y2FsZSBTZW1pY29uZHVjdG9yIEluYyBEZXZpY2UgMDAwMCAocmV2IDAxKQ0KPiA+IHJvb3RAbnhw
LWlteDg6fiMNCj4gPg0KPiA+DQo+ID4gI1F1ZXN0aW9ucw0KPiA+IEFyZSB0aGVyZSBleGlzdGlu
ZyBwYXRjaGVzIG9yIHJlY29tbWVuZGVkIHdvcmthcm91bmRzIGZvciB0aGlzIHNjZW5hcmlvPw0K
PiA+IFRoYW5rcyBmb3IgeW91ciB0aW1lIGFuZCBhbnkgZ3VpZGFuY2UgeW91IGNhbiBwcm92aWRl
Lg0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+DQo+ID4gR3VvY2FpDQo=

