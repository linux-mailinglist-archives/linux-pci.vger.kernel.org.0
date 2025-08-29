Return-Path: <linux-pci+bounces-35139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949AAB3C1AD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 19:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EB5169501
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574E13081D9;
	Fri, 29 Aug 2025 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QGTCeYIT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yNIuDCJR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9F2116E9;
	Fri, 29 Aug 2025 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488146; cv=fail; b=Nq75X4nwAA3mWu3CKEbiSd26HzPthesPjzPargbk6AUPNw0b6es041hLzg9PpFBotPFosNU5bMNARoAAe/fXr0b67wAGcClQqrtDmNc/GRikw3pP/hb4ydogq1UO1armxeGAPIo/PDDAPZQbKni9yqsGcY5zHWhlRfr7UxETIgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488146; c=relaxed/simple;
	bh=8/S5AdWim9qf8RvzOEbeBeROGAZj6bMkoeLOGx0qzl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fPm/2Lk9ggcZ3bsqe4ipCLEs/QhLPFoA0AL6zOrKZ6/bjoO7IRAHlS/QuiUZ0Z4oN7Nd2BB6xPKPjopIiyWfp4GDCQI/U+JOygH0ieqm1orpXxjuKSO15xWfgLKR8zggZy4O934qC/BjOpJ09WlPP+2IFQA8f9ahBa89hxMACtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QGTCeYIT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yNIuDCJR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGfxdK029800;
	Fri, 29 Aug 2025 17:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yVxAVSF3PzFqOlEQCg5baXprRDlAcrfLgaT8up1OqQ0=; b=
	QGTCeYIT7IIr31ABa7KQk0OwSLbLV6c71/8qEKoZEN0ogvtEWCyblXiIj3HjcAi8
	fwzlj0GUuP35OK4R1gHwMbhRR58GJNLjPvkxqhKHuB25CjVtmxqmpZzfZzbE0m2u
	wD1zm8Ubtuh7B8AuVDIcl62p4JP92tYG4ZBnKQacAYgvAJSm1N4rzvr4OSVf5zVH
	6t2MhBDQVElPgpaa+vz3WMdhcPhTdz0ZcJex6fX7hUStjA76k5nT6PYxiJ3FPisk
	g2NpRRyKBT5admSX/jnPAE9CRPvnp8LMdNMXb8evaNYjfh8bJHHsQ3IdwU5Fjc66
	DGtpW06M4709UzJYbp4B0w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48eu0tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 17:22:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGxXvo005057;
	Fri, 29 Aug 2025 17:22:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43dggxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 17:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ4y5WKeefQ0iZ5HN3jipzPJlt6fkr3TB+EZVs2J2ZZLDLgAIdC8yjbgbMAHPL2CFbenGGO95/mBer898NbKc09twQZzMfQ9yTw9js4IYzr7NraoRcH0pLVh19YbNxV5cHV9UInMyMVIhAMEP3jGiNhbNj+pesK7FCQBg5DEJ8qaCsIzxgIx13h0IMzOBJQ4+nxBZzxrxgHFWON9YtnVE6Ba5YoTtU7RNGOxedKWPUHqgFgwr8tCNQtHnfNVq2ZZa17ZMfmc9zK9gVA+iG2iNur7GS4WWcugc9NMSO0oKKuFBhUWhFSenCSnFsChvCkKUuo7dJ+yudX763Qi67yOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVxAVSF3PzFqOlEQCg5baXprRDlAcrfLgaT8up1OqQ0=;
 b=mCuxfrXNeX20HY1SUiSfBncDDK9PKzDv4DkJMDfFMynZ3u7jbeRetYW48yVpx+zp2MO+2M3LkbNycp+7u6e2baBveli0rT3WX7wouSFeq31qPecx+KpzkdaACl4RX0VfpZo7qagkn8B64VbSEh5jo+qGAY2RQKzUiRRrm6NETYx/mqjvtN7XQFZEeVWnS/RtPhXL9UfWJcq7sKt6bgRca/TBvzwK6TPpkqnVHE+YjzmYDQEdNKCiipJYZj2upny6aRqs5zbUwexV2XrwmbozV6ngRmcDdzOs+g56Pgc+5mCEr50KxTBptV7jiDYOLtMkUZtvaVe4yRGnbn9kctbCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVxAVSF3PzFqOlEQCg5baXprRDlAcrfLgaT8up1OqQ0=;
 b=yNIuDCJRVJ/mAKsxUvQOoaEjp+3rGrP72NRkFHGW8akgllL9CvR3H7Yih9eV7SeZdS5asBhBR4GQjpqV5iyTAQAPmRPJiTFJwl9DVdY+ueqF/i4e8uxA09mVzfa+u6jA3TKOmlJI8i6AYe2MGr9Fb7AVBhtdUE/8hrhorAkydlY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CY8PR10MB7218.namprd10.prod.outlook.com (2603:10b6:930:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 17:22:03 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 17:22:03 +0000
Message-ID: <1624f0d5-4ee9-496d-b51e-0ad3ac1c00b9@oracle.com>
Date: Fri, 29 Aug 2025 22:51:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: endpoint: Enhance pci_epf_alloc_space() and
 rename to pci_epf_set_inbound_space()
To: Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
 <20250815-vntb_msi_doorbell-v1-1-32df6c4bf96c@nxp.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250815-vntb_msi_doorbell-v1-1-32df6c4bf96c@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CY8PR10MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd498bb-d519-41fc-3f38-08dde7209235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHV3N0IrbW45d1hPaVRYMzd4QWhmc0gyNmNrTDRkT2xHd1dkR2tRTHRJZ0hq?=
 =?utf-8?B?cElSb2lTZGQ0bXVvNWlrVExJbnlZZ0RFaVErTW8yZTF2SWlaakZXUERkcnBo?=
 =?utf-8?B?S3p0T0ZuUkowenBFMnV2Zkk1dFE1QmZOY3NaR254KzFRSFhpS1hGVUhKRm10?=
 =?utf-8?B?S0N3b3R4aUR0d2RiUVZqcmhaaUpmc1JwWFIrU08zVkhsMDNwaTNHd3V1cHdU?=
 =?utf-8?B?eEF1amRadVZHa0l4MWRsSlpLK3luVE45WXFEL2RLK3IxeXpad3FqVTVhSXlG?=
 =?utf-8?B?MGF3M1lmbld2OXU4Yk5NQzF4Vmt2Y05paVFRUlZ4SDJCdjlYNTE4N2d3Q1kv?=
 =?utf-8?B?TmFhSDVRWDNQam1YWVZYdVJSTUhvUXJmcWFiN1FPcS9aTTJXSGNNWDB1Vndu?=
 =?utf-8?B?ZnkydmVGSHd2dm1FcWNpWVdiNHZ5aS9XdnlRUW4vcXZDS3NUQVo0aXM4bFNv?=
 =?utf-8?B?eTFCQy8vZjVOS29qT1N3U3FwWHliTXl4dHFTYzJ6ME13aVZsR3ZyVUlYdGVY?=
 =?utf-8?B?NU1kZmpibDBza3hJV1VBWk43Zk1tL0lDblJSczZFRUFHdVExQjZJSm9MUnRu?=
 =?utf-8?B?ekpDSC9NRUFkZ0dJbkFyMlllazR5UllYRVNGZ1FQMFo2WjhJdkFVN1FaMmNX?=
 =?utf-8?B?UUc2U0hEeU12cjJxVjR2RnlsVHg3Z0dGc2U0S1gvRjhrdnhrdGN4S3d1eWF3?=
 =?utf-8?B?WExsc1k0NmNkMXZhTW1IcXVjNUpGSEdFdjRHa0llQm1VdEhZeGRER1ZPdEpu?=
 =?utf-8?B?T1dsR01ucndvek9UaE5IQURFL09IZHhka0Rhc3I5Wkt3eElCVWVZQ3MveG02?=
 =?utf-8?B?c01xQU5YQk44aytIaUtqU0ZDRXVsQ3JpTUFUazVnUWlNMWFpcmkrVFRhQXZO?=
 =?utf-8?B?eXNicUZMaW5ySnQzdzVBZk11enRMeXVZcHlOZHQ4TC84L3NIOGt6SytiQm5S?=
 =?utf-8?B?UTVPSGF0R2ZQZnJwbjZtWmhoWjJRV3B2U2F1L3NFNkFkWFU0dEt0V0JvZUxy?=
 =?utf-8?B?eWJYTDBTSnVJdnVpdnZNdk5haVZTNXdiemljUUNLQkNndHZVOVVNT3RYdFhh?=
 =?utf-8?B?aElwMDhZRitlYmZpYWJSQTM2U25kTWlDRXBaNE9qaHJxQVNGK0hsNTB3ZFF3?=
 =?utf-8?B?T0dEcmtJbU54cUovMGFDYWNTbUpyekpaVHVzRkpxZktaQVpydVlyNDNldU1r?=
 =?utf-8?B?bE5kcjFtWFFsTHVFVXFkREppYVpzS3R4N0ZXU3ozckhNTlljaEw1Vjdmc3li?=
 =?utf-8?B?Y0tOUVNXZ3BsRnRLdkFkdC9CRk9wSytoWGs0UktMVWR1akpJSUMydCtRczZq?=
 =?utf-8?B?ZlFuOE1KVzE1dko3Zy8yUzB0SXFpYVVaU1Q2UnlZcVhGenpENm04R1NVUjc2?=
 =?utf-8?B?ZWQwd2RyMmh5QnJOZU1CZmVVejFpQXVzVGVmUktMdm9tdnlhZlRCRFNJZHNL?=
 =?utf-8?B?UEpxRUVGQjkzNXZQeUQxOTJiOFRXQ3krMlk0eVUraUhpVG5nRTdNZHorVmZ2?=
 =?utf-8?B?R2RtTTdoVlNDTzlNVTQvdGVGelFzdDlrM2V4WEpjaGlXTkhWOGIvYUdsMWxT?=
 =?utf-8?B?WVZrTHU1UjJHUmppOGQyVXROYnBwUHozVU92U0lKWXBWWmRsbHlDZG9Wem5P?=
 =?utf-8?B?dlh0K2ptN0VZcVQ5V0dxeXlxbFk5MnRFZGd5L1NCMjNKOXcrT3VlOXZ1Slpu?=
 =?utf-8?B?elNYcTVUWHcwMVFQdzJIK3NqZ2FzejJHaXhHN0VrV3dMUHd5U1NUaktKM0Ew?=
 =?utf-8?B?ajl0UVNSM1ZyRVVSRnNyZVBKUEdSMjltMEpyVmZpRDV2ZXZDWXo4aHRXaTdI?=
 =?utf-8?B?aFRnc1JlaGQzZHY1QUdqL0RLeWt2NjZMVDExRUFHMFQ2TVBBVnFKcWxTYjVT?=
 =?utf-8?B?YSs4ZDhjZWM5MTYrRUxXV29nQVRFZldyZGlIaTI1KzgzR2tsb21GRnk2dnY5?=
 =?utf-8?Q?liuq7+kGDAs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajdsRjFPY01HUG8rOTJtMk1NV1E2R2Jha0N1alNOSG14REorR0V0RWM0SE5X?=
 =?utf-8?B?akFCWVA4a2ZsRmhqTmdBVDJlaTA4bGFnYU9zeUZtVy83amYxUHYyVzBNQ0E0?=
 =?utf-8?B?UGxZVGZVVlIybGR3emdTeW85NFhzcXptZ1NBMEZUNEhqUzhkV1IzUG1XdWRj?=
 =?utf-8?B?MVhmZi9heTBRRjdOQXRzZHRMVmRReCtORXN2UkcxU2IvcGVRcG9lY0Z6T0Vt?=
 =?utf-8?B?WDhjSS9uVVdLakVBdFZ6SUh0OThxYVdNdkIyUC9wTjBIYnFqU0RUbXNJblFh?=
 =?utf-8?B?VEgycnVuS21jQlZua3RTZ3FuYk8zd0t1dUQ1cWp6c282ZkZrSkZackF3d0ts?=
 =?utf-8?B?TXBwb29JSUlzSGtoRXJyb1MvdGRyY2hMUnFTT3N4OVZuRGJtZUJnYmR4a0tt?=
 =?utf-8?B?UmNrdmwxdkpqT3dzNW54OFJmNXRmMllHcGtEcDdkZGtjZW9ScVRKek9mcjRt?=
 =?utf-8?B?VEJFRExPVjZnTUhBeWRTUnAySTkwZ3lwbWtEblJEeXN3QVEycTRlMzNDMmVT?=
 =?utf-8?B?K0dFbmpTRmZ5Zkc5R1VwWXFNZW81c2U4WXZkdCtQU3prTU9uUS94alppWjB0?=
 =?utf-8?B?VXE5NjhJY0lQeFJNUnhzRVAwM1hhUmJQaGsrdHlkWkNEMUV5ZHJQYWRmaU93?=
 =?utf-8?B?NEN4VDNUUU9saWJGcnJtMldGSTNGdnFrdWo0Q0kxb1FDMWVKaGlYNlcxcXFC?=
 =?utf-8?B?U1Jtb0VKMjlGM2RITVR6dUs1N0JKVThVUkYyeSt3WEk0KzhhMnhaZ1YrcnFR?=
 =?utf-8?B?V3RUMkJjMEUxdmpGMCs0TDhpL0kxSVhNc08wdnJqTEtiaVBVUmNJOXlmNllB?=
 =?utf-8?B?Rkp3SWRpZzZJQzZnZlk4Q3hWVUtSNE8xVHhhNC8wMnArM0NDOExrUWkwTG9w?=
 =?utf-8?B?UU5UNkVFM21LS1l1WHRlWWl1dGRWWWJQTXJGR0xPeWY2ZmxBUlc3WW1kK1lo?=
 =?utf-8?B?alRRZFVIdFBnM3JvbEVGSUMxWDBaZjRFWTlmYWNmanQvRVpYbDJadnVSenF4?=
 =?utf-8?B?dTArRGlyRlpYSVlGTVZZaE16bXBURmZwdExjZmxmcXFqWDczMHprc0U1NThZ?=
 =?utf-8?B?R2luYm5mdjBuRm1YQlFRaXdBTTJYMXQ3NnJjS2VlQ0p6dlcyQ0E4d2R6NW4y?=
 =?utf-8?B?ZXZJcEFDTWhLUWNHVXVXakp2Zkx0V3JHYy9KdEl6ODl0eDNHL0hROGwrcWlF?=
 =?utf-8?B?NUVCOTBpMlRCS3NobEpnQ3JUZ29hWm4yTUovL0pNVkV0WU1kMVpyb1lPWlZF?=
 =?utf-8?B?RkxSTzNUaVV2ZG5ta1QzeXNKS1pBSGplNi9kcCtXRWFwRkZRVXpaQTlGR2Z4?=
 =?utf-8?B?QnV3RlJpd1BUUC82Z1lhQnczNUdVQnZGckN6cEc0TnlsS3lCbVgxU0VXRmNO?=
 =?utf-8?B?aC9oT3BCdlpzNyt4S1p4amZXWkRNcVZPL09TZE14UHBFM0s2TFMrN3N3cnFT?=
 =?utf-8?B?V25wR05VRVRMck5JcEFpcHBMVUFiQ081Q2daclh0WjBIR001aVJOV0JBMFJq?=
 =?utf-8?B?Mm5TbE1YZ2wwd3oxV1NlbUhIcmROblRYSitMbXVBcGF2WVlieW80UDNaZXRY?=
 =?utf-8?B?bXhsV01GWWkzckJQOFcyZTFpMEE4OFRLUGRxR3g0Y2FZV3A2MzFBcXphUFNK?=
 =?utf-8?B?WElYYXh3RHVKOGYrekZSR2xPNXBYNFZkNWE2eXhrR3JGeXkySW44VTJQaXhE?=
 =?utf-8?B?VXRZQ0hhanpEbzVsOGtRcVdpR0V4Wm5tMEJtL2gva0tLR0hGOU5jNjVlL2p0?=
 =?utf-8?B?N25jMXFQdWFVUFpGZHc0dERmVUlEV0lLTE4rc3YvaG05YUZ3eHlzVjVtQ1Uv?=
 =?utf-8?B?Q0FTaWtVQnQrRlRJYlExTkdQK3pKT2QvdUUxb1dwMU1QOFIxSUthbWU0Q0Jo?=
 =?utf-8?B?ZzRhY2pxN3NRQnNjUTNUOXBmRjlEeTNLdlhheDQyS3hVSXV0R0lCenQyRkdL?=
 =?utf-8?B?RU1rdUtjUk9UWGN5aW4vZGxnNjdJWlo4YmFlYW9PRDRSRVVmU01rTFkwMVU4?=
 =?utf-8?B?aXBrL1R0akFWOUVEZ0RLcitwVEFzRDF0QXpWOWxTd2l5VWxTWlREWlpWSmZ2?=
 =?utf-8?B?aUdIc09qeThJajd4Wi90eUUvU09vS1QzamVIYWd1MU9xR080OVdHV0kxWUNF?=
 =?utf-8?Q?W07AOecf9u+DQOSOqKDFlmdMq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s5IfOo3kThJiRq27gcMGXwkjw8Jd/5wB3xRB00j5/+BA4vvGktUTaM+coiAwFUEI4j4kX9a5TnGEXg5AKJsHaSw6OqoPUfu4pRhzbjcV7pv0M/86qIOhmLP6W9mzVcm2GHTyH06oiBYOdHlpA0p9H5xwK8yiiCRmVyfXoq8L9LG1sp3gC4i4GHADIC0EqlcTz6qSchaQpLe1+AZ9WX2DVDnU5YxTzSy6puDMdAfD/c8kDya6aV3U6BOduC0cVvcFZQtchko0m794dl2BUPgKCB93qGo+eFQGtaZsAHMjKHd8ALOBovYYIYBcswDA2NZYLIbQmTJRfOWVdkI1cDzlDH9AdD2SDEHEBLAxnCueozRSJyakKw9F4X2kSQZWdMpuubbwqExs8rgxBvCuO/IPud4mQcX0mDqYWL3kP9ItoCS3SpfZpiTYfBXRg1YS5nUDHib43MchsXaFL1satpP5ZX7xze4doUvXiktC1nGCU7mBcG3zMnkyTxh2rbgiuidz6T9aAEthH454n4vWRcYIqEsbV4IeiO/18Wc092SPC9je1OthzzzWuqThzOUNSYbWypPXKpnV1gii5ypIPr3KvdaNoln7NnXeGhx8PlsGDg0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd498bb-d519-41fc-3f38-08dde7209235
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 17:22:03.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uA77c/kTmTT6NAt2DfW8OSDwcfyy0plZH8wGC2sJyXjnDDhwMKErI83FpwDyy7svFpLH6n2cnvD/qk++vwjG1T4LEiPmkahMuuDLlUeKYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290151
X-Proofpoint-GUID: ymHUMmXEAYmOH_5M4wUhqmGHIhkay4RW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX9nbYmFlU+Gpr
 SUFSTfUfh5QBZRuXcvpuFXf2CuT8NPrcBG5HaJbKP+5sEfvFQkvpV43bbRMzfeIieSLosNyTX9y
 GDkuSppW5a6o95HAgrrBXTvAKUp+2PFLEIRJV5TUFJw3/xn+jg4weVNKA1sqj5tV3BwfgjOQ9nw
 NY9OD5RnWvx5k/uesyBufplMutro3yT2DrTzRJE0zz6zD4XBOEh9jhzymvJoM8iv4u9WsCSaJ2A
 JgiP5XYyBHl/tEOBs1ojMtBKGworqj+E/hjDltAeGN5qJ7EAwC4SGKtwe0YDFeeEyfLcTE5MtrB
 tgDcn2Tqxj/4FWnw9K+dr3tXhwFlhDmuk6pGko5NJvQjUTLcxFcAut+QAFkDZrnhthra9Y5ydeg
 HLcXd6dg
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68b1e1c3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=wgpzgXML8AhUoxFaHp0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ymHUMmXEAYmOH_5M4wUhqmGHIhkay4RW



On 8/16/2025 3:50 AM, Frank Li wrote:
> +int pci_epf_set_inbound_space(struct pci_epf *epf, size_t size,
> +			      enum pci_barno bar,
> +			      const struct pci_epc_features *epc_features,
> +			      enum pci_epc_interface_type type,
> +			      bool from_memory,
> +			      dma_addr_t inbound_addr)
>   {
>   	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
>   	size_t aligned_size, align = epc_features->align;
> @@ -270,7 +276,32 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>   	dma_addr_t phys_addr;
>   	struct pci_epc *epc;
>   	struct device *dev;
> -	void *space;
> +	void *space = NULL;
> +	dma_addr_t up;
> +
> +	up = inbound_addr + size - 1;
> +
> +	/*
> +	 *  Bits:            15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
> +	 *  Inbound_addr:    U  U  U  U  U  U  0 X X X X X X X X X
> +	 *  Up:              U  U  U  U  U  U  1 X X X X X X X X X
> +	 *
> +	 *  U means address bits have not change in Range [Inbound_Addr, Up]
> +	 *  X means bit 0 or 1.
> +	 *
> +	 *  Inbound_addr^Up  0  0  0  0  0  0  1 X X X X X X X X X
> +	 *  Find first bit 1 pos from MSB, 2 ^ pos windows will cover
> +	 *  [Inbound_Addr, Up] range.
> +	 */
> +	if (!from_memory) {
> +		int pos;
> +
> +		for (pos = sizeof(dma_addr_t) - 1; pos > 0; pos--)
> +			if ((up ^ inbound_addr) & BIT_ULL(pos))
> +				break;
> +

sizeof(dma_addr_t) returns bytes, not bits.
so 7..1 time loop in enough here ?

> +		size = 1 << pos;
> +	}
>   
>   	if (size < 128)
>   		size = 128;
> @@ -283,7 +314,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>   		if (size > bar_fixed_size) {
>   			dev_err(&epf->dev,
>   				"requested BAR size is larger than fixed size\n");
> -			return NULL;
> +			return -EINVAL;
>   		}
>   		size = bar_fixed_size;
>   	} else {
> @@ -308,13 +339,25 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>   	}
>   
>   	dev = epc->dev.parent;
> -	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
> -	if (!space) {
> -		dev_err(dev, "failed to allocate mem space\n");
> -		return NULL;
> +
> +	if (from_memory) {
> +		space = dma_alloc_coherent(dev, aligned_size,
> +					   &phys_addr, GFP_KERNEL);
> +		if (!space) {
> +			dev_err(dev, "failed to allocate mem space\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	epf_bar[bar].phys_addr = from_memory ?
> +			phys_addr : ALIGN_DOWN(inbound_addr, aligned_size);
> +
> +	if (!from_memory && (epf_bar[bar].phys_addr + size < up)) {
> +		dev_err(&epf->dev,
> +			"Given bar can't fit required inbound memory region\n");

consider bar -> BAR

> +		return -EINVAL;
>   	}
>   


Thanks,
Alok

