Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD425F20D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 05:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIGD3C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 6 Sep 2020 23:29:02 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34074 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgIGD3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 23:29:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id c127so944471vsc.1;
        Sun, 06 Sep 2020 20:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VNwPK3AhXENbRAaqfeHTsdZ5rSIXUT1tkXyQSq9MqI8=;
        b=sryzMWWPXM/IVph4WjtigNkIDKWM1VjjFMoxN0QdJUmu592y2J/GZsz/qsVfj1LE7s
         +pZhrdGQAfw76zapjKCNpPjONyChWe6XRImyBSTj9kEgPYs/P7U3Svf2HxJlk0DyF9xI
         qIttR5uQvGn515G+udbn+DQTDmL9CM6Xc44qzmvj5pj3prCIVei/U4AP3upJcQPmwv4k
         I2KnhbmZtDunKhk5EXeFiJDZHUFZ9vZe14vEjupFAjjV+jwFj6O/6a90paYuyJ8dBdZr
         XxAvm+3h+UixR1qPO6ShKAnO5naBbT52enIXkHS9Df3olu82CZRi4zntPZnSEFtIcULC
         4Jqg==
X-Gm-Message-State: AOAM5332rArudv3fYpQwGLE1/CusLnjGc2ynMFWULY5eKNqglFbT5nED
        vODog0HORZhfE7Ij5A2lpyExzJfCzGq02aic+9E=
X-Google-Smtp-Source: ABdhPJwc/VxzgHslh2yvJE/hhWi7O8+VAa1xqzaPlDnaxj37IY043s/zKpEguoO3Qhx1AL6r7HxPB6VeJcWn+ORKXzw=
X-Received: by 2002:a67:b90f:: with SMTP id q15mr10644300vsn.177.1599449339707;
 Sun, 06 Sep 2020 20:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200907011238.3401-1-imirkin@alum.mit.edu> <018401d684b4$d31162c0$79342840$@gmail.com>
In-Reply-To: <018401d684b4$d31162c0$79342840$@gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Sun, 6 Sep 2020 23:28:48 -0400
Message-ID: <CAKb7UvgQcSsm=5wqs3jUNYYxuv1w_DPYpV1trSfz+OkbfK6TCg@mail.gmail.com>
Subject: Re: [PATCH] PCI: qcom: don't clear out PHY_REFCLK_USE_PAD
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 6, 2020 at 9:18 PM <ansuelsmth@gmail.com> wrote:
>
>
>
> > -----Messaggio originale-----
> > Da: Ilia Mirkin <ibmirkin@gmail.com> Per conto di Ilia Mirkin
> > Inviato: lunedì 7 settembre 2020 03:13
> > A: ansuelsmth@gmail.com
> > Cc: linux-arm-msm@vger.kernel.org; linux-pci@vger.kernel.org; Ilia Mirkin
> > <imirkin@alum.mit.edu>
> > Oggetto: [PATCH] PCI: qcom: don't clear out PHY_REFCLK_USE_PAD
> >
> > This makes PCIe links come up again on ifc6410 (apq8064).
> >
> > Fixes: de3c4bf6489 ("PCI: qcom: Add support for tx term offset for rev
> > 2.1.0")
> > Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
> > b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 3aac77a295ba..985b11cf6481 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -387,7 +387,6 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie
> > *pcie)
> >
> >       /* enable external reference clock */
> >       val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
> > -     val &= ~PHY_REFCLK_USE_PAD;
>
> To make sure this doesn't brake ipq806x, why not limit the &= to the ipq806x
> compatible like we do up in the code? (or use the use_pad only if apq8064
> compatible is not detected, to address ipq8064-v2 added later?)

Do you mean something like

if (!of_device_is_compatible(node, "qcom,pcie-apq8064"))
val &= ~PHY_REFCLK_USE_PAD;

I'm not sure what's considered acceptable in these cases. It does seem
odd that this bit should not be cleared on apq8064 but should be on
ipq8064 -- perhaps there's more going on there? Unfortunately I
haven't the faintest clue as to what it is...

  -ilia
