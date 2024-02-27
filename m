Return-Path: <linux-pci+bounces-4070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B1D86870B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 03:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5558B1C223C9
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 02:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5E9D304;
	Tue, 27 Feb 2024 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nTsxfTMc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3C4A29
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000856; cv=fail; b=Y6mvSSfSJv2X9csIJL0XEfjLfeXJZnNIHcZ03Mc74rNOnBRqTPr1/gzuDcca20o9XhTH3LCZDZq4WD0puEj//6iC+qU7KzJvD5DfZI5cJVpcYKqF/AUKuOUvRwhTsRgf1ZAFnu0fGfbeOv05YoPZfKQUShQofc74F8jR2NrTn/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000856; c=relaxed/simple;
	bh=fG+4QsVaPhslzM6847KkOcEGgTMrvdnMku8fxVVXo/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eLRpkOTauzrDxSRY1u+TDPOU1rRf6UcgFnGA0vIxH6aJ5IaPgtbH+9XHlEtyIPupWMp8Qsw3G+ypH7Seiweg+5SX/IFNu3w1AHlhR+zTb55pMlSwkTprGrvPUxYff2ImbQR+bd7RCQ9d0NYO9sR/hAg0DJwsfzCYIdhjQlbl1Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nTsxfTMc; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PebpLk02UmaEjr+KkvMl2UOpUKnomSzfYo/+pnZalVNYkko4Ae5yi3zKU68paR/M6zgEsjKtl9lvBcaZIG7zkJghnhNdG9ADWTbOHki3Vn9UoEinfsgirFXpN2YZAttqfMmjIhLjp+a0l0S07E8d96paLA1JEwbXTnD7VmbtlBBoV1CDLtCX8FYsnIiKAdThNuMdehkR2ZNfv6zqYdnCZ4pmdVagF40KY6Tl/8g1koBn/B9UPN3fR1MgF0aA8P1XjUjkKISofNeL+H8IVQICqn7h1BE2qmnbp8CJOM9c+OUYGAbRPUkckSgNfBrOR2g/oCw9WlupkiQf/CQWWjEcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TMw7k48qporTqlN98AsMNxEl/hEIpmxGMBM1KqUV3E=;
 b=Twc5VSM9MfNhDznsQLB1wcZcmrdCTkdHl+8vtEzsLdTV2vkJVE2HSAdgrcRzcaKXLYf1o2wMBJD0X2WU4JubU+cxYoEMUt2K1dU4gNC2V40RIyMq8NIoCwfni/qWuNrZIb1rjWAbfw/7AWGnt2uoOpQu+mur1aOam3fz2gCyJtne/geemVRxcYQWTHIsHI0rWWgylzoTij574+dnirD8LoTVyNa7Qf4iq0lAZuf2KlhGZcq9w+Hp4GC0Y5eJDKnhqSvlKqXJID5rykfXBWvsxkZACcaS6ALu4JmYNNMhxmrSCnIERzmigi3XQ5N3+Fr/75C0RZMrLTIdL5RRGM+1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TMw7k48qporTqlN98AsMNxEl/hEIpmxGMBM1KqUV3E=;
 b=nTsxfTMcM7WoCiFIL9vppoAfMQJoA7T2lciyX/vUCdPFwN5EMQL68TUNx5S+r9dc5sxttyPOCi7whbTa42HJZVRAtUiLkc7WfAhC4orI0sW40L3x4G0VrX0vpPfbDlT/gC5Ulg6ow0TFBsMRwj/FL51eDraC9RMAOL+WdVDIunQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 02:27:31 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::ed15:6173:2f14:f539%4]) with mapi id 15.20.7316.032; Tue, 27 Feb 2024
 02:27:31 +0000
Message-ID: <382cdd08-c447-4e4f-abdf-0d5b55e37959@amd.com>
Date: Tue, 27 Feb 2024 13:27:23 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH pciutils v2 1/2] ls-ecaps: Add decode support for IDE
 Extended Capability
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240226060135.3252162-1-aik@amd.com>
 <20240226060135.3252162-2-aik@amd.com> <20240226192444.GA22489@wunner.de>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20240226192444.GA22489@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 454f6eb7-3cf4-4eb8-56be-08dc373ba62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SB97aIdz+LHKju11AT8VMbpVrcaq3UyFMGabhcQV5u33q1zcm0vaJQWLCDww8x1E4zjSVVj6otRGf1AqgGXR98xvcvwUeqx6BWYUmBdGoF4EEv/vHjv5fSDUHLFn0zbEm6oA55stBUYuBiY94y1oQBC9wSr/m+cA0LeFaH4+QOb7cmVDN12kRaBn7MYZ+mMsqb6O4AfDX5EOXvitICjMNZ/LNJpQ/ShkNMUBNuhsvasQJXg39aBXlH0rcynADWtbsw4DkHT5VOoaXfWCN5mw4UW0Vx84G/oaIxPQs7DGyVAo7h4YczxdDwgLt50930DhasqdVWsUxydHdbzGqrsy8sqjh39jC9khd/uov7nuagM1nWmNzPrXnTHesn7YSI8YEPf1Im7Rr2F/GOEL6+L7CSm4tfSX/do+En5sUAJEYxVArPAfduDs3t+0B2eBdgACaEWkNIByVXCfbGmWwlIxUtiDoqoEIKbJZLzzlLGXk9oD3+5q1P5Mh/wRA5LEheZOF6IkKULi7BnDVgKAo4VNSJEjf8YjQ4g5pmgzdEJC73e7mEjnGVqTjc1sB0lP+fZ3DQY+W6sRNKq1OIm/KYABRX6LTySeCEnzURHNvh37wm6HkfiqSR2OSQvDmjbM1hD6vDRrNBbyder4KS2P4a+mVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3BvaTRkbHhYRjkwUEc1dTJHYmVuYlJkcGFJQWlkdE1DbXkya1NPQTZoUWFy?=
 =?utf-8?B?QmFBTWlZVTZ3aGNFcXFQczlZeG1xc3JhdFE2UHBSeCtKMklYVlZuMmpNdjFv?=
 =?utf-8?B?VExEeVZWM2N5QllmUDM2b1dlRXRkOVFsazU0QmNNdkV4ME1rNDdMSUNzL0hB?=
 =?utf-8?B?TkJZZnpmQThwZHpmZjNkSUVaNVhpRzZsRDdDUms5WGxiNjlLQmNXQUUrVEsx?=
 =?utf-8?B?VzZOWEtuQ3c1UlRvMS9jNnRJZ1QzMEh6eXhQaU1ET1ZqeVIzSUNBZXlDVldW?=
 =?utf-8?B?MFg1eTJrSFI2QytBRkZwcTJtVmpsK3JESzZGcVNNenR6QkJGNm8rZDZCdU5s?=
 =?utf-8?B?bis4YUtGeGdYREdxdU0vbU1rN0NmcFZ0MXlBRjVYOCt2YXpHcFZqb29OdDFT?=
 =?utf-8?B?SUYxUmpZMGc1TXNBUzlUaXc3ZDRwblp6anZ4UHlOSUtMbll3eGRFSzY5SEVn?=
 =?utf-8?B?bHRTeWxtSEE2dm40RStlRmVmdC81b2JSQXNpQkFWeTNtTTF1WlpqakpKZGFH?=
 =?utf-8?B?OVp6OG80OE5vU2hQUDY2b2JHMnJ3VU9DTlYrNjBhbWc1aTZrYzlOamd0dmNq?=
 =?utf-8?B?UEc2amo4aytZWkZnZk5WZ0ZqbG03cWpqQ29laHdxaEkrUXRXZWR6VXovRXhj?=
 =?utf-8?B?N3d5YTlCbGRTY0wxaGZHNlg1aWFYb0Ira29rTVBIRHRlMU1qbVFRQmRaN1Bo?=
 =?utf-8?B?Ky9ab0R3SjVDZGo1U1R0SVA4QlNVSDQ2ZisweXplWm1iZXVJV01qZFRWNzEx?=
 =?utf-8?B?QnE3SmFlUmxYNk8yUHdYTGI3SkNNVDBDcEprRHp2Z3Z5eHVSeWp5QjNYeTZU?=
 =?utf-8?B?dFVKUGhnSzdOS285YitlVnRUaDhBUENIWjNTSytyMTJ2MVlYMlY5OHEvMHI2?=
 =?utf-8?B?Rkd3a0F3ZHFFd3RlUmFlU2QrZHpSZ1dwRW5tZ2kxWUdOUGVCTFk3cTB4Ynpq?=
 =?utf-8?B?cVpFZi9nQlZ1TnVLelloSm5HVUNRTjhuaUtJOERTdFo4WEt2dzQvRWxqc3ZI?=
 =?utf-8?B?ZUpVUENSV0pkbmI4SVA1d0MrVEhhOVlrcXJOTm8zbHhEc2RuVzE4MnRmcHl4?=
 =?utf-8?B?Nngxbmpsc1k3V3Mycm5xemFzUzR0Qjk5ZjZOUzh4aTBGREZwcnJjVGh3MUVy?=
 =?utf-8?B?OFlZeFpFcGg2cXNUempQZWhaTzFDK0dKaWdsOSt2TTJkWGFja1h4U3BVK25V?=
 =?utf-8?B?OStjZlZEL2hORVRLNzVsMk1qbDkrUzBRcGIvaEVQeGx5RXV1alZWNjU1bFRV?=
 =?utf-8?B?bWtTQ3JsVktiWnhUdC8raXZHZUpIOTc5OGJZWm1MK3A2SUdFWC9VQXFIZUF1?=
 =?utf-8?B?NFJiR3N6ZzRsQXZGNjNtZnpiYnNaNzE0MDh3L3hSMWFzcWFPNWpMRDNldVVz?=
 =?utf-8?B?dURmUytITVQ4eGtxang5UEEwRVNOWjhYaTF4ajFaM2d6V0o0U3M5ejU4Zkt4?=
 =?utf-8?B?ZC9ZOFlrZFB1cVV4TkhIeGxHb1M4ejRhcEVpSnNsY0txK1RMcVdJeUszcXNB?=
 =?utf-8?B?NmVSWDZOZUNHOG1maHFHaVNEL2ZMNytKZUF1S0trTzhDQlRxNnFlekdDK1c4?=
 =?utf-8?B?cUxsdCtFdGtEL3U3MzhzZUYvbEw4RTNRa016NVEycGRnY1JmKzF0Zncra1Y2?=
 =?utf-8?B?NnJ3M252UXVIY0I5OE90STlUUjE1UTJrUU95eXdhbUhtMmkvWmhlZUxkS0t0?=
 =?utf-8?B?WDgxSUVrclJEQTZOT2VSRmxYWVRmVERuM3h2OFNIaHprRmdMWXJqUXg3dE9x?=
 =?utf-8?B?MHlQa0xxV1B2K3RhU0h0MUtpeGpUaDlkV3I2a2VHRmxsZzZCVVptd3BDQWJt?=
 =?utf-8?B?MW45ZittS3RXM2lyMHE5NUlkdGQyNytoVUgydnB6bWZtUC9KOXBYSlpYaU8r?=
 =?utf-8?B?eHpKVW90cVlUbzQvbGpRdjlBd2FnYVFTUjVrY3Z2cm5kWUV1cEFHL3lXWDFM?=
 =?utf-8?B?b1JtcFBsUmVpVVkrZUwwU2o0dC9YbHpYNDlvVWNyMHU4UTNVclNSdVR3VnVR?=
 =?utf-8?B?eW1TalNoSkpPenJlT3FwSVpORTFWeEo5NGVVd2tJT2U4N3g2OVcxWU5ET3VY?=
 =?utf-8?B?c0RpRXJLcG9rZzBtMktheTJuY2l6V2FNeTg1dzVCMncyVjlWQmFSNHhhU0dP?=
 =?utf-8?Q?e9UxOgE3CNggVd5XQRzcWqKif?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454f6eb7-3cf4-4eb8-56be-08dc373ba62b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 02:27:31.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2AOuQyBl10KYcKScGIg/EcPfuW8XD6HqkKUC60lbTS7ihwyLDzSX4/bP0TPe0w63E5HrDWYp9NkGz/l/drz7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294



On 27/2/24 06:24, Lukas Wunner wrote:
> On Mon, Feb 26, 2024 at 05:01:34PM +1100, Alexey Kardashevskiy wrote:
>> IDE (Integrity & Data Encryption) Extended Capability defined in [1]
>> implements control of the PCI link encryption. The verbose level > 2 prints
>> offsets of the fields to make running setpci easier.
>>
>> The example output is:
>>
>> Capabilities: [830 v1] Integrity & Data Encryption
>> 	IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ Alg='AES-GCM-256-96b' TCs=8 TeeLim+
> 
> Hm, I'm wondering if the Supported Algorithms should be listed on a
> line by themselves, each enumerated with a '+' or '-' indicator?
> Maybe that's easier to parse?

I'd leave this for later when PCIe defines another one (or more). And I 
was hoping someone suggested better (==shorter) acronym for the 
algorithm, may be just call it "AES256"?

> In general, I'd prefer it if the output was linewrapped at 80 chars,
> (i.e. begin a new line and indent as appropriate).

Well, too late, there are examples in "tests" 114 chars long. It is 2024 
after all, everyone got a big screen, even Linus :) Thanks,

> 
> Thanks,
> 
> Lukas

-- 
Alexey


