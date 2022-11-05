Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE861D7E8
	for <lists+linux-pci@lfdr.de>; Sat,  5 Nov 2022 07:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiKEGZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Nov 2022 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEGZM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Nov 2022 02:25:12 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B849813F1E;
        Fri,  4 Nov 2022 23:25:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id b124so7292669oia.4;
        Fri, 04 Nov 2022 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6AE3y29509hLMsGDmKEJpwzl8TMTLwTBza5239RAscQ=;
        b=AUx2N1nbtsFMiWYIlO/6Y0D3ZQlXcMrcbtiRnZWA9ZFE78KapFuKDiYmC62PRk+vr7
         74Ka/Ob07tg7d6e7kdJyrFduSbMUh1XG4h/RqH0Lplb+d8QGphPCQkSfIgTWMcL1H7O4
         G63wO2aKGXfJRdKTnxWrt6qLkTIpx5mtCoyGaZSQB+1qZTSj8dqlxMnr2iqdj4hG+aau
         cj0096rvvIjYJvIGL+FaWFqHpvfWbAFBwe1qC8HEx3Fmskg9rCXFQn5uAaE25w+ZWP5X
         IMRuRlAgL0RZ7gWsQm7fcPXjA0Z7gpqKuThqAix+2ZCkPIt24+u33BnIS5Q5u/x848on
         Swlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AE3y29509hLMsGDmKEJpwzl8TMTLwTBza5239RAscQ=;
        b=GVsSNEmD2CZXD7xcb8QVNVxRX9Biy5bIwka4J/Wkz7474omvgDL5YJ4NhUdELpDXpX
         V3fpYEMGNV6HxNLsIrcfKEEkmGdtFdvVj+LEDKJ8U3SoJUPpfsWokQRKX55SVWo7x5f+
         XpdqrCUXyCS/VnJZQmVD6MKQ9YWR9kPqHri6J6hlaYW6UHEmZ0bKzy7UIDE6QmRUSFG/
         8brttk6LJBjvgx5jOlL1W3owNh76GhhFxzudiL5gMAYsd4EDGWx3aXhU1cC4XK1RBj1v
         vtrfx7/3/0CKuCvIqUNQvXvxkizCa0M5gM5OMsXeZkf5QWa0gZT2tgEZWy+O780OFYj8
         tE3w==
X-Gm-Message-State: ACrzQf1w6uI+rKq+UKKKquf4VjFNpApPl6fe7f5qKErzHqQCM41biU4D
        luTXQep7sz5c08/SKsfSRrKhbThVtSXHfd/olMo=
X-Google-Smtp-Source: AMsMyM5DsRlY+IpeIBtRaARvugXX4xtvaU2mQyq0fH6YLi1+cQHHEFDfHmH8vrZWAcwMiBsXFFTxdtIjlL5F/V8jyf8=
X-Received: by 2002:a05:6808:114a:b0:35a:4acd:f598 with SMTP id
 u10-20020a056808114a00b0035a4acdf598mr7470562oiu.144.1667629510048; Fri, 04
 Nov 2022 23:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au> <20221104205242.3440388-2-git@johnthomson.fastmail.com.au>
In-Reply-To: <20221104205242.3440388-2-git@johnthomson.fastmail.com.au>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 5 Nov 2022 07:24:58 +0100
Message-ID: <CAMhs-H_uV=qURur1r4vK273rpaF990c9T6uP-7KWdPZz7+kNUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] phy: ralink: mt7621-pci: add sentinel to quirks table
To:     John Thomson <git@johnthomson.fastmail.com.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 4, 2022 at 9:54 PM John Thomson
<git@johnthomson.fastmail.com.au> wrote:
>
> With mt7621 soc_dev_attr fixed to register the soc as a device,
> kernel will experience an oops in soc_device_match_attr
>
> This quirk test was introduced in the staging driver in
> commit 9445ccb3714c ("staging: mt7621-pci-phy: add quirks for 'E2'
> revision using 'soc_device_attribute'"). The staging driver was removed,
> and later re-added in commit d87da32372a0 ("phy: ralink: Add PHY driver
> for MT7621 PCIe PHY") for kernel 5.11
>
> Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
> Fixes: d87da32372a0 ("phy: ralink: Add PHY driver for MT7621 PCIe PHY")
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
>  drivers/phy/ralink/phy-mt7621-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
