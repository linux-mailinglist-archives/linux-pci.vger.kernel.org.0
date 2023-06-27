Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E26740296
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjF0Rsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 13:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjF0Rsn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 13:48:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFE297E;
        Tue, 27 Jun 2023 10:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmZIJd7vt0p14yXhQ16AE+X1J5ba9nyeiQ3hN8Xjyfbp8qZp0XjyaUozO3cOxzbvx9+NNDP2Ng0+nmq9CzopyIw4udkugxvj76YRqhT1PD4z+cJvZthE4nGA/zOl4FYqby1VpbL1puSn2XKpIh7j/pTIAfH/dsidq3q73yDzHmqYlE8gScQU+iq36iWzH2SGEfeiAN5FdbVgIzrWFIiymfEvs8GgVJc6rTWm2wNXPZ1hvaYz3jJph/Iu1fRB+qmXUn94n6gJ4tcjG6SbsZ0I0Cwnp8ERbjw75B2xrYofLSuJsYTlsxwNz3qEe8FXesFW579UXQgueEGuoURNhHIgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+X+9FMxK1Pra2lFhI+UugpJfg9kD4Hnk2X/oXRZ9MQ=;
 b=GRfA+W24kzsgrGFwH8dsPj/MYeEgNfFAATul0bIdJeiMkoa6zLmlTewX6tGBX1xlDyp9o9g02st8ZIslAcKm2qhiBb7t3h0Xe+vQc4ToSy2L37mplpUPiSBE9VPvgm5W+g6nY48v6e8zE63E7bw493nn0mJDIbNw5ZnSnmwNypqIDJK7OmqSdSmReP5TKYmdWeJi9+erzRIWBIyYl9XJKs7JMjndgUSv+Kob086e5PmpINhYIhDcQK7ZZgxZKAlPdHUzDO+Yg/O4p/5HOHp5OhRSffzBDWlJ5C/nsu0U7TyQMxhVo9rOO6aJPGxlTbqDoOmwXQpbOfmVSbmpnHPxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+X+9FMxK1Pra2lFhI+UugpJfg9kD4Hnk2X/oXRZ9MQ=;
 b=Sz9g7rNYiDL+XtIaILYfDR2EMM70zNwSrTPT0NdkplzthmMn/PMy3ufdamxsX5fYGGne1kiis3NLWoDn/naVfw52GH2MudcrD2ejxeVRAoK94kcXHSpmUoyCVmRs2rOdCRiE1AQN+furECItvVS45zfFyDvCq+L664/mC+GGEYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 17:48:38 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::b616:6941:8855:93ad%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 17:48:38 +0000
Message-ID: <a79c82bb-e1fe-891c-87f9-6231a30e5ef2@amd.com>
Date:   Tue, 27 Jun 2023 10:48:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] PCI: pciehp: Add support for async hotplug with
 native AER and DPC/EDR
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
 <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
 <e7aa803b-2b43-dc43-1d92-38bcca636e62@linux.intel.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <e7aa803b-2b43-dc43-1d92-38bcca636e62@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::25) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6a3445-a4e2-4731-a468-08db7736bca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6s812OOi/VxapPPxRTuZKkzOtjRp3ThX4fWfbZYHlqt+Sc4FKgzurq2yuAX1QdoFYV0GD3LtDXJvye1yn2WExu+vqN6sBb89dR4iljiflBxMMw12zX7w6Mcpg1ecrDEsm2IgcGpva3mADaGy5VfXsLx5nDYin6qaVQay98bD6PwVAhpQMr/tp9p2CUI4mrskQrLiS55DqqnF78MEcQ27k0GJqWHWRSmY94ixaqZBOnRmhPSgzwzxLJST4KrO0WgNwiQpEB1B4/QZu+LLemefYbt8FrFwKwZDyLJhBMOkcrskrdyFFwxO59LWVSCLM9U7FriSlS1qOVwdbR6um2eWRQcPVnPubfkH/CsNxRWglnYDZ8EjdiqGNxqA/sfBJYlf3PULn25WD9NwN85u03V6UCTygfwI1f/EALZX1d9cyik21H63vd9wes90jdT6hXq+Blya+QSzvxzJcTJ7CX1k5HU+dpuqTi9R0wAJ/fJ4YdGExFS8Wp0OwocH0ymqEZfoqakQo4V1zM23AZwbKPgtjjAHWETcfYCR/OuieDN4WJoxwRuVgEbXYSiv/jTKng0AeNh4TdBaPAtS1PiG02EKiFtPyOyKSvH1ebAgezDezNowgq85Tla5+m6VIHlWugskbuauKs4srhbTyF/haiqF7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(2906002)(966005)(53546011)(6486002)(26005)(83380400001)(38100700002)(2616005)(6506007)(6512007)(186003)(41300700001)(54906003)(31696002)(86362001)(4326008)(478600001)(316002)(66556008)(66946007)(66476007)(8936002)(8676002)(5660300002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW51cHJnRGw2YUM4YXUzak1wWjdRK1IzeEp5alhXMkx3eWFEYnVLdmxZSTNn?=
 =?utf-8?B?THpyQ1RqbThsZG5PaW4wVnFGRWZucnFnM0p2Y2FCeThKT0hCa1FaRlFXamZL?=
 =?utf-8?B?ZzJMN0JBdFhVRnJJZ1lBdk00YytWKzdsaTBLSDVhQktWUHlrRHdnOXBaa0Nr?=
 =?utf-8?B?YU9FYnYraFdJb21LZGxCdmQreDE1ZkRKbVBUM2ZobXJDRmRyUEFsS3Q4ZUZ4?=
 =?utf-8?B?cGZMa0ZlSXQ1R1l1bll3S1d1a0s4UDVTMTk3cCtPYm5nTWQwOTJoemNGMmhJ?=
 =?utf-8?B?ZmtydGNYK0RwQlQwRDNuQU5hdzJ4eTJjeTh5Y2V5Ylg1SVZTSmo1S3FWTC9C?=
 =?utf-8?B?MkM0RlRYKzdGaEFRS0t6VTdUNFdFSnZPZVlqVm5qMFhVV2NLUlpuK0FISURk?=
 =?utf-8?B?RGI0NVVEWXJPR0ZmMkprcTFrdk9YZGNsM3E5Z2Q0bkZTSUhQL1RiS0c0ell6?=
 =?utf-8?B?Y25yUHlxRkQ4aWt6TWpmeXFtNXhnblFlTjFQWmlaVzRxUGJ3VEJIak1ZMGtn?=
 =?utf-8?B?dE04ZjIwNHFDb01pN3dtTUxlVnFkdUJ6ZTk0clFNK3prZys1MEttTUVZcG95?=
 =?utf-8?B?bVBqbXFjV0tBdEM2UmdGRU5DcDA2bWhrTW9va3Z4M2V5Q0dwTHREazh5RFJj?=
 =?utf-8?B?R2E5ZmlyekFQUmF0WjQ1ckJ2T2ZBelpWUEZwV0d5QzV2TU5Ld1NsZkxoTk1v?=
 =?utf-8?B?MSt3ZGNEY1dRZzBzUUt2L3dONENXUWRsUHhid1Y3SVdiL21qTzJ1OUJFTzZ6?=
 =?utf-8?B?UWJZMDVBUkhieGsyN29oUzNZeTVSS29tdnJOVTh0YmlQL0l1U1RZQUZpcjFu?=
 =?utf-8?B?dG1pMktFMkJnZi9WbEVFTUdDWC9TQUVYOW43SUovblBEL3B2Uy9zZC9uRm9l?=
 =?utf-8?B?Z1BSSkVkZWRMai9YWmVHS0NZWFlnZDlaVWFNdTZ6S0k0bDJ3d0VOWHNoaXpt?=
 =?utf-8?B?bVhUT21XQmM4aTVOR3RWaXhmdityYUtlZjU1dVcvSTJBYk12T2pzQko5VWJY?=
 =?utf-8?B?QktzNnZWQ3lOUUpPMjZIYnBRZkJLRldGUWJuWHl6eU02THVibHpMMTVxMllL?=
 =?utf-8?B?TTdYOEdzOSs5VkttQlcwM3RzTU50aVc4N0lyaTlEUEtMMlVIN1VEL1pCT3Bm?=
 =?utf-8?B?eDA0bk9mSUNvamxyWUgyT1hVbzAvbUNncHlVc0lURndncFAveXpGTkJBeVJE?=
 =?utf-8?B?Mi9ZRFJjNGFkNzFlanZGSUlDYW5ZV2VWSERIelpOazJBU2JHc3l2Q2dqRUM2?=
 =?utf-8?B?ZzAwZHZpSkRMUERpK3Z2dEh1cHh2RmJQcGZtTEFSSHJJSHNyZVBmUW1SUEJ5?=
 =?utf-8?B?UkJRY3NsUEFMaEVjTVptdXlFb1RWZHJXZ1BtaGxMYngyUUhoVlUyS2hRYm0v?=
 =?utf-8?B?bXZhK2luNnFpUXhMaklkTUZhbUVnc3h2WGdON2E3cEcreGVLaFBGUlpydDJu?=
 =?utf-8?B?VElUYmFNeEZhQ0sxcC9EMjJjd0lxcFlsemQvYkUxT0h5WFNVK3FrcTY0REZl?=
 =?utf-8?B?OEkzRkZVTVI5UmVleEpyeFMxbE9MWVdSb0JtSWZjUVFXT1NIN2dJTEk3TWFG?=
 =?utf-8?B?NmptTnphbnRTMjhQL2QvZGR0YlVCcmdkMnIvREpSMDQ0ajV2Nnc0LzBwZWYw?=
 =?utf-8?B?bHhkM3ZuQk1IWVl5bFBFNUxVUERRc28weWQwZER3K3dyYzdXaDVqUndkYzF4?=
 =?utf-8?B?bmh6MHBVVVI3cHJMMitsMW16TTlxaENWdkV5MFV3V3BWeFJ0c0tHcnhuZFRE?=
 =?utf-8?B?QUFFaFppVnk5a0cyempsaC9ycVk0ZHVSajJoUUVvVmU3cTJCZ2Rrd3pnMjNX?=
 =?utf-8?B?Smo4Q2RBKzdsMkpXYzhHR2liMG8vRDhRMUxRQkJ0ZE9uWCttbWJiVGJxNHJo?=
 =?utf-8?B?NytmSkthMU02bitOaklXRnpYcWp0S2huVmlwc1p6TWlXcldROHBaN2tsSngy?=
 =?utf-8?B?YTRjZzMvYm14Zm8xRVlVV216SVdpUkRjdlpuMm9KRUhKMklpR1ZENFVhOU1i?=
 =?utf-8?B?Zk9XRUVYM1l4eTZuL2xaNmVEQkpIdVlpbmtrazQ3NGwwdzk4NlUwdkdvSmxP?=
 =?utf-8?B?a0VPYkdoVTVrblhsNm1uRDZMelhZRFlwTGhETk51Q1g1S1BHYXArZDJwdkZJ?=
 =?utf-8?Q?8KfbmsKcTG+OgnXT4enJyfYsS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6a3445-a4e2-4731-a468-08db7736bca6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 17:48:38.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3T/dHj+rkcQBZnbAYDs4QjymmkRbUquUYi4KIQm5YR/RUC7/IXvOgkL0zyc/Yziu6TLW1WjO9iJI4rO9bft6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/22/2023 4:22 PM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 6/21/23 11:51 AM, Smita Koralahalli wrote:
>> According to Section 6.7.6 of PCIe Base Specification [1], async removal
>> with DPC may result in surprise down error. This error is expected and
>> is just a side-effect of async remove.
>>
>> Add support to handle the surprise down error generated as a side-effect
>> of async remove. Typically, this error is benign as the pciehp handler
>> invoked by PDC or/and DLLSC alongside DPC, de-enumerates and brings down
>> the device appropriately. But the error messages might confuse users. Get
>> rid of these irritating log messages with a 1s delay while pciehp waits
>> for dpc recovery.
>>
>> The implementation is as follows: On an async remove a DPC is triggered
>> along with a Presence Detect State change and/or DLL State Change.
>> Determine it's an async remove by checking for DPC Trigger Status in DPC
>> Status Register and Surprise Down Error Status in AER Uncorrected Error
>> Status to be non-zero. If true, treat the DPC event as a side-effect of
>> async remove, clear the error status registers and continue with hot-plug
>> tear down routines. If not, follow the existing routine to handle AER and
>> DPC errors.
>>
>> Please note that, masking Surprise Down Errors was explored as an
>> alternative approach, but left due to the odd behavior that masking only
>> avoids the interrupt, but still records an error per PCIe r6.0.1 Section
>> 6.2.3.2.2. That stale error is going to be reported the next time some
>> error other than Surprise Down is handled.
> 
> I think this fix is applicable to the EDR code path as well.
> 
>>
>> Dmesg before:
>>
>>    pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
>>    pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
>>    pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>>    pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
>>    pcieport 0000:00:01.4:    [ 5] SDES (First)
>>    nvme nvme2: frozen state error detected, reset controller
>>    pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
>>    pcieport 0000:00:01.4: AER: subordinate device reset failed
>>    pcieport 0000:00:01.4: AER: device recovery failed
>>    pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>>    nvme2n1: detected capacity change from 1953525168 to 0
>>    pci 0000:04:00.0: Removing from iommu group 49
>>
>> Dmesg after:
>>
>>   pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>>   nvme1n1: detected capacity change from 1953525168 to 0
>>   pci 0000:04:00.0: Removing from iommu group 37
>>
>> [1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
>>      https://members.pcisig.com/wg/PCI-SIG/document/16609
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> v2:
>> 	Indentation is taken care. (Bjorn)
>> 	Unrelevant dmesg logs are removed. (Bjorn)
>> 	Rephrased commit message, to be clear on native vs FW-First
>> 	handling. (Bjorn and Sathyanarayanan)
>> 	Prefix changed from pciehp_ to dpc_. (Lukas)
>> 	Clearing ARI and AtomicOp Requester are performed as a part of
>> 	(de-)enumeration in pciehp_unconfigure_device(). (Lukas)
>> 	Changed to clearing all optional capabilities in DEVCTL2.
>> 	OS-First -> native. (Sathyanarayanan)
>>
>> v3:
>> 	Added error message when root port become inactive.
>> 	Modified commit description to add more details.
>> 	Rearranged code comments and function calls with no functional
>> 	change.
>> 	Additional check for is_hotplug_bridge.
>> 	dpc_completed_waitqueue to wakeup pciehp handler.
>> 	Cleared only Fatal error detected in DEVSTA.
>> ---
>>   drivers/pci/pcie/dpc.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index 3ceed8e3de41..5153ac8ea91c 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -292,10 +292,68 @@ void dpc_process_error(struct pci_dev *pdev)
>>   	}
>>   }
>>   
>> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>> +{
>> +	u16 reg16;
>> +	u32 reg32;
>> +
>> +	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
>> +	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);
> 
> It is not clear why you want to clear it.

We are observing, Surprise Down Errors setting error bits in these 
status registers and also Fatal Error Detected bit in DEVSTA. Hence, we 
are clearing them to mask any kind of appearance that there was an 
error. Will add appropriate code comments in v4..
> 
>> +
>> +	pci_read_config_word(pdev, PCI_STATUS, &reg16);
>> +	pci_write_config_word(pdev, PCI_STATUS, reg16);
> 
> Same as above. Can you add some comment about why you are clearing it?

Will add.
> 
>> +
>> +	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
>> +}
>> +
>> +static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>> +{
>> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
>> +		pci_err(pdev, "failed to retrieve DPC root port on async remove\n");
>> +		goto out;
>> +	}
>> +
>> +	pci_aer_raw_clear_status(pdev);
>> +	pci_clear_surpdn_errors(pdev);
>> +
>> +	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
>> +			      PCI_EXP_DPC_STATUS_TRIGGER);
> 
> Don't you need to wait for the link to go down?

Yes will include, pcie_wait_for_link()..

Should this check be here or at the beginning of the function before we
check pdev->dpc_rp_extensions?

Thanks,
Smita

> 
>> +
>> +out:
>> +	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>> +	wake_up_all(&dpc_completed_waitqueue);
>> +}
>> +
>> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>> +{
>> +	u16 status;
>> +
>> +	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
>> +
>> +	if (!pdev->is_hotplug_bridge)
>> +		return false;
>> +
>> +	if (!(status & PCI_ERR_UNC_SURPDN))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   static irqreturn_t dpc_handler(int irq, void *context)
>>   {
>>   	struct pci_dev *pdev = context;
>>   
>> +	/*
>> +	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
>> +	 * removal might be unexpected, errors might be reported as a side
>> +	 * effect of the event and software should handle them as an expected
>> +	 * part of this event.
>> +	 */
>> +	if (dpc_is_surprise_removal(pdev)) {
>> +		dpc_handle_surprise_removal(pdev);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>>   	dpc_process_error(pdev);
>>   
>>   	/* We configure DPC so it only triggers on ERR_FATAL */
> 

