Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED186183BD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 17:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiKCQI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKCQH5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 12:07:57 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91738FD9;
        Thu,  3 Nov 2022 09:07:50 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B68C085141;
        Thu,  3 Nov 2022 17:07:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667491668;
        bh=a7iVPVhhf7PhIU9Rc3M+D5j8VdxLl3EFIQJV6RdzmuA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BcWfSNCLMSTE28o+Bjy1c3YzV9wRrqxWybH8QU4/9INFii9ZWEbOk8UZ13mfgOrWX
         IX7G1m2+3FsZU8xH7yZabrP5Vknnkh1ozMMO7moy5mJMC8wk/hzvx9qyad0OoAk8rN
         sRJIe2DAEHlt0RH6xfwyfbf+4MZqqJthXfqQ4ZNYTCx2uNIAcEZtEtyHnjRnQRkl7R
         Z4TX3vjg8lh1Sm/G/dawYPbVdFNU5ngVqr/mvkCinSzN45F0NUP+49A3cGTa7/DmLJ
         Zw1K/GVC6/v7hh+QS6uXaphFgdb+xUsuU8f+8TAAYQ3pRhv7yImKJA25tEZhM0obGy
         YnrNxBFsi13Mg==
Message-ID: <1a36babb-a18d-b189-1ed3-0dc03f50e997@denx.de>
Date:   Thu, 3 Nov 2022 17:07:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] dt-bindings: imx6q-pcie: Handle various clock
 configurations
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
References: <20221102215729.147335-1-marex@denx.de>
 <166744542553.1047593.11633766224075181622.robh@kernel.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <166744542553.1047593.11633766224075181622.robh@kernel.org>
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

On 11/3/22 04:24, Rob Herring wrote:
> 
> On Wed, 02 Nov 2022 22:57:27 +0100, Marek Vasut wrote:
>> The i.MX SoCs have various clock configurations routed into the PCIe IP,
>> the list of clock is below. Document all those configurations in the DT
>> binding document.
>>
>> All SoCs: pcie, pcie_bus
>> 6QDL, 7D: + pcie_phy
>> 6SX:      + pcie_phy          pcie_inbound_axi
>> 8MQ:      + pcie_phy pcie_aux
>> 8MM, 8MP: +          pcie_aux
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Richard Zhu <hongxing.zhu@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: NXP Linux Team <linux-imx@nxp.com>
>> To: devicetree@vger.kernel.org
>> ---
>>   .../bindings/pci/fsl,imx6q-pcie.yaml          | 74 +++++++++++++++++--
>>   1 file changed, 69 insertions(+), 5 deletions(-)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> pcie@1ffc000: Unevaluated properties are not allowed ('disable-gpio' was unexpected)
> 	arch/arm/boot/dts/imx6dl-emcon-avari.dtb
> 	arch/arm/boot/dts/imx6q-emcon-avari.dtb

This part is unrelated to this patch.

> pcie@33800000: clock-names:1: 'pcie_bus' was expected
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb

This and all the clock related goop should be solved by this series:

[PATCH 1/3] arm64: dts: imx8mm: Deduplicate PCIe clock-names property

Once that lands, this could land too without any errors anymore.

[...]

