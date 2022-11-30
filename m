Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6763D8F2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 16:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiK3PLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 10:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiK3PLe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 10:11:34 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729221B7A8;
        Wed, 30 Nov 2022 07:11:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQ/tpMcbjH48EkBZdDzmooUCPywAD9w9RtXlVtoJ3QajvLkc8pcaAZEOTxxoagEeSH4QIPvMLOTnB5VYJ9MhSYrovRzn6m9KuWv50EkGKfpkBTEJkvacboMwvny6Pm6o+GWA9dLhJZTo6t3LuOnT02HwupcWEp6VuLNbd2NiAi3xXxtWLhRMvpLR4kA3Pu23YyjzL+pp/HkNVIMfRcAGGSj/kf1wv+NyLul/PMtWAh2/GGCIGk11boobaBSmzcmgA8lbs2njzJgr6KrscZuFIE/Zvl7IT8L3je/y2nF/4g/pGwBV6AJnAuB/1pS8ajMBfOfhrLs8xc9tdWFuCunFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYCiNCLBu1a0lSxJk9MOM6Nf5wxlmeKjlThgkLGgxkY=;
 b=etWkRoKzmMQKmO1QWt3RSi4C7Bf+04U5SRrPUQgMVB5+bITSEwBzGNYGwlS5mllKihkZ9ZGhie6b8UPu2kZoQu+UxzO+4K4406y4Rl5dG+XsqFnyrEl6yLf78n9VzvFgbZXgk9H8+SRn8AaaX+u5HS2t9mOHIBdGSpRsk/dfNJNpSz9ONzOg7X+P0uB0X8qdH2TG2wFyoeKWgsPTXYQdOqklbjju1ylZ/s2lJRT0gH/sG5q1eZCYcYbnSIvwegBSa6OWYSh+o3hrkSH7cGnB43yh/IRnSA0eXBkzchjONzv05ctlPEfIZqCX9/5NX53COPVUNyGxUTUPs/AlTb9m8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYCiNCLBu1a0lSxJk9MOM6Nf5wxlmeKjlThgkLGgxkY=;
 b=rboXjHSiotofU1qkwKpz47zBXPQRDJGOMFJMGoHBTEORLJwCI+UtU+z9TV8fcw17MU5L3WQajegmRxmR8Fww6zhQDW62dVZyphau1+nTU1G/ifRicWGgViA9qIthkGKL8hXAPOYfXuspVVLU5X2DYngQeCGEWdv4uVC2yjWYMmZfXjQ0sIprnEAEpNI1NUXnu9zSuOmupoIepAdmw5SMkSzpsaGRmuFJrFaWDhOrcW8Fi6U21zkW/lb0veNWcV+QxDKJXaKD/T2GfPAt3uV29IlBMB3UgUmPde9fGI6SQvZXuianaORbhO/sWhZiFNlY67mqK9pdn5YN18ySv8m18g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 15:11:30 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::c267:3c38:d5bb:db3b]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::c267:3c38:d5bb:db3b%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 15:11:30 +0000
Message-ID: <b81c69e0-13a2-6a25-21c7-c0d8804f9c3b@nvidia.com>
Date:   Wed, 30 Nov 2022 20:41:14 +0530
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
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <0b203c11-851c-fd6c-faeb-e283b158f1c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 8922ede7-55ad-4832-567d-08dad2e52896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEu+I9vbfL1f1kgbEmZPHfF1aN0wFa1lPrEHMRcWkIABIngew1pB5hRc9P9FBwk3MQCuguebXyBOMEbwP5kGAQZvBaFD91jlnnIwagmNdpPQs8AbCtKHOCVKE0hERA7HYd6o1WMAAz5OVtMmXnaMWxW7e0xgvUF3oaVCLxyjSg1JKIT87RGYAfhq+qF65GlZwItHtGSE+w9RFejBL+1+shSWE3gofnjunPCJhhad7Vv0Oxo052v2n4gyNlw7O+3DD7twayoK8v9gPdpmbQXUWQhDUWG+c4Pg5lKfm7FYWlf129fAThOl3V06Iz6Z/rnF6X8kQymEhMo9zBdpI1KWRSQGHGPPZZ0povFEvoEQx3v92c+83mmNc11Vq01vDMDct9toFnI729vQ1Oq7fNxNnWuXMUcpktlNdd5YiRIlkl7ZU097faNbNXKeG0CqzTYfkWJ05WUqk+yAXjgGd+YN3l4FC1mufo5i6QLTxQRAJnfp8nrlnW1EVGM8W9ktEp/2zzokYXINUMA7xbZnKFW0NALepPNJMZGcYzrUvYwT7W2jO5PELntF8PFKG718pN/q0nyzIqV6mI4Ji/0e7AQQeF91jjMy3LqTGYMxosa3l4syJLPAV41Zp6jyvIjEGmNdZ0yFRJvcWks3feZlfKQCsXbOORFDfo7NybKpt6EkyWocvHlKuDmOX00WBlxINBADQOFFo7vdQDmo6GJQRJZ5DLIZpA2yfL4budWu4BqMo+T59NgIRurh7Q3tVunUFJK5uG8bcx+NGWRtTinEv+ohwDWeCQC/XlH0Xng1EN9L1n0RM38yE8v4dhkFBQUw0f/B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(2906002)(36756003)(107886003)(6666004)(86362001)(7416002)(6486002)(31696002)(478600001)(966005)(41300700001)(26005)(316002)(66556008)(66946007)(6636002)(5660300002)(66476007)(8676002)(8936002)(6506007)(4326008)(6512007)(2616005)(186003)(83380400001)(38100700002)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy93VG5Za1RpeWhmb1QvTCtuOWxvOVJpTWFaNWNUbjVlK0hvSzhGSmo3dTFh?=
 =?utf-8?B?dTNlS0FnSFpNY1l2R1lqcG5uclNucXU0VVh0V1NqYVpKWSszcFB1bmwxU3BS?=
 =?utf-8?B?Ym92UEZja0J2aVRCTHNXZEFvTWViWHIxU2VIR0pyOEhDRXROaU9zS1NHeEJX?=
 =?utf-8?B?R3hOOWNpWmRhUkJCWURnR00vZWdNdFo5VTZIT0pDaUdHSGtWSWdRcTgrUTFt?=
 =?utf-8?B?cERoWWl1b0wvcHhTQ3YrZkFJYkVyN3lWZHd0STdWdDBBcldzc1NqVHpicnBm?=
 =?utf-8?B?S3RGRnFzYVQvY0oza3d2Rjlud1p0aFNkaVBGc3hPV3lydjJVUWc4bkRxWEti?=
 =?utf-8?B?WFNydmdmOWhQZzBkODNldC83eTJwKy9SM2RMTmtwZDcrbWpDREZMbzBoTjVW?=
 =?utf-8?B?RWpqcGMyRnRTM21TNER2WUxXTTh0QTZaT1QrZzlrcTVsWklXZDhYb0dRRmt0?=
 =?utf-8?B?K1FoZFhtVFhhNUEzam03MzU0QnR6VWdaOVhJeUVHR1krQ0NuN2t1QjhzY3Jv?=
 =?utf-8?B?KzV2UDZObDFGeTZEbm9XV0tuSzRBemkrdFJ6TkE1eU5hd3pxM1Y4Yk5MU0dt?=
 =?utf-8?B?dWtrVFIwb0pQZnZSZFYzNWpUeUVGRWd4V3FEOE82bmU2UzNWUFhMdyszTDYv?=
 =?utf-8?B?dWtLV1FUYUlYOEhrOGhPeTM0RXFKM1VINDlnVHNvaERTWVZ3QzhLVklCK0Jr?=
 =?utf-8?B?TmVDTHptSDQ1ZVd1R2EvVUlHUW05NlVFRE1vVFEvaHg0N1pwK1g0ZFI0TEhn?=
 =?utf-8?B?aXR3a09nbFkwa09FTEx4QWkwT01HcFRQcnRxSVZhV0NZbVZFT2VqSUMrQ0dm?=
 =?utf-8?B?ZDBtbzNIeTlxR0FRTExvUHBHVWtybkZISW8zRWkrcG9Cb2dlVElZdU5tNTRL?=
 =?utf-8?B?cU41RjlQeDg0MU1UczhLWHBBRUFLRWh0ZzZmYTJYMWw2djVUUEVuRkFUNms3?=
 =?utf-8?B?anc5dVNpM0x0VVNnZlRxeExEVE9Pb2NleUluT2JiSzF4ajllbG5vYmZuS2dC?=
 =?utf-8?B?RlFVa0xmc0UxRVBIdnVOVUpxLzJ4ZkY3K0pXdVBuUlhSZk5abWVuZXcxaHVW?=
 =?utf-8?B?cUtiYnlDQ0FONlBSdmhvMjJDRSt4WDZ0dHpROERuRGJDL2xjYjQ1L25iejYw?=
 =?utf-8?B?RGFUekE2KzZxT0EyOTRCK2pXdUtmZmhIay9TWHhIbkNQVy9WVE1vUDhDbXM4?=
 =?utf-8?B?OFZGNk1rbEFqYVl1VEU2QklPOTFYYVdqN0lOMTd2alVDNWNkcHpqM05MYUNZ?=
 =?utf-8?B?aE9obldnaGtnNnVESHAraCtjOUlBVEtJYmQ3a1g0SGpLS0h6YVc2VjQ0VFFC?=
 =?utf-8?B?Y2ZFZnREOXpWTG90K3UwTWVFZ0p2YThOMkVXV01ON1pkMkF1N01vM3p0RCs3?=
 =?utf-8?B?bnV4Y1loTnhGT1ZsUk9wVDQ5ejlKZlNUaE0vL0FzZnlWOWw2cjZldnBka1Ji?=
 =?utf-8?B?M2Y2RnEycXNubDRkcnpWY3BKU2JSa09mMU5JUlZlWUFtV0hYOXFzWFc3VGVY?=
 =?utf-8?B?VXFUQ1ZGZjJ2SGczSXlkdGJpbXB2cTgzaGxIVXFwYmZYSm5QMGhGYXc4c0R5?=
 =?utf-8?B?SjEwZk4rZHovZkR3UHpsRTI4QmYybG9IYXhwa0pCa3JZRzdSczBGVnRIaFNC?=
 =?utf-8?B?anVESnhBRkc5OXY1cThNaHl1ckpXNXkxOFZtekxBc3lFTHUzRDB4S1U1YjBF?=
 =?utf-8?B?UlNHb1FKcGhEa2JBcE5tRStUV3pJVHRoK29qZWJOMHQ4a0ZYblA4cVF1Rjhk?=
 =?utf-8?B?MVJ5K0R5aHFJUTNRMHhnWjJVWDNVZFpmeldKY2piNFBKVEh1N0Vtc3JaY1hv?=
 =?utf-8?B?d3ZlTW5JMlVPTjlLcWJXSlltMjcraFR1a0t6UEVkSUNkYzc4aUppVVBzRFJm?=
 =?utf-8?B?TGNLS3MxQjhSNHF1RU80V1N0cnd2Vnd6ek93N3A0L1NLK0FqQiswNW5rWDlD?=
 =?utf-8?B?WGhUSHF3d1g2YVEvUEV3QjFBcEZuK3U3TUIxaHhFK0c5eHhva0N3bUlUMnU1?=
 =?utf-8?B?Q0d0aXdlKzBmMkVUa2hJYkY0SXFxTEVWU0p1d2M0ZEdzTFpLcFRZOUY4eWhy?=
 =?utf-8?B?TU1RSEhVZzhReWxqQkxITFBPYld0SzV4bTcySTNiS0xxT1c1VVYvd0V3NzMz?=
 =?utf-8?B?ZWZ5WUVCMU5Tc1p5YXorWmQyUjc2NFhSTTQ4eDZmR0djMk1rMFFsdzQ3bnU0?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8922ede7-55ad-4832-567d-08dad2e52896
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 15:11:30.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgIkxqvtEPqZwdWVMh2enSGvRudNoslXVP69KNHjqzQHjSFu9VII3W8c4fvOG1olTlvsKuPclamVm1ru8QvF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you for quick review. I will wait for other reviewers to review 
patch 2 & 3.
I will address all review comments and sendnew revision.

On 11/24/2022 2:15 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 24/11/2022 09:35, Manikanta Maddireddy wrote:
>> Tegra234 supports PCIe lane margining. P2U HW acts as a relay to exchange
> typo: merging?
It is not typo, it is PCIe feature lane margining.
https://pcisig.com/pushing-limits-understanding-lane-margining-pcie%C2%AE
>
>> margin control data and margin status between PCIe controller and UPHY.
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
I verified these patches on 6.0.0-rc6 kernel and executed get_maintainers.pl
script on it. Did I miss anyone here?
>
>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>   .../bindings/phy/phy-tegra194-p2u.yaml        | 50 +++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>> index 4dc5205d893b..0ba3f6a0b474 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
>> @@ -40,6 +40,51 @@ properties:
>>     '#phy-cells':
>>       const: 0
>>
>> +  interrupts:
>> +    items:
>> +      description: P2U interrupt for Gen4 lane margining functionality.
> typo: merging?
It is not typo, it is PCIe feature lane margining.
https://pcisig.com/pushing-limits-understanding-lane-margining-pcie%C2%AE
>
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: intr
> Drop entire property, not really useful.
In driver, I am using platform_get_irq_byname(), I will change it to 
platform_get_irq()
and drop this property.
>
>> +
>> +  nvidia,bpmp:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: Must contain a pair of phandles to BPMP controller node followed by P2U ID.
>> +    items:
>> +      - items:
>> +          - description: phandle to BPMP controller node
>> +          - description: P2U instance ID
>> +            maximum: 24
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nvidia,tegra194-p2u
>> +    then:
>> +      required:
>> +        - reg
>> +        - reg-names
>> +        - '#phy-cells'
> That's not how it should be done. You have only two variants here, so
> add a "required:" block with above and only one if:then: clause for
> interrupts and nvidia,bpmp.
>
> Requiring reg/reg-names/phy-cells should be in separate patch with its
> own reasoning.
Ok, I will create two separate patches and add if:then clause only for 
tegra234.
As per understanding final change will look like below, right?


required:
   - reg
   - reg-names
   - '#phy-cells'

allOf:
   - if:
       properties:
         compatible:
           contains:
             enum:
               - nvidia,tegra234-p2u
     then:
       required:
         - interrupts
         - nvidia,bpmp

>
>
> Best regards,
> Krzysztof
>
