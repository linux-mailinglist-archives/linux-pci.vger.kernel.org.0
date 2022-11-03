Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA55618440
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 17:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKCQZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKCQZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 12:25:52 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE881B9C1;
        Thu,  3 Nov 2022 09:25:48 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 12F5C8519D;
        Thu,  3 Nov 2022 17:25:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667492747;
        bh=WmqemEiN44sB8bjhEdAs3Y9GDPso0HE+fIgfuWW6ajU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oT4yP+7rHFVq+sDHC//fTF2i+fRPBAubWRNCEct0UOViAgOX+lzvVC5khCVbvx1VK
         TEK+tnwDKYahHgNdc7H2deCcf+l9Ew5EduIQmy1nzuL6bhWlP1HmzriFDvL9ltuJSr
         61kg25LtticqDdbr4RgVdddYh7rvDIdLvQBs0V1prkKI+wnWxDz3XfL2a3xi+Fc7sj
         /ftUrVA1tSvhUfMkveVrMq3Mq8mwpgFzCEQeZEhDZoBdOB4x5yMydydPSlWq7WtkpL
         LjyILm78HkRI60ipZfYLro3sVEeuXWKvA0Er9Zps5tCoHloTQFudHltG4k66t/P1QM
         m6KOy5CEO12NA==
Message-ID: <2908d3ff-f476-4750-90cf-1554492c69c9@denx.de>
Date:   Thu, 3 Nov 2022 17:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/3] dt-bindings: imx6q-pcie: Handle various PD
 configurations
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20221102215729.147335-1-marex@denx.de>
 <20221102215729.147335-2-marex@denx.de> <3645906.iIbC2pHGDl@steina-w>
 <CAL_JsqLg893rWwEQhgf_9=78WNiA7bstqPVvP6SQe4SyAhhyUw@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAL_JsqLg893rWwEQhgf_9=78WNiA7bstqPVvP6SQe4SyAhhyUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/3/22 13:32, Rob Herring wrote:
> On Thu, Nov 3, 2022 at 3:29 AM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
>>
>> Hi Marek,
>>
>> Am Mittwoch, 2. November 2022, 22:57:28 CET schrieb Marek Vasut:
>>> The i.MX SoCs have various power domain configurations routed into
>>> the PCIe IP. MX6SX is the only one which contains 2 domains and also
>>> uses power-domain-names. MX6QDL do not use any domains. All the rest
>>> uses one domain and does not use power-domain-names anymore.
>>>
>>> Document all those configurations in the DT binding document.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Fabio Estevam <festevam@gmail.com>
>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>> Cc: Richard Zhu <hongxing.zhu@nxp.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: NXP Linux Team <linux-imx@nxp.com>
>>> To: devicetree@vger.kernel.org
>>> ---
>>>   .../bindings/pci/fsl,imx6q-pcie.yaml          | 47 ++++++++++++++-----
>>>   1 file changed, 34 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>>> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml index
>>> 1cfea8ca72576..fc8d4d7b80b38 100644
>>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
>>> @@ -68,19 +68,6 @@ properties:
>>>       description: A phandle to an fsl,imx7d-pcie-phy node. Additional
>>>         required properties for imx7d-pcie and imx8mq-pcie.
>>>
>>> -  power-domains:
>>> -    items:
>>> -      - description: The phandle pointing to the DISPLAY domain for
>>> -          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
>>> -          imx8mq-pcie.
>>> -      - description: The phandle pointing to the PCIE_PHY power domains
>>> -          for imx6sx-pcie.
>>> -
>>> -  power-domain-names:
>>> -    items:
>>> -      - const: pcie
>>> -      - const: pcie_phy
>>> -
>>>     resets:
>>>       maxItems: 3
>>>       description: Phandles to PCIe-related reset lines exposed by SRC
>>> @@ -241,6 +228,40 @@ allOf:
>>>                   - const: pcie_bus
>>>                   - const: pcie_phy
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: fsl,imx6sx-pcie
>>> +    then:
>>> +      properties:
>>> +        power-domains:
>>> +          items:
>>> +            - description: The phandle pointing to the DISPLAY domain for
>>> +                imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
>>> +                imx8mq-pcie.
>>> +            - description: The phandle pointing to the PCIE_PHY power
>>> domains +                for imx6sx-pcie.
>>> +        power-domain-names:
>>> +          items:
>>> +            - const: pcie
>>> +            - const: pcie_phy
>>> +    else:
>>> +      if:
>>> +        not:
>>> +          properties:
>>> +            compatible:
>>> +              contains:
>>> +                enum:
>>> +                  - fsl,imx6q-pcie
>>> +                  - fsl,imx6qp-pcie
>>> +      then:
>>> +        properties:
>>> +          power-domains:
>>> +            description: |
>>> +               The phandle pointing to the DISPLAY domain for imx6sx-pcie,
>>> to +               PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie. +
>>
>> Doesn't it makes more sense to keep the power-domains descriptions in the
>> common part on top, as before, but adjust minItems/maxItems for each
>> compatible?
> 
> Yes. Keep properties defined at the top level.

The problem I keep running into here is that if I apply patch like below 
(basically what you and Alex are suggesting), I get this warning:

arch/arm64/boot/dts/freescale/imx8mm-board.dtb: pcie@33800000: 
power-domains: [[86]] is too short

I think that's because power-domains: contains items: and to validate 
that imx8mm.dtsi with pcie@33800000 { power-domains = <&pgc_pcie>; };, I 
would need to get rid of those items: ? Which is what I did in the 
aforementioned patch for imx8m, that's why I removed it from the common 
part.

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml 
b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12c7baba489aa..ec5e8dfe541ea 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -68,6 +68,18 @@ properties:
      description: A phandle to an fsl,imx7d-pcie-phy node. Additional
        required properties for imx7d-pcie and imx8mq-pcie.

+  power-domains:
+    items:
+      - description: The phandle pointing to the DISPLAY domain for
+          imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
+          imx8mq-pcie.
+      - description: The phandle pointing to the PCIE_PHY power domains
+          for imx6sx-pcie.
+  power-domain-names:
+    items:
+      - const: pcie
+      - const: pcie_phy
+
    resets:
      maxItems: 2
      description: Phandles to PCIe-related reset lines exposed by SRC
@@ -235,16 +247,11 @@ allOf:
      then:
        properties:
          power-domains:
-          items:
-            - description: The phandle pointing to the DISPLAY domain for
-                imx6sx-pcie, to PCIE_PHY power domain for imx7d-pcie and
-                imx8mq-pcie.
-            - description: The phandle pointing to the PCIE_PHY power 
domains
-                for imx6sx-pcie.
+          minItems: 2
+          maxItems: 2
          power-domain-names:
-          items:
-            - const: pcie
-            - const: pcie_phy
+          minItems: 2
+          maxItems: 2
      else:
        if:
          not:
@@ -257,9 +264,8 @@ allOf:
        then:
          properties:
            power-domains:
-            description: |
-               The phandle pointing to the DISPLAY domain for 
imx6sx-pcie, to
-               PCIE_PHY power domain for imx7d-pcie and imx8mq-pcie.
+            minItems: 1
+            maxItems: 1

    - if:
        properties:
