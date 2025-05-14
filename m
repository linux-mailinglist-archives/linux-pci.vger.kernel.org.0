Return-Path: <linux-pci+bounces-27666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42963AB6090
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 03:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1180A3A9DC0
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F11D95A9;
	Wed, 14 May 2025 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZjUsy+Ds"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0B28EC;
	Wed, 14 May 2025 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747187490; cv=fail; b=Xd5Wu9WZnrAc4+JddmLA7JNk6qjWGaz/Rm1e/6BJqbA4bNxjlA28VAzmP/MXdzZb8XLiBQ1s0c5+/u37LjFJ6md0zQRP/BwmhQnEEh7set2BpyI5mewaN9twVN1Rj8XrJPIn1CQX4jce8mcQEVnyieoKRWMl/vatslODn4TYz5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747187490; c=relaxed/simple;
	bh=5pUEU1qo0rBjGgB/690wbaN+6Om54lQPmPifKlZajq0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IzpZ3eTW1sML1OUYYdFLaqLMoFVazqrtu8CMva/7Xz3qHLcS5+S1nKrkhiMGQLaTfsFRTOkUyFjLP4vwn7XAxpXOADYJxotBQs8ln0xXcGpJbUBvU6SIGWyz80ofx+yw0sC+2ZvcWveN7uWvamvWJQ97tsxsZ4ObN5A71oySbvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZjUsy+Ds; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mge7MjSgiz/G4Y+xMPjh1jpA0+yIhh8KnZzBHbupf+wF7GYT0qHI1VgNJZnAc1QsKwS7tu9ZW5SdPYTYjIKLZ2fn8XnRsfoV9iqbLGSz7L8FvjTCkXR1uCENYx4DT//wXUX+VKTCOH5X9GoDbo0eo/RQ4MNSKMzBqGaoQKPVVkCcfD1vd/OYKdTVQxl0YK1TOBYZOzKv80V8LrhbJYRpSiNOlhQFAG/NIUHBTJ5rmQGfT1YmiENj238WEhsHgVVIChNbSnj4jDzbHhTFWOzPzO1iA1ZFw9OuO/tQiWCi0C704cPdrjZTYxs7qKlzHwGt66WXT1bysJwc129Bg+SnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugpadPjWzRpPMMugAM2Bwir4nOlmrwGRpnHeAzTX8Jc=;
 b=WG/O66Q8Blz+Brqko03gDB00u5seTaAbXTvbNlfQF1VkTuZHht/XeanWuPfhpjt4zlQCMydiYiLIkE4zjlY7Ea7DIHMTsZCsEWLO7Kkh2MdmPQMmaJOI1oDdUbssrDJh6cVZYLbmJcWtYm3hBdic3boN65pwA4xX5gBjtblwHEtuLr4zys9F/WURxFXzX4sU1fvTqKPRcmFwhhUN4kkCweNU0KPfot/+e6AS9+l8Pd/WrwhBDk8kiJPDxeTYuK/2kfwkzH8JtZhDiJwDD6p8LhTeq5Am5XCtOJfJ1JiD9oKJliqM62dDAjPJq39Dct4nT2uJYBufJmBtt2dSHb8ZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugpadPjWzRpPMMugAM2Bwir4nOlmrwGRpnHeAzTX8Jc=;
 b=ZjUsy+DsIJcpCtqnY6BTTY3Wu/UBirjCAdXN1zzMfZmqlF+5C9P5JSk6U+vEcZBNCVUSsU3AWtMxt6+AYCIYjQyOdlcjeLjTrMF4DPW7MFMKnrQB6jyXZKpVNJgq3cbjMChvOHRMgK/WxrTdxkmN/XwcjIbpdKFT6BgAD8YsJO3Rursbg7E1gKefnODfSBVG0UlyuzmR4rzP0rxTnRz1ogMTcxhA4V2slCciOraRPwv/2zm3+Sx1XbxTHbvPjKIfDY7XDHbjXRK4EP++an16hEILpcaA0QrlH+Yn/H34yqdk7AOVS7E8pmg0bgjRxEqiCi0oA8NxHDdOudKOlg6F0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 14 May
 2025 01:51:23 +0000
Received: from DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::af59:1fd0:6ccf:2086]) by DM6PR12MB4186.namprd12.prod.outlook.com
 ([fe80::af59:1fd0:6ccf:2086%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 01:51:23 +0000
Message-ID: <1b4c7742-1e0e-42c4-be52-c5fa55c24ca0@nvidia.com>
Date: Tue, 13 May 2025 18:51:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
From: Tushar Dave <tdave@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250505211524.1001511-1-tdave@nvidia.com>
 <a8d9e9ca-4944-40ae-acd8-d576447742d3@intel.com>
 <f10f54a9-e45f-47f0-8f5e-473daae82665@nvidia.com>
Content-Language: en-US
In-Reply-To: <f10f54a9-e45f-47f0-8f5e-473daae82665@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To DM6PR12MB4186.namprd12.prod.outlook.com
 (2603:10b6:5:21b::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4186:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0272d0d6-2435-4cea-7164-08dd9289d473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b01sMWZ6cE5oT2RxRGthTTl4S0FsODV3TFdhYzdYczhNMXg0SFY4VGtJYi93?=
 =?utf-8?B?V3VobDVkejdhaDRCMWhnOFR5UDJxQmM4YW1iOFpRVTZta2dVcDgzdDBNWVBs?=
 =?utf-8?B?dWJNTC90Ky81KytNL3RzektUOUpTUXdDeitueUw0R200c0dqZGRVSEdmY05F?=
 =?utf-8?B?MEpTMURKWEZsS3Z5MzRaZEhYZDJONU1ISi9sRStkT24vQ0cyS1BDWURyMDIw?=
 =?utf-8?B?TWFIbWw1ejFvQTc0UnZaZ0N3cC9paEJlK2NpRFRWb3gzek1RQ1lIMzB1VUZn?=
 =?utf-8?B?dmhXd3NKcFRZTTVUcit5bkI1MkFkdDFKL3JPdytrZkVObUFnRmcxVmZpMFhq?=
 =?utf-8?B?ZmZWcytPNERlSE4wTWx1SUFLaXBmV0dkUmtreDZVcm1JSzNGQTYvTkFlb3JD?=
 =?utf-8?B?NmpSQm9NTU8weENFYkIwSW82TkdjMEdsRmh2blFSUEJtcnF0UUQ2USt5V25X?=
 =?utf-8?B?MUVoYXZyTG14VER4WnlJdllRcnVHRWczczlQRDVWbDdUV2RVTmplSjJKTDdy?=
 =?utf-8?B?dUtmaEZwa2VkK0h4SkhiNWlxNDB0ellhZEw3WkE2N0VTdlkyV0RoaXB1L1U0?=
 =?utf-8?B?U25aV0dNN2FlRGZYYlh6YWlibk9SYWxnRXNwRDVCeW93MjJsb1p0VkJ1Nk1m?=
 =?utf-8?B?dVRXZXptMEFwQlkyY2pOb29lejlSWlhZaXRJb3VXTElIa0pqN0lsdG1sQzJk?=
 =?utf-8?B?MGZiUUFrLzcrSWZoOG9JODhrcTJyNkVzRUJRVzQ0SWJLNFhERDJMOG1PTHBO?=
 =?utf-8?B?WGFQNzF2MVVkbWVwcUdMaU9kSVdXM1Y4L210RHYza2lhK2tYdFlrNitRN0pP?=
 =?utf-8?B?THlXbEVMRVk4WkZBaE9NN1JFQ0R2T1JDbmhzdE5lSEFBRUQwektkdVNjcTB2?=
 =?utf-8?B?bEJMUllIQWs4eFVwUExvN2lnMW8wWnpxbU1TL2w3dk1yYVBRaHNHaXBWT0Zr?=
 =?utf-8?B?cko0VjQybE9kRUoxamZkRExCSHh3NWg1OStDUGtMR3VZeDE4Rk43QzNwbGtE?=
 =?utf-8?B?Nkt3U2tReC9MT09pRzdqOFhCRWdNMkZCSFVUc2VEN2M3VEZUbHdEcVZKRWsv?=
 =?utf-8?B?eHoySDMyeHQ1bGxpQ0dtOTg2TDczVjNxZHAwWTMxL204UzZlSjRyOS90Y2R5?=
 =?utf-8?B?NURJMlRCc21GMkV0VGNRZ213dGs0emo2T1FodHVFckl6QW0vTStKbjVFQ0hr?=
 =?utf-8?B?K0YwY0VSRzNIQmhHdTBpOFJmcUlXcllRNFpoUWQ4RnNKME5DeXMremRRTEdV?=
 =?utf-8?B?alhBRDNwcHhOOFJNbVhFVmtoMlZqSmxTcytBYm9sQU5lbUtwRHpEWHduUmxU?=
 =?utf-8?B?alVtOU1BK3UyNjBJOXV0bHpkcUZpKzdqeFNaajBRK2s5TTEvTlUrN0s1U1Yv?=
 =?utf-8?B?VW0vSXdrNGlCU2RRanNOcWRLa3VsdkFMLzVoVXFNaW5WamJuQWRZeVp3cElo?=
 =?utf-8?B?b1UrR1FKdTc3cDJNUVhDN2kvZUtRMEUycUtqa2N1bTZCSWRUQUt5VitnMWZp?=
 =?utf-8?B?VEZ0L0FoaTEzbEllcm9UbkhKNER3Zk45V25ISmUwK09vL09sZnhuTlVwaXBK?=
 =?utf-8?B?eTRuQ3RjdGNmUUE3QjZ4alYzVis3cnVrRXU0NXBpWlp1OGpQaXZYQUJJRjhX?=
 =?utf-8?B?N2k3VFZkc3VSb0gyc2dCSktqSi92aG4zdEJrbmlKWTJIODhPRnhndUVHdEk4?=
 =?utf-8?B?ZzYya0VISms1clU3MkZmMzQyMXgySG11WmttcXIzMzF0RjUzR21qNEJ2NDhi?=
 =?utf-8?B?N1VJejE4NEVMejRjQmRUYkN1RTB2NENVUGl6WnNNVFIwTWhVamh1MVJ3UE4w?=
 =?utf-8?B?NjQxK0VSZGtnWjR2R0M4YmZmYzZ1ZlVLWnVMRWtLVDAxNXUrOVFBWEVsTi9J?=
 =?utf-8?B?enJ1QTFDQ09ESk9XbTNnSW5qazFvL09mUkFoS3Z6QU5wcXczQXAvSldsZzZN?=
 =?utf-8?Q?uJ4n5/iS0UE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4186.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWJPMHVZME5EM1JIeWROb1RtbHFkSzNNZ1pxdjhJcUh3eTluU0JHTitTL09j?=
 =?utf-8?B?clFEc3gyL2wvTFJqRFFQcnlQRng1SG4rOXZURkxQVVcwWXBJUlFNV2xWTG5T?=
 =?utf-8?B?TzdpaDJCSlVFdDZ4UlVzTzJxOUI4Y0dMTXBCd3NuQzFnRzY3S2tNbVFRMkVh?=
 =?utf-8?B?bXRBSVFrZmNrUlVqeGJhdEhMM2NraEpDeDNsMnJBS0t3SEhKZHh0NnJuN1JV?=
 =?utf-8?B?c1R6cHkrUlY3YjJxeXhOQW5iSS9VUTF2UXErYTRwSjY3TWxhYjJaOGVMRFcw?=
 =?utf-8?B?aEllZVh5KzhKc0VvRnozWEI2Yi9LMlNLRWxyVnZybHM5aTl5YzVFVDA4bXZU?=
 =?utf-8?B?OUZHSVA3MXBmWVg0ZWl2ZkdLZG1TN1RUUVA3SWlHL1FlRFVlM0ZubjZZN1Rx?=
 =?utf-8?B?NkxhTm1sbHFPcGJKQTIyRTFZbjVsQWsxWEEyM3V5VUFTM0tVSU1ybXlNNFV5?=
 =?utf-8?B?TUMwQy81U2tKaG54MnhzOEE3aWpaWmtHNzdhMWMxN3hXU3d2dERRb1Awc0ta?=
 =?utf-8?B?cnhXYXZWZXQrSitXVlZOc0Jna0lmV0lHQzVKc2hDMld1VzRwYjFUaUUvQ2RX?=
 =?utf-8?B?M2UxN0RYY1lsaU5DK01selB2Ty9lbVN1VXgxRUtVZ0hMUElBRHQ3eFV1bi9S?=
 =?utf-8?B?K2xjc2s2N0dQMzlKNkZpK1FxNm1pRWIwMWlQQ1RQNTF1L1NmWXljYnlZdDJ1?=
 =?utf-8?B?UjduRFV5THVvY3A1M0VXRjUvKzVIWCt0OFZ5LzRPeEtJV3AvQmZUdTAzaTZX?=
 =?utf-8?B?MHBhVnpyWEJIZmh4NnhsQkFYZTVmb29tZzluZWxRV0oyR20ydUNiVFpKaEVs?=
 =?utf-8?B?VXdxL0F0YndYRU9YdUpTemF5YUZMcG5JK09mRlpUczhydzlHUUFFMjJ4c1pK?=
 =?utf-8?B?RFBERWxWNWRyK0kzbS9RalAwYVlTQ2QvMDJwTFFmNldWVzRyNzlQWS92enlz?=
 =?utf-8?B?eU1RK2VmbStLb255L1k5VkdxTWUrS0kwb0xONFcyeGpTUmJ0cFYrcVk4aEZ5?=
 =?utf-8?B?bmFtZ1FaVEtkajFQZUlBWWlndGhUTDNFWEFUWjdBTndpZUwvZy9IcG9wTGxy?=
 =?utf-8?B?WG84dHB5QVM4TkpESkxGNW90dVF4bmNMNTNQVmpWTkNpUTlhZlBHRFQ3SUZJ?=
 =?utf-8?B?eGg5ZTJydUVzT0hQUHkwaGlLWUQzdjQrR04xR2tTeXFhQVRhbmtUWk5oTTIr?=
 =?utf-8?B?ZVRaYW5hcVpQQ2xIekJUbjhTY1lJT3BsOXREck10cnlRL1Jndll2cy9pUG1z?=
 =?utf-8?B?WTJmQ3E2bklON0hCc2tmL29hanIvZDE0UnhWNi9WdVR1YmRTeGErWm9uVENl?=
 =?utf-8?B?dHVseUVGWUk0dVBjc1dwTDBvUWMycWU0UUhoTStvSW1sWkFxSWV1N1lpU3hT?=
 =?utf-8?B?REFkcWFJajFJVUE3dEJwdW9CRFl2VVAzTFVTaGIyVElra2swa0ptWkIwSzI2?=
 =?utf-8?B?VWxaejVKbE0xUnpBUWpua05EQXQzNVkvbU80RHR6bGl3andieDRpeVRaVzZB?=
 =?utf-8?B?em1BaHdaMmFIL3F3cUN0NmVaUS9ZaG1ybXpPNUN4dmVZU1cyWUcwczh2eWx6?=
 =?utf-8?B?MFNUTGRHRU5qQllOeU4wckVsZlpRUE5hYmpBYTVUejB3YXQzUU5sVW01eFRG?=
 =?utf-8?B?OXNlZkRKUTVQd2ZXenc5WnlSd1Iyemd0RGtzU1pEaGdkV3VmbXJMNzdwS0Y3?=
 =?utf-8?B?ek9VOEtGSnoxNjMrbmFmUmNKclNjaE52bUJHTUdxV1QzNURRUGdEZ2hmelVy?=
 =?utf-8?B?dHN3WU5qMGJyazMyK241ZTg1dUFQNXRvOHpTclhrb3FBaUM0U1dmZHVxL0Iy?=
 =?utf-8?B?UXNpZjZPTlkvcEhCbWFMeUs4N2duN0pac0d0QUV4elBHci9ERUVWMVMwNnE0?=
 =?utf-8?B?aFNZdWwyV1I0dHoxbElQUWVYWGM0OTczdlhGZG1GN1I4b1ZSMk4rV202eUZV?=
 =?utf-8?B?KzAyZllEZmFHREVESjBza2o0YmllS29YcUttVU9WVzhaZ042OVF0ZUp0VWpZ?=
 =?utf-8?B?S3VYd3JRM0M1bDV3UElEeStRZjFPQ2RJcU8veWtZM2xXVEtGcFVSUVpiRFpi?=
 =?utf-8?B?YnZ3YjNoSGFWWlFVdHJNQ1BscjJXOWhuQXJXNTd0Y0RKOUJyNEZXSi9qRC9j?=
 =?utf-8?Q?+4qgYMl4ZxpbU0aNuX1LJTuHs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0272d0d6-2435-4cea-7164-08dd9289d473
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4186.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 01:51:23.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbrionKRWIB5Q8cjWGzaih06SX1422chnoyMpe+CPkq+gwdMGFhqe6YKN6vjg08imV6wXBasg2NY2s+k5V/dAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716



On 5/7/25 17:21, Tushar Dave wrote:
> 
> 
> On 5/7/25 06:59, Yi Liu wrote:
>>
>> On 2025/5/6 05:15, Tushar Dave wrote:
>>> Generally PASID support requires ACS settings that usually create
>>> single device groups, but there are some niche cases where we can get
>>> multi-device groups and still have working PASID support. The primary
>>> issue is that PCI switches are not required to treat PASID tagged TLPs
>>> specially so appropriate ACS settings are required to route all TLPs to
>>> the host bridge if PASID is going to work properly.
>>>
>>> pci_enable_pasid() does check that each device that will use PASID has
>>> the proper ACS settings to achieve this routing.
>>>
>>> However, no-PASID devices can be combined with PASID capable devices
>>> within the same topology using non-uniform ACS settings. In this case
>>> the no-PASID devices may not have strict route to host ACS flags and
>>> end up being grouped with the PASID devices.
>>>
>>> This configuration fails to allow use of the PASID within the iommu
>>> core code which wrongly checks if the no-PASID device supports PASID.
>>>
>>> Fix this by ignoring no-PASID devices during the PASID validation. They
>>> will never issue a PASID TLP anyhow so they can be ignored.
>>>
>>> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>>> ---
>>>
>>> changes in v3:
>>> - addressed review comment from Vasant.
>>>
>>>    drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>>>    1 file changed, 19 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 60aed01e54f2..636fc68a8ec0 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -3329,10 +3329,12 @@ static int __iommu_set_group_pasid(struct iommu_domain
>>> *domain,
>>>        int ret;
>>>        for_each_group_device(group, device) {
>>> -        ret = domain->ops->set_dev_pasid(domain, device->dev,
>>> -                         pasid, NULL);
>>> -        if (ret)
>>> -            goto err_revert;
>>> +        if (device->dev->iommu->max_pasids > 0) {
>>> +            ret = domain->ops->set_dev_pasid(domain, device->dev,
>>> +                             pasid, NULL);
>>> +            if (ret)
>>> +                goto err_revert;
>>> +        }
>>>        }
>>>        return 0;
>>> @@ -3342,7 +3344,8 @@ static int __iommu_set_group_pasid(struct iommu_domain
>>> *domain,
>>>        for_each_group_device(group, device) {
>>>            if (device == last_gdev)
>>>                break;
>>> -        iommu_remove_dev_pasid(device->dev, pasid, domain);
>>> +        if (device->dev->iommu->max_pasids > 0)
>>> +            iommu_remove_dev_pasid(device->dev, pasid, domain);
>>
>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>>
>> with a nit. would it save some loc by adding the max_pasids check in
>> iommu_remove_dev_pasid()?
> 
> With current code:
> 
>    drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>    1 file changed, 19 insertions(+), 8 deletions(-)
> 
> 
> If I move the pasid check in iommu_remove_dev_pasid(), it would be:
> 
>    drivers/iommu/iommu.c | 23 ++++++++++++++++-------
>    1 file changed, 16 insertions(+), 7 deletions(-)
> 

Yi Liu,

Should I send v4 with the change below or we are good with v3?

-Tushar

> 
> e.g.
> 
> @@ -3318,8 +3318,9 @@ static void iommu_remove_dev_pasid(struct device *dev,
> ioasid_t pasid,
>           const struct iommu_ops *ops = dev_iommu_ops(dev);
>           struct iommu_domain *blocked_domain = ops->blocked_domain;
> 
> -       WARN_ON(blocked_domain->ops->set_dev_pasid(blocked_domain,
> -                                                  dev, pasid, domain));
> +       if (dev->iommu->max_pasids > 0)
> +               WARN_ON(blocked_domain->ops->set_dev_pasid(blocked_domain,
> +                                                          dev, pasid, domain));
>    }
> 
>    static int __iommu_set_group_pasid(struct iommu_domain *domain,
> @@ -3329,10 +3330,12 @@ static int __iommu_set_group_pasid(struct iommu_domain
> *domain,
>           int ret;
> 
>           for_each_group_device(group, device) {
> -               ret = domain->ops->set_dev_pasid(domain, device->dev,
> -                                                pasid, NULL);
> -               if (ret)
> -                       goto err_revert;
> +               if (device->dev->iommu->max_pasids > 0) {
> +                       ret = domain->ops->set_dev_pasid(domain, device->dev,
> +                                                        pasid, NULL);
> +                       if (ret)
> +                               goto err_revert;
> +               }
>           }
> 
>           return 0;
> 
> Last hunk remain same as before for iommu_attach_device_pasid()
> 
> 
> Let me know.
> 
> -Tushar
> 
> 
>>
>>
>>>        }
>>>        return ret;
>>>    }
>>> @@ -3353,8 +3356,10 @@ static void __iommu_remove_group_pasid(struct
>>> iommu_group *group,
>>>    {
>>>        struct group_device *device;
>>> -    for_each_group_device(group, device)
>>> -        iommu_remove_dev_pasid(device->dev, pasid, domain);
>>> +    for_each_group_device(group, device) {
>>> +        if (device->dev->iommu->max_pasids > 0)
>>> +            iommu_remove_dev_pasid(device->dev, pasid, domain);
>>> +    }
>>>    }
>>>    /*
>>> @@ -3391,7 +3396,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>>>        mutex_lock(&group->mutex);
>>>        for_each_group_device(group, device) {
>>> -        if (pasid >= device->dev->iommu->max_pasids) {
>>> +        /*
>>> +         * Skip PASID validation for devices without PASID support
>>> +         * (max_pasids = 0). These devices cannot issue transactions
>>> +         * with PASID, so they don't affect group's PASID usage.
>>> +         */
>>> +        if ((device->dev->iommu->max_pasids > 0) &&
>>> +            (pasid >= device->dev->iommu->max_pasids)) {
>>>                ret = -EINVAL;
>>>                goto out_unlock;
>>>            }
>>
> 

