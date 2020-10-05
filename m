Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD923283168
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgJEIEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 04:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgJEIEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 04:04:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA2BC0613A8
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 01:04:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so4782760wre.4
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IeiNTBeAySgxF765tOCATEDwXLrm3RiAjoTBQHN6wK0=;
        b=QT2sz2z2T2ObbOF9cBuqPj/xMs2V2JkpGaC1yQPewHnLjCK6KfpJxnFBd52Yg4AGmP
         VJxRGRPxaRQLhLWf/cJj+4TFWIvc5S6rpMyihLW8guAo+UvNRqZKoELqvBpOePuA/Etp
         z293SdQf8ZGebrwCEz1gY7IlvwFjzz13UZb9UEwJiawxT5K21aKdmv/U8ZWx8aU8cdsz
         g1EJ2lezQTBEJzLkUS6vaHwbRc5HEANA2MQBDDgPE/harsOdRDrcIYwSmq3urQxn7+oQ
         VI6XlJwzca0RWlRBNRLXanZ5iKvZaicHTe2BxzY/5qO5xvvbJ/G2d1fmd5VfFwE503zT
         3Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IeiNTBeAySgxF765tOCATEDwXLrm3RiAjoTBQHN6wK0=;
        b=pCxwWAPl7P1PEGCivgPsvtxLlVxEwsdkFjKY9Tl5yFhn/yO9hrsV15O2hsOKZYg9Pl
         yMv7tbifQuHQP1JaqJTmkREkxD5x4ysk8CTW5U63xqkXLVusYVxywNeYyzGgW/EQfWw5
         XUJ37wv8fq8ktQFE6HHdNbCacymGdRPrUCfoA/QMGcX84/PaU50lriu5lLIDobCqw6M4
         sQaJK1TleXI1J6eyjON20Eu1HxRIPX9mAgtNZfkAoS/X6yJEEbrgoeMm4mEvjtM5setj
         ayvjZvEfAic2Y3XTHUm+L6hX2og3orZ/F8NHR/dx4jIkb1OxZHCLMx9dxUXDwCVYrav0
         pYdQ==
X-Gm-Message-State: AOAM5334QI+fix9dVKVqIL2EQ+0eWs+F3Cm2ymThTwbrCHuOlMdDACUq
        Z+wMqHZ1W+BMUdFtsZ6T72XlGQ==
X-Google-Smtp-Source: ABdhPJxB5n46P+iT3QRjzewwc6VgfO5oWkwQMA51B+oAEZSgUCF8P3GFXLcjkKteouHQRqUkrIZvVQ==
X-Received: by 2002:adf:f10e:: with SMTP id r14mr9419051wro.337.1601885092289;
        Mon, 05 Oct 2020 01:04:52 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id x2sm11899009wrl.13.2020.10.05.01.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:04:51 -0700 (PDT)
Date:   Mon, 5 Oct 2020 09:04:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Another round of adding missing
 'additionalProperties'
Message-ID: <20201005080448.GT6148@dell>
References: <20201002234143.3570746-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002234143.3570746-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 02 Oct 2020, Rob Herring wrote:

> Another round of wack-a-mole. The json-schema default is additional
> unknown properties are allowed, but for DT all properties should be
> defined.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-clk@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-spi@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: linux-leds@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> 
> I'll take this thru the DT tree.

[...]

>  .../bindings/mfd/gateworks-gsc.yaml           |  2 ++
>  .../bindings/mfd/xylon,logicvc.yaml           | 14 +++++++++++--

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
