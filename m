Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DF5749878
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjGFJa1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 6 Jul 2023 05:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjGFJa0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 05:30:26 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9691F171D;
        Thu,  6 Jul 2023 02:30:24 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-570114e1feaso5890067b3.3;
        Thu, 06 Jul 2023 02:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688635823; x=1691227823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPVWS/AnexGn8mR391EaLezyPMA3jIWG3qZQy7VQ+CY=;
        b=a1JdLvnO5vJdsdlg4zW+9GIgVEtdNZ70aav/hQO9OSEyR/TS0nGYq/T3lEu/XNndXx
         v42eYo6f+YVhZqFZXrFVZVZBIcM8rRoZrkWYC1PNloV3VHe0CZikIHcaBRZLtrs8lnJ+
         7pOzJAKZmp9WZ56XQ2D/ebmtlJedmpSP7MWnnijAvr05TaPI5TZDh3nbsJtmPdPQpCHD
         skD4LnKit1stOagTgfoEBGdoplWs9RMldS7n3ONzDRot7Rofw18eMsyH1LTm+7cTAR/5
         dK9pyZ+Le4ygHtDG53+MSOKH7yu5FFG0+0cwu5ddLT2XC5a7trAqQj7jnwNNwjqViXTk
         WcXQ==
X-Gm-Message-State: ABy/qLZkqI5YrI0eQEXIP9P8kjevX+H508cHw33XkKeKqMx71hutbbaJ
        zAPmD2JXbf0bl6OXRBs7wOi3r0hDNr9UKw==
X-Google-Smtp-Source: APBJJlE35a1BSrIN+i4KHeScgJNAd8RRPAdXqrvA0YrRU2lfPe4jpP9ou1L7YG9yS2aPKbaG4teb9Q==
X-Received: by 2002:a0d:ca0e:0:b0:56d:28b:8042 with SMTP id m14-20020a0dca0e000000b0056d028b8042mr1335847ywd.40.1688635823550;
        Thu, 06 Jul 2023 02:30:23 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id n6-20020a0dcb06000000b0055a931afe48sm236990ywd.8.2023.07.06.02.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 02:30:22 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bacf685150cso460690276.3;
        Thu, 06 Jul 2023 02:30:22 -0700 (PDT)
X-Received: by 2002:a25:1688:0:b0:c41:6451:b820 with SMTP id
 130-20020a251688000000b00c416451b820mr1163431ybw.61.1688635822384; Thu, 06
 Jul 2023 02:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230706092047.18599-1-frank.li@vivo.com> <20230706092047.18599-2-frank.li@vivo.com>
In-Reply-To: <20230706092047.18599-2-frank.li@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Jul 2023 11:30:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUG9jgQdLhwB-6LaRPY-Mg1NawQAZGtOQWC=k47Fe044Q@mail.gmail.com>
Message-ID: <CAMuHMdUG9jgQdLhwB-6LaRPY-Mg1NawQAZGtOQWC=k47Fe044Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] PCI: rcar-gen2: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 6, 2023 at 11:27 AM Yangtao Li <frank.li@vivo.com> wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
