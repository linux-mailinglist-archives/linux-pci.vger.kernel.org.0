Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB02D73CBF3
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjFXREk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 13:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjFXREj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 13:04:39 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CB913E;
        Sat, 24 Jun 2023 10:04:37 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b7279544edso1319852a34.0;
        Sat, 24 Jun 2023 10:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687626277; x=1690218277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWUPx4B2kJGgvXIs8RsYy9lugFh6tACB+WFQIYwQ1k4=;
        b=IO8uYQgLLhwW529S/Xu5lQpFu5rzYXNDJS0MgCqlO5j1NZ84hxw6G8V4PfzUWJqW0I
         RnfwCRN6z/dvToGw2NtQGQdQ1LhP8ug8PbnhY6Iw7aBr5IzbaL2MC6gUoi0sV8X5/3rQ
         oJgRFailHKBEL6xNg6EGpZDqd2iz3Ko59jePxZfO3zzvxKZy3+wKFgWOuZVcLilr3I22
         pm8xiuLLDh7MbQ+L6p3Qp/8yzDIhSo/FsCyEsSdiLCbfcoN0fZSnMZc4QExojnhluFgg
         V2OKfALkydHJ266E4Iw0QFO3HQrF0XP6f3bIprMxH2RxmO0JWTxXuC4bXTC39EYjaJcA
         xiMQ==
X-Gm-Message-State: AC+VfDwMOVDwBIrb+ssVemhA+6ngss8qmYvcBGe0y5yuv2ZZM1DapU5i
        obFEgZ5Utn4LH5OyItAdxFA=
X-Google-Smtp-Source: ACHHUZ5PzhhFFcHozjXeG4hw1Mj/ZmNTVeYk4Nr3y2QM5U89zI6IZpJ6mD2EcsgWm+8oxfZeytffWg==
X-Received: by 2002:a05:6808:3096:b0:396:12cb:1349 with SMTP id bl22-20020a056808309600b0039612cb1349mr28031552oib.38.1687626276865;
        Sat, 24 Jun 2023 10:04:36 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id v29-20020a63481d000000b00553d27ab0e0sm1447457pga.69.2023.06.24.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 10:04:35 -0700 (PDT)
Date:   Sun, 25 Jun 2023 02:04:33 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: apple: Initialize pcie->nvecs before using it
Message-ID: <20230624170433.GE2636347@rocinante>
References: <20230311133453.63246-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311133453.63246-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> apple_pcie_setup_port computes ilog2(pcie->nvecs) to setup the number of
> MSIs available for each port. It is however called before apple_msi_init
> which actually initializes pcie->nvecs.
> Luckily, pcie->nvecs is part of kzalloc-ed structure and thus
> initialized as zero. ilog2(0) happens to be 0xffffffff which then just
> configures more MSIs in hardware than we actually have. This doesn't
> break anything because we never hand out those vectors.
> Let's swap the order of the two calls so that we use the correctly
> initialized value.

Applied to controller/apple, thank you!

[1/1] PCI: apple: Initialize pcie->nvecs before use
      https://git.kernel.org/pci/pci/c/328a16477027

	Krzysztof
