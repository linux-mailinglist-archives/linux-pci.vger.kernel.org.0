Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F198D5EAC30
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 18:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiIZQOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiIZQNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 12:13:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A13175BF;
        Mon, 26 Sep 2022 08:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hke4al7MIHtqunKKQ4ClKU++CrPo1aNGExFZ6oJvKfAEdU5ycTUBHDq5cdcVOWvGtxcF6eio5EqM/NmpG1MDS7TAW8YYgORXOfllaJPdmDoyG04Ej8ynUg7tvaUkg09CTMlWc+Wwce1vGaHwIkaPjNrzAuVWbzgGUQVrcbMVjpyEIkzgQgFxfYx3fLC9g8XE7dCkoqch0K62j90ym/+xM0vYg7r+hlfa4AO7EvmuqVKLpFgCVQrX1IhrLx/nTqFUGSxGX8sMPEUqrEycEgPbfavMNpzMuzrFrpNVnIsC9sbUH+oxI403RsSAzqF9J/BOWZiieeDeGKSj0f9joouqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72jroKSeNpqDaUeXowzHy9ZkB/0f2n21N/R/8Y1N9uI=;
 b=kQ4JGptdKfi899F+/mNCy7GM23isoetIfE0as6FUHDqs1xCn9uMnBodv393wmY1vpSND/WvTMpdu5Ze+qP1Sg1IdvnMbOQO+Thfiw4MYfgGPImoajXtbcd6xrd2myNNz7dqzJTDT/oML1k6rJtNnb80sXltdtaRSQosGsAJxZJCnz0bFDWqGnK2q9PE/JmZxIZOq4RlCzQlID0lL7mDxzPkvdWzJ0KtSpHxajdK2ZhgDWMvhRSZmrTLYaR5hx1eEHEbDlk0lrsyz/5+epF0cnpXq+9xRYvvJd2yQsoInadLqplb5YctHKTCq6xVuT04jF4jL6FvUE54PlZ9KvhOerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72jroKSeNpqDaUeXowzHy9ZkB/0f2n21N/R/8Y1N9uI=;
 b=uS6She1mp5U2gcixfAlZYcLdorRJYhWx7PGjXp9HeUARkn/0yEdX4vx27oUKhur4ljXr2uLvAfLQt2mdQEjGN+QBdHTBV+Lt5vUE9w0W9LN+zNYXDVXmxRDLoxO3kXixt4sU5h0UcL1XbVvXrTXGWv/ooOX7sagyYgClRHfMZDfRBzz6PavD3o3W7JhkERDZkeR8v0BO/ZrYifcRU0gaH/KKLVbpI6mIUPu3XoRYisErnvWvn7eMvBAX2lBb/pPKi3tuxsW4bxXHKw2uGpmOC6IZVv9vHrrP/MeB0X6MvmuE4dWpZMZGiAxez0SQMeizp6mC6+7LRJ9kJTV6ae+HRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:02:23 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5654.026; Mon, 26 Sep 2022
 15:02:23 +0000
Message-ID: <554df533-df52-ee69-6c6f-effba88b55e1@nvidia.com>
Date:   Mon, 26 Sep 2022 20:32:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V4 0/3] PCI: designware-ep: Fix DBI access before core
 init
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, dmitry.baryshkov@linaro.org,
        linmq006@gmail.com, ffclaire1224@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220919224014.GA1030798@bhelgaas>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20220919224014.GA1030798@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::15) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|PH8PR12MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: a075f6be-b5d7-45af-3bde-08da9fd01d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rPiBj5K7dluMsDmELsi+FmvSTuhAP2YPNwPF64UKZoTu3xm7f4tK7qSH88PIblCrrGeBMiAietTa+1E6nfg5B7ylUo9vraHfZm+TrBkXbs/uNs0Vcn44bFo9W4IG6pDg4DSG/NZ/vuJe0dEGvrR8Wonprg6kfm5Le305HKc6oDyCXho9ZiKt21Hvs64q6TmkO+kJ7HH/Kz+V6vVaB97wMIcTAyRzHg/BBZ4RnxRI46iW4tOTfXkvKixlQ/t+mfEM02TRC00uKQosYbtSwAGQL0mHSMuHPBm7FNhoShL8JAhcrxiEcul4DjaFkE4HVj8mDDUb5CN4uCeLupbeGD1qd8CZcBoC1vXmRQ8o2/BY5n1JaMpQXL7ql6rzmf6xbiQRg1OTuCMfsSwDNDlgQksQGTdSDVZt914+hWorDHH726EhHZwGz9oVsDlBYy00MOU4vXBoUNsOkiLUjWYjNFCCNq+U36oYZ8vQobtWd2Mcte1CZ/75BeqhFXrgzFEa4XyAIxyj/W3pS9Yx4q3/osxy4Xo2jb+Bi1dWpcuMWJ6DZEBcM6gFo4L1yyweLA+lXKcIyUQMW2CXu96YLXdPSqz3jrKmxA4Z3kxo6PI7FE7w/5AXxsVd0EpP2fx5hHcowZ5YtRTbQv7skqSFsI2DuShVm9sRPq7dpC2uYO5GVbZFrD1LmyPmiDZtAcHnxy8WE0pFf/qLZ9IE/SABj8Jtbl/4fvjaWTujhP8CZHU35FML7RBKPy9496fPKUmxu2HLRr/MaBqDbqZbIqoWJuQ2CMhgTCxP+6JGlo4Axw/WHR1gsqlDcKdHk7Ubu01rYC6FbDVPtdw1rqq663ueIilUPzwMPqK29GeBdz9X30SHwck4UA2BWLVaxi7N6brn0WJ5Q5F6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(36756003)(31686004)(6916009)(31696002)(86362001)(186003)(7416002)(5660300002)(2616005)(38100700002)(83380400001)(316002)(6506007)(53546011)(41300700001)(6512007)(6666004)(26005)(966005)(478600001)(66476007)(6486002)(66946007)(4326008)(66556008)(8676002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU1SeXp1NFVyclVmTUJQaTBxTWFPOFdYU3FMN3owQUpIOE84emdIdlZjM3JQ?=
 =?utf-8?B?Z0JWSWNNVFBOcTNBWm8wODEvQ1FmVFU0SUdSTXJKWWxoOFJoTVRPbzRBSVNR?=
 =?utf-8?B?LzBnMzhPQUhacmhsbzMyYktUeDdCWlFiSHJkQ1l1VHp5ekN3MlRKU011ZmpO?=
 =?utf-8?B?cTlCcW5PcjFqdVZkTkdlQ29qUDkycTYzU1NOcGZiUGhqRXRNeHZkWWJYZjRL?=
 =?utf-8?B?L0pCQWs1bGdxWWF1Qkg3WUZHd2s3S0Q5ckk1bGYxNDhieHJNQnR6bmRma1Ey?=
 =?utf-8?B?SlZGS1k0VzZyVXB5WkthNEU3L29uZWs3akRXV0g5bjlBS2lpdHBBNG5TbnJY?=
 =?utf-8?B?MCs4bmpobkJ6bE9GK2Z6VGc0bVkxTTRFR2tLUVNGOHpQdUxPdmt3bG9CNTFF?=
 =?utf-8?B?NVpZV2MwMTdTdFJ1aCtWYkpPZHFDUU8rRUlPVmx5R0pmTklyaUFUbjlsN2RJ?=
 =?utf-8?B?YzBJaXVQZE1KOW9uTjJnb0g0WTIyUTIvZUQ3b0tRR213dGZrTDYzRFphVzNQ?=
 =?utf-8?B?MWEzL3M3ZnNiaVpMSWFCblBkV211NkVPL2JWZ2JyRmViMjlPZ2NlTlBDOXJS?=
 =?utf-8?B?Q2dPR0JDWTlmSW02MHpIVzlZazFUWE5HTlRwNVV2aHIrMFNiMEx3aHlhTmhN?=
 =?utf-8?B?eE1Qa0o0dGZoR01mQW5kT0drNEJRZzdCdHJ0eHFON3RGZlhBUlJzei95T0E2?=
 =?utf-8?B?RzE2K2NIaUFVNTRwdkhObi9SeW8xai9BRGhsUmR2My9teGtwQmpxV1h2aVNY?=
 =?utf-8?B?cVlLT2hTd1lnazlxN1RxY2tJRVpPeThhU0t1YkdtR01RK0MydDVyNnFkNHRG?=
 =?utf-8?B?SlgzSEIrZU9mblc3VHZXSFdjenlUbHBSZkJRbnBmakhLQ0REWFhxNE92bktu?=
 =?utf-8?B?YXp5bUc5MGV4cEhtVDR4eDZJYnVvS0VTbXhlTEsrU3J5WmdqaFE1RU9OUFhE?=
 =?utf-8?B?VkNTME5OdkF6RVhyWk1taWhTd21sNThycWs1Um5NMmdYa1RzSU51YnZzZnhv?=
 =?utf-8?B?dFl0ekFuWW9yMlRFcmx5MVA4L1pvTTBOdTM3WUhlV0pEbUZVUlZ2NmdIU3RS?=
 =?utf-8?B?L29jTUZvVlY1cENTeUlxbnR6djdaMURTRjVRMHVuNUpsUmNLaVhQWHpxV1h0?=
 =?utf-8?B?YVppblFpZmtWcGxrd2xBbnRLTnlIcmNXWExncnBNaDgxMjNEbWkxVE55NHRV?=
 =?utf-8?B?ZUdST2l5NXhUSzBobFZ2TnpaZlYzYnJZdzZVTkQzdUUxckdsTWdjNzUzczBz?=
 =?utf-8?B?bVhRRGFTVW5yVFEwMEc4ZHFhVVRIQmE1amZaM2EvaGI5TklkK0RVRnZaT0R5?=
 =?utf-8?B?bjdkRncyWTRFM3B2VTZJckNaeWMrbk04SE4vK1JvV3h1YXZpd1BGaVZrWGQ4?=
 =?utf-8?B?MHVvb3JXeXI2dmJLOVZuVHhRSS9zUVFPT2hsS3hMcmdnSzM4Ym1GNnZ0STNn?=
 =?utf-8?B?TnJVWUFMWitHelA5RGc4cVNvVjlQaGtyelp1UUxaRG5GbVMraWhnL1ExTUda?=
 =?utf-8?B?YW5wRTBmYkJ4OGx0clJRNmJWd3JQNldVbTBNdmFHNGhpM3BtcDdFNk5MWU9x?=
 =?utf-8?B?ZUh4Z0hPaHFsMGV3ZHpnWGt5ZHpJekRZWXZnY3JqVEd3YVpCMXNXNTQxVGFS?=
 =?utf-8?B?b29pSlhlOHhYOFNIS1VvRlptaUdodGVkaUx5WS81WEpVeDkyRzRodUdiNlln?=
 =?utf-8?B?bzlwUXltQXMxODZ5Z0d4c3Yvem4xNlVpdFVFZDJRb0dQNVlJR28vai9jRFBm?=
 =?utf-8?B?WnMwS1lHdEdDUHI2ai9SdmRLcmpsZjBLdHIvTEJFNkJYNnRXZ1h5WGRVWWRn?=
 =?utf-8?B?Q011MHF5L1F4S3c4SStqT00wM2M3WkhIQktkRGJhTUJ4VVh4TmxQSGNXZXlE?=
 =?utf-8?B?L3p3eUN5emRGdmdaVXlaaEpiQkJJejZTbjIyYzZydmVHeUxOL3QyL1BuYUhQ?=
 =?utf-8?B?eVgwckVHOTNHMytwZzJmSFdJMHdrMnZ5RGs5ZzZ2RVgzemtma1A5ZlpuSWFS?=
 =?utf-8?B?Q2F5UElZTmVndUVtWU9aK2N1cTVHMmE0U2tBQ1M5eVZyNmtCRmxIREg5SFMx?=
 =?utf-8?B?ZzkzUHZHUkxqVXg4S1hnNGpwM21FRldlV1d3blRnWXRPQ21QcU5Ud0g0Y2Iz?=
 =?utf-8?Q?4CVrzZUYnMIWqGKgk+ZhTRm4M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a075f6be-b5d7-45af-3bde-08da9fd01d94
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:02:23.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DichAho7qBiKUc2plf4fL0jJSqTTGa5KwrSsqjmyRdy9hZBFnRLX06NlvgDUjUdIejbqpLt4/030KyTCPMJVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/20/2022 4:10 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, Sep 20, 2022 at 12:03:39AM +0530, Vidya Sagar wrote:
>> This series attempts to fix the issue with core register (Ex:- DBI) accesses
>> causing system hang issues in platforms where there is a dependency on the
>> availability of PCIe Reference clock from the host for their core
>> initialization.
>> This series is verified on Tegra194 & Tegra234 platforms.
> 
> I think this design is just kind of weird, specifically, the fact that
> setting .core_init_notifier makes dw_pcie_ep_init() bail out early.
> The usual pattern is more like "if the specific driver sets this
> function pointer, the generic code calls it."

Thanks for the review Bjorn.

Typically the PCIe endpoints run using the reference clock from the 
hosts that they are connected to. Our hardware designers followed the 
same approach here as well, but the main difference here being that the 
controllers operating in the endpoint mode are not standalone 
controllers but part of a bigger Tegra (/Qcom) systems.
So, the complete controller initialization sequence just can't happen 
during the boot stage itself, hence the boot initialization sequence 
needs to be split into two parts viz a) early initialization - that just 
parses DT, does the programming that doesn't depend on the reference 
clock from host and b) does the programming that can only be performed 
after reference clock is available from the host
We are working with our hardware designers to avoid this dependency on 
the reference clock from the host so that all the programming can happen 
during boot itself and hardware is smart enough to switch to using the 
reference clock from the host when it is available. But, this is for 
future designs and Tegra194 & Tegra234 continue to have this limitation.

> 
> The name "dw_pcie_ep_init_complete()" is not as helpful as it could
> be: it tells us something about what has happened before this point,
> but it doesn't tell us anything about what dw_pcie_ep_init_complete()
> *does*.

To be inline with new ops ep_init_late that I added in this series, 
would it be fine to name this as dw_pcie_ep_init_late()?

> 
> Same thing with dw_pcie_ep_init_notify() -- it doesn't tell us
> anything about what the function *does*.

Would it make more sense to rename it as dw_pcie_ep_linkup_notify()?

   I see that it calls
> pci_epc_init_notify(), which calls a notifier call chain (currently
> always empty except for a test case).  I think pci_epc_linkup() is a
> better name because it says something about what's happening: the link
> is now up and we're telling somebody about it.  "pci_epc_init_notify()"
> doesn't convey that.  "pci_epc_core_initialized()" might.

Ok. I'll rename it to pci_epc_core_initialized().

> 
> It looks like both qcom and tegra wait for an interrupt before calling
> dw_pcie_ep_init_notify(), but I'm a little concerned because I can't
> figure out what specifically they do to start the process that
> ultimately generates the interrupt.

As part of 'start'ing the endpoint as mentioned in 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/PCI/endpoint/pci-test-howto.rst#n101
we execute the following
echo 1 > controllers/141a0000.pcie-ep/start
that enables the interrupt generation for toggles on the PERST# line.

   Presumably they request the IRQ
> *before* starting the process, but there's not much between the
> devm_request_threaded_irq() and the interrupt handler, which makes me
> wonder if both are racy.

I don't think there is any race between these two as the 'start' is 
initiated from the user space. Not sure if I'm missing something here 
though.

> 
>> Manivannan, could you please verify on qcom platforms?
>>
>> V4:
>> * Addressed review comments from Bjorn and Manivannan
>> * Added .ep_init_late() ops
>> * Added patches to refactor code in qcom and tegra platforms
>>
>> Vidya Sagar (3):
>>    PCI: designware-ep: Fix DBI access before core init
>>    PCI: qcom-ep: Refactor EP initialization completion
>>    PCI: tegra194: Refactor EP initialization completion
>>
>>   .../pci/controller/dwc/pcie-designware-ep.c   | 112 ++++++++++--------
>>   drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  27 +++--
>>   drivers/pci/controller/dwc/pcie-tegra194.c    |   4 +-
>>   4 files changed, 85 insertions(+), 68 deletions(-)
>>
>> --
>> 2.17.1
>>
