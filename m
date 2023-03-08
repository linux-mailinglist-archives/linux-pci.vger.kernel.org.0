Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594B46B1283
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 21:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCHUBG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 15:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCHUBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 15:01:05 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FF6B719C
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 12:01:00 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id s1so16466994vsk.5
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678305660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiNCWoLz3c/503W2sfojq25rl/kZxCOdrOLAup4Rmwo=;
        b=NNrfEUVmR+mZeQysb05W4Sj5tC7LtLoMf313pV2A76V9DHpNFR0yY3m0+NBt2DXCru
         vwlgz6pd+RNPc9BngfiJXNgY1bl1A3Yyo7faNSGIrZoymKE7i65kiUdOPo0UAPeLpBWz
         J04olGSVimHV1DyP5hJVA3ap5WCvm3irq+hG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678305660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiNCWoLz3c/503W2sfojq25rl/kZxCOdrOLAup4Rmwo=;
        b=mDRSz72e8PyRGj4UBcfYksNuug0o3sG6pBVuLlXA0DTxAk9WZc0b/OGh62qzj7vWfF
         AUCMlWH3ubP+4eeHXA4CD7W8Ga/ahNZ7nODvt51hmKw7iwvbuolh0h2uCrMY/jc55bhu
         0ro7xlLg/SJbLXPMFnLtpti+98i3MRcm5xTzyqlBIBUmapC7QRmZdhzf5+JEJ2tRmo5l
         DgCuLeHqadfhtnSLWZq4g/PMBG4kKLo9x5qECVXziinLaHlJ3amYanqJU7l+sC3KqlHi
         w/wF+pGNhmMkAOOJFfeagdryoTWEfVxTfPH/+B2rowv22+dUH4A5+dgeZR58dGeJLbWP
         TImA==
X-Gm-Message-State: AO0yUKVaJUZKv8AuNyWymMvKq8ARWQVC64jX2P4rzXgqx0BzrJMf/lNz
        WNvirHa9kd5uzgu/lVwaCsKsgdX/8+SJCYLfYxeNCA==
X-Google-Smtp-Source: AK7set85JyXeUavfBPCvXk86419F+WXZZSMRecR5Kl2iJ+RcOKGb5j+7JEgJUz86ywX7sr11eiBykb7yxQ1Tpb+1MEc=
X-Received: by 2002:a67:fe14:0:b0:412:ba5:8002 with SMTP id
 l20-20020a67fe14000000b004120ba58002mr18964498vsr.1.1678305659793; Wed, 08
 Mar 2023 12:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20230301060453.4031503-1-grundler@chromium.org>
In-Reply-To: <20230301060453.4031503-1-grundler@chromium.org>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 8 Mar 2023 12:00:48 -0800
Message-ID: <CANEJEGvB0+XTgUwJi80BRFpNYWrbtiz17baSoxcR_OpSdnzahg@mail.gmail.com>
Subject: Re: [PATCH] PCI/AER: correctable error message as KERN_INFO
To:     Grant Grundler <grundler@chromium.org>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping? Did I miss an email or other work that this patch collides with?

cheers,
grant

On Tue, Feb 28, 2023 at 10:05=E2=80=AFPM Grant Grundler <grundler@chromium.=
org> wrote:
>
> Since correctable errors have been corrected (and counted), the dmesg out=
put
> should not be reported as a warning, but rather as "informational".
>
> Otherwise, using a certain well known vendor's PCIe parts in a USB4 docki=
ng
> station, the dmesg buffer can be spammed with correctable errors, 717 byt=
es
> per instance, potentially many MB per day.
>
> Given the "WARN" priority, these messages have already confused the typic=
al
> user that stumbles across them, support staff (triaging feedback reports)=
,
> and more than a few linux kernel devs. Changing to INFO will hide these
> messages from most audiences.
>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
> This patch will likely conflict with:
>   https://lore.kernel.org/all/20230103165548.570377-1-rajat.khandelwal@li=
nux.intel.com/
>
> which I'd also like to see upstream. Please let me know to resubmit mine =
if Rajat's patch lands first. Or feel free to fix up this one.
>
>  drivers/pci/pcie/aer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f6c24ded134c..e4cf3ec40d66 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -692,7 +692,7 @@ static void __aer_print_error(struct pci_dev *dev,
>
>         if (info->severity =3D=3D AER_CORRECTABLE) {
>                 strings =3D aer_correctable_error_string;
> -               level =3D KERN_WARNING;
> +               level =3D KERN_INFO;
>         } else {
>                 strings =3D aer_uncorrectable_error_string;
>                 level =3D KERN_ERR;
> @@ -724,7 +724,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_=
err_info *info)
>         layer =3D AER_GET_LAYER_ERROR(info->severity, info->status);
>         agent =3D AER_GET_AGENT(info->severity, info->status);
>
> -       level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_WARNING =
: KERN_ERR;
> +       level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_INFO : K=
ERN_ERR;
>
>         pci_printk(level, dev, "PCIe Bus Error: severity=3D%s, type=3D%s,=
 (%s)\n",
>                    aer_error_severity_string[info->severity],
> --
> 2.39.2.722.g9855ee24e9-goog
>
