Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3981E47DEDE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 07:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346519AbhLWGEp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 01:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhLWGEp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 01:04:45 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138BC061401;
        Wed, 22 Dec 2021 22:04:45 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id 107so8059634uaj.10;
        Wed, 22 Dec 2021 22:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XR6lLGbVM6j7f4TfkI4T9+Vc1GDEp24Th+tejsjoxM=;
        b=oCkF2NqSMEBD27LuyLui+c1YfgkjfBk8KbOz3NpkBbqBCGkH+Am255FfH3A/ZInq1i
         9YAZ+6HEjD1ePXpL4g6t2YLZZRYHBlZz3DRYmc6b4WU3KsEHqTP4cap8zD4odOcCuYgW
         B1M6rQAxQBHi/UXnk2FSr2cjl9ua/l/VygNdQTOm2xz3ruEWwr5oAF3VLK0mMShGLyGj
         V0vwQNy/4meKoBr87E2Ofwnmzw9hRKBqu4+2TVYAs1VPO0vc4WEZmDh1rFlG0u7L4dYN
         q2MabiPjPNsCUzTxWMJXt74g7/73nE2AedFxCs+Ga4MLRefdbZZdi9CU6nUo/JpYs10Q
         jdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XR6lLGbVM6j7f4TfkI4T9+Vc1GDEp24Th+tejsjoxM=;
        b=n5e9Lo2jYG/R119gRKH9sYkBtTWCxxeYttb/AKQeg221dgdpKzM2qugqyDRuZQ/Mio
         goHBCFX+5bf8WUa69nPzaQ+uWDYeaiUke4hlNEYcVORP+mGuGD9tKM96M73bXcJwP0vy
         rrXan4bkscDPzkYWuJOIJ6if/eKj4VTD3VY5H6oIeHKj7ZUWTElv5dOFvppo+49b9mO1
         hpSS7ednR87GT+wVyvcxmrD0Ch2cXGB5Ssv58SBpYq8MyH4vHbMwODXHrqQ//ZMSTITr
         VQNVidx7sWSbzQlpFEHqnmlhx2DtFdCS0lA4JA+PMEeNket/SlnXohJ5wacHy5nlvdLb
         dfbg==
X-Gm-Message-State: AOAM532jG3eHh6vD2JVZ4dZFPu9OGX3Jak/6mB7/pDQCFaeSCYZ864+A
        zFK+U9l+j4BvSUFS1r3gPz0j71ov3jlQERPM6tSLgeK9IEY=
X-Google-Smtp-Source: ABdhPJwDbDuTISDqi+zhcgqOH8q9fsGiDk2NL6+HYKcHrWYWMNkFIpfqAnN28lPSHiN/kXqoasNjJlA6DBNeXSFbgL8=
X-Received: by 2002:a67:d51e:: with SMTP id l30mr255332vsj.1.1640239484159;
 Wed, 22 Dec 2021 22:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20211223011054.1227810-1-helgaas@kernel.org> <20211223011054.1227810-17-helgaas@kernel.org>
In-Reply-To: <20211223011054.1227810-17-helgaas@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 23 Dec 2021 07:04:32 +0100
Message-ID: <CAMhs-H-nSTLiqgw4LxEPBiTGLh7L4n1mm4FbgOCdzCGxK5e47w@mail.gmail.com>
Subject: Re: [PATCH v2 16/23] PCI: mt7621: Make pci_ops static
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Dec 23, 2021 at 2:11 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> mt7621_pci_ops is used only in this file.  Make it static.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> ---
>  drivers/pci/controller/pcie-mt7621.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index b60dfb45ef7b..4138c0e83513 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -148,7 +148,7 @@ static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
>         return pcie->base + RALINK_PCI_CONFIG_DATA + (where & 3);
>  }
>
> -struct pci_ops mt7621_pci_ops = {
> +static struct pci_ops mt7621_pci_ops = {
>         .map_bus        = mt7621_pcie_map_bus,
>         .read           = pci_generic_config_read,
>         .write          = pci_generic_config_write,
> --
> 2.25.1
>

This one was already sent and added to Lorenzo's tree. See:

https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/mt7621&id=8a0c1afb8560c2f64bcbdb559931f5ca8b83de87

Thanks,
    Sergio Paracuellos
