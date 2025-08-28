Return-Path: <linux-pci+bounces-34990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A4CB39B58
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1EB1BA27A1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D30279798;
	Thu, 28 Aug 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+GhH8w4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QPmPKQ7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9602D738E;
	Thu, 28 Aug 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379993; cv=fail; b=FpR9+hJhcqsNvZ69FV62Gr9aKxCIJeShb4BCrCi1J/anT0pYP0Ciwps3L8V63HZt1bMCml8ibMekqFWiGdSbncx1P3QJo9lGoYt0E4kZAmy4IJFDEvwo97c8uvtym5spFfgK4uyKGxuW+m5bBBJDSX3kT0W0Hc2xYmGJxzEU4+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379993; c=relaxed/simple;
	bh=QpM2oUO4oOo/ZAcPnSVHUNP+v9Ib+vKwXeJD8fuZ+3A=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NY9EIXgn5sco5eeu9lapZCP20zUgIDWyNTgs8venk/mZhATyE7pV3BWaVGSgr7T8EN4f8YslGxsHWv8AzESckF+q0aYarc1x33qkXY1mw8QFhD6s/KLKPr95Q98/E048USJciiEe55mb812CDBT5YE5YjL+sGPIq9LtN7zYtuJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K+GhH8w4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QPmPKQ7f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8twQT015593;
	Thu, 28 Aug 2025 11:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uwIspqlgPzf8QHW5hoqiLAH9VKOYMO4y0o6MGqPrRUk=; b=
	K+GhH8w4Uy555FP7ki08O7hvEs5XilmEPWQHMr/MWhUENZ9fY3+JBWq/EhcNki0e
	tfvFLKTMdSa41JKTSDVBSMttdshZQdnnP6Q3JQbWADAVqWSFQ3/Jk4kvO2wxRB3F
	XoavPQKB7iTjSqDu1g2jOPsYxwUpCABuDLbJ77flkNuVu81W2E0B7ySYNAROMAY5
	dbD1zhQrGXFcTtzZsjpvuA7fWm2WvGZSOjAPo9sqs6Sk7oHv2YddU3JCOY1laMw4
	mhc9y4e9Fji3Xze4EZLOxWBs2EC8amF1wdFUrORDGTxqSUjJ6kgWT2LD95e6Wl+m
	oMeyfG0T1SCNE11VtJsGgg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt8e2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:19:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S9L8jX012233;
	Thu, 28 Aug 2025 11:19:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bqx5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:19:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSBDJ1AybhGvm3J+18xPnW49dpsYl3vW6/ZDhPXkiZ0vo8PICi/m5xiXal+fZ9AwnoCBb3eFpUjCLYXEDK6AQ1efhFPyzJUqy1Ybva+m4KaAwFq7+0BMMoaHa316W4utUWjLiTnaj8IyQx73+5s7W+GMliJCxeggaIRsLOfeo0+Oghz1VHczaDvPf2ze+ywPd7FdlV4Lx6ywtjkA5yEQLyNvGJ3aUoA5SI4WzCfR+nDzgZ7ge09O7m4S4H7LH8lQdDejmUvL2p/7GxgWQQwF247cOcWHRbWwSTrgLL2NR3rGNodRtBjaJXiDIQxI+lTYNb7UwoIWKX6KKC9FL+tMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwIspqlgPzf8QHW5hoqiLAH9VKOYMO4y0o6MGqPrRUk=;
 b=NKM7bSx4K6/aoH0AsfokAjrdeiBjQJeyuPO7EL+le2XARznyL0bUpRARN3Iv5k9qHoYkKsUkZeZKt4XhaIu6hbrOqM8lhkf56ktHzI3/f2Wkak5on9Kq6GdR3SDA87yXqTZqXcziHOeJqG0vZjrNIRsvFwkr5aeMNU68+nAamtxOcPWEMVgNQn4bvmIZBzc4z66SeXYGGqm2oFn7Rn3PUx2MDZDzGastl6Fulib/g+y9ogX7wiClpRUqAvJihSUDSf6J5k/jl3D3Ny3pNcD1LLsQY5SYSP77R1+TiGBUeJ3K0cyp3L4AFjwnHPgqt3tviiHRYBa20l1YOEA14p6EIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwIspqlgPzf8QHW5hoqiLAH9VKOYMO4y0o6MGqPrRUk=;
 b=QPmPKQ7ffNjWL7gI2eQuYkYS/q9kmiy/5wLyEyXOaBfEtUDKg7xlsePEcQ6lvzoX7ClKXyYSgpiz1/Q42CnZJ1t5S3wMGRNw9yapSM05wXmKtdZeJYwvgbU6K5QcPC2kE9KKFEUBws9Gedect7dqYDLMHOr8CmXFdAIJTiqIy6Q=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by LV3PR10MB7961.namprd10.prod.outlook.com (2603:10b6:408:21d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Thu, 28 Aug
 2025 11:19:02 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.017; Thu, 28 Aug 2025
 11:19:02 +0000
Message-ID: <08d79767-4b9b-41c3-8d51-5ff879eacb31@oracle.com>
Date: Thu, 28 Aug 2025 16:48:48 +0530
User-Agent: Mozilla Thunderbird
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH 3/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Chen Wang <unicornxw@gmail.com>, kwilczynski@kernel.org,
        u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        arnd@arndb.de, bwawrzyn@cisco.com, bhelgaas@google.com,
        unicorn_wang@outlook.com, conor+dt@kernel.org, 18255117159@163.com,
        inochiama@gmail.com, kishon@kernel.org, krzk+dt@kernel.org,
        lpieralisi@kernel.org, mani@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh@kernel.org, s-vadapalli@ti.com,
        tglx@linutronix.de, thomas.richard@bootlin.com,
        sycamoremoon376@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
        rabenda.cn@gmail.com, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com,
        fengchun.li@sophgo.com
References: <cover.1756344464.git.unicorn_wang@outlook.com>
 <1df25b33f0ea90a81c34c18cadedd38526a30f01.1756344464.git.unicorn_wang@outlook.com>
Content-Language: en-US
In-Reply-To: <1df25b33f0ea90a81c34c18cadedd38526a30f01.1756344464.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|LV3PR10MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: c620b571-1058-487a-8601-08dde624b129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFpaWnJmdW1rOHhCWHV4OTRXT1ZpVjlJV0JteXRSN2M1Z21RSHlhZEpMcmVO?=
 =?utf-8?B?SEp4WHN2cjN2czN4bnJTZWtES2Z0bXpYcFNFZUt2L2F3MzE5ZVBsUXNTQThX?=
 =?utf-8?B?YzB3ZVBxdzdxSC9oRUZaWlhZdXk0UUd6cjRrcmJlQTZ4N2xkV3ZDYVIzWGp2?=
 =?utf-8?B?Y2xpb2JvdXpmRThMdTArS01rTEVXbm9xaG9hNy9IdVlaR05JalNVbE1XVEkz?=
 =?utf-8?B?NDJYdHd3S1JXL3V4enFzQlcxYVJjRU1oZi96aUdRTmR4aWwyYzdabGpma255?=
 =?utf-8?B?MFp5MTI3amVZcEI1SDJZMnV0WExpZFFmdG9lNEppNG0vY2pFNkgzdnJTcnpW?=
 =?utf-8?B?NnVyd2xjRFNPQ0MrN0prRzFiRXRLYzY0R29VZ0dkallGRlBodVJPb2grem5V?=
 =?utf-8?B?cDlVUndwZkZQMVlvWFQ0d2hsc3pXVzhVaE9NMjdkc1puWDU1YzMxT1pQMUZw?=
 =?utf-8?B?SXhxLzd5SDJoUkMvdERpbWFHM21RRnRGaStUSXZzN0ZycDlpMjB0UUlWZmJm?=
 =?utf-8?B?SnFJbENIVlF5R2I4dUxhS0xacG5JdFhzYnRIN3pmUDNhM1RsRFVsTzNndlJU?=
 =?utf-8?B?L0ZIS1YzZUlsVC9FOHh6WjhVRHZZMmQwYkNCelFhdEtGYXg3d3JQT2dSRDFI?=
 =?utf-8?B?SHFlblJ1eXUzczhGamxGbThaMTM5YnV6ZnJQa05TekJzU2ZzSDRXYVpyYmdZ?=
 =?utf-8?B?Q1dTMldFOEV5QUpqbUFYUnV2TmdnUkEyOG0vSGIrVHZ6QWViMmcvTmMyUVM3?=
 =?utf-8?B?WVNRZGFER1p6M3JQSVZQWVFGNGdTODk2bm1OM2pyY0pXcXhZYUZpdFpGQm9I?=
 =?utf-8?B?VlcxdzhlVFRHbmZBSTlKTXVxRER1Ri9vNkxJUktJY3FGVzU3UzFPdDkzU2k2?=
 =?utf-8?B?UjZVV1V6RHZ5aW9aZGVBdXkvekdpNXJKekRrVHV3ZU1HeXRzSFFWNmJCNW9k?=
 =?utf-8?B?RXQ1UndyOStPY1lXRmFYNW5NZ1h1aUkwUTRldElydHRiVTlHbkE5RmIweDlu?=
 =?utf-8?B?ZWNxb2hYdHNoUElMMHdFMWZFa0V6d2I5TmsxL1lxLzMrdGNxM1JiSFNxRHFX?=
 =?utf-8?B?VlJTUytDaCtmbUhsWmxpU2ZweXZEMVRYazVnbVlueEl3eUs4cEE3ZURXVzEy?=
 =?utf-8?B?RmhsTXZaY2FTVElMSDFXR0ZUTzdaYmlGZ3lGMVZLcnJoYmx3RmNDUEJjbFA1?=
 =?utf-8?B?OFgyWjkvTitvMUMxeFlHVjhTaTBTM1NMVG0wRmQwbGVrNVRCSjkvVzJjSm5Z?=
 =?utf-8?B?TE1XeElJVk5ham5pek5nTW44REF0Q1BOQStMd0FrZmxkWksrbDMyNFhvMXVO?=
 =?utf-8?B?djFhaHkrMU5nU00vWEpKeEVXSmhmVzhaZ2JXeWQvTVBCYmtZb3lqOVJkc3Ft?=
 =?utf-8?B?ZkloWklDRVFiQUpyUzhmK3llRHM4MW9OcFdzbHlZYnN2b3NwajNLYVBHaSsv?=
 =?utf-8?B?Smp3Wnp6Wnl0b25Yb3pZaG1halRHdVhlQjJERmRhTUM4S0c1NVRwQWtLdHRz?=
 =?utf-8?B?eEVjeHlFYVM1VWxZUFNOYjFrRGlpc2t6a0tBd1UrMXNmVXRiakY2clNaZTJ6?=
 =?utf-8?B?a2NGUUR1aFdiVGFnbGFUOGRwS1M4MDVkVU5VdnlzNkxNaWcxK1plRFlmQzNE?=
 =?utf-8?B?N1FuMGdJZUZXTmQ5ZXRNekd2NG1OYjBORXVtbHQ4T3NSV05DZzdOcWd0QmNE?=
 =?utf-8?B?dU9OdWNETStWZTR3TG9nWm4wQW4xdUpvdFJpQWFvVTRIT2M1VUJydElWcFV1?=
 =?utf-8?B?MlpaK1Y3akxPeTVDbkNUeFZkV3NHMHZTNkFaQXFRQlI5RXVEQXZTZ1dHUnJk?=
 =?utf-8?B?VnE2V1cxZ1hIYWgvekcwcXllc1NvYmhvYllWREdHR2F3SE1UaTNEM2FQenor?=
 =?utf-8?B?bzZ0NFQ0YVpNVVdrQURzKyt0b3hFZmdFd0ZXcElvbi9hVzJHbXhYT2dqQ2J0?=
 =?utf-8?B?SHlCR0FLT1hWeVpzeUpCbVpIbFpSMFdpOGFqUUlxTnQxRnJBSENjVThXVVJI?=
 =?utf-8?B?N3I1dVRHR0dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnI0c3ZSejBLL01qN2xwbW5kdHduUzZRMFBxdzJjYTlrTmxwczFSSzdSU3dS?=
 =?utf-8?B?OEhremtTZHdOeVN1ekgrU1JZd2pWdkE3RThBZjJIcWVSMzQ2ZVZGS0xBdXIw?=
 =?utf-8?B?WlNtQS9PRnJlSmo1WnF5SG9VZDZtS2x5MU1oTFpPS3hxc2ZpTVZlT0VnZFV6?=
 =?utf-8?B?VVd6bFVhMGNqcGNLQTBlZm12cmVpVStFMjZiT2xXMElERHlQNHIrMkV4ejdP?=
 =?utf-8?B?bUNDeFZKWWRPNmJoN3hyeUxVMlB5ZC93ckc2VWVIWXRWMVB3aDhodTI2dk9L?=
 =?utf-8?B?Z3dveXUrUkUwQ0FsTzh4S1VPOWVUZU5oWHptSEZQRk5WZDhwNzJReGt0eGlK?=
 =?utf-8?B?cUVyMy9CNTFLT2JQaG9tbGR2MGxvaXo0YzRGRzV5d2RSTmoxcFAxVGF0NEU2?=
 =?utf-8?B?bHNGTnpFR3VPbUhPSFdTRFc0VGozN0hsQnRRTVdJQjlyY0hqNnVzYTBlaWFM?=
 =?utf-8?B?VXlqWFM4OWZ4N3VvT2ZLRmFjbytvU0FrSUZXdzFMdlhFSHVpSHByOUt5V1lv?=
 =?utf-8?B?NFMrWTc1NEJGS3JYQUZoZVgyVVJsKzFkQU9HU1hYZG1ramhjbThUOVBCQkxw?=
 =?utf-8?B?dzVJL0dpTHUwd3FBNjdRbjdJYzZvTGF5MHZxenlZckJud2dWQ01uM1dTQnVY?=
 =?utf-8?B?WTlUSHpGSElpWTV0dFUydU9pR2VaSVU1c0cycDEwaFIyZVhaaWhHai9udTBB?=
 =?utf-8?B?UmhPVDNLY1dMWms2bjRQV1FRWTdiSm1PdWJZcmU1RmpydkVwZWhWZDd3NFdJ?=
 =?utf-8?B?cE53THA1NU1VSWEwZGk4R2ZIcHQrYklVakdqNmoxU1Y3K1F5VWJwOGlxNU9j?=
 =?utf-8?B?NXI0KzdqQkFzbUl5TkxOZk51VjBBNXkyQk5XajV0OTNMSnV0NER2bHBWVk1Y?=
 =?utf-8?B?dlV2cFJpVm53SUdOUGRJSm9LVTZ0R2dPMEtvekFxNUVLczJnU0wxemtLM3NC?=
 =?utf-8?B?Uk0vRTc1QkdISk1OTXVHeGlpUFd2OUZabmdZcnQxV3BBdEN5Z1JSWUJ2UldS?=
 =?utf-8?B?eEVSdDRybnlGbFNHQWVoV0xRMWIwNklENlA0OFBQS053MzZYV1dmcTZ1cFZw?=
 =?utf-8?B?M3NRd24rRkE5ZnR6MjU3YW55TFExdFBYUWpwSFI0NG1waWh4Q215TlhsQ0M2?=
 =?utf-8?B?M3pHK25aTTA1Q3MwVUhNVVFBeHhKc29jQXF2VlFtK1Vpd1lua1hoczFzM2kz?=
 =?utf-8?B?WlUrZGRUTWpGOWFwempQL3RaKzB3Vi9vd1VqK0R6T3prejRtTXdEU3NGanVO?=
 =?utf-8?B?YXZjeDFjdzM4VFlzaWVXQ1FNdlM5dFo4U0FtbFVOOWJ3OUpOTDRRQmIwK1J2?=
 =?utf-8?B?dmQwajJaS3JjaWtlVHFPTDBGKzlkSm80NUVlcXZxWFVNYTlKZjRxb2piWTFO?=
 =?utf-8?B?NGJCZ2N5Uk9INUxBNGEyaHJqUFZIRmprVG5aOXFVZzF2RlB3cHhlalNLN3Mw?=
 =?utf-8?B?RnJnU3RpdjBzTlBXcW1RY1dsQzhodjJ5MEpkQnhoemEreThoOUUyQ1cvMitx?=
 =?utf-8?B?UitzVmFvOTZuOVVwMGhXOWg5V3YyekpiQzNFSGxzWWg1cnMzQTBrRDhwNEFS?=
 =?utf-8?B?N29pckJLaWJSNEZsN0FlVTZwOE9WcmVteWJhV3AxbzJSV2l1V0hLWGtMUVp0?=
 =?utf-8?B?YS9OcHp6QjZET24zem9KS1RrZ3FNeHV1K0xITmwvcDdldng4RkNseThqd2tu?=
 =?utf-8?B?WE1DUGdPTGtPdzBSeXVKanh5c2d6RmEzYlo3aUNxOUczc3I3YWtXUnBTY1hs?=
 =?utf-8?B?MTZNc04xKzNmZWhSS2NkS2t3aGVuaE1oa1lld0dEWVVacEl3RGFvSDdRMUln?=
 =?utf-8?B?Mmc2RW1lZkZmQlVHcHhoZXFObW4zaHBaTjdFUTZpRjFQU1hxZ0pQczB0eHVM?=
 =?utf-8?B?YnBiVDh6SFF0SGU4WFA2bmZyaEpnazdWcVdkYi9ab2tWcTI2ellGSG9mU3ZB?=
 =?utf-8?B?T1hTYUFKd2hMY0ZMRUlLRUFnMldFclNCVXd6aDRSc0ZGMmhEL1dXUmVHcHhI?=
 =?utf-8?B?QWpsdUhHWkdxK1BIK3dtQ0kzR2owTk1LZWxtZEl3MmJzRUJUUkFWWUZqQXpX?=
 =?utf-8?B?Z2JZOEtDbVY5ZXNEbHNnTkFDNGFjbWRTQlErTkxoWWI0Nis4WlZlaS9ZU0t4?=
 =?utf-8?B?dm9ZbDhvMjNaaHU5RjEwb1RwR0o3R0dWdklZWERLS20zTGdOSmRVYjVzLzRj?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23WY8/hgQ2sHsCeHkjMJ8xhEmt1oUXVjzXsB2AVwaDgrdm804muDFtfA+9UG4epahQ5OP2wc4ujiN0AfNQGcZCUcDcd5B9QXuq9P4veFUH3k6RAwV2ZVhtJIkb2d8m43cIVfC2DnAPoiFfFSy7lWvt8RLGvGf6EdhXSg9ZTcVRiIISHWVHAUghPHveY9g5cxesrqw7FuLvAxST88/FrSfjD3a1iQ7R2CsgGnQ/Nmm5O8hg2yGwAh0+OmrDBEHTmkIGPUO1UJ8wd/fa0g9b9p3UiTPrA+7tf6Ns9kYhj67lXRa9oUAxCqeTd3/tkt433pZVmO7wqp2xHA2ip2t7prFMNyvCRAEyODOYcciGivGoytqqki922L51CgwYV1a81a20dPQWWrNPv8b97Rgw5NmUE6g73ymJBOpz3SG5HN7rwa9TAAXKh1XOjsPoJVIEiV225jfcHtdtO9deMS/n8i2829FV/wvh/snwnVfXUiRXnjU/Vxy/bzifN8C6vMaO+EzOHbSWYfBgl+8M5f7nt91MTldcqdxoGliotNJkUEk03whOl9vk1UMYmPdduNRxzKzAfXn26BEh2fcfAp/4zuvSydI5GUTU/fqjbmpNhOsYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c620b571-1058-487a-8601-08dde624b129
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:19:02.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLlzQWocwD58AearpyhMoei50hjgdxgXphB2mCIdeDtq+cf7FQyuiSf9ZhFbAEWBvyC+3kw9p4LAOvZmYRbkxRrkdPs+Wm820V90DqURuAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280094
X-Proofpoint-ORIG-GUID: ZsyEpA8OuwQzfH6dr2VlOC2F4je5wXed
X-Proofpoint-GUID: ZsyEpA8OuwQzfH6dr2VlOC2F4je5wXed
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68b03b2a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=UqCG9HQmAAAA:8 a=vWe7RUA4vqTc7iHpPYgA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfXyvkR3lf2QkJP
 WOefTPbt/FyeexXvOA7id6vOSb7lmmbZRw8yjy7kgsSFm4f59nzZflXDPlJuTA882CQlyDiUWvw
 pGALQGakSVwLFX66HAphZ9FjhS9CUk/bbX0Ds2SZzroiBmpZxRYxccrBWOBs4w3Z5Skm0MnB2yR
 eYB2DFLUyGMm79IJA6hfzw0NQUJhJvl7LqapRNtY0q3UrtKTjZYclj4bR5mdGeYCZ1LQaUb5uD4
 ilfWDR5BXpqI7t8JGdnM2Uy09XV1RLM1Ez0f0XqANJXSqdu/P8guZYYCuFaHgzJJjcjU+n0ov4f
 QDvijbirjFGToAOcjayneOBuVmTLjRLISMyjnLOU4ssFAPze7fXj7aNRi+nQqhgokEjA1ZryNMc
 putfVO8GiCfnHeaPRdEWn0nyVktQ0Q==



On 8/28/2025 7:47 AM, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for PCIe controller in SG2042 SoC. The controller
> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> PCIe controller will work in host mode only.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   drivers/pci/controller/cadence/Kconfig       |  12 ++
>   drivers/pci/controller/cadence/Makefile      |   1 +
>   drivers/pci/controller/cadence/pcie-sg2042.c | 134 +++++++++++++++++++
>   3 files changed, 147 insertions(+)
>   create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 666e16b6367f..b1f1941d5208 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -42,6 +42,17 @@ config PCIE_CADENCE_PLAT_EP
>   	  endpoint mode. This PCIe controller may be embedded into many
>   	  different vendors SoCs.
>   
> +config PCIE_SG2042
> +	bool "Sophgo SG2042 PCIe controller (host mode)"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	depends on OF
> +	depends on PCI_MSI
> +	select PCIE_CADENCE_HOST
> +	help
> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> +	  PCIe core.
> +
>   config PCI_J721E
>   	tristate
>   	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
> @@ -67,4 +78,5 @@ config PCI_J721E_EP
>   	  Say Y here if you want to support the TI J721E PCIe platform
>   	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
>   	  core.
> +
>   endmenu
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 9bac5fb2f13d..4df4456d9539 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>   obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>   obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> +obj-$(CONFIG_PCIE_SG2042) += pcie-sg2042.o
> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> new file mode 100644
> index 000000000000..fe434dc2967e
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
> + *
> + * Copyright (C) 2025 Sophgo Technology Inc.
> + * Copyright (C) 2025 Chen Wang <unicorn_wang@outlook.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "pcie-cadence.h"
> +
> +/*
> + * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read

support -> supports

> + * the Root Port itself, read32 is required. For non-rootbus (i.e. to read
> + * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
> + * directly using read should be fine.
> + *
> + * The same is true for write.
[clip]
> +static int sg2042_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct cdns_pcie *pcie;
> +	struct cdns_pcie_rc *rc;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge) {
> +		dev_err(dev, "Failed to alloc host bridge!\n");
> +		return -ENOMEM;
> +	}
> +
> +	bridge->ops = &sg2042_pcie_host_ops;
> +
> +	rc = pci_host_bridge_priv(bridge);
> +	pcie = &rc->pcie;
First, pcie is allocated and then reassigned to &rc->pcie,
which makes the initial allocation effectively leaked and unnecessary.

> +	pcie->dev = dev;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_enable(dev);
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	ret = cdns_pcie_init_phy(dev, pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to init phy!\n");
> +		goto err_get_sync;
> +	}
> +
> +	ret = cdns_pcie_host_setup(rc);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to setup host!\n");
> +		goto err_host_setup;
> +	}
> +
> +	return 0;
> +
> +err_host_setup:
> +	cdns_pcie_disable_phy(pcie);
> +
> +err_get_sync:
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}


Thanks,
Alok

