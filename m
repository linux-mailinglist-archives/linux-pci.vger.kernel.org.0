Return-Path: <linux-pci+bounces-15009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995029AB00B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53148281B92
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B719E985;
	Tue, 22 Oct 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TTJStwT3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1A19D06A;
	Tue, 22 Oct 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605030; cv=fail; b=Rr+hnjywo7FUvmjiTHsKIOjyXM2Fz/GBGye4xdgduBRTnvS5AotQmXjXHGJ2xkunP8eGHGtZUpbI0cnYIln1TLb6t1sj/zUsTWioh5aQFq7izJlDJNboEEU0U7WztQM3DBaIdJy27iIFxaOAF+ENLyHjO8iNZoPB6uZz6n5U5dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605030; c=relaxed/simple;
	bh=++WsmTMQ0oL5vxTsbJTGCxPaYx4ws5ej1sK5QDe5Cp4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PCeNKLv1zzyrX2LF/9Lkyxh4O14zFGZS766fDM0LpS72uApSbGXvYKUYKrzRGclojwqXemyr+/KLpHmggyy38aFEB1Zhr56RX1DOBhf/S2EluJbydLRg+ZUxKUcujaN8F/Nxg40GILvEJtLIWIVm9MR1BVaMzPzrivKIUhU+2bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TTJStwT3; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSm/dinyMivnpnO3JOPfOa5LGIPJanLZ43ZZQjmkSub3Z5+7gAVjVwdl/P0/NBeDVFrRPgssz3fn8REgUHx2K8k/TF3NTWnSMxNiUSMQlclxvrgV3fQdB/988KpDzDUH2EMmQxHaBlAIFdyCSyt7DwuocbC5RbUydPvH2b4pJ7MANdhBzSljk+LfA/s8hagyP8VKrRtAduzzhlstEm7w9wkOxO8q/LAAEkfJxu9iBtK4uFFDR7843W+QvkWF5QADyK/tGrLyUA3TYUUDSrce5HcmmIJrKC1nSdStt1FviYE8SfgIGzt8V1ACt9jntahUUJo2BdcsEuS4GiLiNEzAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syTm9Ae2GielQG46dFf6BVCZKvpcHU15h8tnGsrnv+8=;
 b=I8QZIgMyBGI4fINtoeBSpt8Maw5O/TkPAp8SuF7f0MtLlk6ceGdqodZfdE6hBsfvy5Z6FcWwbSYGE38bvgfRR/0XkIjns3M08Sunsgui2/tzQPvLCd1GGAWms+FazyWDT96MI8HQUOULzMbSdGnpprfyVPqtcjCq1ahhTc/Ow3nkWFTWxnK6jeNtnAlqi+ym/k7pFv4WdsJ905JlrMf4gp1WotFFMlLRmld0ti5tEidKz1HiyYtOF8CCXueOFVblSeMuLF+9sQ5D5sRHzBCybIOrtxbKUpvHtSLrtSWpvZC9CCGlPIVB4n0Qs5QQcxE716IjFtrp8Rr+DVR/pkMing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syTm9Ae2GielQG46dFf6BVCZKvpcHU15h8tnGsrnv+8=;
 b=TTJStwT3yvtz7swjYnMATb+vXOEfDIcrLk/G7tzo4v1EaXGF0yjj7zM1gPmvcullnhHdmrW+722kiNUwdW742bhsPpYmolQQBOQKSmg4dLyrMNnZ9pFbTmcQnYTnGTMb96676niCbotamBC/XqcItw9/mmQaorOnn51/WIMFwmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:50:24 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 13:50:22 +0000
Message-ID: <0cceca3d-f69e-4277-bc9f-2556fd212ebb@amd.com>
Date: Tue, 22 Oct 2024 08:50:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] cxl/aer/pci: Add CXL PCIe port error handler
 callbacks in AER service driver
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 Benjamin.Cheatham@amd.com, rrichter@amd.com, nathan.fontenot@amd.com,
 smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-2-terry.bowman@amd.com>
 <671705b5bb95b_231229468@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <671705b5bb95b_231229468@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: b9da7491-d16b-41b3-42fe-08dcf2a07910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFVVNHZJU0xhMDVjNnBERmRtVmlaNS9yUEg2ald6SzJPNUx1U1IwMEQ2Unh5?=
 =?utf-8?B?OGZKNHI3VUZUN2tIdUhjWlgyVnlXQjlocmJnTXJvbmpNZnBXcjM5d0hRZHgv?=
 =?utf-8?B?VHIzU1FYbnhzQ3dLY0NUZHVlTVNHMFdQVy9QM0FmME5uM0c3bG9DMWV3UUpi?=
 =?utf-8?B?djFvcjkzdDRPWHBzTnFGVTQwbVVCT0JRQjRNUDZIMUgyNWdWMUVLcnUrV0ZE?=
 =?utf-8?B?dEc5aVIrbU5ZRy9qODVXdHZuZy81UjRSU0xrUi9qUEhMMGFnMVpWNW9xSXBi?=
 =?utf-8?B?RGNiWUpHbnNkYTljSzRoZ2VtVkE3UTdubmlrZGpTbkxhajBMT01qaFcyOGFt?=
 =?utf-8?B?ZlZNbjc4bXBCZDBIRWFXRmlISUFqdWNoMXlzcktFZ0lObzRlUjZTcmwxbWNG?=
 =?utf-8?B?UzRobkkrellvdU94QS9pWkRWSG9KWGgvd3g1Y3lSWUpCWjh3VFg3ckIvRnlJ?=
 =?utf-8?B?VWd0dHZ3ODF2WXNROUQydVVLclcwOTI3NVcxZTkyWDM1UURlSmhWeHQrMjVR?=
 =?utf-8?B?QlJ6dXkzKzJub1NlaStJZmQ4VHhaS3YxQnZkK3J4b3hLTHVJWGFMeEhuVGwr?=
 =?utf-8?B?ZTNkREYvOXNYZG5iOS9NRmFBdXVNKzkzNmRVVk5vRDZqbWZOekJ2R2hlbzhQ?=
 =?utf-8?B?MUQrL0pXRVEydFlXVjIrQXUvZ0ZzVE80UUw2eWRKQ0ozblNzcVZXYUdoV3pq?=
 =?utf-8?B?bk1pMmUzclI1QlFNaVk1ODE3VGJaZmZ2WFBmMmp1bk9RY2ZpaTBaUUMzN3Rn?=
 =?utf-8?B?bmZKTkNRR2I2VkJoRHpselFGOXpuUzFXREdYRFJoeUpXNEZvTTE3cTJUTGF6?=
 =?utf-8?B?KzJmcUhHZWtLWFhpcGVpY2kwMmhkdWJmdkJ4M1RZeW9CVVhzaHRCRmZJS21x?=
 =?utf-8?B?ZVQySHB5UUFibEErdTVnS1A4Ti9XcFhHVXdST2JzYlNkRnNIaW1XRTgrdmVt?=
 =?utf-8?B?UDRON1dnT3ZXeFplL21zR3pIN1crRS9LdUgwb0hWRnlrSW5xMFl2bnMrUDNh?=
 =?utf-8?B?YmNNcU9mNXAra2hnMkpubklEWTFZN3locExYSThDSVdLVk8wT1NMRjI1Rm4y?=
 =?utf-8?B?S25SQ29QRGlqZVdXME1Wa2g1cmwwRXFpdHpWRlkvNVFvUU9scVI5WDl1QWNS?=
 =?utf-8?B?Qm1HRTJ6WWFHRW9RM25xVjYzUVJSU2VtMFBuZHRhNDhzbkc0cGZLRW13blVI?=
 =?utf-8?B?TVhGZGp6R3BlOWxVSm14bnIwU3ZQVElNL2NLdXFTVnc5UGp3REc0OHlaYXNK?=
 =?utf-8?B?ajB1NUUvano3QlpFajZkMi9NcDJSWXNPd243VWlmaHUwYk8vYUdSeUtEU0hl?=
 =?utf-8?B?S1ZKV0REbFB6RkxUeDJ3bUkyakhBanc3NU5KUTU4cGp0OFNCLzNSZ1k2VXhM?=
 =?utf-8?B?cWQyVG1SSGRBRFBmYndSY0hnN3BGRjBNNlBkSE14L2pqTnlYYUJpYzhZY0dE?=
 =?utf-8?B?WnkwUTY1aDlqcGtadUxoMkVRckZ5Q0ljMkFDNWxiUG5SNGdXNFFIWUFUY2Zz?=
 =?utf-8?B?a3U4OXBkZXdKaTVhbmNRd2tWU3pqTXFjYVNrbDN1Mlhzazg4WXRDcCtaT2V3?=
 =?utf-8?B?elNkLytjcS84emNtVzliL1M4Rit3VkpEaGFycXZpR2VDYnh2cXNtWDMxU2pq?=
 =?utf-8?B?WGduUDhMc01oNVdyRi9NQlg0eWFxWlErODYxY1dEZFRWR0FiYzhUbkJaN1ZJ?=
 =?utf-8?B?L0lXMHV2eTZ5bGtHRm91WUFEZ3U3NGhOTU0yUldldXVCaTRPUUVaSjFnQ2pK?=
 =?utf-8?B?MHpHd2JJbjJydVpsY2NoZUdBQnBueHU1cmo1SkN6cy94ZGt6YmFHZGJCN3Ax?=
 =?utf-8?Q?eLaqwbEXeY2iosX1hkTEBWNVVyrvHyqqS6KgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1hwaTdwZjlVaTFvUHo0Zk9MamYyVTVvZ0kxVnBrd252Zm8rdDg2T2tESG9H?=
 =?utf-8?B?QjdPTTE5akZoN25oSEhESGZ4eWVHN0Z3bGJJclFWbGZkbjZKVDZJd0tRbG1T?=
 =?utf-8?B?NlQ3RmswZ2RiTXpFMG8rL2RVRzN4TVMrY0RKbVhoZnZoeVZkT0YzZHpVMktz?=
 =?utf-8?B?dnhFYkVwTmN3YzNDTVBqWWFqdXJiYWpzODhtenMyRGhhUGhhd2hxbkwvRzdP?=
 =?utf-8?B?QkZad1k2MzRBRmc1c1BQbFp4NHcxd3FybjdCY1l2c0s2dlAyZ1IySUFUZ1c3?=
 =?utf-8?B?b2RPQ3pIL3FjR0ZQY3lDTzl1VHhGWnBHZzBFOC9HWW5PeW14cHZ6Z29GcmZC?=
 =?utf-8?B?VE0wSlZ1TjVreVVWNXBKUklVNFZZRkY0QWVDeFRtRHNKVlUzS0VGbjlXZk5S?=
 =?utf-8?B?QmpaTjJGaHpKaEhnR3VhcG9zSlRiM2g5S0lscFphUVN6dXl3WWtLQTZvdHRz?=
 =?utf-8?B?M3Noc2xPbGY2d2MxVUdSNE9IRWNIak1FK2dWNUpjUzJpdy9Rd0NLMmNLbGc5?=
 =?utf-8?B?RjJVdStQbWdkSjRGRXJpeWRFLzRiTlVPR09YTUZvcEhaZTF1ZTdydFFSdFll?=
 =?utf-8?B?a2xtdk5ZaE5OV2hYTUdCUnMrVFErOFgyWFZKTTRSSGg3RmVGbkQ0WXllQ1NR?=
 =?utf-8?B?WERjQ2xnTDEwLzdrU1M4N3labUt6ZjlQYjc3WTF6anZaTTNpR3ZPdTd6dzYz?=
 =?utf-8?B?MW95MTE2bGxuQjRPb0FKVDBubWRLOHczVkxEQU5INTZ5OXVrZmI2cWpoSnhF?=
 =?utf-8?B?SkZCUjdTU3VwNENYMW42MU11VlJnRUpqb2dLeG9LenNpODhCZTdmUytXaGo2?=
 =?utf-8?B?MjQxc0wyR3RhbnpPWkFDRnJPUS9URmh3LzBsTDRuVFFkVWpIck9qcDkyZEUx?=
 =?utf-8?B?OHMvWmtwbTMyQTg3NGF3U3YzNytOWkZSQ28yOUZEa1JPUHRyVmdiRUswNnZh?=
 =?utf-8?B?QlFIeFdVcnl0WS95b1VyMldkem5aazY5YWNMYkpaNkh4b0gvYUsveHdaTm9w?=
 =?utf-8?B?ZkI3WjBTRVdaUHFSOGVJeXYyb0MrUVgvUXRkdDdqZ2RJN3NxQVdoUzh1ZUJV?=
 =?utf-8?B?czErTks4Q1dnOGNENlplQXJMTVF3aFhiaThIQ0ZXQ1c1bjRLekhHaWZCeVh2?=
 =?utf-8?B?QmIzQ2tQVUZBUWl6QlRNWGhjeTNHN3J4TThCTjZBS091WnRaaGZyU29ZcGJ2?=
 =?utf-8?B?UnV3RXBuWlAyUlgzM3N3NU5lN3RpL2VLUFd5b2l4ajRzbHduL0E3aXdETTlW?=
 =?utf-8?B?ZW5rTHlMbTZwYW8yU3ptWWcraWErejdIWWRyclAvTGxoNnhKYThZV0l6WVVZ?=
 =?utf-8?B?V3NEdDUvTVpleHk0UzdiOUNlQUR0dGNScW1Gdm5jRkFLMXU1YzVyVm5hMDlz?=
 =?utf-8?B?TTRPNzlTc0JhK1B5SGxFRWdCMGxUcDVHU1hYekNvMXpUK1FhSHFSZ3lvd2dD?=
 =?utf-8?B?K2QyVWFrajZ4MTBhSUdLVFU3cXBXTW4waHVqV1ZjZnZmMGZ3ZjRUMDJPMUJQ?=
 =?utf-8?B?Q0IvNW1IajdXSEVCODR2WjVzYkJnU0dOUXcyNlJSM1lwUXk3dUdMZFVRT2lw?=
 =?utf-8?B?amk4djdxbzZyaHlLMGtldWFIK2JVUGx6cTgrYXFjT2J2a284aHMvQ2l6RVdK?=
 =?utf-8?B?OEpyOHhseExhV0QyekdScVBic3N0c3ZGQnplL1BLL015KzZYSlBTWXYxSWxm?=
 =?utf-8?B?TjlTRDd6Y1k1am9YbGpRVzFFSnZHN1FwNnNOT1UvN3pDVm9DNVF1Qm5rQnR4?=
 =?utf-8?B?Z0xxZU85Q1VGSXdqSjVKekIwZ2hhYjdSWENMTXFQMmpEdHFFUEd1RG45aXdS?=
 =?utf-8?B?SnhROXpXd3NXak9PTEZXYjl2ZXRHREpFOWFWZ3diaVl5NUQ3RjVwL05FWHI0?=
 =?utf-8?B?T1d3VzBZVTBqQnhMVkVzNmpHdjl1dlI4UnFhZ0VEVG1oaGhoek9TM0RERkpa?=
 =?utf-8?B?WFlTa3IzQUl2dHRqR3oxQTl1ZVkvYlI4Syt4b21BUDJzUzA4REkrc2FMN2ZV?=
 =?utf-8?B?QXYzMW8wd0hiOEd6eTRoTktrbEVxd1pFaXlSSWVmQ1Z3UUtWa3pMMUxva3cx?=
 =?utf-8?B?OWF1ODNJRG85ZndxWjZDaE45MXZneWhTNXFBaytLb2pPaW1IRjc5OFhNSDdv?=
 =?utf-8?Q?ubJcfSRLR2RzDtDV6m7IgqCh8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9da7491-d16b-41b3-42fe-08dcf2a07910
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:50:22.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqLPEyOByHWMD0w+FbYT4f5dpwJ8ez3RiE0ZrzmeWHVz6tLzSecyMVdN+SZ7DUcIfbZl+ai/0Px27EvrritpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

Hi Dan,

On 10/21/24 20:53, Dan Williams wrote:
> Terry Bowman wrote:
>> CXL protocol errors are reported to the OS through PCIe correctable and
>> uncorrectable internal errors. However, since CXL PCIe port devices
>> are currently bound to the portdrv driver, there is no mechanism to
>> notify the CXL driver, which is necessary for proper logging and
>> handling.
>>
>> To address this, introduce CXL PCIe port error callbacks along with
>> register/unregister and accessor functions. The callbacks will be
>> invoked by the AER driver in the case protocol errors are reported by
>> a CXL port device.
>>
>> The AER driver callbacks will be used in future patches implementing
>> CXL PCIe port error handling.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
>>  include/linux/aer.h    | 14 ++++++++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 13b8586924ea..a9792b9576b4 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -50,6 +50,8 @@ struct aer_rpc {
>>  	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
>>  };
>>  
>> +static struct cxl_port_err_hndlrs cxl_port_hndlrs;
> 
> I think this can afford to splurge on a few more letters and make this
> 
> static struct cxl_port_error_handlers cxl_port_error_handlers;
> 
> 

Ok.

>> +
>>  /* AER stats for the device */
>>  struct aer_stats {
>>  
>> @@ -1078,6 +1080,26 @@ static inline void cxl_rch_handle_error(struct pci_dev *dev,
>>  					struct aer_err_info *info) { }
>>  #endif
>>  
>> +void register_cxl_port_hndlrs(struct cxl_port_err_hndlrs *_cxl_port_hndlrs)
>> +{
>> +	cxl_port_hndlrs.error_detected = _cxl_port_hndlrs->error_detected;
>> +	cxl_port_hndlrs.cor_error_detected = _cxl_port_hndlrs->cor_error_detected;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(register_cxl_port_hndlrs, CXL);
>> +
>> +void unregister_cxl_port_hndlrs(void)
>> +{
>> +	cxl_port_hndlrs.error_detected = NULL;
>> +	cxl_port_hndlrs.cor_error_detected = NULL;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(unregister_cxl_port_hndlrs, CXL);
>> +
>> +struct cxl_port_err_hndlrs *find_cxl_port_hndlrs(void)
>> +{
>> +	return &cxl_port_hndlrs;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(find_cxl_port_hndlrs, CXL);
> 
> I guess I will need to go deeper into the code, but I would not have
> expected that new registration interfaces are needed. Each 'struct
> pci_driver' could optionally include CXL error handlers alongside their
> PCIe error handlers and when CXL AER errors are broadcast only the CXL
> handlers are invoked. I.e. the registration is something like:
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 6af5e0425872..42db26195bda 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -793,6 +793,7 @@ static struct pci_driver pcie_portdriver = {
>         .shutdown       = pcie_portdrv_shutdown,
>  
>         .err_handler    = &pcie_portdrv_err_handler,
> +       .cxl_err_handler = &cxl_portdrv_err_handler,
>  
>         .driver_managed_dma = true,

Ok. I'm thinking to add a definition for 'pci_dev::cxl_err_handler' of type 
'struct pci_error_handler'. 

'struct pci_error_handler' contains a slot reset(), resume(), and mmio_enabled() fn 
pointers that are used in PCIe recovery if available. The plan is for CXL devices to
call panic for UCE fatal and non-fatal but it might be good to use the 
'struct pci_error_handler' type in case there are needs for the other handlers in 
the future. It also makes the logic to access and use the error handlers common, 
requiring less code.

Regards,
Terry

