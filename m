Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBCB563C55
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 00:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiGAW3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 18:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGAW3g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 18:29:36 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CD437A98
        for <linux-pci@vger.kernel.org>; Fri,  1 Jul 2022 15:29:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i7so6319830ybe.11
        for <linux-pci@vger.kernel.org>; Fri, 01 Jul 2022 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9MLdlefOg4/qrE37ZlejhXDyhhffF7/1nX3qatlgcY=;
        b=o/M5D3kXHcoMYgvMJHa50XQrV93I1AsXmqatPB+s72HImYAg1ZLHfPnvZl8n3u5yeR
         +hNBcVpLiN03mIaInn1IcJ4HzYVll2I3O5cZaS02O00PeV8HVEHxaKTpSYrRvL2UD48E
         VJjBCMrC4GzKJNkNoygRt7+21oz1HT+wpliTae0oUCS1TpuFi9ec7lHmHeDRlBCJ/KVD
         s+H8l3erdy9QrRM+F/Xi3hr68MN5rJCfGJUsfK5DdOYEYa7/riz5ePl8JHwSS94xmdW1
         Hg5iW639AQecNZA6QV+khBTTHW45GU5QKXN8t0rYcjkzxpWYMjNtB2dD5b0fwFWNmJRu
         Bc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9MLdlefOg4/qrE37ZlejhXDyhhffF7/1nX3qatlgcY=;
        b=RwMO9gE3nH40mpHXHsOGbNg4u7L7iceRdt1XvraTkNWnrR4CIdTfYEb2rgsRguJ7L3
         lmwt+O5U8ojCeUCMlfqeRNvWHakwJQfhYpJVNPFmTlfhBPezMbZekYgUpmminiSkuHyA
         cfd/hfB6VCA2uf0d6J5oqVhgQG4OFEqWDpJKubqxWefH25N53MIeUDXU9I8wRjF6fiHz
         0CMJe9ipyIUrRhJnX9pPYrW4J77qBTz57RIEBFeQS/PxIZK8ppX2XQ/HXnZx7rb6fCR1
         4FcrPFTuxQUjlqukMop+1mSRoZ1FbiDSYqkgmGaqfN2N0nBtf0Gfe+JJNS0FoRea7Toq
         PBKw==
X-Gm-Message-State: AJIora+MkN2lHwGa6FoxY9DGVkmmhFzgYlPz+XF1lPhFD7wNWkHtg+Cj
        hwokeQalUFW6vwzWGd6xd3DHi486b+fAAsv11cNQbvlNfGhGGA==
X-Google-Smtp-Source: AGRyM1t4ZKeWtcE/ZCWkbxqDkcPOjezFydUN/dSns3TwAa/eYjgjG+o9msIAPJsvizrgIczTeNNeKy0cGh1dfIg3iCU=
X-Received: by 2002:a25:358b:0:b0:668:a642:ccb3 with SMTP id
 c133-20020a25358b000000b00668a642ccb3mr17357021yba.563.1656714574521; Fri, 01
 Jul 2022 15:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <62bdec26.1c69fb81.46bc5.2d67@mx.google.com> <Yr3vEDDulZj1Dplv@sirena.org.uk>
 <CAGETcx88M3Use8crFMTU=By3UVjjaJuP1_Ah7zsy_w=pNxc+6w@mail.gmail.com>
 <CAGETcx_s+ui9wWA7OawojPbY95bLZE5pSmpK-34_kLZTzjf9Ew@mail.gmail.com> <Yr67fvEPKmDTQfGz@sirena.org.uk>
In-Reply-To: <Yr67fvEPKmDTQfGz@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 1 Jul 2022 15:28:58 -0700
Message-ID: <CAGETcx-ToG1xAtKVuZqwQK7hvVbT+Q0J0m4oWVCtR55XiYqETQ@mail.gmail.com>
Subject: Re: next/master bisection: baseline.bootrr.imx6q-pcie-pcie0-probed on kontron-pitx-imx8m
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, Michael Walle <michael@walle.cc>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 1, 2022 at 2:16 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jun 30, 2022 at 06:02:04PM -0700, Saravana Kannan wrote:
>
> > The patch attached to that email will probably fix this issue. I
> > haven't dealt with Kernel CI bot before. Is there a way to get it to
> > test a patch?
>
> It is but I don't have access to do that - either the lab owner
> (Michael, CCed here) or Guillaume (also CCed) should be able to help
> there.

I found a much simpler solution that I think should work. Snippet at
the end of this email.
https://lore.kernel.org/lkml/CAGETcx-fLAXnG+1S4MHJwg9t7O6jj6Mp+q25bh==C_Z1CLs-mg@mail.gmail.com/

I'm waiting for Alexander in that thread to give it a shot.

Michael/Guillaume, if you want to give it a shot too, that'll be nice :)

Thanks,
Saravana
