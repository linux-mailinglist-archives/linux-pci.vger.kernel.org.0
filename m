Return-Path: <linux-pci+bounces-1593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8BE8219A4
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 11:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334ED1C2099D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24FED267;
	Tue,  2 Jan 2024 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YW2N4nLU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA54D26A
	for <linux-pci@vger.kernel.org>; Tue,  2 Jan 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpkIOOyCbKfPNg/Ots/CZqxCmORFgXm2XZFhxuA0Viqp32O4hCQMtY4oUl4zXvLBDYIZct5smjUQdtlZHaW8kwP2iLz1E6kGHHIkQT69vr7Hv7ZuHFQlPB9nJziaqKJrWSiF+yDFA4rp0LstB3JytY+RyoAlhltPtQYX69WJfuJJzFNm5ol2MQVzrPZq+zPWT+cSbvKmkuddTmeCXO0OOzmSikTXlNyON20klLcxPHPRtixKWZG5Tdf4epnNOWwt60p/GYpCseg3z25L2fCTkuTP6Zv+kNbWZaOF3dPEXPaUPV2OIP2xKEXUKeZPuUD8xic6WWmPVScMM1C+7yMCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjYJmFzEjIrfBXEpeMVw0xFqcxfervdA1VuIzkmxZQA=;
 b=XMkr8DPw6mJNK++Z7Jau4BXgwm/dSM+QwG/IT4vVgxfLzLKWc+Nf2FyLwUWUlmCdkC/ZMzsrp8Not0+vWv5XCRRtD8jnD5NN4DN0C2xr5RgUxxkhjuPtSp/pNAEzdq/IaPblsz3fJGoLNKKvpb7HAA16/9BMzavRIp8Z/AUeI7FbOVxU4Q46Md4ppdW9zy1B4cXxh9xGw6PKtb+Ka1I6PPM6Zn9gmKfi4C9CyjKRdiPyDhW71ufl7ALiSvtkfucOImLkBEvRppqv/3cneShvjup/8+y9TAek+I3upKc9tVGCFmj80cLEIrmvC5VTzwb/D2qTTaf15Dy5FjhEuQpX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjYJmFzEjIrfBXEpeMVw0xFqcxfervdA1VuIzkmxZQA=;
 b=YW2N4nLUM0c4nfPydfAiZcAQC2Hhtsa4qWYhsrIvsLPpql0mZHUKP1RJ+pQ+GTjEtTwv9NTBvdXCIhkHEL1AG7Z7mkFazrjvb9Im9EOjFYst0c02N/IiPTei+8bIzL4Os1i15PdIZCbHBIeL6MoFFjYwvtkYuWTFpByfaKHexC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 10:25:12 +0000
Received: from BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::4821:25c:ab91:94f3]) by BL1PR12MB5827.namprd12.prod.outlook.com
 ([fe80::4821:25c:ab91:94f3%4]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 10:25:12 +0000
Message-ID: <171bed1f-5eb6-4263-e25b-53330f3dc1fa@amd.com>
Date: Tue, 2 Jan 2024 15:55:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
To: Niklas Cassel <nks@flawful.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
References: <20231128132231.2221614-1-nks@flawful.org>
 <20231226221714.GA1468266@bhelgaas> <ZYwRK2Vh5PLRcrQo@x1-carbon>
Content-Language: en-US
From: Kishon Vijay Abraham I <kvijayab@amd.com>
In-Reply-To: <ZYwRK2Vh5PLRcrQo@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To BL1PR12MB5827.namprd12.prod.outlook.com
 (2603:10b6:208:396::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b2be4a-6a0d-4239-422c-08dc0b7d1a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a3fJNLoVXmqqiNPgXBJQMAtxRdTuxx44edBeeHp/ZIR5YadxTI6TgcfHZoSgpZkMUkdCO0lELZmYqBhkeRcw03qRMo1HyUY5qK+TMGLnsWRAucn/skFfCqsDUbdAEVM1+sM90dM8sPsD9qHnDe142hoQZB0j1Q73YyaiqwPKKGzc/MYgoL4ST2PG2R0p+NkHnnXrZYimadJYaok/1mcrqsK9BuhifNE/gT9Jxy5ovHnbM0D1KHL77Rf9tTwgviJe3XyGh4OjThcA/AULXauG7Z0EFFx673O2qhVOPzV0DmXPAKheF16qt/4suHpmWSl+Bg9G+x9adPzAzrQ5oFWLj4qy0nlSd/90v2+SGum+qSW2Jytwsk7Z0GwwjIf/cLF3TjK3RdHYnq1dv7g0AUy14HesHWKwQwFHyQgh8f1yTXhyQRlebLaQ0uQNjVB71nQR7HsSaYzR3Koav/MCtqWkjet2ov+Kp4rjNzDy58CNzqOTVAbUser6SXacTSi9tLof6CbVjZBIHSfkEb67UQ9DUu7BPzr51sRHskXYci+TAxyppHny+JdG5LBaPIIYhI5OndWISeIutW2IjVH9wBMGsucqQ51PimA//eQYNGQbz9NARjgJ5sdIAJavsIg3APMbuk7Obmg63hjrz/k/c+rycYlT6UVLQ/nBbfHfdixPwPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(6506007)(6512007)(6666004)(53546011)(966005)(6486002)(38100700002)(478600001)(31696002)(36756003)(41300700001)(2906002)(83380400001)(2616005)(26005)(7416002)(110136005)(66476007)(316002)(54906003)(5660300002)(66556008)(66946007)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlpwOXRLYmxmdmR5UithVFFkY09yaVJITHVCaXBkemhZNnRLS1JnRFBtVFdF?=
 =?utf-8?B?Q1pRcG9YR1VqeGJYUTdjRFBJc0YrdjlQUThZeVpJVHl5bFNEN0FFR0ZIVlFh?=
 =?utf-8?B?a1QzMTk2ak5ZcFEya29FN0MyS1JwSzJMV2M5NmF5bGVmYk1nSEpXbDVDak5P?=
 =?utf-8?B?clQxWmE0RDZNa1lvR0RqbStEV3REODB0VmpLcDBjdUJ0UjBDVGRyOGpmTU1K?=
 =?utf-8?B?NDF2ek5ZT3RHM2lrd1lyMVRrNEZQSFNwdGdQYlM1M3FCMGpyUjlQckMweWgr?=
 =?utf-8?B?akpBcmdkSkYrNDUwcUhKc1lDckRxNVhhRUl4MG9kSmg1Z3cyOGQ3YmdGc3pT?=
 =?utf-8?B?ck9oQ2FZOVNPaWhxcVRkdU1hSXFLalFheWhXQWExeHR3eUVaRWl3SktUVG5E?=
 =?utf-8?B?eGxWVEFlcVk0SGQ0SjVNNjlVWXdqZlZiWFZoaTh3V21LV1lkTVl0dlIza1Jq?=
 =?utf-8?B?enVRU1pYV1pTMDFucG5Hb2ZmNHo3M2xpU3RweGJhbkJGT1JreGZTNTMzUU96?=
 =?utf-8?B?M2Vadmp5eEtIb0toTEJaYlBDb3dYMnY3S3A1SjVscjlnQzJIcVZLSmdNbDls?=
 =?utf-8?B?R2dZaVgwYVMvOTFUWWRrSVF6Y1VYa2wzV1MwSkRySzlZV0U0UXV1NEpDMzdF?=
 =?utf-8?B?aXBLbDlmQlBKS0c2Vnc5ZFljVkkwOTJpMXZZS3RsYng0RGFxSXREYzlXMDNl?=
 =?utf-8?B?ZGdMRVFxenRwaFN0YXJzelIxQWVMSVg5R1Q4SG53TGNyenFoVk14M2xvNEdq?=
 =?utf-8?B?RVl6NW1kMkpZSWtSbGcrVTVhZm84YUQ1VTBYM2oyNmxqQldvY01EbnNPanUz?=
 =?utf-8?B?MUFlRjdDaFluQWo4Tll0WVVscUg2NTltcGZEMVptOHhZNG02QVJtMHdoZ0NL?=
 =?utf-8?B?T2Y1TFlXYXJMTHpxVzUzZ1BLQWZRNCtoTzYveTRrMU9jRWNuN0kxTGcwMHlS?=
 =?utf-8?B?ZzF2RmdhRnpmMFBiVS9vc0lXaHNlcE51T2tvUVpwSnhkdmg3Z2JScXlnMC9m?=
 =?utf-8?B?ZTEvcE9tQVRwZ2ZDWnBtRmIvT1ZlSjVqd2pCellHcFBZQi9XRUtEYmJ3Z0Ew?=
 =?utf-8?B?RnA1TFZRZGVwQWNTQjJtTXMrU2RlYTBSN0s0SVY1RzhMUUM5SnptRE1pdUMr?=
 =?utf-8?B?dDh3aEQyR1ArNDhWeFFnMy90RG1DRE4xVngwR2NKbnl4ZytMclV4TjNpRUtJ?=
 =?utf-8?B?dGo5aitVVStTUVZRZmJaWVdCd29lN1phdVpGRTNVb2dWYVluZ1ZSeUhnMllX?=
 =?utf-8?B?cGxXbStGdHMxTHNRK3krWlM5SWgvanZ4clhKeWpkVGJGY0E3Z1NJUXRFTXZ4?=
 =?utf-8?B?TTdTYzN6QTBJMm1JTm9tcWt3QjExa1N4ckovclBJR3hSTkRVLzFQeXlxRWps?=
 =?utf-8?B?UmtVRkwyVWF2ZkZzdlQ0NmpiNHIvQk8xU3IrZHVnZFRqNml1K3RzeUVtaVcw?=
 =?utf-8?B?L0FKZjdXbzBkSlFCQXB0R09zOXdINW1ITXFHMHBXcUtvMkRmak14Q3RuNTBv?=
 =?utf-8?B?WTBkVWZEQ09hU1Y5S1JnVFV0SVBtNW9aMzNFUUZOR1R0K0RPUmJzRURQZHdD?=
 =?utf-8?B?MGpsVTdHUkp2OWs0czZUMjMxSGRHY3AzTnVLTlVjOFgxalIzZklpTjZacGJS?=
 =?utf-8?B?cVhsaVJXM2xKdHB2WjZxYXkvbU9pcFY2bkg3d0hUa3Y2VDNrRjdvWktPUmFB?=
 =?utf-8?B?Y3FaVjBISkRoclZGaXNrVldJL1VJWkhDbHRBYjV4TzhuenVvaXFJa2xOOFlC?=
 =?utf-8?B?ek9jNEhaeGt2OWJtYmJqWWNtQmt1N1ROdUFabHcvTitFM0R2b0FBZGpqUzhs?=
 =?utf-8?B?U0oxRFdiNmdNSHh1TmlPQnM0R0pjRG5rZWZmRUszSCtWa21CcHgvUmZnVSti?=
 =?utf-8?B?Vy82VlZpK016NzVLQkFSY0lwYXRPVHI4YUNxZnljWmtDTEw1R3hEcGZvd3lt?=
 =?utf-8?B?ZUpYRkxUM3ZzSmduWFA1ckpEalBGME5jTnhxR2drOFMxTEhuZE5jcHQrVHZO?=
 =?utf-8?B?V3ZrQWRiM3VXTER2ZFNZdk9IWm0ya0hBY3V6NkFUSjdkZ2lLZEp1OUtQRHBN?=
 =?utf-8?B?UTRyYmdjK1FMUmQydGt4Mkw4dkM0aDdVSEhadDNRa1pEdDUxNFR3UEJ0SWE4?=
 =?utf-8?Q?gLhmNViV7ntUcpUoDOJc6OgaT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b2be4a-6a0d-4239-422c-08dc0b7d1a29
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 10:25:12.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzlcv4+V9Ic922wHWW0y4mRHuOY0kN3X2yp6bJ9Kfc32flXv8EmgfI+iDzeEa45PmRGNPu8JUI3cQL3OQhNN8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

Hi Niklas, Bjorn,

On 12/27/2023 5:27 PM, Niklas Cassel wrote:
> Hello Bjorn,
> 
> On Tue, Dec 26, 2023 at 04:17:14PM -0600, Bjorn Helgaas wrote:
>> On Tue, Nov 28, 2023 at 02:22:30PM +0100, Niklas Cassel wrote:
>>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>>
>>> Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
>>> correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
>>> support iATUs which require a specific alignment.
>>>
>>> However, this support cannot have been properly tested.
>>>
>>> The whole point is for the iATU to map an address that is aligned,
>>> using dw_pcie_ep_map_addr(), and then let the writel() write to
>>> ep->msi_mem + aligned_offset.
>>>
>>> Thus, modify the address that is mapped such that it is aligned.
>>> With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
>>> dw_pcie_ep_raise_msi_irq().
> 
> For the record, this patch is already queued up:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc
> 
> 
>>
>> Was there a problem report for this?  Since 6f5e193bfb55 appeared in
>> v5.7 (May 31 2020), and this should affect imx6, keystone am654,
>> dw-pcie (platform), and keembay, it seems a little weird that this bug
>> persisted so long.  Maybe nobody really uses endpoint support yet?
>>
>> But I assume you observed a failure and tested this fix somewhere.
> 
> Yes, I verified it on rockchip rk3588.
> 
> I'm working on upstreaming rk3588 EP support:
> https://github.com/floatious/linux/commits/rockchip-pcie-ep
> 
> Right now rk3588 only has support for RC in mainline.
> 
> 
> The fix is only needed for platforms which:
> 1) supports MSI-X
> 2) has an iATU alignment requirement,
> so where epc->mem->window.page_size != 0.
> 
> pci_epc_mem_init() calls pci_epc_multi_mem_init() which
> initializes epc->mem->window.page_size with ep->page_size.
> 
> $ git grep page_size drivers/pci/controller/dwc/
> 
> So it will not affect pcie-designware-plat.c, nor pcie-keembay.c,
> since they don't set any ep->page_size.
> 
> It will not affect pcie-tegra194.c, since it doesn't use
> dw_pcie_ep_raise_msix_irq().
> 
> Looking at pci-imx6.c, imx6_pcie_ep_raise_irq() calls
> dw_pcie_ep_raise_msix_irq(), but:
> 
> static const struct pci_epc_features imx8m_pcie_epc_features = {
>          .msix_capable = false,
> }
> 
> so while pci-imx6.c will call dw_pcie_ep_raise_msix_irq(),
> I assume that it will return early, in this if-statement:
> https://github.com/torvalds/linux/blob/v6.7-rc7/drivers/pci/controller/dwc/pcie-designware-ep.c#L596-L598
> 
> That leaves just pci-keystone.c (am654 compatible only).
> 
> I don't know why no one has reported this bug before,
> I can only assume insufficient testing.

The HW enforces the alignment so there was no issues observed before.

> 
> I guess you might be lucky and happen to get an address that is
> aligned to the iATU alignment requirement, but that is unlikely
> to happen when rebooting and running pcitest.sh multiple times.

In AM654, the HW keeps the lower bits of the target address as '0' in 
the ATU, so the address in the ATU is always aligned.

"Table 12-2815. PCIE_EP_IATU_LWR_TARGET_ADDR_OFF_OUTBOUND_0 Register 
Field Descriptions" in https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf 
describes the below

<quote>
- LWR_TARGET_RW[31:n] forms MSB's of the Lower
Target part of the new address of the translated region
- LWR_TARGET_RW[n-1:0] are not used [The start address must be
aligned to a CX_ATU_MIN_REGION_SIZE kB boundary, so the
lower bits of the start address of the new address of the translated
region [bits n-1:0] are always '0'] - n is
log2[CX_ATU_MIN_REGION_SIZE]
</quote>

Thanks,
Kishon

