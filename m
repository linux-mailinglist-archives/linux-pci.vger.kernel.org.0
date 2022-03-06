Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F754CEDF1
	for <lists+linux-pci@lfdr.de>; Sun,  6 Mar 2022 22:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiCFVeS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Mar 2022 16:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiCFVeQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Mar 2022 16:34:16 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380FF3ED33
        for <linux-pci@vger.kernel.org>; Sun,  6 Mar 2022 13:33:23 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 3so4505840lfr.7
        for <linux-pci@vger.kernel.org>; Sun, 06 Mar 2022 13:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1VslL3ye1MbAoXD/93dVSkYx3rBEqLz04PvwnWO5Xc=;
        b=aP7NIVkTp8F0TQzsVHRkgravZwx4iPy0i/GXcER23Kdwa3h0g1I9y3M8zMLvIP91ma
         ObiiRLWF0p9p92E69K8HInTDYUDFmL7AEyunpOxfqnONlKhXGU6Fd6Bw+kpf40xyPLD7
         J4arYW2KdltXWYcpnA2rG4WjyBSh6aOQAuIOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1VslL3ye1MbAoXD/93dVSkYx3rBEqLz04PvwnWO5Xc=;
        b=dVtyID0EsUIRAG5XlCqeBwdX93Mnqip6g6tRbMUH1El6Tf6Lfi7cXJgfguZKqNvzBj
         VwxPySjMVaGFB7nnlRhcIXQrmbGNTgpEnJvVdMEqS9EyEOeNW96T+zCTiV9lW0iaVZ3/
         LmjKcC2VbVQno9/Cfnrq8OzvwKHLkwSYboi3LXyDJ18RlRi4wu6yhcUu3RDwSMretYlb
         zNa4/J59g4tCqQgqS3jWoNZF6q1okk1+aFYoW2ROeBxbpzcdUFKwsxdeOhQveQR1v4jI
         CkNeDIXun2f/gcwUTw/nUbhl6neG2xqm3M2wDU1u3pppk+7k0RcDK/dBXyZVT68XMZfL
         fcKQ==
X-Gm-Message-State: AOAM530Xgbju7TME4Y8knlESvyNpUUJFniIruxUkjy2PKd990LFE39Di
        FqO3bj2sfbU+Rudl+6MUJ4KUiZyqa34lfZok10Q=
X-Google-Smtp-Source: ABdhPJyIGNgGcrtHhNHX1DLw0EPLmd2ZYzceSxWwvhavvUfZYhgbTDcfoW3rn5oCj8k11bK7yr0/SA==
X-Received: by 2002:a19:ac42:0:b0:448:1f15:4b18 with SMTP id r2-20020a19ac42000000b004481f154b18mr5870311lfc.32.1646602401263;
        Sun, 06 Mar 2022 13:33:21 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id w6-20020ac254a6000000b00445c0b39097sm2463902lfk.299.2022.03.06.13.33.18
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 13:33:20 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id b5so3199768lfs.1
        for <linux-pci@vger.kernel.org>; Sun, 06 Mar 2022 13:33:18 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr5987125lfi.52.1646602398190; Sun, 06
 Mar 2022 13:33:18 -0800 (PST)
MIME-Version: 1.0
References: <164659571791.547857.13375280613389065406@leemhuis.info>
In-Reply-To: <164659571791.547857.13375280613389065406@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Mar 2022 13:33:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYjH_GMvdnNdVOn8m81eBXVykMAZvv_nfh8v_qdyQNvA@mail.gmail.com>
Message-ID: <CAHk-=wgYjH_GMvdnNdVOn8m81eBXVykMAZvv_nfh8v_qdyQNvA@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-03-06]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Rob Herring <robh@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Netdev <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 6, 2022 at 11:58 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> ========================================================
> current cycle (v5.16.. aka v5.17-rc), culprit identified
> ========================================================
>
> Follow-up error for the commit fixing "PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization"
> ---------------------------------------------------------------------------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/Yf2wTLjmcRj+AbDv@xps13.dannf/
> https://lore.kernel.org/stable/Yf2wTLjmcRj%2BAbDv@xps13.dannf/
>
> By dann frazier, 29 days ago; 7 activities, latest 23 days ago; poked 13 days ago.
> Introduced in c7a75d07827a (v5.17-rc1)

Hmm. The culprit may be identified, but it looks like we don't have a
fix for it, so this may be one of those "left for later" things. It
being Xgene, there's a limited number of people who care, I'm afraid.

Alternatively, maybe 6dce5aa59e0b ("PCI: xgene: Use inbound resources
for setup") should just be reverted as broken?

> ====================================================
> current cycle (v5.16.. aka v5.17-rc), unknown culprit
> ====================================================
>
>
> net: bluetooth: qualcom and intel adapters, unable to reliably connect to bluetooth devices
> -------------------------------------------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com/
> https://lore.kernel.org/linux-bluetooth/CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i%2BRE%2BL2FTXSA@mail.gmail.com/
>
> By Chris Murphy, 23 days ago; 47 activities, latest 3 days ago.
> Introduced in v5.16..f1baf68e1383 (v5.16..v5.17-rc4)
>
> Fix incoming:
> * https://lore.kernel.org/regressions/1686eb5f-7484-8ec2-8564-84fe04bf6a70@leemhuis.info/

That's a recent fix, it seems to be only in the bluetooth tree right
now, and won't be in rc7. I'm hoping that I'll get it in next week's
networking dump.

Cc'ing the right people just to prod them, since we've had much too
many "Oh, I didn't even realize it was a regression" issues this time
around.

                       Linus
