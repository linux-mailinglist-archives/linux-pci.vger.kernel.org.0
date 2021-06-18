Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36F3ACAA6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhFRMOW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 08:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhFRMOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 08:14:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FCC061574;
        Fri, 18 Jun 2021 05:12:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id he7so15506243ejc.13;
        Fri, 18 Jun 2021 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slXAXg1e2tsmaa9oPiftsSJgeXYcSGg3D4R78XBvMRw=;
        b=qwWNKKGFzMLQylLGpNs12wBfRnyVhAQbPU/ZmXjzNrbJxJxn6AbZShqjD5XWZXuMpY
         iWaNFGbRM591p1VvDIHrd5Shgi1BIXza8Q3/rlNrwPOWduI84z/OAmEuuRBfQevDnW7s
         iZpYraPMYIV7RH3dxv5IJeN7mksx8N5K2458yB1Ja9kznROTqvHYqs5Nj7pBh4K8f2h4
         Pxj3We7xy1ilNjmPcTwZUzA/SbouLq9Im30Wv3/xjasmgXfv6Nfodq4o/zACdVF7J8zi
         uv43EPpFBTga2yaTe1zxryYNe/MwL06Nsn72SNcH3zVuJuzQidCMJjMmiixoG5cGSofO
         Jf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slXAXg1e2tsmaa9oPiftsSJgeXYcSGg3D4R78XBvMRw=;
        b=NC4L40C6Pb1A/LzlWvEcoRG1Q7rITo2ifdtmgMdQM20yFwtCXnQISJRv8anbPT9OgI
         NSEGRLE+BaymB3UZ+yxbf3fOVGewUlOOExHlNY4PHWlwcEUTEMCHiqSwq5MKdRdxo3YT
         B6VyYUi8RE40fNcjVfwXGK9+K2Zj3ycAcsU3wRgCP+qahu2QaiN93vcHI9ZV/oIhIuvF
         2e79Tox2+kcV7FEAgquRJwJA6Mxj/aBRQWxq9z8ko/dLsykMr603+BWE5S2k5b+2jC7r
         j93zHxtfgslOcpO707361g0KDFSwFM2XLiN5X1QlM+GmZ7R4Qr1J0j0shGJe3PGrNLBd
         Samg==
X-Gm-Message-State: AOAM530nhe8/Z7zSrjAy+PGXEW2pP87PChsE2e1HRvRsHBweNlvs2L7u
        lon+XZFg6iABBS0FBJHa5DNR8sj0s3eFHF263fKn3hMNY2A=
X-Google-Smtp-Source: ABdhPJwmZRzjmbGWTNRuKw75VrQ7GwYY3ZIuThEwzm4NkvcTZ8KreujakRXXykcCfLaS3NVfU08UJp95NW5pTSQ6CJ4=
X-Received: by 2002:a17:906:3b99:: with SMTP id u25mr10752296ejf.539.1624018328711;
 Fri, 18 Jun 2021 05:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210618063821.1383357-1-art@khadas.com>
In-Reply-To: <20210618063821.1383357-1-art@khadas.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 18 Jun 2021 14:11:58 +0200
Message-ID: <CAFBinCB6bHy6Han0+oUcuGfccv1Rh_P0Gows1ezWdV4eA267tg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: meson add quirk
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, yue.wang@amlogic.com,
        khilman@baylibre.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, jbrunet@baylibre.com, christianshewitt@gmail.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Artem,

On Fri, Jun 18, 2021 at 8:38 AM Artem Lapkin <email2tema@gmail.com> wrote:
>
> Device set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
> was find some issue with HDMI scrambled picture and nvme devices
> at intensive writing...
>
> [    4.798971] nvme 0000:01:00.0: fix MRRS from 512 to 256
>
> This quirk setup same MRRS if we try solve this problem with
> pci=pcie_bus_perf kernel command line param
thank you for investigating this issue and for providing a fix!

[...]
> +static void meson_pcie_quirk(struct pci_dev *dev)
> +{
> +       int mrrs;
> +
> +       /* no need quirk */
> +       if (pcie_bus_config != PCIE_BUS_DEFAULT)
> +               return;
> +
> +       /* no need for root bus */
> +       if (pci_is_root_bus(dev->bus))
> +               return;
> +
> +       mrrs = pcie_get_readrq(dev);
> +
> +       /*
> +        * set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
> +        * was find some issue with HDMI scrambled picture and nvme devices
> +        * at intensive writing...
> +        */
> +
> +       if (mrrs != MAX_READ_REQ_SIZE) {
> +               dev_info(&dev->dev, "fix MRRS from %d to %d\n", mrrs, MAX_READ_REQ_SIZE);
> +               pcie_set_readrq(dev, MAX_READ_REQ_SIZE);
> +       }
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_pcie_quirk);
it seems that other PCIe controllers need something similar. in
particular I found pci-keystone [0] and pci-loongson [1]
while comparing your code with the two existing implementations two
things came to my mind:
1. your implementation slightly differs from the two existing ones as
it's not walking through the parent PCI busses (I think this would be
relevant if there's another bridge between the host bridge and the
actual device)
2. (this is a question towards the PCI maintainers) does it make sense
to have this MRRS quirk re-usable somewhere?


Best regards,
Martin


[0] https://elixir.bootlin.com/linux/v5.12/source/drivers/pci/controller/dwc/pci-keystone.c#L524
[1] https://elixir.bootlin.com/linux/v5.12/source/drivers/pci/controller/pci-loongson.c#L63
