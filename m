Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85CC1CB6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfI3IRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 04:17:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39244 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfI3IRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 04:17:45 -0400
Received: by mail-io1-f68.google.com with SMTP id a1so35976429ioc.6
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 01:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TH3m+6Q+0+bfIH6QRVOU2TE/KWS9g6tELRTADf99+UA=;
        b=LA4fpFr0nZtdMQVjGuyfQDf5UUUdTgIIUoHLP7bCHvX433V9UDdKcB5NM8BlyL2WZg
         NlExm1cjwbuJFiKIvrmJV56Bq24wGSYkXh46yP0jR7b+d3Lbf85oEhrjRwy2UIKFAUk1
         K9GujcuOjBxH0WCsUYHg+tHQD/2BdNBf+lmMHeb9CL30Flv3+FHJYNlLJWtaAMyZIQtF
         2NutFHRv+WQ8TE1EBwUU8TJVDYk5ylV2Y1AU7asEiwMyTkpm8KKNMlRDjPN+mJn5xJEX
         90oB98CaeA46xmETxhn1cuFixOLIMb+nTnFZYpmVaUpODcWovGSkG0JRC0aHusqTOaQG
         BU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TH3m+6Q+0+bfIH6QRVOU2TE/KWS9g6tELRTADf99+UA=;
        b=JKLkIgUvMO4M0l2CMi/6k/8Hb0UxfMLIMnkotshL96AGBv2tNm2d8EsEUKt6H+IpXn
         Uvwp2cXU06cPw/LSRFTaLggI4KKIqonKC4H8B1tOL7TnRpj4Jopzp/22gVOVii1aEUlG
         i/LVMC7baPpKrJrpaom1Pf9BE7jMCyvYp8RmrMHe3JGR7ynbeeVQfcPCfU1uNUEEMEl6
         2wKSSJ1JmHOBEuxCOrQ1KDplBJDAZ9dXdhgXF5kxiWrPc520qjuAkJShn7sulfKiCPbY
         qGu4dgN0cQS6Ai+fiV/sSCjaPJikwUqJHveyQ8d0a1fqfFpNjFvtwqX6oi6jTwZzL8w5
         XZNw==
X-Gm-Message-State: APjAAAVipSrxeDUznHGoPK25Icu3PxnFcL0A3ihDdiz1t9waHK12imtQ
        FapTYEPBNZn2DCryooC6V8EiCArY6JW2dDcO3w7W3w==
X-Google-Smtp-Source: APXvYqwklr07magE3aQcrORDcgxIji9A+zij+RfpWhOSRucfuj75w3BNhd/t/1/buyYYoM1GThD215VgoPoqMs42Wk4=
X-Received: by 2002:a05:6e02:882:: with SMTP id z2mr19326174ils.131.1569831464105;
 Mon, 30 Sep 2019 01:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <1563279127-30678-1-git-send-email-jaz@semihalf.com>
In-Reply-To: <1563279127-30678-1-git-send-email-jaz@semihalf.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Mon, 30 Sep 2019 10:17:33 +0200
Message-ID: <CAH76GKMZy7z05Gc9HVDUkpM04+tXMa8xEEMBWMQ7Zx1Bt_B0xQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: aardvark: fix big endian support
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        lorenzo.pieralisi@arm.com, Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I want to kindly remind about this patch.

Best regards,
Grzegorz

wt., 16 lip 2019 o 14:12 Grzegorz Jaszczyk <jaz@semihalf.com> napisa=C5=82(=
a):
>
> Initialise every not-byte wide fields of emulated pci bridge config
> space with proper cpu_to_le* macro. This is required since the structure
> describing config space of emulated bridge assumes little-endian
> convention.
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
> v1->v2
> - add missing cpu_to_le32 for class_revison assignment (issues found by
> Thomas Petazzoni and also detected by Sparse tool).
>
>  drivers/pci/controller/pci-aardvark.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index 134e030..178e92f 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -479,18 +479,20 @@ static void advk_sw_pci_bridge_init(struct advk_pci=
e *pcie)
>  {
>         struct pci_bridge_emul *bridge =3D &pcie->bridge;
>
> -       bridge->conf.vendor =3D advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & =
0xffff;
> -       bridge->conf.device =3D advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >>=
 16;
> +       bridge->conf.vendor =3D
> +               cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) & 0xff=
ff);
> +       bridge->conf.device =3D
> +               cpu_to_le16(advk_readl(pcie, PCIE_CORE_DEV_ID_REG) >> 16)=
;
>         bridge->conf.class_revision =3D
> -               advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xff;
> +               cpu_to_le32(advk_readl(pcie, PCIE_CORE_DEV_REV_REG) & 0xf=
f);
>
>         /* Support 32 bits I/O addressing */
>         bridge->conf.iobase =3D PCI_IO_RANGE_TYPE_32;
>         bridge->conf.iolimit =3D PCI_IO_RANGE_TYPE_32;
>
>         /* Support 64 bits memory pref */
> -       bridge->conf.pref_mem_base =3D PCI_PREF_RANGE_TYPE_64;
> -       bridge->conf.pref_mem_limit =3D PCI_PREF_RANGE_TYPE_64;
> +       bridge->conf.pref_mem_base =3D cpu_to_le16(PCI_PREF_RANGE_TYPE_64=
);
> +       bridge->conf.pref_mem_limit =3D cpu_to_le16(PCI_PREF_RANGE_TYPE_6=
4);
>
>         /* Support interrupt A for MSI feature */
>         bridge->conf.intpin =3D PCIE_CORE_INT_A_ASSERT_ENABLE;
> --
> 2.7.4
>
