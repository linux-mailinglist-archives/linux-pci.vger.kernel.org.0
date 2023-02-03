Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6B689EAC
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 16:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBCP6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 10:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjBCP6R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 10:58:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EB49EDE;
        Fri,  3 Feb 2023 07:58:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83D72CE3080;
        Fri,  3 Feb 2023 15:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E62C433EF;
        Fri,  3 Feb 2023 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675439891;
        bh=B0v19TuDLbFo7ycDTisQ9anANbQoVZOY4n4uT0Gjyd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kGQvmPLbYV8DDj4fVk/kdW7DucSZhFoIGuFykU16IX6b55kN1pxWl8JkxioL8U+DQ
         BHw41Ao+LyIM78qgqYWUiYsbnVHImQ+VldDORga0k7P1qcZPesZX40T4RVTiAr9kSh
         Rf0hlUk3znkq8tbDa6B0Yo1fkV6LnFTbHPNmJqFJ7h6wABoebtzfihiyn7zNdXLViQ
         DDY3vO1zvS8E0GPatmdDN4SNcWrjl2X2w8Fa/c6mxOqdaz/lDFAI7itb8CIGIhrzwH
         1kinCmOjL3rF2CIHRBLFA4JRdyxQhhRWbWeOlPjna+4bNNTfrnZGo55Bod+Bd9nPa8
         1ZyG5xXKKS1ug==
Received: by mail-vk1-f171.google.com with SMTP id s76so2772121vkb.9;
        Fri, 03 Feb 2023 07:58:11 -0800 (PST)
X-Gm-Message-State: AO0yUKUV5kFdJ9qXlUFsi9S9UUHAoUh0ngVGmqf2Iivi4SiCwBSjsfk4
        f3pq2VoNE4dv4gSmo88unILFeoFO3TN45T6EwA==
X-Google-Smtp-Source: AK7set/aXYETV7oOWFZoLHmTjN3D/bBV7EXM1cP6swru8v2XNM2wWlOKK9YHQNK90WRDw8drcqCI+iCc3mzIufRB9L0=
X-Received: by 2002:a05:6122:419:b0:3e8:551c:46f with SMTP id
 e25-20020a056122041900b003e8551c046fmr1608155vkd.19.1675439890571; Fri, 03
 Feb 2023 07:58:10 -0800 (PST)
MIME-Version: 1.0
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
 <20230203104822.361415-1-equu@openmail.cc> <20230203104822.361415-4-equu@openmail.cc>
In-Reply-To: <20230203104822.361415-4-equu@openmail.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Feb 2023 09:57:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKq1Yv+svKMS3R=TmDui1VJEjinoPFoDAAgr8tBbV1aSQ@mail.gmail.com>
Message-ID: <CAL_JsqKq1Yv+svKMS3R=TmDui1VJEjinoPFoDAAgr8tBbV1aSQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] wifi: ath10k: only load compatible DT cal data
To:     equu@openmail.cc
Cc:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 3, 2023 at 4:48 AM <equu@openmail.cc> wrote:
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
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 30 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath10k/pci.c  |  2 +-
>  drivers/net/wireless/ath/ath10k/pci.h  |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 5eb131ab916f..a776b06f49b5 100644
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
> @@ -1958,6 +1961,33 @@ static int ath10k_download_cal_nvmem(struct ath10k *ar, const char *cell_name)
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
> +            !of_device_is_compatible(ar->dev->of_node,
> +                                     "qcom,ath10k") ||
> +            !of_pci_node_match_driver(ar->dev->of_node,
> +                                      &ath10k_pci_driver)))
> +               return -ENOENT;

I think this can be done a bit cleaner and like other drivers. I see 2 options.

The first way is use VID/PID compatible strings and don't set the
of_node pointer if there is a mismatch.

If you must use "qcom,ath10k" (and 9k) only, then we should make
of_device_get_match_data() work on PCI drivers. This should just
require adding of_match_table ptr and it needs a data struct with a
flag saying use cal data or not.

Upon further thought, why can't you decide all this just on PCI
VID/PID? The giant switch statement in ath10k_pci_probe() could all
just be struct of driver_data from the PCI match table.

Rob
