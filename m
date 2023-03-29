Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241566CF0C8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjC2RNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 13:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjC2RNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 13:13:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02hn2209.outbound.protection.outlook.com [52.100.160.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466285FFA;
        Wed, 29 Mar 2023 10:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI427LIoXkdF50w9+397bD8lPsV+wIS/jmUC3I+Rxdv8tHA5XApHgKM9UYpLN9ooBcp8ZOR3agDw6yG5Trh5tRJQztxS4rCQtEmWbwC91cyu6RKpov2p8GcK1FUrN5UX3xZJF3qugIKhK1m5EBTSYiRd5FmTmVOC4IdJ3yS4cqB9FnS9SS4mNuyqv4J8Fi1KZFc5dP/gH1O6M4rl30oWK/hX3HZfLt59Lt3ZjsKAfRzsfYav0sTDV3MKlsk/nz/c839j3MsVqpY1CyHCPGKYyCcVejW3vxpsY6OjesVOchoOSHxgxMT7lMCixVbuhjqJ+nKKobrmEfw4orD7E+9ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVc/axd8jBov+zhZyeS0qFLmnjAEPfPfh0j/OhBk8ww=;
 b=WydSIme6DLV+mA1Iw+Jy0jaZDUJ8KMVZQXB/gAozQdGMeRMgdtTQya+UttRur21WF1Eht+j9+z/Pxaxn3dxiPUX1mpOxxymgz9m3TgXNl6tM7tgEKYad3wHLUYs4Y5vot0a+bRw62v/OyylU8gmFwqE+K3Y69Pjp4wF50JSVo/GdmVKwUzAcsK5qlD1WDTPQFPvFXQtoTpuxDQfy/6J3uJPEclBdbfJ30eZYBMo5PLgldsb6f/sofOtJByIqXg1So80zYyMZ4ypQfCxyCcAetfGYJOAO2MRIla63K3axcH0z64hXjQFX2Sq2kqVxHXS1SySYk5qVTJCs/UEX98QSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVc/axd8jBov+zhZyeS0qFLmnjAEPfPfh0j/OhBk8ww=;
 b=q4mRBuqF/cMwHEaJMLR5Y//JP4ESL2JI0OmiNM2FLqjqq4surKLo7HtLGmYUVTYDHLJThOi7umlEJGFvfPeIdOogHhF8ekjKZ9rfKMhNdKkObV+95fqKCzNH9RvJEp3TwqhH4/FN4By13vPTYzHt4aUdIhFi/s7LT6wFuj7WXKY+7TpXUGo0YWb8AS9QmQ+BFn7cvrHpJjUUbkvq2K+t/yU2vV31qKwYfyp/gbS8V9bbhU+OI+Fra2coRPwXWwb+3l9t9d5YHerYLcFMGsFQtQk7vUbbhcCx4Q+uLic8ZL3gIOuJI7F5pxSv2eOIOwGIJ4bztiCKV/wRcPyRjecCew==
Received: from BN9PR03CA0910.namprd03.prod.outlook.com (2603:10b6:408:107::15)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 17:12:56 +0000
Received: from BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::1f) by BN9PR03CA0910.outlook.office365.com
 (2603:10b6:408:107::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 17:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT103.mail.protection.outlook.com (10.13.176.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 17:12:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 10:12:44 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 10:12:38 -0700
Message-ID: <0b393600-3f08-c2e8-9b02-664c6a984de1@nvidia.com>
Date:   Wed, 29 Mar 2023 22:42:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v4 01/10] dt-bindings: memory: tegra: add bpmp ref in
 tegra234-mc node
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <treding@nvidia.com>, <dmitry.osipenko@collabora.com>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
 <20230327161426.32639-2-sumitg@nvidia.com>
 <787f656a-223d-5eed-e311-9cc7a6c46452@linaro.org> <ZCLF6ZRH528pu/r3@orome>
 <79d8044f-ce68-463e-66f7-8755e253bc99@linaro.org> <ZCLiCWRYbO98qwCn@orome>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZCLiCWRYbO98qwCn@orome>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT103:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c1edd0-0025-4b75-dc52-08db3078d6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzeDqYzOVqJAXIlp/dmlmxec+XDoIXYeFHPkIFVghvVw0Nim6sYEyVrUPlSrwFUHeTAVl7agXEnAZZXQcA0mye/fS5IJA8xRppU1DJfNKLWW5MU8XlelzVEL0WssG7TGY7Vsm5xeQMjTdGJAYqkdMZPgXdGBUO2yvxtuJCesFGSADktM0VGTUyyYpsqTEeoyACHuchuU2bLqnNUjoZFI+3YzL8uSFle4Pph3kvXiOZuh8dkF/thEH7uqBU0fDMhs31ToHLb68nP8iO4a+H0EyFKHjoGt83mLzaPNJSOXDiGMRgFuuG4pafpk73slpqh324ZXwLTPODWKCzobTg1jpZDdeiI0zTbGx9+AWym87rMVP0kY2WxegE7d97+B4Y5eSW6UwWROcJOvfgxbd4ykHOoD6XiW3ap2vboob2Ja+cvE/vteV6QgsO6fa/sUppnENWnxNfINNVw25630SyFH5cozDPOZKRcWlzCcW7i1MC4qwLvzf5tF5Gy6Vst2WpDY8+KMVIt0fy9EzyIMcU/KjLFsPzo3V5bsdspSr8xAykAKiTiU2mYw05FIl4kJpHZgfo6iSUCkb6YdFLvu9NlxxxxalvDsooj2tK+SZXjPdTjk/faQs25klyBwJUkv/eNWUdPjYaIOx5uRU3rbv3gNwVhwilvjwvjfy7GI+l1eZ47K4Ejk8wkkDAjk7dq4/qHZ4QlTh+ZXWNXkWkiC2Y68LBBAGIEibO5cqqM3xhS7Zd0NDvNkf/9yAGvUVCwWK8BjN36YUnLuP0KqMeq6uhXToxLaWNdlni1oLVpzZcZyDzQ1EWdUW+/RXTPBWZ4XDq0oh2pC64lHeAFHNY5dVnSjH/cKlY4uCL8ROxpRqtfEhaA=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(5400799015)(46966006)(40470700004)(36840700001)(86362001)(36756003)(31696002)(82310400005)(2906002)(66899021)(31686004)(40480700001)(40460700003)(478600001)(426003)(83380400001)(107886003)(336012)(26005)(2616005)(54906003)(47076005)(4326008)(110136005)(70206006)(34020700004)(36860700001)(70586007)(316002)(7416002)(41300700001)(8676002)(16576012)(16526019)(186003)(53546011)(356005)(5660300002)(82740400003)(8936002)(7636003)(43740500002)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:12:55.6686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c1edd0-0025-4b75-dc52-08db3078d6bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28/03/23 18:18, Thierry Reding wrote:
> On Tue, Mar 28, 2023 at 01:22:26PM +0200, Krzysztof Kozlowski wrote:
>> On 28/03/2023 12:48, Thierry Reding wrote:
>>> On Tue, Mar 28, 2023 at 09:23:04AM +0200, Krzysztof Kozlowski wrote:
>>>> On 27/03/2023 18:14, Sumit Gupta wrote:
>>>>> For Tegra234, add the "nvidia,bpmp" property within the Memory
>>>>> Controller (MC) node to reference BPMP node. This is needed in
>>>>> the MC driver to pass the client info to the BPMP-FW when memory
>>>>> interconnect support is available.
>>>>>
>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>> ---
>>>>>   .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +++++++
>>>>>   1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>> index 935d63d181d9..398d27bb2373 100644
>>>>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
>>>>> @@ -58,6 +58,10 @@ properties:
>>>>>     "#interconnect-cells":
>>>>>       const: 1
>>>>>   
>>>>> +  nvidia,bpmp:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>> +    description: phandle of the node representing the BPMP
>>>>
>>>> Why do you need this multiple times? Both in parent and all external-mc
>>>> children?
>>>
>>> We've had nvidia,bpmp in the external memory controller node since
>>> basically the beginning because we've always needed it there. For newer
>>> chips we now also need it for the memory controller.
>>>
>>> Ideally I think we would only have this in the MC and have the EMC
>>> driver reference it via the EMC's parent (i.e. MC), but that would break
>>> backwards-compatibility. Reaching into the EMC's DT node from the MC was
>>> another option that we discussed internally, but it didn't look right
>>> given how this is also needed by the MC.
>>>
>>> One thing we could potentially do is deprecate the nvidia,bpmp phandle
>>> in the EMC and only keep it as a fallback in the drivers in case the
>>> parent MC doesn't find it's own in the DT.
>>
>> Yes, deprecation would answer to my question.
> 
> Okay, great. Sumit, you can resolve this by adding a "deprecated: true"
> to the EMC's nvidia,bpmp property schema. In the driver we can then try
> to look at the MC's ->bpmp and if it exists reuse that. If it doesn't
> exist, we can keep the existing lookup as a fallback for device trees
> that haven't been updated yet.

We can't use MC's->bpmp in the EMC driver's probe as it will be NULL. 
This is because MC driver uses "arch_initcall" and gets probed earlier 
than BPMP. We can do this in another way as below change. This way we 
can use the existing "nvidia,bpmp" property from EMC node and don't need 
to move it to the MC node. Please share if this change sounds OK.

  +++ b/drivers/memory/tegra/tegra186-emc.c
  @@ static int tegra186_emc_probe(struct platform_device *pdev)
	
  -          if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT))
  +          if (tegra_bpmp_mrq_is_supported(emc->bpmp, MRQ_BWMGR_INT)) {
                     mc->bwmgr_mrq_supported = true;
  +                  mc->bpmp = emc->bpmp;
  +          }
     }

     return 0;

   put_bpmp:
  -  tegra_bpmp_put(emc->bpmp);
  +  if (IS_ERR_OR_NULL(mc->bpmp))
  +          tegra_bpmp_put(emc->bpmp);
     return err;
   }

   static int tegra186_emc_remove(struct platform_device *pdev)
   {
     struct tegra186_emc *emc = platform_get_drvdata(pdev);
  +  struct tegra_mc *mc = dev_get_drvdata(emc->dev->parent);

     debugfs_remove_recursive(emc->debugfs.root);
  -  tegra_bpmp_put(emc->bpmp);
  +  if (IS_ERR_OR_NULL(mc->bpmp))
  +          tegra_bpmp_put(emc->bpmp);

     return 0;
   }
