Return-Path: <linux-pci+bounces-35494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7BCB44B9E
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 04:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B311C81CE3
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 02:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A51DE885;
	Fri,  5 Sep 2025 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OtCknya0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586D3BB44
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039534; cv=fail; b=q6ofJ9Unja+WAmdSh3h9s3xwtWRL4SSlr/+xh52bjjwkBq1r2/BRI3+joKcfVcexnDH8XBSXNKo1XiyHgiJxKh6++nojvN2lTGKUpAcYYopG7/8zVUTRVcfElHscf8CCm1sdNHepvxfTiYGVN1kRfJRmOJ4d2vbCTixeePDaOWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039534; c=relaxed/simple;
	bh=0SDzlLEJuXtcLeMJIfwb1DmFaRmMEJo5+Tuxg6bE/fA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fgxvQCx1jva08aQ6C6/nn6W7rJOGkrECuipXAACFpTFYTZ4X5I5MeJUnC7MZ7Ty80qNdVhe9dAL95kGlieS0hSJ3FAx4p2JLo693EX2Aj3qo7ZUnP0CvVjHn6Y89KF59TS2XChLcngFAd+lBpBIiAK04hTuB5R1DRi3FIRzoUZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OtCknya0; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuSBLDau2WGpZhYZzwWWZQE3eDyAA5J2vBQZnGa25vbJfV46C9VLZwO3g+beuwhrCwzCODxGrBA/3EBOm9xB9I56SkfKhFJbYSSK93t39Z6bxyG/eVBLStb0u0jvy26HX+Qvp4v4lYDEtf0aHMMvalvEbIzXrX3A6kx/XPuqAZMV+Fj3PahM3qs5beqJoUw7J4BTRMGAx/NXtupMTjSruzvABsFF04EBxZAcmUaNYgRYXpI9POMkTHUqCmb6et79XWMg+BV37HwPpJdb96js5QtITCO9wZfsdZO+PXHTXBkRtSF6WGP/5UU6gyzSmrFheEHEwzp4FQResXNcOSZNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3qaOE7xbNw+MIcY50yrMqelDCNT5TNrAoootSoc6g8=;
 b=C0x8g82uWvRp14hnjc6MDcFXkAPXGwZT1y0T5uTTICUJal4Yzc7oE7SUebYaR/BuWiq7wP9BOJmhkzTKRpZCULW8cJtwMSMhUBmj7YriqoQ9Hh1ujspyM6uagVF+GjI2aLbI/KZPsfNtFLBLmRlbgBOwIoj6u7i4iDJEGr2SE+Nx7rfH0VLpXoLA/xlt6ttw9r102qSqp8HQVUtituEG40HyIDZSY0Tz7bRy/3oaaHHxrS1avCH/7rnR55aLZifHdWAnvKy+3IXtkPsQMmGudQU1szT/dfJslT4g7Mh7FL8pofTOAR4Xj+d4xELEHMJPVctJjyAAQvJm+t+w8Lw1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3qaOE7xbNw+MIcY50yrMqelDCNT5TNrAoootSoc6g8=;
 b=OtCknya00MMQQ70K+ER0FR1YxDt2S6SBv9yjTBtx8h3vWnizxRybBGiwDUCwR7SkPUin5At77FzIlDf92KXL4FvBar3/pTm+K8gfgYGGyDRom6ltmcTZNbOBKs1uPH58sjpFeotK0Rnq+7ofRai3nBSnfbIcY8OzC98Mk2yJouA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 02:32:10 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 02:32:10 +0000
Message-ID: <f42925c5-9395-4c32-b26e-115658cdce16@amd.com>
Date: Fri, 5 Sep 2025 12:32:02 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
 <yq5ay0qv1s66.fsf@kernel.org> <9db48807-2a9a-4854-8735-90bfafbaeb6f@amd.com>
 <yq5aseh21ilw.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <yq5aseh21ilw.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eff8f2a-af4b-44f2-b309-08ddec246a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0hOS1RnR3F6R1NpR0htaTBSQ3ZWR2pBTi9VcFZ0VFoxTmtCNHBmZTEvOWZ2?=
 =?utf-8?B?RDRGZTNNenpIUnJ5emlXL1NCNG5yRCszeU1wbS9qdEY5blRhV0NwZEdwaS9m?=
 =?utf-8?B?cXNKdUordFFsaFFhM2pzNlVVSUxlY2NxSENPOTlvT1UxZXFGWmtYUlVNekFK?=
 =?utf-8?B?a2Z6YWkxSkpFMWdua3JIRFVUZ1hkYnhFWnZKVDBXYzJhbnhXangvMVZMaWN2?=
 =?utf-8?B?Z0hMeGNkbTE3cVE5TlROQVlkdGVmV3ZpYXJVMi93YWFkTlJwVmRaS0tGTkRa?=
 =?utf-8?B?WXFIOXJrQUd0VEFUWnBCVlU0Q0thdWlYeGlMTENwRCtVaE5xSWlmNUdjRnFL?=
 =?utf-8?B?TFEzZ3lJbDVLUzA3N0ZPcERFM01CbEdxeGRoRXJvQlJ4SWMyclRMTlFTaUhC?=
 =?utf-8?B?NzE3WlBRd3lmZ2NJSi90NGVlMDg1NG5KS1E1dVBBM2tnZVhXSHJIV0EwUTF4?=
 =?utf-8?B?UlRzeFZ4SEVmTW5UWmtRYVovMmRzNCtXNEVjMGhHUHNCWXZ6aGtMVXFzVFNO?=
 =?utf-8?B?SVEvQUpVMnNINWRkbjdqb0FsRzlvZzZ1b09FbnBtMlFGckFUbTR2eENXNVpj?=
 =?utf-8?B?MnUzM3F1RjArcSt0QXYybFMySFh1VzVIVTJjejBUT0orNnl6dk9Rc2ZMZjY4?=
 =?utf-8?B?b00ySXI3WHJIUVZHRG1oQjdxZUMxQjdMYkxoN1B3NDR1M0txRDlJRjZhem9q?=
 =?utf-8?B?OVhTZ0o5eU5jMTZoY1AvMWwrUDM0NW96aGZ1ckRyUk1qekZPRjFiam1RaVZZ?=
 =?utf-8?B?dHpLWUora3FuUEVmOTRPNk5YK0FVbUFxeTFZZEMvaWRKSGViRnBtVmtaUEFX?=
 =?utf-8?B?RExUYUpUaTU0M2cyT0QzUVBBK3QwVnRtSi8xRkNQeVlvM1EraGpnRGh4L0ZO?=
 =?utf-8?B?amNIOWVKMVZZUFhhSnI3Y09ZR3V6YTVOWHJWZnFEbWt4NE5yTnNaMjExQVVx?=
 =?utf-8?B?bjJSbmUvMnhQL1lvVjU5SDdTcTBVNVJaUHZYZWhTbnN5dWd1b3lzb0dHaUVT?=
 =?utf-8?B?bytqMVN2K296TTlhMEt5Wnp2cE03SWZIN21sMmRyb0N1QUozSktVcEV5bTZl?=
 =?utf-8?B?cE91cHFwRnpaRkNtU0NUT0o1UEhZMjJVeHBVNVJYcUwvTnR5NVJQVkNVR2Uv?=
 =?utf-8?B?VDl1NXdYclJQUEhWZndyNUJVNEIzSHZCTTY5T0FiU0hkUGtBUlFoNUxjTTI3?=
 =?utf-8?B?ZGZZbnM1c1pUZ2ZBOVJVWlRaVkhQYWxmSEE3VHBOV1lUeks0N01mRytmaXJ1?=
 =?utf-8?B?L2V4L1BBMWg0d3QzdzRhWG1yd2JWYUc2bzMzQ3lxd2l1UWJ1NTE5U0FUVCt4?=
 =?utf-8?B?NDAwQTZXY00vVjhSVVlJbTNibWpSTk4ybkFDd1Zrdko4S3EyckRnVmlkQ3Y5?=
 =?utf-8?B?TVZaYm5Gb3hyOW9CazVqeVU4bzdYWWhBMXAyRzBUL1I1a253Ulh4T21FVlVZ?=
 =?utf-8?B?Zm1WMnM1N2dmaXRwWlZUR2VlYTJlL2dmc0pvUDZoeFk4c0djdDczMXViZ0lX?=
 =?utf-8?B?MGZmYW5zWC9tYjZHN2phWkNvZ3F1d1ppc1VMbkx6UnZQM1dhZ3RQK2hlK21S?=
 =?utf-8?B?ZFJ4bDZXaE1MQmlMSDVaNy94NjRZT1E4VGJSM1JhRloxREw5STRoRWNUVFZS?=
 =?utf-8?B?dXIzOG1WVXd3Z2l4bzVCcUc1Ky9qS2lRdzZpR285WjJYa3JBdTU4RHVqajdE?=
 =?utf-8?B?Wmxjayt3VkxqLzE0aGNMMStKV0N0YWw0WVNaUjAyNmdMSlh4dXNsdlVmTmxq?=
 =?utf-8?B?YUVzK2lQRWswc2RyV2FIdTgvZjhQNVFrQmNwWXQyOENqaUtUQ3NGRTdSakJN?=
 =?utf-8?B?dStNc2xUZ3JSVnNwQW1HRGpYSzNCVXBjNFptU0JIL1VjREhwMzlDWUxiN0xK?=
 =?utf-8?B?Sm5VYnUxZEs0bUV2VHNxTjJJY1pQbW5lcG56OGRDY2dSdFRZejh1aDE4UXJZ?=
 =?utf-8?Q?yukbajBiQoI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU1xaUhYaElUUytmODROWnY4RUlEZk9IL0JPdDdKYWpQRnpnaTY0dlg5S3V3?=
 =?utf-8?B?VTVNTVc0MEFWakJMMDVTNjd3L2M3eThzUzNhR29zeXRUbWNtZUNmZ0tNaWd1?=
 =?utf-8?B?NGg3Z2x0YVViN1o3UjNuK2hQSnM4RjB0dTY2aTJySW9HOWJWUHUxM0VwM1RN?=
 =?utf-8?B?L3dFZFBpZERSRnFleGszVlVxNjUzOGk4KzZGS3FaUG0zZThHZHJ4RjVQSEp4?=
 =?utf-8?B?WElqc1hEeWFSbEZXVGJNM0dWUDdweGxaa3p0UXVFWG13a0VxM09ESHVyV0V3?=
 =?utf-8?B?OFhiaEc2aG1rTmpnVTNoUFN2VTU3MU9NeHpPampVb3JSSGxMNEFjSXoxcXQr?=
 =?utf-8?B?bGZZemVBWlhxbC9RMU5oY3M0WmhieUd4OVhMeXNrOE9lSHhOUW5weFlUSWFX?=
 =?utf-8?B?cmNLd2ZYV0pXQnBoVXBFSXlwcGVnWDRreTI2Q0hsZm1sWFltYUFaM2Zrcmtj?=
 =?utf-8?B?YTJadDF1cklYR3ErMzhyRmc3cjF5b3VLUFZKc1dhTUo2K1U5WHlBKzg2eEVw?=
 =?utf-8?B?a2IwRlBaUlNXZVZnQ2JWc3VQd3oyRHRTSU1FekJKNzRWdU9sRFhGOW1veEVM?=
 =?utf-8?B?ZmJUcU5ZbWFseGEwWUhvak1pK3hhUUF4dlVtVVMyOGJVWEJUR3hNMVhOKzd6?=
 =?utf-8?B?MGJxOWFmdGZEL1UzWGlaR0tQYnJCY3JGVFZ0YTh4VmdoNmpnR0w3MWFmcGVi?=
 =?utf-8?B?bDBiWVY0U2doL05Nc25McUYxdldmYzhzMXNUK1lmWkF3NzljVGdISUl6LytU?=
 =?utf-8?B?R3puZ3E2RWxXTW1ncnNTY3NUN24wODdEYVUwR0YzTitVSTA3TExhNlJJaFJ0?=
 =?utf-8?B?RzArK0xySk5BUi9UNGREM2dKeU56U09BNzg1cDZMNWN5Mnp1Zm5ySHFEdmJ4?=
 =?utf-8?B?UHQ0SndwNmJpNGtkd2JaWTFXWmNiRWFsRHRqSGU1clBFa1FtTEhYUDZudlpy?=
 =?utf-8?B?bUtPWGlvNUhwRjFJZUVIWlowS1dNU2xCampoc2h1V1hIVTJTMEZ5ckJPZG9u?=
 =?utf-8?B?REd1MDJVcS93UE9vL1ZpZXlxMWVpM0V1d0U1aTFkM3RkZlNSSUVMUmhETTlC?=
 =?utf-8?B?NGU1cDZWcnVmSnJIa2t3amNKOGg5aXNQSkU3QlRXL1AzUmZkS3N5aHdTVDVM?=
 =?utf-8?B?M3RIVE5UVjhPc0dNWUxyaDRZbEx2TUp2UjVQRElhUUFPa2dTQTMwNXVSYi8x?=
 =?utf-8?B?dlRtR0lPMyt1THM4V2h5bDhGN2YwR3Fvd1hFOUpDOGJtQWtZb2ZVWm9pY3BE?=
 =?utf-8?B?T3liSWZJTlZMUFppUWZRWHlSd0I3Yk1lNVhOb2Uwb1NzQkx4aFIvb3hIMzNX?=
 =?utf-8?B?R1NpVHgyNjVlQTF3V0twaE1iakNoRWp0aEM3ZDBNc2ZmVE5tVUZRS2NIcjVn?=
 =?utf-8?B?QTl5UDdFcis5UG9rSDZVbzBNY1BTZDhwUzJvYzBqRDRiRndXcUhiUkgvMFpz?=
 =?utf-8?B?dnZ4TE9DNGtSUVdtbHRKQlV0cVp2Y2oxTFZwdkFiTW83TS9mVUNHdm1ZOUtY?=
 =?utf-8?B?MldueEVEeVZvcVRHSVF3RGxuTkVOanU5RytPMzE5RFRMaXZWY2Q5Q1NkbzZn?=
 =?utf-8?B?eEFHZ2RLNkdPRzZGWlFhbkFFU2doM2ZHdUwrck4rL0h6QUdsNDVUalJiakJ5?=
 =?utf-8?B?R3dsa1NSN2JJeGVoa3FaNkc3TUZxVjBwR2RZeFVxYThCc2tESXF0NmR5NWl5?=
 =?utf-8?B?VUc4VEJPQ2ZFd2ZFalk5ODltR2RFYnEvYkZ4QWh6eHl5NGE4bzQrTHE5SGhT?=
 =?utf-8?B?Z2IySGp5aStjM2x5VmdZSVhFQ2pnN2hMdWF6OG1RclJtTEFuUC9OTjlMYTNr?=
 =?utf-8?B?dTBSeHJ2ZnhOdk9BQzcwK2w2bzRvanhUVU00aGZQZmdTOTFIaWtFNHA0UVhU?=
 =?utf-8?B?NDlZQ2NKVE9iMWxPcTIvekk5czFqTURuQWpBekE4aldiOTY0b25MRkc4cTdZ?=
 =?utf-8?B?VXFYOXE4aEN4QWJNLzUwYlMrYWlFK1JqdUVDZnozdzR2eFpKVkw0TUxPSGM5?=
 =?utf-8?B?TWsreUtlUkhWVWt0cElzTXZmTy9QZkExZG5CeGEwZkZQZklNKzdhWjU1c0pC?=
 =?utf-8?B?VFIra3NhRUJRUmM0VXFRTTE2RWN6c0xqeUhjSkhHTkJHZE4vbVMvbE9wQXM5?=
 =?utf-8?Q?yWX+rLw86TIP+GvdDSZm+Erbm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eff8f2a-af4b-44f2-b309-08ddec246a32
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 02:32:10.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjtCb46Vv+J/hPA8jNgz3eEormRwlf3/FQHwL0c+mrLVEfSR5R/hF7vrj8xDvEKdHABXJIMRqdFmcvJpgEGlJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457



On 4/9/25 22:56, Aneesh Kumar K.V wrote:
> Alexey Kardashevskiy <aik@amd.com> writes:
> 
>> On 4/9/25 01:17, Aneesh Kumar K.V wrote:
>>> Dan Williams <dan.j.williams@intel.com> writes:
>>> ...
>>>
>>>> +/**
>>>> + * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
>>>> + * @pdev: PCI device function to bind
>>>> + * @kvm: Private memory attach context
>>>> + * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
>>>> + *
>>>> + * Returns 0 on success, or a negative error code on failure.
>>>> + *
>>>> + * Context: Caller is responsible for constraining the bind lifetime to the
>>>> + * registered state of the device. For example, pci_tsm_bind() /
>>>> + * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
>>>> + */
>>>> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>>>> +{
>>>> +	const struct pci_tsm_ops *ops;
>>>> +	struct pci_tsm_pf0 *tsm_pf0;
>>>> +	struct pci_tdi *tdi;
>>>> +
>>>> +	if (!kvm)
>>>> +		return -EINVAL;
>>>> +
>>>> +	guard(rwsem_read)(&pci_tsm_rwsem);
>>>> +
>>>> +	if (!pdev->tsm)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ops = pdev->tsm->ops;
>>>> +
>>>> +	if (!is_link_tsm(ops->owner))
>>>> +		return -ENXIO;
>>>> +
>>>> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
>>>> +	guard(mutex)(&tsm_pf0->lock);
>>>> +
>>>> +	/* Resolve races to bind a TDI */
>>>> +	if (pdev->tsm->tdi) {
>>>> +		if (pdev->tsm->tdi->kvm == kvm)
>>>> +			return 0;
>>>> +		else
>>>> +			return -EBUSY;
>>>> +	}
>>>> +
>>>> +	tdi = ops->bind(pdev, kvm, tdi_id);
>>>> +	if (IS_ERR(tdi))
>>>> +		return PTR_ERR(tdi);
>>>> +
>>>> +	pdev->tsm->tdi = tdi;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pci_tsm_bind);
>>>> +
>>>
>>> Are we missing assigning pdev and kvm in the above function?
>>>
>>> modified   drivers/pci/tsm.c
>>> @@ -356,6 +356,8 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>>>    	if (IS_ERR(tdi))
>>>    		return PTR_ERR(tdi);
>>>    
>>> +	tdi->pdev = pdev;
>>
>> This signals that this pdev backref is not exactly needed :)
>>
> 
> I need that in cca_tsm_unbind
> 
> static void cca_tsm_unbind(struct pci_tdi *tdi)
> {
> 	struct realm *realm = &tdi->kvm->arch.realm;
> 
> 	rme_unbind_vdev(realm, tdi->pdev, tdi->pdev->tsm->dsm);

This does not really explain anything.

My unbind() needs DBDFn of the rootport to unfence IOMMU - easy to cache in the TDI's platform data; and resources to RMPUPDATE those back to shared - but this new device_cc stuff does this already (I am not using it yet though). And SPDM buffers but these in the PF0 platform data so that backref I do need but pci_dev is just too wide. Not much really.

> 	module_put(THIS_MODULE);

Why is that needed btw? Thanks,

> }
> 
> 
> -aneesh

-- 
Alexey


