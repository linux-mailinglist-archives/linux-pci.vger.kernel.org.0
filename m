Return-Path: <linux-pci+bounces-7026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF23D8BA2EE
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 00:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F226C1C225A3
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 22:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C46757C8F;
	Thu,  2 May 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="NkLLjCfl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5CF57C8B;
	Thu,  2 May 2024 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714687274; cv=fail; b=B7DDXzMRuQVxiiw8GLFHjVYSXNP5vJqlAsbw22kMswAXcnUi/D2cpSJDquwSKDhFVD5CGdnZUT1RVMgaDLoj/dOfm/SaqVX4h9rtcheTTZ+03ZRCA+u/UwYCcyQX0cYeSzXpv6P6pfeaHCoevVAJgFjJjVC0QOKoAdKZSxropxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714687274; c=relaxed/simple;
	bh=RsF9KWLaM2UO6Y6WEk/KM87CO2p7x+NhMwtO/QH499o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DPFFNXmcmpGyKudCjNSRtGqvTJmp7i5MUqM51r8aQY8xT6A0pfZ4GwFgrHTdm+nHNJQr6fFS+3Ujngp/31sd6SFObdBNYEnk9hU0+a+v3wEhKzFvkUGesW96RkInxLHUzj7re6GA+mCSIkLRdAfxW2SmXm/E6OjbwReatUAe8bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=NkLLjCfl; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=Dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442Kxfi5027197;
	Thu, 2 May 2024 18:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=veQTiqSO6ZybeC+U3v5sz3A5qltk44PBMyRy2aoP1rE=;
 b=NkLLjCflf3Mvce9CmYhqCfXFFL4dnKj+odVTIsDciUj/4QMkrXzEQuMKwHe+ReZI7fcC
 QwGGF5QpUlHGODn4T7iV5zSOb8nMnMBs7cwP5qXEF4cSR6AcqL85jsvuiITnq69Y59Hs
 u+8UDA1wA/NOmmsfrPyBcmWuR3W+GxbyHbfb6F4nWNTYtYznOe8zYy/YEmw5o2Ue2DSI
 HGR362RaKPGD9/JaQnbrzhyoek+1bSij6HDz5vVZ3Ae9ZKwrNTLZNJFylstdBTUWjtDY
 zbflvS+x9/XcXskH3E21rCy3l9HErHcWr1VgHAuNoJ7WllySEZWlWOJ/AEkxagbm99qp /Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3xrux97j2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 18:01:07 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442LZb5u024421;
	Thu, 2 May 2024 18:01:07 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3xv7e72per-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 18:01:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrZTUtNOGueO+s62RAb585pTnEngm+uIwZ2AZYHrHTyf6Mn7zqky5XH+6n3NO6A26ETWmPCWRxN4HnqWCZtTIHF0SSSpdOP8jr6XFnU1jftVaxd0YGBfY7+SAJo2Ab4pmCunBsBlVS2pOW/V3SqD8zYIe7pY8avDJGFZ+7D/VY1+neXA1ULCBFNHPvOSuIIm+25dHN59qS3llnRAHV3xucUen7DXW5UOgEyAx5B4n+M4SxkcauSZ0NoZNr4mPiYIb0LYPjXNYUZzaF6zZNJhW+9Rcli4NDEm6a8REVxBbFLkBiCT6JfYcTqPMOmKHIfwLFFDY7vEdr5LTTwIMVIjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veQTiqSO6ZybeC+U3v5sz3A5qltk44PBMyRy2aoP1rE=;
 b=Yo83it98XTT0NF4C/pEUnW4nRyHclgDlUeqZ1u54WEWPEG06i3P0oeNF2oay1qZlrYocatD39smYWb/+NvFWffhpN1aT0tWVU0Dae+WmtW2amoofzMFqplBMO3AaipaLFLc402w/9QCyvY6Y0PHw+hg+NCkxl/kRc+AgtRrxqZl05CK0g1uiwca31fXSQkUu719f061R7Bs+WmHRjwP3mZLc4atQA9X2vLvVwb9srDYVBkGucEnYSk6olAf8two48r2zqYbsANLIe3Cpaw15Q6Hx4KUJNn+tqRK6jDGkjEmsZE9aalzK2kvVtnSrlDV6aS65PbBN9dPlXcLHUNthYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CY8PR19MB7275.namprd19.prod.outlook.com (2603:10b6:930:9b::21)
 by SJ0PR19MB5512.namprd19.prod.outlook.com (2603:10b6:a03:427::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 22:01:02 +0000
Received: from CY8PR19MB7275.namprd19.prod.outlook.com
 ([fe80::c785:4236:5a66:ef37]) by CY8PR19MB7275.namprd19.prod.outlook.com
 ([fe80::c785:4236:5a66:ef37%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 22:01:02 +0000
From: "Thatchanamurthy, Satish" <Satish.Thatchanamurt@Dell.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bolen,
 Austin" <Austin.Bolen@dell.com>,
        "Arzola, Christopher"
	<Christopher.Arzola@dell.com>
Subject: RE: [PATCH v1] PCI/EDR: Align EDR implementation with PCI firmware
 r3.3 spec
Thread-Topic: [PATCH v1] PCI/EDR: Align EDR implementation with PCI firmware
 r3.3 spec
Thread-Index: AQHam28cYN/M1pmFuEWaKKSe3PceALGEgWJA
Date: Thu, 2 May 2024 22:01:02 +0000
Message-ID: 
 <CY8PR19MB72753D2514337FCE78FFBAB1FC182@CY8PR19MB7275.namprd19.prod.outlook.com>
References: 
 <20240501022543.1626025-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: 
 <20240501022543.1626025-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=18be399f-94a4-4660-8bad-c4aace896d1a;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-05-02T22:00:20Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR19MB7275:EE_|SJ0PR19MB5512:EE_
x-ms-office365-filtering-correlation-id: 4c5b5fce-61bd-4d32-c200-08dc6af35b78
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-7?B?YVgwS1dWWnJkcGR6bGV2alJaWTNKV1dYZ25RUWRVOUdjdU5SOFQxaXB2ZWNQ?=
 =?utf-7?B?VjdMNUR0enlzY28vRXV6VEx5NGhXam1wNWprS3E3Zld6QkNCKy1weTBYdEFq?=
 =?utf-7?B?ZUhMZnBzenJBWDJ6YmVlbkpEYzl5WEZRbW94azFuZ0M4ZVpHdnRaWEFXR01E?=
 =?utf-7?B?UzhTUWt2WUJVbVBtd0g3UEhOcW02ZSstdGRjOFYxdzZSdkNuUFlqSUQxb1RM?=
 =?utf-7?B?UWNzYVRIbDkwSzJoUkRYLy9sdkRQeWZiTm5YT3VlN3ZRZkpuQm42R3ZaMzZp?=
 =?utf-7?B?VVlIejA4OU5GSGp2bjN0MWEwY3JSVGFNb296bkhyRHBHcWh6YXRzV3VZZllP?=
 =?utf-7?B?M3JlS0RCZ0VRbG9QME9JdWtPV3piSlpTT1NqdkpKVHQxelpvcXNYL1hDOTkz?=
 =?utf-7?B?ejVneXc2Ky1oaEx6cTVLUE42NjJiUnlZakZjOVBCcTdsbElYQkR0QUVCQld2?=
 =?utf-7?B?ZlhHU2VJcmVrS3RsL2d4UFRRaU9HNk5EbE1IQXQ3cEpKczA0NENnNFV4eEhh?=
 =?utf-7?B?YnorLUNERUR6U0ZzUzV2Vysta1kzZmdYdVY2QzB1QjlxcnNUQUMrLUo2dUtv?=
 =?utf-7?B?cGpKcUlZMGs5VmRBRXZUUHUzUistS0d1TU8vWGhxaWk5RHBSVjVOOWpvaDd2?=
 =?utf-7?B?T1NNOGU4bVl5b1R1em1tZSstazlnTE5DNEErLUpJb3FJQXVtL2t4UGZaQk9s?=
 =?utf-7?B?NU1KR1dqRnBqRmUvMmNZcVNrd2VtSzlzL25FbTFqVWgxNzlKWnRLRk9NZEVa?=
 =?utf-7?B?ZCstdTZHVm5YMUtDUTluT2J4ZmlQSjNsYW9heHBLZENtd0FlSFBSMTRlS29t?=
 =?utf-7?B?cFBZenlIRTE5MkhzeUVoWjVYRWFxa3ZRcEpIaXRGKy1RY3FybHIxTkJESGlp?=
 =?utf-7?B?MzdCdktaSWh6QThSWWlGMnZ4bGlGVjgzRjRDTFVzQzFyRG51bVBjay9OY0NU?=
 =?utf-7?B?MTJpZ0l1VlNHdnN6Q3hEUzhiME1WamxhV0JiKy0rLURWVHFZWDI0bi85TDYv?=
 =?utf-7?B?OUthb1B3TlBVLzFLNUV0VzluRkVvZ0JrdUl1M1FmQW5uTnZ5WEMyTW4yenVx?=
 =?utf-7?B?YmUyRmo0NzE2V2s2OVl6NVpxOFZtV0V6NVJqL0xraEZka0tSUDFxczlycjV5?=
 =?utf-7?B?ZTdicFRRU1VJWjBxZ2RkN05KNHFEdUFyUjdKZDJBSDBrOG9JYWl3dldaenJY?=
 =?utf-7?B?QjZIM01QV2grLXVRaXJQa0NpQ2JDdzVLVXhFRDBvU1phNEI4NDl4RkQ4ck1Z?=
 =?utf-7?B?VlpmSUg5VDg2V2dUZDhQRUY2WDRiRHkrLVpFWHZSMXN3R0J5NWpSMmtIeGJK?=
 =?utf-7?B?enZGQlRpUHNDS2g2MU9zaXVaMnFWKy1UelJwalRZNG04Z3JSc1RGM0NQbXgv?=
 =?utf-7?B?TGR5ZmxqeTdFbERLL2owQnZUWXUrLUtjY2hpSkFkZkN1bXFORE5kKy1VaHZU?=
 =?utf-7?B?Q3ZpaTk4bnZQSkVuTjZkRDhYemJaRUFpRFJ6cksyZXViMFhuallmd1BZZmlH?=
 =?utf-7?B?eFlsdmdWeEk3MXlLallqSEJVd3hBaW1ZaFIya2RNYVF2N3NMTkZjOXprQ0RJ?=
 =?utf-7?B?eFJMTmpCcDZ5aWpEelJDSXpHUjFOS2FTWFloL0RiYWFsL3JSa1VxQlkvcWZz?=
 =?utf-7?B?SXJXREVBSGszWXVHR2J5UXBobGtoZ0VnVlVLUE1MWk10UVl6L3lVcG8rLVdY?=
 =?utf-7?B?eG15S252V0xWV3kvTFZlSzN3N0crLVBkN3VzZ0d5TzdJSXNRQ082aWlJUmVa?=
 =?utf-7?B?TDhYZXA5YystY0poWkJKM1orLWlwMktVOGxkUjRvZmxadGJReEhhbWpMUThw?=
 =?utf-7?B?TGRTelZ2TmF3VkQvV2tRU2pETmdwUHFjdkNZR1JqcXdES2ovRGcrQUQwLQ==?=
 =?utf-7?B?K0FEMC0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR19MB7275.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-7?B?U0xnQ3Z4YUkyR1BiKy00WklqbTJWKy1pVEVnUGlBTlR4Z0gyQXZ4cystTnNN?=
 =?utf-7?B?bTBEY3V6Mzh6Z1RnNXljdm5UQVF3YXRlcFNaLzlHOWdwc2E3ZHZ2L3lQYist?=
 =?utf-7?B?ZThud0toZ2V6SlVtWTNFWDVVaCstZTJzTXBTZjJGdnB4TDZjc3VKTE1GeEpF?=
 =?utf-7?B?OEZHcDk5dlpiNm9CRUJXQndYTHl4cHAwcHNVRGYyLzBsa0JnSHdrSkZ5cEJZ?=
 =?utf-7?B?c1ZYdDdubWh6UnJDTHM2d1Y1by9lL3VkQ3o1N283RWxabzNQcG1BYXFIY1BN?=
 =?utf-7?B?c3d6NG1jeGZYancxbGVrL0ZvUXlsbDlIekdHcHBvR3Z2Z3dYa1JRd1J6NTI3?=
 =?utf-7?B?dTl3dllNWkFxQmpOTWZBSExRZXE3ZFlLSmVhbVBwZFBEWistNFpUa0JnTDVI?=
 =?utf-7?B?MGcrLWozSTYrLWtHQ1phTFJyekMzMkZGazJnbFNjVU1KdVM2d2diT2poSDNM?=
 =?utf-7?B?WWxXVFo2UXNjV0lvT3V0Ukd2ZnM2TDYrLWoveGtQQmVQYUkzMzFaRC9YMXJ6?=
 =?utf-7?B?UVpvTWptR1dEb0liTmxMSVZDM1B6MjJSOEFpS2ZkQzlwWVlZMVRuakY3aUNr?=
 =?utf-7?B?d08xbmNSYUhqV1VyZHBkb1N1cWM3V0lLc3cxOW0xZ2V0c2tpSmpSOCstYk95?=
 =?utf-7?B?eHRFRUhDelBjZjBvQ0o0SmJWQ0I1Z1pHQWdjVHZJOG1NSTk4Ty9zdjJ6MnFx?=
 =?utf-7?B?NjQxbG1TbEZ4c1JWRi9DL2NzOUpIQUFhOEJJc0hJR3hBYUNCTnc4V3FXeGh4?=
 =?utf-7?B?UVAzQnZzMENqUnEwZjU3U2dCWjYrLUV1dWNYU3g4NXAxSVdRdTZBT0FZd3Rh?=
 =?utf-7?B?aS9KUGlueHJaQWNFZzVNc002NTcyY1IvWEV5bjcrLXdXZFVCOEFneWNZQ00z?=
 =?utf-7?B?Y0RqNCstKy1kN2Y3SGhqUm5INEx2d2pjYVZNV0hiOEEwcWFuMUI0eVlibU4=?=
 =?utf-7?B?Ky05OTJCNzFta3RrenlFM0NyZVdYY1RiMFlqVW0xM05neWU2bnFON1ZIVkdH?=
 =?utf-7?B?dWJSWHplWkd4RnVUQVVwcms0VEw2VEI1RDJqWGc3RXBRdmE5YlFFRlEwWlhL?=
 =?utf-7?B?b3RHL1NiMFR4YTdjLzFtMW8zZHNSblBzWUZlZEQ1Wi8vdHpIMjVuaXRPSmNM?=
 =?utf-7?B?d0RXR0x3Sk9GUmM3OTZ1ZistdGRlM1pKclpzVkVCYmtXNTYzcCstNFVuQXBQ?=
 =?utf-7?B?UXNnRUh3SVBBVFBJNmxpTGZWT0xVWG52ODhyN3R0MEc5bHAwM21TNWhXRkVP?=
 =?utf-7?B?Wk95MG9rSjhBSzFlVFFJWFRDOUR2N1JFTmVyajJiSjlvN1RmVFh4b2lxVWdh?=
 =?utf-7?B?T2xBcmIrLWUzM2lOVFFrVmRWa1lLSWRjMHhjanljVjRRSjBRSExvTmpoT3VL?=
 =?utf-7?B?OU9OdDdzSzJDVWVQWDZVSEVRTFVGTk9tSnh3U2Y4UystL2k1ZnlzUEw4cSst?=
 =?utf-7?B?bnc2enB1TlpyRmNhcGdLYXRjYlArLVFrNGZRYTc1UmVGRFdmbGUwZUd3TGNS?=
 =?utf-7?B?bFJRWEt1a09aa2VHRHozcWsyZVR0c1ZYd0YvYWZkY0tWKy1rcWdXNVdLZWI0?=
 =?utf-7?B?WW9EcVZSdC9Dam43cEg0bzM5Z0lacGh4b0FQdmQxdistKy1iM0FnejAzaG92?=
 =?utf-7?B?S1VwRFJ4RlR5b0FhMzljekh2aFZ0S1pIMzdpR0FxVk1tMHFkaHFNOCstMlh0?=
 =?utf-7?B?aVYrLWU1RWNNTVJKU0l4RFdBSFJhN0ZXMXRiOUtzUWV4dHZFejFmRGZ5TmEv?=
 =?utf-7?B?QUFIbU0vdTJqMVdrakNSbVdOMkVabXIxQWhSNnJyVndMYXRGMistOGpBbjZR?=
 =?utf-7?B?Znl5MHBOd0ErLTlEWTFzSGhUUEQyZk5FUjZBcDEwd0lTOGl0cW5DLzREN0Zt?=
 =?utf-7?B?Nk16NVdnWFFSN292UjRaSzBYV2FVeDJnQTVLaTEyMWFOcURrNjNyUGNsMjRn?=
 =?utf-7?B?SUtqbnJzbUhCT1J6blVQbGw0ZkF6eGVjU2NMWnNldm9RTkZUWWRzcFFqYVhx?=
 =?utf-7?B?OG1RcEJ3RnluM3ZsdHhxTENHclJTSWhuUzFVSUZpaDJiWWJ6amtFR2R2TTB6?=
 =?utf-7?B?cXNEQXR6OGNqdFdkMUJPbEJIOXZLc25XM1dVKy10TmRDR1BQSXEyVWdFQlkv?=
 =?utf-7?B?NWhyb3VGWEQ4anNZQlUzOE1teER1Y0FSd0hGUCstVGJkZWkzaXk3V3crLTZ3?=
 =?utf-7?B?V05zemNHWnJpcm5VMHlic1pmcCstdlcrLURKZVA2MWQ5dEl5VVhJTSstTE4y?=
 =?utf-7?B?RDFWVGM0b3BnS0pFRXY4RGpQSXQ2UXlNM2grLW82M0dYdWVtZGl1YVNNL1p5?=
 =?utf-7?B?RFRud00vaHNxcG9RK0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7275.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5b5fce-61bd-4d32-c200-08dc6af35b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 22:01:02.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QNxXM5TaZgW86thp6HaO1S3l/IL79xoZApGzWYk1ntD7ubX37iwGOc5/dqAWExCWv+wXQkJ/lNU6z99ve9wZ2j0WJdD79EmHFmbjlkoLRu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB5512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_14,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020147
X-Proofpoint-GUID: c-3C-DZ68mVhDmKgPCompu737TFlT5TU
X-Proofpoint-ORIG-GUID: c-3C-DZ68mVhDmKgPCompu737TFlT5TU
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020148

Hi Sathya/Bjorn,

Right, from Dell we did perform limited testing on one selected platform wi=
th this EDR patch and it did work.
But if need to be tested with multiple platforms then we need to test few o=
ther configs. Please advise

Thanks,
Satish


Internal Use - Confidential
-----Original Message-----
From: Kuppuswamy Sathyanarayanan +ADw-sathyanarayanan.kuppuswamy+AEA-linux.=
intel.com+AD4-
Sent: Tuesday, April 30, 2024 9:26 PM
To: Bjorn Helgaas +ADw-bhelgaas+AEA-google.com+AD4-
Cc: linux-pci+AEA-vger.kernel.org+ADs- linux-kernel+AEA-vger.kernel.org+ADs=
- Thatchanamurthy, Satish +ADw-Satish.Thatchanamurt+AEA-Dell.com+AD4-
Subject: +AFs-PATCH v1+AF0- PCI/EDR: Align EDR implementation with PCI firm=
ware r3.3 spec


+AFs-EXTERNAL EMAIL+AF0-

During the Error Disconnect Recover (EDR) spec transition from r3.2 ECN to =
PCI firmware spec r3.3, improvements were made to definitions of EDR+AF8-PO=
RT+AF8-DPC+AF8-ENABLE+AF8-DSM (0x0C) and EDR+AF8-PORT+AF8-LOCATE+AF8-DSM(0x=
0D) +AF8-DSMs.

Specifically,

+ACo- EDR+AF8-PORT+AF8-DPC+AF8-ENABLE+AF8-DSM +AF8-DSM version changed from=
 5 to 6, and
  arg4 is now a package type instead of an integer in version 5.
+ACo- EDR+AF8-PORT+AF8-LOCATE+AF8-DSM +AF8-DSM uses BIT(31) to return the s=
tatus of the
  operation.

Ensure +AF8-DSM implementation aligns with PCI firmware r3.3 spec recommend=
ation. More details about the EDR+AF8-PORT+AF8-DPC+AF8-ENABLE+AF8-DSM and E=
DR+AF8-PORT+AF8-LOCATE+AF8-DSM +AF8-DSMs can be found in PCI firmware speci=
fication, r3.3, sec 4.6.12 and sec 4.6.13.

While at it, fix a typo in EDR+AF8-PORT+AF8-LOCATE+AF8-DSM comments.

Fixes: ac1c8e35a326 (+ACI-PCI/DPC: Add Error Disconnect Recover (EDR) suppo=
rt+ACI-)
Signed-off-by: Kuppuswamy Sathyanarayanan +ADw-sathyanarayanan.kuppuswamy+A=
EA-linux.intel.com+AD4-
---
 drivers/pci/pcie/edr.c +AHw- 23 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-------
 1 file changed, 17 insertions(+-), 6 deletions(-)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c index 5f4914d3=
13a1..fea098e22e3e 100644
--- a/drivers/pci/pcie/edr.c
+-+-+- b/drivers/pci/pcie/edr.c
+AEAAQA- -35,7 +-35,7 +AEAAQA- static int acpi+AF8-enable+AF8-dpc(struct pc=
i+AF8-dev +ACo-pdev)
         +ACo- Behavior when calling unsupported +AF8-DSM functions is unde=
fined,
         +ACo- so check whether EDR+AF8-PORT+AF8-DPC+AF8-ENABLE+AF8-DSM is =
supported.
         +ACo-/
-       if (+ACE-acpi+AF8-check+AF8-dsm(adev-+AD4-handle, +ACY-pci+AF8-acpi=
+AF8-dsm+AF8-guid, 5,
+-       if (+ACE-acpi+AF8-check+AF8-dsm(adev-+AD4-handle, +ACY-pci+AF8-acp=
i+AF8-dsm+AF8-guid, 6,
                            1ULL +ADwAPA- EDR+AF8-PORT+AF8-DPC+AF8-ENABLE+A=
F8-DSM))
                return 0+ADs-

+AEAAQA- -47,11 +-47,11 +AEAAQA- static int acpi+AF8-enable+AF8-dpc(struct =
pci+AF8-dev +ACo-pdev)
        argv4.package.elements +AD0- +ACY-req+ADs-

        /+ACo-
-        +ACo- Per Downstream Port Containment Related Enhancements ECN to =
PCI
-        +ACo- Firmware Specification r3.2, sec 4.6.12, EDR+AF8-PORT+AF8-DP=
C+AF8-ENABLE+AF8-DSM is
-        +ACo- optional.  Return success if it's not implemented.
+-        +ACo- Per PCI Firmware Specification r3.3, sec 4.6.12,
+-        +ACo- EDR+AF8-PORT+AF8-DPC+AF8-ENABLE+AF8-DSM is optional. Return=
 success if it's not
+-        +ACo- implemented.
         +ACo-/
-       obj +AD0- acpi+AF8-evaluate+AF8-dsm(adev-+AD4-handle, +ACY-pci+AF8-=
acpi+AF8-dsm+AF8-guid, 5,
+-       obj +AD0- acpi+AF8-evaluate+AF8-dsm(adev-+AD4-handle, +ACY-pci+AF8=
-acpi+AF8-dsm+AF8-guid, 6,
                                EDR+AF8-PORT+AF8-DPC+AF8-ENABLE+AF8-DSM, +A=
CY-argv4)+ADs-
        if (+ACE-obj)
                return 0+ADs-
+AEAAQA- -86,7 +-86,7 +AEAAQA- static struct pci+AF8-dev +ACo-acpi+AF8-dpc+=
AF8-port+AF8-get(struct pci+AF8-dev +ACo-pdev)

        /+ACo-
         +ACo- Behavior when calling unsupported +AF8-DSM functions is unde=
fined,
-        +ACo- so check whether EDR+AF8-PORT+AF8-DPC+AF8-ENABLE+AF8-DSM is =
supported.
+-        +ACo- so check whether EDR+AF8-PORT+AF8-LOCATE+AF8-DSM is support=
ed.
         +ACo-/
        if (+ACE-acpi+AF8-check+AF8-dsm(adev-+AD4-handle, +ACY-pci+AF8-acpi=
+AF8-dsm+AF8-guid, 5,
                            1ULL +ADwAPA- EDR+AF8-PORT+AF8-LOCATE+AF8-DSM))
+AEAAQA- -103,6 +-103,17 +AEAAQA- static struct pci+AF8-dev +ACo-acpi+AF8-d=
pc+AF8-port+AF8-get(struct pci+AF8-dev +ACo-pdev)
                return NULL+ADs-
        +AH0-

+-       /+ACo-
+-        +ACo- Per PCI Firmware Specification r3.3, sec 4.6.13, bit 31 rep=
resents
+-        +ACo- the success/failure of the operation. If bit 31 is set, the=
 operation
+-        +ACo- is failed.
+-        +ACo-/
+-       if (obj-+AD4-integer.value +ACY- BIT(31)) +AHs-
+-               ACPI+AF8-FREE(obj)+ADs-
+-               pci+AF8-err(pdev, +ACI-Locate Port +AF8-DSM failed+AFw-n+A=
CI-)+ADs-
+-               return NULL+ADs-
+-       +AH0-
+-
        /+ACo-
         +ACo- Firmware returns DPC port BDF details in following format:
         +ACo-      15:8 +AD0- bus
--
2.25.1


