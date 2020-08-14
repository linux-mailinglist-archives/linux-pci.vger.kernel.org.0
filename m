Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C749E244C53
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHNPvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 11:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgHNPvK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 11:51:10 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660DF2065C;
        Fri, 14 Aug 2020 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597420269;
        bh=Iz49/lPLFhH+6nCqxuxoI6YovUPNpCIHAW3SX/qxQYo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cGOiBQusy6JKsx8U5w07zf2ZfdaFMUvpYbXzIIYMG3IJRHEab8cHamYLdPBckaowa
         A4SR37EgAMugOqf0GFkHpntz/eRLXhXFnt3NZ3hT0oGypmHuoDoRokcVVLxSFtgdyg
         R2dGt3o19QHOdBhNNSfZEM4im7sRxJajoA/LDOh4=
Received: by mail-qt1-f179.google.com with SMTP id k18so7222906qtm.10;
        Fri, 14 Aug 2020 08:51:09 -0700 (PDT)
X-Gm-Message-State: AOAM533AnUwJm9cW2q3CKT/1KsmsI3q+/mUneqMUmkF9QkYyJ/3ARst/
        uC6ks0J45PhLgbZLJt8sjd0A4oJe9qNZCtIgJg==
X-Google-Smtp-Source: ABdhPJwalDgAOrAcn5WYJDfouU4gwDgJP0qyY9UfEF240aXWt0tyu0IbpZMWP+9YK9OyrxWKAX8nUaT5mkjgztf1fuE=
X-Received: by 2002:aed:24f2:: with SMTP id u47mr2591700qtc.137.1597420268638;
 Fri, 14 Aug 2020 08:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200814080813.8070-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20200814080813.8070-1-Zhiqiang.Hou@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Aug 2020 09:50:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+a7kRVgnRhOxffZedz3M3s3DPcB6Q_tc4_Vu-WT55ZDQ@mail.gmail.com>
Message-ID: <CAL_Jsq+a7kRVgnRhOxffZedz3M3s3DPcB6Q_tc4_Vu-WT55ZDQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: designware-ep: Fix the Header Type check
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 2:15 AM Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> The current check will result in the multiple function device
> fails to initialize. So fix the check by masking out the
> multiple function bit.
>
> Fixes: 0b24134f7888 ("PCI: dwc: Add validation that PCIe core is set to correct mode")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 4680a51c49c0..4b7abfb1e669 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -654,7 +654,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>         int i;
>
>         hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> -       if (hdr_type != PCI_HEADER_TYPE_NORMAL) {
> +       if (hdr_type & 0x7f != PCI_HEADER_TYPE_NORMAL) {

Should have () around 'hdr_type & 0x7f'.

>                 dev_err(pci->dev,
>                         "PCIe controller is not set to EP mode (hdr_type:0x%x)!\n",
>                         hdr_type);

However, shouldn't the printed value be masked too? I'd just do:

hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) & 0x7f;

Perhaps add a #define too. '0x7f' is used in several places.

Rob
