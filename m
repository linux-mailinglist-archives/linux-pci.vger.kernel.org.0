Return-Path: <linux-pci+bounces-41064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC20C56140
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 486F834607A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD7329368;
	Thu, 13 Nov 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hDS3sFw8"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871653246E3;
	Thu, 13 Nov 2025 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019422; cv=fail; b=D2wSN+IiXK9IoK234BQ5HaiZt1veeUz2hntlJTrwIeahHEj64aPpkC1GdLTY49KX7DWD3NdrmoL3QdadvQ5iD4DhUfUmKSe+ygC3W9YARkBTE+gi4CPV0bZ8sCjQgOiW87f87VLQwa1E/H/zBgGSUcGPwGiiCJ0r1zHYV4xCQro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019422; c=relaxed/simple;
	bh=s6iDwV05QUfh7HY/wOiGJuOhx9HtsXbQsWPRokcqklQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QYeA8+xYdp23W1umDflB8JGxYYQeGtwIEAnlZzPwW3Q2soSJ0y5y4i/muMzxcJ//H43bd5KBeC2E8/OhMerFIEJyoZz06k9elDjOhmQHty+c6h8baHztdy0Uo6JymLiQC+A+OHCe7rxp76hR8pHiWLHwQ2r88/0NJC2wwu0J64k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hDS3sFw8; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1M/8zf//D18UkbDc5gkEE2PoxK/Kr82cxNlryFZYzTPDIwyQ3fXqF8mY+fkecpVs3Q6T4O0VXHL8ITMj5ls3tVFt3osKPS0nBWmkP3In6QrHtXycFBJ48Z4HZlSF21hcUar2VXtTS9Ze4nb6IAk2vQZ0+CaS4a/t0pKVl9DSiZ108zz2k7kST02iE41Kswqyvcv1Jj9tWKSx9cQwyUHq5/pCFYX1AtVYmMJJ5zSGGBQ8lrJSXQQNejxekLpNMJ0Nuiz3sureezriPhu6hgXbK2EWto12OUvqX4A6/n+fw1PpzrC0FqeecengO7YbpQsTqGmQooYJSro1/5f2OUw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vb6N4w4ruxG3db1bA60sLmw1Tv9pt4L6bhNGXuIBGw=;
 b=VgVXiQK+z7euJhR+++8lS565LciQzgyE1nJUuqM3yqELL9GaHNBEnKp/LTAIIDjMdqQb7YXL35peVbJLqOo4lsNnHPUNcciLxcmwILy4lQxvh3YU/aegfk8/Q9IFb2p7RguRF0pAOBtuwMVpuaLnM/UEG4qOP2y3kATkAoFYOirYMTdjab4pgmKnKlym+kNEwlgwfALu0otQixpLR1c+TxnvUcF6JYihpvuLpMulgcCzYplmvnR/fLQLHKJeMzJWyoCeHUO97U1oOvImO4wX8aeZHVbxBdbpOf0dX5/cU4L385IrIGsq0ZNaoO5Qok/F+vLcTsgW6w8+pG/CaRDfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Vb6N4w4ruxG3db1bA60sLmw1Tv9pt4L6bhNGXuIBGw=;
 b=hDS3sFw8QCZZ1smF6PrdlxfL17039X4D7hRYQnrTrr3NpNWskhtt2TrgtFn4GrabTBVoswxquIDTp7QuVGjGuDDIjVseIlKqa+Okaa1wp4ZGgXVqrHpfLJ4tMe60M/CbNnVHITDIqD41ZPBX8gKRq4SD0Goo6ekYCtPdGVB+kNQ1YwPqIlej5Fs2i9ZiIp7iSHR5owHbpSoIsfkKj+SWsIcdPQl3B8vwkjDMANMqfQT0NS0q8jO+e0zrvB8hMLPubLkcSFYAfEeE8rYx3XjE52T9KXErg6nYxxWUP3ctmaVyfjRoEIcPbQgPGROI4/GwDq8SNBG4H7WTJ8Yp5Z/Ewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 07:36:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 07:36:51 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Nov 2025 16:36:47 +0900
Message-Id: <DE7E7YXGLRWP.39EGH02PEV46Q@nvidia.com>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v6 RESEND 5/7] rust: io: factor out MMIO read/write
 macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-6-zhiw@nvidia.com>
In-Reply-To: <20251110204119.18351-6-zhiw@nvidia.com>
X-ClientProxiedBy: TY4P286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f835168-59eb-4075-3972-08de228768c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1UwNDRlQ0MvT25vMGpEQnNCYXhsd0JUeXVnY2V6VHhwMFgzR2hqeWJoN1h1?=
 =?utf-8?B?c1ZpY1UzTUdmQ3YwSDJwc3YyZEVEQUVESFg4NS9BWXRERklaeFlKN2ZHWGlP?=
 =?utf-8?B?K0FZaExSb2FGV3NvdFhGTXlQdzJvdjBMRjAwNStMUHpnTDU4OUphcmNpOFBV?=
 =?utf-8?B?Q2VwQzl1TkhzcUQ5Qi9oR0FBSTBVTGxma3FSWGdWUHBlMUVib1BaMWdDTTNW?=
 =?utf-8?B?TzcrUHNYcU9LTDZtdEYwc2tRL2dQKzVxekZWRm5weWtQdERYdWJxQVJSd01j?=
 =?utf-8?B?bmErb3ptRkFaZ3ljcUJ2Z1pqTnVQRmprTHd5WUs3MzZaYUR4TkJnbXRPeWh3?=
 =?utf-8?B?aldZeDdkMVRsZndURktaWkNwWkpiYUFrTU9hYyttRkpqWTNlSVN3dERvRHVB?=
 =?utf-8?B?TFVtdGx0QUtEODFOM2p4Nm1mNFQvMFVqdGZpZ3AwQmR2TFlHUTd0aWhJeEpG?=
 =?utf-8?B?YUhIVGRtL2hpdjZEL3IxajUzTEttT1NzR05Oc2FVRW9yZ3E4OHluc2svbFpw?=
 =?utf-8?B?ZnRIRXpIWGphR3pTZFdicDF5TnBVSGJUdXA2NENXOUpGZWJZOGhjZld6Rm01?=
 =?utf-8?B?cGZ4eFVrV1REMm81MEllTFNwVmt2WEQ5M1Y0dWxnTGJoQmlRTDJMT0RxK0lh?=
 =?utf-8?B?ZHZaVXYveXRETXVuVW05aUpqRWVBMUg3UE9KdDhIcWRNWFc1VTFBVkx1NmQ4?=
 =?utf-8?B?NkROdDdIemFDYTBwem5HNjZpZDlLZHg5eS9Gb2tqT240eXBxcDhMOThRQ3ov?=
 =?utf-8?B?bmZLMDRCUTV3bjdOcXMzNGR5SlA1bVl0dGhETTN1eEdRTTFRVk5VYk5IZ0VX?=
 =?utf-8?B?T3BuRHo0Mjl0MUdSWVN4YVN3RHZ1MlpJZ3c0R2RtMXhHVHJieCs5WmU5S3lI?=
 =?utf-8?B?Ty9WRmNoR05tVm05eTQxaUFPMmN5WmZBM2xFZTczaXRER1ArNWNJbE1JcVBh?=
 =?utf-8?B?VDRzem80bjRjM1Z2QXdMdkJKbCtJaGxVZmFwZFFEcHd0WDZoc2kxYWpzS1Rk?=
 =?utf-8?B?ZUYyd0R6dDZXTExIc0RENjNmSkdkSi9yUmU3K1paUGNGQzNtMmZUUnlaYkVj?=
 =?utf-8?B?RGYwWXRmMmdyK21JeFBGcFg3Q2NkWVBBUFJ2TDhzc05ITE5CMWYwdVFaQzFn?=
 =?utf-8?B?ZCt0dVBjV2NOcmRzTlVUSlBmYW9wdmVLM3RLdEVkTThDN0VzV1IzK3dCNnFp?=
 =?utf-8?B?azEzc1hpYVFJejN6bVlOT1dkKzRia3NaSSs3MTl2cXVKN01QUEZHRGxrWkds?=
 =?utf-8?B?VFI5Vk9GMlNtNm1nVGFDTXgweXZ1RE1yT3ZxWTdXZWxNK3VYVE41aVloOHl4?=
 =?utf-8?B?ZkY0enBUR21DU3VqdzJwd3I0V2tUUEo4RzNVWklMK3pXU0NlOUhzYTRyL0NT?=
 =?utf-8?B?djZVdHVsaUVsaURKalhDc1oyV2ZpSHRrMTljcWNMb1c3L0J5ajMra2h6WjZr?=
 =?utf-8?B?UW9XMWx6ZEVkTU1jSndibHlOZ1lJRi9rVmFGZUxMdTZLT1B5eGk1SkN2VjN6?=
 =?utf-8?B?aVN2NWp3NlZjZ0tFTVN5Wnl4V2kraXpZUW0xS3o0RmYvN0hUTFkzK3BscmlQ?=
 =?utf-8?B?S1ZWRmtTR1ZXOXpoVzZYMDVKa1pqU1JuVHgxaGtmVWdHUnhISnkySTJBc3ls?=
 =?utf-8?B?UmF1a2MvZk9Cekh1bTJNeFpmelp2cGkvWUx3TWYwVVRPclFXdFJ3V0J5OXR6?=
 =?utf-8?B?RDlsVmFlS2M5K1dBbW1TclVrRTVJb0VEM2Y4QklNTjlhZUtZd2xBQXB6WXhZ?=
 =?utf-8?B?TDNqV2VBbW9PNC9FYVBpd0UyQ2xFZmhxTVgrRU1qeE1XNUErZzVRemZGVUdw?=
 =?utf-8?B?NzZHZ3dLZDJqVGZOSFduNXB5R3lMb3k5VGF6OVpyblJUSmpuZm9NbkdwWEZl?=
 =?utf-8?B?VnMyZWJDWWZiWUVvR3crbytFWVZJakZVVkxVWTgvWnROcWRaZ3dBZiszT2RT?=
 =?utf-8?Q?O7tGYTMNok5CUBgZPHSwHHx2K7ns9YbC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWMrT0s4MzliYzg4SkVxZy8veFFiT1RrdHYwQUlQNzZMdEl2OTd0ekdNMi9t?=
 =?utf-8?B?LzRnWS9YRkdVanFQRW1RMnpjaW9HOTc2ZHlMQUZQdVEvV3Y2ZGFSYTA2dTRz?=
 =?utf-8?B?UzRlRlBnUms0V2ZFZlBCenlSYzA2V1BqNjRmcEpOL29lMENNMjhyMVBKL0Qy?=
 =?utf-8?B?Wm5uUEVRQWlEWTVCY2NOOXFGUEUzaEJNV1hSUlhsODRQdmRqbkdaOXN4YmFS?=
 =?utf-8?B?aU84OGhNN3VmbEtpejh6eVJVZWswUVhzVnpwaG42NE8yTENxLytlUGZ6ektJ?=
 =?utf-8?B?SDR2V0lteGhyQXUwMzl0bG9RRENvcTI2b0RYU3RIbk5Eb1FnNVR1TXhCTzVn?=
 =?utf-8?B?VDEyby8yY1JuVk9QMnplcFRGcVB5em9BREZoR3l2TFp1RnZWS28ybzRLdXRW?=
 =?utf-8?B?VnpDSkJuSVF4bVdEWDd4ZzM4YUJBK2dnU2tUUHQ0YjZxQVZnTjdrQURwTSsz?=
 =?utf-8?B?dVFMR0RGMGFWN2d2RHJQMS94Zk5xZTNEZjk1TVZXbnA4VWRNbXFjSVdNSUpC?=
 =?utf-8?B?cWRZTDVoWEs2YVBSTloxNzRvSU5zaGN6VEluSWtGaHZBZnlDMmpzNzBFUUZi?=
 =?utf-8?B?RmY3MkpnOTdKOWwvQVk2OXphK0JJbmdSTE5VK1lSOFNDV3Z3dXAyRHNBem9a?=
 =?utf-8?B?VTZMeFBhd2cxaCt0K1hGcGNrR09Ka0w2YTZ2bjZKcGhnS2x3RUlFZk0xT2lk?=
 =?utf-8?B?OTNham5CdGtLV291Zy9vOWhNL3hQYTdQaThadklUZE9kYUFkRkRVQXJ2WEt2?=
 =?utf-8?B?clEveDh5QmRENWR4SXdOWEpKM0JrU3AyWGp5S1p4OVRXSE1IN2ZvZHdTMndN?=
 =?utf-8?B?SFRCZkFaZmowc2hhSUZqOUtXSlowOG5EQnU4bk5NWGtFWTF3MXFvTmRlODlK?=
 =?utf-8?B?b2tlbzFMK0d6Y2MxMGJlTGNBRk5oVThtU3Z4WEdvQ01zWFlYeHZZZ1lEUEpy?=
 =?utf-8?B?Ym5WcGh1OUl0cXZSMWMxTVdRT1k5MEkxR0RUeXh6ZFVaMjJRVWpVQW1RMHFB?=
 =?utf-8?B?MWFEbUErNVBFNTdUZGpZcURQQTJoV25GL0w0V051OCtNTFpQdzAzR2JBUWo3?=
 =?utf-8?B?THhDNWVaMlh1RTZpTEZ5MlJjeDI4dk1xYlV0UzVNY2JSN2xjOVNLU01QZlpG?=
 =?utf-8?B?NlVQSEtvMGp2SGt6bHl5K1hsVjNSN2xxN2E3Yml4dlFZNnhVb1JSOWVpUFZ4?=
 =?utf-8?B?Y0VUbms2Z3FLUDIyVG9kRmpnVmZpZkgxMEJod0RzNWRxaVpseU9lUFdhajVr?=
 =?utf-8?B?YnFzeTNFME1MSTY1YUJPMnBFWHVTTXo4Sjdyb0djTXkxR2RLTjRoZXhMWEg2?=
 =?utf-8?B?ZjJjdmxCcTFTRzliRXZxWUNQVVIza0NLeW1iTnc1R3NjZHFtbUt5L1ViWU1h?=
 =?utf-8?B?TWhCZDR5elZUR1pPYTRrZzc4Rlpnb0VMOTQybFBIemlIakg3anFBaXZvVWtZ?=
 =?utf-8?B?REcyd2Faejd6S1g5Rm1aV3NKZ1BzM0VFZmlEdFVxMVo3d3VQRGZPMWNIbFdn?=
 =?utf-8?B?TXB4M3plRXZFOWM3cVhTQjhoN3A0QVovM0N4bUpPakdMdGdiUlk2bHE1dnZG?=
 =?utf-8?B?UEUvWi8vWW11QXpNT1pRMlFoRXNsNW9BZmFSYmRCZnpaUG9HSkNOelRYSzlm?=
 =?utf-8?B?dkxUQktuY08vaEI2N21ZNnp6azdoTHV5NTlXZno3ZGVhNFZHQXlnZWwvYzY0?=
 =?utf-8?B?ZnQwcXF4WDVtUnBzOEYwQkNXeWh4Z1FUQ21Jd2h3OGJXdGFLWlVyUVlOV0Nk?=
 =?utf-8?B?NE1vd3JBMTNLTWF5SCtZRU5tY0c4OXhtYXNiYzJKQ1pmL1l4NzBubFhTZjdr?=
 =?utf-8?B?VmZ6T0lkdE1OV1dTQ012TjZ3emVuMXNZdVZqN2Rjbzd3Qmd3MUhiUTFNZm5U?=
 =?utf-8?B?T1ZkQVo5T3kwVDY0ZUNtZ3dMVUFrazRMSFJSWDE2N1BXdXNTaTJVQ2VaN3BN?=
 =?utf-8?B?dmRobWl6S0Z1VElMTC9pSDJCM28xTUMxUXIvMWlzMEJjL0VUUEp0Qk1kcm01?=
 =?utf-8?B?OHVpQURzZVJBa1VzeXdXS1RXY2J0MjBielVZSEo1a3JOdXN4RGFTNjc5dFM4?=
 =?utf-8?B?TFlvVDVySTlXQmtpNWlxeUZsTDBBRWREOWZ5cVh1ZzJWTFNTOHBtSWs3ME9L?=
 =?utf-8?B?WmM5UUV0MzZGRWMrRldVeWhhWXQ1Z1NMZU4rcWFjWWhQUENHSXplbThEbmsw?=
 =?utf-8?Q?UTbhv54OnSYrLaSpmnh4wCqot2kosAf0ypGuMDfvUZcw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f835168-59eb-4075-3972-08de228768c7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:36:51.0400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aumpa9d+Ni3+1EXUnyRRuN4t4vp5iixVrazEqOsjWQZ0up7/9pEdQJfZWV6KXZjiqTj5Z1IjCvJvKnrtyQVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

On Tue Nov 11, 2025 at 5:41 AM JST, Zhi Wang wrote:
> Refactor the existing MMIO accessors to use common call macros
> instead of inlining the bindings calls in each `define_{read,write}!`
> expansion.
>
> This factoring separates the common offset/bounds checks from the
> low-level call pattern, making it easier to add additional I/O accessor
> families.
>
> No functional change intended.
>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/io.rs | 110 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 73 insertions(+), 37 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 4d98d431b523..090d1b11a896 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -124,8 +124,34 @@ pub fn maxsize(&self) -> usize {
>  #[repr(transparent)]
>  pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
> =20
> +macro_rules! call_mmio_read {
> +    (infallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) =3D> {
> +        // SAFETY: By the type invariant `addr` is a valid address for M=
MIO operations.
> +        unsafe { bindings::$c_fn($addr as *const c_void) as $type }
> +    };
> +
> +    (fallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) =3D> {{
> +        // SAFETY: By the type invariant `addr` is a valid address for M=
MIO operations.
> +        Ok(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
> +    }};
> +}
> +
> +macro_rules! call_mmio_write {
> +    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:ex=
pr) =3D> {
> +        // SAFETY: By the type invariant `addr` is a valid address for M=
MIO operations.
> +        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
> +    };
> +
> +    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr=
) =3D> {{
> +        // SAFETY: By the type invariant `addr` is a valid address for M=
MIO operations.
> +        unsafe { bindings::$c_fn($value, $addr as *mut c_void) };
> +        Ok(())
> +    }};
> +}

I understand the intent from the commit message, but this is starting to
look like an intricate maze of macro expansion and it might not be as
easy for first-time readers - could you add an explanatory doccomment
for these?

> +
>  macro_rules! define_read {
> -    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> =
$type_name:ty) =3D> {
> +    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ide=
nt, $c_fn:ident ->
> +     $type_name:ty) =3D> {
>          /// Read IO data from a given offset known at compile time.
>          ///
>          /// Bound checks are performed on compile time, hence if the off=
set is not known at compile
> @@ -135,12 +161,13 @@ macro_rules! define_read {
>          $vis fn $name(&self, offset: usize) -> $type_name {
>              let addr =3D self.io_addr_assert::<$type_name>(offset);
> =20
> -            // SAFETY: By the type invariant `addr` is a valid address f=
or MMIO operations.
> -            unsafe { bindings::$c_fn(addr as *const c_void) }
> +            // SAFETY: By the type invariant `addr` is a valid address f=
or IO operations.
> +            $call_macro!(infallible, $c_fn, self, $type_name, addr)
>          }
>      };

To convey the fact that `$c_fn` is passed to `$call_macro`, how about
changing the syntax to something like=20

  `define_read(infallible, $vis $name $call_macro($c_fn) -> $type_name`

?

