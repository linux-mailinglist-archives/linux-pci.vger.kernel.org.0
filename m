Return-Path: <linux-pci+bounces-15428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 581EA9B21CE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 02:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901271F21279
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 01:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5CD42AA0;
	Mon, 28 Oct 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V7wr4RDw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5168BEC;
	Mon, 28 Oct 2024 01:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077557; cv=fail; b=LeNdA/MUIA8QS1wfXm5c2K0j2BDxJ3Sa+h/Tk3NuCx5QwIe4C3ihF1O0v09aOxw0hgjVUF6w2P6YM6E0srng8KYV7u2mIOmF571c+MoEwAfXdhLepaVYTkHK4RKh0/Xghh2lQTxmcpyMFtGfk22uIOlbxWDgKvzV5IMVG0Une/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077557; c=relaxed/simple;
	bh=VHlKtFuFxVgGvmY5ut+3rF2Qh1Hdui0Q3+fZIEJxgTA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CLk+UU89gl/VALAPJOhdEh5Hf554Ji20oiM3RwI/FUD9ERG46rbZIIPIwPE86noOpFMCJ7cQU8lRFffN3ZsItoDoaSMu/+IulC6+ZKiFF7oxcjI03tsjV+GoT5tmVBF32PM0xi+I5sBP+5bISdIfAxh/SLIw4wGADxMDuYmGOas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V7wr4RDw; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tELiWAHQoHCSGju7WCNoHKDBVW9DE+O2GYtza0GZ51bXZ70QRb95alKrjCxdcfl/KPw6rrzwVJxmaOmQ6r8PRx57vTuGc6mOs8T0Pw1vBmXPZy6X58ns+dExTVRtN5m8IfkON0t3XEA9dbLUoIzvOn9qxFwfAsLr4FbPAko/AL4cx60R4JTtDsr0dS+Wemod/sfxmwTwAXBq9POgBUiz81nwD9CLNarwF7V+al540ce5227myWNwjoDmOnJBqIsyyfrfivunJLm5KQ+j5+7ufp2osjajqGpGAZu31Vj57u4KbdKggvY2BJDBzlhmXPPl0IpBpoU1FGKsBWDhmtF62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtVgPRk74DQS5IYdvdXn2BsATg8BW3vp8vUCL65G6lM=;
 b=CjyuLhImwuQILLeZqI0bk0dqOX9QGMBANFub0VJDlzZCp3S/d/+6ouRkw6uWkouuuhjzciNk0ypf/FOcbHuFYwpUGlgJHhUp5YN+KLIhIaJpCg8ssyE0cLprN35Kd1hJrdY5IL/2y7qOxXIVaSo40QosOJ7SD1C0Ghlh5e+8XkNF+a5//WEMOxgJxpi8p3iBRk0qR8MfEXnPvHXsdYq5hbUEEwMvU2T4mjW6vU1f39P8h8cQEBmnD4T13Qs+hTaWXHd42zDaIPYe5cE9Q9T2EGseNiI1Cavxp9jlb8Ip7nC0XtIAeN3/BtHcjP1mp1AubRO3PbLq+cOnCPTWBx/fbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtVgPRk74DQS5IYdvdXn2BsATg8BW3vp8vUCL65G6lM=;
 b=V7wr4RDwksnMbHkgmabMzag20Fn8+eNBzrBWmNx6ZdCuDw9i9Ww+lZWeMnuDolSYuwAf/EXP+QYd0zP/rgz8DDMEkGJZ71OaIcQMfpLXvx1UjBW4YGNtJ8oibXMpSqMoBotS3wMJbq07eGaSzaQHFyLpn51ThdSlkClJQsQG7xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 01:05:51 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 01:05:50 +0000
Message-ID: <98aafc3a-cff9-4c81-9fc1-24375a405e49@amd.com>
Date: Sun, 27 Oct 2024 20:05:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/14] Enable CXL PCIe port protocol error handling and
 logging
To: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241025210305.27499-1-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:806:d3::11) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cad9d9-0ade-4b92-98bc-08dcf6eca9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3MwZGlYMGVTaUxQMGdRU05XZjlhL3FJSlVxSE5nVHJTRWh0SGNnN0l4aVB1?=
 =?utf-8?B?Ti8zVDZXZkdMa1EvdnErcm94WGNhbG9lK0hWKys3dENYaWFBdmt2S0VaNzd2?=
 =?utf-8?B?NytrWERtNjJKQ0Z1R1Q3NVdld3F4dnlDTE1CcmZWZWZlTGh0a0IrM0pzQnUv?=
 =?utf-8?B?SlBwU1hHU3NXenUzTTRUS0ttbjR3UklDaUp2SzRHNUt2R1czd09kTGQzWDdY?=
 =?utf-8?B?eHprTGQ1U3g4bUdjSHJJNGx3TzlBbGM2T015T1B1WjZlK01zZEhwWE5GaHBu?=
 =?utf-8?B?L29NeFhSRTI1dngvVnJyblhyMjZvemRWWjc5TlNlVHlDN2ZwbytsWlBVZVpj?=
 =?utf-8?B?OVF5K05RRDhCVC9sc0k2YUE0Y09oMkpST3dueVpjMVh0WHJXMlJHSFkyZ0U3?=
 =?utf-8?B?QnhIeHpRWVhCT2taZjBITWNuTTM1Z0ljTmI5bUxXbGNTY3dtN2JDcVBKV0pt?=
 =?utf-8?B?RzFFQ2tiMkkzYnNqemJCeThoTW1OenJGaEdGdHF2czFTRG9NTk9IV0V2ZXhu?=
 =?utf-8?B?YlRvYWFWbHcxSVZCTE1hNzVjQVlPb3BnWkFlZ2lsMWJBS3Zjc1NmRzVkM3l2?=
 =?utf-8?B?ODY2QmpGeVNxcXpLZ2tlZWh4M1F6dmUvQ3dvbmtMM1h5WUcvVGE0di91TEJE?=
 =?utf-8?B?VTBoVVVad3dVQ1lwNlplbWtMcDRlb2FXVXZqY2c3L1J4Um9vMkhhU2JwZGRm?=
 =?utf-8?B?U0lDTWRCZTZ6Y3BFcFNrNWRpMkwxTVhTVnNWMmFVZFVYWXBtR0FLNDhyN2Z6?=
 =?utf-8?B?MUpaeGxaK21Mdld4NDNqeDg3ckFNM0FRWVJLVjF0NW84cHg1S3BFNTZzSGpi?=
 =?utf-8?B?bU03ZDZuWnYwWmd6ZTVjUExCUTQ2dTR1WW5Sc0lvdGR6MEpXdTMxWm1wR1JO?=
 =?utf-8?B?RFZjVGEvWHU2K1FSUHdhQmRqNGJKdXRVR2UwV2U3Z09RUWJqdFNrUiszY0VO?=
 =?utf-8?B?N25vVWtUV04vd0lXMDJQSmQ4ai9pV2VmSFlzakxocndSbUZDT0dZMGRDNnBB?=
 =?utf-8?B?RzF2bE1tQlRoaDEwMVZ2VWZTUzVoSWF2ZjVlUURVeFZBUEZKaXRQOTRWbUpw?=
 =?utf-8?B?YnU0V3dsTFdXZHdVd1dwcHRWOFRoMk1DOEdnblhCOWJqWG90R214TzZrMllq?=
 =?utf-8?B?dzNqK0JVKy9FRWFwK3BBOCtCY1FCQ3ZFRGFYYURQSFhUMmxaeWtqM2VKdk45?=
 =?utf-8?B?L0IycW0vNHQxKytaOHFGeWErNTd6a0Z5RG42aHlzUStGN2Q2SXU1NHQycFJ5?=
 =?utf-8?B?N2tlV3JOTjVUeUE1WkVHMndObkRzU3A2NzAybnlCUGdXZjlJYURDRzFsVXNQ?=
 =?utf-8?B?TUpIN1dkbkNNSHZPSlhTRzNkYjFVUUV5VFlrS0R0Szd3SW1abnloU2dOVlht?=
 =?utf-8?B?T2JaREgzNlViTU5jOTJ3ODdKeWthejBzeld5cnhUckNwS0xUS1B1ZVNyZWEw?=
 =?utf-8?B?V3NOYnhjd2dxUjc3ZmIrVWpZRExUcXZsLy9Tb3AwOTZ4Y1Z3QlhKSHIrMmdE?=
 =?utf-8?B?SzJlMkExSG0raFB3Y0NKWFR4SlpLSjhFZ0NFTVNmUkx3U3J1SVhYS1FtcU5P?=
 =?utf-8?B?bWZzOFJ1RGUyV2U5T1pKZ3dNV2Q1MTJ3aTJLcUdqYlFkNU1mZ0o2ZDQ4LzJ1?=
 =?utf-8?B?RGdoUnRuV0YxVEw4Mk5JUmFkNjkwWGN2ODJyL2Fjc29RdEhvTW9VK0JIbnY3?=
 =?utf-8?B?TUFLbDc0WUFER2tFRW0vZ2l5dUxGcDVyR0k1cFc5d0VRK3ZpaS9QSGhPeWt3?=
 =?utf-8?B?MWUvYUJQSzB0K3ljUGw4S2wvMVBvdFNZZUlwSDF3cjN3QmZrUy9HZVd5ekV1?=
 =?utf-8?Q?vPqJE+0rc3/W/zAySQSKBY1uEENyoh+q95dF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkQ2ZWZ6aVdOMEovMUl1SlhQWDcwYlBsdmRZdDV1aDlybjRvSlN1dXlLQ3pu?=
 =?utf-8?B?dW5nZjYxL3ZUZXNhdnNrQTIxdzFVMDZ2WEo5Qm5UYVU4VHRrL0E1M3M5SVlL?=
 =?utf-8?B?UlFCTzFqenhaY1UxUU1mNWhRbG9yM2NXZkdtWXdrQlNneEptM1d2Tmd1RjNr?=
 =?utf-8?B?WTZVbWx4QXd6L09JaWtKcG1HL0toV0dwZXYvZ1JtSDVCOTUvekxIclBKUDFY?=
 =?utf-8?B?bk5Pdk1qQlNXWjhFSkppeTVXUGJ3SmowRnlDTWJRTGxseEZmQitEa3hva2Rp?=
 =?utf-8?B?ZUp2Rkx4QkJ3WVlsUU9FcHRyRVQvYWlGK3JjWTZqOUUvTm8rLzBmUDJiYmJz?=
 =?utf-8?B?anBDWXM5ZzNVQzR4eDl2aGpZR1FRVjZMYlZKRmswSGlURE1taVJCQmxnTDhJ?=
 =?utf-8?B?eW95MXZQcUVBRnRiekJlNGFYSzArT293QzdTNUJMdGtxTjloY1gxV1g2WHIw?=
 =?utf-8?B?enc4UCtydHNibk1aeitNQXdQSXB3ZGRkMGhoWXFETlNoS0RrQlZzOVFUUzNt?=
 =?utf-8?B?Sm1JME1Qd0xOaUVkZ3gxL0tNeXJDUjhkUlVZWXBTU1BVUVVhMlFjSkpyY2ZD?=
 =?utf-8?B?MVNHVFA3cnZNODF6QzI4SGsraCtLQkVGVG1ESjlGSjA5YnFHbkhQQ0h0Vmlw?=
 =?utf-8?B?T0l6L3pDSFJ1ZnZQbzZDKzFsMU1Jd0h6ZE40N0w3OGlEVVlPd2ZuVWw0Q0JI?=
 =?utf-8?B?TE10YUc1aWJqZVVsVTlET0FxWEwxVExpQkZmV0JsK2R0Z0JiVmorQUZpdnBU?=
 =?utf-8?B?THh6V2xJc05sNFkrNDVDOERFeVY1Q0x2MkNhRFFOdWoxSWNCK3NuMFpuc1JL?=
 =?utf-8?B?VzB2cTUwckRab0gzN2pOVlF4cHZqU00vejJETmRnRWlTdVBBbnVPNjQ4TXl4?=
 =?utf-8?B?UUFVMWdkdXlLZUtJR2JHRWtVM25CQ3RJYzlwMWZOMjh1OVBReFBYV3kzWUxG?=
 =?utf-8?B?ZURSK1BvYWNzczh4YkIxdEpEVVJmSlBXaEhPMytsNVBiR3FGSmdoQjJBbVNQ?=
 =?utf-8?B?RmFYdndQRHlhMTFuRGh3azZ2R3ZlOXJjVmQydHlVNW5LMTJRdUFwLzdtaUhV?=
 =?utf-8?B?bVorVlhvb0JBRFRqWjgrbS9pOUhaamxOQmdYZm5VcndoNUFSck5OYndlMVFw?=
 =?utf-8?B?MmF5cEFOdnVHUklMc3RFRTgxTVlOV1VjZkpHTkZJeGlOWS9HVCt2VHNHeEp1?=
 =?utf-8?B?ZFJXZE9UVExmWlpzdU0rOEZVWWJMMElhOVIwcHlHWHN1d1JnZE9sTm5IOFlY?=
 =?utf-8?B?dFFYdUhIcllaK2xnNm1XZldralducVNQU0tiNGczVW51eDhBbmUzSndOZW1r?=
 =?utf-8?B?RjBnSVNTd2xNK3ZxWHBmRGxEUXpmZE03aXFEa3FvdDVNQ1F2aHo5cHYzcHZa?=
 =?utf-8?B?OTluZ3Y5ODVpKysyNEZYV3ptR0h0dENTYzdWTUVDLzhQVy9hN1RlK0RFNXcx?=
 =?utf-8?B?NGYybGk1SVZhMC9KdXAyQkZtWW81OFdWUVcxYVNrR0h1d0hnd3dhNDNxWDFy?=
 =?utf-8?B?ZERKbEliU3EwcGFSUUVWekgwSFdjZ3A3RG8vSFNaaGo5MUZFNVQwd2VTVHBh?=
 =?utf-8?B?bW1ENEs0TEdoNS9WRDNVcStwR1RpMU1ocmlDQnZHY2YxMlVWQXhiNTVlaUww?=
 =?utf-8?B?NDJYck94RWUwMDJuQ0xvZXJ0RlhscGY3VTk0YnV5VldXVENaRFZZY1hLamNt?=
 =?utf-8?B?eVdFMEQ1SGpxV1FtZm9YMHRsenNkM2JqajlkTTF1OUNTTm1nbGtWSHhKenNq?=
 =?utf-8?B?bVphb1BObk9SU1dIQm4vbkNYTEJ3Rk0weWdhVlRBb2NzNTZxZ3hPMEVRR1BM?=
 =?utf-8?B?VUJRZGRjLytNS3hTVGVLeDdoNlEwLzRkcUVxSVZGenU0VzI2ZjQxbnNySThL?=
 =?utf-8?B?QUo3bDRmWllmaEJWYnZsWU9XK3c4MWdvQ0M4RXJZK3BUendWRHJTQVJ0Umdl?=
 =?utf-8?B?clpDSUhuRm9tQlFZb2dzTUp0NklPOFIyTVRmTktySlRWUDNLeHp2MnBjYlhn?=
 =?utf-8?B?blhqQlh1OHNhVUgzS0tNVXJuNXI5UUkwNEdobkcvZG1ma3VTTWszRDl6NzI0?=
 =?utf-8?B?UGNwRlNFREJ2aEZEdzRZN2RnWkliYVFoT0M2blExUERQMU51K05KMTVLZThT?=
 =?utf-8?Q?WkuLc7WWptqaPDDDE7oA/0ZCp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cad9d9-0ade-4b92-98bc-08dcf6eca9f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:05:50.6452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYFqh6YlpU2imLbkUUpuDY4ULXPYLow5guvzrPgHtgOUAhcXwoXl757A3KQ1oYUlCU8+ROIOf4vy3f33yAp4FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391

Correction. This applies to the following base commit:

8cf0b93919e1 (tag: v6.12-rc2) Linux 6.12-rc2


On 10/25/2024 4:02 PM, Terry Bowman wrote:
> This is a continuation of the CXL port error handling RFC from earlier.[1]
> The RFC resulted in the decision to add CXL PCIe port error handling to
> the existing RCH downstream port handling in the AER service driver. This
> patchset adds the CXL PCIe port protocol error handling and logging.
>
> The first 7 patches update the existing AER service driver to support CXL
> PCIe port protocol error handling and reporting. This includes AER service
> driver changes for adding correctable and uncorrectable error support, CXL
> specific recovery handling, and addition of CXL driver callback handlers.
>
> The following 7 patches address CXL driver support for CXL PCIe port
> protocol errors. This includes the following changes to the CXL drivers:
> mapping CXL port and downstream port RAS registers, interface updates for
> common restricted CXL host mode (RCH) and virtual hierarchy mode (VH),
> adding port specific error handlers, and protocol error logging.
>
> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/
>
> Testing:
>
> Below are test results for this patchset using Qemu with CXL root
> port(0c:00.0), CXL upstream switchport(0d:00.0), CXL downstream
> switchport(0e:00.0). A CXL endpoint(0f:00.0) CE and UCE logs are
> also added to show the existing PCIe endpoint handling is not changed.
>
> This was tested using aer-inject updated to support CE and UCE internal
> error injection. CXL RAS was set using a test patch (not upstreamed but can
> provide if needed).
>
>  - Root port UCE:
>  root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>  pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>  pcieport 0000:0c:00.0:    [22] UncorrIntErr
>  aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>  cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
>  Kernel panic - not syncing: CXL cachemem error. Invoking panic
>  CPU: 1 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x27/0x90
>   dump_stack+0x10/0x20
>   panic+0x33e/0x380
>   cxl_do_recovery+0x116/0x120
>   ? srso_return_thunk+0x5/0x5f
>   aer_isr+0x3e0/0x710
>   irq_thread_fn+0x28/0x70
>   irq_thread+0x179/0x240
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_irq_thread_fn+0x10/0x10
>   ? __pfx_irq_thread_dtor+0x10/0x10
>   ? __pfx_irq_thread+0x10/0x10
>   kthread+0xf5/0x130
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x3c/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Kernel Offset: 0x29000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>
>  - Root port CE:
>  root@tbowman-cxl:~/aer-inject# ./root-c[  191.866259] systemd-journald[482]: Sent WATCHDOG=1 notification.
>  e-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
>  pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
>  pcieport 0000:0c:00.0:    [14] CorrIntErr
>  aer_event: 0000:0c:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  cxl_port_aer_correctable_error: device=0000:0c:00.0 host=pci0000:0c status='Received Error From Physical Layer'
>
>  - Upstream switch port UCE:
>  root@tbowman-cxl:~/aer-inject# ./us-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
>  pcieport 0000:0d:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00400000/02000000
>  pcieport 0000:0d:00.0:    [22] UncorrIntErr
>  aer_event: 0000:0d:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>  cxl_port_aer_uncorrectable_error: device=0000:0d:00.0 host=0000:0c:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
>  Kernel panic - not syncing: CXL cachemem error. Invoking panic
>  CPU: 1 UID: 0 PID: 148 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x27/0x90
>   dump_stack+0x10/0x20
>   panic+0x33e/0x380
>   cxl_do_recovery+0x116/0x120
>   ? srso_return_thunk+0x5/0x5f
>   aer_isr+0x3e0/0x710
>   ? free_cpumask_var+0x9/0x10
>   ? kfree+0x259/0x2e0
>   irq_thread_fn+0x28/0x70
>   irq_thread+0x179/0x240
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_irq_thread_fn+0x10/0x10
>   ? __pfx_irq_thread_dtor+0x10/0x10
>   ? __pfx_irq_thread+0x10/0x10
>   kthread+0xf5/0x130
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x3c/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Kernel Offset: 0x24c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>
>  - Upstream switch port CE:
>  root@tbowman-cxl:~/aer-inject# ./us-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
>  pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
>  pcieport 0000:0d:00.0:    [14] CorrIntErr
>  aer_event: 0000:0d:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  cxl_port_aer_correctable_error: device=0000:0d:00.0 host=0000:0c:00.0 status='Received Error From Physical Layer'
>
>  - Downstream switch port UCE:
>  root@tbowman-cxl:~/aer-inject# ./ds-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
>  pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
>  pcieport 0000:0e:00.0:    [22] UncorrIntErr
>  aer_event: 0000:0e:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>  cxl_port_aer_uncorrectable_error: device=0000:0e:00.0 host=0000:0d:00.0 status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
>  Kernel panic - not syncing: CXL cachemem error. Invoking panic
>  CPU: 1 UID: 0 PID: 147 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x27/0x90
>   dump_stack+0x10/0x20
>   panic+0x33e/0x380
>   cxl_do_recovery+0x116/0x120
>   ? srso_return_thunk+0x5/0x5f
>   aer_isr+0x3e0/0x710
>   irq_thread_fn+0x28/0x70
>   irq_thread+0x179/0x240
>   ? srso_return_thunk+0x5/0x5f
>   ? __pfx_irq_thread_fn+0x10/0x10
>   ? __pfx_irq_thread_dtor+0x10/0x10
>   ? __pfx_irq_thread+0x10/0x10
>   kthread+0xf5/0x130
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x3c/0x60
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Kernel Offset: 0x19c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>  ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
>
>  - Downstream switch port CE:
>  root@tbowman-cxl:~/aer-inject# ./ds-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
>  pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>  pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
>  pcieport 0000:0e:00.0:    [14] CorrIntErr
>  aer_event: 0000:0e:00.0 CXL Bus Error: severity=Corrected, Corrected Internal Error, TLP Header=Not available
>  cxl_port_aer_correctable_error: device=0000:0e:00.0 host=0000:0d:00.0 status='Received Error From Physical Layer'
>
>  - Endpoint CE
>  root@tbowman-cxl:~/aer-inject# ./ep-ce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000040/00000000 into device 0000:0f:00.0
>  pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
>  cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
>  cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00000040/0000e000
>  cxl_pci 0000:0f:00.0:    [ 6] BadTLP
>  aer_event: 0000:0f:00.0 CXL Bus Error: severity=Corrected, Bad TLP, TLP Header=Not available
>  cxl_aer_correctable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Received Error From Physical Layer'
>
>  - Endpoint UCE
>  root@tbowman-cxl:~/aer-inject# ./ep-uce-inject.sh
>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00040000 into device 0000:0f:00.0
>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
>  cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
>  aer_event: 0000:0f:00.0 CXL Bus Error: severity=Fatal, , TLP Header=Not available
>  cxl_aer_uncorrectable_error: memdev=mem1 host=0000:0f:00.0 serial=0: status: 'Memory Byte Enable Parity Error' firs'
>  cxl_pci 0000:0f:00.0: mem1: frozen state error detected, disable CXL.mem
>  cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port2
>  cxl_detach_ep: cxl_mem mem1: disconnect mem1 from port1
>  pcieport 0000:0e:00.0: unlocked secondary bus reset via: pciehp_reset_slot+0xac/0x160
>  pcieport 0000:0e:00.0: AER: Downstream Port link has been reset (0)
>  cxl_pci 0000:0f:00.0: mem1: restart CXL.mem after slot reset
>  devm_cxl_enumerate_ports: cxl_mem mem1: scan: iter: mem1 dport_dev: 0000:0e:00.0 parent: 0000:0d:00.0
>  devm_cxl_enumerate_ports: cxl_mem mem1: found already registered port port2:0000:0d:00.0
>  devm_cxl_enumerate_ports: cxl_mem mem1: scan: iter: 0000:0e:00.0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
>  devm_cxl_enumerate_ports: cxl_mem mem1: found already registered port port1:pci0000:0c
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4500
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4500
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  <snip>
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  __cxl_pci_mbox_send_cmd: cxl_pci 0000:0f:00.0: Sending command: 0x4102
>  cxl_pci_mbox_wait_for_doorbell: cxl_pci 0000:0f:00.0: Doorbell wait took 0ms
>  cxl_bus_probe: cxl_nvdimm pmem1: probe: 0
>  devm_cxl_add_nvdimm: cxl_mem mem1: register pmem1
>  pcieport 0000:0e:00.0: RAS is already mapped
>  cxl_port port2: RAS is already mapped
>  pcieport 0000:0c:00.0: RAS is already mapped
>  cxl_port_alloc: cxl_mem mem1: host-bridge: pci0000:0c
>  cxl_cdat_get_length: cxl_port endpoint4: CDAT length 160
>  cxl_port_perf_data_calculate: cxl_port endpoint4: Failed to retrieve ep perf coordinates.
>  cxl_endpoint_parse_cdat: cxl_port endpoint4: Failed to do perf coord calculations.
>  init_hdm_decoder: cxl_port endpoint4: decoder4.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
>  add_hdm_decoder: cxl decoder4.0: Added to port endpoint4
>  init_hdm_decoder: cxl_port endpoint4: decoder4.1: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
>  add_hdm_decoder: cxl decoder4.1: Added to port endpoint4
>  init_hdm_decoder: cxl_port endpoint4: decoder4.2: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
>  add_hdm_decoder: cxl decoder4.2: Added to port endpoint4
>  init_hdm_decoder: cxl_port endpoint4: decoder4.3: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
>  add_hdm_decoder: cxl decoder4.3: Added to port endpoint4
>  cxl_bus_probe: cxl_port endpoint4: probe: 0
>  devm_cxl_add_port: cxl_mem mem1: endpoint4 added to port2
>  cxl_bus_probe: cxl_mem mem1: probe: 0
>  cxl_pci 0000:0f:00.0: mem1: error resume successful
>  pcieport 0000:0e:00.0: AER: device recovery successful
>
>  Changes in v1 -> v2
>  [Jonathan] Remove extra NULL check and cleanup in cxl_pci_port_ras()
>  [Jonathan] Update description to DSP map patch description
>  [Jonathan] Update cxl_pci_port_ras() to check for NULL port
>  [Jonathan] Dont call handler before handler port changes are present (patch order).
>  [Bjorn] Fix linebreak in cover sheet URL
>  [Bjorn] Remove timestamps from test logs in cover sheet
>  [Bjorn] Retitle AER commits to use "PCI/AER:"
>  [Bjorn] Retitle patch#3 to use renaming instead of refactoring
>  [Bjorn] Fixe base commit-id on cover sheet
>  [Bjorn] Add VH spec reference/citation
>  [Terry] Removed last 2 patches to enable internal errors. Is not needed
>  because internal errors are enabled in AER driver.
>  [Dan] Create cxl_do_recovery() and pci_driver::cxl_err_handlers.
>  [Dan] Use kernel panic in CXL recovery
>  [Dan] cxl_port_hndlrs -> cxl_port_error_handlers
>  [Dan] Move cxl_port_error_handlers to pci_driver. Remove module (un)registration.
>  [Terry] Add patch w/ qcxl_assign_port_error_handlers() and cxl_clear_port_error_handlers()
>  [Terry] Removed PCI_ERS_RESULT_PANIC patch. Is no longer needed because the result type parameter
>  is not used in the CXL_err_handlers callabcks.
>
> Changes in RFC -> v1:
>  [Dan] Rename cxl_rch_handle_error() becomes cxl_handle_error()
>  [Dan] Add cxl_do_recovery()
>  [Jonathan] Flatten cxl_setup_parent_uport()
>  [Jonathan] Use cxl_component_regs instead of struct cxl_regs regs
>  [Jonathan] Rename cxl_dev_is_pci_type()
>  [Ming] bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_uport) can
>  replace these find_cxl_port() and device_find_child().
>  [Jonathan] Compact call to cxl_port_map_regs() in cxl_setup_parent_uport()
>  [Ming] Dont use endpoint as host to cxl_map_component_regs()
>  [Bjorn] Use "PCIe UIR/CIE" instesad of "AER UI/CIE"
>  [Bjorn] Dont use Kconfig to enable/disable a CXL external interface
>
> Terry Bowman (14):
>   PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct
>     pci_driver'
>   PCI/AER: Rename AER driver's interfaces to also indicate CXL PCIe port
>     support
>   cxl/pci: Introduce helper functions pcie_is_cxl() and
>     pcie_is_cxl_port()
>   PCI/AER: Modify AER driver logging to report CXL or PCIe bus error
>     type
>   PCI/AER: Add CXL PCIe port correctable error support in AER service
>     driver
>   PCI/AER: Change AER driver to read UCE fatal status for all CXL PCIe
>     port devices
>   PCI/AER: Add CXL PCIe port uncorrectable error recovery in AER service
>     driver
>   cxl/pci: Change find_cxl_ports() to non-static
>   cxl/pci: Map CXL PCIe root port and downstream switch port RAS
>     registers
>   cxl/pci: Map CXL PCIe upstream switch port RAS registers
>   cxl/pci: Rename RAS handler interfaces to also indicate CXL PCIe port
>     support
>   cxl/pci: Add error handler for CXL PCIe port RAS errors
>   cxl/pci: Add trace logging for CXL PCIe port RAS errors
>   cxl/pci: Add support to assign and clear pci_driver::cxl_err_handlers
>
>  drivers/cxl/core/core.h       |   3 +
>  drivers/cxl/core/pci.c        | 180 +++++++++++++++++++++++++++-------
>  drivers/cxl/core/port.c       |   4 +-
>  drivers/cxl/core/trace.h      |  47 +++++++++
>  drivers/cxl/cxl.h             |  10 +-
>  drivers/cxl/mem.c             |  29 +++++-
>  drivers/pci/pci.c             |  14 +++
>  drivers/pci/pci.h             |   3 +
>  drivers/pci/pcie/aer.c        |  99 ++++++++++++-------
>  drivers/pci/pcie/err.c        |  54 ++++++++++
>  drivers/pci/probe.c           |  10 ++
>  include/linux/pci.h           |  13 +++
>  include/ras/ras_event.h       |   9 +-
>  include/uapi/linux/pci_regs.h |   3 +-
>  14 files changed, 396 insertions(+), 82 deletions(-)
>
>
> base-commit: 739a5da7ed744578a9477fb322f04afecafca6b0


