Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338AC4C917B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Mar 2022 18:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiCAR3J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Mar 2022 12:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiCAR3I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Mar 2022 12:29:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DE50447
        for <linux-pci@vger.kernel.org>; Tue,  1 Mar 2022 09:28:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so1680393wmb.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Mar 2022 09:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y86hBfPWj9E4aTo+XMBrAu6Y5p4SQMawkPD4Q/SuKPY=;
        b=ifR445Ptk0kZIwyK/iR5LauUeexT4h+Xm5fWIS9UfHsJTwIXI+TBUH0b1B1nklV58Q
         e3posB9tDmWAuXNqOByYa8OEIeuEgFpyIkDoWKkxe1RAiCnFE6ZEzQVCpMvS62fGzNFV
         nWcw5JV2lmoD9jxvmDMFuNVsgy/NwYWUQ6a0I1zB2e5jSr3/JFEIp9xW/NRIDhtT+/y6
         uvAB7/5ZICC2qcmaHb2EAlpVYU+L8My5syB7aELi6iajmzjea09g2vNncJq3GY6hv/nP
         g2d17hu4ZYUIRYCXpyuRUhAY/Kr9r3k7MyrtDEVfLOZZZFWPJ239r6w7DpTzLNolCHHw
         A62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y86hBfPWj9E4aTo+XMBrAu6Y5p4SQMawkPD4Q/SuKPY=;
        b=V0eUKeyIVZSl07QCGrpgDgugW5Fip7v6bKtO/Eh9ZxfmQN57OoFAQDAcF/dX+IXOfS
         yiJ3pAdiL/Ev8XPmcHYJoa/gvSc76jqlcbvCnSktqYlAjj3tY8ysIZ97yrQpxJZm4kW3
         TDHFAzM369QhXqPSZ0JZAih00r+vUEK+y1G9ldhjcTTJFWoVmG51mlFcFZJnUfTzo8Bf
         n4KtvwY5O8MWmWhFXZM6/gpGPl94EEOuGLgmtzdgZZ1bzPvOx1QYEoWHo43ziG5iEGal
         kv4Pqt5zmxq2BFBeSUOd+vYHjTwhOGk1AmmeoRF8EuS9oJ8XH6yzplKyGjFJvmCOR3gG
         eknQ==
X-Gm-Message-State: AOAM532yz3S+9u6E/9m9m1chgEG3i74p6vzfy4kVX3phslZJdpXXtnrs
        v/j1cLExcEtwTgJis3H+/Y6EMw==
X-Google-Smtp-Source: ABdhPJyP4zzjkBPeDrhk1IU4HHA4Z4mVRSeyWw7DiZ4BmjKx+FbF6/CkwhxttMvqrC0XO+mqNoqKvQ==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr18173339wmq.139.1646155705687;
        Tue, 01 Mar 2022 09:28:25 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id c4-20020adfed84000000b001e5b8d5b8dasm20457807wro.36.2022.03.01.09.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 09:28:24 -0800 (PST)
Message-ID: <5f481315-021c-39d6-8c6c-91918851ab13@linaro.org>
Date:   Tue, 1 Mar 2022 17:28:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 10/11] slimbus: qcom-ngd: Fix kfree() of static memory
 on setting driver_override
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, stable@vger.kernel.org
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
 <20220227135329.145862-4-krzysztof.kozlowski@canonical.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220227135329.145862-4-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 27/02/2022 13:53, Krzysztof Kozlowski wrote:
> The driver_override field from platform driver should not be initialized
> from static memory (string literal) because the core later kfree() it,
> for example when driver_override is set via sysfs.
> 
> Use dedicated helper to set driver_override properly.
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 7040293c2ee8..e5d9fdb81eb0 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1434,6 +1434,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
>   	const struct of_device_id *match;
>   	struct device_node *node;
>   	u32 id;
> +	int ret;
>   
>   	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
>   	data = match->data;
> @@ -1455,7 +1456,17 @@ static int of_qcom_slim_ngd_register(struct device *parent,
>   		}
>   		ngd->id = id;
>   		ngd->pdev->dev.parent = parent;
> -		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
> +
> +		ret = driver_set_override(&ngd->pdev->dev,
> +					  &ngd->pdev->driver_override,
> +					  QCOM_SLIM_NGD_DRV_NAME,
> +					  strlen(QCOM_SLIM_NGD_DRV_NAME));
> +		if (ret) {
> +			platform_device_put(ngd->pdev);
> +			kfree(ngd);
> +			of_node_put(node);
> +			return ret;
> +		}
>   		ngd->pdev->dev.of_node = node;
>   		ctrl->ngd = ngd;
>   
