Return-Path: <linux-pci+bounces-26640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5CA99F00
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 04:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FF41946B5D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 02:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D51433B1;
	Thu, 24 Apr 2025 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="esVsFhw2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nr70wTJw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8F7E9;
	Thu, 24 Apr 2025 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463367; cv=fail; b=M5X9xsYI/UAit3ZH/afw9u6DOl4YRYYVYmUKJqO0sQjdmkE90DfDYXKE0HNxyyYoD956ZfIsfhYHd3nRWBqMRl4KRKB+NBXDZ4i3nkZSHWnUbHmGTzU/ZIsbdej1AP0EA2xa0oY0fN+8dOeFfO/Z7alz18ro4mFhuQJjRpOxR0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463367; c=relaxed/simple;
	bh=liAD1V3kY/lYjkl9lARSyNZBCYLNug4vLN585USAsmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gjmutSEB+URnkcbeWTVbaidrUslsCPYus1bBP8sB/FIFpHQvs3dca0L18XpH0FMH6+82hVKkE8DUAilVRenDUwCstSlA1RJDysZTvSAK8rydsTB1t4EFJ/w+XZ/V1RbhvNHBkidw++CrXz3uUHq6+1J4UmFblUcpw9HEP0HqNyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=esVsFhw2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nr70wTJw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O2VxNK018153;
	Thu, 24 Apr 2025 02:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XIhPm/PnlsFsNKtJL2q+myzcy3uCB9z7lSFdrtUTFV8=; b=
	esVsFhw2NJ1aQiExiZapMJQMwsxs3+YCwSzl7259ZnPeJCp/QyBJlkKaKf2eQrkK
	3VYESNope9j1y3KTZED68jc1Tmr8ypTFk1FdTxuc/Ns476/c/HPxVZDxZkv78/G1
	2RHs/GcbXiEAO385BXAIkQLJvl7Zkj5Z6Wq5z29/29uUD/B2EULgDxwLsliNXDLt
	3Hoq3LidAY1ZuHAJJwiagjIDX4oGE3rLk6W+n/F81FR78Nd77rLgvn8kRLgT6cnQ
	rdV87Rx5InUb6NK21KCz/labHQCqZqYgRa6FYkYdTSjTgsqTakDNnhgV7cLcJHx+
	OsQQO0Y+pDsR2XobIPB4kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jkjjxey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 02:55:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O2hw7H017347;
	Thu, 24 Apr 2025 02:55:47 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jvfxvph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 02:55:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE3COgCMQKwKRvkb+m8o21QpJoWT6MnmG/nB8e6W09MWWsmiq98/YCcYLBZfoAyeir/Aw17cKErHN+RSY0dVoodrqhi+Lu8Rw/k6AIPXoChLK4kBx8qgKsqMqqaH0xQgt0TVeAbWqv8Ng0KNUgq7C0quaLI31f0cuNdfqvKJF8nlaGQ/WQd4Qdv55BQehI6akyr4LR4hOhKbAeFK6JRA2mh4o8kZN0Q3evqiSObcIpyfnkgaAejkRcAEdvooeY0g6Y3ddGCdrYl+AMnPYBPUfaH3ZBR92jhoteZFNDwuyAs7O/L/cxj0xGDD3JdKwaPK2r4DmjQqV7e0KtOvk4AYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIhPm/PnlsFsNKtJL2q+myzcy3uCB9z7lSFdrtUTFV8=;
 b=PbhSC5f/JWNtExObEUJVBScEKv9JpZGDnS02GTXrXAIk0SfM+xbtZVHkvnjLb6oT/R5s8eAwTorvcSHhhoWKPfyG3qhxgCaOCttn70Tlz0kifn/e/m3zapnoc/dGVWZ++DITybM6eN2JjCaiwrznQdVj0/Xt22yYZkXQ7J/4bSm5aRlig9ap57itdXnrPuc2RHkxORTyyYbEi2ZsEUzeOFsR+kIlQ7oNb4gC3OWRTqUTDSLKRW8WjUjVwvz5pGKCkXACWF/1FLRsFC9fhyLtQsaaS3Nkz1gp5DRU7IzG3TmNItDmGpqasR8uRqKOsuFrqCs4sZwHM/tP5GnAmpdF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIhPm/PnlsFsNKtJL2q+myzcy3uCB9z7lSFdrtUTFV8=;
 b=nr70wTJw0rs5g7DsOB+BkgYLF7mhQMEPe0CBTJI8E/5zu6XWEhDviqdBtsT2pmAQMVQdeD+1mbiOgFPunEgCO1etWIWyqYsJNMpkLZPJcRaaktTy8Q2WmNBX2UHWt/QQtRZk8u44njkz9lUjA8Yzms2RiT/hA3RoX7SiX3P3CUE=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Thu, 24 Apr 2025 02:55:44 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%3]) with mapi id 15.20.8655.030; Thu, 24 Apr 2025
 02:55:44 +0000
Message-ID: <40f142be-12e1-407f-8b64-05d8c12f31b9@oracle.com>
Date: Wed, 23 Apr 2025 19:55:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Report: Performance regression from ib_umem_get on zone device
 pages
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: logane@deltatee.com, hch@lst.de, gregkh@linuxfoundation.org,
        willy@infradead.org, kch@nvidia.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <fe761ea8-650a-4118-bd53-e1e4408fea9c@oracle.com>
 <20250423232828.GV1213339@ziepe.ca>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20250423232828.GV1213339@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:408:f6::7) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|DS0PR10MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: be24d8c3-b3cb-4b06-a3fe-08dd82db816a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2UwTU1KWFNkU3g2bGhzQ1NEZWNQZmVCLzNQY3NwNHZBNkJhRzZybThxOGx6?=
 =?utf-8?B?bkRjOTVyVnBsaFFiTGFTdHVIVWVSb1pEVndNSFRPV3JGa2xRVVlueERVMVRL?=
 =?utf-8?B?MWRPWHhsaXNXNDJZcHhZNGxVdzBVdW5FbFVya3Y2d3pLcWdmcWlKTWUwWW5a?=
 =?utf-8?B?eDlNeDhFMS9ac2d4bnJoRk83MFdTQWVXakluNTB1eWU3OGNBd1BtYXZSVk16?=
 =?utf-8?B?VXFFNm5KU1YyaVNvUDlGZWNpaUtVNmg4dTJ0T3hKd0txdnRsTkppenBUY05r?=
 =?utf-8?B?QWNGYWlwR2k4ZSs3ckRCdU1TQ3JwN09vR1QzTnVkTThMcGVjYVQ3WVAyTXZm?=
 =?utf-8?B?WGZORS9qaDJTUlN5MnV3V2FsQUdOSjkwdFdCTE96OVNlUlROVzhYUEFMazhO?=
 =?utf-8?B?M2JhaHFqUzJuVFN6VXFZSS9aRWNnODQ5bEhEYnpDb0R0RjV4MHozTnNuQ0VK?=
 =?utf-8?B?SVZWWnhrT3BnUzJFQkhpV2VlRXlFN1ROaUZwZC9OVFlqUURkTFRiaVE0NXpn?=
 =?utf-8?B?ZW1xYTZlYks2UFltU21SL1hhc2JxSUdacmZKZmlSeU1yUkJENWVqdXJzeFY2?=
 =?utf-8?B?dm5GZDQ4bk1mSWhRcVJFa0ZycnpBa25FUG1oY0pMNEhZNWJ1WkJBeU1KRk1p?=
 =?utf-8?B?ZXY3SW45clgremJFK2QxNUhpVlg3cU5VeWlVRXVVMUUzSWRqQnJ2aVZLSmti?=
 =?utf-8?B?WWRyWUE0dFhkeFpWL0pQZFV0R0IvMVVsNHpGV2N4ZUFhcjhBTGVuUTJJaFdy?=
 =?utf-8?B?UDlGRGY3azZVN2FwQWIwaU85YlJkVi9xbkRreXYraVdGazZrbEVaL3duN2R1?=
 =?utf-8?B?a0ZYOUsvTUVHYURRK04xSGwwMW5Pc0NQSHhQQ2cyQkNpUE1iOUt1TVlnd240?=
 =?utf-8?B?N1ZuNXp5ZFVlZUtmL01FS2VHcEpTWGVnb25JdXk5YnpqOExPU3NmWkVYWW9z?=
 =?utf-8?B?djJiTGt1eWpFVEN6ZXd1UkQ2eTBCOWZ3dkRRM1lLMXBick1TVEJBdzI3UTVW?=
 =?utf-8?B?ZVpSU2ZMM2ZQeC9meEMxay9JQkFMQzQ1Q2JRai9iQjBwd0gxK1FjQUtUczcr?=
 =?utf-8?B?enFnMmhXcDB2aWxFaTZXYmVoQVUvZWI2OTFzakFJa0prNHJ0SlpkWnpxazZs?=
 =?utf-8?B?bkJXNUViRE9xamNlRXpKTlZITHE2MzNYUnEwNUJWdVdDWW1tODNzK1FHNit2?=
 =?utf-8?B?VzBremhaZk8vcW4zKzJEbGpTdWtYRU9pR0t4QS9vK29rNFRvWVloRnk0YUpL?=
 =?utf-8?B?S0pFUXM3NjhZdTJLaGQzUEVSMnRrQlVqbU9acEcra3dmc0F0UTJXNG5UVlVN?=
 =?utf-8?B?dDdoaWpqekovUHpaYVNpSlQ5c1JnR1BuMUtsaVNuZWc0UHVnVlBrbWh2QjZh?=
 =?utf-8?B?YWZjbzFYZ3dxdkFIUVg4NTE3KzFLZkRmY1RqeGtEOUFJTGNnWjhFNG91a2xt?=
 =?utf-8?B?NnNKWEpQQjh6aXZ5WnhOVUlZMWIxRFo0ZHVPMEVKR2V0WWtCUE4yMUt3NzJY?=
 =?utf-8?B?cEJjNkg2aE4wNTVpTnRWUUJTbEw0QlE0VWgwdUh2SFlMVzk1alZHMjVZWDZC?=
 =?utf-8?B?ZGJVTW9qSjU5R2lxY1F6cjBnSnkvMHVWcWNXRmswMGs5dVhhQldINllMYjhS?=
 =?utf-8?B?dXpIWVF1Qm8rTS9DbDJ6VWFmbEE3ZVZVMmZNZ0piWEVnMHRXcHV5MXhnQjBs?=
 =?utf-8?B?UXJlenpqbnp1ODVTWE9MWWpSNW9LZVN0bEZvRlNOZkhJTnhTVGNQd2kvK2Rh?=
 =?utf-8?B?aUZLL2FTb0YrSFB6dVRoSk1sK1hHRTh1bytJd0VVOWFXaVE4YkdqMG04UTJP?=
 =?utf-8?B?V1ZHT1JtUnJYWkNPaU5iVk53RUFNcUJid0t2VFp6M0F0NWlDYzBwQ2RpeEs5?=
 =?utf-8?B?YWVuK0xPOVJXZG9JWldmeXM2WWlQMDd4ZVZMajM2aEdTTlMwNWpqWU5xbk4z?=
 =?utf-8?Q?y86nm2Mro64=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THIvVGNmYkhwUE05dVoydENRQkt1Tkh3T1JLS3cvVTR3dkdFUkJIWTFoNWdn?=
 =?utf-8?B?VGFodFJUZTgzN0ROL0piakgrbnBOdEhSdDl3ek9Pd0RINGJOZFMrN2syV2c1?=
 =?utf-8?B?ekI4L0JaRU00QlZSeUduQzlBWGIzeXFBaUhNc0ZKbW5tSTBIU1AwV1c5YUE5?=
 =?utf-8?B?K0I0bjVXWG9GMGMzVWVFUGJEZGUvWU1iZTN2MFdrajExeG9YWW80MDdoK1h0?=
 =?utf-8?B?eTJaVFRQbXBWQ2dkQkp1UGxVY2s4UDM0ckU4R1BCYkplVkNXcDZORVFsS214?=
 =?utf-8?B?d2ZoYmx0R1RJVUh1YVJTZjBpa09Ma1dVeG54c3JrQlJINXcyS2xmODk1bGds?=
 =?utf-8?B?Z0Z2czVJSUlwUVY2M3VudUowTlNPRGp0bkI0b1E4Tm9FRytOL0RudnhtSk80?=
 =?utf-8?B?a0FFeGFqVEoxV2tXVGdBMDNHamRIcWlSK0IvL0VPT2Z0clU5dVBrMUVJaXAz?=
 =?utf-8?B?dm5LQ0xYSHplSURLNnVlbm4zSTFrRlpJMzA0RHpiOVlTM1NYYm1ydnJGOFM3?=
 =?utf-8?B?VWhwWFlxeXVMenVaR0xIeEJYcktmN0wzeGZKa2pPanE5RWdacndoaU4yZHFO?=
 =?utf-8?B?MDNRVkxFVHNQcDFscEFaL0J2ZHdMdWZSa1BrVXFydlhWZUs3T1lVR3BJeFRN?=
 =?utf-8?B?cm9ycUdnQldHZmFJVUlacjFIemQ3SXJPUnRaYjFnTnBNRGRheXg2QUV6Tlow?=
 =?utf-8?B?TlBWWVNWOENsTmVWNG9yLzc5K0NIbHdZaHJGMXU3THowS1VxM3RlVTN4R1lz?=
 =?utf-8?B?T0k0Ymh2eFVwYmtTYlNLY0hWOFpIQys3RVdnZk9rM01XM1F1eHkvMXJwUFVt?=
 =?utf-8?B?TWE0K2hPYXQvUnJ6NGF6VyszM0xTTHBCM3NhRHhLWE5pNTdUanI5QUV0dlh3?=
 =?utf-8?B?SmY5RzdRSFBnQTh4OEtObWdUU0gwT3EzcGVMMHcyOTU1SGZYdlNPby9YYlZP?=
 =?utf-8?B?WFNSUGE1Wm1ydXJFRFB4SnVrMitvaGdaaWdZWldvVHhweHpUWEdqZzk5U3Nt?=
 =?utf-8?B?VUJtbThEZkMwb0d3RTd1YTZWTnN1R2NTU0pLTkdJTEJmV1VHMmF0RnRBa3hj?=
 =?utf-8?B?YnZ0ZlNZczdoTVYyMGM4SXlYd0x3b1NOcGJQRnBJZXhNMjNtMmpqUEFPNXV4?=
 =?utf-8?B?TWJJeGpXL253NXB0YVI1T3ZKOG5ra2NlYk1tclZNU0c2RU5XdWE3emtBQ0gx?=
 =?utf-8?B?YUY3M0JiVk9WWjVrWkthR3ZHbmxFYVF0aTF4ZDBFY1czQkZvUUFCZ0YzV0Jo?=
 =?utf-8?B?TDBqd1ltdVgxMWFtMUIxa0xZc2MzZk1Laks0ZFRTYzh2SzRtclVyM0E1SGNx?=
 =?utf-8?B?aG4vVWg2aHl6L2tmRXQzQmxXTXZabFRlakgwYWlla1dQR0RSVG9Edm53VmZq?=
 =?utf-8?B?a2JUc3J2cC85NS9PRlIxR2JGRU1ta2w5SU9zRXhDbjJWYXJxcFp2S3NZNnlL?=
 =?utf-8?B?amFQbWgwQmtsR2NvZElsOGdpS2d1QWpVR0x4NWh4eWZhd1M3RUdla29idEpD?=
 =?utf-8?B?VXF5SCtNL0JHMEpYVjYxU1R4Qk4zZTVwOGVNZ0RmaWFQTklEYWNkNXBzOE84?=
 =?utf-8?B?My9sODRHMW1XeCsybThEQjJpcHU0alVFNUljQkpZVmg3dXBNMDRTUEQydm1P?=
 =?utf-8?B?MU42aktEWjdYbytmeFAwUGhHa1dNUDRIR0p0TGhJZHBjcG5Scm9GaVIzbVZj?=
 =?utf-8?B?UDdTMWlyYjZVWHdlSGFSYzlibmJ5cUVHSnJYRjRCZVZmb2dBZnRKeVM4K1U3?=
 =?utf-8?B?c3VrTVAxQW9nbUFzeHJ1OHRETGpjVHc3bTBGZVRaMnkwdElXazFZR2oxcWFt?=
 =?utf-8?B?Q0xpOXVOWkNVc3lZWFpFS0NLNVpwUXVOcE5ITFk1VlNBejVYY0dWZytIb2dQ?=
 =?utf-8?B?b0s4S3BjbzJZNEFGdkYwYWlnbDhOUlFiNTF6SkdzbzRJdWRWRGVhVzNXT2tx?=
 =?utf-8?B?K09NY3l1aTZMVXIrd0Z6SmQ3SEZnRFNocUlTVHN2U1pSaGNwa2Z5NDZVZnpI?=
 =?utf-8?B?VVlGYTNXV2hoY29YSmtpRHd4aUNwaFpQT0RiRTFFbEFGM0pZS3BDblZJdThR?=
 =?utf-8?B?d3d1Y2twTWVwSHAyMFRKai90cWV5Qk42cXJEWE5iTVltSEp6U21raVN0RXZv?=
 =?utf-8?Q?M54p9pnIvJSuWAW6sQkEZJV7b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cRReBOJxeLyUz/tn8N0UgwHK1SjMIIV+BQYse9V36J0mZlisuYXx9sZv2Dor+RX7FyN6gtagvHzkcBwUpEQm/5tYYBfQiN9q8STLJ6WHWyrRRhFnP0s15xqYypz4vABx/MnM2w2mfQrEJBBV0eE0olIHciz/gw4/E9H7oVDGSkeutTZ2k3K41AHIEXveu91DZzh5tRY730w37hl579mFMhDrTko0aZLgTy/dCWpCHWBRnxAaQaHwS9pCvyskdV/hQMRRKLhBLCQysLh7EmUMOn+nZ0bJQcJYKWUy3dfR69noE7SG5XEQXSF2RB6EXWnmVpxKaJjRi98RUZNFxNogSzcHolg5EU+8a/ckeSMSe3eUSWRMFQsakfiIAkxLjfAJpScXBBy1YercByYTP2FVxdH6RL7A8CyCdS1RLU5QtBvigfGTJ8sH0ORxrr6UA/Em+zJwIShSXzhzMEJI9ukXUy9RCaZibUc2TfzHQ2H1CF2MqCNkxKQalgXveQMcq172M2y5asxBmosG7v+RQkMHKq8QrSLrsrLnDJgn1X+plSJUtNp/cZ7WouVn66Q67V/Iw5Dee26o11yOM5J/uEozs0R2sm8i6TpJyN1rYzn85bA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be24d8c3-b3cb-4b06-a3fe-08dd82db816a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 02:55:43.9686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38eqFz0bc4fNE03yUZE3AG8qpcZKx9qaY1OsTJpj3vdLBEgkgmXrYy5ZGmTGTKP/39pxEIMBxB879pGaWEQqKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_01,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240015
X-Proofpoint-GUID: mbRv2Eh3vRrwrAK1ioMXkuueC5GFMQ_s
X-Proofpoint-ORIG-GUID: mbRv2Eh3vRrwrAK1ioMXkuueC5GFMQ_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAxNSBTYWx0ZWRfX27l/jQHwUoHd 4WI+axlLU6Hloq9ktW/eEbbS3j8v/W9UXcGoH1dd+huZXTKJ2gfT4i8c9hZnVM0Ff/fK9HRjXFb 67rjqHhWpDAxCcl9oBLbwwT+ejZnbnXzd7OKYITqwR/AjqPhzQw0GyfOOInZXTyZfDXPDoi6wgc
 T+Ikc1eFKdh1g/UvMRalsRlKe4OSa7LIfjRH/z8V86nG7zPi3qWEYoXErCZfhaYCTkkWAsfKjUI jet5utfHjl0oxiPlg6IVws8bPunkhGZRAdknpxdj+LfeVEoOZxSufod+T5N/YXutiE27r0TyTzp UJWxU7bURX7ngo7UgI5miC9UN3kdi14uAHFjN1X0yZZlf/Sl2oYyZ44G2SjOvZ+rojpXncSf0GN OwXqhbYb


On 4/23/2025 4:28 PM, Jason Gunthorpe wrote:
> IIRC device-dax does could not use folios until 6.15 so I'm assuming
> it is not folios even if it is a pmd mapping?

I just looked at 6.15-rc3, device-dax is not using folio. Maybe I'm 
missing some upcoming patches?

thanks,
-jane


