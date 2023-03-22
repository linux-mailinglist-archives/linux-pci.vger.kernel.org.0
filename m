Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D826C435A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 07:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCVGkU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 02:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVGkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 02:40:19 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CA051C9C
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 23:40:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bk5so3625431oib.6
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 23:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679467218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke6cIxwNHxgaZFBB/jfvzTlKS8OVZziRO/zVUdektKA=;
        b=Q+vsce9EVvE2Qi8+y+Ai+bv9SHNlRk/DlNRdlqCbEt3wRtox7tm4AUQbEJsSDmcZ5E
         RW/UOgpCYJ3TugUiBJ4err05Rhxbzy2cSTDV03fuZ/ymiq5oybkMjcte9WTqMQO1vp9G
         VHHVycN6/PA2FqD0gTlAHI2+n2AC1aG5CaN27ZNNsPMoo9DVyVTiXKPUDSGQr80kXYUe
         NkMevox6Mrr54s223nOk4kNYlZCLr1rfhPijhjTQJ4zGiBhvkb1QbcmJJLIjYEXcaCC/
         9rmU/Kn6QsP366UbgIOgfmADBxdlUiSVPDlXkxLVIKQ2sBH6nmH8axd6C09JiwoihP6e
         Fk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke6cIxwNHxgaZFBB/jfvzTlKS8OVZziRO/zVUdektKA=;
        b=qu8/0/ZwsETHLgctUNwT8mFvr5UUbFG+n9bs93NE1eN/i++H22dbboEmXZXCXsEXTJ
         1fygY6Nr6I40k3tkterlty1+FAdzIZ3/SmWaRd3NhiwaBf5SxnVc7Zmt5SZs2yB/GJBL
         c0dOrOt1YpLRiJq8MULKUVUOBCKO6ZSqULI15uXf3lPUOjPXpU0T6TXss5KWeJvRsmV7
         rfonMDrlLgJgEOW+gxNh8ZIuFcNkqTpWps6T58o4VoAbx3oylqIuNLg5o5mBCoWhty3Q
         fbikokZrJHdwDF8BIa5RNNZW0bNIgm/mfAkVftqWplOJ1AsshxfQU16VjPAHuAP9FQ0w
         RaKg==
X-Gm-Message-State: AO0yUKW81M2IjAZZqWUMUjnN4QnpAzCqaM6XrFzep5aWcOnn4K1h+9l5
        55iK7wLSNeOC/DPN0P03X5Z3OmMi8dQQNbgDjlE=
X-Google-Smtp-Source: AK7set/ivZ6wY348VkcNilAhR/sb4gt0fLnpa3AYCKBQvEAMpAWigD5IYwL/fir/gtIK6LYSFC4gxAsFBcch815+ksQ=
X-Received: by 2002:aca:190a:0:b0:383:c459:1bc with SMTP id
 l10-20020aca190a000000b00383c45901bcmr688095oii.0.1679467218089; Tue, 21 Mar
 2023 23:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de> <20230321193208.366561-12-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230321193208.366561-12-u.kleine-koenig@pengutronix.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 22 Mar 2023 07:40:05 +0100
Message-ID: <CAMhs-H-44g7Yu-J__1bGK6B=CYqDUrGXehrBTsKSSb-8X6fvSw@mail.gmail.com>
Subject: Re: [PATCH 11/15] PCI: mt7621: Convert to platform remove callback
 returning void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 21, 2023 at 8:32=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
