Return-Path: <linux-pci+bounces-19956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBDAA13899
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8D27A299B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 11:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F61D6DBC;
	Thu, 16 Jan 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i/+ZcFPW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ocDE8OtO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5D199931
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025901; cv=fail; b=i/a7ZCJ4ZxcGDD2lC6idNR4kFAw4UFy/7KOcdijYLL/s5cMrKTdSZtB1UQcSKzRURrf/VEr5Oq2WhqJL/rR0q7tnaVFEi0MApqwJQ6SBgJrTDhYTgfhWXWCU4cpaqARYIpzFjUvXaamXpmPICJSBWcjpoT4/of6QDcV3IsBXaNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025901; c=relaxed/simple;
	bh=G1NxUIRhKWoF5KVOjv8raRRoqjFQCNgJxSkiIdRrS88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E+vUOkrVgy0sxEn2kFdcFn+k51m9EsoeAO0fJc5TecRL2d4NfqQrcPQaDM9uNUzcfN5Ki1ODeEbCgDSGxSVWVFqt7w9t1wUf58nJ/pVL8x3iTEAyjRkggrVr+zMelE6z8F7D+KN884+nd0PdVqtNFYlS324BvpIogCE/OiLNQ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i/+ZcFPW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ocDE8OtO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G9NHZ9021678;
	Thu, 16 Jan 2025 11:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=V4IUhDy+Bxxi8b/Dhu2spXbBxyxa0wVf2iQruKmEmPI=; b=
	i/+ZcFPW1fyE1W75gskYNfCf22ITSbH2DwFRHVt35RHux9/URqx3s/Rd2PmH65bZ
	3z4BO8FdGQwjIlfYxoFjxR8sTOdgaPh0rbt9OsNmUsfuQGsHQz3CQcvrAh0fzQML
	nQnQwhhIWk2uktSPv3WUR5YzXAaMoh8f6BHDExCLzCeV3U8bAAG3yONSqTFsHfKD
	/0+2MvjnZCxeSyOOOGXqpmwGT3oN1iYMRGmoyz6TQ5M0fcH7jRy8Rz1JK8jKOzDH
	f7zLf6f6UFezTEZgto5UT05GNB1t4eFK2Onxzyw4+5QLb6nW+I5L7axMaJSW0aDe
	KNeX+VUTobOO5M2uO2vy4w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7ya0y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 11:11:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GAgK54032177;
	Thu, 16 Jan 2025 11:11:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3anv0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 11:11:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGqVzLI+TpwmFSdebU/cmVi1qFpt2yTYe11ENsKUPOTMrxM4TFJ6KAYA1mV80gbX1OmAYhK4y9HhXgEXIrpyzL72N1sLW89xTdGcmA0NpmRFb5UM5ZlC2w1qkl529sIx9wPnLthnO3vH/O/feHXLMci3mgzJmHg6iIWSoYrsCFwdkOjo5X6cUbrNuuEhNKP9iQMr3zdjlDc582rnGbJ9QXEV9a7XxfNMsUILKXnFe8g+76AvPUoHUsPmsvzIWWAw60mMxX1YOMtZR0d8kaTXI2pCqwgfCVGuyDvZKyUwZNTD2hl70jB8DmMhLy7HyferqbBLyQW3qH6huEDv5oL37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4IUhDy+Bxxi8b/Dhu2spXbBxyxa0wVf2iQruKmEmPI=;
 b=F+P8pFdiktG+ADUOor3DQZTt6b4Kqf6K1bXQt3DI32BO6My29IUvubzREnhkuviIlOUVtyP9YbHpgYSd+4QGRz3Ka4XXQgmqzN9ZLO+S+gY1+4k3ksadEX0VssWnf+gCTmrLQL3HBc01eJsDSiPgEjsMBjyLKzR54tJU6xUB8enKzm2wuBBR2jzjPy4HuDw4vJgORpMx3XbvYamqMbpfHrIbXlIBEB0VlZnhIkL0j4e5GrsJolEBACjW8Q/XysuAKb4tCJy3WrxiN8CttAvgqZRcfl+snx5qduRuHDeOLrkahc2p8p210f5s3pznuxV8AS7irMZ0aPzAQ6TnZIQb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4IUhDy+Bxxi8b/Dhu2spXbBxyxa0wVf2iQruKmEmPI=;
 b=ocDE8OtOYVJwZVHi7sXfvzBHd0mBQ4Es8xu8UzB7QDhODwaf+rGykNzl+B99fByNnf1AY/4hFrk0rR8z5BQkYFrYx8M/a3GJCl5ulgOCOlhQhL49cg7H5GLhCdl4SvUSGGrECdezdqLHdJVrPer/3Iv6dOi5wKCtrXRGuo0/gic=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 11:11:20 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 11:11:19 +0000
Message-ID: <b0eb4417-600b-4b70-ae5f-d51ccbd5ef2c@oracle.com>
Date: Thu, 16 Jan 2025 12:11:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] PCI/AER: Introduce ratelimit for error logs
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-5-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115074301.3514927-5-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::23) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 267d4681-699e-493f-eedf-08dd361e80d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHZVdENVcjFrRUd0SXBCblVaNk9uaTJIR2pvZU9vMWx6TnFPU1d4akhrYktB?=
 =?utf-8?B?bDF3NVpSSm9raGl4ZzR2Q21aSHRRV2taVFU4amR4YjI4d25BQk92aGhYek04?=
 =?utf-8?B?WnZ1dUJicnJLOUp1NUtzdFQ3S2VWZHhWRDdrSDYxU0dwZlhNYm0zZUdWbkZE?=
 =?utf-8?B?RmtGaUNlQlVvdWN1UGtNelVXRnNtb0J5b0VSYkFvRWJxZzF2Q0c1alVjK1lv?=
 =?utf-8?B?TkhtNVMrek1tZ3pDaHdjME8yUnl4aS9wVzRYRk54MHlGd0RVNWU5eHBTc3M1?=
 =?utf-8?B?SnRxblMzY0hZbjV0bTZGK2tKeUJqNlFDTXpRcTFGSXk5TVhmVEdpWjFScDNw?=
 =?utf-8?B?d2dVcTFLRDdOWUYyNm9UVE1sMWNBUEh3MkRFcTk5dFY5S21FSngvNmJpbU03?=
 =?utf-8?B?YXFhME9CVlVBdWlKSFVGa2FnT0xsalMvSFZoZ1NWQ3FyMkdTc1IySlBJRjNT?=
 =?utf-8?B?OEJFNDdhWnBBeXJLNWxpYiswb2Nvb1Q5Uy9aSWsxOFJiMm8xM0JpNWUxdi9B?=
 =?utf-8?B?RlRLRFFXdzJ2ZVlVclBNOGNCMTlKSS90enVIdlBNTzVEbFhVUmdXNnlPTlB5?=
 =?utf-8?B?VWw1cXVyUm1PS0NQRzNJUm56TGQ0cU85QnBtNjFrVzBuUm9OYlEvS1dKQkZn?=
 =?utf-8?B?cG9oaGF1dlRheURST3RocmFENmY2bHFGTlR4YWE0ZE9IbjhwcjlHUEZ1d3pF?=
 =?utf-8?B?QXFDaXVROXc3azFBd3NVZlp2Vk42SjNQTlBHZVEwdDE5ZHBMYi8ySVJYdmNX?=
 =?utf-8?B?a2c0YlhDWkE5ZldLRTBIVmVPYndoTlMzbGxRYk1JUlRHWTBVNndKVTlNQmx5?=
 =?utf-8?B?Z0VFSDJhT0VmYk9Wd0tWaW1MeVpkMDlNYzlRR1V3blE4QWJJUkNZaUFaelBt?=
 =?utf-8?B?cFUxai9Rb01PaHBZTnhuRTAydGNLeGE5Q1NCdFp6bG9tYmtYQVlDTDEraXZC?=
 =?utf-8?B?eHdGY1ZvSlFDcDFveWVQQnBaNVNHdHdJRDJpb1BOdEF0dXJJVzRLbzNxNk85?=
 =?utf-8?B?ZUpEeWthbjVFUk01YnVLajRWaGVBVmhKL1pkeFFBN1NOcUZZWFBDNTA3bGhM?=
 =?utf-8?B?em5scWpYZ0hlbkNMYUpIZHFUV05jMHU1RGszMlljMlc5Yi9KTllZWVdxL3E0?=
 =?utf-8?B?WUM1NkFIVzNCSmVtQzVVMEhuYmhFY1RMR3VXZmpKSVF3WFR3bEVvUzFNdDdY?=
 =?utf-8?B?M1BGV3UxR1NIUXl6d0FTRmdFc1NPLzlKK2hDaEQxSEJ1VERxM0hsSmNaZWtC?=
 =?utf-8?B?YmZLVURPcVY0KytmOVYrdE40NEMreFgxTUYyQ0lPS3JXN0paZ1RwNmFvSmU2?=
 =?utf-8?B?eUd5aDJHazN6YSt3STRCa0RTYzlwZXpxa0M1SDRtYXp1amt2ajRFdldzSkVS?=
 =?utf-8?B?aVBQN2RGZmtYZlArb0Zicmo4TDhmVHQ5Vk9qTUxDZHZvRDJ1SWxiN3BxVUZX?=
 =?utf-8?B?R0NCVnBwdlFqRHpQWEZldnVZMHJtbWFBT0REVHF6a1JsU1N2L1RWbmEwa1BY?=
 =?utf-8?B?Q3pLODJIbWNweEZLdkZNK1dSQUtweGdSRjNSb0tQRFlzOHNMeWdJMzJwcy9u?=
 =?utf-8?B?bmVnL2JxbXlUV3RTQjBqQlV3S3Zib0I0NWJtQjRkbENKVjVCdnNsTUZUTUc0?=
 =?utf-8?B?cm1EeVk3NW8yVlBFSHZGSE0xakozMi9aMGd0aER5WkhzTGErdWM1bGZYeG0y?=
 =?utf-8?B?dzlEd0tuTWhFQUsrYWVKQ2htQVJHanYwWjk2cWVVakdad0QzRWJHUmhkTEw2?=
 =?utf-8?B?bVM2UkZPdXlRbmtQTFV3TW1TV3ZXTlpXdUM5Q083VVFmTGhtbW00VkJwdlRH?=
 =?utf-8?B?bCswV29XU2tjNGNLODJib091ZERPeC9BZDZ2dHVybXZ2K1VmclVHWU4rRXk0?=
 =?utf-8?Q?oFp1zARlfP/rn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MExmSjdMY3pjcXBEaklBdEV3d0liSVE0K3lsMlFNTVJpTk12REo0S3BpWCtJ?=
 =?utf-8?B?MlJ4a05Fa0FQZnd3TFFPZUhkbjFqT2VmbHFkbjFrK0pYc2pUemZlWVB4Ym8r?=
 =?utf-8?B?Wk5EOGRGZlpnUS9tbG0xdVdNUEEySTY0VEUrcWJSUVdtdVVmQ2NNdmpvSUcr?=
 =?utf-8?B?VHRMUitmcy9LWlFsc3k5bnBEbzRqMHNBdHpYMnBlS25YZ044K3RsbDVxQkJv?=
 =?utf-8?B?Q3FzQTBSak1EcEtzaVZtUThnaXpzTDR1elJYY0NwTUhuZCtLY254cWMvQ0Va?=
 =?utf-8?B?L29yVTZxbXcxRzZGYUJSZkxkL3VLYmI3bzRocytHaldjb3pPTjY0TzBvZGE0?=
 =?utf-8?B?MlZvbGUyUm9wbmdNa0ZOZGIrc0VvQVNYNFBSM3FYUDVHLzJncmFqb3Q1eFdu?=
 =?utf-8?B?SXk0Vm9sSzJMcjcxU2lzOHVSZWJQOWdZcEw1K3dZbmJzUkJLZ1lmRFVuWVJL?=
 =?utf-8?B?NXpVdi9WY0VtVUVTdWdPOWtiMGx2N1ZyMGEvWXd6T09ma2I2YXYwUFNCRCtZ?=
 =?utf-8?B?eVNJQUtPQkQ2OG84WHN3Q2cvUkNlaUMrMEloaXIvdHNNSm4ybnYyRVBaZzRn?=
 =?utf-8?B?V3hEOWhweHdzWXV2WmxZbHZ6RlpYeVROMnFlRk5FTWdhbTFuaHVjYlM3OFp2?=
 =?utf-8?B?cVlhMDBkMm5EbHM4TXp4TDB3aHlMU2R3S3FSME9yUnErT2NzdW5VN3p2TUlV?=
 =?utf-8?B?alhNK04vd0Rhdm1hTWJYT2dSRmp2dHBDeU8wYkFrY2M5cjBCYU5Oc3Z4Znp2?=
 =?utf-8?B?NW9IdXhmREZydmZuQlVNS3NmWWI3NTRWek8xSXlqU1lSY3k2VDhYSHhhZ1Fs?=
 =?utf-8?B?bnhRQWhFQjRjMElBVHNUajJCMG00VGdLUGRIY0VyTnZkYzlHY2dxRHVMTEEx?=
 =?utf-8?B?SEkyZ2U3WnEvdlB5SkpyUlIyT08zcWF2eWNYbU5oTzRZbkdQNzhvNW1LR2VS?=
 =?utf-8?B?akVXNTFuM2hSTU5SM1ZMUUtPZE5pY1ZSUWdZL2pObDV4WUJYQnoxZUNieXBa?=
 =?utf-8?B?alIwcjZzVlJYR0dlM3dTUjZOYVlmUGVhdzROanRUa1U4cysvQTFLdEIwcGhn?=
 =?utf-8?B?NGNTVUtDVFR0TUpWN0lCR3lGcW5YZTlTODhLTWtSSGJCZTFkckpJWVJFTGFz?=
 =?utf-8?B?ZUZDZ25JNXJnRjRJcVM5L21nako2aVFNbzhoZElrTWI4ZEw5ZmlsODYzWW1w?=
 =?utf-8?B?Y052VFloQ1pzVVdPZy9xaXJJSzZ1R2JUVXVBamtOc3krbWg0dnpMbjdTSzk0?=
 =?utf-8?B?NnZ4V2lVWEhwT0FDYThvZ05DbTFaK2hRWXRxVEJLb2FHbmdGcmN3eUR3disw?=
 =?utf-8?B?Y3pXMFNPbkQ3VFFjYnNTNFlGVGFzQkZ1ZGd1OCtPQTJadWNmdjI0c2lEb1d1?=
 =?utf-8?B?cC9NNlcxZXMvdDBrdmhFSlhlMHEwMmVOa0JaY0wzYW5QQVJZRDY4UWdUclRR?=
 =?utf-8?B?ei91QXFVaW5MdC9yaUsweDNkaUxyRTNHbk8xc2E2OTZwNEF0L3ROVWNEcXRn?=
 =?utf-8?B?R0ZIMnVKb0NSYTZKcmVzdnEvRlJNV29wOStweXpzNGNMYWl2TTBVTllBVEoz?=
 =?utf-8?B?Ly9pYnNWdU1VaktxYThPZUxad2NZbVJKcHZXTkdTcWpIMi9sK2VuWjRwSFVB?=
 =?utf-8?B?OVY4RjJPdG8rNW1IL05KQUlNMC91N0JOcXZHdWcyRnlNSHNqQTFxcDZWSjNs?=
 =?utf-8?B?aWp6dU02M1ZOTWdSVXVnQktxTHhKOEcyTytsT0x3eUR2c1JkcnhlNmorb2tq?=
 =?utf-8?B?U2ZFbFJ5OWtFQk1jT2xHRmUxQVY0K3UrZG1IWmplWGdyYkFtN01sdUVRdEhF?=
 =?utf-8?B?MEl0SHpmeElBcENRZjBxZTQxaElIL2loK09CYjkraTFEUWJOaTdwRGVwdTd1?=
 =?utf-8?B?ME5aVjJqYk1HcEI3NExiWmRpOW9JRGJKQWlRdWpvYmo4LzQ0YzdCTDZFMkNi?=
 =?utf-8?B?UlBIL0xCZ0QySjFDbFQ5UDh2NEJPNC80c0FoVzVnTk9seXA3U3N5d0tQdVhw?=
 =?utf-8?B?Nmw3QkQrN1pWMklONDlROWYxZmg4OHpKWkdjVW14Y2hET0tpMHA4Sk91MGNR?=
 =?utf-8?B?TVZ5bUtzWEg5ZW9mR3Rqd2hEbitaaWNlY0VBMkxJV3NaOXI0Rk1Ob00yUmto?=
 =?utf-8?B?WE5DdTIzcEdCZ1lINCtFVTMwR1ZXY0poMEFoV2RTempTQTFkZlF2Q1o2NXBE?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K0AvG71cAFC5Cc9L7W0AvBJIvMlJGuEjs7AtnsQyNiZq95fkJjkqxP2e8l8SYwtrslp+/yEMUwvNJB4bzg92hGvxlOwqvGrsjz9j+GT6sdN/mC13gTdZjier1D3jGv+mX+/LnJ1hxFcz0nXDEJ1DgwsfTbUWlCblUVFwIBTusuSxz2CNkZqla4V8HwnJlDyWDnJCNu14yGRgAhftQ10oqvl869aBdaf858eCItN7WIoi2xQNEX1QPBnjpyAozgTi7o0RYcgrJqE2A05UYsGfWRh8MEpqHZOHwLxMxdN5gbf/08WvuRAVI5YnouqTCJ3M9sRijMGouOppmS4XOd/JLJ87ltUSgWLGc136+o9Q2+6J3gZ3GqWrBalGZZxwJ+IyB1TfZBU/aEZWK6yqlxvCpy7Omp0vsed5RP8iA4iqjrM85OnaMOKb6kkZIAZKDEgExpff2f0XPofBSO+NIKz7B6LDJujH8QMgbXb7NWobxCdogp8jURlLBiZU2si3A3+IT03K3Vm42hjdvBVDTh6QoHcFqiuZ9qrabWNVDP4sW05rEL7kxGEv5hjUOBZTtk7HU8OXV1wy72afwu9BKlwujv0kEU2u9JlNpTNsz0+/IwY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267d4681-699e-493f-eedf-08dd361e80d2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 11:11:19.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1xspKvjRK2gxA/eYv9DC1ZHXlrXO14gJf8nsI0B26i6BWMFRelBXc0SzWQEh3SajHVSRSzOm8Z+BTQOajLDCOTXa9c9Mn/f5FXkU+cSapY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501160083
X-Proofpoint-ORIG-GUID: _E0cxqxH1A05FhnaGY5oLKuW27GS030q
X-Proofpoint-GUID: _E0cxqxH1A05FhnaGY5oLKuW27GS030q

On 15/01/2025 08:42, Jon Pan-Doh wrote:
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER errors (correctable and
> uncorrectable). Set the default rate to the default kernel ratelimit
> (10 per 5s).
> 
> Tested using aer-inject[1] tool. Sent 11 AER errors. Observed 10 errors
> logged while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable)
> show true count of 11.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   Documentation/PCI/pcieaer-howto.rst |  6 ++++++
>   drivers/pci/pcie/aer.c              | 31 +++++++++++++++++++++++++++--
>   2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index f013f3b27c82..5546de60f184 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -85,6 +85,12 @@ In the example, 'Requester ID' means the ID of the device that sent
>   the error message to the Root Port. Please refer to PCIe specs for other
>   fields.
>   
> +AER Ratelimits
> +-------------------------
> +
> +Error messages are ratelimited per device and error type. This prevents spammy
> +devices from flooding the console.
> +

Nit: I would create a separate commit for the documentation updates. 
Also, I think it would be good to mention the default interval and, 
maybe, explain why such rate-limiting was introduced in the first place. 
If you don't feel like writing about it, let me know and we can work it 
out together.

>   AER Statistics / Counters
>   -------------------------
>   
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 5ab5cd7368bc..025c50b0f293 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -27,6 +27,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/delay.h>
>   #include <linux/kfifo.h>
> +#include <linux/ratelimit.h>
>   #include <linux/slab.h>
>   #include <acpi/apei.h>
>   #include <acpi/ghes.h>
> @@ -84,6 +85,10 @@ struct aer_info {
>   	u64 rootport_total_cor_errs;
>   	u64 rootport_total_fatal_errs;
>   	u64 rootport_total_nonfatal_errs;
> +
> +	/* Ratelimits for errors */
> +	struct ratelimit_state cor_log_ratelimit;
> +	struct ratelimit_state uncor_log_ratelimit;

My comment for 3/8 applies here as well.

>   };
>   
>   #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
> @@ -374,6 +379,12 @@ void pci_aer_init(struct pci_dev *dev)
>   		return;
>   
>   	dev->aer_info = kzalloc(sizeof(struct aer_info), GFP_KERNEL);
> +	ratelimit_state_init(&dev->aer_info->cor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +	ratelimit_state_init(&dev->aer_info->uncor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +	ratelimit_set_flags(&dev->aer_info->cor_log_ratelimit, RATELIMIT_MSG_ON_RELEASE);
> +	ratelimit_set_flags(&dev->aer_info->uncor_log_ratelimit, RATELIMIT_MSG_ON_RELEASE);

In some cases, it would be beneficial to keep the "X callbacks 
suppressed" to give an idea of how prevalent the errors are. On some 
devices, we could see just 11 Correctable Errors per 5 seconds, but on 
others this would be >1k (seen such a case myself).

As it's not immediately clear what the defaults are, could you add a 
comment for this?

>   
>   	/*
>   	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> @@ -702,6 +713,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   	int layer, agent;
>   	int id = pci_dev_id(dev);
>   	const char *level;
> +	struct ratelimit_state *ratelimit;
>   
>   	if (!info->status) {
>   		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> @@ -709,11 +721,20 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   		goto out;
>   	}
>   
> +	if (info->severity == AER_CORRECTABLE) {
> +		ratelimit = &dev->aer_info->cor_log_ratelimit;
> +		level = KERN_WARNING;
> +	} else {
> +		ratelimit = &dev->aer_info->uncor_log_ratelimit;
> +		level = KERN_ERR;
> +	}
> +
> +	if (!__ratelimit(ratelimit))
> +		return;
> +

Maybe it's just me but I found "!__ratelimit(..)" expression confusing. 
At first, I read this "if there is not ratelimit", whereas the function 
returns 0 ("hey, you can't fire at this point of time") and we negate 
it. My series attempted to communicate this via a variable, but maybe 
that was too wordy/complicated, so I'm not pushy about introducing a 
similar solution here.

All the best,
Karolina

>   	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>   	agent = AER_GET_AGENT(info->severity, info->status);
>   
> -	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
> -
>   	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>   		   aer_error_severity_string[info->severity],
>   		   aer_error_layer[layer], aer_agent_string[agent]);
> @@ -755,11 +776,14 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	int layer, agent, tlp_header_valid = 0;
>   	u32 status, mask;
>   	struct aer_err_info info;
> +	struct ratelimit_state *ratelimit;
>   
>   	if (aer_severity == AER_CORRECTABLE) {
> +		ratelimit = &dev->aer_info->cor_log_ratelimit;
>   		status = aer->cor_status;
>   		mask = aer->cor_mask;
>   	} else {
> +		ratelimit = &dev->aer_info->uncor_log_ratelimit;
>   		status = aer->uncor_status;
>   		mask = aer->uncor_mask;
>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> @@ -776,6 +800,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   
>   	pci_dev_aer_stats_incr(dev, &info);
>   
> +	if (!__ratelimit(ratelimit))
> +		return;
> +
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info);
>   	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",


