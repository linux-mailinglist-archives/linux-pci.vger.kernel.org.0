Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC4766B44A
	for <lists+linux-pci@lfdr.de>; Sun, 15 Jan 2023 23:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjAOWC4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Jan 2023 17:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjAOWCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Jan 2023 17:02:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B531817E
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2023 14:02:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so20958046wms.2
        for <linux-pci@vger.kernel.org>; Sun, 15 Jan 2023 14:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2dZCDFQTlUSfzSrB9L9rWAmCeVgrewqdX+JmfnJMsE=;
        b=bKW6B2uEddzMu9EiNkOlUHF28h6D0/0SsjBsoK5rsZR++sDUeukaX4IqJEwVn2Rrsg
         OwubldIDKRQ2OK7BSK6DQB+oV52vlW+oMD2r9VCwTGDw/kA5+XQ7J78Cq1GewF6lEL7t
         U1ws4f76X71IdPiKIjer8fAQQWRHRRkuwhlHmuzECdUA04p15oObJ7zwV0RvcwqZIzOZ
         eRByvTkXFj+2AJ9o/nVphMIEwkSegBCbwykRtY1LRXsn0kPWtWa0mJ/HHvaNnwOOQ1s8
         HlpqgcXgb0POyVLptt1ysrivmDw8KbBBApEUNoM3hCxaTb/sIGrOGDVjCZIQO7OZ8osh
         JAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2dZCDFQTlUSfzSrB9L9rWAmCeVgrewqdX+JmfnJMsE=;
        b=68cJ4gPX5RmKOT7a+7fg7Q6bSytsxGATkhtok2tL76itEFexTcvP/N6fWstFqtE5kl
         GTYxtXR93tnRzLGZgedDGs7eduB4CMAWQpZ2QjgOl8jbbFYdTncR7WZvQhooyYX4P0yD
         acChJbUh4t41oAMTNFxDKj7SLbCrI6RlQozxKdnpdsXq/PYhF1CqY8JzDVQ102x5LPDl
         4JOWH9JqpIjcVirxH1n9EBTAVZyjHe9FqvuI+5m1pOIdmbUjxOExrNyd5R6b/WdX/ikP
         iWJkU1XGOeYXqvcA+m2tv4sN/yujNFToi38j3eEmIqhmQEfTAesdJfCyNUlD6nnpDJpV
         lwZA==
X-Gm-Message-State: AFqh2koEQsFdqQZFqPw3gAvmSatA3O21SvVWeTWiIzslDLsM/fJ+mRB/
        jETYNMePy0nt0us94tQpH+rI92E2RGjE70jX/dy2FE3jQMk=
X-Google-Smtp-Source: AMrXdXtT1nR4fpJ/cCktYNXm+0JUr3dGXMfWfXwD3RO3i5ReXznClFy2atjwkFm2uxitEbsQj1BrHpxcAPM7tW93nHw=
X-Received: by 2002:a05:600c:c85:b0:3da:7c42:4cbe with SMTP id
 fj5-20020a05600c0c8500b003da7c424cbemr295933wmb.24.1673820172702; Sun, 15 Jan
 2023 14:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20230114164125.1298-1-pali@kernel.org>
In-Reply-To: <20230114164125.1298-1-pali@kernel.org>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Sun, 15 Jan 2023 22:02:41 +0000
Message-ID: <CAEzXK1qKu_3hpK4+QTv9STBOY0qYkofLCPaE_bioOjip_nVGJg@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I don't want to interfere, however I would like to contribute my
opinion as an end user of PCI_MVEBU.
I have been using Linux on a custom built hardware with an Armada
A388, for several years, and to me the most critical component for
getting PCIe working right in Linux is the u-boot version. Although
I've stopped trying the official u-boot releases as well as the SoM
vendor u-boot versions, because I don't have much time available to
tinker with those, however the ones I have tried always failed to
bring a working PCIe environment under Linux. So I am stuck with a
u-boot based on the Marvel release 2013.01.
It was key to getting PCIe working in Linux, other than that, all
Linux kernels have worked fine and I have been using an AMD RX550 PCIe
dGPU and a DVB-T/DVB-S PCIe tuner card simultaneously, each in its own
slot, without issues for all these years.

Thanks,
Lu=C3=ADs

On Sat, Jan 14, 2023 at 4:51 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> People are reporting that pci-mvebu.c driver does not work with recent
> mainline kernel. There are more bugs which prevents its for daily usage.
> So lets mark it as broken for now, until somebody would be able to fix it
> in mainline kernel.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> ---
> Bjorn: I would really appreciate if you take this change and send it in
> pull request for v6.2 release. There is no reason to wait more longer.
>
>
> I'm periodically receiving emails that driver does not work correctly
> anymore, PCIe cards are not detected or that they crashes during boot.
>
> Some of the issues are handled in patches which are waiting on the list f=
or
> a long time and nobody cares for them. Some others needs investigation.
>
> I'm really tired in replying to those user emails as I cannot do more in
> this area. I have asked more people for help but either there were only
> promises without any action for more than year or simple no direction how
> to move forward or what to do with it.
>
> So mark this driver as broken. Users would see the real current state
> and hopefully will stop reporting me old or new bugs.
> ---
>  drivers/pci/controller/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kcon=
fig
> index 1569d9a3ada0..b4a4d84a358b 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -9,6 +9,7 @@ config PCI_MVEBU
>         depends on MVEBU_MBUS
>         depends on ARM
>         depends on OF
> +       depends on BROKEN
>         select PCI_BRIDGE_EMUL
>         help
>          Add support for Marvell EBU PCIe controller. This PCIe controlle=
r
> --
> 2.20.1
>
