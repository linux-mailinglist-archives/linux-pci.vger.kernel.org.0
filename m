Return-Path: <linux-pci+bounces-3539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36982856D5F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 20:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7116281DD6
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095DA134744;
	Thu, 15 Feb 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZlgAKXz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79A3D6D;
	Thu, 15 Feb 2024 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708024179; cv=fail; b=l3ikbXi7SIEWS2PujrJoIjKa3RCnPxvxHYXJFPCY66WYgu4HTtH5V8DW4K5EZ+IrjAxEp4CL5OSNmkZBg5i60b/9BGubObNtINqkeOEdDT6Fu0QnIympxv+LH22VltaUPTXYDR9n3wwsJIAhsCk7OC0PujYNXAIi0Sco2SiryQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708024179; c=relaxed/simple;
	bh=KBgkGLl0jmtJvG3QC8sF2XQOjCNjsF1eBNgFfM/2Ht4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eetm5Tq1I97+I/tpKhEjI1nVMFpeJExUJqR4H8daOFZLeVWYxFYIghf2PewMTpB8Lb0WIral6NnpWzf4IGBWDch6a6C+odWTadQswNoTCanAdk5UMfETUisrz2nFCcUwqkhYpm0Ixsf+E0+1WYGT4f71h22VwWB+boCAPj+rZUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZlgAKXz; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U505/2x2pMjykhiQauxyC5+AKb+HkrWk5P/hliWV9Kw2ectARFDFketBz0zUB9y9l3r2F0uK8l8Vo1q2tEkhXGwM5UGLeY9qUvE0BtD5C3JSF6y5kECTQxZnc+XnDGssvPaUgZ1r5I5JwKeOYz6qtW5kF/Krab9tP6iTKqD6aRI1GHgWPoUXjEQf8KL0apSkfDJkUdCcvCLOwyDFxXr57b4qTvbbEAsQOwLozHp/r5ZvZ2K1Lait+wCl+xpUasugU3AYqghrwF28WHC83Cf3U/0S/V0ZadN/RgzB898qi2kWWVwsTeE/RSaYIbSPURmBbJFB+J3fjL9iWCpqnilnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K83ALH1RqKUuPGPpBsUP4reB9oQULlWERr0oxvNxVRg=;
 b=SWGNYmutonBUo+za49y7oRYdWi0nXA5sHb2AzMs556s/oCU8lmos3Z3XJqDzzpYo4dcRX3gdMU/FwpoU+rzeruE1hg1aOTRZ8Nt6d3UZH9L0K2Wxe7orG5lyTu98U0/hXHhcyloKUKIWgGx2xJaSQhokrvNuRPnCevjyZDAfB4KW8YMCawN3XraJevqTw4rHagaGRbzkk+xy5icY7NT/8u2csQPbkiO4HlQqKOLlhuVR5wGzIXY7xMqUyXNIZ+xNr4aEgbCYftAoCBEzPkepMo/eSFqeX+95y+E5RMH1Bf2RygynsM9KUjN5+WGc57h+OshWQ2eHwZJbi5K6K7/aSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K83ALH1RqKUuPGPpBsUP4reB9oQULlWERr0oxvNxVRg=;
 b=qZlgAKXz5JNnmGFhnLw65UTtXuZ9JKhGSrX//GBn0zzHV8RBnEqG4q6P6KVTsFJ4Dhg5GFhzzsDbQK16jaRnSatoUOfBeyfxmMgm4/h0IQRx2srGVDDEkyphtSNUhmuz3SV+Ed7QcOx+5eRXqmRL0frZjza5tuHmNQMy+oMl1KC1b5OlYOAl1Kpwn1t+mkSycQdKCZO6RLGyvGhHiy9Qjobh7PoNLbZrWDk8wVg/d3/TpkbT//zVYZBPOf8SN6RrV3oAAPgdutvYW0YESH/jgVM+5erKiNvUvVEktVo3Go+tUKgj/6EeYf+FRqH8NhAeDCiO9ilm008U+tUA4Ha/hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 19:09:35 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4%5]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 19:09:35 +0000
Message-ID: <77b41973-e021-471c-89ad-f8cb8752e278@nvidia.com>
Date: Fri, 16 Feb 2024 00:39:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 13/13] PCI: tegra: Add Tegra194 PCIe support
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
 robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, Kishon Vijay Abraham I <kishon@kernel.org>,
 catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
 jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, digetx@gmail.com,
 mperttunen@nvidia.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240215160157.GA1291755@bhelgaas>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240215160157.GA1291755@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::27) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: bf71be81-adf7-4b10-c0ea-08dc2e59a594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xRZL4GgaxNmF+CYrjJ4xIjUhLZ3WLkhBSuAp8w8EoSDuP8j5Y2tRfDKcwnxSUc3R1AfW4kHnETIZYMAqZnA2/CebmtRrHC3Y9ZGf3X697VDH6cyxmwMjpkUjMNTKL8iVHT/PUWt7FfHXPTc7N8BN/89G/u0uUaaOw5EGBuNNURksdqYpJkQP+ohNCbHfKhUl0l618fNAVBT+sB6jvvcRcWBqPMtlK+7YKMhHDp+PLMK5JVa9qMcITSpIdI1+0tpANTcm//3W3OzQ6ExyKn3W4J65sRPSiww/3vK3bcrRm+nX8EGgOCrrRrkljRs1ma7qrYXQr5ZD4J1UVJfNd4w1dHcAl8sRT9jTME2myS+nUgd3InQCF4bs4sIm6UisZS9R6zaDRPJSQa4QesLYWauG17L3QdKaJiB1b2+EzVnGciW5NQWhuIY3d5y3sW19DGL33fCkLpVE/7qB37P3mwtm00rB8G1TX45/AGsZH8nIoxI9zRoXNi5Vhrf8c9lLSB75QGjcFxCgwkBGmTkrWUOpy757g4VmastJ97J6E8PUY7pwGUYQCaAb6J0f4ZW1WqJZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(36756003)(86362001)(31686004)(66556008)(2906002)(7416002)(66476007)(4326008)(6916009)(31696002)(8936002)(83380400001)(66946007)(5660300002)(8676002)(38100700002)(41300700001)(6506007)(316002)(6512007)(478600001)(26005)(6666004)(2616005)(53546011)(54906003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFpiNmFmTSsyNXNxOVYrUXJuWjVqQ0xpL1JGMkFZS3F1T0FXc2paUk80Yjdk?=
 =?utf-8?B?K1gwdEZtVS9aeUoyRXJYL20xalE0UUZyQzZWdGpLUE9CVTdoWXQzR2Fwb1Rq?=
 =?utf-8?B?dGtTR2c5UlhBcVVjeTF2Rm4zR2tNVTJxUkZjK1ZnSWUyQkpNTFBkaWhacXlS?=
 =?utf-8?B?SzE2aU5OSkhhblhQbTlUV1RQQUp2dHBTT3htSFlaeitGY2ZHVmFDcVVrQ3Yz?=
 =?utf-8?B?eEFodC95N2pKSG9pRlNwSVhnRGxtek84cVJxSzVZOCs2RmNYdWlnb3NaN2pQ?=
 =?utf-8?B?WTNFbXFJR01Ec015V3dIdE55QTd1OXZEUlg3dFZTeGJ3TExKQ3Q3WG5VZ3Zr?=
 =?utf-8?B?MTdSbEtSeXhDZlEwRDNwZUwwcTZWc1ZHQjBhYjZrVnZ0QUlsNHgxK0dhQmxK?=
 =?utf-8?B?Q3pxaC9sTnNwZktLRHcvQzhkbktLdnhPRFYydGN4RDhpYnYxSVpZcWsrZ2pV?=
 =?utf-8?B?bkxKYi8vMG9NcWNsV0k2am1BVXFOQnE4S1VVMkFHelpSbFRJZG9LdEtpRU92?=
 =?utf-8?B?VlhxNnlaRS9zTzQ2cnZBVC9WUk1ZOFZMQTBZYU1jUWUvOTN2QjJ0VEpZV0J4?=
 =?utf-8?B?aUNTOEViM3hBZ0NjeFZqalNsZDErYktzdkRnRkhSQVV0cDdxZG1ucGRIM0Ix?=
 =?utf-8?B?a3JBVDRvMDFML1dVeVkxVWpCMWhYYUtNcnVLeUszTTJWb0NiNmx4N0VyK3R1?=
 =?utf-8?B?RHVFT3RPZUk5ZkxwbVQ5ZDJsNm12UjBOZ1Y4bGVNdStUMVJqekgwSVU3N2ht?=
 =?utf-8?B?QUtMbFhCUVRoOGVLQlloRkxMdmU2NEwwR3pLaVdxUDl6d1BVT290allXRHZT?=
 =?utf-8?B?NG5BVkRyY3Q5Nzd5VXZMamVjcDMvU210VTJvakZXUldYZEtBdXJ6Q2lhTGp0?=
 =?utf-8?B?K2xNQ1B6UXQ4T1JiSEJwaGNwajBER1RMdGRUZDlZcGVKclNINk1VRWoyZEM3?=
 =?utf-8?B?dENOdk1zZjJTVnBBdCtsWUZwZWxMTDFUY1k3ZmVWc2J1UEx5dnpVN1BQUm5u?=
 =?utf-8?B?UW5weTBrbXMwZEhxRUZtdW9sSllsb2UvSG1kM1YvQmJ2cnJaaTRNUHNqWTYz?=
 =?utf-8?B?SzE0UE1zc245UGRYNkRrS3dkY0pFSlRFT3NQdDRObTdrdVJ1ZzF6MnNZWDhs?=
 =?utf-8?B?aTNmbExOYVJDYjVqUkplcmJtL1lNQVFHMjlOL21PakFzOGd1aExCOGltd3Y5?=
 =?utf-8?B?NjNVczNKQktSY3p3bWtGcGFSaFplVEtmSnNyWWhrRlhXNGlvcjBXTFBQVmtF?=
 =?utf-8?B?Q0Y5NlpBNnoyaUYvUVBHN09IMkF2Tm0wRTlob0Yzclh6YXkyR0FQVlBrR0k1?=
 =?utf-8?B?bkNSMnUwem9aaU1yeTVRVHRlTDkzRjF5bSsrVXA3Z0ZsVGxrNHBIckwvQVln?=
 =?utf-8?B?b002NVVVZkYvVStTd2E1TlFiN1FOY1hUT1Nra2lUL1A0azJ1UWlyclU4OXN5?=
 =?utf-8?B?U25nUXZ0VHFsNGxPZTYveVgrVkdFZ0pYQWNYWWl5dVQ0QUhMbERDSHlQTkVD?=
 =?utf-8?B?em94cVBCeVZzd28yNjRuRkJMaTFnZUwrMTNPWithWm9OdUtrQ3VrdU9WNWt3?=
 =?utf-8?B?YlZIcjVpT01BMXR5OEZxbWNCN08rcVVaNllEMGlnamh6cXJyRVR1RXVYMER0?=
 =?utf-8?B?TDk1M2R4THNoK3ZWVTcwMUNySEtrbUpCZ21NWk5aZ3k3MUpNRi92eUtRVXQv?=
 =?utf-8?B?N0doalBkMVNBcDZHOHBOeHRIWGFXSnJHVmUxM0swQ1BnWkNQNy81NnY5MEds?=
 =?utf-8?B?WTE4cW14cU8yMk1sRDRjWDVHNFNoQXd6cGZUdkVRT0JwbzYrUFlvQ0NzbHhu?=
 =?utf-8?B?Rng0azNlVmJZQmRXTDlzT1pLeWEvL3g5dUNOMTVrbFVrZEszQjh4TndET3Aw?=
 =?utf-8?B?VDNYRSsxOXBkUEp3YlhrUm1oRGM3c1p6QUJtWmJDYlFqNEtYMVBHTDBUdGlK?=
 =?utf-8?B?Rm5RdjkrZUVRQjczZ0NEdkdlQy9lVUlXN1d4bUgvd2wwemhDRnRyMHZGZ3hU?=
 =?utf-8?B?MDY0UFd0UjIrdXk4aUhYM3RjRm54M0ZLc3h3RzNsR0hHYkVEOURCSHlmQ2FG?=
 =?utf-8?B?R203eHdzcmtXSVg5dzlQbko1MitobS90cERLd2U1YmJJUnhZUHZlL0J0ZzUz?=
 =?utf-8?Q?eXsyM8U39Wn8N5VXNFUEymspH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf71be81-adf7-4b10-c0ea-08dc2e59a594
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 19:09:35.0251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /2HUjzGuoVu9sCshRNP/nHOO0d1oX6xuec/IjGFGpQLQngB6KEphSuagLdbbFLEGXvx0reOCIVYhTbO1cOajJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259


On 15-02-2024 21:31, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Feb 15, 2024 at 04:55:47PM +0530, Vidya Sagar wrote:
>> On 15-02-2024 00:42, Bjorn Helgaas wrote:
>>> Hi Vidya, question about ancient history:
>>>
>>> On Tue, Aug 13, 2019 at 05:06:27PM +0530, Vidya Sagar wrote:
>>>> Add support for Synopsys DesignWare core IP based PCIe host controller
>>>> present in Tegra194 SoC.
>>>> ...
>>>> +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
>>>> +{
>>>> +     struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +     struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>>>> +     u32 val, tmp, offset, speed;
>>>> +
>>>> +     tegra_pcie_prepare_host(pp);
>>>> +
>>>> +     if (dw_pcie_wait_for_link(pci)) {
>>>> +             /*
>>>> +              * There are some endpoints which can't get the link up if
>>>> +              * root port has Data Link Feature (DLF) enabled.
>>>> +              * Refer Spec rev 4.0 ver 1.0 sec 3.4.2 & 7.7.4 for more info
>>>> +              * on Scaled Flow Control and DLF.
>>>> +              * So, need to confirm that is indeed the case here and attempt
>>>> +              * link up once again with DLF disabled.
>>> This comment suggests that there's an issue with *Endpoints*, not an
>>> issue with the Root Port.  If so, it seems like this problem could
>>> occur with all Root Ports, not just Tegra194.  Do you remember any
>>> details about this?
>>>
>>> I don't remember hearing about any similar issues, and this driver is
>>> the only place PCI_EXT_CAP_ID_DLF is referenced, so maybe it is
>>> actually something related to Tegra194?
>> We noticed PCIe link-up issues with some endpoints. link-up at the physical
>> layer level but NOT at the Data link layer level precisely. We further
>> figured out that it is the DLFE DLLPs that the root port sends during the
>> link up process which are causing the endpoints get confused and preventing
>> them from sending the InitFC DLLPs leading to the link not being up at
>> Data Link Layer level.
> Do you happen to remember any of the endpoints that have issues?
We observed this issue with an ASMedia USB controller card. Unfortunately,
I didn't keep a record of the Vendor-ID and Device-ID of that card.
>
> Could save some painful debugging if we trip over this issue on other
> systems.  We have seen a few cases where links wouldn't train at full
> speed unless they trained at a lower speed first, e.g.,
> imx6_pcie_start_link(), fu740_pcie_start_link().  I guess there are
> probably lots of edge cases that can cause link failures.
>
> Bjorn

