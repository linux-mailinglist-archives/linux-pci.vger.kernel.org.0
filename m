Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEFB633100
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 00:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiKUXyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 18:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiKUXyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 18:54:50 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2015C5F63
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 15:54:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id i10so32066153ejg.6
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 15:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d7xhKnOcB71a2ZVb8nhxzwdaG6r8FnahNHMuFn4dMPc=;
        b=M02zW5V8SfeT7IVK3x4WxpQV5fEi4269OMA/Q+CHdeM5bw8D7rU9FGEbvT1yOM7KhZ
         aqZc2SgwKR/C2MiNmZPmOt9yEeXSYGWVcPTKE8deyMnvHXIesC8Su6ytr3bSMOCEINQL
         /1A2kUbyRY2SOYf67P3MJ2LMRG5mETxjg2/gB8OMrhjk7jX0rmM3TjthryhtVe4zGZpl
         L7xXUKJ7iUsZUBte0IhgwIQlCL8tMM32HJFLTVapYN/g0stWXPuFXtjZC/1hfHNdJP2X
         V7Q/doEUg5ddLStpSYI5p9PAXQ4XitGJPFGDGMxR6kHuoep4vZ2a4n2+wC2isRODkOvi
         FXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7xhKnOcB71a2ZVb8nhxzwdaG6r8FnahNHMuFn4dMPc=;
        b=O8ZS624dMtG8y+l3tAZo0GHntpebxAaNlWhcBpg/A/On3u8xqYqkWc5ZjtT/iaf7iZ
         Q8Eb+1Qnk+/tYRmdsLYSLwQ9KiF34c2yytmSiaDZOG5zzt4SPytBLQVQ700qrk6SBEt8
         6nmfZLd43zhoE4hYK5eAq9qXyCqzcjIOyEy39JjjIRcMgSpHnZbMpFadyvhw7PTf8r+4
         lZ+hM4FlmMYvdd49lwpskktw444706HMOOwqM5kQMxaVluPfON5I5gObv9ZqRM0Yz2LA
         501BbyNScFUaz3uAJNJRxyEH66u8HAWG0l5ENKFnjv8OEXDRrlGWM4aSuU/o5/f8O1yb
         cJ4A==
X-Gm-Message-State: ANoB5pnPcHelB6f6O2rasJS7VwB5ywr9YZHeE9+49EG1oJ9SEyd2hIfg
        4qfrpBy9Mjdn8GX3JkecCzgvT4LBUDfI5yWCdFQ=
X-Google-Smtp-Source: AA0mqf4pReabHjbQcjTohnTPsET8HLgndd4Q2OzKPoWBVNDsHVplBj2fbaDhBk+4NfJaDZml1MIZLu/PpNPpG2yh88Y=
X-Received: by 2002:a17:906:3bc7:b0:7b2:884e:3c83 with SMTP id
 v7-20020a1709063bc700b007b2884e3c83mr17086739ejf.59.1669074886593; Mon, 21
 Nov 2022 15:54:46 -0800 (PST)
MIME-Version: 1.0
References: <1669014996-177686-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1669014996-177686-1-git-send-email-shawn.lin@rock-chips.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Mon, 21 Nov 2022 15:54:35 -0800
Message-ID: <CAPOBaE5_w94UGx+mEkNi+jzjk+Te3K6Mt6KaB5uLsWXSY192mA@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Round up num_ctrls if num_vectors is less than MAX_MSI_IRQS_PER_CTRL
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 20, 2022 Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Some SoCs may only support 1 RC with a few MSIs support that the total numver of MSIs is
> less than MAX_MSI_IRQS_PER_CTRL. In this case, num_ctrls will be zero which fails setting
> up MSI support. Fix it by rounding up num_ctrls to at least one.

Hi Shawn Lin,

If you find only a single case (1RC with a few MSIs), please set it as one
if the divided value is zero.

For example,
num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
if (num_ctrls < 1)
    num_ctrls = 1

Best regards,
Jingoo Han

>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 39f3b37..2cba2a8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -61,7 +61,7 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>         irqreturn_t ret = IRQ_NONE;
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>
> -       num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +       num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
>
>         for (i = 0; i < num_ctrls; i++) {
>                 status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> @@ -342,7 +342,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>
>         if (!pp->num_vectors)
>                 pp->num_vectors = MSI_DEF_NUM_VECTORS;
> -       num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +       num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
>
>         if (!pp->msi_irq[0]) {
>                 pp->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
> @@ -706,7 +706,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>         dw_pcie_setup(pci);
>
>         if (pp->has_msi_ctrl) {
> -               num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +               num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
>
>                 /* Initialize IRQ Status array */
>                 for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> --
> 2.7.4
>
