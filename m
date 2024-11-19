Return-Path: <linux-pci+bounces-17071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6A9D25B1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 13:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660721F24D15
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A381C2317;
	Tue, 19 Nov 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4CEGN2zA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0E8157472;
	Tue, 19 Nov 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019030; cv=fail; b=TXT7hilAkIpnbjYXhHA2OqoCOVNUDQ2VjUbCsJYWPx9rT4wn3/vR+SDIvcZtMWmyuVNgYN/F9+Ml00axM45kzGFyneht93nyBnz0oATbNKvUzC4VVdhRwICjH9GpYpTvBeICsJUtuL6qRVHWZiIG5hZdikY/BHfeCIn33oLv/ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019030; c=relaxed/simple;
	bh=RS6GOhxg7GeuyodZ+1AN3L06BvMKTk8hwc/G4+MaO1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YiVZqEVa3Yx0CTVfRLuquyPmP27Dlxnl62aRgLkCHMcvFXP1r+LJs91Ra9gUGhx1kFOHbazaerVFG5zVete2z+WcL2Ea70EZQoSa0EZIBYPWNUgJVxmWTmava4om5zZqGVEsuqO1Wak2PIV8vTcOKx6dPs6T/3zyQ13lru8Hpx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4CEGN2zA; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMu3dVvlUZkZ5dwnBIH78GYb9gwWfqw2QaXhGvkL6j8hg3B8b9kvDuO6tSTYbmbc6bA+Qt6OGof87A5LJIO05cKsODKXO2eDtpUPbQvu31gy7U4iAfUi7s9OmkLWlEtaW/TaB1VVK2DTyS50b96u06/vQvh/fQVcBHU3a4szBZVEcch+PtbtBo4UKDkTjgbkMmiB2EGdOWFBb7vtL0c+KJFB3Tb9AQbugLt7ZOfaLx7PHRMpM0xxSCxerlf1PTitCH56Le4a2k81kwGC/uNPQgahnqnzOko4aQx1X1HqDnsqduSL6URKd0wCdP06DFa/52vg08dDApqkryofYRX+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5vrRi55n2PxSxi3GpxIt4j4/SD3ShhVlL19K8SgEoY=;
 b=vg356KsODaq/51t3Vp9NEM2LeBKIqFJkuvjT3h7z/78wZ1bJK1IYhQ8SRPY3jrB55SNwZhpUik/NMSbdmeDvGzBB7qP7Y/HVMSIbdG/oO1fE747AG5NEHF4gbj1sXlt01ayt3OF/6cskuVneL30BVnXhQtwkFuecibb5WDneLG4NvZBV9KOqavCmXUA1HCtjsmNddgC5DBb2vUPvJC0MZz/0R3BsdJSvcwflFUtWI0RtngNUn1YuRJXkxTsONeM5N2C3MI6Fmn8lD+1Pc3ZXmXaPHf80XPgfb1iD8wlo99fgDLh65wshyEJa3vw+hmdDnbqe+XgfggswPuZcqIfZtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5vrRi55n2PxSxi3GpxIt4j4/SD3ShhVlL19K8SgEoY=;
 b=4CEGN2zAufY7VXnjr3sZjIL5DF/yAxR35aI2pHYIj7prV+fpH2ayXRDLE6YXU3RvRiTgmsdg6aCwtsQ2EjCZHe7gmMRQ/ww3HsYO3K0SLMX/ENlFbeLnI92IAsR8ehSSVRs60S9MIrfgzD61eFWf4zWbw8TgHeuUC3tUqcnzXVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Tue, 19 Nov 2024 12:23:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 12:23:46 +0000
Message-ID: <6e099326-77d2-4e50-81a7-58fa1213da3c@amd.com>
Date: Tue, 19 Nov 2024 06:23:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] PCI/AER: Add CXL PCIe port uncorrectable error
 recovery in AER service driver
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-8-terry.bowman@amd.com> <ZzsYzN5QALTko_Ku@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZzsYzN5QALTko_Ku@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:806:23::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 69945eca-5181-4570-2358-08dd08950387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2srTnJUbjU4UGd0NWhKSW4rLzErbUdpWmFlSENMbHdVc0c3MWUrMUFmRldV?=
 =?utf-8?B?SERSUy9PVHhZY1hjdDVqOHVSSnNPbmJUbElIVWE1dXZoN0JPL1AvT2tYOCt3?=
 =?utf-8?B?T0tDYkEvTFVlbTVDemZZTlFrSmcxVWwxeE5mT0FJRXFEWVVTbWhxM3JKZ2Fp?=
 =?utf-8?B?MXhUYmJBTUZSK010U3lQTmhGUEsvMjZKbzRFMm5uQ01wdktPOEhhdVlXSDVH?=
 =?utf-8?B?ODlKb1ZmdDB0VkZIaC8xaVNtNEE4V3p2dVhqNE1Fdkh4RjVLc21EVEdhQUh1?=
 =?utf-8?B?WHdBb0tuSWhkSE8wZUpyWFBtNUxkNFdjUGJhSktIWDNWNFNmQzB2ZUh1OG8r?=
 =?utf-8?B?YkswUjFGQWlTZEtQL25hc0ZuKzZkNktJT0grKzVhN1dyY25UMzM3ZnJtdEcx?=
 =?utf-8?B?UXllOWY5VnZYY3I1aDI3cGtVUERhbmVMOWJOYzMxbUozTEV5WkhiSDVCcHN4?=
 =?utf-8?B?VWpuQjBxT2dtV0NWYUFBaCt4bmEyV0xZWjNhdGo2ZE1xYmtHZ05rR3dReVc5?=
 =?utf-8?B?Z0VJRldRc09TMnRvaDNzd3VHU1pET1VVQTFrdmQ5Z0FmMW9FaDdLVmJzRWhp?=
 =?utf-8?B?ZnBsSEJ2WmpLSWI3bFNKUnlWMHBvcEZQOWk2c1pyZGpSSlRlc1B3YlZhQ0p5?=
 =?utf-8?B?L2JEMGh1Q2QxUkFRNlhRUy9FakdMRjlwbU5md0MxK2NpQmdmM2k5NDhxSk11?=
 =?utf-8?B?OG9HbDA5QnFTK01ST2M3Z055dVZqNE8zM2x0MzU2NmlrVHNLU1psREVVWVcy?=
 =?utf-8?B?cDFSNWxZQmx0ZDZkc0xWV3RmSWtYaCt0OXg0S3VkckJGdlc5QXFPY3dXNlI5?=
 =?utf-8?B?cnhXWWZCN0hTektiWnVwOVlaQnJJcjhmRnNEbGRMWjlnWHFuSUlIS1hkUVBS?=
 =?utf-8?B?NERkTnpSZkVRbkFKQ0F2M3B4UVZNbmttek1kbk5yOWZMbTVtN0JTRjkwMThj?=
 =?utf-8?B?endvMzhYTkMyNE11eTdibWw3dG9VUjJ2RVV2cXNRVHVjOXVTYVRHVGlvZXlY?=
 =?utf-8?B?bEJqSURKMDBBODg2STdHR1RQd0F1ZmxtWGVybDRPaGY0QXgyeHZzZjVHMGFG?=
 =?utf-8?B?VGxFVktOcEdCNlRwYW5iSlR4WXpFSW03TTRVUUVPeC9sSnZWbmdsOFlrN1Ba?=
 =?utf-8?B?TTk2clljL2ZIZ2lxOGIzeWhsZmc4djZzVmw4d1NDbzJtQ3ZjQTZUY09LbWM4?=
 =?utf-8?B?eFF6RUcyTzQrVUhqWC80WEkwa1daTjJ6VSsrTTlITjhyVFJYUkhnZXVMNzdQ?=
 =?utf-8?B?VDI2anBUcHV1eStCcXd2OFY3OGMvMUpraGpMcEJncEVzMUlvWTY5L2taRVVl?=
 =?utf-8?B?NXRpUm1vNVpXVHA3ZWozWVl4TWJIY1ZsMU1OL0toUzFTRm1uL285eVdzU1hk?=
 =?utf-8?B?V0E5NGdWNGNVRTFNYmVZOUJodFA3Z3ZsclNSVUVnSHBhU25tcEJqSEE4NEZx?=
 =?utf-8?B?Q2tzTkpkcmdnOStjcy8xYVdYWmpuMTJhWTJ2Qy9QRy9Bd1Znd0xhRlhKdUJw?=
 =?utf-8?B?RjR5TVBPbkg3ZnVsOUFTU0wrRnBFZkJhRmtHL3dvWjBXZFpGTUNndmpVKytY?=
 =?utf-8?B?Z3NkMVJrS1c3V2YwTkloK0I3eWpYRG81UWcwNkJiYTJiZDh0Mm1EN1VCbFFM?=
 =?utf-8?B?d1EwSTN0M1pFY0x0MWlWNGEyVVorVjVVSlZQcVJkUHYybHBHM2xGRXRaeERp?=
 =?utf-8?B?TWhmODcwMUpkc0s0bGR4blVTRTFjcmpEVFZZNUdlNTRkdWZ6VDRQY1NDcXdi?=
 =?utf-8?Q?wxzOSqKYnlmUBo39fXqwZ7WwrobQG6QAilJXNT3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkhJd0lFa1RTMUc3dEtrUFJld2oxb0lrbDlGdFRVOGpKTk1xb3o3YjZIbnlG?=
 =?utf-8?B?d3pvZm9mRjVNUlY1Y2N0QktvRFpTUm1zandXZDd0L0t3MWhQckxqZUNwR1kx?=
 =?utf-8?B?Qk5kbXp4aDdocVd1ZHZKUTliMTBOZERXQWdQYmwxTDlmc0xwVjhvRDJSK1Ey?=
 =?utf-8?B?NmRoVFVDVEZ4ekI0dFR1N3EyWjdGVXJzbmp4S0pBTjFqT040RDR4SDc4U2Zt?=
 =?utf-8?B?eTcyWnZqNG0xZUFJM29IZUt1OVltcE1BZktNV2ZOVlMxNUxrQ2Z6bGdkbDRh?=
 =?utf-8?B?N2kvU003cnVEMXBDQlFISkJaN1FveWFZTFJ2MkF5V3FRUm9BMkhOVERBUGZK?=
 =?utf-8?B?RXg0VDNCTDRVUEh2VmQzUHBHSVdoaDdhRUNIaU1OdFM4T0oySTlncmJQY0dG?=
 =?utf-8?B?S2U3Nm9kREVFTVFvQnRFVElyNXhCSHh6TWhLbCtsMFFRYWhzSW5CYjU0NGZk?=
 =?utf-8?B?QzBGdEQvTVlqNnNQWTZ1TlNyTWg0ZGRtbk5MZm1DaDdaOVFSbWRqZS91MzBR?=
 =?utf-8?B?bW9QVDBVUHhueDFrQURUand6TmdNTEl3UTNMSFBvSEJ0NGV1UGNmLy95WkNv?=
 =?utf-8?B?WFBPdXg0R0xpbE5RUkZlMGNLemRJckNtcUpLVm1ldUhkbVFXMUNPN1F3eDRw?=
 =?utf-8?B?blQ0YlBCalZhWWczVDI2K2JzVUs5Z3E1RFphVndzRHdnSjB1YjRITms0eVFD?=
 =?utf-8?B?cFdJTjdIWUc4Umw1VjRmNUJHZWFoZWFGbE9rZXo4Q25HcDNvVVF2WWJrTDlU?=
 =?utf-8?B?NUpnTkxEUG1EM2QxVUxzNEs3VldUQWp4M0M1T0Roelo0bExJVzNSc0dDVUV2?=
 =?utf-8?B?LzVFZnc3ZUF2akk0RFkzeGJ3d296UmdiR3QvQXBQdGJISVUxK1FGMDgyQkFh?=
 =?utf-8?B?dCtyWDdhS3FPcUVCRTlSNVU3VkZ5K0VYb1lsaHhOQkVSTE9NU2tMQWVySHE3?=
 =?utf-8?B?enU5TkJOK0tJdFcxNzFqZkFoMFRFNXBXMXZFTlpVeDBBK3JoMFZxUkRwNkZT?=
 =?utf-8?B?c2FtVG5GTGRQKzBBYUlCYlBIVFd3Y1h0cVRXQ29zSkxFdnBYdlJHRW9QbzZ4?=
 =?utf-8?B?TFo0TkhDZW5Bc1czQmN1eHNXMS9LOWRYK1JQTzdzUHI0cDRzMG1XWGd6MVAy?=
 =?utf-8?B?dlg3bVAwcmxuM1I3SkJ6Zmc3dGtKODlwQS9hOE5PcWsxZEt5dlVDREVZZlgx?=
 =?utf-8?B?VWluMzI4dk9CdWRGbnNpUkZmMGhHdWhxdEdJZklUZ0lweUx3S2ZyZ3JkQjFO?=
 =?utf-8?B?OWYrWjBmSXVVejBjb21kVlEwR2sxQkpJQW1WYzVadVE2Z0ZrVDBOdzF3bllM?=
 =?utf-8?B?V0lISEgxbmQyM2pvYllBMHgzVzJST05xaGRUeWNHcFVuSk9sSjA4VzZmc1B6?=
 =?utf-8?B?aTBEVklNSHd1K1JYb1J2M1VaT2RYblhtRzRoNjVnMFdXR1NDV1FBTWh5YmpL?=
 =?utf-8?B?dDAxOTgxVms3ekZyakd6ZFltaVo2MStVeVcvbnJKSHZqMWEvR0lzVW9PakRW?=
 =?utf-8?B?Wm9QZ0YvWjhBU1RBQTNjTTBMN0RtNDMzbW9YYXdWUFBxT2lKdXNGejRhNjcv?=
 =?utf-8?B?ME95dkVUclFma1BLUm53WG14WkJzdkcvS0xyWEY4czhJM3NYakhLTFlTalFv?=
 =?utf-8?B?ekQ0RWhzQ3pVNm93Z2hmNTZtNzhEZnFobjhtWjV3VU1IY2lUMzFieW5vbVFz?=
 =?utf-8?B?clBpQ1Q2L05qOUJkeUtZS0E0ZGlFRzZZd1ZTN0VLblFWUGQrbVI0ZDNkSGto?=
 =?utf-8?B?RzR6Tkd2RWdJL1dIR05FeDA3aDdLZG5KSFJNL09taWthYzVWMHZEUUlPQk1z?=
 =?utf-8?B?bFR2UDI0bEhRSkwvc1pobW11c042SHJlRDVqeGMvSW91RlIzNURvaUllYm1k?=
 =?utf-8?B?RXFQVXlYaE5QNXFsR29qM0xFbVlqeWZKb1Njcm1rcjExSHlwM3EzTTlOc1dJ?=
 =?utf-8?B?c0NrUHNvZFZKMmw2TE84UlpXLys4N1c1bVB1dk84VWFnZWpHWUFNdFI5aTBF?=
 =?utf-8?B?OEREWTM2SmJrL3NuTDl0UzNKNUdVMUdYYnBya1RDYU5sWHFzd29MbGFZWlI0?=
 =?utf-8?B?NnNkeHY0SGtEU1d5dHp2azlnNjdFZDJnMnM0ODFhRUFNb3g1dGkrUkhwb1FF?=
 =?utf-8?Q?tiWATCusMLNtMXBJ9TVY0zl/4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69945eca-5181-4570-2358-08dd08950387
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:23:46.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xnr9Y7Pk9n3QaMmwYVtvcdHbI2JK7al2H/BDjg+d703wY9UmsN36Ii3jXZsyOOv1/s0oGkOQRVAA7/w8LrAUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493



On 11/18/2024 4:37 AM, Lukas Wunner wrote:
> On Wed, Nov 13, 2024 at 03:54:21PM -0600, Terry Bowman wrote:
>> Non-fatal CXL UCE errors will be treated as fatal.
> Hm, I wonder why?
>
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1048,7 +1048,10 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  			pdrv->cxl_err_handler->cor_error_detected(dev);
>>  
>>  		pcie_clear_device_status(dev);
>> -	}
>> +	} else if (info->severity == AER_NONFATAL)
>> +		cxl_do_recovery(dev);
>> +	else if (info->severity == AER_FATAL)
>> +		cxl_do_recovery(dev);
>>  }
> Nit: Maybe use curly braces and collapse both if-block into one.
I'll make the change.
>> +	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
>> +	if (status)
>> +		panic("CXL cachemem error. Invoking panic");
> Nit: This will be prefixed by "Kernel panic - not syncing: ",
> so another "Invoking panic" message seems somewhat redundant.
>
> Thanks,
>
> Lukas
Ok, good idea.

Regards,
Terry

