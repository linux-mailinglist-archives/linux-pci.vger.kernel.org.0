Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9656D7A4DB0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 17:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjIRP5f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 18 Sep 2023 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIRP5f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 11:57:35 -0400
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C385CE5;
        Mon, 18 Sep 2023 08:55:59 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso3924140b3a.1;
        Mon, 18 Sep 2023 08:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052360; x=1695657160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+ijkjKH5/utcBzTS1qWbvES1cIqKMJukpH/4RUxOxU=;
        b=TIDp+DOhreAcyKIbDwb63fopLvydd+bxqsw4KzNGS6LtlCofAOMqFXZ8SL1iwnAj83
         wCwMeNFbPosl3kgC6VYH9u5DtYN9vlcOiOxozc9zYM9XbZ6GjutR0hnXHaijGlUwlmfl
         +Bx1ExORnMutu5FlgmEiPGgcHjDESc+xQQj9xnO1Uj1uVcExHCJ0Rq350eR7Yx5GoFtW
         sTJ94hL9gzf/LPIiAV8I0pU8NzzndLRewIFCVt8lEEATkTdvlMe7de1IxbC4XFXDYsZF
         MTrNpUWWFydjfPHsxElUMK1oTax4DfwFhdcSA1ilaVmlho+xkS+B0WuyRJu26j/E9Y8+
         +3tA==
X-Gm-Message-State: AOJu0YyyWj9LkM5c25eCA6J3a9x7QKyYS7KPHd1P+I6SoGAgTcPl961p
        HU5BItKS5/ggB2thjizzuh/6+TfPXL5WXQ==
X-Google-Smtp-Source: AGHT+IHfW6dAe3J6ycGD22v1wqVRZqL/PqMv6I2RTGNlk4HbxzAljVGDvFo0iuq78lQZz7Q2rmYjCw==
X-Received: by 2002:a05:6358:249d:b0:134:e603:116e with SMTP id m29-20020a056358249d00b00134e603116emr8298299rwc.6.1695051279944;
        Mon, 18 Sep 2023 08:34:39 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id g186-20020a0df6c3000000b0059b3e6a2ebfsm2650482ywf.119.2023.09.18.08.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:34:39 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59eb8ec5e20so6878567b3.3;
        Mon, 18 Sep 2023 08:34:39 -0700 (PDT)
X-Received: by 2002:a81:7bd5:0:b0:59c:150:4155 with SMTP id
 w204-20020a817bd5000000b0059c01504155mr9726853ywc.39.1695051279611; Mon, 18
 Sep 2023 08:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <87db26af4a30210ab54519b91bb8541e88519185.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <87db26af4a30210ab54519b91bb8541e88519185.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 17:34:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUR55fozetp_no-X=_as=TcFwc06vYE_3tkskRaDkiA1Q@mail.gmail.com>
Message-ID: <CAMuHMdUR55fozetp_no-X=_as=TcFwc06vYE_3tkskRaDkiA1Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/30] drivers/pci: Add SH7751 Host bridge controller
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-pci@vger.kernel.org
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

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> ---
>  drivers/pci/controller/Kconfig  | 9 +++++++++
>  drivers/pci/controller/Makefile | 1 +

Please combine this with "[RFC PATCH v2 07/30] drivers/pci: SH7751
PCI Host bridge controller driver.".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
