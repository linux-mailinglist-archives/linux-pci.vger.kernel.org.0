Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2F783DCD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 12:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjHVKXt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 22 Aug 2023 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjHVKXs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 06:23:48 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FA91B2;
        Tue, 22 Aug 2023 03:23:47 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bca018afe8so1139008a34.0;
        Tue, 22 Aug 2023 03:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699826; x=1693304626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eL1dcJHTRjYqwHPIQszdBWz/GPp2gmn4+7V7RXDtqAs=;
        b=DFi1WYXUEqODo0s78laRgTkK5SBEmQbHmIzHicQor8tLbIK1Cc2NZNCDCTXGbL5kSM
         bnIn9xasS+s5Z6834BUUTBKms+b3VokvxwtkYifNgUbSLL6lPWCX4evPLavQTfSYTlJk
         DLdPBBKukSh1ZYAePkxkfjYsWSYi0AMdsqZey9RSmMtpageeVn7xRFwz+UlJ/eD8DQph
         T6o5aJXK84DD4SOCElqj7WROi8m65LffnBhd9vPD9wdOOWTfOPk/fQ4yxfNdgGYhWvXc
         TzLMyhw3HmZCf2HwxBOatBVRqA5E0zgF98oHgALeclB9uwCR93oM6bDg55ZZIadSSvv3
         NY4g==
X-Gm-Message-State: AOJu0Ywt0pRTM9Zz0wPCAROjQk04cqAog5LBG9cN9aqVo8jC4XVzg/M0
        iIMnIb1DnbwrHCj6tUD0uWtcVS1VpqPuoRnyJjM=
X-Google-Smtp-Source: AGHT+IGUe/rWbdrS1ZxSKqzYexhJTpHkoc0SVCyfpi7Af8o+ltoTZ210OQzmvZUILI82AEb1TbyXdrg4MYd9vtBdXF4=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr8601371oov.0.1692699826623; Tue, 22 Aug
 2023 03:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230822094136.621740-1-chenfeiyang@loongson.cn>
In-Reply-To: <20230822094136.621740-1-chenfeiyang@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 12:23:35 +0200
Message-ID: <CAJZ5v0hJ8AnaKrk=zeZHOm00YWqF2dYZGkDurDoMJHHVXZP8rg@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Only read PCI_PM_CTRL register when available
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

On Tue, Aug 22, 2023 at 11:41 AM Feiyang Chen <chenfeiyang@loongson.cn> wrote:
>
> If the pm_cap of the PCI device is unset, do not read the
> PCI_PM_CTRL register in pci_set_full_power_state().

So this is the case when the current state is already 0 and so
pci_power_up() returns 0 even though dev->pm_cap is not set.  This
should be mentioned in the changelog.

> Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> ---
>  drivers/pci/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..d6671cefcfa7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1305,8 +1305,10 @@ static int pci_set_full_power_state(struct pci_dev *dev)
>         if (ret < 0)
>                 return ret;

IMO it would be better to move the dev->current_state == PCI_D0 check
from pci_power_up() to this place, that is

if (ret < 0) {
        if (dev->current_state == PCI_D0)
                return 0;

        return ret;
}

because nothing more needs to be done below in that case.

>
> -       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -       dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> +       if (dev->pm_cap) {
> +               pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +               dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
> +       }
>         if (dev->current_state != PCI_D0) {
>                 pci_info_ratelimited(dev, "Refused to change power state from %s to D0\n",
>                                      pci_power_name(dev->current_state));
> --
> 2.39.3
>
