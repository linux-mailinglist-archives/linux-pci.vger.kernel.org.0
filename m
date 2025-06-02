Return-Path: <linux-pci+bounces-28786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 205E3ACA8A8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 06:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DECE189A851
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 04:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8989D13B797;
	Mon,  2 Jun 2025 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JnApozp/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21552AD2F
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 04:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748839929; cv=fail; b=CPALY4GrdMa28NMLtAK4HB5cWHn40T5Ud0xmHV9JrokXgNkxLl9ELE8HjmQN9aSJSlvbfkWKTpy4VYod2deDl6mWtIF41JzreqkLIsHXBo3qIrQGXKUI9WcAnI4Aqh/eH3HdscZWdRMB0Oc1VlaMrYU1UfrO6TXX+LhJEidywTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748839929; c=relaxed/simple;
	bh=YtDIPKxO1emQxzTSaPC+3BvhxGhcHciFq9RKXa8Ez7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nlolsDfmz8YyQdcouWET9+5+qe9xVufCMyPAErAaY6cwBqAK4FmXGKJz1I4GGY4GMwZ7mEKoYIa1D8ACY7E9reWTZSWNP8pM0CizRfEuDAxnOMy3LbcUb9s8RJQA/9LIPkPfax03++K+tO5nYPYIxVxI8tiM/rbylUBSQd1ehXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JnApozp/; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU28zFpSkRAJ6UxWG8qHh8NCOGT0sDo9nih2ZdeGHFs52rDNHr1aaNwzsfDIlXMzjZ/slsQtNYuPPK2z9crmx1hrdKlorEHPKHppDdrX/Us+I+d7A1iNOhg3F3d1TPKerLx0eq3kIeF30UjTYNLuQhzo2aOPVbnhc9cHGdnvUqg6rV5ZsVBmsoHgTcyGKYTsHn5lrJDQPctmBVjPs01UWoNPLscBoMeDTc0LHCoeIwbF1rQUnbLAghP40wsVAV8HveEkzDyupKFd6gS6+oBkeEg7N01fGh6+1GumtHIS+ZyEELdtWx05y9o3ZNfeDL9fwN/Cq9BHdvhadIR5nzQBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN7dlmvoytO/RYqTAxbcS45cg+wuEANFSQioiqS4XHY=;
 b=iE8csDVq6z/lOcrfxbe4kfh7AvEOi8pB1e+/sJyvTNd0ZLnHNS4KQ6mr4yr04wWEGvS0icnnocIpLZK+G1LJ5hp3NcKgaTk4jjw0WrL8nzFUJLYUy1E9lbnxkFQSmYJdzYnk5ALS6HPO+6jHytBJsOlQcEAIE4HZBxNVvG92wWP4repWcZHbjWa/CoN16oK3hOTUs9QsZ2wLbByp6FnL3oHfv6EL5d1qKOBsvTiJq3jDNgrp7D6Hgjwv7FHH3n+gs3JrFyJ9+hVCixr3Fx47OUdJTaSANwBW3XyXdFwkxaG4BdmNo60e3tfzNZvCWV7iWyY5BLVr0eHVpH93iiVa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN7dlmvoytO/RYqTAxbcS45cg+wuEANFSQioiqS4XHY=;
 b=JnApozp/QpsiRtT03/3iCVOfv9Vc6kZAf3keGLhZVxe/wSBApRqkV7BzraXpt1WM/dKFd2Et0lHNz+Vj2yi2Mc8fd0/2j2NcS6yOi5/5f/SljcnHdKU4ENuxy4Xox5+H6r2EGmjyYYFElNT+ILUCmyscopGmWjJYtwd6CkliLL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Mon, 2 Jun
 2025 04:52:05 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 04:52:03 +0000
Message-ID: <80277929-ce8d-4cef-98ed-c5280fdfa543@amd.com>
Date: Mon, 2 Jun 2025 14:51:53 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com, sameo@rivosinc.com,
 jgg@nvidia.com, zhiw@nvidia.com
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
 <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
 <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
 <2fb2de7a-efc2-4ab0-8303-833dd2471d9f@amd.com>
 <aDhtLn2ySm/pgeab@yilunxu-OptiPlex-7050>
 <4b3621d7-4bed-44c7-8139-57de5825e968@amd.com>
 <aDsfmJpUqy53dans@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <aDsfmJpUqy53dans@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0119.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 83093965-efbf-4cc0-5f73-08dda191378b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkJJTExtQ09MNFo5RjhCRDRNNEVRbXZjcjhOais5MlhEOXRaUkkySEJWVzJM?=
 =?utf-8?B?SHNDS0N0T1VpMlZrUjN2NXcwamVGOGFFcGY2NVpqN3BiZkZqZ2Z6Z2xqN05L?=
 =?utf-8?B?TFRNN2JvbVU1YllWYlNpQUJVTDZCSi9MS1YvcnlvcjZwcVo4OStYblY2bDRn?=
 =?utf-8?B?TGk4bWxKeXExZ0RoT1A0a0p2dkFUWlJyci9JanppbFdNa1k5MDNBT09HOEpp?=
 =?utf-8?B?ZTVjSVNxREpvKzY4K21RTjBabUhPNkduMlVnVGRtQUI3Slp2NnZpK2xKMHc1?=
 =?utf-8?B?bGY4RXZNOUQwTWRuYlc4RTk2NDhDWVh1VDZFVzQvQTkxVjZKRjFxOVZnU3lo?=
 =?utf-8?B?aHAwcWdnaXpiZW9RSHEwSVJycFkrbXpVNzhkSFBrS2x2WlViT1hpVGUxdVNZ?=
 =?utf-8?B?QmpQRHZmMXJSMTRrMzVqUXgxT2Z2bXRNQkMxWERpWm1uZktPZDVPRFJ2YzVP?=
 =?utf-8?B?VEZoMGM5WFkxRFhncUNKR29PT0RpZTNBSE5kUFNoSE1mWGdsU0VBanIyVnVM?=
 =?utf-8?B?MFV0ZjE2VmN5UHBsWHVBc2NVL05PcVpkZnp6bVJkUURWeldGNlZzUXZ6WWti?=
 =?utf-8?B?Rmxtem51SElBY3hUWWxKUnZpZmhQVnRNUjEwa3Rudyt3cytJYThhdFNFeXBm?=
 =?utf-8?B?NHhUNXJJWmp2L1R5NG1DWW5WK0EvRjJXR01ZZU4xSHVRVmZMZCtKdlphOGxn?=
 =?utf-8?B?YmRhcDlXUFhZSDZBNkV0SmhVSzRrSXlWMXg1T0lzdE5ldjZkSU13Q21qNnB1?=
 =?utf-8?B?Z0txZ3p5K3I5OEUwdFg2K2RMeWNyUHVxcWJScm1kcWtGVjY1YzIvTUxpakFN?=
 =?utf-8?B?OVFra3Z1ZjNDUHErYk82Ty9teVVkbkdYQjhFRERFVjZGV0k4ZytEZDlUbVNs?=
 =?utf-8?B?TjEzMW83R2hkYjVhL080blJnLzlYaTF6anNoOFBpQkxSejRmL1QvKzRJb0Qr?=
 =?utf-8?B?Y3U2bXhHcy9wYjNlY3pvZU9YOWN6SWM2QWV4bk90TzdlV3htck9LQTQxd081?=
 =?utf-8?B?bmp6S3o1QVhaUmc1eWZWMHU0eWhjYTJ0V0Y1aWsxdzNoMWFVbmNOSEg3SVdW?=
 =?utf-8?B?RmxoTjQzZFo4NWx5dTdENTN1cysySEcwem5jaHkwMDJOSUdCdWJpeVF6YWNo?=
 =?utf-8?B?a3BvMGVyNmNpbkU0OEc4eUFuVGhLRTFadTNQNnRJUjBVeUVsTjZoTlJDT0pM?=
 =?utf-8?B?aHVZK2QyN3hjajZsZHVoL0svVVRoK25YTXFMbEVDR2JUTGYxTC9acVV2Rmxk?=
 =?utf-8?B?UDhaZ1NRZld4OVRPUkNCNVNQM0g0T21VUWViN2tHV3NCYkwvcXRnazZydjh3?=
 =?utf-8?B?THdLek5PYzU0Vk82ajFPdlhjRG1FSEhPMkwyREVxVWNxOEFmSExDVFMxVllG?=
 =?utf-8?B?bEs2QTVVUUFYcTFRWUJSbXV5NGZVUndnZm1yakgxUFBPaFJMcFhWNFd6YjNS?=
 =?utf-8?B?R3dnanlaQ2F2ODhOVUdJa2J4d2trOGxBZGEwWkxDUlJ6QWpnRmEvYXNUNWtX?=
 =?utf-8?B?Sk5iMFlYU2dxeVRlUFRQeEJEWGlUUWM1UVQ5L2d5QTAyRjlNbVB4TThVOG1T?=
 =?utf-8?B?RUNkUmdqMm1uSkJ4WXcwVXZLZkxsNGNKQkFwQTJCS1AvdnMwWjBYdmVPNTQ4?=
 =?utf-8?B?RnFqNEIyYmROak9JeXdyM2JNT2RLVy9NbDNhOXdrLzNZVWVPQ0IrU2hSYXFr?=
 =?utf-8?B?amFubCttUFQrRTNNZ0Z3dStUMCtwRGNVdGhsa3MreEdFSnl3WGtoVVpYTVFT?=
 =?utf-8?B?bVNCcWMxcENBd2xMQ0VaWkgxOW1pSEMzNUFXSTQ3dWNWSWVWTEhWdEZ4Q3dy?=
 =?utf-8?B?RkNvb3krS29HdkJ4NHR2RllLK1RHemNrQUxWbVZsbktVYmVJYXNVL09BTEZh?=
 =?utf-8?B?NTlKckRVS1B5RUFzVzQ1Z1l6UE1VRUFaNHJNUXo4MmdhUDlUN09Na0NMU2pY?=
 =?utf-8?Q?c7NhIZANHfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REZpaUJ3Rko4VVp0ZFRHYklRd2xtbENrOFpGaC9jb3RpbEx3amlqOEx0SFlD?=
 =?utf-8?B?eEJsalpOM0NibENhYjVHMEZQcHROYlFaUzR6c3lrbWI4NjN2U1ZBSXR1VUxa?=
 =?utf-8?B?OUl4eldFSiszVlVURVp6Yk05VXc2TTVkMjB3c1QySmo5K0UxdWVsRldVKy9N?=
 =?utf-8?B?KzNlQXUxMXJJR1lDREV6Qk02U2JVclMvcDZycnhRQUNpOUhsVlpxQWVmZ2NP?=
 =?utf-8?B?SVNpeVBPRjlIS3hCK3Q2cThRYWZ0a0hkRzlQV2lDR2szWUhUZG5BaFNsdVpK?=
 =?utf-8?B?YktxRUlrbHQyYkFpM3I0eHdkYkVoNHVnT0dySE9jdi90UFJwbXprNWozckd1?=
 =?utf-8?B?RXhha1lFSDNMRkRCOENwdmFodVNUbUVPMzBsWWpsYUNZQ0FWdVZTcFhHLzUx?=
 =?utf-8?B?TXhqK3p2d1huOGNhcnRvc0M3QytaSlRpY1krZDluRklEa0U0YVAwVVIvdThW?=
 =?utf-8?B?ODNyQW9WS09SN2xBQlV0VHhaMTM2REhIVEJYTkFRZmU0NUJnSjBGTzFkME55?=
 =?utf-8?B?ZVp3MEVFTkI1SGxtYlZ6THQrdDZtVGcydG53Vk0wVnFRNHZITHdaNXlBOGlx?=
 =?utf-8?B?dnRPOXF1Q01DbTF2dHpuaE5jQ291K2hEQjNMOEhHK3E4MjI2UWxyUW5GMkEr?=
 =?utf-8?B?aDFCbm1aZGRScGV4QWFmekFrd2g5WHFNbld5TEJtRmkzc1JaelNjNnhHcm9j?=
 =?utf-8?B?M24vMGVUUzdSR2N1Qk16M2FBSVhSVDVsbkdveEFBdmJoTEsxZEUwSVUwV0pr?=
 =?utf-8?B?OVBCN2JCcktNWlhrenFacThSaGJwd3J4MDJQQjkrRC9xR3NHRjlub0VudWcx?=
 =?utf-8?B?c1lUNUF0VUltMnFRKy9aYnVDM2xTa05vTDVFcjdkYllkQTZjZWdxdHZ1SFpS?=
 =?utf-8?B?anVwa1hGa3NuaitFVVg0L0UyMHdFYVNUekhJR215akc3Z2dselAvYjNxNFo3?=
 =?utf-8?B?YVhXMHozT215UlBSRFdRYlFUNnFiWll0VlRKSzEvWGNKL3VxTVNLdXU1cFF2?=
 =?utf-8?B?M09JbE9ud1hrZURYUHkyR1g4QnhnTFpNRXFtbEJHZXgzVndCc0FkSU1KbmJm?=
 =?utf-8?B?SFZwYXJSSlhrTU5aUnNkS3ArU0xZL3dld3FGUkFJUndsdUk3dk9WUElqaW1N?=
 =?utf-8?B?VlFQZHR3dVhUc3dHNDBCeHl3OGlmd056cjZOcFhvSGZYSE5NVXhjQUFCN1d6?=
 =?utf-8?B?SGJadlYrNmtxc05nSEhMTDFZS0NDZ3Vxa2RFaEkwZjgra2MwUUE2YTNHdnlW?=
 =?utf-8?B?WmluR3JYaENUUUZCN0tDeGVmaWd5ZExzaTBrNng2NmFDUWxrQTROckUxOVpU?=
 =?utf-8?B?alM4ZDUvSVNzZDR2c2lKNWZyNkZ4dWxKOEF6bjYzUVp4eUpXbEFGVGYrL0ZI?=
 =?utf-8?B?N0dLZnp5KzIzMktEeThmT3N4NlRLVHJwRXFsNm45TkZkOGR6ZHJhdi9wZUJD?=
 =?utf-8?B?Y2VlLzIreWdDZ1AzNThFbHJTUUdQbXE1R1lnZXY3VGRpSHFXVVVITHJyKzJi?=
 =?utf-8?B?emlyNVVvdkNROU1KUkFSSWZTRGxjWGJ1V1NiektkcjJ1eEFNWnFWL0R0cDA5?=
 =?utf-8?B?Zm9aZGRrSmlyNm9aTitRQkZFMlVoMXhPU3pwYlZCVHpZMjIrWCtCQlhTYkdI?=
 =?utf-8?B?TkNQaGtFam1KclVBMWlqbUpKYVlxeXVrU1dkaUIyTE5HWE9qbWcycEhncm4v?=
 =?utf-8?B?eVJPejJZekJseEdDS3hmT2EzRGJKemZJTjJHWnRNTXU0QUlzaGphN3dmcDQx?=
 =?utf-8?B?cjh2a3pINEI3aTFWRzZ0dDhxbmhOdER0TW1QMDBSb3NTcmtwVEZ6QnRqMHhP?=
 =?utf-8?B?b0FRT3JKQ2ZQTmRsRDRzOFl3WE9aNFdCKzdVUjErcStXeGRlU29nZHJUcmNY?=
 =?utf-8?B?cXUvd2IxU0FDM3VQWE40TmlsOTgxWTlXNmcrVkNzb2tYYmg2OE9tV1pCLzRT?=
 =?utf-8?B?dVlJUEN0blI0TEZoUm1LUC9NL0R4NXIzc2JEVktERFlaUkhFQXVQak4wYWFO?=
 =?utf-8?B?RW4xYUJGQ25ud3NUdGJNd3djVGtJbHF3b2MzMTB4L0VscEJ4QWhzdkhoWTdG?=
 =?utf-8?B?czB0N2pZcFZUMWg1NlU2QnVPNmNaTkIvNUwrTDgyeXdUTmtDNjlkU0VQUDI3?=
 =?utf-8?Q?axTMhIn4MAPLjQeGbrNI4a/ZV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83093965-efbf-4cc0-5f73-08dda191378b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 04:52:03.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0H5HRPQAdtRmB27xh8q/KnSHGYsx0xZz7+sdmHC7zZiR23qxtiNXfuTyndtbLjlOGIQdcEaoCgzfztFioKRLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126



On 1/6/25 01:26, Xu Yilun wrote:
> On Fri, May 30, 2025 at 12:54:44PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 30/5/25 00:20, Xu Yilun wrote:
>>>>>>
>>>>>>>> + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
>>>>>>>> + * @type: identify the format of the following blobs
>>>>>>>> + * @type_info: extra input/output info, e.g. firmware error code
>>>>>>>
>>>>>>> Call it "fw_ret"?
>>>>>>
>>>>>> Sure.
>>>>>
>>>>> This field is intended for out-of-blob values, like fw_ret. But fw_ret
>>>>> is specified in GHCB and is vendor specific. Other vendors may also
>>>>> have different values of this kind.
>>>>>
>>>>> So I intend to gather these out-of-blob values in type_info, like:
>>>>>
>>>>> enum pci_tsm_guest_req_type {
>>>>>      PCI_TSM_GUEST_REQ_TDXC,
>>>>>      PCI_TSM_GUEST_REQ_SEV_SNP,
>>>>> };
>>>>
>>>>
>>>> The pci_tsm_ops hooks already know what they are - SEV or TDX.
>>>
>>> I think this is for type safe check to some extend. The tsm driver hook
>>> assumes the blobs are for its known format, but userspace may pass in
>>> another format ...
>>
>> The blobs are guest_request blobs, they enter the kernel via iommufd's viommu ioctl and viommu already has  iommu_viommu_type which is (in my tree):
>>
>> enum iommu_viommu_type {
>>          IOMMU_VIOMMU_TYPE_DEFAULT = 0,
>>          IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
>>         IOMMU_VIOMMU_TYPE_AMD_TSM = 2,
>>         IOMMU_VIOMMU_TYPE_AMD = 3,
>>   };
> 
> That's a good point. So I think we don't have to use a 'type' field for
> ioctl(IOMMUFD_VDEVICE_GUEST_REQUEST). But I didn't see these viommu_type
> would be passed to TSM driver.So for this pci_tsm_guest_req kAPI, is it
> still good we keep the 'type' for type safe check in TSM driver?
This means that we somehow make it possible to create an Intel vdevice for the AMD TSM and now have to catch such situation  in runtime which seems wrong, we should not allow the mix in the first place. IOMMUFD is going to call the platform IOMMU code and that guy will just refuse creating a wrong viommu type.


>>
>>>>
>>>>
>>>>> /* SEV SNP guest request type info */
>>>>> struct pci_tsm_guest_req_sev_snp {
>>>>> 	s32 fw_err;
>>>>> };
>>>>>
>>>>> Since IOMMUFD has the userspace entry, maybe these definitions should be
>>>>> moved to include/uapi/linux/iommufd.h.
>>>>>
>>>>> In pci-tsm.h, just define:
>>>>>
>>>>> struct pci_tsm_guest_req_info {
>>>>> 	u32 type;
>>>>> 	void __user *type_info;
>>>>> 	size_t type_info_len;
>>>>> 	void __user *req;
>>>>> 	size_t req_len;
>>>>> 	void __user *resp;
>>>>> 	size_t resp_len;
>>>>> };
>>>>>
>>>>> BTW: TDX Connect has no out-of-blob value, so should set type_info_len = 0
>>>>
>>>>
>>>> No TDX Connect fw error handling on the host OS whatsoever, always return to the guest?
>>>
>>> Always return to guest. The fw error info (not raw fw error code) is
>>> embedded in response blob.
>>>
>>> For QEMU/IOMMUFD, Guest Request doesn't care blob data, so don't have
>>> to judge fw_error either. Alway return to the guest and let the guest
>>> decide what to do.
>>
>> So whatever is inside such requests, the host is not told about it ever? How does DOE bouncing work on Intel then if the fw cannot ask the host to do DOE? Thanks,
>>
> 
> No, I just say QEMU/IOMMUFD don't care about the execution, so no need
> an explicit fw_err return to them. Platform TSM driver should definitely
> know about fw_err and handle it (to do DOE or anything else) internally,
> but don't have to EXPLICITLY propagate these error code to up layers (TSM
> core/QEMU/IOMMUFD).

On AMD, the host has to provide certain handles along with the guest request/response buffers and the host can get it wrong so the host may want to know if the host did a wrong call. Say, we are killing a guest and by the same time making a guest request - will the Intel fw still say "that's ok, forward the response to the guest", even if it knows it is not possible? Or SPDM session broke - the host OS won't be told until it specifically make a call other than guest request? Seems weird but okay. Thanks,


> Thanks,
> Yilun
> 
>>>> oookay, do not use it but the fw response is still a generic thing. Whatever is specific to AMD can be packed into req/resp and QEMU/guest will handle those.
>>>
>>> But for out-of-blob data, it is the same effort as packing into type_info.
>>> At least we could have a clear idea, which blob is SW defined, which blob
>>> is GHCI/GHCB defined.
>>>
>>> Thanks,
>>> Yilun
>>
>> -- 
>> Alexey
>>

-- 
Alexey


