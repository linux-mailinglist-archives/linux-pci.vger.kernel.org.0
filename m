Return-Path: <linux-pci+bounces-44212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D37ACFF89D
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 19:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E93321B862
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC496375142;
	Wed,  7 Jan 2026 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZdPI8n/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ahyM2fNW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E236C0D2;
	Wed,  7 Jan 2026 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808757; cv=fail; b=Q7lknTvHWDpFPOKGZMjTFiMXsxAQMh8k7MFaUS/9ktzOC8+yjgwit2rqt1BZ6sanl+ZvnF5Q2JXYYrd3s6G0279ExK3vIx7T+5Zepm4UdPXw30fM8lkrIMJyPuPHd+mT+d4Kd9FTvc6OriZiTS6LAPfSehdL/iZP9Lr0wlhZp3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808757; c=relaxed/simple;
	bh=+WrpoSU24NuwcXyKzH/yPqLX2vB89eT7T2Gz7Vl8E4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qHuEMWbZ5188OYoSUYIbBIvcGGUtCpKqGUoroLLySD9WAgZ3+OObNeRXnnyDNiSO4UPZNEv5YhdkY1GKmVLFI9jsQ+bxypIPkJoW4IJ/qpBGWUZdPgmbqwHBQdrd6We9jtJxnbOZrqnkZZU/U4XXBDcTouSxwqTUS+omThDPRwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YZdPI8n/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ahyM2fNW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607HueA82504467;
	Wed, 7 Jan 2026 17:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+WrpoSU24NuwcXyKzH/yPqLX2vB89eT7T2Gz7Vl8E4Y=; b=
	YZdPI8n/mUQYEJ0p17S85oHUaCyHkECB+zmSBdxUPVRwwFmrMW1vw4/z3F+uIJ5X
	TLnY0qRDol25njJF9h6Ad4Q9lnM8isSZIYMB5CHfJ95ua1n+C7PBOdhc8hh5/Jh3
	gJVrJw7psZCtgSg/wjEXwv5cpKdvVXfQVIuR+uPHDtCOVKsm3pxCBiK4ytYp2dQP
	QFjlUWds39FoN1CiriLvwQlwAavrsBHcBEltvwqORqaSM4pkOytdS+JkXRJwqOve
	tmZMq36LeMrxz4z9brzF0EmcX40BIrkEUZ3pfnc7VkR9jQJNfy7U/GwXKtSF0ctI
	+E3ByVPjMrZ8ht9KgLuDdw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhvb1g02a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 17:58:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 607HOxBP021775;
	Wed, 7 Jan 2026 17:58:25 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj9vrh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 17:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkpITBCKh9UGMM69hqOokMUGPv9sZxBDqE+r+/Hc+roW7Eo1NM/Ez+5zQQXTPj2rPXR6jS2Wwocf2TnbzQNsCHoQvqE8EM/FTr/aREHIk1d7LXY92imziakrKoPGaQPfIEtZVg22b8T7osK+BPTiMl7Y7Pm7SCgBC0nK53Sk8nYudfYYVZDEXWzG0eLaAbnT39/OjQ8+YRhhd4l4wpbU1ip3SMY1qyqZE7mvrkSuwWAbxDyuGilC4+DC0WDmnBkxxyYcx9wceb369tJwlEE1JEcyjqjnwZHNTIopKT0jy8ifiKFj1FyR6EdnG+B+QJRAN/5RqPXWhn+YxOqz7IfvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WrpoSU24NuwcXyKzH/yPqLX2vB89eT7T2Gz7Vl8E4Y=;
 b=dEenHGe8aSTFfGzrSy/kd2vWZ7mapPBljShMX/bYOEs5XD63joEd44shBTfh7QL9zouFdzmsICUCe3XNuRbNofslno6RUnJeYZp477i5ioPrwA+cAtGSlyhFA6l4KwjJdP/xu9ZTyy+aEL/z7dUiOkJlDMf9HWK4PMjYUluKJUrAY19sPBLt7Tmiz5wcYrJnjiyw+e5nLCQFMl5D0uvQjMGQA2toxWTgUlVwRwcAyEaQFcyLaXqNKwYWmy4jzNrM4kcpuTFJTk7thMGI7XwlKofgS9xQT8WLKHAwoD25FWDK0hl24KP45tZeWMKTLPZEapxgNzEcftsDIjR8sgu7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WrpoSU24NuwcXyKzH/yPqLX2vB89eT7T2Gz7Vl8E4Y=;
 b=ahyM2fNW08RsoQRMLjoOtd/aqL7yzmE33k9OhkP5mdAjN2J5yKjCraiKCOJnm2verLBlvGCbZ7eymfkG6Z92U7VBkLfgy0thY2q2EoFgdZa3NxhAMgUiqWGcP0wLvjC4n6upMdszGrn+kom9tQ4e+qwwZhdMPuEjY2HgW3eXfas=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by DM3PPFA09EE1970.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:58:15 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:58:14 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>,
        Casey
 Leedom <leedom@chelsio.com>, Ashok Raj <ashok.raj@intel.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        dingtianhong <dingtianhong@huawei.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in
 program_hpx_type2
Thread-Topic: [PATCH] PCI/ACPI: Do not fiddle with ExtTag and RO in
 program_hpx_type2
Thread-Index: AQHcZfNx6ACq7R62xkiLgv89EFhEMLUnZYQAgB/M64A=
Date: Wed, 7 Jan 2026 17:58:14 +0000
Message-ID: <1C290028-E094-48E3-B2CC-29734CEBC97C@oracle.com>
References: <20251205142831.4063891-1-haakon.bugge@oracle.com>
 <D49C0D9C-96F9-4D2A-974C-7B6E0CBFB235@oracle.com>
In-Reply-To: <D49C0D9C-96F9-4D2A-974C-7B6E0CBFB235@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.200.81.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|DM3PPFA09EE1970:EE_
x-ms-office365-filtering-correlation-id: b7bc9c99-eb69-4ec5-cf50-08de4e165460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWZoWlZJZ3loSUgvTTBDeFY5Q3BLekpUQnQwbjJOU0Vhc3RUaUlHTkhKRVgz?=
 =?utf-8?B?SDlwUFVDdktHWTNwcUZiQXVybVNSZDBmeTBXeTVkbVNTOUV0WmNScUFLNisz?=
 =?utf-8?B?bkJRVCtlbS9FSEUzQm0yUSswd3JRd3h3S3IyVXFZZmpjT3dpQU12LzVKUkpn?=
 =?utf-8?B?c1UzNnZ6bThCM1hEK1pld1AvL3BOWHdtUm10enMwVUVPK1pZZG9JeWJwUnVV?=
 =?utf-8?B?Z3R4QnlMNVpYeXZJL3NDdUVSNHFhUTN1elFEWjdvaWxsRU1rRG5SMXdxNWcv?=
 =?utf-8?B?akNiM041Q0lKMFJ5c0JMK29wNm1rVnUxSUo1VTJPSGw0U2hJbityNHdOWnBY?=
 =?utf-8?B?TnZOSUViYTJ6YzkrOEhIRzVaRXlLUXpLNHBaeWE0K3pGQzU3TlhzK1B0SmxB?=
 =?utf-8?B?SmhrZURVRzNNN1JQcDZlNkk5Rm5tR2hRWmtaWHZTelk1ZVU2RitYcmkyY3hl?=
 =?utf-8?B?UDVycElpYU5YL3p3L3A3UkM4TksyVlBEQVpTd2UxcXhXZEh5clAwUUc5QWNS?=
 =?utf-8?B?ZVViVEc5YjFsZ0FBQkRKc0dxL0tCemR6ZkNWOGlWY0VTZ0xnZi9qd2d6Tkcy?=
 =?utf-8?B?RkoycXczdTBMeHNuR3ltTm9pWjRWang3RURlbEtmcU5iYnRkdm1oVHhuLzRE?=
 =?utf-8?B?Nm0weVZic3AzbjN4c1VyV0MrdHNvUFBmeTQvb1pRS2h1YjNRcTIxYU4vUVdu?=
 =?utf-8?B?dWVvQnBUb3hYS29xNzdDWEoycnVZOVNVUzgrRityV2pVeGVobWpsbFd1RWs0?=
 =?utf-8?B?QW9mVkk3dkxzTStyRzcvZCtiWjFPR0REUjNvbE5lN0dwOTRrdHFydUN6NXRo?=
 =?utf-8?B?dFhlUEdyMXg0RDVqRW5ncWdBNXhwOG13cUcwMWg4dkFPRnRMc2duaCttQkUw?=
 =?utf-8?B?b1JDY3JXek92RmJvN0Uyd01YSC9wUWFEdHcrUnoyVVFaazVIc0NSR1E2bXJn?=
 =?utf-8?B?V0R0ZjlYV3RPOGg2TUdhRHpDMkxHN3V3b201MEpsY1hwRC9FQTlxcTh3L1Aw?=
 =?utf-8?B?VTk4Z1lDdk5INUs1R1RNWHBSTHFpMUpEa3Y1Q09sWmJSSTBNUXVncG4yZUtk?=
 =?utf-8?B?alNsektWUTBjN0NGaWtoSjArcXdQTjFjbGVtZVdLTmdyZTNyQkRUbS8xV2FF?=
 =?utf-8?B?Smh0UmcwcWt1UEZDcFJjemd3Rzd1elJIaUViQmpmdlVzRTNnUFZocWFsOE8v?=
 =?utf-8?B?bFpnUlJFcnZSV0svZkg5RlF3c2VaRHF5TklINjJUQTc3aEpKS0V0RzNvamxu?=
 =?utf-8?B?aGd1dVlZYUZHVEdiQ3Q5c0V5T292SWszeUVjeTZwL2hWdm0zTHlFR3MvUnZT?=
 =?utf-8?B?Tm1XbERzaHpreWoxL0ZLOCsrTlJGYk05Smw2THpjeEVqTHBnL3lTMXNlajRv?=
 =?utf-8?B?eG9XNElNTjV4RmVSS29HeElXdEVhYnkrSFdDV3BWc3ljWVhTa0pza1kvenVV?=
 =?utf-8?B?a3pGeG53bnA3OS9qdld2emREcHdmV09WcFE2OGI0OFJ3SlZpR1VPVjR1eFJN?=
 =?utf-8?B?S1d1dC9MSWJhMWkxMVN2SnVRakFINXV6Uk5rWWRZQ05qZjJpMzg4ZmdrdkE0?=
 =?utf-8?B?NXBaSnJUUXEvV1dBR0dmNzVlMVBnM2ZHOFlKSVJvM25UL09sOUxhc0xLRkpo?=
 =?utf-8?B?SGV5SXVreFNXNW00K1R0OXN1TWFlQ1V3WWdHcE5mclBxeG4wU3AvMFZVVFNp?=
 =?utf-8?B?ZkZGZW1NR1pEcmx2eEVPR0gvSjZ2aVo2NjJzSi9meGFFbFNvbjN2V25YSitq?=
 =?utf-8?B?YUhXd3M3NmNkaHNySG1wNHdrdVREcGJlZVdVRlZkOWM1eFhjVm93aFVOVGFE?=
 =?utf-8?B?MWI4N2QwTk1lazhNRHdkQ09NZm5VUHJGU1diTk1iTmExMkpWUlM4azd5VTFa?=
 =?utf-8?B?VnRUQnh0dGJFVytlYno2QzN3MTBaeis2VzBvTlZkTVRNVEp5SWVicmlEWUFn?=
 =?utf-8?B?ZFZKMUVZdTZWNHErWDArb0lZaFhDSG9iRlNDV2tWN3pVMHdXZjA5ZVF1TjZi?=
 =?utf-8?B?TmdtSE1iOGR5V0xKV1FNbzRGUU9FU2tjZXVMYzJXTzY0c2pOaDFURmdzYTJv?=
 =?utf-8?Q?P8fMMt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajhvUzlTSVArTmVPVnBXdmNUSDZ1TnpNNjRJS3VHRjd5bjlhYStleHgxeENI?=
 =?utf-8?B?MlAybzgvV05ZUEVFQ3RPbCswSHJyQmVwMS93WVZSTUZEZU9JdWwxcHhwVjVp?=
 =?utf-8?B?ZjZSMGdIMnhCazhWRndZVk4raERKdldtWEg4M0J2SGtrOWRqbW1mNlY5L1VX?=
 =?utf-8?B?L2NjQTI3TUpJUEM0Y0tWSk5DZGhuNWIrdUtRRmtCRWVyOTFZd1owTCtESktJ?=
 =?utf-8?B?Z09KTE1rdDhqaHcySWtPL0FCeTh4Y1ZzeUw5NWtBWndUTUpGYjFEUjF0NlhO?=
 =?utf-8?B?UHhnOXc5Z1JUUHpseDEzNEx4OC92WFJvRW40cjYrVUszaWxDMXBzdmNoTnJp?=
 =?utf-8?B?cVpkVmFzSXZveG5iS3R3RCtrSXhuTm1HS3JYdng3VFZmdnNrcHRQemsrU2ps?=
 =?utf-8?B?NStoMjMzRmg0SVIzR1ZFamRSV2pCVXRZS2s1UkptTXdRVmRUekVZRjBpY1lJ?=
 =?utf-8?B?RTZHcXBjWkFGL2hkSHpreFpBRDlNNlVIcjVSbmlkbndhT1NkekZ5dDhwOUhG?=
 =?utf-8?B?d2FmTDF6S1VrZ2FzajlZWWNnRVhleUNiMXdTd2sxUWs2TzFxb1JuMkptYTZ4?=
 =?utf-8?B?UUg2Ull2Q2ZwR25GeThUUTdSaC9KcHpaaTJoWTNDRkRQRHFaM2NISHFFaHJ5?=
 =?utf-8?B?TFBIOEUwRmhFVy9xK1lVQmpDQ3gvc2Zhb013RXI3Ynh1VlJybHQrdlBZQ0hn?=
 =?utf-8?B?a0xVeXJUSmtFSlYySlE5VDRpVzdoQ3ZOeU15bmxyTDNSYjNvdnMwN1Nqam4x?=
 =?utf-8?B?T0ZGZ3hRcWMrVlhib1gvS0JObHVKT1FFczJtRGpYS2pZS2s2dUIrS3lvUDdY?=
 =?utf-8?B?Z0NSSVMvdVZRUjJUemFlelBGak5lV2JWTHRIUzhocDJMRytHV1VIYmlSSmpL?=
 =?utf-8?B?c0VmOFRId2dhRjhZN25Ka3ptWEZVU01jWWt0bTBiMjBDZDR0TXYvWjlNenRY?=
 =?utf-8?B?YzFqSWY5RysvR0FsaTErbVk2YXpueWxwUURlU2NXeHBPOUpGWWdNcjJqUHlL?=
 =?utf-8?B?MGtPeGs4VkxVUitJTUdtbWNjbVNNUS9wQzNLeWQ1dnlwQW5KWmhPcTRDR0RQ?=
 =?utf-8?B?WWo5T0xpcUVrcnhtczhyTTU1TEI3ckNhNVRObjFJRTQ3Mno2cWpnWnJiSU9E?=
 =?utf-8?B?VW9SeElRQzkyNjVmR2ZySXQ4NmZTUnRINXJnMWhMOUVpLzh1dlhkMXFhVisy?=
 =?utf-8?B?a1A5VDY1d05GQXBJNEtFVkhJem5uUGdDK2EwOVYvUjVYNStYcnpOWXJDVFA3?=
 =?utf-8?B?U0haMW5zZTF2UmkxNncrZ2VHOElMMVkvcXg5NUsvdDk5Z2pGMnlZeVZlRW13?=
 =?utf-8?B?YW02bS90enRBTExWMENkTkZpeEJlUkxBUm1WT2E2bmoydWdqLzZLcnJ1dlgx?=
 =?utf-8?B?WFdOVVBzOFU2TTc5aWN6SkNJb2xBM2I1NENQM2ZlME1jalR4RFMzUG1HWTRH?=
 =?utf-8?B?U09XWW11ekhuY2k4RTlVZHlsOUM3TW1hOWhEc2Z0ekczMkNWRldLSEpQZmRo?=
 =?utf-8?B?SlhlT1VTRWVoOVNQdSt0VnRISTR5d3NhRVJRMytoYmtzQ3FiYk5tUGNzWE5q?=
 =?utf-8?B?NUcwa1h5ZW1HZk5SSG1PSUl1RTNTSmViaXFjcUNLNHJXNzgzL3VzOS80YkRD?=
 =?utf-8?B?QnNSbTNuRzZ3UHlGUXNqSy9IcHVBRi94eHd1b0lwU1FKM2Jya0RpUU9GaFlV?=
 =?utf-8?B?bHB2Mm5CK2xjQk1wajM3OGxqVDIzQ083aHloNWpjb3RVWUY0K1ZzN2xjL0Vr?=
 =?utf-8?B?bUlKd1owUkRRMkt4OXNCYkg4OHBlYndpR1pON05jQkJoM25UbjFnbVI2YnZr?=
 =?utf-8?B?Vm9ORXRJVUN2N1pOeTkzeXptRmNIUm9EZThqSUZvZ1ZCNHFEaTFJZmwzczFx?=
 =?utf-8?B?Rys4UVlGeWpvdk1FYnRMdmo5VUQ1MDFaQ1U1SEtIVlhaZGc3MTVqMk81TGwy?=
 =?utf-8?B?TForeXdOelZHSWNNQ1NOQ1orWkhIVElBVnE4cFNMNTk5N1NnWFJ5bGZvSVFS?=
 =?utf-8?B?dW56ZTkyWHBBVGF6WEdSZGNtVFJFNFl2U0Y0RVBTdVA1alNodmZxUHVWbFQ4?=
 =?utf-8?B?R0xvOVhIaVl2SzZVcjZkMW01K3dLNXBGQ1FmRGpER0kwQjVSZ01iQUZWVXFL?=
 =?utf-8?B?bE5rN045MWVSY3FNcUJGcVM4V3pqOWRmTExCVnpiNUF1ZFFSeDlHcjg4a2VD?=
 =?utf-8?B?UXU0NnRBU0o3eHcyQXdIeEhxb3UrUDdjZkVyc014YS9iOFZwRmhNVlNqZXBX?=
 =?utf-8?B?WTRMa09Nd1lxTW9mVXpyM3NtTmYyc3M0VXVsc05uSFVUbTBNdnYyK1hMYTlh?=
 =?utf-8?B?V0ptcEdFL0JVL3pKaVNTdzBqNUxmSEp6dEZadVNBcmkyYy80NWRVQktkbGgy?=
 =?utf-8?Q?lIG6JY/HtVCOch+c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE8788EBD660944C8DF97964258D4CBB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s4edunNEhiA5GxM9Q1zJNpjB2hcIPhRmj1sWBC5loCEd9GlVV2NvUbiuL3fu03dtR+vR4er5eYPGbXoTVX0RZ9bs1hGoxnT59NY82sYAZMmj1MT6Oq4zuo3blhukv4SnYtG+9ZkJa7KotCbLb7ckR8dwo5PaJyi7pyTzobmHoKCcnuMDB2lODUIUYYiY87dpASNW+GSEnBIk7a6kx4TEwsskNXi4T81yaiBJoh8C1MXxvjfxi2yg0RKBemJj4sXVwocjjNLF0JkDTN4znhJirb8k6lVBcta/4uf8KNjO9DgIR1kdrxO4Vbu5gZKFPpdgqkATgPXJH50Ot8c9gmhSVfChcoDG/I4mQnYFjoa5z3nYsuI27SOpz6yH/fadKAIsQXi8oKBX3kMfSyBNlkjqF2f42bbhGuoU17o6iANOt4OTHNXcRHNhZW8WZ8SRAs4lqjv7XI0y3anU4XzvEwBW0dFAm8OZ8HLDvYtUZsp7zz99qKFfvMNc1upSpOQkRmbl6a1iKGzaS7/BRWXGsnRnbJMhGeO1WUPEVD1BC2ioDI3sZ+d1FOBpYAZzYm+kHA2sXV4DNo8HCh1eYg87hcUsbHk90rcGa2XvnTNFMM0/IZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bc9c99-eb69-4ec5-cf50-08de4e165460
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:58:14.4541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ca3+91bd7dnXE9HHCN3oa68qajo+Ackj3CRMVDOWw4MYUX9Atb8aSAUSXFt/7oSOwokVE3zqqJa+moVLTr/5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFA09EE1970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070142
X-Proofpoint-ORIG-GUID: A_cN_AVsN9DTjkUkAQYWXo1YScePPqVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0MiBTYWx0ZWRfXxGWNFb658fvV
 T9ZMAWK6GkdjXrW4vX8UnJU5n8JJMVdNkLvaB/5sjbVmObQ5HCRZzOorCnIpMrTFQ7wIi3FtHqC
 CylTbsWVXdINLG5l+GUCX783bW6Y62eaUF85EOimofZ+90qOA+X6YE6Iyjd5nZIEotcTj3pMNQA
 AxU7LrHFrIuPXKiRRIxFDtcAjjdTdJ+9vtQuoBJZu859NBrRTcp+P8omrWOJGoAkg/5DLCf+4Sx
 UlZ1HKgB+CzHRN08+jOsrLGZEkcS0ueD8/X4Sbko7Y0mpN75UW4Fi/jG8Jp87l9XEzikXq4aNbA
 ysZVTMJRpTQouTud1GdY1kraRJElRZCbcvyabBcKXxJe4dVNeO58siLXO5i07orqecl5W1O9fFQ
 m2HNIXNGo9PMg8PnR10vJkZHqppEO94JnGPaXrM16DXgc8Ybn9HXww8KvYjjSS8p+NaHOU1kjSy
 MxfuEy8aIEg4eDrUzAw==
X-Proofpoint-GUID: A_cN_AVsN9DTjkUkAQYWXo1YScePPqVF
X-Authority-Analysis: v=2.4 cv=T5WBjvKQ c=1 sm=1 tr=0 ts=695e9ec2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=a9krmoUPdi4ZbYenjj8A:9
 a=QEXdDO2ut3YA:10

PiANCj4gDQo+PiBPbiA1IERlYyAyMDI1LCBhdCAxMzoyOCwgSMOla29uIEJ1Z2dlIDxIYWFrb24u
QnVnZ2VAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiANCj4+IEFmdGVyIGNvbW1pdCA2MGRiM2E0ZDhj
YzkgKCJQQ0k6IEVuYWJsZSBQQ0llIEV4dGVuZGVkIFRhZ3MgaWYNCj4+IHN1cHBvcnRlZCIpLCB0
aGUga2VybmVsIGNvbnRyb2xzIGVuYWJsZW1lbnQgb2YgZXh0ZW5kZWQgdGFncw0KPj4gKEV4dFRh
ZykuIFNpbWlsYXIsIGFmdGVyIGNvbW1pdCBhOTliNjQ2YWZhOGEgKCJQQ0k6IERpc2FibGUgUENJ
ZQ0KPj4gUmVsYXhlZCBPcmRlcmluZyBpZiB1bnN1cHBvcnRlZCIpLCB0aGUga2VybmVsIGNvbnRy
b2xzIHRoZSByZWxheGVkDQo+PiBvcmRlcmluZyBiaXQgKFJPKSwgaW4gdGhlIHNlbnNlIHRoYXQg
dGhlIGtlcm5lbCBrZWVwcyB0aGUgYml0IHNldCAoaWYNCj4+IGFscmVhZHkgc2V0KSB1bmxlc3Mg
dGhlIFJDIGRvZXMgbm90IHN1cHBvcnQgaXQuDQo+PiANCj4+IE9uIHNvbWUgcGxhdGZvcm1zLCB3
aGVuIHByb2dyYW1faHB4X3R5cGUyKCkgaXMgY2FsbGVkIGFuZCB0aGUgX0hQWA0KPj4gb2JqZWN0
J3MgVHlwZTIgcmVjb3JkcyBhcmUsIGxldCdzIHNheSwgZHViaW91cywgd2UgbWF5IGVuZCB1cA0K
Pj4gcmVzZXR0aW5nIEV4dFRhZyBhbmQgUk8sIGFsdGhvdWdoIHRoZXkgd2VyZSBleHBsaWNpdCBz
ZXQgb3Iga2VwdCBzZXQNCj4+IGJ5IHRoZSBPU1BNIFsxXS4NCj4+IA0KPj4gVGhlIEFkdmFuY2Vk
IENvbmZpZ3VyYXRpb24gYW5kIFBvd2VyIEludGVyZmFjZSAoQUNQSSkgU3BlY2lmaWNhdGlvbg0K
Pj4gdmVyc2lvbiA2LjYgaGFzIGEgcHJvdmlzaW9uIHRoYXQgZ2l2ZXMgdGhlIE9TUE0gdGhlIGFi
aWxpdHkgdG8NCj4+IGNvbnRyb2wgdGhlc2UgYml0cyBhbnkgd2F5LiBJbiBhIG5vdGUgaW4gc2Vj
dGlvbiA2LjIuOSwgaXQgaXMgc3RhdGVkOg0KPj4gDQo+PiAiT1NQTSBtYXkgb3ZlcnJpZGUgdGhl
IHNldHRpbmdzIHByb3ZpZGVkIGJ5IHRoZSBfSFBYIG9iamVjdCdzIFR5cGUyDQo+PiByZWNvcmQg
KFBDSSBFeHByZXNzIFNldHRpbmdzKSBvciBUeXBlMyByZWNvcmQgKFBDSSBFeHByZXNzIERlc2Ny
aXB0b3INCj4+IFNldHRpbmdzKSB3aGVuIE9TUE0gaGFzIGFzc3VtZWQgbmF0aXZlIGNvbnRyb2wg
b2YgdGhlIGNvcnJlc3BvbmRpbmcNCj4+IGZlYXR1cmUuIg0KPj4gDQo+PiBTbywgaW4gb3JkZXIg
dG8gcHJlc2VydmUgdGhlIGluY3JlYXNlZCBwZXJmb3JtYW5jZSBvZiBFeHRUYWcgYW5kIFJPIG9u
DQo+PiBwbGF0Zm9ybXMgdGhhdCBzdXBwb3J0IGFueSBvZiB0aGVzZSwgd2UgbWFrZSBzdXJlIHBy
b2dyYW1faHB4X3R5cGUyKCkNCj4+IGRvZXNuJ3QgcmVzZXQgdGhlbS4NCj4+IA0KPj4gWzFdIE9w
ZXJhdGluZyBTeXN0ZW0tZGlyZWN0ZWQgY29uZmlndXJhdGlvbiBhbmQgUG93ZXIgTWFuYWdlbWVu
dA0KPj4gDQo+PiBGaXhlczogNjBkYjNhNGQ4Y2M5ICgiUENJOiBFbmFibGUgUENJZSBFeHRlbmRl
ZCBUYWdzIGlmIHN1cHBvcnRlZCIpDQo+PiBGaXhlczogYTk5YjY0NmFmYThhICgiUENJOiBEaXNh
YmxlIFBDSWUgUmVsYXhlZCBPcmRlcmluZyBpZiB1bnN1cHBvcnRlZCIpDQo+PiBTaWduZWQtb2Zm
LWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPiANCj4gQSBnZW50
bGUgcGluZyBvbiB0aGlzIG9uZS4NCg0KQW5kIGEgcmUtcGluZy4NCg0KDQpUaHhzLCBIw6Vrb24N
Cg0KDQo+IA0KPiBUaHhzLCBIw6Vrb24NCg==

