Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915897913BC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351141AbjIDIoo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 4 Sep 2023 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjIDIoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 04:44:44 -0400
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27833126;
        Mon,  4 Sep 2023 01:44:41 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-49040dc5cedso196461e0c.3;
        Mon, 04 Sep 2023 01:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693817079; x=1694421879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdypnkqWPfFDZuLjucd3BrugeQJTVNQdzlIAmZgZVJI=;
        b=bPc6N1LwhQ42d8rlbmP/fAU38I5ZdtafMbjm4KCAJYk2WE9pfLzbTbUf/APnDehLdG
         5FuqdE3xxuY10nPFDXGCesyjFW8fESxnmpINCiETxQtwacRoLqnwtoxvrUm5NjqJHHJ8
         BWlBLNgorBLtFYjpFor4qBn+GUpXcRhxx27LWItwwZKjxETKHbp3hnwZvpQXRfw5zxey
         RJUSrl/XO3pMzk8dqm4iOoftS1vPnUBbK1FENxbcd7/kN6Cb+M6K6QJTcyl0yD7dXOxA
         lw8e9Rkw6CwA19IPvk0591q3KQopXM18w1bVIv/HxxcIquLJ6WGWtE1e2VRCSxmeed4c
         700Q==
X-Gm-Message-State: AOJu0YycxOTxsy3L012AlOjpHabYDhcBL4+bEe5CKy6Z9k+fm9QPhfrv
        wyhIwsWsaSxg4o+bb5sRVg9TIXdUDkHr4w==
X-Google-Smtp-Source: AGHT+IHOqIp65QLtj+FQ/WoKDNGBjm79HXZ2r6xIYsblq05GeahVy1QBBRnkKRvAGAuQCwUsTM/tpw==
X-Received: by 2002:a1f:6d81:0:b0:490:b58e:75a9 with SMTP id i123-20020a1f6d81000000b00490b58e75a9mr4791218vkc.4.1693817079582;
        Mon, 04 Sep 2023 01:44:39 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id l22-20020ac5cdb6000000b0048c34d8be47sm1527968vka.5.2023.09.04.01.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 01:44:38 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-48d0eb04c8cso198982e0c.0;
        Mon, 04 Sep 2023 01:44:38 -0700 (PDT)
X-Received: by 2002:a67:e9ce:0:b0:44e:8d95:88bb with SMTP id
 q14-20020a67e9ce000000b0044e8d9588bbmr5108769vso.18.1693817078322; Mon, 04
 Sep 2023 01:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com> <20230901131711.2861283-4-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230901131711.2861283-4-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 10:44:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCznxgoP60FrjpZgpx8Pt8Gn-0E=r9eQHayza2FvJn0w@mail.gmail.com>
Message-ID: <CAMuHMdXCznxgoP60FrjpZgpx8Pt8Gn-0E=r9eQHayza2FvJn0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: rcar-gen4-pcie-ep: Fix minor issues
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 2, 2023 at 12:40 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Fix minor issues of rcar-gen4-pci-ep.yaml.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>
> This patch will be squashed into the following commit on the pci.git /
> controller/rcar branch so that many fixes into a patch:
>
> dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rcar&id=738bded11aaa3a9717e415197cd6b833dc439cb3

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
