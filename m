Return-Path: <linux-pci+bounces-22738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DADA4B962
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 09:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198897A1A81
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90861DFE1;
	Mon,  3 Mar 2025 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVL2/TeJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zD0A4U5T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD11E5701
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990743; cv=fail; b=rDxVnGkpesaPweXtgcE9vFW4vMdXXFq5GzRj7urWgDfpIKC9OCtf1CdMM5J7GclnXms028SwPHCTB+jg8nwXDTYV9xtz+u2FtXBuX/OI2uu7TqvyVDZ6wxSnd4bm6NALnqmGJs/mRl+82yhgIRm0NP4R16q7BZpiHmETDIdEvA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990743; c=relaxed/simple;
	bh=tryEOLKYQI72c/rUqcaSjLj1CgLVivHxowk1RI33Piw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvMdcFQxRuc8ibWURojtaOsD7XbwS0uPYzGJyTYx+f/G9glfxmd3NXtEEKQYlYRa4dnyzw/9O3buPyf7ueWsxKz/VXN04SDpVJSBUt7kiPEkSHqwQ1ZW8Qp+94Y3FA9iYmf4rMWPQiVb4QrOgeulog+hVM5PRryhUl5SOiENIJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVL2/TeJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zD0A4U5T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237td3Q022615;
	Mon, 3 Mar 2025 08:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EjCSUesrDS002532+PpWItqAk60ybAIHOzmUSyUEw30=; b=
	eVL2/TeJwx+k/OCEkQJKiBt4Y59gROu73bz5IzW5K+5YcozCwnFkObdRbHEIXskK
	emOw2W0uYJsLFLgzULIbHsWWkkKXScx6p6XuNmNZ7jp7c+Vqcvf3sKP7rP8zExUA
	bHyRNJJ7BRWz+e7honmcm8NjIPdF6E0t13om+VlYe5rDKdgoTbdsvPnLxMY8uuk9
	GbV9YrRbqVGp+GPmtFMJCW40hMdFpjikEt4L/acMq0YlKYh7sy2aASiQ3OXMvt8i
	yqLLKzJaMEOSJMnrTfhT7zsV0DSJr2bVJUf1LWSuRDEW6TLU7FHLMV//ycoOVH8V
	ub1J/s451iBT5B/04o9KLA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8ha55a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 08:31:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5237iRQi003169;
	Mon, 3 Mar 2025 08:31:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp766v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 08:31:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m68vK4kaUDh4mPkzviKvMoFu3OiEbb++DMyhcuc4IPmMokXT9bX7MqWgOW+Qhiv8gEJ4ZwS+d6avDx8lnJRmxi5GADmd6v6V+oj9G+febyBXPJOW48dyDKg+byBir/fiaEQQqo7Yf2cNVEkwDr/ErTUxGIeaXH5W0SQqddcvqCHy/RItxkmlUVfDSYggpB6oRFh2iB+o7fpAyYEf6sfkOOYuGzuRj1C3rHPwJu5iN2c67Mv6WSX1lBqMoXrD+VbEQVrP8skinXpWgGoNkBmKFKoh/CfHZSCZDoMWIdlIm6NYHvGF7tvfyBkEIbl8Xpu39qRxs8f8zs1qFtOZ5BYzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjCSUesrDS002532+PpWItqAk60ybAIHOzmUSyUEw30=;
 b=iHejXwDyMkG8+EgBmVOlKMVk2zvCjEL/pW0nuw7i1BDTr+GgKuiiKpZjWPi7TokvR5tHFwQDmUC714upJKM89KMbIiwwhZqMql00G0x8OSaZ3PHHLprFtRalSkDvYZmjkxkC63sDsW+DLcwrBB/xJyyo0uhus0B80NDmSr4Tu2le1nj0+x5+ut9YLDkGQ3NHmwAUQ9zFY+U0Ltgruyz7rh+i2SkIO3WWIxeM563LQtd5FqxMKrXEwvT8JIMdXhEK6Tb9HhSdCeET91y6Gcvhy9Swvxmfem+BQSm5XmonbB3xYp9zcq1wG19n9YsF6q+OFxcdw6Qt1xLxsnEK5LVgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjCSUesrDS002532+PpWItqAk60ybAIHOzmUSyUEw30=;
 b=zD0A4U5TVfond7hEblwNUaT7QKvqnoOPMzh9tdZs82qFavmh37n4RUJ7Pd91cy5xJjHIOvXF3MTfLrTBgOpVVcCwydA1yoQbzZsG19eqhZtjtIxHPMNXf1LJA1USSt/bWXKd/JNZuw1nRBu8N0XpZLCKqhDxTljidJSEdV4byOM=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by DS0PR10MB7478.namprd10.prod.outlook.com (2603:10b6:8:166::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 08:31:55 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Mon, 3 Mar 2025
 08:31:54 +0000
Message-ID: <49bfa13d-756e-44e6-a14d-0e4940260bcd@oracle.com>
Date: Mon, 3 Mar 2025 09:31:46 +0100
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
 <319344c5-02bb-4257-92a5-424ce72654f9@oracle.com>
 <CAMC_AXXaxsUDkOa1SED4F6AZ8TQceHOJfQMJ8FpmQ+=gzArV4Q@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXXaxsUDkOa1SED4F6AZ8TQceHOJfQMJ8FpmQ+=gzArV4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|DS0PR10MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 54200a13-3c52-4469-7278-08dd5a2ddab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YllTTHZsZFJQKzBSQWFVS2RJcGo0Ni9oMzVNMTdUR3hCa0lTR3h0V2hLR3ZJ?=
 =?utf-8?B?dFgxYkNJYWhaTUtKS1VFZFVoOE1taGFGV01HbXd2aFZKT1lQK25WVUwyUERt?=
 =?utf-8?B?ZCtHZnFCUGJSVC9NOVFNUENVSGJPTmE1TDZ1RjJLN1JTY2lqejBoV2krSzMv?=
 =?utf-8?B?ZktjYmF5SmEraWlhSjUyanEyNUpsZExFeUoyU1JEY3MrOUV4bUVtSG1MMmhH?=
 =?utf-8?B?Y2lLaXpIVlhWV250K2V6c0FFVEM0WGZDbTJwSUkxQW0xaUljQ251bklWMndu?=
 =?utf-8?B?T2k0dGtQaUJvbnRaNXZWMDRuSjgxMzQreDNZeUd0TnYyN3BBNHN5QmVOZWxs?=
 =?utf-8?B?bkcybGNsYW1GRmtaUVpnRmhTbllkektNLzdWMEh5ckFjZEpRZUUwa1NSU0dI?=
 =?utf-8?B?L1ZHSU9OelUwTDZveFR1Zm9tVFdLUDUvbUpaMEo4THB3WUNSY3Uwdk85cjIr?=
 =?utf-8?B?K2YzY0RTWDlJRktkMVEvdk1GVzVkNDZpQ3lZNE4rTkxJZ2UzcDBORjZ2MmNX?=
 =?utf-8?B?NTBrU3JDUm9EektMQ0phbk5VQXg1TkZjQ2JiU05EZ1duSnpMK2dSVm5lTHFY?=
 =?utf-8?B?amY2L2NzZGFab2svampjSlVxM0xlcGJWZENVTUZRbHdpMksySzYva2FpS3Zv?=
 =?utf-8?B?K3hSeGZiSGRQdlBIRGNVcUNaaURxQTNtTVpUcWI5OTRHdHpOdG5zTStueGYy?=
 =?utf-8?B?c0FlemxoNSt0UDRpVTZGTlg1RFFHcjF5aGxIZHkveThBeVE3WVlSc1Z2ZjdH?=
 =?utf-8?B?OFUySm5CTXB4dGlQbVFvZ01pbEt4TEJKc00xYU15WG00YS9TM0UyaG9lZU5y?=
 =?utf-8?B?WHVvTWlsWHdWSkZ0YzlaTXh3LzNBWnV4b1BGb2MzdmRYN2w3RERpTHl2NzE4?=
 =?utf-8?B?cjFsTGFOOWNXM0NRWVNtVkJVRENrWGVsdXdVNVcyUTNscGxnekl6Y2pzekdL?=
 =?utf-8?B?ZVBSSm9NTDVlcGRvS1hoZjBiYW1FU2tjNjZCT3FFQlBxQzNyNnB1WldFeWwy?=
 =?utf-8?B?aFJ6cy93RVcyVE9Zb3hneVc1WERPbmpwejNBcFlyaFJnWFJyV1BudXkyaHZ1?=
 =?utf-8?B?OG1PTXlCT0FpbFVHOXI3VXkvVTNqRW4yazFuellrTnRGRGI2c0RESjBXV0kx?=
 =?utf-8?B?Z0FUb0U5UTU1UVNFUlRRdGFBNFZMOUJaQW1wbWtjSFNTUEExTi9BYXljekt4?=
 =?utf-8?B?alNSQk5MZzl4Q0IrNnZ4RE5JVVRjalJyMGNvdmlQUW1jY0IrdGtwWXNwVnRO?=
 =?utf-8?B?SmRWaVNWZkttUHVEb1FpS21CeVI1elgzVDlmZ0llNHZPbTlENmtwcDNubWV1?=
 =?utf-8?B?VG16c3BxYk5XeGd2VXdPb1ROd1BQcWlmaFhraGw2TDFPWFg1Ym9IRmFIeWlU?=
 =?utf-8?B?WTJkWUJQdUVFcXU3YmQ5NThqZkFJclhwNlM2LzhvVkVETzY3cDVlbnZLUnlQ?=
 =?utf-8?B?UDU0bjhwZWtEaE82RXNmV1IrQ2FBMmZnNTY0RTVpZFlYSk5DYW95NFBJdEtY?=
 =?utf-8?B?RENvWERsR2xPd1FsMFVNQTVkUzVQZkQwU1JUcnp2YVlOK2NYNEw0dUZCelhr?=
 =?utf-8?B?VkFZbG9PTUllQnAyVjVnRlRjc3NPTEJSb3BMU2dyR3l3NVZhZlRXeVdEcFF6?=
 =?utf-8?B?Q28zRnVkbHBMK1BzVmkvbFU3Z1pESVVaQkQ4LzY5a3ZxaTNaUFA0akN6cU8x?=
 =?utf-8?B?YjRDNzFzQ2NNODZRR1Q1VUdEYys3TXBHOEVYSnp5bHlmVmlUQ2dxSVBOZTFj?=
 =?utf-8?B?MWRFVkxielpNYkRvRmdRYzBsbDdhTHJkRXVZZ1N3ZWxTY0ZkL2czTFJQSkNW?=
 =?utf-8?B?QUZZckN1VDRiYzREelZFcWJFUWwzalBMUXF4V3NqT3ZPbU9NZlVDamVOczZr?=
 =?utf-8?Q?V32P8Fw0RybSv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0Z0c3RzRDlCTHRPcjdrOWttSmlLM05laXdCeU9CdWRaNHRlWjROM09jaTB5?=
 =?utf-8?B?ZHhBN3d3Q29SbUs1WXdQcWs1VDJpalBHREFFWlFwVnFHcnQ2WjZqd281bmUy?=
 =?utf-8?B?c2xjd1Rncm54Y0NwdVluaEMrMUFBajZ6b2xHbSsvdzR0b2FmMHhFQ2hHdkw2?=
 =?utf-8?B?MUE4S0VEQU1sVktCQWYzOWxOUk1JMTgrNUpEYjVveXAyT0tLOEJiNTl2TDZB?=
 =?utf-8?B?WkozZ3ZPcVNIdXBTM284NzVyOUtJYmNEbVJ0dElpYk8zcy92bjdFVjBpSmlt?=
 =?utf-8?B?WTMrWGxUTnk5L3k2UGpJU3JsZmZpMjFEeW9ySUlIdi96Q3ozaHJ2NEdZMEcy?=
 =?utf-8?B?ZHpKQkRHMzMvVmdSRUk2VXhkQ0IxZEI3NEFzN1JDdzZ0bVZsaVJhaEpDVVBj?=
 =?utf-8?B?R2dxdVBwRC9KSnlMRWxWWk5HQ05PRy9Dc2tTUG85L2k1Z3FBUnUxc2pZakZr?=
 =?utf-8?B?emxGOXZmK1l5RlRITzhaQkNISVdBMFhmQlZ4ZVFuUkRwNUdGYTFyZGRwY3Vv?=
 =?utf-8?B?a2pVMHFPbEdPTHY5bHBlSldQcDNjcG1qcFRyMU41WXdGV2U0MDN3a3pxUmJp?=
 =?utf-8?B?V3h5eE9GcDdmV3V4a2UyM2RKajdRSkl0TVdNOEFvOXFuekhIcU9nbXNtR0Mx?=
 =?utf-8?B?Mm1idkxWZFNmWmRXamo1LzdHZ3ljSzh3UnRmMENNaGV1WnVycGRpU28rYi9I?=
 =?utf-8?B?NDRidkJ0cUU5THBuajE5ZHh2YUxRQ0JRak9UWmRveDU4ZmdTaHpPazZtYzZl?=
 =?utf-8?B?aXlHRU53WHRBQUV2Sm9jeTE5d1BnVWRTNXNhTVQ5UlNZbkRPRHdSRkRGSno3?=
 =?utf-8?B?RWRHbnVqdVJnK21Ob3hlMmZ3SHFpT1p2RjJWOVFUcXc0a3hDOHdIWjE0UEMw?=
 =?utf-8?B?Wno5QlREZmNKK0ZId25uZTRWUHJOdDNwakpONExLUzZtZWtNdkRodkxJQ21L?=
 =?utf-8?B?dFBuaXpyWVNLSlY1KzBjUWlaY0NxRFZjOWJZVEN5SEdsSDVJV0VEQjV0SmRC?=
 =?utf-8?B?VUlBTXNZb2VoVDlsL3VCYXdMaFA2dU03a0Y3RjZUcTNZcTg1VXBKS1IyZTFB?=
 =?utf-8?B?ZWJKcmVOK3dtL1FWbEo3Y0tQMkFPeklKVWZzbnJscDE4K1diRXlvcENhaDFj?=
 =?utf-8?B?ZHNWWTFPK1NuemJaM3lndHI3THluTU1nU3Z4eGY3UkFqZDAwdHFqTEhwSExr?=
 =?utf-8?B?Mm85YUNGZXIvV1NZUEs0T2UxVzVJVkErZjlTd0RMbG1oQjFOUW5qTXEySkVW?=
 =?utf-8?B?c1RWelVPNnFPbWdmUlNMdTNNVFJ6TEJUZTdiSThLN3JBYjZQOUNYbDRIUm0v?=
 =?utf-8?B?QTNtWjJxajVZbSttQkRuT25PLytiMmdoSDU2VXQ4aTE0MHVhKy9DT3ZLMDFp?=
 =?utf-8?B?ZnJaWXl5ZHE2L0pDUlBRckZTSnV0eXVnOVRwTWd2MkVZbTdaczJvNHpabWFw?=
 =?utf-8?B?T0xldmRIQU1uYTZjUzFDTVVlaFhCT0ptSHREcjdlcndNQ0hzUGV2b1hmUTE1?=
 =?utf-8?B?enVLUUNOTWJaUTdJZnRSZExoVkxFMFVqZmZPdDUwRkFlaEk4R0h2Z1VUL1ZF?=
 =?utf-8?B?cExVRm90L21ERHFaWk52NmliQU8xem90UXpNL1YybHhkNUphRnBoeHRYQWRO?=
 =?utf-8?B?VDlQVjF6VFdGV1c0TU9tdDRncGtVTmN4RFVQamFaOFFSdisra3Z4Uy9GRnRn?=
 =?utf-8?B?K21iUGxWM24rMnJmQWtiMzZwamlLY1VnTnAxcENsNW55Z20vMGJxZ0RINndn?=
 =?utf-8?B?OGRtRVNvMWNpRWhrbnlBditWd3ZvSU12YzhrbnRNQkVCZEcrdFpNbmRNRDQ3?=
 =?utf-8?B?T2FmZlJlaU0wSEU0eWMvb29KNjVGSGFrV3JnT3Z2UXFRZTZDaGFENVFYUVhq?=
 =?utf-8?B?SkJrUTZiNlBHdUJTdmZWUUhGNmtoY1hUdlBFREoxMmlLU3JTZkYyOUFDSHpv?=
 =?utf-8?B?VHA1TSt5Q0Z1SmxNVXdoVWdxbGN3L2VDZXNrcHBJdlc2RVNFaFBRcTFHQUx6?=
 =?utf-8?B?VjIzK0pla0Q2OUQ2Y2VuTzJUcDZSb2Q2ajJnRWhpSVJ3NmxtTGc1bXNib1hl?=
 =?utf-8?B?RnEyYXJMNWp3THY3UWpzci9IYld6RUlISEVBdSt1RG03UEVnYUdJMHZyWWxZ?=
 =?utf-8?B?cFhudWp0SnQrTUJ6eUY4ZmNaZGRkbzk1K1U1eFFrUmJvVGEybTZVdWtRNDZY?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zo30bLxLl8L1GwodCLWvg1zFnl926DVhCt8tmmQwKUDaXhjiFYYLuBw4a1KGbKY3qc0BKEHnHJOSdKC0Etp3X17b3lcQDneE4nybO7bOTwvRonmoG8ocyhAbWisMcgnFBV3ZX0NwPgVcw7an3Uhc7lU4O3lmiTIf5UyaomKPoWMrMmwP9uFHzDTpJc8x0hSKwqpCw1b4pKmQMCyZEhQ2eprcAa4AiXQjpKhzstjKFNK5vuV3T08IYJITZYEyqno7J51dGml6p7JF3p+tW9SPc5O7F5w2QQnJOz5rCI+QJ0gHCE4ivUc6SdNPMRcEURJh64nkf5HziZH8V7ke7Q6tWxs7vWCOx5aqSIeWn/clnrB13yF39CYmeD1ccG8h6sJuvPeHPQNFV9j2NXmgQ+7eCLZQJ7Zi2Nw8cE/EJzUHqBzYTcyx0OePCLiNDDT4vsiFDpfb6H1EXgmNwR+pQiCRnWC4Why8hVH2G2BL85JZz2F2XTtmY2cXNQ/1NPwnoQveGo1YIF13d5HK7gWpSJNhNzzkn0S1OevjHl0uCf/4qOnPHqQNM45Kq7ttm3Sconmjpcs9GFqqB2EJb1tCGKA3N5jvKNgmglUgNA2hjKu2wHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54200a13-3c52-4469-7278-08dd5a2ddab3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 08:31:54.8971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOIwzD+6OTJW6SR4w2CpKXBFazSH0vtavFOiUucSEcidM/sKNPgnJS9MdlV41P/J9Pv7y7tgpMdxazhrr2xpW6k8HlqWPGOX93cJEek7E6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030064
X-Proofpoint-GUID: ErhH6o1LNcxLHgdvDd4-IhmxvaB9FrFf
X-Proofpoint-ORIG-GUID: ErhH6o1LNcxLHgdvDd4-IhmxvaB9FrFf

On 28/02/2025 23:28, Jon Pan-Doh wrote:
> On Tue, Feb 25, 2025 at 5:56 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>> On 14/02/2025 03:35, Jon Pan-Doh wrote:
>>
>> Also, what value do we have to write to turn off ratelimiting
>> completely? Can we handle that as a special case?
> 
> Not something I originally planned, but can add it in v3.

Right, I think that some users would be interested in seeing all 
uncorrectable errors and we should give them an option to turn off 
ratelimiting completely.

> Given the permanence of sysfs entries, would we want one toggle
> for all ratelimiting (logs and potentially IRQs) or separate ones?

In my opinion, we want them to be separate. We may want to see no logs 
of errors but still have them recorded in rasdaemon, for example.

All the best,
Karolina

> 
> Thanks,
> Jon


