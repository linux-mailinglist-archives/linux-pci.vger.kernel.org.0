Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD7222AF8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 20:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGPSXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 14:23:13 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPSXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 14:23:12 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mn2Fb-1kfxPt3VPr-00k99o; Thu, 16 Jul 2020 20:23:11 +0200
Received: by mail-qk1-f179.google.com with SMTP id 80so6447878qko.7;
        Thu, 16 Jul 2020 11:23:10 -0700 (PDT)
X-Gm-Message-State: AOAM530huo458TG5uk3Z/WsTLqhlmCFbrPZjAMEQAI827hRKlTINiWTw
        ez81v9L38s7QIwEJHT5pbXXDfw07c3Cu6qP0quk=
X-Google-Smtp-Source: ABdhPJxGrriyRsR3c/KbpnjkC2s9ZK2i9yjLtrI7t9taPXMe6YEy79uW5SDiSgg7Rvt4nATRSACGzmEr51YGyOvKzdk=
X-Received: by 2002:a37:a496:: with SMTP id n144mr5371218qke.286.1594923789486;
 Thu, 16 Jul 2020 11:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
In-Reply-To: <20200716141534.30241-1-ulf.hansson@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Jul 2020 20:22:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
Message-ID: <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Rui Feng <rui_feng@realsil.com.cn>,
        linux-nvme@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+TjDQ9YUAMYyAEtk98Cm3V/08UfVGlPkR6Yp9cG9e0a8gFt3h07
 3AnnmZL7waJLYasGA6NDFjQPYJ1yyyRYpJf/wasOBsOi4+LI2SFJOwBHKzL+ITG6Sf69tP7
 I88E1UDokMqPfftDjM+1wQ5thTYl46T59zRHIayUPGPWloZw6G0H3LF9seqGcwZPmxWguCy
 oxPxlBaX81A+9jNsiFEmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uZs/R89mfro=:SC6jXf7/yn75Xjer/U6coL
 +JsUU+t2kRt3Iq74fK9DOUlLz+2EjGqKwjd9492PCn8BA3abiZoUdTaxd3HjpTc2UNBRJLUFY
 MYI0aXbZ5Mtefnkrr1IU7+Ryex8gBsBFCJUd7wgc/q2NUpMjC3tKJ2t7B4WpFQT20q/JkBLgp
 GWHmjzhFTeviqwDElHZ3P1oUG4ILOZDtsTVcHUoL4YFKxuoGvE131PgZukPPGdjxZKf0aiRSP
 BAAWEeSCCR9LBNleJ13Jt97ia1cG09ET57QocXeE9lLse2ftTYG71PpibgmF49NVUnrDX5PxL
 GjlTebdmXKHddFzGNAa8SUKayjFDiJk3PajwcSbiAMf422F+sa3LkeAY7A/0B/YKNUI7mnhuZ
 0QG1Ar2J3JYYg5ycoLvdiQ2w5TbUD0iwbrN/ZDiDpCSs2Qo+pFaUmLA0bBx0rjHbwqceF6tpu
 cn2FUBxzAEYDmWhuU1WeqEuIiKSJom0z0UvL14uLbPnlqhaTtSHiaoT4Zm0gW4br0FcvhxAQK
 7TX9qqk/Do4JxM+Sd6yGIXwaRa/4EWQOV1XXXJkdDtF+RrhM4EhmWRohgb2D4HAbmGh4KxieG
 phUnjQZcH+8KsHRIhMddZnfz7qHITNM2DrZTyb32M787r1rkDH9bdJAjlLhmQXoRHxabzlItI
 3wvfeM0Ob5O6SCpIp3NeBhhDa2cuSMH5WgAGlpQzy9M6aNj3FIhx4xFYEJ8cScIACQdNW5rXq
 onT1Ce7c2WI5PXhJZh9sco0+FW7g2jTjoYKtThNmchUQ1T1UBx75z9P7lgf1tsrU9lPGaCkIj
 B2lbFRovJGfGJ4Vaaw+7Hrhg4Y5Gmalr7VFQRIPR8fo3Lw1tE5XIaWFuxV8Rz6sG+5t7Zyv
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 16, 2020 at 4:16 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> +       /* Continue with the SD express init, if the card supports it. */
> +       resp &= 0x3000;
> +       if (pcie_bits && resp) {
> +               if (resp == 0x3000)
> +                       host->ios.timing = MMC_TIMING_SD_EXP_1_2V;
> +               else
> +                       host->ios.timing = MMC_TIMING_SD_EXP;
> +
> +               /*
> +                * According to the spec the clock shall also be gated, but
> +                * let's leave this to the host driver for more flexibility.
> +                */
> +               return host->ops->init_sd_express(host, &host->ios);
> +       }
> +
>         return 0;
>  }

Does this need an additional handshake or timeout to see if the
device was successfully probed by the nvme driver?

It looks like the card would just disappear here if e.g. the nvme driver
is not loaded or runs into a runtime error.

     Arnd
