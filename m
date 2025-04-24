Return-Path: <linux-pci+bounces-26643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80787A99F1E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA871897AE3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52C1993A3;
	Thu, 24 Apr 2025 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4rYobJY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XgzkiFYR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45A1A2872;
	Thu, 24 Apr 2025 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463693; cv=fail; b=Qfblk3cldMEV5I17tZvRpYqfxtbqW1iebeA7J63ZwCOL3W7s4Cxf1XzqEYNhs6C+2mxtu7YafNlW+kKp3BtbR/TWK8Gok98Js4C+6otrZT8lj+SXsWyRPwKRhozDwZSQ2jMk+jAVaPE0s7Nu/eUy2YRHSjFDWoE1wnPlJiq5jqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463693; c=relaxed/simple;
	bh=+EIZl9Q9u0SHY+VU7nREAtb6l4Fu0+jL3FHVcZcJGnM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8Ju9V5RhxNL9QiKgYOB/ANcchYOTQ1LbRPrrqvt5b1ux08Gf9iv25HPbvIGSCyFX1ZPQP7DfnsiqYcZY/cSWMzKFtSsc2GXVv41YRI4sDZdexM1rghob2iYMFUjgtFVi2YAKJ19WEPN3m16ar/BEdAqP/Fag+rUoDeYyZpDfZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h4rYobJY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XgzkiFYR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLMLsQ025376;
	Thu, 24 Apr 2025 03:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7844aSW/JWNW6JWPjmiXN3oPRkndjx55D67fi//QDBQ=; b=
	h4rYobJYdr4NtiWiD+hQyogsgUJVw+A77gVZGWrvQRMRSRHaKh0Oxdr87CuFNzKu
	c2toXQjl+olKsnmhnwRSdb5FRNinp2dV6bAtOmXMjXnrhhB4bK5xrIqA1qEk57KI
	mJdYqc9XI4kILhAtAkk5lsLM8sB9VI0C91JaZGRc4hHCG3fMq5kigltDoutYDStV
	M0mQdsrN0QV3IjBIrXyiE+aguEadvd/iEqvjKO717S18RcfdQLO2qTbVYmmMzkoA
	O4F/fYZu3Bjv/eD07bj5LAMQlD1x8Fl/JKqcB8MopJ+tKz+T2Zu/3QZmycT0l0ch
	gP6qEWX3yv7sq8m/ZFkZMQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha2w3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 03:01:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0L72h013854;
	Thu, 24 Apr 2025 03:01:12 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010003.outbound.protection.outlook.com [40.93.10.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxppw9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 03:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brRTiTC6W52TUY8b3QdfR6+UWf3Ec2bIL5SFVA4IWTY+Vqv3Oe28+p3fWZVm2yop6OOowRKHA3hwvAY7X0sHjDHc/zGRBAYJxIUGdK98M1lwKgKa8NSmIBtu19RdW5lTS4eTp1GVU7rmrXBhja6vku8v33DhvWfaSvpWlLp94moVXEKpRpWq9kAJ/WdGmftgP625J9LPEWMzWB9ESJBlmqhPWHZLZ5XU0n8dvRPcA4Jct6fKSrBnu9x8WH3Lxs6YdZ0+05YdxfHAVbdjpw+idm1zjw6mY5bC0W/+4M5wNwRe9goYayGxHWaIgmxLs3VcoiiDVBF0gMOXiNVihWg1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7844aSW/JWNW6JWPjmiXN3oPRkndjx55D67fi//QDBQ=;
 b=NE/GpyNpp+amnj2UpKNA6UYoXfEKDvso+nFGOsmR24MI36/GrCoWojbJUoeTANVQxlQO/iUi0T7IaViQWTSju9GUah7zFHagqScvCh9FmHzv/4CE5fH7Av7cWd1/os4xLqkDntKuR0NZLeuce74yHEcPWxv7P6Ar7FrdQKqrGQlPA9i+vDozskPf8+cv+4Rt5T3UeFm5k/7pa0qlLZNuexJl8DvCDRFlE5vb2PndMSGZDTvRbZZ5RBqWiZj+9HXQOqEr6JIuT/pQYE3y7ceFUKhLgsTDJFRVgUWlcR8ehR6DAsNMeIfgAxcPWZKNX+nEIxINmY38O43xHxn8zQCQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7844aSW/JWNW6JWPjmiXN3oPRkndjx55D67fi//QDBQ=;
 b=XgzkiFYRyXPVkwXy6G865QcQd0jsZ6KhY+7JXTngX8NHBD6TQwHB4KwxaCITeav5h8CGfXW0/6iL8PAkPkC9SFrhtpW5pxuD3wqwDLL4dzg6h0RToZ0v6Etw8OUZ7c/G8T0MFzICtKiSYUwgfciK7GDH3pwYUJPG7NsFRzXdQw0=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by SJ2PR10MB7671.namprd10.prod.outlook.com (2603:10b6:a03:547::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 03:00:43 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%3]) with mapi id 15.20.8655.030; Thu, 24 Apr 2025
 03:00:42 +0000
Message-ID: <a789c1c6-7bd5-4cc9-bc8e-c70715b09932@oracle.com>
Date: Wed, 23 Apr 2025 20:00:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
From: jane.chu@oracle.com
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
        willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
 <40f142be-12e1-407f-8b64-05d8c12f31b9@oracle.com>
Content-Language: en-US
In-Reply-To: <40f142be-12e1-407f-8b64-05d8c12f31b9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0044.namprd17.prod.outlook.com
 (2603:10b6:a03:167::21) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|SJ2PR10MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cdf816-cec2-409c-811b-08dd82dc3377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTZndGFvc0ZGa21xcVdKMS9FTjQ4WDJ1SzBCcFVIamd2TFRHdCt1ZVlXRkty?=
 =?utf-8?B?elBKSVBQc0N1SFVCMEd2SThQVXZjTnhWNlF0RjZrNGgzRUhnOUttRWc2eUdk?=
 =?utf-8?B?Zzh2a28rS1NGaXpYdGRVeXErM0l4MVB1THl2NUFoYUgxTTlkN0NOWU53Rk04?=
 =?utf-8?B?Q01Db1lST2doKzBSZEdaZlFHMXd2ZW4rTmRJY1RqdFI1YXBEdDBPbXpOQjIw?=
 =?utf-8?B?UllIUG5TclMvVnkvdGJkQXlMWW54aUQ3Uk1pL2YxdVJWSkx4clpncTdWQXFm?=
 =?utf-8?B?ZTFTWlUxR0hheWhUZHN6RGx6S0o5OVdiemRkYnR3UTRCUE1mRzdZTWthM2pN?=
 =?utf-8?B?Wll2Unh3bGgwbjB4WTEwcDFFMElTcmp5ZldVUDV5bVI3bWIwZXdIdXJna2pT?=
 =?utf-8?B?UUQ3MlJSWnRsbndBTE1pcFRBTG9YTzArcGo2Uis4SFN5VXpiajdmUjhQWmV6?=
 =?utf-8?B?K1d5b0UxSjJzd0lhNzM4SXlBRFMrcXFPenJua0xoUHVwSGY1ZVYvTW9ySVQy?=
 =?utf-8?B?VU1hMTE2ZEdETEhSVlZUejVoMGpsRXg4MCsvcW5OMFpwTm9NSW5NTmVYaUNP?=
 =?utf-8?B?TjdpcG8xeTkrT25RYy9JYkt6MHhYa0FuYm5xaWRGN0R5SXRsTks5NlJzNWoz?=
 =?utf-8?B?WE5sRk5kRWNxTGdsUTM3VHM2SVNZcDYvVFdtdXU1ZmdzRHdSRzZLeENUdFRJ?=
 =?utf-8?B?dWEyeUlZc00vNFVSN0I0cW9HM2lHd2pWQU5la0NXdUtCV3Z2bGFZWU5qUDJw?=
 =?utf-8?B?SVlheUNlMXZwOTB4SXBrY2RjdHE4QjdlVGgzYzAvbUZlRzh0ZXhOVXArTUNp?=
 =?utf-8?B?dUkxZUw3cThGdUcwRk5UUytLWHdaYk41UEJrSUprTXdFbkxKZE5wL1BtZVVC?=
 =?utf-8?B?Q1FRb1cwM2lKVS9qNnlQUU1XV3pzaGRGZWNSQ0NZWnhkL05OQVNkaTVWUDEr?=
 =?utf-8?B?Z0lKM0hsWEJHM09vMFF1VjVLTnBwcldTeThoelFTZVVhVDBXYTNqWlpad1c3?=
 =?utf-8?B?d2N2emhRTjZ6Unc2cGtOQzBaWk9OWWdMM2QyMFlhNUJ3TnRpbHFINDRyM0VX?=
 =?utf-8?B?bTg0c09QUGxUNzM3Q1JjT1ljOTdxSUFxSlEvYTk2ZGR1VnRQemwzZnBaNW1W?=
 =?utf-8?B?TytmQUJWemVlNVlmRVp3WU4xQnBuY3VmUGpnRkkwR2dueDF6ZjBTOE80bFIw?=
 =?utf-8?B?cUJaTGJsVGpud2VBMUxhNVVSRS9sQU9LY1Jud1JsL25RM1JrMjhxV2VydnNq?=
 =?utf-8?B?eVNYU2hvSy9XM3JMa2MyNllRS29wOWtPaFlUQ3NvODIrc2RaQVc0Zm1lSXBG?=
 =?utf-8?B?S216Q3V2L0JLTGEvQ1FDVmd0SnYvWWpFdDMvVkFkcEhuaFVjVHN6WHZza1dI?=
 =?utf-8?B?ZGZPK1ZjZHl2QVhsYzJDYyt3REsvb3ZYY1NEc2tQdTZkempsR2hKVko4Umoz?=
 =?utf-8?B?OXF4aWk4LzZKdWV6bGZGeGUvSVEwblRQMVhxbllRRDRpTFFTSFlzLzhqN05h?=
 =?utf-8?B?eGN3VjBmVXd0U1QvbnhYWmZSRTBublUzOHZGaUY4VlkxcnFrZzhaN3l3bHpm?=
 =?utf-8?B?ZFhnZ0RwVHFCU1FJZ2ttNGZoMVQ1cmNLd0s2YmxHS3o0ZWZkQ1VwM3l0M3Fv?=
 =?utf-8?B?bk1QT25wZExlamJBVEhQbmJ6NWlTTHN2UmQ1cHhUeWxTZ1JoS2Yxc3VtM1NG?=
 =?utf-8?B?QzBMRkdQR3BWV0lpanF2Z1hrRWlseVR2bGlackduem1XVE5aeHBpVzdFd1Rq?=
 =?utf-8?B?WFR3bWNiZjRRbVNtQnZxVkJCQUswSHphVnlFLzlEUDBtTzVDYjFOQU1GNTVK?=
 =?utf-8?B?aGx1M1BlamRjYUdWWDVLMzZBb2x2VXlhOFg3cTNnUGxLQStYZkRDaHcrRkpS?=
 =?utf-8?B?Y1BMemM0SDVwT3VBR0QzK3ZTN21IZ1YrQXVSL0haSmRSUTdkek5Ibk9qdUpn?=
 =?utf-8?Q?L212hIcWwKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDVYRFpOdEdJRzhZd3lpMnBVckRlOEJTUm4zblg3d1dLbS90Z3RYZ04zanVp?=
 =?utf-8?B?c1ZheDFlZTE5R1B3aExsemtiMWRoTXlBQUJsb0JBMjU2dHpLN0ttcVptOWtF?=
 =?utf-8?B?M1I0ajdPd1UyNmdjZGthOFZZcXF5eWxFckwxaTJTTU1QS1hsOGU5elg5VGNK?=
 =?utf-8?B?eDN6eVBxUG9JM2c0SlJMVldOWVpCd2J1RmxqNitWRnEwMmlwcjFtajl4em1T?=
 =?utf-8?B?ZUlGSnJNbkI0VlFaNWFIaGNYemIxa2tWNjNqYkEySUpNOC96MElsTjIrMVFH?=
 =?utf-8?B?aTFJS214MGdSajVzd204N1YxWC9xZ2NuTGYxaTJqWFRvSFlTUWx1OFZOV2lu?=
 =?utf-8?B?M0xsZTRLU2llWFVBV0dJZ2EzYUFERTg2dW4vM2ZrUFY0dTRVRFdSM1BpS0lz?=
 =?utf-8?B?RWF3ZUFhS2Z5Q041SlZLR3dMS3l0VDlLVGgzck1CbjNjK3NQeTZ6dno0dGpz?=
 =?utf-8?B?MjlhaVZjRGdKdldhYmNudGlxQzhudmk0WWk0SHdNR0EvUFpqNENjMVRMVEZX?=
 =?utf-8?B?c1ZEL2t6eC9zU21QN0pkTzF2TnczMEJyalZFejVBWnJ2bDVnaU9GTlJOUXo2?=
 =?utf-8?B?MERoM0xDTk9wTjB3a1k5dWlrdm9kRGtmenVzL0x6UmQxVThqcklLekQ2TUk3?=
 =?utf-8?B?cVJJZkJMRUJLUTdFOVdpVEgzU1ZRcjZrRmlCTUZkTktOc1hYTVhDVGVFcU9T?=
 =?utf-8?B?ZFBzeHlLdG5XYWRSS0swV3lONVBsTSszOWRtT0JYcituUDNnejFnZlgyN2JN?=
 =?utf-8?B?RHZzOEc3YlJoTTRub0U4U2N5OWdJTjNDb3B5di81a29mbjRzMllsalNGb09h?=
 =?utf-8?B?UHQ1V1BQTzd4cHRwTlBqZG1ubHQvSXMzVXN5U2J1NkNrUUdoWjF3dmtoUkpw?=
 =?utf-8?B?SGVObTdRRjFGQ3k4MFMwVGNHUStlNkJaTzBSMmpOcURpMi9sckJaZXM2VWpu?=
 =?utf-8?B?SlN0VmxmM3llMmZEb292L3ZCS09OZFIyd3hxVW42blQyU2FhV0c0L1VENCsx?=
 =?utf-8?B?aU9KeTNHVW5yT3Jsb0FaWjNLaW5aWnIwajloLyt1SGNpZXdzcHhiblg0TWs0?=
 =?utf-8?B?YlpoY2ZRajJ4T1ZyRi9tZ0FYUHd3VktEeC9XSWpwU3poYlBkN3JueE1jMXdW?=
 =?utf-8?B?cWNhSGxlU0dSNzNsejk1YnhVdmZtZWdoZS82UkdsMVVlUFpsUWVnclZoKzIz?=
 =?utf-8?B?ZzVyYjRCUzlkVnZCZzZVbzdVZ1lHclZTbkQyT2dIQjhtVlFrenNrSEVlNTBD?=
 =?utf-8?B?ZmFLR05Hcm1zcFZTRlFMR3Z5SnFIdXdLcnBUZVZvTFZxWjUzWjdLTjNwZU9H?=
 =?utf-8?B?ODVQWThHa3NEUlhHODJubnZPalVnK0tOVitMdzZhR3h3QWwrQkVhTE04SjJn?=
 =?utf-8?B?T3BqRDg2WXJZQlJDRENpZEgya0o2WHh1VzlvUWx5clpMU2N4aHNFT2QxV0pP?=
 =?utf-8?B?dmNsc3l2dExqU2hkRVdZWThaVWRGdGJvQS8xN3ZlRjA2SlpPZ2czUEJ1bzlk?=
 =?utf-8?B?TC9BeHExTFpVTGlkYmNxWUtiUCt3Y21FOS8zY0ZlbDdtQVYvWDZDUHR3dDR1?=
 =?utf-8?B?T0EwLy9zVkVWcXdxekhPV0NKVFU5bG1BRjhqVUhvZVY5dGdneTJTZ0FpTGpo?=
 =?utf-8?B?U2JiSStEVFozOS9MUklacHhGd0RtYUZ1eGxzVk1xZGJ2czBzM05pNjJ0aWlT?=
 =?utf-8?B?dk0wd3g1b3JhQXB4U1l6VkhzczcrR2gzaGRHaEZiQW5VTmFQVUpqQ1Z4ZDM3?=
 =?utf-8?B?djFhaDlkSlIyUVJiNThqb2FVSlNDbFJ5amNXeWNzemFvbEI2SDB0MktjM1RL?=
 =?utf-8?B?OFN1cnJwY1hkUnA2dkZJd2VLUGQvMkF3REwreC9NMy9TS0ZsaDJ1c1BXODc0?=
 =?utf-8?B?UTZYRXMxZnBDQ1J0RG9ZSHZQRGVOT3JuRmZwcmdBcDM1K1NjOXVjRVdOV01R?=
 =?utf-8?B?ei96R1NaNTRxTHp2M1p0Tk5KMUprR3BLVmR6OUJPdmMwczFhQytxVjIyaDI4?=
 =?utf-8?B?enNSbUNtVytWL3oyY1VyNTA5TzFEVlVzNzFnRzlkSnd3ekJjU3hGWTJVazR4?=
 =?utf-8?B?a3BOZzJ0ZjMwdGhIQmh4eUJBVTVrbjk0YWVWQzJGSHRFajRRSGRJQVZzcXZa?=
 =?utf-8?Q?7+9Vl92H3uIWWq8NxzABXw/i3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s/g50jwjo0UeFl0gy59gYpRwxnxv9KUHzP+UPZPVlR7nW/WnSp5Ql1p/ghsNHFdlgnddJuLx40YkNTpmBY7eYfUq7EVHbK7y5HeKCqZdc7nZ6mkEfTIZJabHJAOHtgj6lMPT8yKxAc7RbPSFanKp+FZjn2Ys25DnOqgRKYuxHc99fAmIFVf++dwB/kzB6QE5T4PT1vFvCciOi36aFfem5XtCbX/Ia0y/8Ga/XMyjluNAZ9oqv2UaMsA0xJMKxrJQPNASGv44zWWM5CXFPa/Juo0JJ+E6CZ9fJTcGxHGSWcbPV2Z9y0ECX3/a/cYDlUWmYYcX7+DeXnCUfvwxXdboqGSeONmK9GxSlIXCUUjBu/l+9DdzrXcAQx7+EAg/KhIfSAHvc1eHHLEvguFF5nyl6qrWZ1N+LYV/KyKwqZ6Bje1pdxUE+Jxh/zDJHAL12WKmsHQEahfgbYBUQgK6QdbQObpFRBOijhFFzwFHQTmQ/FPqTooFWy2QE6uYuna2rk6ggl0JLLhCliwvJJh5JpDfgCfEBIMTe+AYEAeS3Ztn3r+bh8o5zND7wbfdTbFGzsaepGsXGy2H/OGK9WB1UPwRdzQMBWRd9HkBhc2aJ2OE+5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cdf816-cec2-409c-811b-08dd82dc3377
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 03:00:42.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrbvpOKSRkzYHt8P48Nh2SqtFsBUPW64EgyHM+gfo8sDrvt1FwpomWOeSm2KpzkSjzeGiSmpEVmktwbSj0ES2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240016
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAxNSBTYWx0ZWRfX7BRxEAjKrmHA E0BYvRI/SBYBKOYs6eFePSol1inau8fVbdz2tIAWCj6TGHo+NHJNgusO6CLvwSXRVjyzKG5NTNz 8/4IE16f3JR4NIPfCRa9t3UguFLlQz1TRkRwaHII0D5voEFNcTdw/glVZnaFR0UXXcMrrA5ICkd
 ghHCL3QwJLANaaztk9kcqSRnRa7bPrb1HtoPu+ihV3t/lp2rgxK3mIaL+9Zo1Fkg2tyPGlC7tD+ wzv0DRxp0YlsCcnGE3orVDUmvHSF6Y/rmMZ810QvpfC3sJE8FpA6gj0B4Ho/9hRUTK3m+6dJTvg uNl5+hqxH8H9MOmFlCkL0lMpM0Ddr/s39hBgdEx8Bz5u1Fm+I1AgBheiG++NaR/BmlW4xsKuob/ s13KJ36X
X-Proofpoint-GUID: cDhly-UBUQC5y9QclA4uwkPaXjTmOMX-
X-Proofpoint-ORIG-GUID: cDhly-UBUQC5y9QclA4uwkPaXjTmOMX-


On 4/23/2025 7:55 PM, jane.chu@oracle.com wrote:
> 
> On 4/23/2025 4:28 PM, Jason Gunthorpe wrote:
>> IIRC device-dax does could not use folios until 6.15 so I'm assuming
>> it is not folios even if it is a pmd mapping?
> 
> I just looked at 6.15-rc3, device-dax is not using folio. Maybe I'm 
> missing some upcoming patches?

Oops, scratch that.  I'll test 6.15.

thanks,
-jane
> 
> thanks,
> -jane
> 
> 


