Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7756349BF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 23:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKVWEP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 17:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbiKVWEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 17:04:14 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D7B11A26
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 14:04:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f7so22522727edc.6
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OFhlAG7Hm2IB3aJn7V+VtFlHepO2BQ8l7T2C71S+LeA=;
        b=ex4ZVTQ34cpv+FD0Emp/UcAJbeYdz8e3y0tPUyCEJTr7w1LyuWmARDrjKrlDN+ohOg
         WM9Lcp0OOYkR/axVtd7Ua22oiA/6P9onOXZiqpcKvdAhlXUvrR8e6LIr25QnDv2u8Nub
         i2/382TXQvlRSD3E0UdA+0qNx2vH21CCUawW+BnSLnMSf5d2NPgg7w8WOTH8PLVsC1m7
         s0wLE3uA90Cvt88xNgceamIc+7/UExM3GgEG/4sqJoL5c74l3ZoaxbX4CfgjYz3DZzO7
         qVqjfPy/yLFIlDz+n864Skh653aQPfY8BqdH/5GDuarpMX5kCH12A1E27FoAEXjnbASH
         v2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFhlAG7Hm2IB3aJn7V+VtFlHepO2BQ8l7T2C71S+LeA=;
        b=6anx2CU2Bvvy3EUUC2p1GsZ1MSvFNQ6aV4qZxV0Nf4DTHlaMEYv8R7U8RgDL76oleF
         hRXy+SH8oftxXFKNb0rnjeV7vtfXyrrLNpv5J+SbE1n8AYnc7SfzlAVRi7ApwI8xHKZm
         ApxLP39bcSOM9C073N6OsYupb7aCr7WiMGPg7cDgQo3zHGS8hjc0/rw95FTrqX9QfZiT
         mBEg93xi4BSgeQ5KKdWHlCBbBMNelJXp7fjuUi8KRbU/g/p1RwCKD2iFbqqrJIAHWxiU
         rjIMPU3FUCDS+qgcFkRak1X6hDJNdHfuvYLN94FUOOmzv2O+VDQxu89Uy2Hoxu6zJDwv
         cpOA==
X-Gm-Message-State: ANoB5pnPwpdI2VzdbY9MgVSUgJsVoQnKfXEe/RRsioA78GUH5pBvmwY0
        gdKkushEZVRgJRTEvaiKXlE+BtVBWhncGcGTVGMfpcfVY0A=
X-Google-Smtp-Source: AA0mqf5nF1Ze9NtsyHdmHeTlpHdH+CFPjfFQ2h8RHyu37UMOLuCqP4Fi6t6UQfCqTllr5ejcB5IYQiF/s7SKnbNmlKw=
X-Received: by 2002:a05:6402:19a:b0:460:7413:5d46 with SMTP id
 r26-20020a056402019a00b0046074135d46mr23107338edv.47.1669154651814; Tue, 22
 Nov 2022 14:04:11 -0800 (PST)
MIME-Version: 1.0
References: <1669080013-225314-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1669080013-225314-1-git-send-email-shawn.lin@rock-chips.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Tue, 22 Nov 2022 14:04:00 -0800
Message-ID: <CAPOBaE6KNXn56Gs8DCUg9nMqDPF494OaM58JYHsaKVsFRbvt5A@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] PCI: dwc: Round up num_ctrls if num_vectors is
 less than MAX_MSI_IRQS_PER_CTRL
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

On Mon, Nov 21, 2022 Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Some SoCs may only support 1 RC with a few MSIs support that the total number of MSIs is
> less than MAX_MSI_IRQS_PER_CTRL. In this case, num_ctrls will be zero which fails setting
> up MSI support. Fix it by rounding up num_ctrls to at least one.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
>
> Changes in v2:
> - set num_ctrls to 1 if it's less than one
>
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 39f3b37..cfce1e0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -62,6 +62,8 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>
>         num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +       if (num_ctrls < 1)
> +               num_ctrls = 1;
>
>         for (i = 0; i < num_ctrls; i++) {
>                 status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> @@ -343,6 +345,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>         if (!pp->num_vectors)
>                 pp->num_vectors = MSI_DEF_NUM_VECTORS;
>         num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +       if (num_ctrls < 1)
> +               num_ctrls = 1;
>
>         if (!pp->msi_irq[0]) {
>                 pp->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
> @@ -707,6 +711,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>
>         if (pp->has_msi_ctrl) {
>                 num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +               if (num_ctrls < 1)
> +                       num_ctrls = 1;
>
>                 /* Initialize IRQ Status array */
>                 for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> --
> 2.7.4
>
