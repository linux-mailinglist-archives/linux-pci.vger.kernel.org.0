Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F084C356D64
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbhDGNhi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 09:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245267AbhDGNhh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 09:37:37 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5E3C06175F
        for <linux-pci@vger.kernel.org>; Wed,  7 Apr 2021 06:37:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x9so13697656qto.8
        for <linux-pci@vger.kernel.org>; Wed, 07 Apr 2021 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XbvLyn2BjN/TsGrST9aWCimExiN5HlLvokM7BNpnYA=;
        b=fl1sCdaq/tbjdrhwx7sdDhyNuYzekwKPQEsjpOwLhA4+RDh9pADFrizW46c94BVqy/
         ro+3GOiGAEyVd2nk266p0se8pRm+nL4HuslN7+NHi3NUZ7aaN6QTbvpJ5CgA4L0FsOwV
         cVO94hTkh/AOlfzDnwvwVmMpL/L3VHrxHq6AaYD6y9p4Aiuad1U83I5gQJPk+5siXox5
         VZuM2nAsaLQZs0yI0Xhng8qQnzVsmDKvkk8Ehh5ckjN5ZsdUJF3N3E9XmQOPxCM6eVPS
         MkcXOMRclQSntMKFvCMXqdoAiVxJW4tkmMOeid/5jiE+WBK/m2hR/CZbECY3/X3gkaE+
         LHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XbvLyn2BjN/TsGrST9aWCimExiN5HlLvokM7BNpnYA=;
        b=RXlji4/TPNCRykn1t1c6e7jSAHi8K2kNHGbIvn9cu5+ThPIRiHbkjNNG6gMz/20wNK
         miqXM3RvbQs1u4PN3lgyA7fEFFgYYXlkco4ymjKTdFgTwXeh7fSY99wM8+Lw1VNWjray
         pHp61O/VO87cvUcdmgsP9HH71EsSh/z9XAccywrIof9QET1JKGkaQN1SwYhq33Qtp7Sm
         3H/jD45PHjE28nkoqMgTQZHmFTafjxGJc2drsjt6wEwEQPnKkfsreT1bXw15dTKXLXi0
         hmkPSG/jQWnlSuzWNiND3Uq2aBFWXI96o5vaQukHd5xgdGPO3ghdtCJOo4YEEBEmTYbS
         tJqA==
X-Gm-Message-State: AOAM530UxsRywyBI8O+3KC/1sxbDTZI7WUrxBbpgPM5cbYxgkQ9vMOhN
        Ta1yTZ6Bwkk8DI2/1AZ1AUlQYhnoYdtUTe2wS8Hcxg==
X-Google-Smtp-Source: ABdhPJyH3mLgKrUYzrtHypBKex2qr7oGWmH9Nx/2r3bE0LpA/5oMj8GIY5Z6P5aBUGlJgucLDPXTXz3DkJ+tdva9MKE=
X-Received: by 2002:ac8:5f87:: with SMTP id j7mr2703109qta.135.1617802647013;
 Wed, 07 Apr 2021 06:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210407131255.702054-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20210407131255.702054-1-dmitry.baryshkov@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 7 Apr 2021 16:37:15 +0300
Message-ID: <CAA8EJpooq2-vw19YKeiFxWoM-=6DwnhjF+8M7sSACgjqdnHznw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: move dw_pcie_iatu_detect() after host_init callback
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        PCI <linux-pci@vger.kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, 7 Apr 2021 at 16:12, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> The commit 9ea483375ded ("PCI: dwc: Move forward the iATU detection
> process") broke PCIe support on Qualcomm SM8250 (and maybe other
> platforms) since it moves the call to dw_pcie_iatu_detect() at the
> beginning of the dw_pcie_host_init(), before ops->host_init() callback.
> Accessing PCIe registers at this point causes the board to reboot since
> not all clocks are enabled, making PCIe registers unavailable.
>
> Move dw_pcie_iatu_detect() call after calling ops->host_init() callback,
> so that all register are accessible.
>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Fixes: 9ea483375ded ("PCI: dwc: Move forward the iATU detection process")

Please disregard the Fixes: tag here, the patch in question came to me
from a local tree, which I failed to notice.
The patch still applies on top of the previously dropped patch (and it
is the same fix as the one proposed for exynos by Marek Szyprowski at
https://lore.kernel.org/linux-pci/b777ab31-e0b9-bbc0-9631-72b93097919e@samsung.com/.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 52f6887179cd..24192b40e3a2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -319,8 +319,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                         return PTR_ERR(pci->dbi_base);
>         }
>
> -       dw_pcie_iatu_detect(pci);
> -
>         bridge = devm_pci_alloc_host_bridge(dev, 0);
>         if (!bridge)
>                 return -ENOMEM;
> @@ -400,6 +398,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                 if (ret)
>                         goto err_free_msi;
>         }
> +       dw_pcie_iatu_detect(pci);
>
>         dw_pcie_setup_rc(pp);
>         dw_pcie_msi_init(pp);
> --
> 2.30.2
>


-- 
With best wishes
Dmitry
