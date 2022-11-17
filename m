Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B7C62D597
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiKQIz7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiKQIz5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:55:57 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E005E9D9;
        Thu, 17 Nov 2022 00:55:57 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id x13so768342qvn.6;
        Thu, 17 Nov 2022 00:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlT6ogh4GaBnqEF0LX4CJxoqBzrwLMc6a558GyxEcJA=;
        b=rDxUwhZU/Yn8lfAMxLDsMx579MBQiw2fABi9a1y1+9idD1Zxy8yWS43ykiTb8vBOLm
         1wZhye7Fa7EaPHnQhpMlWqLWrqQLfzLOX+YO9/Hjqgiyo50qtG6Dcw735ta3U/gY25L7
         pYNEYSgn4lfmGv8CSWSQQ62bZwKROUf+6yYM9/row3FXmvzxgvZFcdolqx6+lJ4k2Ekx
         YZ2E+RkQ+nU4rCoQWKezve6GjcdHQlWXgfZrK1FaRDT/kEnNdi4LGHlniJbCPYs9yYLk
         uFvI86G23jH13LYVxFAYqROIaqSpWwFgchybgIM6iQ7MLfZW2CWtHYmeGZnJd4rt+Ilm
         bdyg==
X-Gm-Message-State: ANoB5pnQaFXssaw9j5wFav0Xgf/+1ngo1NsCdmSB9a8IiiK3+e3F3AP4
        zW6pq8fcMbhQVw3eczOSUlKkcvZRniOQNw==
X-Google-Smtp-Source: AA0mqf4PTxFbEtF8LSLXOEtjyl/EjgWoBaca7Snkqgde047AujFdNbwSJR96yfTUvEiQikCn9XcPFw==
X-Received: by 2002:a0c:edc2:0:b0:4b4:4a3e:d20c with SMTP id i2-20020a0cedc2000000b004b44a3ed20cmr1503042qvr.112.1668675356417;
        Thu, 17 Nov 2022 00:55:56 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id t3-20020ac86a03000000b0039c7b9522ecsm80211qtr.35.2022.11.17.00.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:55:56 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-369426664f9so12267987b3.12;
        Thu, 17 Nov 2022 00:55:55 -0800 (PST)
X-Received: by 2002:a81:6cd2:0:b0:38d:5807:4b9b with SMTP id
 h201-20020a816cd2000000b0038d58074b9bmr1127414ywc.358.1668675355727; Thu, 17
 Nov 2022 00:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20221116205100.1136224-1-helgaas@kernel.org> <20221116205100.1136224-3-helgaas@kernel.org>
 <CAMuHMdVtSHdFhd-V=7EzSZz6K7+fW9rLxUCN_=yZTGfKoAhS6A@mail.gmail.com>
In-Reply-To: <CAMuHMdVtSHdFhd-V=7EzSZz6K7+fW9rLxUCN_=yZTGfKoAhS6A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 09:55:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUm3yTomDZf5PvSzkVGiWqyam-LgXE39TbccEJKPV_vdg@mail.gmail.com>
Message-ID: <CAMuHMdUm3yTomDZf5PvSzkVGiWqyam-LgXE39TbccEJKPV_vdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Allow building CONFIG_OF drivers with COMPILE_TEST
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 9:55 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Nov 16, 2022 at 9:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Many drivers depend on OF interfaces, so they won't be functional if
> > CONFIG_OF is not set.  But OF provides stub functions in that case, so make
> > them buildable if CONFIG_COMPILE_TEST is set.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thanks for the update!

Forgot the most important part ;-)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
