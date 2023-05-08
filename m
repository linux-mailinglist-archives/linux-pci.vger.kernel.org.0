Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35F6FB045
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjEHMjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 08:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjEHMjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 08:39:17 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B263A286
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 05:39:08 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so24722758276.0
        for <linux-pci@vger.kernel.org>; Mon, 08 May 2023 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683549548; x=1686141548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uROyBrg4Rj4m8VfCLH63bHghL03rmG36CD/tTQoIjDc=;
        b=TpEzbfix6RIrR/JlLG63lTb15z44oEkRjGofFW29A0MN7BOInaRnSkqHTvYVhkKQgb
         3TWhd0n+6n1bF2K6Z6DD8ohTKKfVNNm31T9EAKdcuN2lwLBuciqdjlXcxMwIQY4LSsk+
         wbitVqddA81Ndh1TbwZFpfntDp4mSuJaJrCfX8lr3b5TRc02JpN3wusASiQ20/kEC/gz
         f7AWqfnKUv472FVV4Ut3FlWjDNy/g8XSEefAra4Ju5G7DoX0RiICWefNpfJxKeu8umE+
         Y66B2DiKKT26LRJFh3AeeeNf2QUVcc8d/DXOcHH129HXPfpTlZ8LPxkgxmtr0oXpw3ve
         yBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683549548; x=1686141548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uROyBrg4Rj4m8VfCLH63bHghL03rmG36CD/tTQoIjDc=;
        b=D4vEI51Ba9tS8DHqh9G/mZka4tB2ZZwGJZ0To3YfKGAmdfRv6Q3Z4aiqmxgsenvY4z
         BJreLGW2zrW5ZuGZuAJBlCmr0VLho5DvbzK4ZmQFXccTxd4SgTnwTPTUy3K35nQhQHSH
         4guEzV2ewPhEG1NBSCIzjuA2dbyXap4+Wn4XIqmdu4G0zUmg/plcO/gxa6PnA0p6Mm3K
         Pzsiu5lpc1zXOKHFxiLe/dPAUen7sj6ul+zzO6Tmtxnr/nA1Hjdjvg6Y3XHK152cQfC+
         3uo5diCS9xMZJIn7uWCDdcnMXKKguke5DX0Ve1RkuzrIh/6Je/N6hMJgQxuxt61EcDID
         XlUg==
X-Gm-Message-State: AC+VfDyuVew0SY28KQEJVT+K6mhgehjUGY1SUznrx8sglosFiBJqKV+d
        utBFPkUNG14tROh7HdnVEHsXnAXBL4TEhyY6li/QQA==
X-Google-Smtp-Source: ACHHUZ5jBvl+0pVUDygH87dIQI5+wsNCOfP5FbE3+s/fQidEE1nNvoYXgM3WWx2UgSOufKK3tCw/bOlQcyUE+7oE8b8=
X-Received: by 2002:a25:4ac9:0:b0:ba1:6bad:9270 with SMTP id
 x192-20020a254ac9000000b00ba16bad9270mr12863241yba.27.1683549548166; Mon, 08
 May 2023 05:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230508043641.23807-1-yejunyan@hust.edu.cn> <430d0357-d10e-db3d-bc82-722b022b519b@wanadoo.fr>
In-Reply-To: <430d0357-d10e-db3d-bc82-722b022b519b@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 14:38:57 +0200
Message-ID: <CACRpkdbPzGumK=wAvOr99TQZB4hTjxvymPCvj_3qU1XSPKkpOA@mail.gmail.com>
Subject: Re: [PATCH v3] pci: controller: pci-ftpci100: Release the clock resources
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Junyan Ye <yejunyan@hust.edu.cn>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 8, 2023 at 8:59=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> completely unrelated to your patch, but this comments state "optional".
> The code below seems to make both clocks mandatory.
>
> Moreover, a few lines later, we have:
>      if (!IS_ERR(p->bus_clk)) {
> which seems to say that bus_clk is optional.
>
> This was introduced by 2eeb02b28579.
>
> Just a guess, but either the comment should be updated, or the code
> modified.

It's fine to make the clocks mandatory, because all Gemini
systems provide these clocks.

But that is good to mention in the commit message as well.

Yours,
Linus Walleij
