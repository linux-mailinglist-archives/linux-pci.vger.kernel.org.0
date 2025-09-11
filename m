Return-Path: <linux-pci+bounces-35944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBCEB53C30
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 21:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2367AA3C3D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93F0259CBB;
	Thu, 11 Sep 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qYCa1kt2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8723D28C;
	Thu, 11 Sep 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618387; cv=fail; b=Uj5Hmcyr7TR6P7NUt/SwnhVVMpYWowqcIEsNeoiMYR18Jhr26cANH2I9hXTk1Or8fW7eEbSPceOFLQOocycK847HrzLWuF3DtemA6Ftm7noHYDTnQHPkUJvPilwpYgCHeYj417UtpHdKpeYpG1vD0IqzvmD4rBJ3e/KVrQmj7aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618387; c=relaxed/simple;
	bh=GODR5NirSRPIn9UE1jXdUE2WpyTXsWCLxJ2/pcJbtpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M8b3fHTcEEty8oDaqACP4AU1p8KmI0XBYWtv5K1VAssrAXQOl2dYd/JTn9SfdIgPkkr9hiZWHtKi1PlUPp1NpsWvYc2p3wWzRSitQxlFl+U1Qbmi+2zoF3LEqMAw0feccwAkcuCb5X9ExqvZ8H+wlvVcqRWE3KDrdVB1f43H58c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qYCa1kt2; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8ozT22Ri6s/PX4BX2RhcIh1Ag8rLrB1/Yb3tAAJzl7C33bO4HIwbFe2bqGJ7Ywz2b3ndnug1pp+cTYuAzWeBOsYOBEfjRMKxOevObBvoFboWwpkpAna9u7+vaLpNu77pCroLwvd5j9imCIAQWjfJemT2H1a08MjN1ElmTer1xAPXe65UH9yjkSXpiOem6mUdjY1ENV5vV6m8DO2KYtRfVMbleTRe1jlTLg2+uYeL5L2JXBfeizDMcUbgZtmP9SRiodeLv9xFof5DKE78Pt9rWJJJhlY9G3MFAPYBAoejF+xy5orwYE0WNfBcISaIRJMCAyuOLeNrl05riIN0JTRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1agG390rQ1NDfS1nbQOb/oq1624Pj2V7ye/MWIIrXS8=;
 b=f32j9X0J5Ui6SHIiZFMJ+Pw/js7p8aCJ0bhgY0zmn4DAnxGrwUl7I9SzIrHQxkk6j7h5wBz+d2yWXvhpiT0mailqjtJ15GGzVmqlMaCYGKM2H+ySm+CvE3ea9FuYcBxuNV6ynSXt0ht3tBLL1VL/ELhJp3giJ8TYrkOicXXGpGY4ytj7+eH+5QYnjHVz3ELjUFjKogdqWtPBOKfcx/mGtJuqIAOsOKk6EuVWYvHGBjd2DL+CxIqq5JhlpejBLl/I1X1APUslWW9bTbezBcGLjLOCVPATXkvBec4FZA7TJp1Jnuygj7rPjnNR6+A89JmPJKZH9avFNF2ZLf91g/CIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1agG390rQ1NDfS1nbQOb/oq1624Pj2V7ye/MWIIrXS8=;
 b=qYCa1kt2/4P1zwpsH/Jq7QjgVc5ea5aCQgXPvH73gUN0HIbZppC58srrUUoo8DFA+1VVf42vxC5ArhaIrWCVvSKHCtCiS/7qAPdBr0eaMEVQDG0UeoWDdsNlrOwoWEULFijuq5xJgOFA3pC1h3gzjrw1P8fHQccIW80RdXM+y4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 19:19:39 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 19:19:38 +0000
Message-ID: <67d11134-8916-4ef8-ab78-06bcbb87d9cb@amd.com>
Date: Thu, 11 Sep 2025 14:19:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/23] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-22-terry.bowman@amd.com>
 <7a59101b-4ccd-4d86-b97b-21602ebcd1a5@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <7a59101b-4ccd-4d86-b97b-21602ebcd1a5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:805:66::43) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: df0511b6-28bd-4419-6b80-08ddf16826c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkZQaHdBWkIxUm12TldFWFNxK2ZvRjVHcGYvWDRUSXZmZmJHSjEwRjB0dWht?=
 =?utf-8?B?cUdFbzIvckduRTUvaWFkWVdBaTFRZTJsZFBQdFUxeFJFRDZoY1BPSFowbEZn?=
 =?utf-8?B?aEZrYjZqWmhsYWpKc1NmK1RNbWFlMHMyY2xDNjh0NlZ1YjJvK0VsZlRnWk01?=
 =?utf-8?B?aU52ZU11bHRYdkFBTzQ5M2c0ZlFrb3VOeHg0dm9kU3lWT0JYWkYwK2xLTHRD?=
 =?utf-8?B?c3lnWk0vRmhhQXVKbnVzSERlcTZ4WVRkSEs2dndGeW8vNTgzYjhJTzhzNk9s?=
 =?utf-8?B?bTRVQ0xzbERVaFFKU3Y5c1hyOEJXc1pPV3cvZ3Jsd3RPeFdhZFJDOWtMYTRK?=
 =?utf-8?B?WlByeDZlK0FPOGNIT2xIU1AvbzhYUVZMNzBNTXh4a2k5WUVjeHFMdVZxWU9u?=
 =?utf-8?B?MlV0MTB0dmVGbTU1UWFqSUFGTVc1THd6ZFFVOTJZb01XSlhmZ29iVFgvMHBz?=
 =?utf-8?B?emZqNXZ1YTFFREZQMHg2Vjd0Q0xNZy9MbXFDc1Q5SmxJVC9RL3dGa2VjL1J3?=
 =?utf-8?B?eXU3VVFFWWRNWXJ6U3FYMjZCMTBEQWp4ekZXdGZLS2g5RW51dGxwODZMZS9w?=
 =?utf-8?B?VzFDQTVlaDZFZE9HUzdhYXdXcnZvKytHYzRwa0hlZzJ2bWhKTXRPbGR5cWcv?=
 =?utf-8?B?TWtEYUdIMTJMWDlJNWtOdm5mYmxxbTZLK052MTBCZU9VRXdVc290c3RaWEtx?=
 =?utf-8?B?ZUpHVUxrRXhiL3U3c2VQNXVwUUY4M2lrSHFnRDFuTStPaGN4VzFvNmJZdDE4?=
 =?utf-8?B?OHc3cFRaTHFNTkcyR3dtZUJRMEJRVlFZZXVHY0xwMll4VDlQNE0zR1R2V2Jy?=
 =?utf-8?B?YVY3VEFMRDJ3Z0tUT3JVNlNPTW15T25iUHBVWGNxVEpxVWVnaU9XVU5rd2dl?=
 =?utf-8?B?UFVPOGxZZEZOV09xaGdDRVYyRXFoV2RiRDhPUGlwNTFrYnRMTVJ1OFB1MUJo?=
 =?utf-8?B?MUllYlM0eHA0TDV2L3NxcC9DYkhGZ2NTVkFFbVBNSU5tYWltYmppc1VWQ25j?=
 =?utf-8?B?Y2pkVnFMKzN1dUVpZ1hhQjYzN0ZUeStDZnVLT2ZzNFFvOWl0SFVuTDA2M0FM?=
 =?utf-8?B?OE1FdzFPWWFLQ0I2WVhXMmUzSXhZVjYxT25icmRWWHova1pxZ2VJTC81QlRM?=
 =?utf-8?B?U01xTnVjTVVvVkxVclpGRHhtdkNZRGJWYXBJK0lHcmtOaVJjaUNGVSsrQXpw?=
 =?utf-8?B?UDd6YUUxNmhZTkxZQzl5cHc3aW83aUJQNkpTWG9QazB1cEFyOVVKQUxNRWRn?=
 =?utf-8?B?Y3FuSnRXNWJuVHIwSk9QYVNUQmtYek90ZHlQUWlDV2RoaSs2MGZxditLYXFi?=
 =?utf-8?B?UXRzT1c5dEF5SGd6Q2J6SUNLeGNmQ000TVIvMjROTER1MDNpVDdaS200aU0z?=
 =?utf-8?B?YWd0SjdoTWU3TWJWV05nbkRXa3ptK29MNVJodlhDSHVzNmJJOXZpWHBYRnU4?=
 =?utf-8?B?Q05pUDY5emNGMDJXM3I4VCtueVBWQ3oreHVZMFBVbi8zOXpPLzl4MUtzS3JL?=
 =?utf-8?B?TW9PNW85YklGbXBVMGVPMlJaaDdaNkhjeFJyUllQcEU0UW9qMklOWnoyRm4x?=
 =?utf-8?B?VjlTZEV1b0NobXZtTWpTUnp0UnZFYy9oVFhRYzF2NUJlQzR1RkxJSU9obXoz?=
 =?utf-8?B?b3cyakhLNkcyK3NtNEN3b2ZuV2oybG5WaEFWS1pOeGpuMXVDOHF5MytnbTRz?=
 =?utf-8?B?TFQzTnlIOFBVdzl3bUNSOTQvWU1uNEZFWDZuenEzWU0vTEVBZ2VsN1ZjcjAw?=
 =?utf-8?B?bjNCV2wwV3hSS3JZTmxVRXVodHlQK3o4R3BqNTFPUE5iU0JaOUhoVDluMkY5?=
 =?utf-8?B?aFB0U1JNa0ptSExtNVlFN0JJeU1aVzJuZ2M5RnB3R2d6Mjc5OWlxOFB3WXMr?=
 =?utf-8?B?UkNuL3drcXF0YkpwTkVKbDF4SDVub2xCeUZTYzBBVlhpRVdrQVQ5UmwzMXdJ?=
 =?utf-8?B?OENXQ2JtNlZFVW9yVHUyZ2g0YmNsMEdIRUU5U2tOUUFmNlN6NDVNalR0MUxm?=
 =?utf-8?B?K0NIWFlGVmdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2JJaEdaS2RCRzBGVGpjT1Zyc3Yvd1V2Uy8yL3JNVGQ2UVh2eDRpUTBNL1Ry?=
 =?utf-8?B?QWI1clZPSVMyd2pjMlZxcTdBVERtUjVJOXpsZWdWaEx2cGIweDZGMm1hMys3?=
 =?utf-8?B?d3VrNCswRVJNdTZvRTlaZ0htb1ZUTFBzLzlnbHVXK0N5dUg0bTM0cjdFVTNx?=
 =?utf-8?B?TERrQlVHVmNpNUp1cGNEMk94YUY3VG41SUJEb0xKTVBsWXJ3Yksyc2lONW9j?=
 =?utf-8?B?dTJGcDVXamVSU3dmaktvRFNvTWl2dUEwWStQLzhWOVVXc1BxZ1hnU0p2TS80?=
 =?utf-8?B?M3ArQ05sbGR5RnN0RmlIQnA3SjA0c1QvWGdUVGF6WDFtTnhCdW5xTU0vb1Jv?=
 =?utf-8?B?eFNwWEtsSnFFYlJ3Uk9ON25Qc0NPRStGSVNMcjRjVkJaek9HMndDT0ZqRUJT?=
 =?utf-8?B?UGpNR0dXUFQzcElEcS8yMWJIeGhnMFM2d1hYRWZJNG1hVG9weHNTM2J6SDJH?=
 =?utf-8?B?RWFScEc4SkdabUlsbmhGYWVlWXNDL042cDJUWElGcStkTFZLWlpUN21qdit2?=
 =?utf-8?B?S28xSmFrWk9NMGRwOC81TzJxaWw0QUdlS1g5ZmMwa0N3YUUyQXgxL2xiRmpE?=
 =?utf-8?B?d0Jvcmh3NEQvaklUVm9SVElYUll6eW95MzUycGtBSmozeldoYVFXS04vY1BT?=
 =?utf-8?B?aTFad05qRHR5L3VPTE15OFY0SWE2aHpMcWJOY3lLT0t2ZUx2dWlIcm9zUVhz?=
 =?utf-8?B?eWVSeitleU5LeFFFQVNDc2VGRExtK21UOXFka2oxYnpSOFNmeC9vK29UMnlD?=
 =?utf-8?B?Nkd6YjhaLzJteml5bDJMckdjNk9Menk1aTQ3NEM3OFNxVUVoYkFISFFqSFVP?=
 =?utf-8?B?U0pqbFlEOG5uUE1aTmQ2QnZiMWUrWW5RR3FvR1BaRTdoaUxaZWRYUEREZEJk?=
 =?utf-8?B?UG5YODhWZ1JZbWJEeU9ZVmUzdTNkajQ5a29wR3dHclZNb1h5QkZJZWhoc3V5?=
 =?utf-8?B?M2dlS0pPMVcwWFgzV3hKUGpQWGo3UTVMVmRJbUFGNmhyTzRXWEQ2WFVzekps?=
 =?utf-8?B?UXlGd0k3N1hJTkErTllUUnBaamRkRWpXZkNqS3BQRFBFM1RlVHFBRkNkeUtO?=
 =?utf-8?B?Q05ROTRhdzVJVm5PTkpqbjF6VFVUZkhlUk0zVUtVbUdkTHY0TzFBUzQ3QzJP?=
 =?utf-8?B?eGU2Y3VhK0N2RDNoSjBLN0lnV2RQdHorTnJRU2pGSyt0bVluOENOcUc2VDRQ?=
 =?utf-8?B?UjRGV3BCbDBNdGhZTDBWdjdXRzQvMXo1OGIrNXlJc1BTL01QTEdXSDliWlJM?=
 =?utf-8?B?OUdRMFd5aFVrN0svWVRnUkw5OHlkNkFrSHpGRlc2dnp1L3dYRlgzS0czREtY?=
 =?utf-8?B?OFgxLzd4ZHlqQTlidUlGZFJpSm1nOHFoSk1NSC9LZW8zRnNGcmlDK1VSMkNH?=
 =?utf-8?B?eXBvWWNDN0tiNmpTOWxjSUtCMnhld3h5MSs5SHlPaS9Xc3RDc0xlSmxub1NS?=
 =?utf-8?B?dFY3MnlGTXVyNnRsQkltSCtYdEFDcEJlKzF3RWsvUTlua2VEY0RlUmIzZWo1?=
 =?utf-8?B?djQrZ0RzMGFRRGNxL0ZlMGRja1k5eUJPc2s5NzNOdjRSa0ljRGxPMzl0WmdS?=
 =?utf-8?B?S3FVbnExQ3hIZFpBSXdDRmNVNm1NNGV4ckc2SVE0K0h5cFM1aCtIb3lRbjdS?=
 =?utf-8?B?V1B0VmdBb3Vuc0FjT3plRkhtNzk3SmhoVm9zN3MrcUVuL0MvZkkvZ2dyUnhl?=
 =?utf-8?B?NWptVSs5UHUyZWwrZFhHUitzMDNwc1RQakZ2YW9ydVlrbmhkaFBQNWdWVjFI?=
 =?utf-8?B?L0txRmp1cGRENjcxTEtCdUZFTjZ3Tko3UU5hZk9mQytGMnBUODAxcDFZM3BY?=
 =?utf-8?B?WnlSOGtuVnZKUFdtbDhheHBUZTR3eHhaREwzN3VJMVdtNllLR1hBVG4vUzZ3?=
 =?utf-8?B?YytBV1Z2M2FsbWZKajRoaXZUL0ZuRmdsZ3FVZFJ1U0VFbEU5RFBCQU4wTXpJ?=
 =?utf-8?B?WVVvVEJBQTBBZEM4aHF2TkdlcUl5UHVZbkJ2a3pVMnRaYlZKMzBiMEFmaVU0?=
 =?utf-8?B?dTRJT3NLT09NaWpRM0pKSXdMQk1pWGEydGFpakl5VFBNeHFHeWM1bGIrbTFV?=
 =?utf-8?B?clF3ZTAxV1BnUU4rbDYvRWtNczY2RjJKZmw3OUhES3A2WUZQQjYrdDBTUjhZ?=
 =?utf-8?Q?j+iDogG9vKrktDNhrd3ySrUqF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0511b6-28bd-4419-6b80-08ddf16826c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 19:19:38.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yf3Y8WaeIL/SX3lVYzR63V1ZmCRYsgX9rVsRklGteGa9tlhOgzaHFfT1dsVWNyVduXZo7YNNJMveWm8+e5+6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358



On 9/3/2025 5:30 PM, Dave Jiang wrote:
>
> On 8/26/25 6:35 PM, Terry Bowman wrote:
>> Populate the cxl_do_recovery() function with uncorrectable protocol error (UCE)
>> handling. Follow similar design as found in PCIe error driver,
>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>
>> Introduce cxl_walk_port(). Make this analogous to pci_walk_bridge() but walking
>> CXL ports instead. This will iterate through the CXL topology from the
>> erroring device through the downstream CXL Ports and Endpoints.
>>
>> Export pci_aer_clear_fatal_status() for CXL to use if a UCE is not found.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>> Changes in v10->v11:
>> - pci_ers_merge_results() - Move to earlier patch
>> ---
>>  drivers/cxl/core/port.c |  1 +
>>  drivers/cxl/core/ras.c  | 94 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.h       |  2 -
>>  include/linux/aer.h     |  2 +
>>  4 files changed, 97 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 758fb73374c1..085c8620a797 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1347,6 +1347,7 @@ struct cxl_port *find_cxl_port(struct device *dport_dev,
>>  	port = __find_cxl_port(&ctx);
>>  	return port;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(find_cxl_port, "CXL");
>>  
>>  static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
>>  					 struct device *dport_dev,
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 536ca9c815ce..3da675f72616 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -6,6 +6,7 @@
>>  #include <cxl/event.h>
>>  #include <cxlmem.h>
>>  #include <cxlpci.h>
>> +#include <cxl.h>
>>  #include "trace.h"
>>  
>>  static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> @@ -468,8 +469,101 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>  
>> +static int cxl_report_error_detected(struct device *dev, void *data)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	pci_ers_result_t vote, *result = data;
>> +
>> +	guard(device)(dev);
>> +
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
>> +		vote = cxl_error_detected(dev);
>> +	else
>> +		vote = cxl_port_error_detected(dev);
>> +
>> +	vote = cxl_error_detected(dev);
>> +	*result = pci_ers_merge_result(*result, vote);
>> +
>> +	return 0;
>> +}
>> +
>> +static int match_port_by_parent_dport(struct device *dev, const void *dport_dev)
>> +{
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return port->parent_dport->dport_dev == dport_dev;
>> +}
>> +
>> +static void cxl_walk_port(struct device *port_dev,
>> +			  int (*cb)(struct device *, void *),
>> +			  void *userdata)
>> +{
>> +	struct cxl_dport *dport = NULL;
>> +	struct cxl_port *port;
>> +	unsigned long index;
>> +
>> +	if (!port_dev)
>> +		return;
>> +
>> +	port = to_cxl_port(port_dev);
>> +	if (port->uport_dev && dev_is_pci(port->uport_dev))
>> +		cb(port->uport_dev, userdata);
>> +
>> +	xa_for_each(&port->dports, index, dport)
>> +	{
>> +		struct device *child_port_dev __free(put_device) =
>> +			bus_find_device(&cxl_bus_type, &port->dev, dport,
>> +					match_port_by_parent_dport);
>> +
>> +		cb(dport->dport_dev, userdata);
>> +
>> +		cxl_walk_port(child_port_dev, cxl_report_error_detected, userdata);
>> +	}
>> +
>> +	if (is_cxl_endpoint(port))
>> +		cb(port->uport_dev->parent, userdata);
>> +}
>> +
>>  static void cxl_do_recovery(struct device *dev)
>>  {
>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct cxl_dport *dport;
>> +	struct cxl_port *port;
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		port = find_cxl_port(&pdev->dev, &dport);
>> +	} else	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>> +		struct device *port_dev = bus_find_device(&cxl_bus_type, NULL,
>> +							  &pdev->dev, match_uport);
>> +		port = to_cxl_port(port_dev);
>> +	}
> Do we not attempt recovery if the device is an endpoint? Is it because it is handled directly by AER callback of the cxl_pci driver? Should endpoint error just not be forwarded from the AER kfifo producer instead of being checked on the consumer end after going through the kfifo mechanism?
>
> DJ

The UCE fatal case is handled in the PCIe AER handling callback which is 
what I used for testing. I need to add EP support here for use in the EP 
UCE non-fatal case. 

I don't think bypassing the kfifo for EPs is ideal. The only headache with 
the EPs is EP fatal UCE is handled in PCIe AER callbacks. We may be able to 
improve with future series by adding logic to detect the link health and then 
access if ok in the UCE fatal case. 

Terry

>> +
>> +	if (!port)
>> +		return;
>> +
>> +	cxl_walk_port(&port->dev, cxl_report_error_detected, &status);
>> +	if (status == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	/*
>> +	 * If we have native control of AER, clear error status in the device
>> +	 * that detected the error.  If the platform retained control of AER,
>> +	 * it is responsible for clearing this status.  In that case, the
>> +	 * signaling device may not even be visible to the OS.
>> +	 */
>> +	if (cxl_error_is_native(pdev)) {
>> +		pcie_clear_device_status(pdev);
>> +		pci_aer_clear_nonfatal_status(pdev);
>> +		pci_aer_clear_fatal_status(pdev);
>> +	}
>> +	put_device(&port->dev);
>>  }
>>  
>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 69ff7c2d214f..0c4f73dd645f 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1170,13 +1170,11 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>>  
>>  #ifdef CONFIG_CXL_RAS
>>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>> -bool cxl_error_is_native(struct pci_dev *dev);
>>  bool is_internal_error(struct aer_err_info *info);
>>  bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
>>  void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
>>  #else
>>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>> -static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
>>  static inline bool is_internal_error(struct aer_err_info *info) { return false; }
>>  static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
>>  static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 1f79f0be4bf7..751a026fea73 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -81,10 +81,12 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
>>  void cxl_register_proto_err_work(struct work_struct *work);
>>  void cxl_unregister_proto_err_work(void);
>> +bool cxl_error_is_native(struct pci_dev *dev);
>>  #else
>>  static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
>>  static inline void cxl_register_proto_err_work(struct work_struct *work) { }
>>  static inline void cxl_unregister_proto_err_work(void) { }
>> +static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
>>  #endif
>>  
>>  void pci_print_aer(struct pci_dev *dev, int aer_severity,


