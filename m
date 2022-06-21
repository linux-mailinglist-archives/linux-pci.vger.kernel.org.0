Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9C552D25
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiFUIgp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345537AbiFUIgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 04:36:43 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7E22290;
        Tue, 21 Jun 2022 01:36:42 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id c1so18949209qvi.11;
        Tue, 21 Jun 2022 01:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCrifMlo157VPMmQRiT6jFW67xnyQ8WeHHx7w4rwSGc=;
        b=2rLjrJnxpxp0xEZVe2nrGZtsSuYGcWZnclfukuNWRJ3+fQxeWkgf78CK3nvWiDAj0B
         WrrQO7v2v+Z8zX5thbhVCy6CxTv72b0sOA+I//TA6r0ghmle9Oglr+YsZH6eo+/krxT2
         VHInjjQA/KRP3H97PPFmkZmGDZa/8WF4HSPLX/5SHlo/7KnbIInZzQJ/k4qRtrBGa+M6
         bg654P7kQCDtW9G7y6/dN9ZZUMDqht0BAOtKM9giUO1EdZ85cp/tHFQb/lkUtng7nNxd
         Xu2f92pFV4q1EG9ImuNGSKU/QHiuIfTva8BzK7aLBjP8W28kCL62FXXqS2jR/cIfTQgB
         FpHg==
X-Gm-Message-State: AJIora9Rzt0uSmdWdPM9RIkjwbbKKKjN4NvyaNT48eDszJvpQEKqXc4L
        fXXGhpM1MqZUbSEbk+Gri9HEZLpMl/MOnA==
X-Google-Smtp-Source: AGRyM1vmy6JZgifJJ1muPHSqJRWQH+mBYzFeZy47FObm37PY1XfXYZ7rzUDNfLjwLbn9UPnKppgTnQ==
X-Received: by 2002:a05:6214:d8b:b0:46b:a979:d9c with SMTP id e11-20020a0562140d8b00b0046ba9790d9cmr21917084qve.23.1655800601024;
        Tue, 21 Jun 2022 01:36:41 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b006a785ba0c25sm13001804qkb.77.2022.06.21.01.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 01:36:40 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-317803b61e5so97911457b3.1;
        Tue, 21 Jun 2022 01:36:40 -0700 (PDT)
X-Received: by 2002:a0d:f801:0:b0:30f:f716:2950 with SMTP id
 i1-20020a0df801000000b0030ff7162950mr32597022ywf.358.1655800600138; Tue, 21
 Jun 2022 01:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220621070145.4080147-1-windhl@126.com>
In-Reply-To: <20220621070145.4080147-1-windhl@126.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Jun 2022 10:36:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_=cWVr7pjYNbz+eO5R3S_H9nJyodRNkQ6uWYgQ_O-rA@mail.gmail.com>
Message-ID: <CAMuHMdU_=cWVr7pjYNbz+eO5R3S_H9nJyodRNkQ6uWYgQ_O-rA@mail.gmail.com>
Subject: Re: [PATCH] pci/controller/pcie-rcar-host: Hold the reference
 returned by of_find_matching_node
To:     Liang He <windhl@126.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 9:47 AM Liang He <windhl@126.com> wrote:
> In rcar_pcie_init(), we need to hold the reference returned by
> of_find_matching_node() which is used to call of_node_put() for
> refcount balance.
>
> Signed-off-by: Liang He <windhl@126.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
