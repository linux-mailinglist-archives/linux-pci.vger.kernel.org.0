Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33536D3C8E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 06:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjDCEuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 00:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCEuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 00:50:54 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B08A4A;
        Sun,  2 Apr 2023 21:50:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so13494341wms.5;
        Sun, 02 Apr 2023 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680497451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KmuBUFzQUjaxZVU+S/+mOcmOc0AOV31J3v1NKMouK28=;
        b=PGK/Fk4wYOsAWep6nEBI2HWHAGlmmQr9MHVl7DMSGeFoHAdU0dwbFTq9HO9wrXfLok
         HUULIuqfTTkJpJfQJa6vhojoVJnzzaCnp4StcdPc0oH+djaJXj+OK6J5XNsc99gjLUDB
         eAMV0TIIoDDkhm3s5ZrySlTZ8X9AxVFLLzPz8PGFe/Tv/yWdz9jnL+DTXafyU4kQnC8Q
         a8H0PInP4F6/AEd52TJkWlq4JKhhsC8gYUv8m5N/Gyur+swg2s2RqdQlNLYXpfwkuDAF
         d7CFcef+z3GNLRrW/TJtM+fGvyJ4HrFeN/vUFBAg7H0HIGagF+Bn6HaRlk7AhHNZcy7N
         oSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680497451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmuBUFzQUjaxZVU+S/+mOcmOc0AOV31J3v1NKMouK28=;
        b=P80FC3G4bhuv9A5AC9/fcAXFMVJZsxfGbtwsHxe82aD6o0wYhtMHDBGtVx7EzlYQs6
         9TBmmB8hMeRNuAFziJGDnPq3yh6BpgazuEyzaEaY/FpIAqRObXdzyx42DR1ux4OFtZkH
         g8gW/UGC4UKJLfMdTv0Ng99P+qcqrkzO8aPfuvZtl4MlKLcXXj62KW+lR77EFkFi78wx
         Pbwk+92lR4XEc/FIBXJW08x08AEQus8nkNf+RpeMBsblbNpI8FMy8gI1KQbZL4OzWhXv
         ho/PcuWtWe9ycGzEC8vpvGucwewMAQiHA3O0q+rAwV/LWnosSD3lphy1FQ/rHw/wgUjV
         0NHQ==
X-Gm-Message-State: AO0yUKVTgMbD5Dr7Ml+/tAo7NQKZSq5ROGohYGH6YK9NxRqb7aiHyrFY
        SkRilJZutXLmCWgIOGEzigE=
X-Google-Smtp-Source: AK7set8ZQ9YczPJ94tVG7x+s4l8T7g2se9y9PUJGHUMtSjgLZlVwkUZj0mxGW1e7LgB+9x+f4k0jOg==
X-Received: by 2002:a7b:ca4a:0:b0:3ed:d64f:ec30 with SMTP id m10-20020a7bca4a000000b003edd64fec30mr24501671wml.33.1680497450934;
        Sun, 02 Apr 2023 21:50:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003dd1bd0b915sm18158191wmq.22.2023.04.02.21.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:50:50 -0700 (PDT)
Date:   Mon, 3 Apr 2023 07:50:45 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     ye.xingchen@zte.com.cn, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PCI: mt7621: Use dev_err_probe()
Message-ID: <2e4f27f0-a4ac-4523-8f90-695a62973bd0@kili.mountain>
References: <202303231145121987818@zte.com.cn>
 <CAMhs-H_-kQ0FGP3L1xJ=ec_xJ59a2OztMLLjEQmQfYFOEa4DfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMhs-H_-kQ0FGP3L1xJ=ec_xJ59a2OztMLLjEQmQfYFOEa4DfA@mail.gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 23, 2023 at 07:23:26AM +0100, Sergio Paracuellos wrote:
> Hi,
> 
> On Thu, Mar 23, 2023 at 4:45 AM <ye.xingchen@zte.com.cn> wrote:
> >
> > From: Ye Xingchen <ye.xingchen@zte.com.cn>
> >
> > Replace the open-code with dev_err_probe() to simplify the code.
> >
> > Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > index 63a5f4463a9f..964de0e8c6a0 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -220,10 +220,9 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
> >         }
> >
> >         port->pcie_rst = of_reset_control_get_exclusive(node, NULL);
> > -       if (PTR_ERR(port->pcie_rst) == -EPROBE_DEFER) {

So the theory here is that -EPROBE_DEFER is recoverable but other errors
are not so we just ignore them?  Error pointers will trigger a WARN() in
mt7621_control_assert/deassert().


> > --
> > 2.25.1
> 
> Also, this is not a probe(), so I don't see a point of using
> dev_err_probe() here.

It's a weird thing to return -EPROBE_DEFER from something which is not
a probe function...  Someone told me I should write a Smatch check for
it but I never got around to doing that.

In this case, I guess the user is supposed to see the error message and
manually fix the probe order?  The dev_err_probe() will change the error
message into a debug message so the user will not see it and will not be
able to fix it.  So using dev_err_probe() will break things for the
user.

regards,
dan carpenter

