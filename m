Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7AA5AF728
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIFVll (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIFVl3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:41:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F09CCE1;
        Tue,  6 Sep 2022 14:41:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pj10so2203717pjb.2;
        Tue, 06 Sep 2022 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=KXWoT9EuSbOt9nePjiUUdf0oshHpDWDtGCi8pF2h50U=;
        b=L/ZW1aQIc7XbaIj/P2WsdtKQeUZstgyo46isMATHBR3E3MqQvPC7yPtIVGzFDYqqqx
         6EFL5KIgCXLe6zm1oKyQbiHxz5YDJvct4VS1H0VYbBJ7Csil4/yKKvQ08PljHOlG2XEC
         kFRMbcYNIfwum6pp6BgryfSBaof3oNoRry95NgzwDMvTtjh5LFV9iVWYDOoLHYwOxOmc
         BC6hDD32EFH4+Wvi9LLzMOfL4Io0jLT3E9zJ0YfBquFpfR78RXBt0M7TFnTpU2MsxACy
         ygOJqCRZZslXIbA50dkkY29KCBmu5hpHV4mQBpWf5lg2ddoB8toR23cEZrX/RrJ58G/m
         yS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KXWoT9EuSbOt9nePjiUUdf0oshHpDWDtGCi8pF2h50U=;
        b=u35zl9QSgchMzhwLuMNbZmFL8x86vxep42EsIpOCpQ6xy2k/kNv+1ka+OUphdyNsnZ
         E15ZPgWHkIiwL9uXqu3n1atnKOi15Arc65/Ftaey8BwfnEXzvgS6MQ3RmsqL+gC1TnoP
         wVKnue15ohpnGl4HzHmoTGLtg3W1/sljFKryrFl284d3XG2KtpOnotM52AL3XWteufx8
         5W8HB5EnieGyFyB2PCvc46ikk6gSqTNBRY82nxqKI+7mcFfh7CQSV+r799v9lZo3PrYS
         cpOnenX8TKlFOhC7vH9Q2RFcxua8FRrlOgK/OaFaQWe0RkOZ5w91tEsix/IJjOdAOt9c
         E5Aw==
X-Gm-Message-State: ACgBeo3hCw6LdQJo++SsO/pWe4LcXA52pVYcO6vDTNdr5RnjsFDdr02A
        aspcHFgTqhOcbfCARizFHf8=
X-Google-Smtp-Source: AA6agR7xRMfCeJ8pXahcgMxPoFOWsnEGzC98sW+t/jWKHmRwoTPEsvKLL1qsbs4pGkus/FeiFWqGog==
X-Received: by 2002:a17:903:248b:b0:172:a790:3206 with SMTP id p11-20020a170903248b00b00172a7903206mr465623plw.139.1662500483979;
        Tue, 06 Sep 2022 14:41:23 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709027b8d00b0016c0eb202a5sm10392565pll.225.2022.09.06.14.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:41:23 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:41:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: histb: switch to using gpiod API
Message-ID: <Yxe+gPl5qeqJuC4Z@google.com>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906210811.5kzdq66eeeauk2d3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906210811.5kzdq66eeeauk2d3@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 11:08:11PM +0200, Pali Rohár wrote:
> On Tuesday 06 September 2022 13:43:00 Dmitry Torokhov wrote:
> > +	ret = gpiod_set_consumer_name(hipcie->reset_gpio,
> > +				      "PCIe device power control");
> 
> Just unrelated thing, I know it was there before, but I saw it just now
> and have to comment it: This is absolute nonsense name. "reset-gpios"
> device tree property specifies PERST# signal pin (PciE ReSeT) as defined
> in PCIe CEM (Card ElectroMagnetic) specification and it has absolute
> nothing with PCIe power control.
> 
> My suggestion for maintainers would be to remove this critic name at
> all as it would just mislead other people reading that code.

I can respin the patch is you suggest a more sensible label...

> 
> > +	if (ret) {
> > +		dev_err(dev, "unable to set reset gpio name: %d\n", ret);
> > +		return ret;
> >  	}

Thanks.

-- 
Dmitry
