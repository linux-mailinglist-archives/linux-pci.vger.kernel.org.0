Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C818F78418B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 15:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbjHVNG3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 09:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjHVNG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 09:06:28 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2F6CC6
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 06:06:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76dafe9574bso79419785a.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Aug 2023 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692709584; x=1693314384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YEozutqkXIFfgpUL8ezNRdTzgciBgR3nzmNF7BsP0bU=;
        b=AA8v20EcekmUnFmJ3zPtbgzvo+2d/djHmK3mPyr5tr7Wdr6NmsqgVD+A1tshEbvAex
         cqFSQ54gGLbl4mt3pEkEd7OqGhxug5mPVyjYj0sR/BCPU05oMELeFjqBvYXbrfm9pOI3
         jLScxqZu7g7k9cj6g9SyHwWhta5GWDTfYAKdJw0IhS7HK1pShu6b0cxOgT1Tqm7GlYGI
         +6tqW7snagMGFVFrHpn1obO7By4F1RQZIgWFYSGhbqTch3NXxiMCkQOTNLAkOe1HUrCj
         IhzQ6duKFiw/5GvqnSxtuuXUZ+0uZwEQddX1TBjTZayDNllIy7NpIAaQtursdHgFnAjB
         dGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692709584; x=1693314384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEozutqkXIFfgpUL8ezNRdTzgciBgR3nzmNF7BsP0bU=;
        b=AdAsZ/jy+UD7twDOu8awekkOW51oCnCSFCEVCBaEBLQot6W+T2TlgF0NT2vHiDG82G
         tpts1CIglOipMnjPczL99WHOxfXxFDkGVnxL/fb8yairNATvx22YFgMaR5nZ6jjpkSSi
         dxtk/rVdb9OIb9ib43KB65rz1ghh75RNpMDeBbNDFg4SJFyc2fCAtNwcAPGQLwyS/vqP
         HsQHqTpJHr06fhaPSmBKtqLrhyvMHTs3wc8oTYHOJR1eDnT2d22y5EvQrdeAbcnvQjM0
         XoYf7H8q/UzjgeDdDZYjIeTnaHP5EI6By6tZpj3SIkhZPCaaOMmbQqbVSkcpK/F24nL3
         Ku0g==
X-Gm-Message-State: AOJu0YzDzea3esGrkqWUh90bR6OtUjAMqfQZF53bgzeIdq8ZNSTvziMv
        /jUY4p1/UgvTHvAqpZiL1JhFgIQH/yQk0Sdl9bcfew==
X-Google-Smtp-Source: AGHT+IH7FFokEykaZUogckv9j1QPt0YaIMYfzav6itMDlNog7eheQ5lpUgXhgXXjW8nbNIUBqe/wIgFVFSuH2I/1uCM=
X-Received: by 2002:a0c:dd0f:0:b0:64b:33ae:ef9f with SMTP id
 u15-20020a0cdd0f000000b0064b33aeef9fmr9461493qvk.4.1692709584004; Tue, 22 Aug
 2023 06:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230822115514.999111-1-chenfeiyang@loongson.cn>
In-Reply-To: <20230822115514.999111-1-chenfeiyang@loongson.cn>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 22 Aug 2023 15:06:13 +0200
Message-ID: <CADYN=9L-RS1NPZqogi4M9oLEB8Tod31pn2+D6sk1Am++b8LE9g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when available
To:     Feiyang Chen <chenfeiyang@loongson.cn>
Cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        mika.westerberg@linux.intel.com, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        guyinggang@loongson.cn, siyanteng@loongson.cn,
        chenhuacai@loongson.cn, loongson-kernel@lists.loongnix.cn,
        chris.chenfeiyang@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 22 Aug 2023 at 13:55, Feiyang Chen <chenfeiyang@loongson.cn> wrote:
>
> When the current state is already PCI_D0, pci_power_up() will return
> 0 even though dev->pm_cap is not set. In that case, we should not
> read the PCI_PM_CTRL register in pci_set_full_power_state().
>
> Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> ---
>  drivers/pci/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..7e90ab7b47a1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1242,9 +1242,6 @@ int pci_power_up(struct pci_dev *dev)
>                 else
>                         dev->current_state = state;
>
> -               if (state == PCI_D0)
> -                       return 0;
> -
>                 return -EIO;
>         }
>
> @@ -1302,8 +1299,12 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>         int ret;
>
>         ret = pci_power_up(dev);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               if (dev->current_state == PCI_D0)
> +                       return 0;
> +
>                 return ret;
> +       }
>
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>         dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;

In fuction pci_power_up() there's another if-statement
if (state == PCI_D0)
        goto end;

That also will return 0 if need_restore isn't true.
What will happen then?


Would this work?

        ret = pci_power_up(dev);
-       if (ret < 0)
+       if (ret <= 0)
                 return ret;


Cheers,
Anders
