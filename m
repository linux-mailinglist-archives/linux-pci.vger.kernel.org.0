Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788D27849BF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 20:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjHVSym convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 22 Aug 2023 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHVSym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 14:54:42 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A810B;
        Tue, 22 Aug 2023 11:54:40 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68a32506e90so743403b3a.1;
        Tue, 22 Aug 2023 11:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692730480; x=1693335280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvDQtztLIY+cdOtcu3sc3WtCIys2WUi05X4v/3QNJBs=;
        b=ajeJFNr60m9ofo41tyeO/ZLWqSv7Xa8QDvEBu3mvJky5aBnHWQwGuCSVFHdu1Zmndx
         jAonec1WA2QMfngXisch7gZ5x8IVJgdlVHnCH+KoBC3TpTB8zMyPdNJf/WLY5TALntaF
         OAHnrsuHFf/kAt5Mu1u/ZLMZexPykPFgDbAoirm4xyKNm6bueyQrVjJQ9geeGRE8Oy7J
         Dp92EhZJ5/tDqaPu78B48JS5BpFf+LHS4C9Gggg5vk4ScxuACFNMwkH7uyK1weq8UBmt
         m37D4Inl2fA1mzQzjZgxXotq4lU8FTFwMFSxxb1JtD8scN/JpCic90EAomMTJ7TyXxBL
         YrZg==
X-Gm-Message-State: AOJu0Yx9/a4NCfO1dQbMtOflDeBI29zsFF6MCdwhkyAk9X6cuBEBcoD6
        1HG6QU5v49/EggkPg9YZSimsD4Cun9xObuHjwdg=
X-Google-Smtp-Source: AGHT+IFqJaPZoitnFsoD0BvnxsjVda1SXYA8SQRmkLHzByCU5AnsucL7HDuA1V69fu68SF3SA5w6skk9ICdrGAJrxQk=
X-Received: by 2002:a05:6a00:2d0c:b0:676:2a5c:7bc5 with SMTP id
 fa12-20020a056a002d0c00b006762a5c7bc5mr11676824pfb.1.1692730480210; Tue, 22
 Aug 2023 11:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230822115514.999111-1-chenfeiyang@loongson.cn>
In-Reply-To: <20230822115514.999111-1-chenfeiyang@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 20:54:28 +0200
Message-ID: <CAJZ5v0iGLe6XEpvf0uvHuCE3c-_BtVrPw+3rn=EP=8HrX2rmSg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when available
To:     Feiyang Chen <chenfeiyang@loongson.cn>
Cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        mika.westerberg@linux.intel.com, helgaas@kernel.org,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn, chris.chenfeiyang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 22, 2023 at 1:55 PM Feiyang Chen <chenfeiyang@loongson.cn> wrote:
>
> When the current state is already PCI_D0, pci_power_up() will return
> 0 even though dev->pm_cap is not set. In that case, we should not
> read the PCI_PM_CTRL register in pci_set_full_power_state().
>
> Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

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
> --
> 2.39.3
>
