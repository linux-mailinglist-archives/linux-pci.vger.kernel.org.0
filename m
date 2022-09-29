Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC05EECDE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 06:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiI2E5n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 00:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI2E5m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 00:57:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F9711D621;
        Wed, 28 Sep 2022 21:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAA536uJmeY6awAvJGx54omWdZMpRUeKnNu32VK7FCRevSOG9rsVZpNkHIALdkE1j3Y4shlFa00R7Pgq7HTpSSAnanSIkyon4qwC8Y3JgcRqOCbRL6/OMtFJs0hMs2iIuARCwzLkRIZvo8XL2MsJPHGTwWKSy8kyfOaE3XC1k4WgXx3r9sBB9/oqQ1WkdUY+AgSVa/06NsiLipjSAT2FbHiEdNMYtSWhUAE6mFeBgeiqzEoKbmVJzCr2dfR3G9hcWzhzyXD12FmssVfiq760w57tJxeV9ZviPt3UpBQkZP97eLd3D+IpObh7jberUAxSJ/3Z3Gl7hSu3VtmN3ybWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+yQiGHABdNeGHtYQOkkgI/1tB4u8tYY4V1fqr4v4aQ=;
 b=QPyuWzrEu+c4IXX12v4XFxGqn8r/Y4x0q4iu7qQUD/MbF5KuQGnjav7/Ab5zeiYBssBG+7iO1OlZkrHqT5v4/gdnHEzVyD/SfEeJWZi9AO2Q5kn4eLFyNVdB6x0L6hB58nzMrNtqQjmfiCdPNl75Po8PzQAlodTzOwXkdwYl20vnrs6unOUGG8G/qf7nuVrTKhcPtiNjPprOyru3jtRbjd4Eu6/22Yj2MT/NEcMgtnSFbWOJXL+gYbiZr/M4BR7gSbRM4ceZI6WeSqg9LaNrg5MUgJxnp8eA2iEQNhUzVoWVHPFymueU/XigaTO/LTi/+HCcO0aHa2Veerr7/A+8tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+yQiGHABdNeGHtYQOkkgI/1tB4u8tYY4V1fqr4v4aQ=;
 b=lDGVWjfj9iOKMeJIdgO1HX15Dh6Qe9D1B0Vmi1+SJIcZxqMMw+zAgfLD7p+HZJjRpLEjR9qS/B3y3XrQItttL3+OLEph+3gBM0vWILTlyv/SBuh7Q8nyRSwP4eGQGib24NK2mxe1/zn7YKM7st7nTCVW9kgaW4M6E9+REVEOxgaV1I66ta0y8sHI03GItVjSGj569sY/qRt5vUeo09DEC2A4Cj70kvzQPOs7fWsaOrV/Td/3dwSI4ANe02oapfWczwtMvVfZ8BJiHYc1usyQFcc+AVNT62quKNMGcqDQdl/xz2/llw88OsbqIhck3W+KgUe3liO3/rIm7Lmz732k0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 04:57:37 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::d9ae:c30e:ce3d:9cb3%7]) with mapi id 15.20.5654.026; Thu, 29 Sep 2022
 04:57:37 +0000
Message-ID: <09c23fbd-0319-5e06-6c10-dc73352131f8@nvidia.com>
Date:   Thu, 29 Sep 2022 10:27:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2] PCI: dwc: Fix n_fts[] array overrun
Content-Language: en-US
To:     Han Jingoo <jingoohan1@gmail.com>
Cc:     gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20220919143123.28250-1-vidyas@nvidia.com>
 <20220926111923.22487-1-vidyas@nvidia.com>
 <CAPOBaE5X8iUTQW5QqTKFN78U=jnVvCzCj2mb4HG5S4uxBaCN1Q@mail.gmail.com>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <CAPOBaE5X8iUTQW5QqTKFN78U=jnVvCzCj2mb4HG5S4uxBaCN1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 70595236-2f6d-4dee-570d-08daa1d720d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDWjRyAmXtY032obxurptM+ctpgcsFxFjezYJePdpIu71qNZVuXbmK9/F4824+ifB4WsYuJ5uaiGI2y7AVbhTy6iaC9QxEQVj4e5eL3S/Qa5FfQt54fIjp5KV1B+qEJQuC/3aoI5YEhnx+0soMsBctArjBjup8mjRZf+hBMyjkbLk59p+dS+X8hU+6PaVOykz7clBWT3ND5z2DYgEGM8P6IFhXw3GHj+7DUalck6/Wf5y74K2u9W7aPS9HDRJ1tcWDomTc0fagemp8ncMGoun9Yf3jQcVlI4cyNftNEhRPV2ieAWteHphZa+eXNIb9LPhUpGCTxF6322Sx41HKngaTjOU/dH1zO1yVQ6UUf2JAyFzgta8SfL3ran77CvL20wxYzgug1tPZzj1O8Utfc5K/RNY4tm8eylTwrA4OXwaSJJwrzKt6TI2l450y/n+yKUxjoZPq2UXMJF3cknlpjWjN/G5ycofVYIF1LWYoHQgQlH7Fglpx93BEitODtsMJlaehLkc9zskBEP2OhIPqWuHMAmNHjKUflaRdd4CEOIie/LVDMjWEBeOLI7DleBKHhkOp2RCXLS7K2dkbUtwwR5yi6tx42QiGcLJklom9Bt+OAF8tzv2kr0lxGqas8R/PPBGLMbIPzPxKSlfS+q/ciM+LYav0aNp+TILJI7xf38391RGNRQU7ItMwvl3C53Cxh4Vj0hpIKBt/zwEMqDOlUFVQksQl/+HmXlnjh6940kqk+wZyb+IADGxl4fA8hlA+ReZjZU3BeqM8NIU+iFe4DB2XKHc8DKsZMydldDz/iuWFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(31686004)(66476007)(26005)(6512007)(2616005)(186003)(66899015)(6666004)(478600001)(36756003)(316002)(6506007)(38100700002)(6486002)(83380400001)(53546011)(2906002)(8936002)(6916009)(5660300002)(86362001)(4326008)(66556008)(66946007)(41300700001)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2lsTEpDanlkaFpMb2FnRmhUVXRBUlRyZzJNcENzdUV1V1N6ajl2RHRrTWl2?=
 =?utf-8?B?dnB0d0VUcUN2MDIyaEozWXZsRFlmaEpZaHZQbTRqK001d1QwUCt0YmQybjV6?=
 =?utf-8?B?dUFLOHZiVFEwbmdHSkphaGhYZi9IdzJkSTZZMDJkRUp3TEJUSXRHMExWZUc5?=
 =?utf-8?B?WWJVNlBoWW5IS0ZPL2pBdE9tNUR4U0Q2NEtySHFOd0tMRlVKSXhFRXJzTGZE?=
 =?utf-8?B?UGJuYk9IS3hvc3NRREdwdXFOb0dJdjV2RmcrdGNOTlNMQ2hnYVM4NTNKNDI1?=
 =?utf-8?B?NFZ5M01BZkNqdkF6dnFnYm96REI4TlAvV2FoUU5rVDNjaFowRTZWVmppNzA3?=
 =?utf-8?B?eUEwUk1uZTg3eTJINkI0K3djbVdvMW12MEl6WnU3NFRUdXRiZnhYWk9EMm5L?=
 =?utf-8?B?bDg0R1gyblkxcDdveWp2cHYrbWxBVzFHT3p0ZE01VVRaVlIxb3hjSTFiOXNP?=
 =?utf-8?B?TWk1TjRCbTdZc2RpT3N4NlgvMmlMRmVaU0p5ODRibFB0VTNwOFhzemhraEZT?=
 =?utf-8?B?cm84Z3JiRkJ3TTREdU5OSTBKY2pSeTk3eHZpRHJnQndLdE5XMGMrM1FaOWc2?=
 =?utf-8?B?UDZnOGFWb05sdUlzeXRrSzNNNkFXaUY2Vm00ZjJhYXd2Y0Jldkc5d3Y4cThH?=
 =?utf-8?B?M1ZMWUdvOUswbGh4K3dnQUtZN09OS2pyY2FxT2NjNkZqQzdycjh5RkpoTVZp?=
 =?utf-8?B?K1I2Zm8yZ0NpWFQ3eFoyenVXQXl0NlFzSExCWWh5K2FOYnZZdFNkT2ZKWGdE?=
 =?utf-8?B?M3hJSjRoV0Vhemx4NW1GV1BKcDYweGp6ZjllekZtRFJpNVdvcmhUS2NrNHlr?=
 =?utf-8?B?M3luYXozRGFIRFNDUUdnQ1JzRlhpTWlETUNXTFFRVUt1dlhtMjdyNjBFL01u?=
 =?utf-8?B?R211MWhlVHBnTk10SXlER2c5R1NNWG8wOG1kR2gyZlhBMFNacmFEOGU2R3Fq?=
 =?utf-8?B?U0oxTU9HY1hQU1U0RE9IYlZCbDBsZlBTNzlPdG9oaXdjTUMxSFBxTTVSMWhz?=
 =?utf-8?B?SGtVSGs4TVFOSS9HdXpmTHRwNnlTaFBwSGEyYmw4eUloMytZazhzOE1GTWph?=
 =?utf-8?B?bUVSSjdqNnZjU2s0K0VoaHQzNXM2bm80aHhCWkpMTVg5NXc5Zmo3MkpiVXFY?=
 =?utf-8?B?SFJKZTRXN3NHZlZMSzhLVDBMN1VhVkQ5bHc1UkJpRGhPQXdNNjIrekVORkhh?=
 =?utf-8?B?SjJYTnl1TllVZDlhV29HUldxWG9ySC9CYXlMUmE1OVBncVBmRkZoOEhxNE5k?=
 =?utf-8?B?RVFxczdGR0t5Q0EvSldxMzJJYjV6YzAxTFFNc3Frc1l6UERHRWxSQWJuRklS?=
 =?utf-8?B?TzRvZVVwYTkvMUZ1UXl5djc3ZzVpZFVLcHZqMC9MbEJNZUx2eW9IUUJBTlFE?=
 =?utf-8?B?YXRoWUV5UFpXWUNHUnhlaU5nc21BMVB2eDRoVWxlQmNGNWhBYjlDZXdiSGxC?=
 =?utf-8?B?d0RqR3p0a3J3K28rdGY3eGo5czRlbGFvNGNweTF4K0dMNlAzakdTQWlTTHI2?=
 =?utf-8?B?UHllY2tDSUN1alE5aFdndTR2SDhnYjVzeTJhdHpEUnpjcU90dldQSllHUnBu?=
 =?utf-8?B?Z0VRSXQ5WG1TdllsYjBZQWxwRmFSaXNZUHpvZnN1a3o1WVZpTkJkZytneSsz?=
 =?utf-8?B?RG5PeGFnWTdCa0RsRGpRUDlybzljVUhEQ2FhS0VxM0VRcDBicmlnZnp5c0Zq?=
 =?utf-8?B?VHlVT1lweGJPcm1qL0IwSDF6YVp0UjNtN1ZvdmJnZW03S0JxRlY0RG16amFR?=
 =?utf-8?B?VXZEakJKTi9pbmFwS1VEa0tsQ0RCVUJKcWJ4Tmd2LzB5SmtqUy83M1NiOHNi?=
 =?utf-8?B?cEhBR3RQY3VnNGdFK0Zxck4yRmJrbmo3cHdJc1Z6akM0ZHU4MGhBN2xFN3la?=
 =?utf-8?B?enhJTTZqTUUySDR5ek1LRERRYUZCZ2lDYzU4b2NoMjlsa1Z4dDRab3lyRVJM?=
 =?utf-8?B?ZE5nT3ZHaXBCSHVCQVZFZFhhM2h5VEh1cmhMZzA4Vzl1Tk41T0NOdld6UWhB?=
 =?utf-8?B?MGFOaXNRcDZBNWt2SytwOUc2a3IzVjNzSGxCQzFSbUF1VkJveHUyKzVIRE9F?=
 =?utf-8?B?bUoxUERobHR2d0lTMGJ5RjRTdWVZR1Fia25zbjk1NnB5a3ZBYWtMNmRkMjVv?=
 =?utf-8?Q?UU25m0kkN0HcnhNVXFAPtQYDT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70595236-2f6d-4dee-570d-08daa1d720d7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 04:57:37.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkgesBW3WqIGHy2lU8QVCTCNDfStDeqrnyRxfdJSaGtAsnBI9SbG+Co+6dNm3JSDVhnzQa2Cy7TI/wlgxI9sOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/29/2022 7:34 AM, Han Jingoo wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Sep 26, 2022, Vidya Sagar <vidyas@nvidia.com> wrote:
>>
>> commit aeaa0bfe89654 ("PCI: dwc: Move N_FTS setup to common setup")
>> incorrectly uses pci->link_gen in deriving the index to the
>> n_fts[] array also introducing the issue of accessing beyond the
>> boundaries of array for greater than Gen-2 speeds. This change fixes
>> that issue.
> 
> Dear Vidya,
> 
> I am just ok with this patch. By the way, do we need another patch to generalize
> this setting? Currently, this code targets only Gen1 and Gen2. But, in
> my opinion,
> it is possible that this driver can be  used for more than Gen2,
> later. PCIe Gen6
> standard is available and Synopsys has their solution for Gen6. So, would you
> send a new patch to generalize this thing, later?
> Thank you.

As I mentioned in the commit message, current code is incorrectly using 
'gen' in the index and ideally n_fts programming has nothing to do with 
the speed and hence I tried to remove the 'gen' reference in the current 
patch. So, the same code (after applying this patch) should work for any 
future Synopsys IP versions supporting higher speeds.

Thanks,
Vidya Sagar

> 
> Best regards,
> Jingoo Han
> 
>>
>> Fixes: aeaa0bfe8965 ("PCI: dwc: Move N_FTS setup to common setup")
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Jingoo Han <jingoohan1@gmail.com>
>> ---
>> V2:
>> * Addressed review comments from Bjorn
>> * Added "Acked-by: Jingoo Han <jingoohan1@gmail.com>"
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 650a7f22f9d0..3df687667f27 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -649,7 +649,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
>>          if (pci->n_fts[1]) {
>>                  val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>                  val &= ~PORT_LOGIC_N_FTS_MASK;
>> -               val |= pci->n_fts[pci->link_gen - 1];
>> +               val |= pci->n_fts[1];
>>                  dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>>          }
>>
>> --
>> 2.17.1
>>
