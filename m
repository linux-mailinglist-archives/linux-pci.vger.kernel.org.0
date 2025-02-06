Return-Path: <linux-pci+bounces-20802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC67A2AA7C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40F93A2B34
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C151624F0;
	Thu,  6 Feb 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D7R9WhFR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E32+MseG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB31EA7C6
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850205; cv=fail; b=fwgt37nk2YvKW6yzi9rl3qnsCKqYbIuazfwqB5pUWLOeBPc+YsSrz4yvroq4KwJMoyqztqb+q3gSwB3Vnmkq7Di+9HsN8nWLD7Nfg3pAqz9iUoZGFtgVjbUQELobszpkVLsO572IZSF5FQm3JIajlMHOng2YyVRPx+zrUVxwjYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850205; c=relaxed/simple;
	bh=Pj2G9xjUR0KxfY8QS/+wTSBEML0JR467YfLajEp0dnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LGHSGywYsGEUYnXYJXj7D+UEXcO+0Z3UioAmAZkSGQ/LfdlZdi2SZDG3NegxBvxqQusc1mPkPiT3294OHtGKdSmmo240eYJwl7GOh89dtX6uoZ+FWj7V6u3rUlD+IM0vQKdn5olObMD4Mgh+ZjqZ42hGp8meIbQ1upa8XpqcjZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D7R9WhFR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E32+MseG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5161gLum025971;
	Thu, 6 Feb 2025 13:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8yrovjbM5/xAxIn9xW3oy0zIND0kMLiyZ4lJRPSFltA=; b=
	D7R9WhFR0T29rjtODNS5xy9LY8teSGCAYlW3eiXZ3UxKq8ZJ/Z5Ou0idTjhgZ7ic
	O8KpHY9pYK5C768IUFZ8HNbnK4U/ooSl7ZaKzSmvdqesGhlBBnjrOORLTBUYkY1B
	2757OxXc53wBThlhzFoEpI+4Yz3ObWAKt6PcPyVrOHJXbvrJYPG1LvEKviO0ZRtT
	C070to0SaqIGFXRdkgO1xhRCmYSxsc7Z3/fEH840rZO8fcKKtdcOIpbE7lieHbb9
	RfQFVogfWl5oljLo6d4PkvfEU3gf4LftpjosFvA8iOVB5txGBbsE9uoxkvJnd6VK
	dfE/1RKDgjlsuFrr23DgrA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhbthcn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 13:56:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516CTIjv027767;
	Thu, 6 Feb 2025 13:56:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p5utmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 13:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymbiPtlOr51801PybKkj7B0WucJUuIEyxOaGfRKvUi1r5SF4+8RXvQAWozWVQ+cnnj8ydCkgYRJLe6vsUhV8v+a2wnx3bnbb00okyQsSfnhnLf1skRVYTLIqhQHZWetgbB3mH1H6Tcr9QNWhQCF2WHybIKvybPKEiCml/ZmBKtIgg5KDuUYcxgCRH4fx/Q9IZmfRb+ZdVuYE/DXkK7GZsN2/8WG4RHNrhpvV1x4h3gTbkIs0Edbnud+0BLCwKiZtiIB0nJrxV53KiTeHE/JDKfp8Anu8aEh5aIAKuFGrgXg/BW0X8pNRsrEdeTqsHml6w8m2x60qs2/ITSyIoHU3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yrovjbM5/xAxIn9xW3oy0zIND0kMLiyZ4lJRPSFltA=;
 b=beD1tvWAyxJC2pi0W5MFggfN6Yd8tiZkyV5amJlbIXK79xZugktgwxgqaa3IjU30fqrqMswRSYZhiQvZZPKkRkAityJ3GzDZmv33QVG/OYvuDmQnb7lpb5kQUDpT+ZwVx8koqsz22+d4txuSeux3p4Y9Ibjm6eGa4EwBL09wWkF3TL7wFlACerb+yiW7AZf5ZsevcL1fKIC00LSmJNzUY/2j1oDWso0zfFbn2JvjjuFac2BySzX1nq6hDVXV5EYwTPmff9/czaTkmElkA0vBOkUYHb4xV/UnZht0VSm0L6DKTis/M/m1BmkMFQSidueOmZgp1LOXbkDI98geYrfzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yrovjbM5/xAxIn9xW3oy0zIND0kMLiyZ4lJRPSFltA=;
 b=E32+MseG/Uuhw+m9c5l7Hzi7hNSp88FsaDoZxPBSpCc1aZ8mwgvWDOO9lHV9I32mOT0jY5rKpQyDKJ0eQRPEA2NE2NhJW1CLI1w96ZAyPNTJ2f1DQzUabVRAWu+mDxOcLwL116tqVBh+jGFCsctKM5sQr4BPe1yNlbTv6HDQtpI=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by DS0PR10MB6752.namprd10.prod.outlook.com (2603:10b6:8:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:56:25 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 13:56:25 +0000
Message-ID: <29d3d0c4-656a-403b-841d-e3b61bbe594d@oracle.com>
Date: Thu, 6 Feb 2025 14:56:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
To: Lukas Wunner <lukas@wunner.de>
Cc: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-6-pandoh@google.com> <Z5SVN8tt-xtCAHph@wunner.de>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z5SVN8tt-xtCAHph@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::10) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|DS0PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 096b1017-3a5a-4e74-f612-08dd46b60bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU1nRTVKbU9McmxKZVZRUUFjTlpEbXA4V29OMloxSUYwZWVIY3k2bXo5M3N1?=
 =?utf-8?B?V3B1OFJFdENySzJENGh0cU5WUHRYcENEa1pROEZhdys1UitsU0dCREdnMzFu?=
 =?utf-8?B?QzdZcG5WSURYY2J2dlFHUm9nd0t3WFNEODVJTlB4VnViWEc5RDNhMjJvWk4r?=
 =?utf-8?B?b0YxU2VVT3pNakFNTXRkYitFV0lKRk5pZDA4ZE5uQ3BEOG54anpndmRxSEVs?=
 =?utf-8?B?cWo1c045YllKc29DYWErK0VSa2ZrR3l5ZWVqTXJsNWVRbktYTE9QL0RGNUxH?=
 =?utf-8?B?MkhwdnFQTzk3QTB6bDhlU2FLWkNvc3BqbHVMZzN6TWt3czhieW4yN3dqdzVP?=
 =?utf-8?B?VGh3N3VjeGl3c0pQK0J2b0UyT0VoNG9vaTJrdk9OV0hyQnZ5dGp5b0lKMHA4?=
 =?utf-8?B?YWdUUXovTk52eFRBVmFTTi9XZk1MWjdlaWRIK0tYajRqbXVHR3RwM3JUdWM5?=
 =?utf-8?B?eWNONDl4V1dMZXJUbXhxZUZOdnVEZGdqWjFyYUJ1c2VvZUJLMkZVUzNpZzRD?=
 =?utf-8?B?SC96Y1JQQkJIeU93c0cyaDdCRmxxYjN4dENZQXFwRWtRdG1IcHprLytWb0Ni?=
 =?utf-8?B?SGZ1bnVKdFlxSlJwRWJyT0h5MkxkK3o3MHNaY1BCRmh6N2FWaEV4bmpFTjZx?=
 =?utf-8?B?M29idE15MkVKU3FndU5zcmkycXVoZWNsNkV3bDlESXU5d1JIOXBubXc1N1dS?=
 =?utf-8?B?NTVpTU5yaWtWZEN2ekd2dUQ0b01ua3RRak9hZGdhTUlXeDV3NDdrZHNxWlpZ?=
 =?utf-8?B?dGFTU04wL2x0SDBWT0p4amNNSFVEY0tiRHZ5a1RUT1ZkdVk5UTdQSFk2YUND?=
 =?utf-8?B?b0RUb0hWbG5WN3AzYWhGanNudzhjdkpJZ1NNS20zNlJqaUJmOHZFU2tMRkVM?=
 =?utf-8?B?Vk9ydThPdm1xODlWZGQrRElYcVVYc0VieEsvakQyWURndExTWWdBUVdMay96?=
 =?utf-8?B?NUllSzlZQWNMb21ZUXd5Q1FqaGJqNnU5ZHlhcmVIYjRVTEtoTXlnb0U0U1Ey?=
 =?utf-8?B?MURuSlE0dnBJYnlJU2xXMGl2aTFxc1NRSUlhUmZIRWdIZkhYZzNuOUhoTDdu?=
 =?utf-8?B?M1YxSnQ2cE5OTmRmQ3lxNkdqNHh3Q2dNQ0VFSUgweTJaK3c3dHJUaXlpOEww?=
 =?utf-8?B?QitQcVR3TndBOTZ5YzVteklVdFJjbGFSTXpDdTc5WHQxNGc2a0wzWEd6NEZ4?=
 =?utf-8?B?bEswTS9MMm9NM2QrN3dFblhlL0MvUlNkcE1rUW1xODdhcS9rSlNrdFNhODBz?=
 =?utf-8?B?VjJKMXFBR0dubE9TQkFLK0dvdER6OGpYcUFhVm9kdXQrbC9vblgwYU40b2dy?=
 =?utf-8?B?bS9MY1g1MUZSV2J3ODZzQ0pvRHNRMWd2RUIrUENXNnViSHNCSHhlSVdnZkxX?=
 =?utf-8?B?SDF5bTgvNUt4b0RWL0x5OHdjNDJ6dnVrQnRCNHJtR1hiYXVNR2E0dHJuZUNF?=
 =?utf-8?B?QkFDdGxVZHE5aHFUU2ZqZEN3SnZ5Y2lOVDRKbjRBR1c0ZDB6bDV5a1I5TnhB?=
 =?utf-8?B?OWhYbFJKeWpud01QQW1tdDByWitoOHFsamxCRHNDQlUrb05EMm80QmRVNmo0?=
 =?utf-8?B?czVnazhJNTByQkN6TmI5eUxKdVZNMTgxejhlV3k5dGNuaUtUQlI0REVtQ0pq?=
 =?utf-8?B?QWE2ZzNzZGZrTVdXZGNEdkpIVmQ5L2pCeXAyTEJaNkxheTE4OXFwR2h6cG0y?=
 =?utf-8?B?WUt0d0hHa2lOWDlYekRTRVV4U3Q0YWwyRkFlTk9nTzhKSjdZeVUvZ1ZSaFpz?=
 =?utf-8?B?RFZwam02dGpROUw4MWhROVBveTNDdEdWYmtyUlJ6WHBLTWxzRmdNT1JFVFdk?=
 =?utf-8?B?RmZmT3hVWThEdUs0QjZTUGw3U2VuTGxUVHlvcXBBZXlESHMycE1VRjUzanZR?=
 =?utf-8?Q?c4b9gS21spyDO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXE4TVFaNEE2UEM1NEwrZ2k4czNhRU5YU2FIR1RMd3IwMGxZWW1uQVB6bFZm?=
 =?utf-8?B?aU9aVGdvQVNhTWZqbHJYcGJzTk9ScC9xTnZzdXRzQ25yTGpSVVRwcmF3bUlv?=
 =?utf-8?B?Z0pubGNIRHVpSVNiUWRDVkYwb2NDamdZVUcrTm5lMkI1MSsvaEYyNUtJN3ZW?=
 =?utf-8?B?VE9sQ1dNdUIxRVNCazhjcTRLd0NMV1hiT3U0MS9oUVVwaUJsRG9KbVhJQmNU?=
 =?utf-8?B?OGhLK0VSOElMY0ZlWHV2aUtpNXg2elAvVVdWemI2U0tReE1yUFg0UElkbWxp?=
 =?utf-8?B?NlpLbEdHMEg2L1ZPazhvd2Zxc2cyaWdrQkxZVkwzQWo3eTlzRkZ5TXA5L295?=
 =?utf-8?B?MkJ5MmZKNWsyQlJrZmt1TEVkL3VDODE2OEx2VjV4OUNzajI3ZytzbCs1Yk5H?=
 =?utf-8?B?ODMyWm9HMWxpVWVGK2FXdFFFeHRoMVM5Q25Ia0xwV2FvajRvS3Nna2ZrbjZ4?=
 =?utf-8?B?RUNMYVlkNU9lUlBuNWJkQ1FBclp1MkZ0dm56NmpKRnFGazQrV1JuTTdDalgw?=
 =?utf-8?B?ZTBCZVova2RyMjl6NGtXNDdFOGVwUU90RnFxc0VDVzhxOFpZRE9YemlXdHFT?=
 =?utf-8?B?ekZPdG1vdzRTaks5Q3gxcEs3VkVzU3ZHaW5QVCtMc3NBL0NHNGRzSWl0Wmtm?=
 =?utf-8?B?NXQ2czhNQlNYeDRFVXdranhUK2t3cDNQREhkYlVwOVlLZG93bldKSkEzRStE?=
 =?utf-8?B?b2xQSnZiQnNHbjZqODh4SHZWalNjVEVsY21pOHNaNjdQRUdrR2dxV3ZRSm1k?=
 =?utf-8?B?N0FsNlE0MUVxbkp3ampNTjdIVkJYWHV5aVhJb2tzUFJsTkNLVVhtQlpqeXZ5?=
 =?utf-8?B?OFVhL3cwZURUQVpvOVVrWnJNYnlvSGFxejlGbEhnRGNsZDFFSlZHazNpbzI2?=
 =?utf-8?B?cjYzcWdGSlF3MnF2RHpBOUdQTFVJV0M0YzhxVkVHSERTUU1Qa2xqQWxxd1JT?=
 =?utf-8?B?dEN5Wmw1VXBzWURrcXBiMWhadEsrSjdtcDA2THFRbXg5ZnhNVW5ITmFMNitH?=
 =?utf-8?B?aUZrOHJmSUM0Z0NscnljTWN0QXhkYWdCSlNsZS9HWngrZ3NtYnUxVHFjTCtk?=
 =?utf-8?B?Z04waEFyS3dBeGRnU3NIVFQxNjdha3hndDY4Mi9lVkVWdHg2MjQ0VC9WeTg3?=
 =?utf-8?B?RGVzRnRoK2JtZm55NEhJNFY5VVh5aTEySSt5MW5sNXRmSlczd2ZmR2Uvbi9u?=
 =?utf-8?B?OWQ5L3BCYmpEMnFSSk1LSmt3UXdsaVFqQXJ6SjRBdjkrdVgvUnpReXNhQlVr?=
 =?utf-8?B?STFrV0xxb0t0OU1RWkZjenVWL0xtNytXYUx6NzJId05RSnlNaXFCaitEMnNB?=
 =?utf-8?B?VG5YOE5pR1Z0TTJQa05zZGJTVXJBVnhnYzZ3dFpjazNCZDBrWW1aaHk2Z2JS?=
 =?utf-8?B?Vk1COEgwdDZPYXBZZlJxbzBRNFJZcGN1UTMxMXFLdUFyL0RCMExvd2dKalBS?=
 =?utf-8?B?VFpzeDlSaGV3L25CN0FFeFozZ0M0a2JWbUs2YS9mZ0k4TGtMWlFPQlk1RklW?=
 =?utf-8?B?ZU9LLy9IVGZtU0hOTjVodmR0T1haanZrQVd0bU9IQ2YycnRGcUNaNmVKVEM5?=
 =?utf-8?B?aTRmemVObncyYWZ3cmd2N2FVNDZ6a05nb0pZc3ZnY2xNcWkxZWdSWE9kcE5m?=
 =?utf-8?B?c3RiNDBCbnpJV1l2K2UwM0J4bmllZzJiOUZoQWZNOHlVQjZOaEsvL2ZyLzJj?=
 =?utf-8?B?R2wwRzlHTElUVHlMeUJtbklEV09uYmczZTl6YUIxU3FLYVREemNNUVRETHJD?=
 =?utf-8?B?WndjQXJTeGVzejRVMVR0UWxOcDRhRzVRM3c1akJpclU4NVZwWGdueWRjVEhJ?=
 =?utf-8?B?cllyTndIbmlMaEVGcGhuNUNFUWY0S00veUI5d1JnMVMrL0FGbmh5UU95SzZR?=
 =?utf-8?B?TVNDMUtRckJGZnJCYjR5b0ZJZS82QlM3OXJ1aEdsRUlQR3g1emtIdmdQcGdK?=
 =?utf-8?B?b040WTNxd2xjSVU4NE5NcjIvdFRISm5Sam80QkxFTDR1Y045aklDTGlFZXho?=
 =?utf-8?B?amI2SlpkRG9GWmMyVkJ5MkhFaGt1b0dLOTBmb1lDU0ZnYnYycVZZRkxrdVpR?=
 =?utf-8?B?ZzY5NGlVdnF2M09MK2txdVNHcGV2b3JLdHpsa1dWNnUyd1lwU0IvWG41M2lE?=
 =?utf-8?B?aWhrL24rK3N1bGRKaXRsZ3pmMjJQZVpXemt1a0xsT0Q4elFhWno5amp6eUI2?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zWCgZX0NxPcxyYkCZjCBkpMHvY+Y/TY/j4g+oKRjtmo4xNrgHFECRUMEWCXRvfvfh5SXEPBYMqe8j+ZPlV0Ueg+6i/lP6J9grJ/0NfJS+Fw22rcwVMQJVc3/ZphX+f3/tnco5nbzQQ1cmhu6/0Yx+1U9vhAZA64tdD2C7z82Gu+yXqQSZ1J8YfnNm77oVl4mKY7HcTT4uwjLxJLtTZWNl1AWbqrIXnMnvqMUxTXZC2ez5G7sVE5uqA0+GVn4QiilEOgnW4+p45ZemPS/WkhwkIQ9WAWUUu8ihvqilJOA4wc6onSH1WmXQQDsFeLYZvIZS0T3Y4qSbqcshIe+5ENTFGF6wSm/oIfSvLDXbykxo089nITr0ezIrFlEGKA7ZTpKCRX4hFC8VPqSpintRWPMtkcNGjmtLUqlBDiGPvCaE1BScWkVZ+C2tbQ1i/06uJqMTOEbRy2PQjX1/K1sTCs6/cYTZUhXPrNd+HBnuFGlfbdEPszL82Kea/QKu4kiq0diRZmiv1UDCLnoRyjIq0CDgY6N3B600GFShX3pKKR3ZL34agAUc6qbAqKFaTBGBUeb8ySu0Ae5WdNWJA/MlSKTCH/x5o3KE9MWA5sFpmlWK04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096b1017-3a5a-4e74-f612-08dd46b60bd6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:56:25.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVlm4u475fm2/lPa06ZyxdlNiaDttKf3AR52VN4Nj/rxfNHVsjKvO7KD6MTGX56o9ToohwwHL5lQdZ1Qkc1LLt1V6RWFfRwfYJ2hWuOaKNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060114
X-Proofpoint-GUID: EaDQMoB0-3npk2Tk6Pd_lGkVuwt2ATm2
X-Proofpoint-ORIG-GUID: EaDQMoB0-3npk2Tk6Pd_lGkVuwt2ATm2

On 25/01/2025 08:39, Lukas Wunner wrote:
> 
> Masking errors at the register level feels overzealous,
> in particular because it also disables logging via tracepoints.
> 
> Is there a concrete device that necessitates this change?

I faced issues with excessive Correctable Errors reporting with Samsung 
PM1733 NVMe (a couple of thousand errors per hour), which were still 
polluting the logs even after introducing a ratelimit (first every 2s, 
second ever 30s, as proposed in [1]). Also, instead of masking the 
errors automatically, we could give a user a sysfs knob to turn error 
generation off and on.

> If there is, consider adding a quirk for this particular device
> which masks specific errors, but doesn't affect other devices.

There were many other reports of Correctable Error floods, as signaled 
in the cover letter, so it's hard to pinpoint the specific driver that 
should mask these errors.

All the best,
Karolina

-------------------------------------
[1] - 
https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/

> If there isn't, consider dropping this change until a buggy device
> appears that actually needs it.
> 
> Thanks,
> 
> Lukas


