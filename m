Return-Path: <linux-pci+bounces-3649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE785881C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 22:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AF71F2162F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 21:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B9136658;
	Fri, 16 Feb 2024 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bptsd9vJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453F13AA5F
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119502; cv=fail; b=Z1xlCscXareBvxtzqAgUokePG9wunk5yLTEcoDvr/70zSNmcnB2e5vM4BJfznsn48RhZgZbjeMlSgYeHo0mhHboXgesKBA6GhiGMgiyBI0+O/qO5kwWMRoglhRpdpEDEXLeRYiQVatv1t/Pb3eZU7i2THllhwjHlC2UOBa63nCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119502; c=relaxed/simple;
	bh=DhmdAAYKR6Po2hsin5KfieYMkMO9WvBLaFxwKzq3zgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=em0O9o3fDgJuKyIA59N/++4DluCymPvnm1lhSd4AzCQKHeGICJ45QYN/bWKhxe1cGSngTZepRG8zeCWPyaNwEo5SBdaw6qNVOWGsrPtcqa0TjZpo0hhtUhXhqV2I8VlO5Uv3phXhFSm8fWyRLmVmoUw8ermqumOUuRB8Y3SDKmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bptsd9vJ; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBLBnhBpSek5m3s4uu/wbFDtnnppa+Ervd5yGGH+M04FVWptMr+FMtec0WeJeKjBvPuOr6LuuVlG0wfGkSJQRgceNDUdUHX3Ckiu/AyxkHZqr7KNkPvHjOqApjW9JaXAQhiR5GCQ0bDx7YrYaX6bJc5WdGZasRU0EowIbDEhjHWB073G6h/ZLCPZr0OWsxYbibuRZvYoUiiD5l7RnnsfIB6RpLNIQdEsMgxlLUAYrZTQiicsXbotUXe5PPKmd0x/8app3kz/pHW00aVcJzC0ICLt4vCgW6dRC0LwE5a8kwsEUFk16eJoYJ9zTwH2qYqJzjbkgeG0cdQbd+ELX+BwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNrs3sakF4kCWduqUXHLirTNVHMEJsqG22zK5FMerfU=;
 b=hva0B6vRU5ae7fL9EehTWSx6kVf/RTrHAc0Y4MD4dVaTi/Shr3r038Q/AR971Kr3wXAMQoW6ndoOSkGOg7AjhmBdY3f6ghVamjlGafaNNywCX8uUPGgqixl0p1uBCdYTu2C84HDFQD4Ak5ychEXgwqNMBUUXU+BdVZS/SmslCZkggCTB6a4qYRBKX7ixij9/qQwIEO+VNOJrTJeBsOpqVHOqs3aRLbIUBDvOr37YfbSjBzC+UT6kyp9aolqZCCIaAJj3wFU9z32HYjatzWv+i9c2FpSPXsiyzfKMyvGmmfAFEIcZDHLXas8Yqn8TMivjvZVJGl9/Ap60isOQw8gi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNrs3sakF4kCWduqUXHLirTNVHMEJsqG22zK5FMerfU=;
 b=Bptsd9vJpBJxv8disKIDbxdvS6cJtmol63KCoghRD18iZGL1OWyBkI7syLrkrqIOvHTHfL1VkGxIzgKllXA6qkdv0JszPLShBjz6wR4WAzYUIaTuw2QbmaGxovSPRnfC0EFKTHQeQNrsNR9c8PdCaQ5wodg2/Mk+KsebSjYp9z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Fri, 16 Feb
 2024 21:38:16 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::c167:ed6d:bcf1:4638]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::c167:ed6d:bcf1:4638%7]) with mapi id 15.20.7316.010; Fri, 16 Feb 2024
 21:38:16 +0000
Message-ID: <79921a75-6d90-4d7c-9aac-5df4430cf985@amd.com>
Date: Sat, 17 Feb 2024 08:38:09 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Wu Hao <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
 <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8PR01CA0030.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 518737af-f304-45e4-f0d9-08dc2f3795a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fmkeG27VcqSjdo8kKIscd1VWY6ghDvgFNkn8cBxxcOt8OCEwx7tYcWUdsnK7ErmQozzQykyXSXrwnUTC5fmXgXXZQwNDTvW1RPD+s3AJ1CQgO6h+NepMRPDvqCzMcaM8FxKa7zFCC0YX7C9fDBt5z4JQQZUtdb05D7fVX46jy4rf99iDlCG1CEshCwbJQxBHmFa+lBWLxhsbiaTQfcdB0oOCM9dEZZWMOx51WL93IGg5+MHyfaFzEE/+pc3eC7RXckjPtoA+qpj93vqRZ0dfqnDQXSPcSdLoYvXA2cvebeGqZsMbnPL/3oE1ajXym9tVHlFOvHjYtrhTUb3LWJ5DkhVbPGBvuV0q2qVgtxo/FOpmSmEXsKm+ctrvKfafTR8vXn4d1KHXEl//v/MNZ3IwYN3Ggzu9VAMbdb5AnbmchGRdtOLrJ10TggieeKS/bHwzKTiQJMTloeJYZNH81pxsravrtsU6imJlbhykx0h9we3YS26fubUIOFqMv14uohCQfbBJpBXDIojamZ3HeoFNeA7Emj2JR0nGKdedrY8u/z6vc16bhFjndYYAfLdZsSmW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(8676002)(8936002)(54906003)(36756003)(66946007)(4326008)(316002)(66476007)(2906002)(2616005)(5660300002)(38100700002)(6512007)(6666004)(6506007)(26005)(53546011)(6486002)(31696002)(478600001)(83380400001)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUZVVVo4bmZDYUVHd1hyS1M4aFZRTDhIY1RkU0lFOHJZM1c4TURUZFRiV0tT?=
 =?utf-8?B?cDhVYzB2WS9PMVc5RzhXQXZzVVlMUnpXMXpoUDlHY1R6R2VXRHVkd1pCWk1M?=
 =?utf-8?B?bnNCc1BqOHk3b05LUHlLbjQ2eVNaY01qVTdTWmtIOXordElvZ1RRWlM4Si9O?=
 =?utf-8?B?QWFHUllkcTJqeVplUHVrbUlhTjRRa2pQTmxqLzQ0TG8xNEpyRm1ScCs1eTRD?=
 =?utf-8?B?cW1mZDdneHErbWJ6OTM3b01GQk5DQy9QVnpEaGV0cXpFaTIvZlZpMVJjVzNB?=
 =?utf-8?B?djlQYnNxVmRoRVdmd3dJV0JNeGVxZHJ5b1RVc1Eyazl5TWtsYXlPMzcrNEFh?=
 =?utf-8?B?dWVvc3l5R0FWbjMwNTdFa1lEZGVia1B3dVZCcE5lSTVZelBxUWxDUFRvSUhu?=
 =?utf-8?B?d1d1ZEN1UzYxd05PamRxRDhGSGZDU2tES21wbGE3VGNCMSs3TjZPOE9qZVhY?=
 =?utf-8?B?aWlBUjFUKzI1YW5HY0dFZHgreXFhM05udldnTmxKOTJoWmVPZ2NXeFZkOWtI?=
 =?utf-8?B?c28ySDZDamV1K0twRm9HcnRGZktJNjFXT3Q4aVJuNkl1cHNiQkVidUJxRGh5?=
 =?utf-8?B?Qlk2Y3ZqRWJtb2pmeVRmTzNTTWdXUHM0elY5RzErVEtJdHJuc2Z5TFM3bEpi?=
 =?utf-8?B?Q09DOUh0QkJUM0ZWYWtKOSs2QVJVNFdXRVpUTWVqUUpzVGt0Rm9jaDNmL2Qw?=
 =?utf-8?B?R05nd1ZqcWpONWdUWTVCbWEyN3JCSUs5QjlHVkJENDBoT2VVTUdUNmxZWjBO?=
 =?utf-8?B?d2lDaVBNTUU3THp2TFEzNk1iYjR3QmtkYUZnNCtDVmJ6Ylp1SEMwWmFtMHdi?=
 =?utf-8?B?UzMxejcxYXhHK3dDcUZqNWJVN1BtOStGZ2pqZi9tWkt3aTE2ZlRLZGVWNFA3?=
 =?utf-8?B?RHF1UzVGTnBLN3hhdVViUnFTcVJ4bkt1dXk2UFhWS2NtSWcyUTRQVkJkT2xJ?=
 =?utf-8?B?czMvSVJKV0NuYVpHL2JqWVNNekRKV3JjT0V1K0lsNlpnTnJwSkE1Yk5VeGx3?=
 =?utf-8?B?bkpRalVCdUJhVk5yR29adUhQTVgzMWlHb096anUzeTkxeVk1QWRLd0NZUGFl?=
 =?utf-8?B?OUpGQkl1eTIzYjNtbEVwQTRpeWNvUHN4RWhwWHVlYXd2U1Z0Q09uQjMxSG02?=
 =?utf-8?B?Rmx6UzUyQ3VzZGh3UzFZNE1jdDdLYi8xSzVjQTZlL29aMWJCSC9xZlZqUHZk?=
 =?utf-8?B?Y3N4WHIycGFzbGZYb2IrL0U5K3pqWlNkcDRvM1VIVko5Vy9BY0ZPSHh3TDdo?=
 =?utf-8?B?Mm1XY2pDRitCYk1RZG1RcitoZmM0SnNkODFmYzhpc2piWUhhYlM3Ti8wazJm?=
 =?utf-8?B?UHludGdqeE9hNFVXajZ4aVRIZ3FKZ255dUtVUU5pd2lLVTBEVG84REZ0bVI3?=
 =?utf-8?B?MUd3REhtaSsyaU82NFpxVXlZS01uQ3ZCcjF2OUQvalJlYTN3azVUVWFTVkVw?=
 =?utf-8?B?TVVoYVJ2cjVXU01TMXgxZjl2ZndwSlk5RUVnSnFhenJzMUdJZkZHTmdaVEo0?=
 =?utf-8?B?dzFiN29iK1R6bmNFem1FVXozZk9LRkpycUZZaHhpQmV1ZjZaS1FpcEpwNzcx?=
 =?utf-8?B?OFBVSGVZUWNSa1ZMVm8wUnVHeFlmY29TTTl2L2dJQ2NWNytuR1dyVXRoZGJV?=
 =?utf-8?B?elhoQmpYakVjZWxEczRpUGt0RDVJanRXcWJyVVlmdzJzZXJQQmdjMnpNRGow?=
 =?utf-8?B?aDFzZXpoS29RcjVKY0ZKeXNNakZlY0RKZEJXbyt0bDNneGtKbmpydXlrc3hz?=
 =?utf-8?B?dWo4RDl5WWtHclRpVFV6L3Bobyt0U3JBRFdYb2h5MjI2RXBGYVpNRHlnancy?=
 =?utf-8?B?NzBtT2FnaTNKa05ZU1BKTG9BeTF2aG1iZlo4NFR2ajhhcThjNC8vblNnN3cv?=
 =?utf-8?B?aEg0TnFlL3NGVmtLZWRmZkt6MjdaZU9lR1MzOVNES3FuVlc5bnBsMUdDM25D?=
 =?utf-8?B?a3ptMFh6N3VPRW13aE5hWVVlbHlGbFZrVVlvaGp2NlpVeWMzMSs4RVNKb3BY?=
 =?utf-8?B?MHlGTWtIejNod3ZvWlBYajFCTmVuUXJUaFRWNFF5b0VINjlyWFlOSnBZSVNo?=
 =?utf-8?B?eldXVFZ4UmVFUG9vV0w1UHZLUzFzRllCNkl0VUpIOTVpVk5MQ0lxRHdoL2FS?=
 =?utf-8?Q?osQnDuLgiOkR27Bvf8Peyefkm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518737af-f304-45e4-f0d9-08dc2f3795a8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:38:16.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ernLRxlQ1+lnG3MzRXcJfaV1OCLElXoK/0YqcXHlY4kdNpY4UeNOu448NkSHxNEWktm/6tBz30LUPo28vhS0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368

On 30/1/24 20:24, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted
> Execution Environment (TEE) Device Interface Security Protocol (TDISP).
> This interface definition builds upon CMA, component measurement and
> authentication, and IDE, link integrity and data encryption. It adds
> support for establishing virtual functions within a device that can be
> assigned to a confidential VM such that the assigned device is enabled
> to access guest private memory protected by technologies like Intel TDX,
> AMD SEV-SNP, RISCV COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a device security manager (DSM) and
> system software in both a VMM and a VM. From a Linux perspective the TSM
> abstracts many of the details of TDISP, IDE, and CMA. Some of those
> details leak through at times, but for the most part TDISP is an
> internal implementation detail of the TSM.
> 
> Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> attribute, and add more properties + controls in a tsm/ subdirectory of
> the PCI device sysfs interface. Unlike CMA that can depend on a local to
> the PCI core implementation, PCI_TSM needs to be prepared for late
> loading of the platform TSM driver. Consider that the TSM driver may
> itself be a PCI driver. Userspace can depend on the common TSM device
> uevent to know when the PCI core has TSM services enabled. The PCI
> device tsm/ subdirectory is supplemented by the TSM device pci/
> directory for platform global TSM properties + controls.
> 
> All vendor TSM implementations share the property of asking the VMM to
> perform DOE mailbox operations on behalf of the TSM. That common
> capability is centralized in PCI core code that invokes an ->exec()
> operation callback potentially multiple times to service a given request
> (struct pci_tsm_req). Future operations / verbs will be handled
> similarly with the "request + exec" model. For now, only "connect" and
> "disconnect" are implemented which at a minimum is expected to establish
> IDE for the link.
> 
> In addition to requests the low-level TSM implementation is notified of
> device arrival and departure events so that it can filter devices that
> the TSM is not prepared to support, or otherwise setup and teardown
> per-device context.
> 
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci   |   43 +++-
>   Documentation/ABI/testing/sysfs-class-tsm |   23 ++
>   drivers/pci/Kconfig                       |   15 +
>   drivers/pci/Makefile                      |    2
>   drivers/pci/cma.c                         |    5
>   drivers/pci/pci-sysfs.c                   |    3
>   drivers/pci/pci.h                         |   14 +
>   drivers/pci/probe.c                       |    1
>   drivers/pci/remove.c                      |    1
>   drivers/pci/tsm.c                         |  346 +++++++++++++++++++++++++++++
>   drivers/virt/coco/tsm/Makefile            |    1
>   drivers/virt/coco/tsm/class.c             |   22 +-
>   drivers/virt/coco/tsm/pci.c               |   83 +++++++
>   drivers/virt/coco/tsm/tsm.h               |   28 ++
>   include/linux/pci.h                       |    3
>   include/linux/tsm.h                       |   77 ++++++
>   include/uapi/linux/pci_regs.h             |    3
>   17 files changed, 662 insertions(+), 8 deletions(-)
>   create mode 100644 drivers/pci/tsm.c
>   create mode 100644 drivers/virt/coco/tsm/pci.c
>   create mode 100644 drivers/virt/coco/tsm/tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 35b0e11fd0e6..0eef2128cf09 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -508,11 +508,16 @@ Description:
>   		This file contains "native" if the device authenticated
>   		successfully with CMA-SPDM (PCIe r6.1 sec 6.31). It contains
>   		"none" if the device failed authentication (and may thus be
> -		malicious).
> +		malicious). It transitions from "native" to "tsm" after
> +		successful connection to a tsm, see the "connect" attribute
> +		below.
>   
>   		Writing "native" to this file causes reauthentication with
>   		kernel-selected keys and the kernel's certificate chain.  That
> -		may be opportune after updating the .cma keyring.
> +		may be opportune after updating the .cma keyring. Note
> +		that once connected to a tsm this returns -EBUSY to attempts to
> +		write "native", i.e. first disconnect from the tsm to retrigger
> +		native authentication.
>   
>   		The file is not visible if authentication is unsupported
>   		by the device.
> @@ -529,3 +534,37 @@ Description:
>   		The reason why authentication support could not be determined
>   		is apparent from "dmesg".  To probe for authentication support
>   		again, exercise the "remove" and "rescan" attributes.
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		January 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a device supports CMA and IDE,
> +		and only after a TSM driver has loaded and accepted / setup this
> +		PCI device. Similar to the 'authenticated' attribute, trigger
> +		"remove" and "rescan" to retry the initialization. See
> +		Documentation/ABI/testing/sysfs-class-tsm for enumerating the
> +		platform's TSM capabilities.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Date:		January 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Writing "1" to this file triggers the TSM to establish a
> +		secure connection with the device. This typically includes an
> +		SPDM (DMTF Security Protocols and Data Models) session over PCIe
> +		DOE (Data Object Exchange) and PCIe IDE (Integrity and Data
> +		Encryption) establishment. For TSMs and devices that support
> +		both modes of IDE ("link" and "selective") the "connect_mode"
> +		attribute selects the mode.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect_mode
> +Date:		January 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) Returns the available connection modes optionally with
> +		brackets around the currently active mode if the device is
> +		connected. For example it may show "link selective" for a
> +		disconnected device, "link [selective]" for a selective
> +		connected device, and it may hide a mode that is not supported
> +		by the device or TSM.
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> index 304b50b53e65..77957882738a 100644
> --- a/Documentation/ABI/testing/sysfs-class-tsm
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -10,3 +10,26 @@ Description:
>   		For software TSMs instantiated by a software module, @host is a
>   		directory with attributes for that TSM, and those attributes are
>   		documented below.
> +
> +
> +What:		/sys/class/tsm/tsm0/pci/link_capable
> +Date:		January, 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) When present this returns "1\n" to indicate that the TSM
> +		supports establishing Link IDE with a given root-port attached
> +		device. See "tsm/connect_mode" in
> +		Documentation/ABI/testing/sysfs-bus-pci
> +
> +
> +What:		/sys/class/tsm/tsm0/pci/selective_streams
> +Date:		January, 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) When present this returns the number of currently available
> +		selective IDE streams available to the TSM. When a stream id is
> +		allocated this number is decremented and a link to the PCI
> +		device(s) consuming the stream(s) appears alonside this
> +		attribute in the /sys/class/tsm/tsm0/pci/ directory. See
> +		"tsm/connect" and "tsm/connect_mode" in
> +		Documentation/ABI/testing/sysfs-bus-pci.
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a5c3cadddd6f..11d788038d19 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -129,6 +129,21 @@ config PCI_CMA
>   	  A PCI DOE mailbox is used as transport for DMTF SPDM based
>   	  authentication, measurement and secure channel establishment.
>   
> +config PCI_TSM
> +	bool "TEE Security Manager for Device Security"
> +	depends on PCI_CMA
> +	depends on TSM
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Say Y to enable the PCI subsystem to enable the IDE and
> +	  TDISP capabilities of devices via TSM semantics.
> +
>   config PCI_DOE
>   	bool
>   
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index cc8b5d1d15b9..c4117d67ea83 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -38,6 +38,8 @@ obj-$(CONFIG_PCI_CMA)		+= cma.o cma.asn1.o
>   $(obj)/cma.o:			$(obj)/cma.asn1.h
>   $(obj)/cma.asn1.o:		$(obj)/cma.asn1.c $(obj)/cma.asn1.h
>   
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
> +
>   # Endpoint library must be initialized before its users
>   obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
>   
> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> index be7d2bb21b4c..5a69e9919589 100644
> --- a/drivers/pci/cma.c
> +++ b/drivers/pci/cma.c
> @@ -39,6 +39,9 @@ static ssize_t authenticated_store(struct device *dev,
>   	if (!sysfs_streq(buf, "native"))
>   		return -EINVAL;
>   
> +	if (pci_tsm_authenticated(pdev))
> +		return -EBUSY;
> +
>   	rc = pci_cma_reauthenticate(pdev);
>   	if (rc)
>   		return rc;

btw is this "native" CMA expected to migrate to tsm_pci_ops? Thanks,



-- 
Alexey


