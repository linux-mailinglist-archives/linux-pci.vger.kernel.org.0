Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A45055F2F8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 03:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiF2Bue (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 21:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Buc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 21:50:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F92C651;
        Tue, 28 Jun 2022 18:50:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x3so25436049lfd.2;
        Tue, 28 Jun 2022 18:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2w9yITAaJAoni3UIR7rb0uRelKGjMKmP4oiTkgm1Us=;
        b=IdLjdXB5OIHZgJYCVy+52cMP0i6YSeugVpYxrqZnmn0YNcq9UPmWBEz6dDRTgrJ+zS
         MK/PxSbmwM4uoZd/QjmXdSx20rI2flxrvCigehD0TDnPT9LiYwBpRXicsSmijfU9AMdI
         I8zaz6OUO6IrHuMxMgho7HUkjZZTfKPNP0cT38HBR4dgCqPI3cbGfHUSCTqPq7qdzzQG
         yK/75BnWkl8/pXLyGVlCuwXEWB1A4Wke4kX/dqs7bYvhsMpeO6OITw/RfLjJFONhCwOH
         xK+Tn6mMwlxcQIGif+uA6reD6zi7rQKjxd6z356pYpk8NEgxud7KIlPYIuorSO06D+IP
         ibrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2w9yITAaJAoni3UIR7rb0uRelKGjMKmP4oiTkgm1Us=;
        b=6ypY9SI9F/RK5i2FFIM59MRI7R2+NlWRyVb0H12NArWAyNY7WQA9LzEFLlBdQRojF6
         BG9JA/AvqgbhZE/SpiGPR+6OyGaMzsUwEC4VLkTLQgXam7xhAc1vIslIDg546b+kMCNX
         9l13fYT8+wfxWg4z8lUrZ16XTkJzTQUMueCz1O24E8CU62WVfa8ZM2kc4/LczjRe0mJM
         cJIV9BAR2TbTgKcbdufoOTpe5gA9rz+97gruMHbIJX9IwHjWun0fnN0DcKp95iXJEkd7
         11llLZAzQ80PYx5ve0sqdnGktPDSctc32tnwwdPv4PSBGKWKCHgQk9ip2741i7RPwDqV
         H9kg==
X-Gm-Message-State: AJIora8QJRXK1fm1JsNZKPF2e7pLAZT5NyeGpUcfHOjTTFS8Utmaak7+
        jOSyBCtl9Fi9Nmz83tfmQvg=
X-Google-Smtp-Source: AGRyM1vgme3elnvrZrywk1sPcmcyOdeOVKXGkRWc+Aoo6j+nfeIIY5zpbBdRnWw/iS4zgrMwRMNYTA==
X-Received: by 2002:a05:6512:3f6:b0:47f:6dff:dab9 with SMTP id n22-20020a05651203f600b0047f6dffdab9mr488014lfq.645.1656467429742;
        Tue, 28 Jun 2022 18:50:29 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25f07000000b0047f5d390926sm2402673lfq.94.2022.06.28.18.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 18:50:29 -0700 (PDT)
Date:   Wed, 29 Jun 2022 04:50:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/17] dt-bindings: PCI: dwc: Add max-link-speed
 common property
Message-ID: <20220629015026.6vnfuxlkyd6db3la@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-5-Sergey.Semin@baikalelectronics.ru>
 <20220615145550.GA1069883-robh@kernel.org>
 <20220619142720.tzfgefunvf3kirul@mobilestation>
 <20220628121540.oilmolkhqa43tf4e@mobilestation>
 <CAL_Jsq+N=HD78j7MZ2UXbfr36ozg-+kjZaoENSXr1M1qhJMmXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+N=HD78j7MZ2UXbfr36ozg-+kjZaoENSXr1M1qhJMmXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 08:56:38AM -0600, Rob Herring wrote:
> On Tue, Jun 28, 2022 at 6:15 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Rob,
> > Could you please get your attention back to this this thread?
> 

> I'll get to it. I'm catching up from a week of vacation.

Ok. Sorry for bothering.

-Sergey

> 
> Rob
