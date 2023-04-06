Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A036D9C8C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 17:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbjDFPj3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 11:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDFPj2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 11:39:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857631732;
        Thu,  6 Apr 2023 08:39:26 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N9MYu-1qVVyt10GS-015JJz; Thu, 06 Apr 2023 17:39:03 +0200
Message-ID: <d0bf241b-ead4-94b7-3f03-a26227f9eb58@i2se.com>
Date:   Thu, 6 Apr 2023 17:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230406124625.41325-1-jim2101024@gmail.com>
 <20230406124625.41325-2-jim2101024@gmail.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230406124625.41325-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nknTnX5dlSCEMuTzZzTH1lzDx7myKdzZXx63p/ALhR5p/l1cSBy
 /WVL/VeWlNJRfuyPTv3z8OZICfKrmkG8l1dad5ttQkPqrRPTpFW+HjZL8FfkOz39Bx8e6cy
 vDV+pMAiGfNRtiH0hMZAfvPAbLsy5UAXhIAbE0EwJl3GqM7J5hdrBtwFv80E4+82mzLLblU
 mnBo88FTMBiQMQJibNy7Q==
UI-OutboundReport: notjunk:1;M01:P0:1JPu3Fn+QcE=;R2rM/eZ8PosqU/E3uRLSGrLJ8xn
 tSj49CxxVi1/9bgT6bzPsMFvXzbtk/c3JjjZ4zbTou1QamVn/o6LKCFCZT7p+FQplf4XbnOrM
 03IZourgA/SwhPEUg4y5658zCqcUNE//OCMFEiQsy0nYefH4LO6HMfQljXYwpoypaYaHuqV++
 T7azvAR1Ugr6zap3dH8O9zr7jnCazLDzZ14DKFrLzHQ91tiAqTwVp6T2Kc0MJ0nepSx4L7TpV
 b+3+LnvBEBq8fF2yYz+15ff6J7p+L/01HRxcEin1Olh4pLRUomWhxMsFnIUL8vN+JIUvnBJJ3
 pJtMph81OwHIxCantSeZTSds9PE/hjMbb2+QFvW4jTmmvjRmCtvZ/XWnoWtGUtQ45id/Q4r0l
 fqi2NRjuTBYmF+Fl9CmmrwIBZoTqVb7xEH/cgdrJvkDgKscNeMQ8std+OUy/g24bfJx7YnLBg
 NkgCcBMd2cjpI4/WLXCti9hDwxXmT9oQcfo1f/cKQiVCNCiw0ar0sQhoCPRXu8K6ymLMRPD9f
 lJz2qR3dV47nb+yHd+LfboaeADyuChHxTVpT4jA1w+3P/VbYPky894EKQfokJ6cNvIt4gh+cC
 Tr7qRA53J4IVD2lZbzS6yHuO3UTeD4tFCWntiemCZrY4FPj5yAEeTOcH1Eln8iLCvok5IhXR/
 BEwyrnuU2Cxs23GCCzeJ5GlpzGUBGf28MckPl2r/FQ==
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

Am 06.04.23 um 14:46 schrieb Jim Quinlan:
> Regarding "brcm,enable-l1ss":
> 
>    The Broadcom STB/CM PCIe HW -- which is also used by RPi SOCs -- requires
>    the driver probe to configure one of three clkreq# modes:
> 
>    (a) clkreq# driven by the RC
>    (b) clkreq# driven by the EP for ASPM L0s, L1
>    (c) bidirectional clkreq#, as used for L1 Substates (L1SS).
> 
>    The HW can tell the difference between (a) and (b), but does not know
>    when to configure (c).  Further, the HW will cause a CPU abort on boot if
>    guesses wrong regarding the need for (c).  So we introduce the boolean
>    "brcm,enable-l1ss" property to indicate that (c) is desired.  This
>    property is already present in the Raspian version of Linux, but the
>    driver implementaion that will follow adds more details and discerns
>    between (a) and (b).
> 
> Regarding "brcm,completion-timeout-msecs"
> 
>    Our HW will cause a CPU abort if the L1SS exit time is longer than the
>    completion abort timeout.  We've been asked to make this configurable, so
>    we are introducing "brcm,completion-abort-msecs".
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 7e15aae7d69e..ef4ccc05b258 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -64,6 +64,18 @@ properties:
>   
>     aspm-no-l0s: true
>   
> +  brcm,enable-l1ss:
> +    description: Indicates that the downstream device is L1SS
> +      capable and L1SS is desired, e.g. by setting
> +      CONFIG_PCIEASPM_POWER_SUPERSAVE=y.  Note that CLKREQ#

not sure about this, but maybe we should avoid references to Linux 
kernel config parameter in a DT binding. Since the driver already gaves 
warning in case the DT parameter is present, but kernel config doesn't 
fit, this should be enough.

> +      assertion to clock active must be within 400ns.
> +    type: boolean
> +
> +  brcm,completion-timeout-msecs:
> +    description: Number of msecs before completion timeout
> +      abort occurs.
> +    $ref: /schemas/types.yaml#/definitions/uint32

According to the driver at least 0 is not allowed, maybe we should 
define minimum and maximum here and let dtbs_check take care of invalid 
values?

Best regards

> +
>     brcm,scb-sizes:
>       description: u64 giving the 64bit PCIe memory
>         viewport size of a memory controller.  There may be up to
