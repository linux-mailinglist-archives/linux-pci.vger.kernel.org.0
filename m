Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E673081CC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 00:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhA1XW5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 18:22:57 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:42689 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhA1XW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 18:22:56 -0500
Received: by mail-oo1-f53.google.com with SMTP id g46so1859244ooi.9;
        Thu, 28 Jan 2021 15:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydH4nhxewK7vs+CzByTZsj+twADBwFlu+n9oaryGu3g=;
        b=IJlJC3Qs0gVk7M/YqtVq22LZ8sjoohEOaF5AP3U4pIiKC3PYqtFyvYjqnEuZJHm/UC
         O4IJp0lOA8DtpDy+AAcIRyE5/yV55T/FMrz1zHjRu1OnDT/AiMZiF+avbx6gCDtun5/D
         2uojSCNJVhN1Md78PLMqs52zfZ9gQv+3alRtQZpQWI0wQf94fQ0+AYtwm602XQr5UhUx
         nP4oZgfMFLoILsZsfe3zBgjtZawV4nW1hq9euuc2adX6faztP9IfX2Ok8/8a3wqqVwGx
         OqWpvxw3MsC/pa5NvPF+74nmcNkUF9400sZb0WR+Q+9bJ9XlG+GgiICfSRZ8hQsgaCg4
         m09Q==
X-Gm-Message-State: AOAM5302vT+HO7BZNItQE/vbeFEF4ZJxbk1vHNIUKVwZl7o4ZOV+jYoF
        8gxmhsa0VmfAA2PsRukQUnhf30z4das=
X-Google-Smtp-Source: ABdhPJzFUzfv7gbRcuengnXOY5sHTHQQk8G+pTaTghZ5FijpRS07urmHAGpgzlyrL+/VeXxxP58SjQ==
X-Received: by 2002:a4a:a22a:: with SMTP id m42mr1356247ool.22.1611876134785;
        Thu, 28 Jan 2021 15:22:14 -0800 (PST)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com. [209.85.167.177])
        by smtp.gmail.com with ESMTPSA id t65sm1537692oie.25.2021.01.28.15.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 15:22:14 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id w8so7963523oie.2;
        Thu, 28 Jan 2021 15:22:13 -0800 (PST)
X-Received: by 2002:aca:f382:: with SMTP id r124mr1069457oih.175.1611876133354;
 Thu, 28 Jan 2021 15:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com> <20210108093610.28595-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20210108093610.28595-2-Zhiqiang.Hou@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 28 Jan 2021 17:22:02 -0600
X-Gmail-Original-Message-ID: <CADRPPNQr4xGH0On94rxr69VYeZAQEYQgt=CosVqEDi91cfO_tw@mail.gmail.com>
Message-ID: <CADRPPNQr4xGH0On94rxr69VYeZAQEYQgt=CosVqEDi91cfO_tw@mail.gmail.com>
Subject: Re: [PATCHv3 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, gustavo.pimentel@synopsys.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 8, 2021 at 3:29 AM Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> The dw_pci->ops may be a NULL, and fix it by adding one more check.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Hi Bjorn,

This is causing many layerscape platforms to fail to boot.  Can you
help to pick up this patch?  Or are you actually preferring other
solutions like creating dummy ops when it is not needed?

Regards,
Leo

> ---
> V3:
>  - Rebased against the latest code base
>
>  drivers/pci/controller/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 516b151e0ef3..0413284fdd93 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -429,7 +429,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>         dw_pcie_setup_rc(pp);
>         dw_pcie_msi_init(pp);
>
> -       if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
> +       if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
>                 ret = pci->ops->start_link(pci);
>                 if (ret)
>                         goto err_free_msi;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 645fa1892375..cf895c12f71f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -141,7 +141,7 @@ u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
>         int ret;
>         u32 val;
>
> -       if (pci->ops->read_dbi)
> +       if (pci->ops && pci->ops->read_dbi)
>                 return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
>
>         ret = dw_pcie_read(pci->dbi_base + reg, size, &val);
> @@ -156,7 +156,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
>  {
>         int ret;
>
> -       if (pci->ops->write_dbi) {
> +       if (pci->ops && pci->ops->write_dbi) {
>                 pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
>                 return;
>         }
> @@ -171,7 +171,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
>  {
>         int ret;
>
> -       if (pci->ops->write_dbi2) {
> +       if (pci->ops && pci->ops->write_dbi2) {
>                 pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
>                 return;
>         }
> @@ -186,7 +186,7 @@ static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
>         int ret;
>         u32 val;
>
> -       if (pci->ops->read_dbi)
> +       if (pci->ops && pci->ops->read_dbi)
>                 return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
>
>         ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
> @@ -200,7 +200,7 @@ static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
>  {
>         int ret;
>
> -       if (pci->ops->write_dbi) {
> +       if (pci->ops && pci->ops->write_dbi) {
>                 pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
>                 return;
>         }
> @@ -273,7 +273,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  {
>         u32 retries, val;
>
> -       if (pci->ops->cpu_addr_fixup)
> +       if (pci->ops && pci->ops->cpu_addr_fixup)
>                 cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
>
>         if (pci->iatu_unroll_enabled) {
> @@ -481,7 +481,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>  {
>         u32 val;
>
> -       if (pci->ops->link_up)
> +       if (pci->ops && pci->ops->link_up)
>                 return pci->ops->link_up(pci);
>
>         val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
> --
> 2.17.1
>
