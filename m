Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB832EFE0
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCEQTO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 11:19:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhCEQTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Mar 2021 11:19:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2F0265092;
        Fri,  5 Mar 2021 16:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614961143;
        bh=JbqpCzbiZhOJg7RXN3nYPgSGE1F66AcCU1LkFJFaT44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BCVM3hDSn4iJYdeOeAeJSt4TW7B4xv9taNYHJouvfmf7fsrRyWyUIdCRslBT3Qa8R
         7vy0Xvuo+YS0/mpnkLMCWBsnlpIPtdtU0lzO2rFJcImatWz6W45d/ZNVy7F+Tjnqlz
         e7rgPj08EwJCxgMs6YuJh2sBZhzr08i27IyLBniu8HDO/NRfX5S6v3l+7ciqmnu/ij
         ld++4tX3XuW+taDIzI90mSR+5OndNqVKlVS8IbaHdCzaXBZdkVcNUC4oVmjHZYXUiq
         VpTGoANUBJ1Wk3dTpBK/OUb8TP/k1RueRhdq8G1L0c4FQxmIm8a98tnFt82JTQpr2x
         6E/1foRXT4pww==
Received: by mail-ej1-f52.google.com with SMTP id w17so4563897ejc.6;
        Fri, 05 Mar 2021 08:19:03 -0800 (PST)
X-Gm-Message-State: AOAM531Hr9eKwDc1vB9ebLvqhs6Pnns2a01lVfzcd9MkTgyDQMkK8apx
        JpN/XC7xQlVzfnK8Bja/AO+DherpMIL9uQ0kyA==
X-Google-Smtp-Source: ABdhPJz5KANNdL2ryaw8s4LqJ/7MTLA9iKXqYzgw+PyABAMFuVaCmgJCrJWLEKPtnoxWgiuIO7mnIClBkemeoHkNeCo=
X-Received: by 2002:a17:906:2312:: with SMTP id l18mr2953629eja.468.1614961142243;
 Fri, 05 Mar 2021 08:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 5 Mar 2021 10:18:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKudb9XRTb-_bN=i-sAadQQ40zHrph8f4xZ92cnKxFz3A@mail.gmail.com>
Message-ID: <CAL_JsqKudb9XRTb-_bN=i-sAadQQ40zHrph8f4xZ92cnKxFz3A@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 24, 2021 at 10:39 PM Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> In the dw_pcie_ep_init(), it depends on the detected iATU region
> numbers to allocate the in/outbound window management bit map.
> It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
> of iATU windows").
>
> So this patch move the iATU region detection into a new function,
> move forward the detection to the very beginning of functions
> dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
> from the dw_pcie_setup(), since it's more like a software
> perspective initialization step than hardware setup.
>
> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>  drivers/pci/controller/dwc/pcie-designware-host.c |  2 ++
>  drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  4 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Bjorn, can you pick this up for 5.12. Lorenzo is on holiday.

Rob
