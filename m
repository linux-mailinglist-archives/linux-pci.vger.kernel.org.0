Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033A46FD066
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjEIVAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 17:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234829AbjEIVAU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 17:00:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF9D5BAB;
        Tue,  9 May 2023 13:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSlCQ/ZXtiEhOjcchMTdWmzF71uKtkmGCUNGWUdmuSPcbkkeUp5ukIILwH/Ul26B9ZT6U1iQoQgc9nzELk8Dc+r1h/0Zef2UZ8JxKx+DHNm7UgXNTshFHsK+MI2PEQvy+Hy92ErqB5TGNm8izdzgXa1jJD6V/lAYQ1hQnQtKRjKo8fPBztX7bEm5mCsKlgJb7qa1GzDp0RHo8Ut+ZwW/MNA3pqMhd/jIwLsjRdA0J7vxNKMgSd850v4z4wD7D2rAHkovqRQ2YCiMmE4wDC99/QzIPI9Gu9WqS5ecLte/Tg16nZJpM3He6xZ2n+d7k35cy08MHUP/0iGC3LwcKo3ykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nK390aaEr6e7uGQ/SEnhfGhuPjAFrIbzrfq/G7+MBc=;
 b=hGhJwCuudx7TzGTnMyh4JOcWc0K73iGeP+/BySF5ZWsSmr8WyCmwFBDunA+3YlYg8gNTnrrBwY+nXM8f+bXYf/T7PJp+EoGF53cVUMrAzIL+HY/eKnLjIodoa6o2/BJ3J9/nsPFS9LezizZOQGed/iG6lqwjn/Ahf+295OOsie0EN+zS5QEWtUn4K578qWL16R+vw/oXpPPFA3VBJs9gZ3bOgQd6z/nm2XexFlYc02nPXi1zQ9fmg36gGcxX3Qsimh5fvcN8rmMZVq8XVTr1VgqlmXdP4+Z3kDovF7kmtKuBPCNIq7pylmQwiQW8TAQo38R90sLjhJJ9glLqcIR/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nK390aaEr6e7uGQ/SEnhfGhuPjAFrIbzrfq/G7+MBc=;
 b=X1Gi+QhDO6LkSVPQrsH/0juTaCDTj93iTXU170loDl8y0H4x2xTVYCiGtchVyS1EgnDOVYRWaiK7HRptbMFs1ARamRm+J4B1Nl9Xml8iuheEU3Pn9uBy3kLm7ggH7sKlHIHDamdHY94h2Yrq7R1YoOg/mcFvnTdHqBoUXYoieeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 20:58:48 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::8b48:9557:ef60:f7b4]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::8b48:9557:ef60:f7b4%3]) with mapi id 15.20.6387.018; Tue, 9 May 2023
 20:58:47 +0000
Message-ID: <5cf1d75d-feb0-c31f-a0cc-3c1c8ad99146@amd.com>
Date:   Tue, 9 May 2023 13:58:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/2] PCI: pciehp: Add support for native AER and DPC
 handling on async remove
Content-Language: en-US
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0138.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::23) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc823da-7cc3-425f-1fdc-08db50d02eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xkAKm09ven0LOEceokc2NlTx1X8IkkNMuST20aDnrZMHwFRMZEM4yiisXpI0N7ivoVA9chzzJB+7q5Ih3kG3ToDL6auD9vDoIP2U48XdIM6RgI+ohFTTnawE9Kxr3sajKNreGASE8HTFqkkr6TOlztl4FO3Z3E4qVi6tlAHargKh2LbF9mzQAXdKdkWJqPKC9wkMT9NVxbV0lDjB1eSAVQA3shfWPCFcyazJyJGzmHfv7DXJ5H/NqSfZXzBC1G9jKbRMk+Hxmn6jmWzHLQ8cH6G+8DGd0x7lbz2rZuWCIZfPVsPhxhN1e4XqIaF04n+ZUaBTI7yyWQAEHCACA/hLuKJJbi/sBxYpMXt3r5trpL7UBei8y+Yo7DZYdqmrcTDOEN/S2Rrzy2BpnQ15T37gYYy5XCL8UO8kpbmOOBm9TYkqjvzdtv3GH3AJdn9mVdhtRNjuZtyQ7e+L++RiBPnMkG1tPdXi3Zm69NfAkoRRM1cNYYsKD0ID530uzAvtJLrJrtJKfXoIeeFNpH2+gh+m+7D3e+7WxPZS5y2YkFyALvorhSzkyadJ9W+2I1vywfXvNDCjIL1VRmaC43kpTm2GcuC1ir9+K0D5ehq6W1sV8DED10mQ6SzVrF3R3hR5bBbnwOInExA/O22tPvpNbdi5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(451199021)(31686004)(38100700002)(36756003)(31696002)(86362001)(6512007)(966005)(8936002)(6486002)(5660300002)(478600001)(8676002)(26005)(186003)(2616005)(53546011)(2906002)(4744005)(316002)(41300700001)(66556008)(66476007)(54906003)(66946007)(6666004)(4326008)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDYvcGZPcG5CU0UxWGM0cDBYVHVKR2NsWldjSXB5dnMxSmxJQ1dHUUViSkR0?=
 =?utf-8?B?ekoxTXJwQjF5TElzK2U5Y2pOLzVBTnVPd1hTMm1lNVhYM2k4b1U5RkJzWHRB?=
 =?utf-8?B?M1hkalNNUG9IYlNzU1JCNUhjM0phdDlEc0hDM0FiN2JSUDR2MkRhYUpEZHpv?=
 =?utf-8?B?Q014c2R6bUNPV2JWZHZmQWZnQS82c2hyZ1k3dXBzMkVVY0I4UUlDM3luSmZM?=
 =?utf-8?B?bndkNzBYUEs2Q1c3WTVMQ0t0RG12aG1lR2FJVVFCUEwvdUxlZHlzMW5aNm91?=
 =?utf-8?B?b0s2ZHBySU5rTUNTQUVLcWF5bkJGN2p0QWk5NEk5UDRUeGxmVUFNbVZraU5W?=
 =?utf-8?B?N3hxQVFlOWYvaTdwcUtyTjVCQ2ZRSXlkN2NoTVhvNkZrSmpRVVY0WXJHM2t1?=
 =?utf-8?B?RXhLSTdkYXEwVUNHcm9LQ2g1Sk9LWEo0OUx0M1dSc2NyWkhWemFjd002bEwr?=
 =?utf-8?B?TmVJTVNtSkVqQUVZM1h3SmRnSjh4WDh5ekNoK043cFhITWVManB5bEJiKzh2?=
 =?utf-8?B?bzNPQWhFUUhjOVgxcWdiaU5SYWRqci9FN2dQYk96L2oyREd1dytZL09jc3lp?=
 =?utf-8?B?TjBRN1pDc0dMdmN6T3dwRjB6KzBXcUptZ1gxWVRlSXlYeTMrVFY2YTNuMEsx?=
 =?utf-8?B?OUllYVNTUDQyTG0zZzFGK3QwNDJYSEpKNVJvQ1ZQV1JZSE1KV1hsdEpubGVh?=
 =?utf-8?B?b2pYNmpxam5LREFiN0psbTlnTktzQWpJRlBqME1qSDJrT0RxeTkydVJKUXRk?=
 =?utf-8?B?a1JMRWI2Z3I4c1UxUVgzSWI2cWYyKzJBYzFEY2V1UGRSWmZjZjhrTmZveGxU?=
 =?utf-8?B?SDk5Y2k5YWI2Y0QwUVpHMlhFcDZtM2NNR0tlSXJmUHg4blpwQmJHbS9FUGxl?=
 =?utf-8?B?ejFnV2hHNzhlVG05a2k4d0dQYitWKzg3U1VrNlZBUldma2RXR3NDK3NYbXBN?=
 =?utf-8?B?RGpmbC8ySDVJendwMVg2ZVNrcHJZVFlzam5HZW5naDRnaTF4R3VQL2tUUEQz?=
 =?utf-8?B?emVIRTNrMm1DN3BjT213aFNnVUgxT3U0YmlwemFSSXB0cHhLOURndmdpaUlB?=
 =?utf-8?B?dXEwbCtSK3V6MHJPc0hUbHk0NjBIYmxQdEppbE15bjkyaWlBUnRBemFqRUdP?=
 =?utf-8?B?bVJYVHZrbWF0WTFiaTJUR3VLbFlvVTBQdzJVTlVONUZnMGlwc21ZMjR3N2pa?=
 =?utf-8?B?WEM1TDRBSkN4M2l5WDR5VUY0VXRTL2J0T1VLbFJVOUp1dWxVQ3QwbVArNWZz?=
 =?utf-8?B?TlZUbUhHanZlOVJQT1NqQzJYOVk5dkxidkpFc3JVUG1uQWxrNWsxVzE0QUwr?=
 =?utf-8?B?VnlDQTNoeHNRNDRtZ3RscDRJdXFjd3k4b21SSzYyaGNLSndvWWFIWG02eXFs?=
 =?utf-8?B?eWpLV0k5TDJYWGdkWXhFbVl2T3J0MzVTTUYySzJxbit3WmlBa2pZVVRrbGFY?=
 =?utf-8?B?UVpDMVY2YXhvdEgrbUpveko3a041Y0RWZVZSOTBRektwcnB1QVcyVDVNb3ND?=
 =?utf-8?B?VG4vQUdvazRiUHMrM0M2QVFoWEpKTjYwWDBZejNSL1JldGF0TElRQU11YW80?=
 =?utf-8?B?eXhVR3dNMXJlQnJSQjdrZTFYU0xBQWtLYmdtMEdDb1B0QktZZzJ2YktxNWJ1?=
 =?utf-8?B?YlFCRTVBbEJSQjVvNUMxSUg1WXVlZ3N6TzAvQXRPcnFoN2lCazJjNGtBZUV0?=
 =?utf-8?B?UWQwaXNjaGROd25EdDloVGVENDYrbUxvOHRmVVJRMjhzZXNsWi9RWWltL2s1?=
 =?utf-8?B?eDlqK1hCS2dQLzRXaHJBTW1Ua0hGQzB1ODFqeGVPOXdpY2NOalNXdHQ3ZWlI?=
 =?utf-8?B?LzhLRk5BUENBMkU5ZFpQelpFZUR2WTIxcHFaSC9VWW5UMUlsV3VtdFIreFNP?=
 =?utf-8?B?dElKakJQbGVLa1IzcWdaSC80aWRYZ25kOWI5YlBnU3ExdjRoVGp4MzU3djly?=
 =?utf-8?B?R2M1SVRGVkMwN05rNDJPUEpuZmhpa2lzZXZJajNIMld1TWJQTVNhR281R1VO?=
 =?utf-8?B?NWc4MERiQU9kald5NnFGN0Q1ekk1SHVrWXFKVTN2cmt5VFAxR0syMzBsdW1r?=
 =?utf-8?B?MnBSNSttYnBBWXZxN2NVbHVZajRzbHY4bFZaNXhlVDRZblpoREdJb3BDeDAx?=
 =?utf-8?Q?Q/ZCMCHge2gQr7kVkNeQvC7lk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc823da-7cc3-425f-1fdc-08db50d02eed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 20:58:47.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP86kTJf37zNF19Ss5CWcwaEooj29Sbl2LAs3+eeem0SS7O0QikPwgplIeei6bfTq8CqASP00WA1p4WVaAJeLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Could I please get review comments on my patch set? I had re-based it on 
latest tree
in v2 as I did not hear back on my questions in v1.

Thanks,
Smita

On 4/18/2023 2:05 PM, Smita Koralahalli wrote:
> This series of patches adds native support to handle AER and DPC/EDR events
> occurred as a side-effect on an async remove.
>
> Link to v1:
> https://lore.kernel.org/all/20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com/
>
> Smita Koralahalli (2):
>    PCI: pciehp: Add support for async hotplug with native AER and DPC/EDR
>    PCI: pciehp: Clear the optional capabilities in DEVCTL2 on a hot-plug
>
>   drivers/pci/hotplug/pciehp_pci.c |  1 +
>   drivers/pci/pcie/dpc.c           | 50 ++++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)
>

