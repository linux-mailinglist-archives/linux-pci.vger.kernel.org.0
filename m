Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C0B7005E6
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 12:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbjELKqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 06:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbjELKq3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 06:46:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2875C10E6D;
        Fri, 12 May 2023 03:46:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3075e802738so8875904f8f.1;
        Fri, 12 May 2023 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683888384; x=1686480384;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo67O9FRX0GyvAWrdRm6agPjzPmEBmkG90/e6PxM5KQ=;
        b=JCRV1/NQyGX6dw30BOLJmllahdmyGUPU53QIi9FLiR5Vfnxd/uxH57HFPSk2aiYmXs
         Lwb7Qy3ApHZfdD8luXPgw+oPKlxgc2wRL1wd92LiLKvvrCJe9INCIriCfJXnWkAO19l/
         kasDE6ZhNNTv8R8qVQhXsVjD+0Pf0CBGWWOyhOeIW7RLZnfeBxOiGNtz0pqqUFgqfY0l
         J0JW80xxDmkPygm6LCo7LzDgPQOnKoFh35Rj3+iSTA9CtTrnMcqwV9YNV9RmRfVcP86H
         /nCUaDxSjynHnQx/rk7tXbMkQMzkDE3L0xn8uZCFZH9ojCzgZQdUT8WX4RksSCGlQtKp
         DCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888384; x=1686480384;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oo67O9FRX0GyvAWrdRm6agPjzPmEBmkG90/e6PxM5KQ=;
        b=S1eV9H5/I6w8K+xYOxztiHrGdb9mZE8XoXwhcIm5nlYVi5x7gEbO37KxijoUBLxrl3
         iFC0nS0gCMYQC+PrA2MIcWgWIx8wBKg1wMsfP1wIozoOcJNjzCypmXNAaN167AxfwrG1
         Yyr2y0f+cOQdW6JD7/CVnviSLr34U+5vi9yhu0Awea9FQvNo415O0jroEXRUuvlKzaAA
         SWfiOuPUQFejsNyqUCL2bW3zMkdFNWZPnl3FRjDmqC80+MR4BppTm5qjDDBFiy11SeO8
         9DC8+NLibWpjGtQwO0oiOtyuEFCwjkHdcV/Iha2qMCutlmiofViVfKEEQGU99D2mPxGr
         HcWw==
X-Gm-Message-State: AC+VfDymSPqGariRpYJkLgnBtHIdQnHTAgtFpCkk3xR0IsCtngxrW13L
        nNrldsNYJwUDv+jj9663LdE=
X-Google-Smtp-Source: ACHHUZ7cQ6lAGWPK6qsZqTOzReZDoPCdV311+gW5FWzcfuzQiOK30bhW8w9cTIRqHdDCML34gprPCg==
X-Received: by 2002:a5d:5011:0:b0:307:8a39:5568 with SMTP id e17-20020a5d5011000000b003078a395568mr17093589wrt.7.1683888384189;
        Fri, 12 May 2023 03:46:24 -0700 (PDT)
Received: from localhost ([146.70.133.78])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bc8cc000000b003f4e4b5713esm5650587wml.37.2023.05.12.03.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 03:46:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 12 May 2023 12:46:21 +0200
Message-Id: <CSK8M39MQL2C.3S7JO031H0BA2@vincent-arch>
Cc:     <linux-pci@vger.kernel.org>, <robh@kernel.org>, <heiko@sntech.de>,
        <kw@linux.com>, <shawn.lin@rock-chips.com>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <linux-rockchip@lists.infradead.org>, <broonie@kernel.org>,
        <bhelgaas@google.com>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        <lpieralisi@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Dan Johansen" <strit@manjaro.org>
Subject: Re: [PATCH v1] drivers: pci: introduce configurable delay for
 Rockchip PCIe bus scan
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Peter Geis" <pgwipeout@gmail.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>
X-Mailer: aerc 0.15.1
References: <CAMdYzYp6=mYSoUHN3TEXVSMbRt1HpRm0X_4RMez09V0XzQewaw@mail.gmail.com> <ZFwC/seTfSoaLn0v@bhelgaas> <CAMdYzYoa8dhmBx5MUG0yBPwVVXPXHrYNnR0QvKHXvV=JaKuMfw@mail.gmail.com>
In-Reply-To: <CAMdYzYoa8dhmBx5MUG0yBPwVVXPXHrYNnR0QvKHXvV=JaKuMfw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > > Many years ago we ran that issue to ground and with Robin Murphy's
> > > help we found that while it's possible to gracefully handle that
> > > condition it required hijacking the entire arm64 error handling
> > > routine. Not exactly scalable for just one SoC.
> >
> > Do you have a pointer to that discussion?  The URL might save
> > repeating the whole exercise and could be useful for the commit log
> > when we try to resolve this.
>
> The link to the patch email is here, the full discussion is pretty
> easy to follow:
> https://lore.kernel.org/linux-pci/2a381384-9d47-a7e2-679c-780950cd862d@ro=
ck-chips.com/
> Also:
> https://lore.kernel.org/linux-rockchip/1f180d4b-9e5d-c829-555b-c975094036=
1e@web.de/T/#m9c9d4a28a0d3aa064864f188b8ee3b16ce107aff


I have some concerns about the patch proposed in the email that you share. =
It seems like=20
it is quite extensive (code that is it not just related to the HW) just to =
fix a hardware=20
issue. I would have expected the code to fix the bug to be integrated into =
the driver itself,=20
so that if the hardware will died at some point in the future, I would expe=
ct that also the=20
buddy code will died with it.

However, it is possible that I may have missed something in the patch,=20
and my thoughts could be wrong.

> >
> > > The configurable waits allow us to program reasonable times for
> > > 90% of the endpoints that come up in the normal amount of time, while
> > > being able to adjust it for the other 10% that do not. Some require
> > > multiple seconds before they return without error. Part of the reason
> > > we don't want to hardcode the wait time is because the probe isn't
> > > handled asynchronously, so the kernel appears to hang while waiting
> > > for the timeout.
> >
> > Is there some way for users to figure out that they would need this
> > property?  Or is it just "if your kernel panics on boot, try
> > adding or increasing "bus-scan-delay-ms" in your DT?
>
> There's a listing of tested cards at:
> https://wiki.pine64.org/wiki/ROCKPro64_Hardware_compatibility
>
> Most cards work fine that don't require a large BAR. PCIe switches are
> completely dead without the above hack patch. Cards that lie in the
> middle are ones that expect BIOS / EFI support to initialize, or ones
> that have complex boot roms and don't initialize quickly.
> But yes, it's unfortunately going to be "if you panic, increase the
> delay" unless a more complete database of cards can be generated.

This is really unfortunate because as mentioned in some previous emails,=20
using sleep time slows down the kernel. Is there any way to tell the kernel=
=20
to tell the kernel "hey we need some more time here", or in computer scienc=
e=20
terms, load a driver asynchronously?

Thanks.

Vincent.
