Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317645B8791
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 13:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiINLxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiINLxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 07:53:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA97AC26;
        Wed, 14 Sep 2022 04:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtjNQ4RCt7+Lvl/w/ePEgyXmTTAZjOFz+EAol+MY5+up/FZtjeoEnF6ffgHGeWhsbBMMPEpkEtzCrTBsWXTgbCjFU2BYCmQiBcSaU1dzd+dgLq6ZS+egQncEOq79TF/xBgfkKiRmyTHnQHMFmmb29O2kuH80bL9RSrYCbSTkuhaOuY91aviDfE43Pj3tb1P5D8WRaOTnSpnc8dtKpZauexnCtuhBhZygcTuKrJsRf9Fr2Hnfmc8u1TEQSMe7J43DrXquImabA4+zp438lR3jdUyPxNUGD3P2xSiztafFvbP+Gs9yQfg0YOMs/AMPaW7E6Y1L0t8Q4lZ2CFOj9phRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU7v+5Bzz5lvCsyV1K0YnkmulZGh+N8zwRGsqLRJO1c=;
 b=Nr0zMEn1UaCdgzu6etO9XN8gb4NjqSd7OR6MYZoQkFk240stqcQwpFFwMPEw1E70JPmW6wUpiqVvnPF0Px2g+A5wVvOxjT2Wws40ZBAWojVYII7+RzHzRzkE3AUNJiYg1Kitp7D72iJo8m4cp1wPyT4wxnYP+GtZo5PTrQJvL8o4V28+/PTgDSHnhBOzV46dmgp0xemcNUbv000U0X59SXFrnc8xhh/5maQErIEvVaKmNR/fYM69EzhQgWV9Kqadfri9+JfCdZky7zqlVNdL+iTMaEJz0siQPTmxEyzN1giEffNgJzJv5cYRHdWOLTpj4LDvA1NB2pWzmyrrerFH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU7v+5Bzz5lvCsyV1K0YnkmulZGh+N8zwRGsqLRJO1c=;
 b=S+OofwfITT5vyMz54qOXe515WWHgD/RpsPhdasScFu+PtTuOo3TMZu4uBIpMZsNhI8QJzkpL1Z1/oicixYPOweF/fZ3qgV5FE3lxqMBvbT3/DBNZUW//r0lNYDjQwU8dSYSoSFuISI+l+SUu/qsHihPKZFj77ij6Xe20mA7dlhlHU2Y7jaDdRW4B4qbd22DThRfGrso1BA+PgR3L8OchJLzBjGiCjrGD28Hv0bnVjQJPV20m4Ozyj9Z07KBu5ENFukObFPYTuzqGmUsUnhEtxX4SuPG127H/vc6n8omVK3d4J4CE/vgpEuSJW2Xfyl/AHvgowQkBmOXFPF4YRIqtaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM4PR12MB5053.namprd12.prod.outlook.com (2603:10b6:5:388::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Wed, 14 Sep 2022 11:53:03 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::7090:22ef:abb3:ae9f%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 11:53:03 +0000
Message-ID: <6c952bcc-7e66-7385-ad80-e9b084aea440@nvidia.com>
Date:   Wed, 14 Sep 2022 12:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <b1c243b0-2e6e-3254-eff0-a5276020a320@nvidia.com>
 <20220913200746.GA619956@bhelgaas> <20220914062411.GD16459@workstation>
 <29b39edd-10ab-b679-f270-67b0b406ca2f@nvidia.com>
 <20220914111857.GF16459@workstation>
 <5ffe3dfa-28a5-a5fc-0ae2-28927c39dc03@nvidia.com>
 <20220914114306.GG16459@workstation>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220914114306.GG16459@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM4PR12MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b2c25c-7a9a-4fb3-0c1f-08da9647adf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djAYfLBqonwdBgi8/HNNry98txDUeAhQVoWfbxBM0yCYyBXWN7Jzlf8ALINNPlaEPde2ShfdDjylaio4TXAUT8sY4hmfOJbX1G0hMtfmw8W9WRgC9PDNtWcfxcTgNyRkN4XuXOrh6tbmKbIiqhtkLNIY4LBm5G1rJO1Rdg1qCmFgoKn9t4nJ7tnFpQ2mrt8ZtFD9h8kx31yFOTRAttlxJ+QNfQyLIU0XDk/FbN4k9nu1f/wRGDew6ZN2X8HbrNOVrOv7n1RvAaHTpjfxEOfFn9cUlsCCCeu5V6DY9X6Bbwoe33fG2z6PdehPhGwRXpCaNpvvd5c67aLgGAlu8NdR+afxHR84uWtZEn8HRbtResWGUVre9HxIIZpHVY95rxwiV+DZbzeMXQxYrQbmbjkRZOKvSLE/yid8QLgjpXXIyqKDhu0Dr0uvIlSX6jX02Xn8HH2AINummj1d2Qjk1yKhdfxhgypSiiXWDtPg+DRfwvya3HcqxdiSJkYw21zX8bUXTMVpdKMTPp3slw1xJ2S6LouS6YMJT3Z6i0mt2IAhb/obNJYXU2xRBRFwTGdvuGPVgVrQOXJL1rbEp+vZClG6LMfrKTdtZqIXauQI82SFBjbLFqlko78j6quBB1WGKGE7VKnzqszWZUV3HpP5axSjHn+Z5Oat+l4CLpwsNKbnH5fFwkHoa7rWPPIOyKmH9/v/Te5xzSHo+K0MS3jzCN+TGDalcI9IuzZjf/Zxuh5ZFm5eDatkbTTTpl4lI33MC7tMQxd7FDp5KFE2xOu1YSSEn5PrtwyLJar07kw8U/8I2no=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(53546011)(7416002)(31686004)(478600001)(36756003)(6512007)(66556008)(186003)(31696002)(2906002)(66476007)(41300700001)(8936002)(2616005)(54906003)(6666004)(86362001)(83380400001)(6506007)(66946007)(4326008)(6486002)(8676002)(6916009)(5660300002)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZExXYmEwZUl6KzlxaVdFV3RrTVR6K1dkcHd6bjdHQ3JlQW9ORVhIdFRqaWtV?=
 =?utf-8?B?S1BKSUZkTmFJbzZyeW5rYVFmZmQrcDFhSEVEd0h6Y1dYbVpQQzBENmhkV0JC?=
 =?utf-8?B?NjBISVRIS0x6bG5CSEphV0trU1MxbHphRWhRdFRhZERoSkpPSmJHVHh1Nzk5?=
 =?utf-8?B?Y0VhbHkxeWhMMExSSjVsTm9QN09pbncyYi9XbmZidGF2czVHMXhKTDdrdzlG?=
 =?utf-8?B?MWE5Z1YwT05SOUdpaVoyeGFkNkYxc2NFNVdBZElwN2RaRDR1N29JQURXdFd3?=
 =?utf-8?B?QlN2Zy84SWY3U0dnK1UwUlErcnFOWXZCU3UvUFlIcFdVdFptYmswR3N1TVgr?=
 =?utf-8?B?TWttd1hYNXhwYld3QzZncUJSdlJLT0ZtenY4NU94WHl6ZzFlZm5obnZmMFdG?=
 =?utf-8?B?bW5HTm1SYmRJZkVIS3RSTTUzckVYalY5U1dVVHFvb0NSL2dYR1B2Rmxnczhk?=
 =?utf-8?B?ZC8va0lrc2h4cktRR28vVk4xMEsrQ3lQNW9jbTB3cGwvcHVxdjBNc3Fsaitv?=
 =?utf-8?B?cm4yUm1IOWVIU1BGNVJTVnJGalU3OXBDbUhSN21QazVuUnVKbm00YmdBajFa?=
 =?utf-8?B?dHovekIxc2hxK3gyU0UweVp4QksrRkZkckpvY0UrNDlYZ21MSlZFMHRQL282?=
 =?utf-8?B?ZXpCWGVSdGFaYU1PakpKeGpUZ01pYkV6eG43MnRCbTRGTE5VYksvcGY1aytO?=
 =?utf-8?B?OXhsQzFRNVdseUllMDFDZTRyYnJpYnRFOHVZRG04U2NTcDRlVjUrSmpJL0hW?=
 =?utf-8?B?a1B2dHlDbUFMZDl6SUNvZmd4WEZ3UEY5akdzRk9lQUxUQ2lvRXJtRENSNEM1?=
 =?utf-8?B?RFVoQkI3SUVqWDdoaldlN0M5cXhVWVArYzdVQkE2TmpCMytoN2RseU5pc3A5?=
 =?utf-8?B?VFFEZk5sUko2YTN6UUZPdDlJa0dLVzVmQ3ZjcXJjdFdNYUdYS20xTmNXcnFJ?=
 =?utf-8?B?dzdROU5RRDJuQ1pFU3IyMThmZ2NQMjZXTWl5Mm5NdHZkNnNKL296alluMzdl?=
 =?utf-8?B?Uzh1b214RTJ1c0pYR2tYUGJPOUdFMEZmN2hEeExaQi9aWldxRXNHajdjRG9C?=
 =?utf-8?B?eWJMR29DNFFSdG10QXpOUFhvNEtzOVdPNCs0blBBU2hzR2pyZ0ZMcWhNdFMw?=
 =?utf-8?B?NzhZbUhOSkZNMHpMWWpmVFFQQzh6NEVtaCsrUXRiMW1yTmJNNk5waHBoRDdW?=
 =?utf-8?B?cUEyL01EL0Nnc05UNGZFaU1CRWdKVlAzUHZtMmtzL0I3clQzeWVqV0JLdHpZ?=
 =?utf-8?B?RnhLUFZGWU9kdWNRSnZaVXJyWnVjUTVtNUxQbXVLMGpZNkhXdU43ZnA2M0Ur?=
 =?utf-8?B?TmgvTHA3UlhSZTh6eHExeGlSM3JoMjZaYWJqb0JBL3cvYTBTM0NmUVd3WXV6?=
 =?utf-8?B?TkNMUEluNXBjWVY5QS9iM0ltcVUzMzFySUlCaXoxUXJGb2E0WnRQUHpIZ1Rk?=
 =?utf-8?B?eU5icDkrR3lDVWV5UDlEbjJzUkh5M21QVHBxdis2Rjh4bytieThZSEJSNGNa?=
 =?utf-8?B?dGhGQ1FrcUxlOExQVGRpRUhuZmhiNGlHUUF6NHRVK0RoV21pNWlzdFYwQ21r?=
 =?utf-8?B?TDdPUStzS0JiKzJvcGFjRDNjbk5ndTg2L3VEenVEbktBZ0E2Z0Q0L3JMWUNR?=
 =?utf-8?B?SHpJSm9ZNHZrKzZWbVJvTFhGbWNXaWJaWHZORG9sMHZnaGdMRjhrNGhtUjVW?=
 =?utf-8?B?RnpYNXJMbFFvOTZ5SE41UldVaHRyc1pqQW9saE5qQWNmNWtVVk4vU1pqN0ZX?=
 =?utf-8?B?bCszRzgwSWpHWURhV2NVMGZpaWVQbzRmazBHNXpxakl3ZW5EZ0FuNVNTMVl4?=
 =?utf-8?B?bEQ3UXFpK2V5OXZPL3FUUGRYbjJjOXlPL2VEWUFCOGovK3o4WWkyNkdHb0pW?=
 =?utf-8?B?MjU1K0lyVVhRSHFKSDU4OFB6V3loMnNWZ2lHRWt0KytlUGZGUjVlazBoQ0Vu?=
 =?utf-8?B?Snhyem9mQUJ0TlZGTGNXZTRjaVFaK1ZzWU01aWNrN3R3S0QxVEtGZnA0YXdo?=
 =?utf-8?B?bWwzQit0NnhZRzN1MjJ3YzdOSWpoMTNuNWhwRHJsS2VRa3JrNnVMbnc4MUIr?=
 =?utf-8?B?anBzUnJzNnlBd0toWU1TOW4zYjNNbEhWMzNKL0FXa1diYmJNQ29VN2tpdU1p?=
 =?utf-8?B?Yk5NTzlYR0toVnhQOHlGaGU0SjlmcG1uTEZaK1hLaWJkdWppNTUzTHBJZlBa?=
 =?utf-8?B?NHVjT3FrcWRNaWM5TlZBL1AydEtGMno0TW1mNWNmL0piYzBvZXBhQWlFZVB5?=
 =?utf-8?B?OGdXM3dqRk04YlNFSDFhQkUweVh3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b2c25c-7a9a-4fb3-0c1f-08da9647adf8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 11:53:03.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8Urk5EONAkmP3ZTY4Y431BWxDj4QfVfKnLmAmyIAiw0UgjdpB4+d03PueSmX99aaISG62ev/wktmX/4Ba7meg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5053
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 14/09/2022 12:43, Manivannan Sadhasivam wrote:
> On Wed, Sep 14, 2022 at 12:25:51PM +0100, Jon Hunter wrote:
>>
>> On 14/09/2022 12:18, Manivannan Sadhasivam wrote:
>>> On Wed, Sep 14, 2022 at 04:32:10PM +0530, Vidya Sagar wrote:
>>>> Agree with Mani.
>>>> Not all form factors support PRSNT pin (Ex:- M.2 Key-M form factor) and even
>>>> if the slot form factor supports PRSNT, it is not mandatory to have a GPIO
>>>> routed to the PRSNT pin of the slot.
>>>
>>> Right.
>>>
>>>> Also, since these are development platforms, we wouldn't want to keep
>>>> changing a controller's status in the DT, instead want to know the device's
>>>> presence/absence (by way of link up) looking at the log.
>>>> In my honest opinion, I don't think the absence of a device in the slot
>>>> should be treated as an error.
>>>>
>>>
>>> As I mentioned earlier, timeout can happen due to an issue with PHY layer
>>> also. In those cases, "dev_err()" is relevant.
>>>
>>> And I also agree that absence of the device should not be treated as an
>>> error. But my question is, if you know that the slot is going to be
>>> empty always, why cannot you just disable it in dts?
>>
>> I really don't think that makes sense from a usability perspective. You want
>> to allow users to connect PCI cards and for them to work without having to
>> update the DTB. I have plenty of open PCI slots on my PC and I would be a
>> bit upset if someone told me I need to update the PC firmware each time I
>> wanted to use a new slot.
>>
> 
> My question was, "do you think the slot is going to be empty always".
> This can happen with slots exposed through a connector (not a PCIe one) and
> users would plug in add-on cards for accessing the slots. In those
> cases, the add-on specific devicetree can enable the PCIe instance and
> use it.
> 
> But from your reply, I can infer that the slot is exposed on a standard
> PCIe connector and users would connect a PCIe device any time.

Correct it is exposed via a standard connector. Yes for PCIe slots that 
are not connected to an on-board device or connector, in that case it 
would make sense to disable, but this is not the case here.

Jon

-- 
nvpublic
