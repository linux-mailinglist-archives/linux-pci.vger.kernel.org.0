Return-Path: <linux-pci+bounces-9825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4F9280FA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 05:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7CB282B33
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 03:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFAF175BE;
	Fri,  5 Jul 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mgQY1Vdg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TKPv9TzE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC4101F2;
	Fri,  5 Jul 2024 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720150744; cv=fail; b=OS5TkeRLfrNjx9ldYZxtaez7dzYQDKPmBo4P2lkxFiwf43iguw+71gDdZdrPfAa5K4RdpohayuLQ8Fg57S5+u1EUuLZip+ly0tdYkfK+r/YizV9fTLTEhyZZOyNxUM1v0Dlh3n1uMm93ULTpQQ1+0jv5W7zmqlFNPv3l0OxXDig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720150744; c=relaxed/simple;
	bh=9Nsx1AZ7uin99mE0fOtiJPaGuuGbNPflvUmMSDF85D8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=e/L+/wUZxNNW9qENugX9sFr0TJRl8L7Pn9KpF8loZRks3IRIig/8qEOmJr8lQVEd9qHQOJW5JyanTC8r0Ci+it9NEDVe3vkTT/m8gCT7Ka2j4tbRVHb0S9X019BmnNhueYzMEOgCcVpgudhcoJ2HoRuR6IcqbxJMMUpc9AG3XcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mgQY1Vdg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TKPv9TzE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Nwx3w008587;
	Fri, 5 Jul 2024 03:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=9KDfPqCDLd5nfe
	jRqKqqGxPpF4+F8zhinzO3Im68NqY=; b=mgQY1VdgWobXlfEENuRKaBHawRBXRt
	swBPFssITpHvUoqGSO67MNZhZk1KwzN+I1g3CZ93TC0BtRpPaCWaicF+frEplclT
	2CCzLQkAP+EuX12aZ19MarK8ZrtSXnhcR5Tzehy+1mhMWo4UNsbyEvDjxJu6nUBK
	SzDCmKousH7RA4gbiHBwHY4mpb8/ULpYGc2/ZzuyjXFO4GPFN3lOBiPdh7gDoMHa
	tZAuJ4vwnYYEq2Cj8dXp2yjEE5rAP6a6wL4p68r4aZrQNzhWkGrJ5imDQGhn0xrj
	3yYqb4g5nA2O//ss0kkdKLrH/01+fGfsZVMev3FOEjJhTgsZXvLJAzvA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgmkkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 03:38:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46507FhV021474;
	Fri, 5 Jul 2024 03:38:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qh06uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 03:38:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH23QKGlSvyMmHma1LS8N915VOu2Qf4tcOqmoZSBBaGMYXIYZvR2lg0w49kcqaDXdmDYjY5lJS+XCA5w5KWfGwqLNg5+rQq1Mb0+hpIm2Alszyh+xs7S8bBwxNgb1qmdhquuSd4KYMwcqNLkIKJ1xuXiUe7jxX7/GzuqqTUcrhWTJLLUhMAP6jLQYvoAvXQY4XKTPThEjVP82Td0/c0Fhfow6f6NlXl4M3XqfMHkrJrkW8l9bLz+Z4lDX3zc9mt34OFp01Vfydu/UnS2029AmRC7ft48rMHgW2Kzu9yId3avHi262m3L9ZkIpfvJX7GmUQsWZkUWFTD31UmVT+38kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KDfPqCDLd5nfejRqKqqGxPpF4+F8zhinzO3Im68NqY=;
 b=SNT6CHhkwuvvPE1+bdngtzDrjjRFNRDg8WCYcv6zZo08ecsxD67Y12K4GZqfCqd9cQShWxlyBA/pPSQUUscc9G2KHxu02iN8Qz1uJq8k1y2PiAcrYrYwptjFFCzcusWaJ/5I1vYj0vwPHUQYkLY11ZLiKq0o9leppK4UILoRGUxkdVbtiZ9z0H/WZifAIolTLVFPimAkFL2rR96sDFcWhyd5xAK2s3OyKhjhZb0T8v4TKjbT8RZP1IPoTACzb+1tIcoivGdUcmMZJnNO4F8eIYM1P+a51tsu2vzluocvWDMWMdmbKm/Q6jjwrWn95nAQe8OMzZLyr/ZR+N/CsxRfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KDfPqCDLd5nfejRqKqqGxPpF4+F8zhinzO3Im68NqY=;
 b=TKPv9TzEzTOPRgkgfIQoQW3BrKUzRMH9Vlem+DadhihDBYLhOrt+1sGfxXyzewRRhSMfFRSvUYRyAHAIiU5gtVbmBLPkG1M3rDADRvH7/UG+k8V/8Bx8dvgprFb42Jdrfoy5iV+ZxZccvkO2AQ/EbyuEQgnx1oqEWCgPTX3WVcQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB6858.namprd10.prod.outlook.com (2603:10b6:610:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Fri, 5 Jul
 2024 03:38:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7719.029; Fri, 5 Jul 2024
 03:38:55 +0000
To: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: martin.petersen@oracle.com, helgaas@kernel.org,
        sathya.prakash@broadcom.com, chandrakanth.patil@broadcom.com,
        ranjan.kumar@broadcom.com, prayas.patel@broadcom.com,
        linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 0/3] mpi3mr: Support PCI Error Recovery
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240627101735.18286-1-sumit.saxena@broadcom.com> (Sumit
	Saxena's message of "Thu, 27 Jun 2024 15:47:32 +0530")
Organization: Oracle Corporation
Message-ID: <yq1a5iwa4os.fsf@ca-mkp.ca.oracle.com>
References: <20240627101735.18286-1-sumit.saxena@broadcom.com>
Date: Thu, 04 Jul 2024 23:38:50 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 20716bde-28ab-489b-a244-08dc9ca3ff20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zX466IHTTI+JXvLLvk+SkYu9gD6k7zqMDD1COKmenCrGUYAogTG+JPZsqHoA?=
 =?us-ascii?Q?uKplnpmP3jeZKTxz8oCxGIVfbaH8/Pp+Hlf69jfAcjobzq78TMcSvUKMe3Uu?=
 =?us-ascii?Q?/6Asi0bt2bBJppc1Yr2bVSq9yhzX7ONMKBeYtPGr6EwCgEftp4rigq/JPH+Y?=
 =?us-ascii?Q?OPTzUor3KOy5rXjQWfEAyNh+77m3i9LWiCuUOGVsPwq4La2tdiPS8XhorEvN?=
 =?us-ascii?Q?hzg7x0eV3ajoRIfZhkl7tAwNGcpcUChB/gNjzcIHmnbKKi23XOn9IzXWbiL1?=
 =?us-ascii?Q?aDsmLsSdrGvqpsAQKkdnyDYBTunDpXj10P5vk7ozzQNF/VS38ywe7z8U5EPC?=
 =?us-ascii?Q?kcnzFDVD3yVAPyUkd/PqDGa5L3/PCd7G7D0Y2sQuOKhF6kUlBbL+OWGYfCK7?=
 =?us-ascii?Q?nZBDeBc1W9S1byCLG9Y0MC1u/vv0P2lyAaqS3ke9JSoVvF/tQ4u6J1VwnstJ?=
 =?us-ascii?Q?E+SBMUfyjwFj0DcBxYbBEaoj/gXlM4fXFO/W5OslMkZm+W6YDUnVP63HGJnZ?=
 =?us-ascii?Q?ad056CCmk+gcCdjQ7FIA2j+ylT/T0fHQiCdgjwuO8Nty2J48HAVlFFe/8kQq?=
 =?us-ascii?Q?wNaV9VpX4iwnUwMVwAvh0Ru+hOWcejWoNTMEHx7MsFzUSS77jh64d81Pji2N?=
 =?us-ascii?Q?Vr8ZLXthD293MLuqQrS04XMTo71KjFWkyeNlEKg2VnhAEjSq7FiOGHEfqUct?=
 =?us-ascii?Q?wgo/lOPpOmFuNUwRol9OLPxEGyDvbn2RJfFOPbOeC+ZpBXCZufK/WBpjp/my?=
 =?us-ascii?Q?TSp1yZXM+rlArQmY+vnhLOszNMhzY1UHWwbgGQY8w7g/dtEK4qxBZiztxli1?=
 =?us-ascii?Q?s8rx4d08Y6YH8c+HGIvOQMTbTpGVeOaoQo9jjIS6IZy8g7HoiFgzRG2Ma4Tu?=
 =?us-ascii?Q?DjdEDCX+SQ37WxquP/qWrKJoUgEjO5XFniHZBzb30y7sOfy5P59JsIx4rPiY?=
 =?us-ascii?Q?6lZzHIOK7mIVvpI2eoc0reylTqZqlDJ7QuxiDFSV9ckTogg6x5NVmYDf0L51?=
 =?us-ascii?Q?zfkRsd4DWCuLguHQwQ8d17+cV4R52vI0jr4ATSivjLdQYmueH+20wiHASqRI?=
 =?us-ascii?Q?mpvsGmhrIXLCZ8t/BZ7Bs3Qa56wGE4JqkdBt1v/djUuWXrnMCPcKARzK1yCo?=
 =?us-ascii?Q?SmCYmBaXxgpdKiK+mhYZttw2gxuj6jSxf+y7320EMAuV9APyeQDOb++oAse6?=
 =?us-ascii?Q?EShy4lBlonKccACVmlUhlFMftkXX5k/YnPKBPJDdYsJ9p2U1MtvbxtTkSv6y?=
 =?us-ascii?Q?ZFjSko7ne7HD0O74eDeT6OYnKug0mddRq/49FMAiaDeCZ9CnLJ6Bv4n1etUU?=
 =?us-ascii?Q?kSbnyUENtSjR9Ci5KnvmxD2mZzkNSKoDdfobQ1h5+Tgcbg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JeYz5KTzsVgm0ppVlgXcPz9xLGe6maOWy694VlS4XbppmtLqgVoQuffSMww2?=
 =?us-ascii?Q?vhZSdJU1KnanNPFxK9a50u5cAhvsCXJWBeyYGy7hGtWJ0yGy0htWcvUC0m2e?=
 =?us-ascii?Q?BYhnLBFx1fWEUl1bIdeFNSZ36R6K7jVvem4fBGJvoHCsyFSUfs+dVReQyZsI?=
 =?us-ascii?Q?ODzWPcR1RyCpjbH8M6spjgWt0hSaF4LjAa6moEex+MTiZGZxHx4rd5DCLLTx?=
 =?us-ascii?Q?oG/AQChy2jR6UCSvPetXE2lG4cpVHg6Jz7tvUSXcuAjhauZtRMLZi5/oqLTo?=
 =?us-ascii?Q?2ru1KczpnIYqh42t7bb/zq2hwyc0VFFkEKlPrrb/YrI5CD1yNR58KYJgcNBF?=
 =?us-ascii?Q?8d6VjccJ2slatW9fgNQ1h/1u+RiMUnVXDIu/+XeVTgxrOWp7GU5cQdY9EKe/?=
 =?us-ascii?Q?sI1qWEdKuqRP14PVBKBRtgwVgSFBjigXvlONcaF7aDalzpzfN71FTSOEtVPc?=
 =?us-ascii?Q?bDX5e4QUXZjQIUHfrh9HGiMOBAv+ct8gioMWGp2blJaUHurq1GeLTZW/ax9d?=
 =?us-ascii?Q?IxpHvPrLHqFcyX0NXiqs+7JzsFMSDffaXPMmKm2SdttY85eLxy3Ve4md5QFv?=
 =?us-ascii?Q?0WYNlJhmT3cgUK1NfK1s/2JnHJmLi5nQ0wbs+uqHhcWh2QDxPqx1X8csDkom?=
 =?us-ascii?Q?8g0czZsjgWk4FJx36EoH3z8jGrdEXn1DZuLNP3p6UPC079H2IUoY7M+jgn7Q?=
 =?us-ascii?Q?VIBV13YJ/EJrvGK2UJCMwNkBB0qwkoOW6enbmtiWtsjjHGWxV0ddCRiGWNAa?=
 =?us-ascii?Q?DuHBgYExMPaXDS7XjmX/sI3E3GmaSllE4fuXQ7zYZC+FmEk8VLAVjJyJ5LLt?=
 =?us-ascii?Q?LV+1YGulMUwaAsrjdrXYL2Yw+GmZdFJC9F01gqVzGg8CGHwAhDcLMP4TJpnm?=
 =?us-ascii?Q?sL+g5qT4dNTbcxQapIn4yrwZxd+Bl5TP8wXsI7jn2DgNYZNFK0LMFFaC9OQu?=
 =?us-ascii?Q?NsX8JEBJWvHWjN2JTsbGhueZc6gUa90Si/1opatBUH9Z9aFp/syRxNJ7h+2x?=
 =?us-ascii?Q?gHGtei1Taz8JqnEtOVcodTZp5/At8efdwz7N2kvz6WSMt04PbNiFSvC8QlLO?=
 =?us-ascii?Q?GXBFhUUq55nJUXggOTkPdrXBrVWbsz8LmQI1ZticedJj8oe00Qnn9aA7klMY?=
 =?us-ascii?Q?4cHSrhHsrGSjtNnnpzXei0syxA9S5YZZRZoQ0n9oc5dFMT/NxP+RA1VjDV+z?=
 =?us-ascii?Q?iyYTyztsjf0OMRT31ebxI8oinrO+Vzbk6oF4Ru3Y6Si0i3aSVXWtrNZTt/M9?=
 =?us-ascii?Q?7dibyuTP34iWf0Ho5r8cWfz4qIJTXTKYi85XZn9hXBTFSLFvpehfZWhkix5m?=
 =?us-ascii?Q?MHwZQfiKTcogn00OlWV6PPztfXAsz5Htv+OsgK7v84E6NMUJdISNoBrvztPh?=
 =?us-ascii?Q?eZEQlYI7y+1yQAuQ4HN+dvch+OBPLQborZ57megYCGDNuDolfI/1lIJfuk28?=
 =?us-ascii?Q?P58zMIkRhpe/sN/SMUcxGhDgzPHFCbgn8oMDbiDSdyspxokvAz5wA3VMfbLP?=
 =?us-ascii?Q?ArnZdigcPfixKFVsiYuiJGMnD0EVH3dIV+UgdvvxKSpZtFa6KV81zuXD1Y31?=
 =?us-ascii?Q?f5L1ZGzl4xIh1bFSylcB0kobbFC0uc2TCqFlD49y9QRgi7m8NUqfe8rYWpde?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DyXLOAe/QZe7vjW+3wWNKbxoubR/9OMpXiHWP7G4DWwDZ0iC6obhXZDfoiw8Ibntipzj7ClpJVW7eeXNgDJ60GOstu/9Bmj08Rsorp6Ac4xDGBn61cATObchuToeNf4JiYPFWBKWh7SOkjXugirl3icbeyNQxs7eOgIxUj432D8shwM3YmTQ42j2hwlka57VTCwyQuryaoFfKN3Y3ssHtSL1/CV4vnarZ0MRDYpt0rcuao3tmBArxPvj+lVUtqeenT4oa5AaIDARI57a4Adv56d1uAuvJ/EjiDB22gPvpzXUUBhzGn6+V6ditxNLgIvQlqDgsiwUgrI6lhut9QwR/+mrt3fJpFvBvQpkWgXZquV2NcYVBMHKPGQS6GFomF/TroCW3lvq5iUZaAPQeMWzptnp6hdAxBurOrA2V5NE106DasPuGe0WnAGVYXBL+SdyWrFZjSZPIkv4ZyU27RF/wZ3SeHVf1Oz7QAuW/QAblakG/Y6ND1abO+IQ34zy6s9Uk/K913OwTH9nNFi/VIPwf6OecF0UR4Sw7s2U+zAFRvqbT6jWN+Ag45d3rbbivznfzO4x6RjO/v2hRSkNy/kM/cWpymEBn2jRkDDMZgI03tM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20716bde-28ab-489b-a244-08dc9ca3ff20
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 03:38:55.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rh+JX4mNgw5BcKipkf5HunmbrKwvt+OGhjs/zvQdzPQhmjN4SJ0qhefg04QTo7SxRvrFzb9Nr5gI2gVhHsLE+Nt3cVVzdC43P3rodT3j+Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_21,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=632 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050025
X-Proofpoint-GUID: QRhkSbdNefBHIpQ7O1BR-zw0h1TtLmkH
X-Proofpoint-ORIG-GUID: QRhkSbdNefBHIpQ7O1BR-zw0h1TtLmkH


Sumit,

> This patch series contains the changes done in the driver to support
> PCI error recovery. It is rework of older patch series from Ranjan Kumar,

Applied to 6.11/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

