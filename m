Return-Path: <linux-pci+bounces-22344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5836A441AC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC0C189C16A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D6326B091;
	Tue, 25 Feb 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VR9AWvBZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MF5k9IOq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974C26F45E
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491855; cv=fail; b=BlxZniCWu+ZiqQGB7k2dmMUpL/5Uj88kq5dB5iZomvwXeKKdnH1LccrzvCvDkUUhh+Gvs/7/6UF3q0BLerfbrmNvpTGYplQRD5djyh1W8jAft8VUgfDV8vb/PsYeoSwh7D+N1Dk+dFd5f2I/InLXwjGZ4Hp84luSRGHV+u7Snow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491855; c=relaxed/simple;
	bh=CNiwHbkCxovK2QraiiuTO0O4HEZWZslWy8Lutv9/dPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d0m964RawL8kcVpeyJJrCXuFWhn4yKdEUqtVOpoldJJs2K9rYr2uRSWm/5JUJ+320qO3xIodfOAQ20MSMSmXYlPvUJSuAlfaY+SqIn+aRIh6oo3oq+TIQ2799p/r5Cb9Er1f+vl1+Rb6IXEda9RsCmzFD68FBhsus1Q2lQnt8Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VR9AWvBZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MF5k9IOq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PCfbFH023639;
	Tue, 25 Feb 2025 13:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bPzbI35FTMzvurLHKRY0GCJah0PjZF/NHfyutsUC78c=; b=
	VR9AWvBZgB0dtAmZdPmGyASE5+T1g8bhp6ic3u/6zgRktXLWK8Dg3rpmvr7Z+Dh1
	/8jDlE939G87J2IBWV+5abKleJuVeBsBSQzW0mRuP7qficie2l0kurCgVBLzvr5N
	3rRtNKZ5f6ZcMyUxRrU4qiMbEt1JVGEhixooX9nUehAn7yoOpe1KdUIER4wzYVct
	gQyIiWU1A6rBYi4xKozcCsWDtB1GijfYTdPpgpJh1nnmWQEKJibn4Ai+bNBKEhQ7
	kkbkwBBqyrnnjvZbgXK2X84RO+ZPBEmBD/jN+5gvZRIavOOT6EvOEIy2i23XsQs0
	OkdvZjJJ1kc1+mcqRIxZDQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bn8be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:56:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PD9tVP012753;
	Tue, 25 Feb 2025 13:56:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51af72c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 13:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hm0rwXeu2bz9i5uFLZOKQprTm0fNWdZG/1yT5/lqvHD5+dK4/ZvZNeh/TFiMube4xrXPdtd2k8jx0JQsk8h9IG2pbUjZUTFQKk9ThpHPNo984hQotJZMCyzSUPgtL5zz3QOkLi3GNiQOdNFgP1ptG6sxFDx1OGetuUYDVLZg0Ak/m/uS1i+fNaahahoz3Jdhd/qFxUP2aadcmblyeVf57pNh3NDs2irzHwu6z9mjPdEYkKehWiJD6k5q8IofuEkohhJDa1aPCXQdaTOxszOgKj/Go9E+fCmmY4u1kLz3GRDNZbO1uyTKIsymxAny/jK2+tE7ehgokHmqxlzi7bQ7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPzbI35FTMzvurLHKRY0GCJah0PjZF/NHfyutsUC78c=;
 b=jVxFzz9JW5M4maw51vtUsZYO5O/avea8aRd0xyVNIzXa1l4tTpxcBrbZ39J7DJe3LxFKiQMHj0HAFhaHUGhG0rQtqxaIfw1DRN4flf5m2xYuK3Jw3sK5u4NDFeX2l0OkPJortUM8zGcW2271jwcgiDZqNgrKYfEZsmBvaNuUnXM3FRu8dOlRW1ucqD3aKPdVd8dElvr2ub9zzbn0bhvv9tqANZVGaZw50aD5JZ+FBIDilynaRz899ig4Pqm1jvDnD6RQLFLKeQvhHSxBSWnpyRMZeU2u/JC+JED+CRDggtQr5RCx72r3jNRu/KlsA2dGpKsUkPHvMK+w5pzUs6i6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPzbI35FTMzvurLHKRY0GCJah0PjZF/NHfyutsUC78c=;
 b=MF5k9IOqqJJSBXG4gaKXu+j7xQCFHH3BN+bXP29r4ngbj7Xvoee9rboNpHqm33HB73jkVXN9LdUod0XT7efcXVslrHI358V5JHmYFAeUmQjcSt6lg0yZpUx++CEQKbelO80IgrndRdR5fP5mSLWL3A1/zm1IaJmMssZB84CIJJw=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CY5PR10MB6213.namprd10.prod.outlook.com (2603:10b6:930:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 13:56:49 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 13:56:48 +0000
Message-ID: <319344c5-02bb-4257-92a5-424ce72654f9@oracle.com>
Date: Tue, 25 Feb 2025 14:56:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] PCI/AER: Add AER sysfs attributes for log
 ratelimits
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250214023543.992372-1-pandoh@google.com>
 <20250214023543.992372-8-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250214023543.992372-8-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CY5PR10MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: cb873799-ec11-461f-82cb-08dd55a43f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmN5YmdrY2REY1hNZ3ZvU3NiSHhWUEFiL1ZpZ3BqWE45eXE5WFJKRGVrT1Rl?=
 =?utf-8?B?T2ZnTHhTUGFyREZ0REpSUDdjU2IvQmZZK0RxMGVVQUtrQmFaeXhYT3lMc2k5?=
 =?utf-8?B?c1BIMmhCQXFBUnRYL0JvQmQwRkd6Yi9UTnFLK0VJNWVtMktYL2xMMkNMT1RV?=
 =?utf-8?B?eC9ueFNsOU5TN0JrOWNjazBqL3ZTeHliVDVja2Z5T2FycXZXSTBQOE1NSWRn?=
 =?utf-8?B?ZkhkcTRueXRwcWhubHpHQzYwSGpjcCtGR3ZpNHI1OW8xd25JNnZGcmxNWTJJ?=
 =?utf-8?B?Z3dtUThXSnVrOTJnNC9STExKZ0REWENZMkRIbFJIS2dsV1gxL3E3a3IrZkdn?=
 =?utf-8?B?WlA5ZUsyam1POGVNOTFSV01PQjJJZGxnY0gvYi9haUowTlpLa3J4MnF6Y2h1?=
 =?utf-8?B?ejlGQmhqWUV6S3Rybnp5dDhNUDRpQlZDOXJyaWtOU25UZTI0UzBzTlRNT01Y?=
 =?utf-8?B?a1FzUDNvbVRNOHdHQWVtSXYwNzhqMm16YXgwbk1DeER0WDFhYndwbXhjZEND?=
 =?utf-8?B?SVlRK3g4R2JqOS9lcW1kbWZMOHl5OHVsdmdlWlhWdkxwclUwVmtwb2lZQlRx?=
 =?utf-8?B?SitUQzlpMHNvbGtKdHBoR2ZhN0cyTEF6RVd4WS9DU1YvdklEU3RTeVFWTUFO?=
 =?utf-8?B?VlVYclhCTDcvdW9GNFlYZzFpZWN3dnUwcUlSUGU5RFhJRU9EN08zTjd5bTZ5?=
 =?utf-8?B?cTdvLzkxTjZDaFJWTXh2VERyOFNJdnZuVDlFT1FWcEFsUWxXOHBicnhCL0tZ?=
 =?utf-8?B?VVVac2RBblBHNXFvc2dtdFl3a2swRnlBTWJ3VGFMOWN2R2VscHJDQ2tsUWM2?=
 =?utf-8?B?eTBEaHlrYzd4dlhtUVkvR3RqbTlpaWFhZDBXUkdnZ25TOHM3c2d3aHRyNmFB?=
 =?utf-8?B?TXJkd1U3cU8zNEtzTWV5RkpYTEp1U3NpMGQvL3N4MzhIR1J6dXFFWHd0WmNw?=
 =?utf-8?B?WTdGd2lLR2l4VjloeWtRY0hBSzRVUzdnTzE0SnV4VXZRNkl1QlNUU2g3Qktw?=
 =?utf-8?B?bG0zeFZBbC92aUt3d2hkYnRLZkdRTGdGRUUvdXQ4d0FLZCtVcGpKWElHODVu?=
 =?utf-8?B?WG1OeHpIQzRnd0JQbTJJd0wxK1ozTFdvQjBYT3RUTU9ua1FZa1AzYmFzbHBG?=
 =?utf-8?B?cWlXS2Rzem5BNnpKRU1GanM2SHRQVXdFZTNhRVdCVWJhM0VqMG5ueGlOUnVa?=
 =?utf-8?B?WW1YZEZEUnVhTFV2RGM3ejhqL25xSXNYSmp0S3I1WG9XNFloMWhHMjlnWENI?=
 =?utf-8?B?R1NoWHk0YzdyVVIvWUl5UTZzVXJ2NmgwK2F2MUNCbzZtMEFrZzBmeW9Yb0Vm?=
 =?utf-8?B?azdJWU5FUEtOSCtMRjNxWFF5VnRTdXRUaXRnOFJ0MEZCWjAvMmxybkR3Y1R2?=
 =?utf-8?B?QjNDeC93SUNyeTRhU24yYXJSa3R2Q21nZXNqdTFqTm80dmtWT0VDQ2xBSlVj?=
 =?utf-8?B?THRKb0NHbEkwS01ubUFpSEdaYWJDKzRYaGVsSml2OVNER3g5V1IwOTBGVGda?=
 =?utf-8?B?YnZQN2NmNXRtWlpieDBKVStFVkpKYlZnU3FacEhndWRZMHNLUTl1ekM1SFlV?=
 =?utf-8?B?ZlpnUXZQMk84TnR0UW1Ecnh2TzNFaWZrcS8zNGNnbnBzaVVMRkt3Q2FseWZO?=
 =?utf-8?B?ZTB4RzI3Q1JvVDduc2s4MWkzbWwydHA5Y2UvK3JvYzNZNnBiN3BSSWZ6WnE0?=
 =?utf-8?B?ZnN2NTJIQXYwTDFjbXdxRlRnS0JnZnhQR2pRcFQwU1E0djZ2YjQ2V1ZKYjJQ?=
 =?utf-8?B?eC8rd0VYTnlnenlsaElHT3NRc0dvaHcycEJTcEl4UVpYbzV4YVVRZXNkNXNx?=
 =?utf-8?B?QVQvcHBoUU5rQW4rdTZHcUJCTWJySWRnczBVRlpHa2J2Ulg1SGdNRFhNNEdk?=
 =?utf-8?Q?0w9k7OnzbYxD7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3VFcTFPYnFxVGEvUUp1aFhoUkM3S25zNlVGTEUxWXU0THBIUCs3UWRrOTh0?=
 =?utf-8?B?eGh3R1dXU3NXS0ZSd1AwTHJwc2ZqVmxoLzVmTVBwQkE4UEZlSUh0Rk5yM3pq?=
 =?utf-8?B?d3dLRnRNSFk1bFFrNmtCc0xybVY4S3NldFg0c2Y5ZEJ2a2tJSFpBdXh4T3V5?=
 =?utf-8?B?YkpCRjAwaGFvRDJsZ2hVOHY2VkNXVjYrNkR0R3ZzRDg3VFV2elFNQUdzT3Qy?=
 =?utf-8?B?aEZiQWdSNTRUYUMrNnV2WU5qeFVublFSbkFJa3dvQVJTcTZtMHMrRVFtOWpE?=
 =?utf-8?B?cERjY1R2eUx3VzhEek9KREFWYVpoNlV3dFZqMzBKODdEQ2tsaFZiT2ZDdWtx?=
 =?utf-8?B?a2p6YkF2ZmN5WEx5Tmt5Z3pyWE4yV0NhNVhobGJ3NiszYmNNWGFKb0ZKKzJo?=
 =?utf-8?B?ZmhDOUo1VlM2UkZhVHNPTnBKV0hRZitZamF6eWNmWVRiK3l6V0tiMkhTbHRS?=
 =?utf-8?B?OW05RkpVQ0ZuTUNUdElxbmh0ZGtrK1o3YTJSTzNxZGVRMWlvdjlzV3BQMmht?=
 =?utf-8?B?d2EyT05PdUw0L1JWRkdsdzgybVRSREFSRi84bjBBdi9YbkN6a0FlRFV2dFRO?=
 =?utf-8?B?ajVlRHI5L3d1UC80ZURCcllOc3J6VnVjZzQxYmllb2xTWGRXWFBua00rWjVm?=
 =?utf-8?B?NU9xTVRDL05oV0VzdHA0U0w3aGxOVjdWbDA5VkNmcTVLUWlQajlBL3BDRnFK?=
 =?utf-8?B?NytObjE4K3lvZzVzR0hDT2J2eFlLRkdxUEdablIyNDR5Tkk3bFRrZ0J0TjNP?=
 =?utf-8?B?ZzJBRllVMkZaejhPSGJMSE5meEtUaTI3ZXZMbUM0YU1ySGJPMGJqVHE3Qncx?=
 =?utf-8?B?ZVoxQkFiYW5TdHVTdks0alZJMm9LTzI2T3h5VTF3cElXVC9Ed01WeGxQUE1N?=
 =?utf-8?B?M0JuOGpuQ05jcS9URmVVeUNGMDN0d3JLNVJiRlFzWDNTRW10ZFZwWGU1enY2?=
 =?utf-8?B?blg2RzV5V2RJMlNiOEZzaHV5YWxnMW84U0pMTWJzSHBCYjc4NUVLR1hTUkUy?=
 =?utf-8?B?b3UxNStmYWNNQ0FtcytVUW9nbkNvTG00NXJqS1J2TUNGWXZNVTBkM29nQXlF?=
 =?utf-8?B?bkxQN3V6QkxBcm8xcE1GMXhyNkd6VlErR2c4WmdBa2YvQVVJcTJvVTl4TytT?=
 =?utf-8?B?amdWOWdldlo2Qkd5cGU3VDRsKzc5Q0JadHNSMzR6V3JIM2YxclhTMDhiSHVy?=
 =?utf-8?B?b1hPcmR2MFhLK2cxdWJTVkhlZ3ZNRVB4cGtjSU9Zd1FJdXNXbTJFb3FpQVow?=
 =?utf-8?B?TGozK0ZvS3FpUmkxbk94djBIRExxdlZCc0tEQlZRUTgxRExXK3YwOVNzNjlR?=
 =?utf-8?B?bTJHc1dGOXpGTnRJQ0NYNTNDNlYzSlVORzZiUE9kSVVocnRIcTNXR09USEgw?=
 =?utf-8?B?dlI3R21ybU1DdG0xSG1MWkl4UXA3aE5iZVk2bHdteWRyckhncHJwNGpIcHJN?=
 =?utf-8?B?eEs5ODFQTkJzVFd6WHNWODRhZUtocXIzSGRlQloramxwUjB2L2tEZWlhYXhZ?=
 =?utf-8?B?TGhKM0syL09Ocmk0UE51OHpra05ucG1oT0cyY3VHQlNEZXVmQy9hRTNTQ1pC?=
 =?utf-8?B?aTJmakdwZ2F4aTRmSTRkV3RjTGZXdmY4VFVPTVlaWTkzVWJrQ1RPVTJYMXg5?=
 =?utf-8?B?cWxFb3FoZGpUSzg3R0MwZjQrL2lxaUpCL3RGLzBFd0d5UlFTR1laVEs3b2xZ?=
 =?utf-8?B?VlYxakpDR0VQenNMcUhCS3dBcG95cDg0NTBYNXlEbVB4UE9Qd2JXVk5acXY0?=
 =?utf-8?B?eWE3MGFFODRaN2NOYkRTTU8yMXRsSlVGclREdWVaV0ZFZmk5Q1dxMk02L2ZL?=
 =?utf-8?B?QnpUaCtmdU52aHFCMGxkcG1NdXRsWWRMZVpka25OVzk0bkNwa29NMXhTSUJJ?=
 =?utf-8?B?TVc5aG5IQXJsdjZCQWRQdVpYOGw2SU9XU1YwdmJTTUhsMWhkSHdxT3VHWDF4?=
 =?utf-8?B?NmJSckJ2V3YxdFVnaFFBVzkyV3RNUUNHOWVvUDFVMVczcVIzbzRjYWZGZ01D?=
 =?utf-8?B?YkR6TGpnKzdFQ0dGVk9TT0ZGdkx0c2pDYTM1aUlCUHFEY0JJYkpEelhXZ1Rl?=
 =?utf-8?B?ZmtCK0hVRzNUSi9IM3JVbGw2UkVCMTJLTUtDVEE2UFh3VTZJWGxZQTRFQmNL?=
 =?utf-8?B?SUtuU3ZabUhnYUdnSTd2clJ1VS9hMnlMN3NRUVFON2l0bUMycXZSaHhjYkMx?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QAxLPwaFOf864FOEMD+3UAJB6x+JyFxSO+lp0uyJ8HD2pHQ4i4LQ0hIeG0yl5K6TArLAcQ1lUAhZDMHAHMv3dAtTO02N7ZAdEUFYql3PI06jxq69ld02oKbQJJdnmu619IrY1YJSVE2XEYfl2DaULcsEnP1rHaESlwkh5A48oXB6A6YeYZNlmYubl0xuQdg4ogVMdS7Ve2TxsInNI2rsfpEu1+wfrefPW5GBmi982B6WUvlbIJj/5XUHa4gfTlIZMsrAIXTJ0yjBTBcYDYBM+TrF78ruhp2hkQfS1Cvh2K1yfYdfmuyQeOIRW5coMz6ttiJ2c70NmHVuXGXhXmzvN65RiDj6ilTeAo/QJQ4EqG9jPvDYeY4WE9ca0KSJ5tNxJcuYCdlJU83etR+DrD6yHC5Pj9h4WV4GguFgE9SYxwzgVu3Y0sgRj4xnYcJ1y2Sgior9dhYvY3Pxr92ujS4TNvKsVNXC693JEH8+vViY6Yh9ftXpo57eoDWLvI8NdM3o9QE59QxEfeWop/OCVQothJmWQOi9nkw6B2aZcXlS7avO9+rAwVy/E1/3NXodKGC6xwH20oZOSrDbc6fh+W4TqQcl8+e3a1xSaSw/oBgw9xg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb873799-ec11-461f-82cb-08dd55a43f90
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:56:48.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK5YoxS+0lv9FKb5+Em4TLnyme+5oZK92uEjxpjzPuMdVvDtMPeMag8GHu9mODnFB2aX6WiLE6G7+ek7ihFYTCzhPFBmgOkV+xQIoOfKNQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250095
X-Proofpoint-ORIG-GUID: Q3BEglM1xN-3LhtPd9wWWx3nmQt9RF4Y
X-Proofpoint-GUID: Q3BEglM1xN-3LhtPd9wWWx3nmQt9RF4Y

Hi Jon,

Sorry for catching this one so late:

On 14/02/2025 03:35, Jon Pan-Doh wrote:
> +
> +static struct attribute *aer_attrs[] __ro_after_init = {
					^^^^^^^^^^^^^^^
This is a copy-paste error. These attributes are in the read-only region 
and can't be written to, so please remove it in the next version.

Also, what value do we have to write to turn off ratelimiting 
completely? Can we handle that as a special case?

All the best,
Karolina

> +	&dev_attr_ratelimit_cor_log.attr,
> +	&dev_attr_ratelimit_uncor_log.attr,
> +	NULL
> +};

