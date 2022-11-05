Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B537661D7EB
	for <lists+linux-pci@lfdr.de>; Sat,  5 Nov 2022 07:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKEGZr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Nov 2022 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEGZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Nov 2022 02:25:46 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D21248F1;
        Fri,  4 Nov 2022 23:25:46 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13bd19c3b68so7704391fac.7;
        Fri, 04 Nov 2022 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iPTBrqMd1m/Sm0/1qyKS1POR1PDbASDeCT0rB1tU/vk=;
        b=jBppZhZMDzKee6IjZzOQMQVT6NmeQbYXhkMPBKjK0XXYd5WvO79bIHWbLCV76OOnf8
         g/Aso7l3M0k6IxrS5BESc6ak78S+sN1stOk1cmMxZ5iC186IQBnHKpFMxO3ZWNT7g/D+
         5ER/aWATkm1rIeW15tcZ7Qz0IOJh14oV5U3hrIEAK0idwxEyfgH6mTAoJmWk4qBIPG3o
         FRC4kvjRMeMVAQEM1EP+vcj45xYT9h0qqjt+3zs3LAjO2k/dtx3fk+T0ub8/fMunljbA
         hyk49TS2iE+AE0ZGYXV+oxYOFPrWzawwtDmGivb6+VVU5YTHrTdwT1Z9F3QrDiHDtvEO
         IvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPTBrqMd1m/Sm0/1qyKS1POR1PDbASDeCT0rB1tU/vk=;
        b=NoswTLemKj+iLaiIlyxew26g9rQvV62/nj9LYgIC3XoI+wAoVypGZplKDngUFPqedB
         oVcoHrSFpuNM22RsJ/pvOix3zYUK241jVS5+5dDNx+TOuEMhLAKer4eiYwJCxZ9sHI01
         mjrcvrkQ/Z2ycbRti6Vbh8LZmplkAlQiSKgEStA78O/JELjIpFLXhaF2fytYDMaopNMf
         RtsVABXSeHw2Qco/tInfNOL2x62h9kwfsSyNRFu2DDcKSW8aAk2RmUQo5YSLC9ve51fz
         daz0DVUoqqpJDr7sAkpqVj41Mp8lrsJl/HFIgLgE3kNsC7hYAT8mxJ+JPO1eEsMYsKHq
         /BJw==
X-Gm-Message-State: ACrzQf0itow7jdlUJWY3O9l4EnIXOoFaIFyb2EZCAGFjqhXBvL9875xS
        DkS1IKz+8KAK1frJswKxO7JumaOAniyGoI30F+A=
X-Google-Smtp-Source: AMsMyM55eK50zNlSXtpfWeWuliapR44E4AVCP/mWMJRhLFllXQKyJGZsQwoXSFgdEUfYQK4TEpqenK6htDRaS1/nBcA=
X-Received: by 2002:a05:6871:89:b0:131:6362:e26f with SMTP id
 u9-20020a056871008900b001316362e26fmr23665376oaa.144.1667629545427; Fri, 04
 Nov 2022 23:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au> <20221104205242.3440388-3-git@johnthomson.fastmail.com.au>
In-Reply-To: <20221104205242.3440388-3-git@johnthomson.fastmail.com.au>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 5 Nov 2022 07:25:34 +0100
Message-ID: <CAMhs-H-pJ5gOQpbCsNSmsp6fXdELWeT6bA4jom_8TNjsLF3dnw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: mt7621: add sentinel to quirks table
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
> commit b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
> using 'soc_device_attribute'"), and the staging driver was moved in
> commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
> controller driver") for the 5.16 kernel
>
> Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
> Fixes: b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
> using 'soc_device_attribute'")
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
