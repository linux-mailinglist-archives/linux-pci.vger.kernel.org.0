Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E215F3BF8
	for <lists+linux-pci@lfdr.de>; Tue,  4 Oct 2022 06:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJDEFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 00:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDEFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 00:05:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B03711C26;
        Mon,  3 Oct 2022 21:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDPs2laSvatvcf3aQaxeut+9U0cguYTnc2PcDlcRIy6bGecKxp9uYEJ8v/9LQkWuFRkeBe+mt8SDiFD/LKREZIh3NywZ9kW/YlqiwXtXNsjQMWphjuFLh+MhfSHPYu8z4gDkZOc1cy9v6i+X1TiKCNttmx1jZX9Ay50D8+dNFYYq3PNjX84AIZoDc20Mp7JfrCywg8FKtQlaPTR65fQdqNw/iDjLTIR+91QAT9nccWGiiuTF7MT0bUdFpMe0VloZqOpIjnNfWi/f1rcad/2WTrmnK32ukz/oyG/g3/hYt9s8bZbkMNnRVImmgVZFnDwQtiXeLuT0ZV+hr0zb7xoK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlC6Or01MxI40uhbb/QxNkNlHKpGqHWVIL1FWUuFMO4=;
 b=Z0Xp3DaJD0Bt+CJtMj/92ObqHZ9iwulZalYUh684L79UZ8TEpb+q00IoB0zVfjJr5t7qYzxg/I986aFrfeKKAXOLVNBt91gQbHv5PLTtUyB1nlX4zCy3YbLojNwV6lY3gcQjHHRomxtCN/rO9CfbiTK3oOoKJX6W2lULkSZHJxy2Ft3j8jhKUFBem1qSTKTc2BsNSmOUMPeH5ZPWZPv35QWKE9HByhKITP6u8WPr4qP8swQIBvJz1ChrqZj7rQ9BMbhkrLETm1TKvjwybZBOWWBpKa9BGXujB4hoaAu3YHf52l/jw4V/vE/lMiKVmCgYTCnxBKM1T7OBG2Hu+9gOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlC6Or01MxI40uhbb/QxNkNlHKpGqHWVIL1FWUuFMO4=;
 b=uUwxVJhKNwifYVReiY/ADauir/7kiQON6lEfWdIe7Ppjktzzc9GsUOyxA/Yd096Zct2yamdLp8uKi4Fq2McM+dHj/4zO2oXc2/2ynUNzR9vmUjhNwXn+Tf6lpqIvWq7B3Fkyug35i2lTWfLeFMFDdyA8lyeKJ1K8ukVNKKbZG3l0GJmwizLLWAfPEn1xQx1BuJE7JsJQoOp+mVcrHM97R1lEjY40oVHEAkDh2dZXEzp7eNEzkjtFc7NuIQ8v1urPXb8d1hdAyvioB4i2PkiuCINWTTo44bgBqdAlGNWtxbB4p7Huh1sDddhZf+qz2T96GB0/C1oBiio79de9du2JTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Tue, 4 Oct
 2022 04:05:03 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 04:05:03 +0000
Message-ID: <364fc93d-a4b5-59cb-c62a-8e3b32507523@nvidia.com>
Date:   Tue, 4 Oct 2022 09:34:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1 0/4] GPIO based PCIe Hot-Plug support
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mani@kernel.org, Sergey.Semin@baikalelectronics.ru,
        jszhang@kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>
References: <2a465222-342a-418b-95af-9948f6ce9065@linux.dev>
 <20221003180949.GA2104321@bhelgaas> <20221003182147.jp5gn2jpnf4gucdl@pali>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20221003182147.jp5gn2jpnf4gucdl@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::19) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cacda82-3b1f-4856-9d61-08daa5bd9cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFQQ33sag3sG46Ucbu2sYvVxIZ3mJO2qmvYMrPGV0zVPWMmlLyl2djV8QXGuio5fAA8HjVfecKwYvzk155U++UbGPno9H+In/H8eeVA9TQ59yZe4CTooQb8Q12RvvTShpd4+kCV/DecARHuqVkFWwbwz/7Jw8VXnx9sRCPS8UT27IPBjKNOBZvQvj83/kYJVxwM8KHs8rYUamIyDn3n3i5w40DhghOHV2vFWOoiEZ/8qhN1xL04TQ7oOCSCNcE1DUx+p/N+4IZodJbw05jX9ONwTsULvqX6atZ9oheDvOxYNVox1uxa3wFq8+33Ghfn393H7xqsBAW9r8ytwolt5fc97cM88cwUrSRzvTHZJ6KJOYxKDJBranLno7u6e1tFOVgkpNEFopI9H/IW9FhnURNrY3OiUHHSQG8b73lBCjfSQqxp8BNGQEpo5m+6+RLWBTcAS3Sfh80OHKrY4iH5CkA0j/InQ08cAuqnzy1DNmPpjsfGYRGeseuUpY3rC88GVD6O3L9c6MMGNuw0rlUoFpDMMYF1rHWAuYVh0KuNF6O3SExkhQ/ZTh0RWx78kTVl2LzSl8dc8VYg0v0F36VCn4H8ddsDW4NkARNzAB5FKl9/WqP7kr7IxNpAcWcw+RJZvFOqkSRw438yIAH2aJBLqDmSp53cxzDxEvpxsX0IabCM7lzwJNx0409Sqjp5Pt3XUJCvSKFa3mWR9NXeRyrZmo6sNNdj1Y0kA2KA8aewrsvC2x2O/99637rZOFbsMLcrhJMbtABkBORKR6BbNGR3a4NvsbNpvjujwDUYX4V/jSYCcdNFbyTMz/ZQl++v+cSy8yAupZApWnTaPZOUd1yL5O2QKeot88Had8bwPoDd08XCWErXm04OvFs2k5MqkS4B3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(6486002)(966005)(478600001)(54906003)(31686004)(5660300002)(316002)(26005)(7416002)(8936002)(6512007)(6506007)(8676002)(53546011)(41300700001)(110136005)(186003)(36756003)(6666004)(4326008)(66556008)(38100700002)(66946007)(2906002)(66574015)(83380400001)(66476007)(31696002)(2616005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDExTWRuRmxSK0lKMmg2MlpTTG1WZzE5Y29vdzF6OGZMaWhvUng1Z3A1SW9Q?=
 =?utf-8?B?dzEyaGlhdnFNK0xoMEpuL3lyMUdWRXJFQ1R1YWhkTVYyc2dqL0UrWVp1c0E2?=
 =?utf-8?B?aHJTUVZCR0c2REIxSmd0TGpqSkJUTlFnUVdDNkI3OXkza0NZTGo3Q3FuT1hp?=
 =?utf-8?B?RjF3bC92SlVRcUVxY20vK2dyLzlMVEZ1RktpNzRJTmc1bk52aVlGOWIwaVF2?=
 =?utf-8?B?SzUxdng5SlFUcXlkaHFJUWdrcjJja2JoeDBubi80amxMZlVtdzhYa213cXll?=
 =?utf-8?B?TWZ2TmMxUFpNTUFwRUszQmhlalBiZnBleGhFTDdCYXB0bm1qSUlxblRsQ1Rs?=
 =?utf-8?B?NGdUSEU0WUd4QU1LT0puV1U0V1ZGa21QWXprQVBxNnZnTXZDRzFKZ2xhd1Vj?=
 =?utf-8?B?M2w2TEZTTE44K3Z5bklSSE5IVm9yeGMzcERxTXhBeUJvdlRZTmYrQmtid3Zh?=
 =?utf-8?B?dnovMjNSeE5SMTV1ZmVZdzh2bGppOGh0T3hqVmV3eXljUkhZZVBnMHpYa3NQ?=
 =?utf-8?B?K29QK2w3QUZzSzRUMlJRcXNVdDhVUGxjZ3hQRSsrd1JhdlBZZGxXTnIxUkpl?=
 =?utf-8?B?a0tjQ2VRQjFLY1RMRU5zWG9MUUNaeTJ2TnpjSEUxZ0ZVUkEvY3Z6OGF2Qitl?=
 =?utf-8?B?VzRvM2N0QnE5U2hud0QvWGFtdW5NZXQ3WnNVL3R4YjFOVVlGU1ZTRjl0VENn?=
 =?utf-8?B?M2xSWmZMT3AvOUpRaXdtUVVYRDQwNUdGalk2WFJWT2R6Q3hjNWExYnJReTVQ?=
 =?utf-8?B?QStYdVc3ZThXQ3RzK3dJaUZvNXVrQkxEempWSW8vY1QyTDkyM2JUYWI4ZlBN?=
 =?utf-8?B?R1VIbExDR25Ya3BuNzJoVWlIemNBRllJQkdrR2t3NTlpQ0JpVW1wN1UwTS9D?=
 =?utf-8?B?V2VJaTdWTzNGeDczN2hIMHREMEl6UlpBTGJvUVlFYm5KTTREa3pabUh2TElp?=
 =?utf-8?B?S0ZqS0daYVFzY1NKVHRuTEc0OGpJTS8zNVMzSTBHQ0ZySjVaejdEVkNJKzI5?=
 =?utf-8?B?akljZHJyYVV2SHovWjhjS052M0wxQ2ZWdzRZcmMxWnd4U0NuU0t5ZGhsVE9L?=
 =?utf-8?B?aURtbjlHWlRWdmNKYk1qd2l6VmoxNkJpUDNWQ2oraVpyUk9KRFZpbVJJQXRk?=
 =?utf-8?B?ek1HMlFKeWtJczZodm5jOFRRYjRxVnd2cWRIZ1k0dDJ3UE15LzJ6N05xYnpV?=
 =?utf-8?B?R3RJS1JlTjBGL3pEcjVqYno4V2lKQlIxVkR1TTFNU3cwODF0YlJpRlprTG1k?=
 =?utf-8?B?ZHZmN29CVGFLdTRxNlNlREI4OWVZRGs2VkNFM1VnYWp3eHdOZDVXTWlWS0s0?=
 =?utf-8?B?L0pRd3VXVkEyQzNwdjIzQjl4N0hRQkk0Vm83emF4RlBPV01nc0RENm5IZWpT?=
 =?utf-8?B?WmtSbndLZnk2TUs2MWUyZHh3a21wYnEySWJKNUVJYjhoL055TEUyVEhsbnMx?=
 =?utf-8?B?ajduSTdObFNyZStnblRrVEhnVXdxL015dzBYR29WK2FaUWs0Z0tmMEFqc3M2?=
 =?utf-8?B?c0dTbGFOcm1xVE9yL2F2TzFkcjIrK0RocVFFU2FQa3NJUFhDS0JSQkl1SUZp?=
 =?utf-8?B?TWtRemdsbGY5bEZaS3lnRGFiY3ovcGJzblYxOVQ2L2x5cXFJQ0FIWTM3L1pa?=
 =?utf-8?B?UXdxQ0ZsWnJHU2g0dHcrczZwRUJydzQyd3loYmJxUTQ4Sld2eW1uZ3Rlb1FG?=
 =?utf-8?B?ZzdpMDlUUXMrM2U0UGRtS28xK3hjYmJhM1oySHBDY3dOQVg1UGRxSGJlZTlz?=
 =?utf-8?B?NDdKWDBSVXY5UXo4c1NrMzlUVjdTenhNZHZiWjJFUVFKeUUybWtaRWhaVi9C?=
 =?utf-8?B?SVhhY2YzRXdHdW1QVmtoTzE5WFc3ZEx5TkRFc1gzTXU3ZlJvZHFKRERaYTZx?=
 =?utf-8?B?alFqS0pzU0R3dXh5MTN4eGw5R1laU3dLQ3BUOE9Ra1g1b2lUWHN1Q0RTS2Fi?=
 =?utf-8?B?M0pQRTZ4UVdUeFZkbEcycThqZHdWUnhKTkJOaUZjQVpCZlJBUnFxcnVHcDBU?=
 =?utf-8?B?YU1lcTdVNUsvZnpKQWUvaFRwcGo4cVdzbTlXekV4d0RpS0lMWG5jNGVkWFdq?=
 =?utf-8?B?M2F2SUxMaGJpbkI4ZFMzOTJCSVpsdGJIZ3Z5bUpnYTA5WjI0NUR4bWtqTEwv?=
 =?utf-8?Q?xqX0nAAdF4nbdnhaVNl4iqZeb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cacda82-3b1f-4856-9d61-08daa5bd9cfc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 04:05:03.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whQbeynybiLCnN7eV1piotQPCJ9uaunS60t355Nb1ymNXlDjHrC9kR7tBjOeEidp1zcnTbcylXsDGthJPr+9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/3/2022 11:51 PM, Pali Rohár wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Monday 03 October 2022 13:09:49 Bjorn Helgaas wrote:
>> On Sat, Oct 01, 2022 at 05:50:07PM -0600, Jonathan Derrick wrote:
>>> On 10/1/2022 10:20 AM, Pali Rohár wrote:
>>> ...
>>
>>>> Would not it better to rather synthesise PCIe Slot Capabilities support
>>>> in your PCIe Root Port device (e.g. via pci-bridge-emul.c) and then let
>>>> existing PCI hotplug code to take care for hotplugging? Because it
>>>> already implements all required stuff for re-scanning, registering and
>>>> unregistering PCIe devices for Root Ports with Slot Capabilities. And I
>>>> think that there is no need to have just another (GPIO based)
>>>> implementation of PCI hotplug.
>>>
>>> I did that a few years ago (rejected), but can attest to the robustness of
>>> the pcie hotplug code on non-hotplug slots.
>>> https://lwn.net/Articles/811988/
>>
>> I think the thread is here:
>> https://lore.kernel.org/linux-pci/1581120007-5280-1-git-send-email-jonathan.derrick@intel.com/
>> and I'm sorry that my response came across as "rejected".  I intended
>> it as "this is good ideas and good work and we should keep going".
>>
>> Bjorn
> 
> Nice! So we have consensus that this is a good idea. Anyway, if you need
> help with designing something here, please let me know as I have good
> understanding of all (just two) consumers of pci-bridge-emul.c driver.
> 

Thanks all for your comments.

I would like to hear from Bjorn / Lorenzo if the design of the current 
patch series is fine at a high level or I should explore emulating the 
root port's configuration space to fake slot config/control registers 
(which in turn depend on the hotplug GPIO interrupt & state to update 
Presence Detect related bits in Slot status register) and use the PCIe 
native Hot-plug framework itself to carry out with enabling the Hot-plug 
functionality?

Thanks,
Vidya Sagar


