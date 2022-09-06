Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5775ADC47
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 02:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIFATY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 20:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiIFATX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 20:19:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56745C14;
        Mon,  5 Sep 2022 17:19:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o126so782510pfb.6;
        Mon, 05 Sep 2022 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=v4JA0M0hCIbFC7NXFN+IygsKVK4ZMU4qWYqYqoR4tJc=;
        b=fHHlrsomzS5RX1w3UIei5qFtxTClmy9iSQEvGb1yFamLQYZo+o6zDJ8zJUVbJLL82Y
         pkr7UJu0RGPOf+0J7r9ut0astM8MHGg1EaaL+qlGu/ue2aBOikrSmX+DoJq6OVnfYCTQ
         FMcozHAuaegI9kVFEFk5BCS8NUELgRVLurFlc4zQR+4mEluidRXNcvb1Uq6r9730CALq
         i+o2Z457eW9sgjxUmvKSOZs27VXpd+EYrVSuTXtKTDhoWiowlHQASX22DQpd3afScQaO
         NjyzcFcZoXy1i9cNJaiHRj8JaHrrDq+3JIoFmZc3azTXuJLuoblV3/wMiYnfYqdVD2x3
         dUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=v4JA0M0hCIbFC7NXFN+IygsKVK4ZMU4qWYqYqoR4tJc=;
        b=1+/5jNNCtN2Fcbg7pa+Qn/ASzRvEJrQL10qk+VIX4yxA73AmUf3kGFqwy67432klT+
         xI8H0pD7o2ehXiLaGzu1EbGJDhLIOVJa+pgCjPROUcBeAn5O6xhx2lfpjdWBK6tjUp8X
         96WY+LDvoHHWl1avLrqsFV79rW8Cdx2ZVmgmCEe852dzNaaKUUdfMH/bMfcPBeyibutS
         JVb2DPHW0NkXJq/hdYPVFDm0/oUWgZt+j9ceBnY/9sTXmfOib7HBi4/4WQci5KFVRK4f
         QCl8bdsvVAV2uvVTXbNAZKydZesxAdqYCx7hDCA5YCSMS3Fy5wneVBEhLblQISGolQeu
         d7+w==
X-Gm-Message-State: ACgBeo18iFOHzHPbVoCq6ZcjBkFQfj/7YMbXiSussqZwsqA2g7flFT3a
        8iaXhHR3W2O+9ens/wL9qkQ=
X-Google-Smtp-Source: AA6agR6BSwkY2FCM/mxUqmLHetzPYwEnkn1n9g0P2sCyTVfQpw3+hUsDHc+Gpjiwldy8UpbPbUcIag==
X-Received: by 2002:aa7:88c8:0:b0:536:926:700f with SMTP id k8-20020aa788c8000000b005360926700fmr53349294pff.72.1662423561657;
        Mon, 05 Sep 2022 17:19:21 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id c10-20020a624e0a000000b0053e156e9475sm431528pfb.182.2022.09.05.17.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 17:19:21 -0700 (PDT)
Date:   Mon, 5 Sep 2022 17:19:17 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 07/11] PCI: apple: switch to using
 fwnode_gpiod_get_index()
Message-ID: <YxaSBRkAG/hKjFol@google.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
 <20220903-gpiod_get_from_of_node-remove-v1-7-b29adfb27a6c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-7-b29adfb27a6c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 04, 2022 at 11:30:59PM -0700, Dmitry Torokhov wrote:
> I would like to stop exporting OF-specific gpiod_get_from_of_node()
> so that gpiolib can be cleaned a bit, so let's switch to the generic
> fwnode property API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index a2c3c207a04b..d83817d3ff86 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -516,8 +516,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	u32 stat, idx;
>  	int ret, i;
>  
> -	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
> -				       GPIOD_OUT_LOW, "PERST#");
> +	reset = fwnode_gpiod_get_index(of_fwnode_handle(np),
> +				       "reset", 0, GPIOD_OUT_LOW, "PERST#");

Hmm, I am looking at the driver and it leaks the reset gpio on
unbind/unload. I guess it does not matter in practice, but still nice
not to leak. Thankfully it is easy to cure by switching to devm option:
devm_fwnode_gpiod_get().

I'll send and updated patch with a new justification.

Thanks.

-- 
Dmitry
