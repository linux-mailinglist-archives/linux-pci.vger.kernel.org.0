Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90176F4FEA
	for <lists+linux-pci@lfdr.de>; Wed,  3 May 2023 08:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjECGHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 May 2023 02:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjECGHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 May 2023 02:07:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3530FC;
        Tue,  2 May 2023 23:07:05 -0700 (PDT)
Received: from [192.168.1.141] ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mt7Pt-1qDOfW1TYX-00tSA7; Wed, 03 May 2023 08:06:39 +0200
Message-ID: <db172ecd-879b-b35b-2f02-e63dd9c956e2@i2se.com>
Date:   Wed, 3 May 2023 08:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/5] PCI: brcmstb: Set PCIe transaction completion
 timeout
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
References: <20230428223500.23337-1-jim2101024@gmail.com>
 <20230428223500.23337-4-jim2101024@gmail.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20230428223500.23337-4-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gnrDjcKlfBr0L+0fOTOP1uduDiw1yquGKRWBhEpzG7pTV2fVczr
 MNTrh9QtKRUVtct8tAFCQlIASxZztS4A7x+z2RNMtIcux43judTCglG3PxslB5vNrIsNhNS
 cFQQpYeNUB55FMM7rhU+1vH68Ipdd0qQCQL1z+IhfdinelgRJWTrkuNqUI1VGIwp45pSDrY
 CZBOF3Ctu89Kwnoz1QCjQ==
UI-OutboundReport: notjunk:1;M01:P0:3UPmeLQFCrc=;+zKSJqET7Y1yJ5TjBDYq2g1buPG
 LybJqOMIYJ8HT/PCJllN0towuK/oD03NoE1UhXrfJ57vj+/zmFm4/lCggh+IUEVSirju7UvXr
 D/U4glU1SxnIYlgopS7QlTYojYUzQEvNbW3hMAF3GbDiBVZU/1hlrrIDUZgkCYwy2N9WhXhys
 5++78rekHhK5g/noLmpfWR8+LsHXdC4jbCZOjZ3iCWAlqe8u9smStJU8Lpd0R45YFQlISrlfE
 d4Qg5hXogFpyx/qYB1e65oDvnGhX0ntsK1JcNeNZe3LLYRYbwgcuc1KWmgBoTXtpBGizCvlK1
 jWfFjtBFvMDqWjsw+Nxk/Oo0Q7rUBNOvHlRSvsGg16uvyLH8CO6pg2HKLyCKA0/oZok5PI8gA
 FAeE61zSN1uYB+dr5VKf3zV918jN2lRp1QvDwAlUi7Oq/OFfta7jLZeprnC+eStq7K9MnZlfB
 4zbAr2+0Z0itxZCob6QDhB7fZRXMXkuDwu3KrAM0VHFG6Sy9i4RkJuO6J7zXdDo96PnS65eHo
 7pWudPn4bPQ98mlemtALIDrEMNVcPAwCdi2290kIMV2NBoPE1KJ59097O2T010hM3mAOo3G7s
 Ah8Lq98f3aO6KE+kKvRtV36MuOZJAyo8XNv1bGWfDJ6NaPaCTAgSqtLQTV/DwTbohHT6rUwYc
 in3ZMlhN5jSspbfcIxggJoJQo1piZNOMoqzZS+HOrw==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

Am 29.04.23 um 00:34 schrieb Jim Quinlan:
> Since the STB PCIe HW will cause a CPU abort on a PCIe transaction
> completion timeout abort, we might as well extend the default timeout
> limit.  Further, different devices and systems may requires a larger or
> smaller amount commensurate with their L1SS exit time, so the property
> "brcm,completion-timeout-us" may be used to set a custom timeout value.
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>   drivers/pci/controller/pcie-brcmstb.c | 30 +++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c4b076ea5180..c2cb683447ac 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1080,6 +1080,35 @@ static void brcm_config_clkreq(struct brcm_pcie *pcie)
>   	writel(clkreq_set, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>   }
>   
> +static void brcm_config_completion_timeout(struct brcm_pcie *pcie)
> +{
> +	/* TIMEOUT register is two registers before RGR1_SW_INIT_1 */
> +	const char *fmt = "brcm,completion-timeout-us clamped to region [%u..%u]\n";
> +	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
> +	const u32 timeout_us_min = 16;
> +	const u32 timeout_us_max = 19884107;
> +	u32 timeout_us = 1000000; /* Our default, 1 second */
> +	int rval, ret;
> +
> +	ret = of_property_read_u32(pcie->np, "brcm,completion-timeout-us",
> +				   &timeout_us);
> +	if (ret && ret != -EINVAL)
> +		dev_err(pcie->dev, "malformed/invalid 'brcm,completion-timeout-us'\n");
> +
> +	/* If needed, clamp the requested timeout value and issue a warning */
> +	if (timeout_us < timeout_us_min) {
> +		timeout_us = timeout_us_min;
> +		dev_warn(pcie->dev, fmt, timeout_us_min, timeout_us_max);
> +	} else if (timeout_us > timeout_us_max) {
> +		timeout_us = timeout_us_max;
> +		dev_warn(pcie->dev, fmt, timeout_us_min, timeout_us_max);
> +	}
> +
> +	/* Each unit in timeout register is 1/216,000,000 seconds */
> +	rval = 216 * timeout_us;
> +	writel(rval, pcie->base + REG_OFFSET);

i don't think "int" is the proper type for rval here

> +}
> +
>   static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   {
>   	struct device *dev = pcie->dev;
> @@ -1110,6 +1139,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   		return -ENODEV;
>   	}
>   
> +	brcm_config_completion_timeout(pcie);
>   	brcm_config_clkreq(pcie);
>   
>   	if (pcie->gen)
