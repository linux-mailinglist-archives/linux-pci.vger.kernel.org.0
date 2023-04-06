Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF5F6D9CE0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 17:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjDFP7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 11:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbjDFP7j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 11:59:39 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684BE93E5;
        Thu,  6 Apr 2023 08:59:38 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqZE0-1qF5wU46Vs-00me6o; Thu, 06 Apr 2023 17:59:19 +0200
Message-ID: <09926d3d-2f1f-d060-af0f-bbc5b02d3664@i2se.com>
Date:   Thu, 6 Apr 2023 17:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 3/3] PCI: brcmstb: Allow setting the completion timeout
Content-Language: en-US
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
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230406124625.41325-1-jim2101024@gmail.com>
 <20230406124625.41325-4-jim2101024@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230406124625.41325-4-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7gXUYGdfhQIK9uebKjhJEUnRpA3eeSFswJBEbOwfcfGijEp9h2x
 z1lakDXPhXuNg/wRcxexlOKzc5GolTKhAob87T6Gwg6Z/y21LCNnwAykUxJ0NoBgwthlDPE
 itukKU4n2b14MtSC7Vrh+mCASBh7o0MNPq8SZaV8r5cBwMfpDiy6JEZAtDPbxjFoDq3eSbQ
 RNq0UWUGiVkVyLijzXWCQ==
UI-OutboundReport: notjunk:1;M01:P0:aMhb1Zdku4o=;m+dr8A/uTHOyFf6FH5bhby+2p8v
 nkjmDfcvrOGb7aSnV8OrZG9ftY9fsGeYAjfB6wQEYo92ooHAKTZdfpsWn+lilPFZ4Wp/qZVBw
 CcfmKpQ6r4i9MgbxKZdBpT161fU/U8dUDziXjtnxGRtEKvMaN4dmZls6+NgGJZ9lAS6eGwdA2
 kzi+4Oo+EMk3+O9/D67rwKs3N91zTtdKygvLRBvp+/dgl6wgMhckD57QdjPeA8ocXiE2j1Zlx
 nDAWJZxe7x/vbBs8kB/CsOj2ka1CAAhgwzYwFBs9VZEQ0IbLNt2Jk/Xh4RyfaS1WQB6/enjJc
 rs5QkeptjwDRPOOYYURy8zGH6CfNoDEtkwJKcgu9fkvbdpbV3Yikw4iOObvJ1Vr7b4zU2tmn9
 3uRyVBMv5MR7LRFA+WTIp+YwfxqfMvipJ1dJtRX94j5LYgbopVKiSbSRn8HJvzHZK5+0lKjQL
 /fL6JwPJNc8Qw6FIX5IDvYFxDUDWf1Biw+fHCrQaiXiN2pv0zfLcGTsf/zqmmTvQ7QR+9iYy2
 R8GAlcniKzKib0BIwBaI93VsjJflj83hk+Hok3yn0JMi9Aw8zQo4CjS72oK+XJnjSB3jNWW3U
 FgIv+APsnHCuoWDOEwIfLeVaWUENSuk0U2Fgu65fJ46J5Vz4eKM9SKOVoIhHcWRftG1KkGd2a
 NsYwqnNorvWc7cAhF8hhCVXBRQdcL548Y1n4CqdtuA==
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
> Since the STB PCIe HW will cause a CPU abort on a completion timeout abort,
> we might as well extend the timeout limit.  Further, different devices and
> systems may requires a larger or smaller amount for L1SS exit.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>   drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 129eee7bdbc1..92d78f4dfaae 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1080,6 +1080,29 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
>   	writel(clkreq_set, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>   }
>   
> +static void brcm_config_completion_timeout(struct brcm_pcie *pcie)
> +{
> +	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
> +	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
> +	u32 timeout, timeout_msec = 1000;
> +	u64 tmp64;
> +	int ret;
> +
> +	ret = of_property_read_u32(pcie->np, "brcm,completion-abort-msecs",
> +				   &timeout_msec);
> +
> +	if (ret && ret != -EINVAL)
> +		dev_err(pcie->dev, "bad 'brcm,completion-abort-msecs' prop\n");

i'm not sure about the error behavior. If we want to proceed with 
defaults in such a case, i would make this a warning and mention the 
used defaults.

> +
> +	/* Each unit in timeout register is 1/216,000,000 seconds */
> +	tmp64 = (u64)216000 * timeout_msec;
> +
> +	/* Clamp the requested value before writing it */
> +	timeout = tmp64 > 0xffffffff ? 0xffffffff : tmp64;
> +	timeout = timeout < 0xffff ? 0xffff : timeout;

Personally i'm not a huge fan of silently clamping wrong DT values.

Best regards

> +	writel(timeout, pcie->base + REG_OFFSET);
> +}
> +
>   static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   {
>   	struct device *dev = pcie->dev;
> @@ -1110,6 +1133,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   		return -ENODEV;
>   	}
>   
> +	brcm_config_completion_timeout(pcie);
>   	brcm_config_clkreq(pcie);
>   
>   	if (pcie->gen)
