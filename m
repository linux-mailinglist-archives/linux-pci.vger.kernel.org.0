Return-Path: <linux-pci+bounces-43039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA7CBD6F5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 12:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF31F3011F82
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 11:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38128AB0B;
	Mon, 15 Dec 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fLq1EeH4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iDJoCxJv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942A28312F;
	Mon, 15 Dec 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765796402; cv=fail; b=tN+OYARNNGUn5YOv0drpDz08qNce0lYTFWzSa5bjLPf7H39Hp77D2h+V2+qqcpBC47QflvRDlC84WRotX4Drrv2rXCoSUxB1Vi91I6IDi+W/cT0XWbnJIITEwjAx//l9J+BQ8gKkAEenm0E4q4URSO+sIl+Yp85z7EN0cRsgk2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765796402; c=relaxed/simple;
	bh=IKwNwfT3OKsrrj1TFqedW4AT1UL/SOpU/Wrz5J9IHc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W6h7a6LlNs+XhZZe/bHq21lmPbVfyHlIWN/NxkcSkkZa0tqXoPflvQVHvofl2agX6Qw1GbIcxLhYhAjI4xEYXr5E3rTT2e7J3GSVMiHnoptckxsz02nSTG9pBU7f7Z13imeTAxlX3eOsYNjF7DCTW1D7fRW5ssBtMD5/S/zqG8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fLq1EeH4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iDJoCxJv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF9v0hE1853514;
	Mon, 15 Dec 2025 10:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PRcK05w4za6ISbkUNV0xyV4amcqJKDtUm5lEvyglvhE=; b=
	fLq1EeH4cXInvixMTZNGiJ6nadrony7Fx8rP4NLS1dk1Q0mczaCe6fJLoeUIrNq7
	QYB9mMmCY7593KYeKVi9vyJFgHO799A8WfEJhL5ctfBvC88ISacZjFfp4dtQJMUP
	Prcbwu6MK+a6WRNwgls7OwG9hSGjcxdoYqf5IkJ5Genp2XVRYhMy2AvFGwDey4FW
	fimQ9XgCBKSgTr4UyRCHnUfqdiDY7xqP0IwNO9WT5f9kG3bQ6NKYAa0UbtgtEjuU
	pTWsIZbAHcFbhS4D+AR8voySqiZ5fXoHyANrsQe0bB6HzIomTD/bbR1ZnpYxVG2T
	aUUTLFPuzbsExBDxUva4SA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prhsvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 10:59:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF9NLYe024951;
	Mon, 15 Dec 2025 10:59:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8snbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 10:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p50bvWo5MarbBIp+YsFAhTSBhWqNp/XlheEfJelmmPDlze6oqEcu+zI0G6sUrWJnO+i7sIiY/cI6ZHAw5DhJBkfIWiuw/eECBL+Djh+xGUrlccMk9gX1BbOEPSWU8BQUtlQOGfd4HnG91KapqOM8EtZ806wl7A2FisELOXSU4Kivux5RvURudf4W+4ns5un2HRQg/FTiYEP2D4AAx74BYveBdPRe5aZN+crvKtJomGLgwZ15zq5cH+9wMPx/S2znSTFzijV/fqNHIPcot6V6l53LULlZkTPg9SrNF6eoYJnzgW7j1mPQHLicx3zj6UXKFYblZCCoitING7e507uA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRcK05w4za6ISbkUNV0xyV4amcqJKDtUm5lEvyglvhE=;
 b=d2dSbTxQDh6VPPQ64ZJpwabCQOH3jAi4FRijGVGbXRYBI2M2lkiTYeH6AB0kF1EWVrIo4AS//nB7kEk6DlpBbeoLdSG6r277AKIomSoK9LPPxee835IizNzaKFdjNRHa/BGolKu1H61yfMWATvFzCjc2agBzaTRPlspRXGwf4E2UXCV6hP4baAYyjLlpQSiGR5W6EkYfECD8SvECKozzOgHRrEgE5il/nU1ytVTUvy/EKwZdcATEBW6TieeFQIkh/7IA7xe2ThR8u7h6il0nfTJ7BYP2zoG/GHJ5grAw77BpBoQa7h/PCKWPDFivZ7LIF0ODBbqtWCbygwWghsw/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRcK05w4za6ISbkUNV0xyV4amcqJKDtUm5lEvyglvhE=;
 b=iDJoCxJvpEJ+gY/CNFlom6tKnBKYVZ5ywvXOT9hV8+s38cr1OtHa1Eo3/2yAjYMnogcqKZ75XfviGsN3wQQulvoKHBmbtUn+UR/I3PmMbzNJK/4qRqHqh+56D2EsXuhY63CVyeX5iIg8aFK8mJ55Ni/DU9eClOkufcjskwATUz0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM6PR10MB4188.namprd10.prod.outlook.com (2603:10b6:5:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:59:25 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:59:25 +0000
Message-ID: <af02c6ff-3a9e-441c-9f99-0528492b56ff@oracle.com>
Date: Mon, 15 Dec 2025 16:29:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v8 2/2] PCI: eic7700: Add Eswin PCIe host
 controller driver
To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com, mani@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
        mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
        krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
        inochiama@gmail.com, Frank.li@nxp.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
        pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
References: <20251215095928.1712-1-zhangsenchuan@eswincomputing.com>
 <20251215100200.1752-1-zhangsenchuan@eswincomputing.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251215100200.1752-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::7) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM6PR10MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 15259289-7942-4dd2-d854-08de3bc902d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGhST0Q1Z1RscUgzZFpiUjYxajlHQ3N0eXZ3bTFOMUp4bVViMlJReVpKcTdQ?=
 =?utf-8?B?NFdTNzdEU01IdVlhNlBpRFA5ZmE1SFBPK2tVVkxVdUxoNzkyU3N5RkVvUjhZ?=
 =?utf-8?B?Y3NUUjE2YjNBOEhoTW5sOTA2eCtlak5OR0JGb2toVkNTc3VCVGVsSnd1Sndo?=
 =?utf-8?B?Z1JBMlZsNDJXTzdJV2VUd0h3akFMcTdCczVoMnZhV1hYQWpOaG5tZ01PZFdn?=
 =?utf-8?B?OEVDdkJ6bWRwNTZRa0dveW5ZNzlUVVRWMjNKc0h6aTM0QVdiUUJPekZLOFJW?=
 =?utf-8?B?M3NJcmI5dUlsd2FxU1poY3pIdFAzQm5GZEdwWGcxU0Zjd2w1alZCa1R3ZDhO?=
 =?utf-8?B?L1h5VitwZy91OU8wNmtSRWR4a0FoVWJJRHFJUjRkcmovQjRaa1NNY0FRc2Q1?=
 =?utf-8?B?Yys3QWhxSWpIdytCcjdrR1lXTUgybXhjNVV6QlpOQ2cvaTFCWWJqVG1IK0Fr?=
 =?utf-8?B?cndXUmM2Vm9ybWM0bjJTQTk4SWUzTE9ab2dPZ0Jld2hhZW1nYkdsU3J0ZGYr?=
 =?utf-8?B?M2JsVUJMTkVIQWwzcHg2ZnpBOW1ISmJuUEs0RncvVXAvbFhFZ25IbVdmQkwy?=
 =?utf-8?B?MmNZVWlFN21RcGF4NDV1VHFhNE1JVUJWVVphTjVxS2JvUHlTM3pubG54cXhV?=
 =?utf-8?B?MHV6dUdhNEt5Y2crOVVxNmFySW5TdHByenFkMWlnUW5iQkhKOFh3eDUvWHpS?=
 =?utf-8?B?V0pOdXNqeUdidU05Zms1SWtsaTJWc0RHalhWd0xlcDIxblR0S0NtR0V0U2xD?=
 =?utf-8?B?SzZISlp2dHF6TzZaenhMWFg1K1BSYkhlSkxXYzJpL1U4S2paTC85NC9CQkpK?=
 =?utf-8?B?QVl0M0dyeEZVVEJGTEg4RTFXWnBHUEFHOTlvNHFtNSs0RVNJWVFWYlVmcmFV?=
 =?utf-8?B?YmQyMm8rVHNTZGRtREswbEhXbE5RUXJRZEhXZU9sRFJIQmd5elFibWg5RitC?=
 =?utf-8?B?L3JabVB6QWVVbkQ2akhUNjJoczRNOFdNcm44U2lPbTVyL00zMWhuZHBmUU5k?=
 =?utf-8?B?Q3k4M2FEVWZnTU9ucU8rVUVMM2tPcm1mN3NDbnNsc201Zll2T2owS2dOa2dR?=
 =?utf-8?B?UXJSc016UWtiT1hhUC9hZVJpdlE0RFBlc0Yyenp3YWhMd0p6VzBIWDNySG1X?=
 =?utf-8?B?czFHRi9LTDMzVTgwKzZ0Z0U2UXZyZDJ2Z3FrODF6aG1nYkxyY2M0SmtmMHJS?=
 =?utf-8?B?d0lMdDdtSTkvUVg1NlgyTGoyc2NYM2N4aHJNZUFhdlFOTi8wbHFnd2R6Q2pW?=
 =?utf-8?B?N3lURTFvNXBhNG5PVjd1OXEzMVdWZ3dzVjhwc3lSWUVjQnMyR2J3ZzhoOFpC?=
 =?utf-8?B?VXRaS1lma1FxbXlVZ0swRnkyaENWU0JDbGhHM2lGbzh1b3MrWk9OenlodkNa?=
 =?utf-8?B?a0tRTXllVVRTQzFTd1didDNId0VHYVV0QmgvVG1wc3dxNlFQSURNdXdza0FC?=
 =?utf-8?B?eVlLNGFsRXdYZzNVMG81NlhpQTJZeGZkRHptb0JZaUJVT1BuOTYxUlVkZHds?=
 =?utf-8?B?R0V3Mmt1VStod3ZPUU44Z3Z5K2pxaEl5dWJRUXZzMDJqcm81NFpORmhHa2tP?=
 =?utf-8?B?cnYwSVNwdC91b0lKVmlJa3RkMXJDSCsyaHRKNUVFTFBWRE9XaVRlREd3WnV5?=
 =?utf-8?B?ckJHSHJ6T013cUUyZnNQZ0Fxa1FXOCtMdDBtYzZPd2ZUZVlNMGhpcTE3QzU2?=
 =?utf-8?B?Y3RTYUdEaDdCRTNLV0tQYWZScmVEbUQxTEY2aFlOVWlwOXNFRkg0YTM5VDZi?=
 =?utf-8?B?TWlMY0J1Y2RmeEZ2TDRRRk92MEMyb2draVovc3pBUlFVYnY1YVNPSUtLQlZw?=
 =?utf-8?B?NUpPR2xXV25Rd3J1TkVMSG9nY1VuUGFmckk0bjZQazVMU0FmTVArNXlNRFdY?=
 =?utf-8?B?OXV6TktGSFZJRGtYRDJaeE53R3B0WXZpT1lITTFkQ2hmZDdjM3BMZVVYeEFG?=
 =?utf-8?B?UFNoQTRyc0xhbHBnMHFSQ3FpaDJLODJHZ2lBdms2R0NmSmdDbXpCbW5GeGYw?=
 =?utf-8?Q?OOcAsNK9kxDwo3zwiEMvj/kNy+ey8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmFpTHp6SHIwVkJidTZlNzlWZFZxZmR1NloxK3Fvb1dQZTF4WkRWL25HUjNB?=
 =?utf-8?B?U0dvMVM3YlliM2o3S042YlAzcU55OUN0Q2lWYnRIakNaY1NCckwrejhKNzJZ?=
 =?utf-8?B?NjYxWlpJcFg3emc3QlFCZCswdVlTbDF0MXNyejZCNi9OK1gzWHpXd0Zwa1lJ?=
 =?utf-8?B?K2FCZG1QUDJKZzdPakpENDR0Yyt3OXE1aCsrOU9aWXNWMTdpaEpxWW96NEp6?=
 =?utf-8?B?aS8wKzZPY3k0RmFBOHgvQUdpYTVYODFyZmNmWnJXbFMreTJXc0dDN3gzNVNz?=
 =?utf-8?B?L2lDNk9WTEk0ZUhwQi9YeU1peDV3a1RiK284RFJEVyt0WC9zZGhENHBKdU9R?=
 =?utf-8?B?S0dBRm1RbUl2WWNzWG1QaVNpa1l5aWF1anRTa3N4MEcvUmhvQVBhQ0xpVmx1?=
 =?utf-8?B?VktUVlI5UlZRTnNvbEQvUXFXMmdVQUc2d2pPSnY0eW1QVGJVd1k4ZEV1Q3hh?=
 =?utf-8?B?WVZzSSsyRUdmY1p3dnQ4MU1XdnlSR3ZHMU1LaDI4MittaHV4ZzZRZFpOOFJL?=
 =?utf-8?B?MkZ2N3RxdVhudmNDU09kK2hVbG9kL1crWGFuN3FXSFhtUy9MLzZ3dDlQWHdX?=
 =?utf-8?B?MDRlVEl3T1hZVmdiU2FIUVJIMXlxc2twdFpYakN2VmRXZktHMnhKMEdUVDI0?=
 =?utf-8?B?LzVSOFNoQXJFMG0vN29TenVpWFRTbHhMR0lDY2NEN1dNc1VFZmhYOGV0K3BV?=
 =?utf-8?B?NzNXKzA5RyttNFdrQW14Tit3WDJpR3A3akZMd0NyYytnWHhkck9JSlpRR2h2?=
 =?utf-8?B?aDN4NGdMTkoyRmJCZTA5eFoxUklrZ3g2Rjd3WTU3STZiTU9NTEVNb0psRDVy?=
 =?utf-8?B?U3hjdHNpeE5KZ3kyVFM4MDRSS1pTZUVBaXozVmJJNXBrVEFMZjRza0NDS0Vk?=
 =?utf-8?B?cUJlMHFxQUptSzJRdlJNNERFYlJVeXJlMGhUUXMyQk1KMzVoNUJXNi9Uemdz?=
 =?utf-8?B?aWZzRmdKWG5MN0V3WHN6OUE0SWEwOUNHRXgxdXZCYWR1dngyNk9paUZ4NGZz?=
 =?utf-8?B?emdJdVh4Qml3ZUU2VVRTMmNEYlJmRldWam5zNUNqWXQwOGtQd2t5dmhwSmd5?=
 =?utf-8?B?bmYwd0JYWGY1bk1WVkZxdmxEc21zQWZrQkxIUmg2RUpTRzJ1Z0FsOUNObW9T?=
 =?utf-8?B?aGNvNGdBVUE2Vzl4azVpK3JPaUswZWcyQkRsZWliK1NIQkJLWW5BVnVRV3c4?=
 =?utf-8?B?RktUMkJRR0duZkdXRDc5YmZZWTVtUGptaHlNZXJNY1pTcC9ybGVtdldxMk9j?=
 =?utf-8?B?Ylk0TEIvL3l4UHkyWTNNS1JWai80ZjM4ZTYvQ1VXVTc3dmk0NFlHSU1kZTN3?=
 =?utf-8?B?c3J1MVoyMjRZRWEwQUxQMWdUa1d2SHR1OWNQTFpVREVPdkszTUR1Q3ljNENv?=
 =?utf-8?B?MTRYNDlMV0tTeUhBc2kyR0JZUFJZbWFJVVFVWnU1NWFqaFdpRDl5bkg5ejNu?=
 =?utf-8?B?K2J4R0E5RCtvd2ZsK2NQUlgzUnkyNjlHOTQydlRQWEtGUy9OcllQanZ0T2ZQ?=
 =?utf-8?B?dWJIL1NQejdnOVZhNGxDeU41UkdoZnFrLzdXQXBpZEZaL0RQa0QvclJ5dmVX?=
 =?utf-8?B?R0JkaEdSQ3RxMEJhZ2FneWZUZjRtVms3azlKWGFMZTQvZitqQmV6ejlFVzcr?=
 =?utf-8?B?R2MxbnlJOTlDaDZQM05sUjZQRHFwdy9kMDIzekJ1N2YrcTBSUjJFRUVieldO?=
 =?utf-8?B?TEhZQWNTZERsamx5a3FZN3FSRWkrOStLUXVKVmZ3eklKNURDZDJCRDM5Rms5?=
 =?utf-8?B?Y1daM1NVbUorSFZpS0h4SW5ibzFNbGZnZHhKY3F0Z0VHVDNoaEdqQnBDNVhz?=
 =?utf-8?B?TEpyNWczaDhXbE9RY1pGNjRscGxnVEFTTUFoWVljZnREV1FEcGVKTis1bC8y?=
 =?utf-8?B?c25TRm9iRUU0Q0hFVU9OR3dxclNneTlLMWwyN0RHUWNMc2k2MTljVjZMZXV5?=
 =?utf-8?B?aUdpSDRXcTBOS0xSUWFiRVJWNmZBSTNQbURmanV3dUUyd2tSWjJXdEhuUllS?=
 =?utf-8?B?VnhSMkhXSVI0alRJaTUwSEM0Z0k2L09lcDdIa0pJaUp3ejZ6Qm1nVUZMeTEv?=
 =?utf-8?B?ald4RTNCTHBDS0RQV21iS0xmaGlCWUlvVlRmUkZMdGJvSkU5ODl6Z3MrSFB1?=
 =?utf-8?B?ME9ydHMrZlZMemxwWm9rSHZKV2dTZmMveDVwWVh2SnlhZWxpbysrcWZyWjkz?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ip5uqEFuh6rGGyaErPHXlbBLrILQtOznnMBzkumlAOeh91N1+sBflsPC2O25TDszysxh+KFqZN0q3g04KNFIvGZxkE8SGvaOdRtMjxFjpKb9M/5qPH3bCti96cV9rgytcEfABvWKi5xOIDJJHrrhgZxq5blBof0rwxE6ii4yfBBy7vb5B+FAHcoC83hSdgRLDkqZmjvGpSrMI6hBS0RlxjOpZs5nrg0NE7mV7adL3Vto4n9tQ4G41OmL9H7an29Sp5n2ne0/QkXDS0Ncrbd7bsPxFQvjtss/qgMvvJoU1oWy4o/L/D3PBT7zuyflpMaBWJsLH7iZDj4c2elnxoGjB/4Uc1slQ+YZk51IDxGiEbzrG5hg3uQP4NQmC74/AriZkBW4WO+D+4wcOF3Gz27owt5iDMQNwKJ5goB7gDofolwivnGHpnzcwy7x9aWuLJHtKVyb6fsciaZYaqxWbVXMWDZwid2dLh4fhoF+0/ug7WQT3Xq0wRlAftAxL97/rMTzhR5czxWXugavlqEclFbQVcVrxTwSCctQEHykMwqC9f5PVLcte8xsf7qE1z64fmzgI9vzIS/yDKzUst7Sj8n+5pF7zPMwSrUP6Edh176PiBE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15259289-7942-4dd2-d854-08de3bc902d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:59:25.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4CjvP+BAnXpMA9WgbV6gzd6zkI0McKurXAie9gLr6c6p2njFL5Zec6nAZg0vpJHVqvgPS6NgCmn94AfJWMZcT2q9mTy95eX2iVxSTOA9lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA5MyBTYWx0ZWRfX9+jVvBzx3WgN
 l6AY/gQpGAqGnmAahjCj5lFmGrbNMW4w6qXd4H8OniV1fTRICNvDEI7s+/XPbTvb1wiyxsyE5jp
 fbaZa/OgSsRJqni3r1Un4agKV7+YFJpi85TiRHtI6SsgnKUxLz9StYj6IvF71KCIFPIPa8jSXDL
 o8Ru0vG0SZe+euqKl6kMZZjPeuEIceLggLNZKy28M79O53OCBRTRAUdvesDo/03vszhoeWF2rHR
 NIq2Vudlgfs64toxM9Jc3BGYJe7ZgcnXtJ6y7Map5AF9V5JQ/akIN2GpAndthsfzKeuDywOlqAY
 rlUg0+kKbdcmHlHwX9SuNk4bQwq/5yPKh3pQl4kC7XY+pfLRW0uQhe7/PFG6pVWEbS1dgs/mKU3
 tTFevSL4YtWrIYUo20Ld0EfjwUD8Dw==
X-Proofpoint-GUID: Ttrplaq0cQ9U5G29pIH3VJd4I54YU98I
X-Proofpoint-ORIG-GUID: Ttrplaq0cQ9U5G29pIH3VJd4I54YU98I
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=693fea11 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h4SL0BZ7AAAA:8 a=5N3NIffLigoG6rt-7kMA:9 a=QEXdDO2ut3YA:10
 a=Cfupvnr7wbb3QRzVG_cV:22



On 12/15/2025 3:32 PM, zhangsenchuan@eswincomputing.com wrote:
> +	/*
> +	 * TODO: Since the Root Port node is separated out by pcie devicetree,
> +	 * the DWC core initialization code can't parse the num-lanes attribute
> +	 * in the Root Port. Before entering the DWC core initialization code,
> +	 * the platform driver code parses the Root Port node. The EIC7700 only
> +	 * supports one Root Port node, and the num-lanes attribute is suitable
> +	 * for the case of one Root Rort.

Rort -> Port

> +	 */
> +	if (!of_property_read_u32(node, "num-lanes", &port->num_lanes))
> +		pcie->pci.num_lanes = port->num_lanes;
> +


Thanks,
Alok

