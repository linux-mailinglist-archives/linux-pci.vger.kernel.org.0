Return-Path: <linux-pci+bounces-8140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C3D8D6B4F
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 23:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696BD2815D3
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C285420DD2;
	Fri, 31 May 2024 21:12:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E75200B7
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189931; cv=fail; b=QWgdZe0eGmJL4pofAyYL5MUTsPzvQ+b4X72+AfutgMEtrYZi+RBHGzfXHnOEZOMmWZjOVmP5plXJvskb6z/TtIvvC20r0K9Z/kDRCwSKRi7jO7rLzzE8fh5ObHxp6Dq8NZjQLmXjFh+lGhGNkBes/NCBrSdyQbAMtyTabOj91Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189931; c=relaxed/simple;
	bh=tCSLjrN7vjOY0osbpy17+KZk39v8pyFwbSpwIOWPtFg=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=WugrNT1nmgqq1MtnHJ9A3S4zlPvPgvmFB4+jRHnygc/Rh7GAoYY2Exn/evTDf1zCZm4DDPf9iPFd0KkWBDxdJaDdrZaSxs/sr3yzGlW1NRyquJyYtPsg7Bge6Bq6s+TIx733rL12i5w7z5d60OnPkJF25LDBTrRb1Fs3bcs7uYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44VHscID020114;
	Fri, 31 May 2024 21:12:08 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3DXA7BKkb1Q?=
 =?UTF-8?Q?AigA6V74I5bdz6iU5GkNkxZ5IQAznSv5kY=3D;_b=3Db0GpUNqQ9Phvtp4MN/y9?=
 =?UTF-8?Q?9YFY5s0TlQYu3hgC/zDaCJLw+VA8hPgQviBINK/gBvRO/VzG_sYxdOknY+Hss0I?=
 =?UTF-8?Q?YicgSsZD9LCA0fTSNUAuIeYNsZOxR+nUmazXNXS55JucOksQ96EyuD_SC/S2xM6?=
 =?UTF-8?Q?f0o5r+wLFz3j27JVHbAWzc0vnxnM2VXliXedSzq0EmU8ihJljJdVnLrlYk67_xR?=
 =?UTF-8?Q?UMQpGgemtYPBhw7pa6v/oMozBY0YUX9T3fW27/7E01FMpRFJsJiJ2jSeUxDHKtl?=
 =?UTF-8?Q?CG7_ZjHjx8/6cDacGURaj8CrrYQIFInqqlzdbDO7S1ZNb0t6VoWtQsRibt9HRtE?=
 =?UTF-8?Q?m5UG4yj5q_pQ=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kbc2ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 21:12:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VKP7ZZ024126;
	Fri, 31 May 2024 21:12:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52fpxcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 21:12:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=by0K9sXMTL7QLtLwMBPT3yLbs5bvaF7s1ReEQ+RquAx9A7CRwPokzP4ogHUS3MzWoUb93tNXAa5RrGnulHmNi+OmGzO0UqF+9rts95XKta1WYTiNjuVyMJ+cqtqtB22aUgZJnGGuJMIPJT1TAQiFoqFZ6I4VDBry5IhSvurWSYcjBceZPDDcbYtTr/x20/6GMue1kvAbE3gMkeAlyNAJj7cK1sEmznxeNrZitLNMirerrZBmW+iZaj25F+n7jDEeuA8Ox5oyNHcwHnTImj0KmE97yxe4ZxjhMKf+qAw0j+s8Ey5my01mrzJMdZTIuFvGjV1bU8QmIr3Ct+HE2csK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA7BKkb1QAigA6V74I5bdz6iU5GkNkxZ5IQAznSv5kY=;
 b=h18mT5xtRkFOBQG4MEQ8rNyvR5U2cdFzxO4S/bQjjPbFSi4Xom42O8CX2mNwCaEb59H/Y/dQAz6W7+P4arnXZlvo7YD7iE9X6+YxmFIyAfue5HZpsqU1Q4l9ecLI9hAN+QBh+aCU3j0f5wrcccydgjfaoGSk5Gq6ATZbeWVG35KWOdmOEJugKn+DYZB6E8p/TjTEgCECPwvpmeA5nRIx4IJlq7Ks+7Spesbrew8hK3DKZy1ANcFVYab7ikcTWQNtNLZ4FEHhw8c1j6I5/qNDZYLSi2J/nhyaeSKezkCFygn/JPEcctOk+NvXGTzyKwtJdJCn74cXvLYgcu+zKwVG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA7BKkb1QAigA6V74I5bdz6iU5GkNkxZ5IQAznSv5kY=;
 b=UnL1kP0D0aQt7gBtXYDgZeyiDdVdz01RXZ0nz0oBmbYNcmtlqixkWgB59NAHoE+4X49+a9XziqzGvPh1Cp6WfGaCI7RLgbfSJGXBubpUXdk8Ze84OOcB/46b94duwzETvosWx+fQrwmp/DDbmWBKO87Lo3IsHCS2zTOlC3rGqM4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 21:11:59 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%3]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 21:11:59 +0000
Message-ID: <c14b0b67-e766-4464-9acb-dc4f6dea0b7e@oracle.com>
Date: Fri, 31 May 2024 14:11:56 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-pci@vger.kernel.org
Cc: jonathan.derrick@linux.dev, ",lukas"@wunner.de
From: alan.adamson@oracle.com
Subject: Spurious DLLSC on a x4x4 NVMe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:208:fc::40) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DM6PR10MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 878277c3-eac4-43f8-2c35-08dc81b64f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RVRkMGRXcWhlaUdneEswcHhHUHhDUVpmbk9CcDNOeWxCV1NpMDQ5YUVpNzZp?=
 =?utf-8?B?U0hUSGhGMmxQZUErZG9OSG5sV0J2QVNUNU5SK3h6ZUV4akZUeGViNzAzNnFw?=
 =?utf-8?B?bEVIZmVxczRXamJreW0rSEhFU0ZvMlJlV3BrUS9xRUx5Zm9ncXlqVU9XbnFP?=
 =?utf-8?B?VEpzTXg1cUNzM1pEdmNzZHdCT3ZoOGRQMEk4QzZnQVM1WEtzcTFFUjJOSWhK?=
 =?utf-8?B?dTFFQWZsa2JUTnlVMWVZOVBlWm1HdTRQWjlhV0lXenBTdUMvd2o4RlF3Rkx3?=
 =?utf-8?B?ZVJBZHQvTU5wR094VDhYTytIOSt4U0hhQ3BKVmdqUE5ENWIrWmRWR0s2VkxF?=
 =?utf-8?B?MHFzYVBtSG8rL1o4RlUvUkxxeHl6MGUyNWFmc0pzc0JzdzBGS1p2OUg3Q0V3?=
 =?utf-8?B?TGJua0ozMjdGN2U0TUJ0R3pJRDc3S3ljQ2hpU2crN1k0TEpSWWxWUFVYUVk4?=
 =?utf-8?B?dmlObkVwSHI0T2pCTUdwVFRHZkVXcG5ERlFUdDdTQS93SEFSNHgvOTU1aTV4?=
 =?utf-8?B?SmZNc05vWWxsZmk5ODRXcllQMnRHYWg4ZklwK3ovMWRkR1NKa29rbzdGcHdk?=
 =?utf-8?B?Rm9PZ1lMOVpITlM5Zkp5VzZGZjhHY0kzc0h5SXhGVW52Y0t6VWltRzhZTUgz?=
 =?utf-8?B?TlgrZkpUMjBkMXJsY3RkMVlJNW9Ddm9GenQwbVdWb05uVXFGUnRkR0JvZThQ?=
 =?utf-8?B?OVR6K2ZMcmcvVU1pZzdLV0N1Mm5WZDJTNCtKdEt2OTQ2RlhLTTNtWFhLN3p1?=
 =?utf-8?B?ZStyM01rUDRkcVp4ZXhCUUtHVGlDTlRISW91L2c4OWh4Y0syRzM5dTY1SFZZ?=
 =?utf-8?B?MWRkT0xQUWJDZWdCbWtVNFdLRzRRdUoxZkJIR0tlSEt3OTV4Z3c1azlNQ0ZV?=
 =?utf-8?B?Q3FqR0ZJd3VXSDB5WnYzWXE3cWZVMjVJUnhYcXk3UFF6OVhJNjJsUmlITTNV?=
 =?utf-8?B?TUVvQ0hsc0JMVjJhd0RKTFE5YjN2YjdzczlrNzRjM1lONVB2K1VTYnZVU1Jj?=
 =?utf-8?B?akNqRTMyaVp4N1JGZ1l3eUt6NnBXVkRJUE5LWEpnaGZpWCtzSzBjM0ZrbDhw?=
 =?utf-8?B?Zm9uV1QvSDV3QzVLa2h3bE5XVzg4Ri9xeENud0tSYjI1MkxKV2tqV2JJdXFw?=
 =?utf-8?B?OGRYd1B2emRHMzhQVmpLK2JoSG5WWm9JOEtxb25Hbktsd09VTW5xZmdzMExr?=
 =?utf-8?B?Rm8rZ1NxaFZTMXpUTjJ1dDFCdEo0ZUpJYUVGbEY3NnJTY2FueDlTZnZvY205?=
 =?utf-8?B?K1VUYlBHZi9wczVXZWRsakZkbVRiVUhJL01ONElNbEk3QTZBeUlTcjNsOEVt?=
 =?utf-8?B?K0JWWjdxVDl3ZGgzQ0RHb1ArM2c2M2xuVDN1T2FVS1pMOW9OVnkxeWpBL3Nk?=
 =?utf-8?B?UElLRzFBbVFFRkIwQTZTdEFUUmhUTThCVUNFWDJ5cit1OE83dDgwTm9XZVlC?=
 =?utf-8?B?MHJ6dzZrV0dtYzh6YThLZGswdHQxQ1kyS2MzS1BRdTY5cXJyM3lTRXpNVDNL?=
 =?utf-8?B?SlhIMUtUTjVMNDJyRFdhaVcrTFZML1JKZis3TG4rbXdEdDM2VmdUWlM1OGp4?=
 =?utf-8?B?R2RlUWpZamF6UnJhdVZ5anBLR0dTek1hMVFDVjVaQXZmckZMY1ZUTjJFdkxt?=
 =?utf-8?B?bU1zYW5Cdk91OGNUUG9DR2ZZKzYvTlE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TldCVnBoUUpjUU5oUDAzMm5hNmZRaGlpZDhjT2V1SGE0ZDkwbW5VTUZnTHhG?=
 =?utf-8?B?VnQyQkw2WjYzdTdLZ1Z4TE9VWTVXM1JMcEtQQWozUHNVdjlJTkVCc1Fldzds?=
 =?utf-8?B?ZUF4U1VMdWQ2TUd5RXZnS1owY3N4WnJ1eWdYVnQ2M2lqa3BCVUw0RlRPYjYw?=
 =?utf-8?B?QXVwN0doQmg4cW4vVDNSM0xuOCs4U1g1T2FQRWVzU3lKS0kyTlZHaW1YaWVy?=
 =?utf-8?B?cHVHL1N5WUZEYmpQYlROTytBOWoyMFhWV09IVDNoTTRCWlhua3dhL0NoVGMx?=
 =?utf-8?B?c0VSeHNwQ0Rkdm9wNkl5RW9vaURQMUxvNmlJaW5ObFJLOGhoSnBEd1ljSkg4?=
 =?utf-8?B?Y0l6MmFNeGZ3N2RpSUVTbUN5Tkl0ODNUZElyUWtDRkpucGVFYWNHOXJYWmgr?=
 =?utf-8?B?dTVwekIzYk4zNWtOWU1JSmNLY2RmRGJoODJlTjJDZFBvY1o3Mk5DWkZFbjBv?=
 =?utf-8?B?YzFXb0pma0pHMVFwd20vejZsVzZUZ0hkVGtJT2thdUxsUmhJb1FaUWY0Y01V?=
 =?utf-8?B?NklTK1FlNmpYcWFCRkVOckxYanZjUVVMbjE3USs5NHFxRE9vZWU1OFl0bkdx?=
 =?utf-8?B?M2l0UVBicFZGclpQQ1VxcWhzZDFyMXRaMUxjRGgzQWR2cExYMS9MRlFpV3d3?=
 =?utf-8?B?RkNoa21SQnZhaExneDFmYW8xeVJvVVNmWEZsYnUya2ZabG1LeHAreWFNcXpQ?=
 =?utf-8?B?UDNQVWYwZzZNUFQrSlk5M2VvTlFEcHFZelNhdkROQUdRZURjdnNvdmF3eW00?=
 =?utf-8?B?M09YemJrTDBpdFN3bzJlMm1EVUM1dDh4eEFzZCsvMDg2QzA3ZjA3NkhyZGxG?=
 =?utf-8?B?Ync1bDFoNnowMFB1eDEvZkIzZWpJdlQ4T3E1S1l2Y05BWlc0bWs5ZnJ4S0xP?=
 =?utf-8?B?d1dRYktocVE2SVNycWEyUkQ4dGQzcHdkM095QmZPZjBkbldQV3ZNelk5MjNI?=
 =?utf-8?B?RGplbHdTYlh2UkVDOVJkNVFPa3Y1ZkRScC9XOElEUW9FOVBLcEdtOGtHazVy?=
 =?utf-8?B?K2N3ZzJhdnNpRHJhWjFkMGNLbklRTnJva0tSVFF4OHNiQUZ6N21YdVlURTZP?=
 =?utf-8?B?VGxhbjNONVVVZ2pTL2R2eGp4NHRnRnMvSXJLa3BKQmZGSGhXendacHVLWnho?=
 =?utf-8?B?WXhHL2NGa2JiNUx1L2RlazZ3U0Njd3VrUDNQdGtXcnlKNmdQRUNqQVFXdmx1?=
 =?utf-8?B?Rk9SWmpNLzNQbTBxVElCb1B0Z3dBNDJrbjVRYXJoZDdyTitBSmpuQjI3NkIw?=
 =?utf-8?B?UzNmN1RSMGFLajdrcGorZTB5MVVZRFpva2VkRzdndVlIcEovbnViMUNKUDJ5?=
 =?utf-8?B?akh3ZDI2SHZSRjhQVnJhelBWWmszK0VKcUNQZ2xsaTBERUpKV0NTOElxak85?=
 =?utf-8?B?ZEk0QSsxK3BPSDNMd0hKZXRxdVp4NWlCT0hITmFUcm5RQkdEb0dYcmZBczVJ?=
 =?utf-8?B?SkVrYks4czVlaUdGanc2RTlLN05ZUDVJYWJmaXROVERwQm8rS1VYQlg5LzhT?=
 =?utf-8?B?cXQ5VlArU0JDSnFOY0ZpaWNlQS9mRUZzY3RqLzdpakxsQkZ1ZkRwVzBSUGpW?=
 =?utf-8?B?Nk9XaFlxZ2VYdk8ra3FMTEsxVjNLSzVwTHhqZ1F5S09nK3R4a2U1dW1TWEp2?=
 =?utf-8?B?ekQyN296aEREZWZFaGhBK212R0p4SUE5cEpJUFpQTElvanRnVXFpb2pYMWc5?=
 =?utf-8?B?YlIyVytndExrV25wb1JxNUNvUTRSdytIVEpZMWh2TkJaZmZuaTUzQU9Mc01z?=
 =?utf-8?B?Q3pOcFJsYWF4VTRCOTZrUVR1ZDlLMm1QMlJ4NjZaRG1INDhMMnVlQjlQakVT?=
 =?utf-8?B?bTJOUWdUV0NGQzFHNTk3MExrMzI3TytLWXlVUEpmaUJYMUtkNFVQbEd5TVVk?=
 =?utf-8?B?RG1MWTZ2QVpaR1dxQnNoTmM3dVBlVEtzWDFYRE9RZVF5bzJkVVFjREdPSURt?=
 =?utf-8?B?TGlYVW1NQWF6VVVuNHYzZWZyQ3h0Q1pmWng5V0ROWHEvak00UWtzelI0N0tY?=
 =?utf-8?B?VVRlMWo5STJheUY0Uk10NGVFWEN5VWsxUnp4SFZJcTZUVC92alhzTDFNMmFG?=
 =?utf-8?B?TGZoMWdxMnBrQkZ5NTNIT1BYc0tUNXloL2hXS0F1WU5jWVBRRVVwSXUzK3RK?=
 =?utf-8?Q?7I7tMdJXEUxzooahjJiGj6dy/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kLJM6B45Edvqf1KR/HI9/g9im68Uq6kZZBqtG4CwwplWUd6tNrokWAmPQbRo/vwzbVHtjrPT+mVTK8N3fNm0/TCSvOCl9d6gdMtj3UWFnWdBGFOrzfri1S6KJnz9xDdPvRYuXILOsmfpb75e514tsxOMfKPjRUxYkjuCvBNwk5CTnoS6UZHeSbFW4yRzAgJ5sTzKFjrIW5cQVeh7v1oaE1PbHKPY2Iod8vTeKaJHIIy3VO36JGYhyIsX2roF/2MEjnkP19Q+gBhOAxyHMhqQUsNQa0uaU9THeeDBf84T8xn97wN73TtyjR9MepRP+2Y1zfXGYx5Tifx/35/D4sYHGVcLDgZ4Qp9SvkYWQU3SmJiB19yp8DXyv70cDQaAEES8RqRn+RGZzn4Diw+NbmAzSqRcvUChm9Uys2t7N0If/mjM8bx3IaxJGZpq3FbFBilJpMfHh7qklHWO+2wdjwYDrMDCsQnlFV+F1/OhcdDh76g1rSYesyxn7qndFO+L/47BJNXuxReIVOIG8qemx2wsDpLm3+zGOL1p+SJPIrrYPhcMbfDy0Jj1/1K8gtLysCRUAHITRj53cr+jUzirqKE0ehVstxOr+5xI9aLIMXUPXW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878277c3-eac4-43f8-2c35-08dc81b64f61
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 21:11:59.7912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IOKlLr4bW9irw6sD/WczxhBUQNcVMZfL0T1VsvNd6lgLOIjqq/RXnrZg60qJzfQS6DAI0lIyJac0f/iq/EhRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=678 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310162
X-Proofpoint-GUID: xqINZTiFacz7XVZDlOkCbAnXjOPXYbIp
X-Proofpoint-ORIG-GUID: xqINZTiFacz7XVZDlOkCbAnXjOPXYbIp

Back in 2021/2022 there where discussions about issues when hot removing 
a bifurcated x4x4 device from a x8 slot. I could not find any resolution 
or applied fix for this.

https://patchwork.kernel.org/project/linux-pci/patch/20210830155628.130054-1-jonathan.derrick@linux.dev/

Was there ever a resolution?


Alan Adamson



