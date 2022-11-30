Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658A763DA53
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 17:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiK3QOK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 11:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiK3QOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 11:14:04 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E554EC3D;
        Wed, 30 Nov 2022 08:14:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i52rnyJ5KvlZU5jCwg8olLrtIzaOPMR8kM5ipf2I1DfSNv5aAx0JlzQibRfwPRjhBb7CnqvhZGDMleqkA4Wi41nRLtBB2+Q9v3c7+20MWFsXEK7bv6C4Q7TbUcyTNySsVYfWJgPujDH6qQEbvmit76xKt3XIcTxG1EA3y7tokdlf41JS+PN4MDkep7nHOlK8HcY1PLEYwn/0IBRlwtmEZFM2qDzW+Ns4qUswoL4rluAMtqsQBtj0oPzxBwLX1q0+IDrtlSrGzBZh08qFTGWYu3GdSFCyfip5tE1byZcTy4MmqfbM0FpHhM8lOUeJKD6ezfdRJWm/y5bAb6biCgh9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1nbsY+2PJmOEehdocZTzfKeP0I2UqWWLGbUumuO1hc=;
 b=OW28ohHckFKuU/Sl6M5uOxSH74iBsWyQiot0XQBFSlaUW+xfcDiVI/t8QZ5NyioHjwQCzIOpCWWzs82ZY91U2bRNDeuPVYNoXvq8EJH2SXtGjLDCUnVki/uUdExXC0tw1OjwnjKRnK8Mo9PygGsovztNL2YLzmt4NG+dnsG7qtajJXmvaI3hXaTCdp9OxYh7lRmV5wwnUmMrrSKuynyec5Bh0MMJIqogZSEj51VqkA8hqSCykWq2iHeu3p/Y0nX8+rt/beJFviqllUT7704BBSToA1k6SroWaWW2mJ8PBx24KaZ4DCfcLWsknPonwdDgGZEc8Sb+tPKv7po6Vq+6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1nbsY+2PJmOEehdocZTzfKeP0I2UqWWLGbUumuO1hc=;
 b=tt+Ud9xGjih0tJKhAjkGntdR1+L+1YpyLWFsjINgT4cpNXw1Tp718MBAqCEeG4JM3ZUhkTNvt17tIRWuLb8fw/E5bmZwcPbAvIHpFGG1deYTSfJUj025W7xVPE2p7iFaz7/DFPHsY4AppNYIlZJFmL81X8Lut+Lw3oc/GWTqrakjJ+C64gjzpv4878EYcVpYKEP+/TQwGhziNhGjmNRbYiXWxqZpfr78AtrPcXwCZ9wfjLBbQKrGznEYhD3VYQiN2UC0PqZHrUA6qBuKjVfcVU8rsOL6iMW++X21sIu2iNlM3mn3FTwVHi3Z8mAPTatFruBT/lAqLExifNMvyM4h6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 16:14:00 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::c267:3c38:d5bb:db3b]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::c267:3c38:d5bb:db3b%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 16:14:00 +0000
Message-ID: <c755ee45-fb6d-1f7c-2a3b-bcaa9d292c1b@nvidia.com>
Date:   Wed, 30 Nov 2022 21:43:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] dt-bindings: PHY: P2U: Add PCIe lane margining
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        vkoul@kernel.org, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, vidyas@nvidia.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        lpieralisi@kernel.org, nkristam@nvidia.com
References: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
 <20221124083510.3008139-2-mmaddireddy@nvidia.com>
 <0b203c11-851c-fd6c-faeb-e283b158f1c8@linaro.org>
 <b81c69e0-13a2-6a25-21c7-c0d8804f9c3b@nvidia.com>
 <7ce2fd0f-621d-dfbb-2ec0-53ccbb3308ae@linaro.org>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <7ce2fd0f-621d-dfbb-2ec0-53ccbb3308ae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fd7861-c305-4382-652e-08dad2ede3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoO6BiZSAb6npKelfFKMvIpgUn3oq91G4jSxFf1jhv/PrAxSFURuWXl93P4X1jj2hfr+u9kNqJLPqae2rHFLNiVWUI/kiwxykUQ8aJE6Omx6bKd6tdWpx10zCetNJRJ4y198sGMDtVj5dsHIAVvVfs3/J88InuXvBywpdQsESW/uIUSyfcEnzGToo/H/thHRZd/PyC7wL7Gowg/s9soXVmKtH+0mBM8s7/nLKyn7kR5NqaSdq4wN44zuAnFhh8wHmWG23uClzKBFkGwPw8g1YZIfl3je9bvKGQFWhqsa3s0VLzuGFbOCxWa+ZuJe6fLi6UvyLndaGLOVW6HHZN3mhXOzq29Jh6KGROnDqY0SSdt78JZbHJnfvOdrW6CtT3cONtbEUzoXyMO1ynMdbvwO/I9DAydPXhoBhj7DKu90gN0ZerYya6MGiIKu377xs19QmRsvSGzP4Cc+bKgyL2IZY16Qan0j3pnV5OeKetwQKxQ5IRbGKja0w7UVxiDJim9mNmt0rTpF6HXXkjVUclV76AM5Ng77Eaou9yAOBaTV/NvacZEdyi3Wt/iSdNUjGxwM+Y0KQtQVXy5sOG3D2vCVbyncZ1jaXCr0P8J1n6OIotdHV3b4o16eRx9I5bpxVrNkOHqqKujPwWejt62tLOc4Qag//ndbn0Hm5ACwFGXs2wW0fJi25bwyY5UBIYbkTZ3eu/U0Pke4wtaSeCO9aB26EKFfFQCsDSoeJY9VQZJqLoLffJIbwEWwkNxRM6mIk8Bwf8z/ENzfZktjGpFJc5Ty9xSi1bNG8ka7bMQAEcS6nPKPpp/ph85BcRj5PgtHter4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199015)(478600001)(66556008)(36756003)(53546011)(6486002)(26005)(38100700002)(6666004)(6506007)(66476007)(41300700001)(66946007)(8676002)(86362001)(4326008)(316002)(31696002)(6636002)(7416002)(5660300002)(8936002)(6512007)(2616005)(31686004)(966005)(186003)(107886003)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlEZmhLNWtZZTNCVDhteDAxakxHbVNxNEJiRzJmWlptUDFkTWo1eEhFQk1h?=
 =?utf-8?B?M3ZPdlhNMFpxY0hjMnVnN2hMRXI3azhMOUVHSVV2MXh0N0FNb2lsR0dJWXJi?=
 =?utf-8?B?TlpNY0JTYk1Jbm5MZGh2eU0zRkZBSnAya3BJUEpGcVNzZEx2WiszNEVZWC9J?=
 =?utf-8?B?eGx2R1hxRkJkRlJzZnFNL3lkMU1zTi85bjZBMWpQVjhVUmwxdXJqaHVaOS9H?=
 =?utf-8?B?bXlobGhsa0pQUmdHRk9MQlpxdStwZ3lyNnMyeUQ0enpXZkx5OTBvMHBkQVJW?=
 =?utf-8?B?NFV5TnE1ekhHUzdJc1RkK3REYlBlakJaSGRTODk2Sm9oWXZwSEVMRzBKK1Fw?=
 =?utf-8?B?WkYwZ0V3aFdXeGJDalllWkJhajBjbEgxZnhLWkVKODlMNXo2YWIxK0k5MDFt?=
 =?utf-8?B?U0h1aGN2UitRUkdlbVJWcHVjSGRKV1pqT0REM01FenBvQ1ZYTEtTTjFUTzRl?=
 =?utf-8?B?eWZtU3pVSHlSVDRJaEdTR3ViMlpRNVA5ODhMcStrQ1dZbUozU2d5eTQxbGFj?=
 =?utf-8?B?MHM5L2JuQi9TUnhVaHd5eUE0VDN4d1ZMU1dpWGJINXN0SlhQbjN2V24vSXpU?=
 =?utf-8?B?VFdLQ2pMblJmV0VYWWsyZlJtekFBbm51ZExlMGJWZVJvTFhaRFBVazZtcUo5?=
 =?utf-8?B?d1ZwZGwxeHdmbW1kNVoyRWdGeXNzUnRTTVg4SDU3QmJyNk5UTWhDc0hvYU1N?=
 =?utf-8?B?VHpGQTZBcko0Q25TRkVYSGxmZE5sMmNxV1lQbmttaDhkd3dlTHJ2b0xPbW9K?=
 =?utf-8?B?My9UM2lLYmdmZFlqcUNqeTJNRURmd1lKM3hPLzE0WW1jMDVKamcvaDd0eVA0?=
 =?utf-8?B?YlhLZnhnZVd5ODBsMmRYZHdteTZQLy9CM2EvN1Nrek9ZQ1JnQXQ5MkQ3YXJ2?=
 =?utf-8?B?SDRTczVhc0Y3eGVtc2RQazFJZWtEV3Vkb3ZEVHhUZURqVmJiUFJpT0JhcmpJ?=
 =?utf-8?B?QnZ3R01OaW13T1VFN1d3NjRjeXFMTU91RWYyRlNCNXdZaG5TL2c2RlI2VFJB?=
 =?utf-8?B?bHNWRHhuMkVDckRDRlNrcTJ6SjA3ME03eVdUaTl4QWFkRkNHendqckhGSFVy?=
 =?utf-8?B?dVJETjRYd0xLMGVXMldWL3IrQy85ZVdTeTNwUm5HQXNQcjdjcUV0WktXSTVG?=
 =?utf-8?B?UGdueERrOG1kZktIZnRQb2RlU1pHY2hzZURjNnlFNUhWVFB1RitjS2haNmpN?=
 =?utf-8?B?MmUvMjlmSHhFU2kzZnd2WlZ1T0RHV09KZVNpdFlYaDJjcGFTUFprSGhIYUlM?=
 =?utf-8?B?MTB0RUY3SVlwSUZsSzU4Q2N2T3pHTmlOc2k4U2cvUlFkWVhlVVQ3dUdjS3d6?=
 =?utf-8?B?aXNWR2luSFRSdFRvSWxUNE9ObEhEdjI2THdDSjRuRTcxeVRFRXNtZEFLdjE1?=
 =?utf-8?B?TkNxaUt0Z3VjdDhxWlVYaXpyNTVDdkRZOVVWL01RVVF2bXlqOFJiQTFsbnV4?=
 =?utf-8?B?LzVnOTQrZHI2TnVTYzVjSWVHUmFHejUyeVVrZ0txaXJkTFZFMzJpQzg4bkN4?=
 =?utf-8?B?NXQrU0E3NFU3K0NkVXhnVFRvUkkrUGdYMHIyQ1dlaVh3MWJVd2VYRCtRRnNJ?=
 =?utf-8?B?SzhsNFQ0WFFJbWpabDl5OU9lV0p0QnliNktKMVBiNjdaVVNTd2d5eWpCYUVV?=
 =?utf-8?B?Mi9teitiRGpzTzREN2NCalQvdUhoUXM0ejF3K3M2K1BXWmdjY0hDNHpzVlhJ?=
 =?utf-8?B?aXNBZ0k1dnVOT3ZKZTA1NjNZWFhMZ0N6S1RxanRBSFk0S0w0bUlxVnBLNXNt?=
 =?utf-8?B?NFFMZDcrK1Q2aWdrdzdIK01VeU50ZTN1WGwweFRnak5zcjhqU3JQMzNoK21v?=
 =?utf-8?B?aGtYTkJnZStsVS9OMjBCZ3J2WmNjdEZwN2ZSKzI0eE82cGlMVFRMR3JqZUpu?=
 =?utf-8?B?VUk1WDlhTmR4QUVXY1RNamN6UFNQc1k4aGRYb0dZSjQ1THVrdTNnQXhOV2lW?=
 =?utf-8?B?Lytvb3NDOFZySXk4WHk4MTBvamxwOWxOK0ErdUNIQ1dZWnB5M0xsOGwxUG9i?=
 =?utf-8?B?YUpIMnhoNXVXN09KVitVNDU4U200NWVPZmRNTVVhU1YzN1hXQi85Yi9ldWtQ?=
 =?utf-8?B?SG1Ma3R3MERKeVVScXJDZXhJR1dZYnlzT2xxRmdYSzZtZllCcW9jclNGajc1?=
 =?utf-8?B?bWdQWEVOaTdOaEhTUlBoKzF4RTZuS3U5K1F2ZVYwZ0kyY3ljSm44VjNsRURz?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fd7861-c305-4382-652e-08dad2ede3f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 16:14:00.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfY3/Ujxh7DY3ZRDpAk8pBD6/IaJwTzXgsVAuiRMC0hqifEpHM3LXirPvU1gHErSfTmKubRt08jLd1vT607/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/30/2022 8:45 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 30/11/2022 16:11, Manikanta Maddireddy wrote:
>> Thank you for quick review. I will wait for other reviewers to review
>> patch 2 & 3.
>> I will address all review comments and sendnew revision.
>>
>> On 11/24/2022 2:15 PM, Krzysztof Kozlowski wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 24/11/2022 09:35, Manikanta Maddireddy wrote:
>>>> Tegra234 supports PCIe lane margining. P2U HW acts as a relay to exchange
>>> typo: merging?
>> It is not typo, it is PCIe feature lane margining.
>> https://pcisig.com/pushing-limits-understanding-lane-margining-pcie%C2%AE
>>>> margin control data and margin status between PCIe controller and UPHY.
>>> Please use scripts/get_maintainers.pl to get a list of necessary people
>>> and lists to CC.  It might happen, that command when run on an older
>>> kernel, gives you outdated entries.  Therefore please be sure you base
>>> your patches on recent Linux kernel.
>> I verified these patches on 6.0.0-rc6 kernel and executed get_maintainers.pl
>> script on it. Did I miss anyone here?
> Yes. At least Rob, maybe more. You need to CC all
> maintainers/reviewers/supporters and all mailing lists.
>
> It's not my task to verify each of these addresses to check whether you
> really missed someone or not. I spotted at least one missing address so
> just run get_maintainers.pl and use all entries from there.
I rechecked my "git send-email" command, I did add Rob's email. In my 
Linux file path, I found a file with name "--to=robh+dt@kernel.org".
I am not sure what mistake I made during "git send-email". I will do 
dry-run before sending v2.

I rechecked mailing list from get_maintainers.pl, I added everyone from 
the list expect Tegra developers who contributed to the file 
tegra234.dtsi, but not for PCIe.
>
>>>
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> ---
>>>>    .../bindings/phy/phy-tegra194-p2u.yaml        | 50 +++++++++++++++++++
>>>>    1 file changed, 50 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>>>> index 4dc5205d893b..0ba3f6a0b474 100644
>>>> --- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>>>> @@ -40,6 +40,51 @@ properties:
>>>>      '#phy-cells':
>>>>        const: 0
>>>>
>>>> +  interrupts:
>>>> +    items:
>>>> +      description: P2U interrupt for Gen4 lane margining functionality.
>>> typo: merging?
>> It is not typo, it is PCIe feature lane margining.
>> https://pcisig.com/pushing-limits-understanding-lane-margining-pcie%C2%AE
>>>> +
>>>> +  interrupt-names:
>>>> +    items:
>>>> +      - const: intr
>>> Drop entire property, not really useful.
>> In driver, I am using platform_get_irq_byname(), I will change it to
>> platform_get_irq()
>> and drop this property.
>>>> +
>>>> +  nvidia,bpmp:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    description: Must contain a pair of phandles to BPMP controller node followed by P2U ID.
>>>> +    items:
>>>> +      - items:
>>>> +          - description: phandle to BPMP controller node
>>>> +          - description: P2U instance ID
>>>> +            maximum: 24
>>>> +
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - nvidia,tegra194-p2u
>>>> +    then:
>>>> +      required:
>>>> +        - reg
>>>> +        - reg-names
>>>> +        - '#phy-cells'
>>> That's not how it should be done. You have only two variants here, so
>>> add a "required:" block with above and only one if:then: clause for
>>> interrupts and nvidia,bpmp.
>>>
>>> Requiring reg/reg-names/phy-cells should be in separate patch with its
>>> own reasoning.
>> Ok, I will create two separate patches and add if:then clause only for
>> tegra234.
>> As per understanding final change will look like below, right?
>>
>>
>> required:
>>     - reg
>>     - reg-names
>>     - '#phy-cells'
>>
>> allOf:
>>     - if:
>>         properties:
>>           compatible:
>>             contains:
>>               enum:
>>                 - nvidia,tegra234-p2u
>>       then:
>>         required:
>>           - interrupts
>>           - nvidia,bpmp
> yes
>
> Best regards,
> Krzysztof
>
