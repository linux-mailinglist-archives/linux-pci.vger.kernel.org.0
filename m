Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A992F690DFB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 17:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBIQJ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 11:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBIQJ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 11:09:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B54C1D;
        Thu,  9 Feb 2023 08:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B970619EE;
        Thu,  9 Feb 2023 16:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058BCC4339B;
        Thu,  9 Feb 2023 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675958961;
        bh=0M/80MVd16v9rBzSC03ir0k/yTUZTebVxlTZPrgIvNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d/NQIopcyTOmfXh0Oe5f9loEh9fWJBEN7zdyfNum9bv9Cn/azjJTEqIeTlI/RfBt5
         3rrN6Md9mErpOWka1J7AXprUCkfEQq9e7Vv7lm3enNfTPaS9rsQPlgzv7qyHqhUiF5
         KMVVZG4aAN2/TDkSI278bd34zuEoa9YWb1rkp6m2IVyPAhDHNAnMGRfh3h361mLMGk
         WcW6NnSEbVAydeL/NKId2E5zFPjv5EwufXJaxphGdg+jtO1tV8PVttElQzPGK2w0pD
         aXX8tsXyRdhsF3/DQTaEaEKJSBjlMfJdmMtER1xe0LKxr6JqhHM/fmLrwJjq/WNNzn
         NmW5u1O3YwuJA==
Received: by mail-vk1-f172.google.com with SMTP id i38so1205352vkd.0;
        Thu, 09 Feb 2023 08:09:20 -0800 (PST)
X-Gm-Message-State: AO0yUKUTxsNsGo+XbxfW0Z9yby5lbB4tlrxQVL3qjHsmPa5egyS/d5+A
        HjcYuAngdF4QljG6ig2ahxzKbx3Xn67WtA2kng==
X-Google-Smtp-Source: AK7set9aPL1yHxtKO96ECAzw2gdVVnMz0shz/0LHQsodjryYcX0FU9j1ko12Gj4Tl1fgXZ7dNENAWxvgLOC/dD7HRvA=
X-Received: by 2002:a05:6122:1461:b0:3d5:d30f:81c2 with SMTP id
 r1-20020a056122146100b003d5d30f81c2mr2315587vkp.14.1675958959955; Thu, 09 Feb
 2023 08:09:19 -0800 (PST)
MIME-Version: 1.0
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc> <20230209045026.1806587-4-equu@openmail.cc>
In-Reply-To: <20230209045026.1806587-4-equu@openmail.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 9 Feb 2023 10:09:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKTRqaROZh416TBMmfEpYLbfa3ejwhe8+ryDecPthQ6Ew@mail.gmail.com>
Message-ID: <CAL_JsqKTRqaROZh416TBMmfEpYLbfa3ejwhe8+ryDecPthQ6Ew@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] wifi: ath10k: only load compatible DT cal data
To:     equu@openmail.cc
Cc:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 8, 2023 at 10:51 PM <equu@openmail.cc> wrote:
>
> From: Edward Chow <equu@openmail.cc>
>
> ath10k might also be sensitive to the issue reported on
> https://github.com/openwrt/openwrt/pull/11345 , loading calibration
> data from a device tree node declared incompatible.
>
> ath10k will first check whether the device tree node is compatible
> with it, using the functionality introduced with the first patch of
> this series, ("PCI: of: Match pci devices or drivers against OF DT
> nodes") and only proceed loading calibration data from compatible node.
>
> Signed-off-by: Edward Chow <equu@openmail.cc>
> Reported-by: kernel test robot <lkp@intel.com>

This is for fixes created as a result of kernel test robot report.
Reports on your broken patches should not have this.

> ---
>  drivers/net/wireless/ath/ath10k/core.c | 31 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath10k/hw.h   |  4 ++++
>  drivers/net/wireless/ath/ath10k/pci.c  | 18 ++++++++++++++-
>  drivers/net/wireless/ath/ath10k/pci.h  |  2 ++
>  4 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 5eb131ab916f..4c9e8140aeff 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -13,6 +13,8 @@
>  #include <linux/ctype.h>
>  #include <linux/pm_qos.h>
>  #include <linux/nvmem-consumer.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
>  #include <asm/byteorder.h>
>
>  #include "core.h"
> @@ -26,6 +28,7 @@
>  #include "testmode.h"
>  #include "wmi-ops.h"
>  #include "coredump.h"
> +#include "pci.h"
>
>  unsigned int ath10k_debug_mask;
>  EXPORT_SYMBOL(ath10k_debug_mask);
> @@ -1958,6 +1961,34 @@ static int ath10k_download_cal_nvmem(struct ath10k *ar, const char *cell_name)
>         size_t len;
>         int ret;
>
> +       /* devm_nvmem_cell_get() will get a cell first from the OF
> +        * DT node representing the given device with nvmem-cell-name
> +        * "calibration", and from the global lookup table as a fallback,
> +        * and an ath10k device could be either a pci one or a platform one.
> +        *
> +        * If the OF DT node is not compatible with the real device, the
> +        * calibration data got from the node should not be applied.
> +        *
> +        * dev_is_pci(ar->dev) && ( no OF node || caldata not from node
> +        * || not compatible ) -> do not use caldata .
> +        *
> +        * !dev_is_pci(ar->dev) -> always use caldata .
> +        *
> +        * The judgement for compatibility differs with ath9k for many
> +        * DT using "qcom,ath10k" as compatibility string.
> +        */
> +       if (dev_is_pci(ar->dev) &&
> +           (!ar->dev->of_node ||
> +            (of_property_match_string(ar->dev->of_node,
> +                                      "nvmem-cell-names",
> +                                      cell_name) < 0) ||
> +            !of_device_get_match_data(ar->dev) ||
> +            !(((const struct ath10k_hw_misc_flags *)
> +               of_device_get_match_data(ar->dev))->need_calibration) ||
> +            !of_pci_node_match_driver(ar->dev->of_node,
> +                                      &ath10k_pci_driver)))

That is just plain ugly and not understandable. Why do you still need
of_pci_node_match_driver()? If compatible using VID/PID doesn't match
the actual VID/PID, then you should never probe.

The prior explanations didn't really clear things up either. I'm
really at a loss as to what are the scenarios you need to work. Please
enumerate what are the different scenarios of what's in the DTs and
how you need the kernel/driver to respond.

Rob
