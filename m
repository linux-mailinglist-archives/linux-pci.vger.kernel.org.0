Return-Path: <linux-pci+bounces-19972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDDAA13C36
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706481613FB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD2C22ACD7;
	Thu, 16 Jan 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vfo4BLRu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QDY4Fceg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D422A7F7
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037647; cv=fail; b=iL3e6zu0PG+4zS+qfmye1TyYYQQM/qmyUb0u//Qi9pBMNK+Z8jWfUPAA6bIdMGaYPsIeePqbyrrXNCmQgkoJ1MGgJDDk4OhgmIuHAzPf+Ooll1iAFvQdxk4nQAzGiYrVDRBuwIICy83lDSlwePeFPdxZQReZi/hEsbU0HRjlEeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037647; c=relaxed/simple;
	bh=HSl28Vq7sx0sH3J9Pe2cv/12bB6yABa69IwO6Svr7z8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RZPl2qLb8wbcogSD+MIk7hJwILuhFfGMcoK+2z3bHNx5uz/jsOjdDc87t4I2LCtGbPieSIt5kOvqTWRSMp84VUaC+C2u3YevHOBxmZw2bbzlB8RZpprMdB4Mj2NTu4ikodCYOBc13z5EQ0/rPlyhJokR3gHf3yeO/el3Ao0+P4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vfo4BLRu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QDY4Fceg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBN0GV027528;
	Thu, 16 Jan 2025 14:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XzND9QFeze0Dgmvb+Sr9FR3pQgWSAHm82wuOMNI+A24=; b=
	Vfo4BLRuUcNSq4mCpqgqZ0NDQY24FGCEYSt0TQODiy94rVXs8HSuGSJ2YtTMvxmd
	8iIjLS7TDnUYewD8NmJyMwH+mblFUDb03F8s6l+8axwCekPdqCJISji0gizXc2GX
	oHWhU7tuQje8WpOxp81RYWv7D+EJuPMu70fB9PQXBMDJEoir2hkcDIE2/Ef6WiYw
	/4k4tWjON8fpKiwerKAg5vMjraoKQTF+1UkM6tbuzPpKumMQZIDLaDzIVtv4Ibom
	RRyIDa+Ni744ygVjsGp5ieJx+RXMyMKSMnfK9DdnguUQnz0i4MRO90LIGb0h9/hx
	3m9wqZ/dCl2ZmcT54g1DWA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 446wtp8nh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:27:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEPLe7038715;
	Thu, 16 Jan 2025 14:27:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3auhhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:27:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlK+OFVYKb/MLPubFM3/xL0zX9fO756eAJClXTfbiwjFWwQrGa2SSj2XKCim9HccB6b5WQlpYFUA7RYHtHeQEEHho+mw4ARW8WwwkqluYGF1yclKHpXoOQt4ved/7qm0epdTVdcsqMDb2MRZkZfADidaHWjNuD1oerGkyVFK7MmanoTPPaJjlQFBDOjutpVigFvRxqklQgxZEwAfMFdxIx5c+xjK9TdRr/NfDz+LujWoC7AJ4VFmyIaFJe/pjP3V5NrZcWIfGzuBmrAgoEBEIWEQOTwMSMhPyKRCFmLs4h+apm34sHIj2rQFChaEd24UmOZUZ5G9dey/OEUgxgL2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzND9QFeze0Dgmvb+Sr9FR3pQgWSAHm82wuOMNI+A24=;
 b=bHEz3nUIqnktWSDjZoftywtSE2QZqEIYLxTBnlQIRoE3whfzk+twU5neBMBxkkW0vAtUiMm+DN7lHkaRQJrkFe/QirsjMdQQMEBeRxaJs8LlOJ1qs2I2xzr042skQY3J03QYziNAovIxI7xNawfZKZ1WFHgkdBD5r+4kPUcKCI0Nwlq3RzlsP4XQI1ZkJRKhXLpeyCPB3/3Zy2WcN7h5IXtOteECgKlkWGITh/9IfNtMRP90D5370E4h81o3ZDfO+EASdu4BAEvyJrSomxpN/70OHegV4DL1h1iTWxe3iO94xlebzswAWfLsf7Xlq0V8yPuPjprIzmHipuJZtifi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzND9QFeze0Dgmvb+Sr9FR3pQgWSAHm82wuOMNI+A24=;
 b=QDY4FcegHC1xtjI9h6ETio8UNS36VDqKU1fFu0NlquJpyT5cSHYh21pG55yT3sx/bfecU+MZ2c1pre0q17xbN3O9vrllMV8dpWhunKdF9a4Ln6A7x/q5rtN7Wsw0xTS/yrgxhJyo8f5HO/kQ2wc2UOo9+qp5mvK+qZmWMWbi+Cs=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Thu, 16 Jan
 2025 14:27:19 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 14:27:18 +0000
Message-ID: <f9ccc68c-216d-4cb5-9e0d-d2b49854f06c@oracle.com>
Date: Thu, 16 Jan 2025 15:27:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-2-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115074301.3514927-2-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::16) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CH3PR10MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 133e91e7-a4da-4b72-303c-08dd3639e1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGhkeTJiSEl1N1NwWXFsb1FUbzVURU8zZlBGcEJwM2lTUU1pN3N4ZktaOXhV?=
 =?utf-8?B?bUxncGpaeHVTYzR5YmJsTFdlVndTejJ4b0sxcEFYa01PS3IvbTZkOTRZQ0s3?=
 =?utf-8?B?bnFSU3VWU0xXbkxZWGF5TVdFeHlTczdKaFk3K0hTclAyWk5MNUZ2VFRSUGYr?=
 =?utf-8?B?ZVNxQ3dod0ppbjNGN3BlU2xyMnRXRkQzS0dYM3ZZV0hpM3l6cDNMYXE3VlE4?=
 =?utf-8?B?QlFGU1Rtd3h6TGRVMnpCMlRxS2xabGIxaXNENlRqMjc4NGRRWE01YXE1UEMw?=
 =?utf-8?B?NHR5b010L0t4dlQ5QkhXM0U2aHVvanNEaitkZnVXUjYzMUJCU0F1LzI1MDBj?=
 =?utf-8?B?YnhCamxmNFJMOS9CZENYMHY4NU1EcGcvWTlHTzQ4a0p2eFlnWXpwNTJGajBF?=
 =?utf-8?B?NjlMWmg3M0REUHI5c3crLzVpamphd2RWNkYxMGRkR0c0Wm9sVG1SQlNQMy9G?=
 =?utf-8?B?TVBFbldzYkdZOHFJWml6Zmt3SFphbjdqN3BRR0hBWkl2L1ByWGE0NmhyNUYv?=
 =?utf-8?B?dTVNdW1nNkJxSkZONG5XQXF6RWJKaS9nUkdzRVRYYUhPTVR3U1ZLaWhEOHlP?=
 =?utf-8?B?Skhzcy9Ha1VuUWZ5Y25ZcWoydUE1NTdIQ3o0dmdhSnRXYzJyZmlwV1lObFMx?=
 =?utf-8?B?NlVUTC9uREpEQUtCY3FjcUJQOGdoM21aYzByaVFRbDZSRHE2UzRIRVdDNDIx?=
 =?utf-8?B?bVM4K1dDdCtkY1lVaXZOaHlYNmxYWHFmT2VqZVRpcEhKRU5OSlpIb3RSU0Ux?=
 =?utf-8?B?TnNtUXBSdTgyRTBCQU9JTTl2cnQzNlYwUG14aEVtbDRKb05BYmxKU3FiWUVu?=
 =?utf-8?B?cDBueUE1K1BaV3FYSW8wMUIrcWVGQ2taem5Xd1RBMTZQNVNEQUZxdXNvV3No?=
 =?utf-8?B?enp6RVdObWtQYjBkNlBydG1CL2JHemF3eEF2RGtzZGduWmhpSklnRmo2SU9B?=
 =?utf-8?B?cFlzRXhHU0h0dFAya3o3V3BuZUpQb2RSVlFDaFpJRTVNaWtMVjdBYVM4dDgx?=
 =?utf-8?B?aWRrS0V5YXJoVXFveEZJYnhlck44ekd2L0ZkTGd6c2paeVllZVFQalB3Y2p6?=
 =?utf-8?B?OXFFdWRVY1ZveFloUy96UXFGRGxkK0FHSmNXSmRZVUZPcWN4MVBodUV4QmJD?=
 =?utf-8?B?K0RZR2RiQmM0ak0vK3ljVVFrWlVITzE1VlJrMlVtNW5IRWIzU2drdFJTUTV1?=
 =?utf-8?B?Vi94UFZuYzdKaDZqUHdWc2J1TWZaQndVemdNeDdMTm9KTkJ2ZU81QjhiTGhx?=
 =?utf-8?B?Nll6a1htb3czU2Z2SCt0ZlFsdVJsRnhZVDVrMndJVmhxWlIvNmpNSTNvYWRK?=
 =?utf-8?B?NENiN2hPenZMNUVPK083SnEzNzVSc3JJNVo5UStGOWZPT1hDUkdhMC9ZZ0gv?=
 =?utf-8?B?dkd1ZWhXL2dGcHozdnpFUDVJK0xGalhIbVdwNDlmUFdjYzNXMnNSdjFJOGRD?=
 =?utf-8?B?TWs3ZTc4dzhMQUMyR2JFNzQ3dHNOdi9jVGVDYXU1U0dPWU5YazN2T1AxQ2tN?=
 =?utf-8?B?aGhHK0V1SXNuRUlJMWhScWs4ZlVUQnBNcjVEcUtHanpaS1R1ZU1pNElPVzM1?=
 =?utf-8?B?eE43TVJaYXQwOTBVRGNmNm11bTkxNituMnJ0Q0Y2TzYvd3BmZlJKcEs5WlhY?=
 =?utf-8?B?aDM2bHBNM2kwWDdYZzhzT2JRbmRGY2lMUnIzY3Q0TUJSTHJsY1JCUzBOa2J4?=
 =?utf-8?B?OUNqaW4zZVA3RVhaVmQ3WWNGMis1MFJtckwvcDhvaXR2V2xTTVVOMzV2QXBt?=
 =?utf-8?B?ZHdOK3JXSTVEUHlGQlEzVFN5VUxrYVEvSHV4cC9hSGptK2thd2RFSm5BS2hj?=
 =?utf-8?B?RDJlZ3FIa3FZV3RSVkVUdHJTRXVjS1pITkpTZzJnK2pTR0o2bjE0VUdrY0h4?=
 =?utf-8?Q?SgFLeNfRs3VmC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUFremxNRUNqS1JTbE14U0Y0MEFjY3Y3VmlWYnlEanM2bXFDMzJydXNZN2xq?=
 =?utf-8?B?cUM1cTNWa1BuZStaSjBqQUVMNjJWWGFpOGFTUm1QQjJvWXF0ZHlDQ2MzVi9Y?=
 =?utf-8?B?aUxzVFhLNXI5dVM3aWx4OVN1WkFMamdTUFE1YUI3N1RScnRqV21YK25zQUhi?=
 =?utf-8?B?amlKa1pmYVF4c1hqeUM4RUZ4T2cyOTV5bmI5NzcwQkl3ejVKakhSSVBxSlYz?=
 =?utf-8?B?cUFmSnl3aXkwVkJyb2VpZ3FZdzM4NS9idW5aV1Z2Ymt2SGVKRmkyM052am1C?=
 =?utf-8?B?eXNUdSs5bUtBanlIOG9KQTRiRFZTUlpMSWRQUnlMc0M2SVpPeUp4dUR0aHZM?=
 =?utf-8?B?NXBRam1qeU5WV2VqRW1QR1V1ekg1TDh1OEdyYVFXWkZUSlE5cVU3Q0g0WmN1?=
 =?utf-8?B?UXJtSWxJSnE3djRLTXZOSlp3dUN5ZmY2b29DWmNXZWh3em02N25XR1JaanVU?=
 =?utf-8?B?TkJNcW1VVDNndHJrSDAxVWxqaGZLalQwVFdoSG9wblZqei9BdWdDNWhPaG81?=
 =?utf-8?B?ay9vNExkZzZpcXMyL2h3cndZRDJ0UHBDMDdnenBiUjA3SytKcEhPSUI3Y2RX?=
 =?utf-8?B?eXZoeGxHVFowSk16U1JuSU84SkNVeXpKZWNndFhaZ2lwSnhnOGpCK3BrTGJs?=
 =?utf-8?B?Smc0ZWR6YnRSODVRaXpaTXdXS1pyWTdVdmJyZGpUR0FHSVdnTEZlUmtPRCt2?=
 =?utf-8?B?Q25xSXNpdDlENE5WdDF2VEU0RjVrQ3hrWVVEbFNSV3BhV1IydnBzbXdwOFFP?=
 =?utf-8?B?TnBvd0VBZml0dzM4WUFVNEw5Y3ZxckYzbzVDa3VqZm01RDRYRnBBMkozQ0dt?=
 =?utf-8?B?V2VtbUxuWlNlYVdMOUFad3AvWWZXMEdndUhhZXg0bmtZYWg3ZTYrUnF1Vkhp?=
 =?utf-8?B?VjQzd3NtN245V0VrQm1CMnYzNWlkVWl2SFZZR2U0VktXdVNQM3gxUVBBS2Zq?=
 =?utf-8?B?TWpmdG5PbGdyMFgzZG5hOUpEbmxydVhlbDR6QkNVYjBVdHppZTBZV3B5cVdt?=
 =?utf-8?B?aS9qN2kwZGM4bG1hcVFBV0VhQVUyMnhzUi9xZDZ1aUttMEVnRzlESzNOU0dF?=
 =?utf-8?B?dmgvTzkrWWtWdkFZWlVLZXBSSkJyMTE0OFRQMnRJM1NTU1AvTUprVnY4N205?=
 =?utf-8?B?UGZDN0NaWEZGVzZ4V1JIZ3pmaUU0Z2FWNzZRdnliMjlOUUc2Wk81Q3pNY2Vw?=
 =?utf-8?B?a2hUeVFTREU5RzQ2ZVBrSEFUbmliSWVkZW1IRWRNVlpZS0o1dy9jd3BkUXI5?=
 =?utf-8?B?blBtcUVzdGl4dW5JMTJEL2ZGSkZTWUgveVVsMWkzc3N4amRDVXREY1dRRUhE?=
 =?utf-8?B?cXdSMmFJWTFOVG80MnpCZDExY3NiUFFYNG5TcGlxVTQ4c3FzaXdRRXJRb01z?=
 =?utf-8?B?aHBieG4zOCtSclZtRnJUZDB2UFJMS1JKK2gyL2tmQnlOaUx6b21LSHFuL3Ri?=
 =?utf-8?B?QjdFRmJneTBvNEpTdEU1cE12NVhqSVpxUDlmaEJkSm5MOGl6NkVzNjBsWE5p?=
 =?utf-8?B?aTVPU0F0VnhpQ3RVMkprQkQvQWlHR2RnelBnY1FXYnNwSEJiMXdsUnp5U0c3?=
 =?utf-8?B?N1BHdkhla24yK2xOekJpOXkvYXJqZ2pEMnpuWVRsdHltd3NrZit4SUI3eEtV?=
 =?utf-8?B?eVIva1ZzK1pNZWZCN0RjSDVNMEJ5ejZTR0haMEVFQWtVNHA3TzdpeEdqWEY4?=
 =?utf-8?B?LzJGU2pxY1d1eVpTa2VnQjVaUjVQWTJycXJPK0xaMnRNK2xJb2pFWFJ1QmhG?=
 =?utf-8?B?QUE1Y2p6eTRWUkNDNDhxVHpqVHRkMi9BVTl1WTZaQ01nZytLckxMMm5GSXpx?=
 =?utf-8?B?ZTJOeW1EUkYrbC9SdWc5byt0UFByT3pyZitqOHNGS1pxRktHTkVyUkI0VkVR?=
 =?utf-8?B?OTVYYllYVkxUcTFvUDM4dUZwY1pOVnJqN0hnWHR0V1Y2OXhnOWR6Zi9la0lB?=
 =?utf-8?B?MTI1SmJhZi8xdWU5YytOdXlDSHJwSk9uMGYyUjlyZ0JPelJ4bUQ3bkV2eFY5?=
 =?utf-8?B?a2RGU0VKdElDMmtTWHFBNEtkbERvUFR0OG1oSWxNWThqcW02WEgwV2IvNmhx?=
 =?utf-8?B?akdoTmt2SVlPMDk2emZaV1k5RzNNdERnMjR4aUdFZjhPZTQ3QTZpZHRTRmFM?=
 =?utf-8?B?MitUdkFaZnozaFhoYUU2bVJtUVphNVNvem5VdWhENW8yRHg5TFFxUGlqeWJO?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9nABON4QRqYCX74IbERvGqfUFkwegcITUNErTtRfLcyS4cV+K4fAJTtavD7WCeQi/QhqhWcTyCyAjGTFev1jP+lnPa8lArJN/4cXZXpiuGUQIYWMdvpBT7Ct2DJkM0cq2xLp4BFryc15SH+3R75a9lnTks0e4Xup8Qtpe371+P+zSwPhgs+nTvy2B/yFe9vn2TuXlX/tMr2pLH623wqPMmtKA5Zv1HtAWusWTpyxD8uZ3QVPOWWArj5S5nwafl+X0OV9RoYmewgI5PIq/dv9MryO15tijWuNLnk4b3GX+iKPYIIum/DHGJSqiyghnkZVsqk5fSh0xKLCLOhBtJ/pMQj3KW0eVrjfJKHrPEPmg4c79lZCl94ZEQ5SYLtFIT6OzOYc5oUb7aZq4FwGHbZgj/J0HbE3TzJA0YGZ38w47ePvAn138g4cNnBCmLg9mUgVK+DeS06eKecF5lePlSZbmh7TXecfPxVqbBY4EKBxLUr1vnKTPseBNiocF38ubAhHOMc723/MqfzRGrZaTs71UB3oSNBccAFw+qkxkH+U2mdDfXN4nU5/VS0UOh4ICf3a5hVtK6471yGxI/DvLKYds9TzIySDhzaBtA+TGV6t0vg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133e91e7-a4da-4b72-303c-08dd3639e1b7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:27:18.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /r8ojHflp6k+ByDdHCQQFJ5ksMvIZjQDeEjYEzsoo8DDLvtwHwOzabYEBYOH+Lx22bWEgQy39L7ElHUEto4lNYae23GO3590xzbG4OovvtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB8215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501160109
X-Proofpoint-ORIG-GUID: WODG1vEBS6_DxmnASdJt7pUjyW3PuVUd
X-Proofpoint-GUID: WODG1vEBS6_DxmnASdJt7pUjyW3PuVUd

On 15/01/2025 08:42, Jon Pan-Doh wrote:
> Info logged is duplicated when either the source device is processed. If
> no source device is found, than an error is logged.

Nit: s/than/then/

> 
> Code flow:
> aer_isr_one_error()
> -> aer_print_port_info()
> -> find_source_device()
>     -> return/pci_info() if no device found else continue
> -> aer_process_err_devices()
>     -> aer_print_error()
> 
> aer_print_port_info():
> [   21.596150] pcieport 0000:00:04.0: Correctable error message received
> from 0000:01:00.0

I agree that the bus, device and function info is repeated later, but 
isn't this line also about the fact we deal with one or multiple errors 
in a message? The question is how valuable this information, in itself, is.

All the best,
Karolina

> 
> aer_print_error():
> [   21.596163] e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> [   21.600575] e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
> [   21.604707] e1000e 0000:01:00.0:    [ 6] BadTLP
> 
> Tested using aer-inject[1] tool. No more root port log on dmesg.
 >
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>

