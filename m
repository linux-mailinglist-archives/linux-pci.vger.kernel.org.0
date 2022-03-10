Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B814D542D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 23:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiCJWJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 17:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242700AbiCJWJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 17:09:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EAC74865
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 14:08:45 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bi12so15222508ejb.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Mar 2022 14:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZhkoXzG05knp5CmHxpjlTRvvih1FMi7P6N0g3c2w9w=;
        b=lxOlvZfn8iOetqqjmdsHxno8mROFFl0RSPPxAAwGWA1GsiyWXIOjQihH1WdJCJusJ9
         ztnUdSpLF0LwhwzlUGD8+iRbQe/aIDZhwm84C06w8JosoDZFWlbkjl6RtC5n7Rh7+/E7
         XtACtKs6UQnv1NTd+55v2dWFJNbbQMV0Ntl/KhLdPUNKu2y1CBqDi/sm92hUJWOMhzqP
         KMRNVyEe6nBDqmvDYD2JcstdZBPQH1RS9LzQfok8DT+w8YrHT3ZLYpRvju5O61KuBA/H
         iqNRIj0keYohCE0FrJWkH/g5KG6dr6pz2pFcpcfWs+m+dUkfp4SdluzB1lsAPaeHB/rS
         EabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZhkoXzG05knp5CmHxpjlTRvvih1FMi7P6N0g3c2w9w=;
        b=AbxSBfkjaYYy86PIxSm0++17b3+IgG5s4jp4ntQ2rfQSMiM33om7ydLSArZw3s4DwE
         QG1iLlHgYmBKmFDjimGekt7huQrT7bsUY59pknuZ20zuXEhG0hvEx+9LhdPuyqKrPfj6
         50NjMkyF5/1k/TRzCdB2BHILNXa/srZcjMZjeskEGTThnfk+Y8FrDvjEweklMEv8rbuw
         DEvmxlDg5JUF8arjo9MREbCOvf2RH76iDlbr3o27f/FOEwtaeHSq5o2yvdTMqfLEcR7T
         he1R+PccIhN3hFnKZO6wuO3grxFYWnFSezD6netr9qrgMj5HU1h+6IfdN83jhlfq04It
         aoTw==
X-Gm-Message-State: AOAM531h8vntvHjM8sInQdESMYxu+xXCOQTRGSHQzuNdurRkSjvL0qGm
        C8ocDtDzfSlP/6bjMm5a5LN+0X2yhdHGn6BWZHI=
X-Google-Smtp-Source: ABdhPJyWODhrECvYDKJsoYb8R9yGlw+tysT6Y3m/whLEqqgBzvmk0/tTVIzr9f5GHMhMX+Fy20TGhDzTx6ukTLTl45k=
X-Received: by 2002:a17:906:dc90:b0:6da:a5b1:7879 with SMTP id
 cs16-20020a170906dc9000b006daa5b17879mr5984486ejc.433.1646950123840; Thu, 10
 Mar 2022 14:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20220222162355.32369-1-Frank.Li@nxp.com> <20220222162355.32369-3-Frank.Li@nxp.com>
In-Reply-To: <20220222162355.32369-3-Frank.Li@nxp.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 10 Mar 2022 16:08:32 -0600
Message-ID: <CAHrpEqRhq7U-2dxSHp=nhE22WEwweryA+TNnz-t1n0FaoGC_fA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] NTB: epf: Allow more flexibility in the memory BAR
 map method
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com,
        Jingoo Han <jingoohan1@gmail.com>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 10:24 AM Frank Li <Frank.Li@nxp.com> wrote:
>
> Support the below BAR configuration methods for epf NTB.
>
> BAR 0: config and scratchpad
> BAR 2: doorbell
> BAR 4: memory map windows
>
> Set difference BAR number information into struct ntb_epf_data. So difference
> VID/PID can choose different BAR configurations. There are difference
> BAR map method between epf NTB and epf vNTB Endpoint function.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Update ntb mail list.

>
> Change from v1:
>  - Improve commit message
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 48 ++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index b019755e4e21b..3ece49cb18ffa 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -45,7 +45,6 @@
>
>  #define NTB_EPF_MIN_DB_COUNT   3
>  #define NTB_EPF_MAX_DB_COUNT   31
> -#define NTB_EPF_MW_OFFSET      2
>
>  #define NTB_EPF_COMMAND_TIMEOUT        1000 /* 1 Sec */
>
> @@ -67,6 +66,7 @@ struct ntb_epf_dev {
>         enum pci_barno ctrl_reg_bar;
>         enum pci_barno peer_spad_reg_bar;
>         enum pci_barno db_reg_bar;
> +       enum pci_barno mw_bar;
>
>         unsigned int mw_count;
>         unsigned int spad_count;
> @@ -92,6 +92,8 @@ struct ntb_epf_data {
>         enum pci_barno peer_spad_reg_bar;
>         /* BAR that contains Doorbell region and Memory window '1' */
>         enum pci_barno db_reg_bar;
> +       /* BAR that contains memory windows*/
> +       enum pci_barno mw_bar;
>  };
>
>  static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
> @@ -411,7 +413,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>                 return -EINVAL;
>         }
>
> -       bar = idx + NTB_EPF_MW_OFFSET;
> +       bar = idx + ndev->mw_bar;
>
>         mw_size = pci_resource_len(ntb->pdev, bar);
>
> @@ -453,7 +455,7 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>         if (idx == 0)
>                 offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
>
> -       bar = idx + NTB_EPF_MW_OFFSET;
> +       bar = idx + ndev->mw_bar;
>
>         if (base)
>                 *base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> @@ -565,6 +567,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>                             struct pci_dev *pdev)
>  {
>         struct device *dev = ndev->dev;
> +       size_t spad_sz, spad_off;
>         int ret;
>
>         pci_set_drvdata(pdev, ndev);
> @@ -599,10 +602,16 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>                 goto err_dma_mask;
>         }
>
> -       ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> -       if (!ndev->peer_spad_reg) {
> -               ret = -EIO;
> -               goto err_dma_mask;
> +       if (ndev->peer_spad_reg_bar) {
> +               ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> +               if (!ndev->peer_spad_reg) {
> +                       ret = -EIO;
> +                       goto err_dma_mask;
> +               }
> +       } else {
> +               spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> +               spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> +               ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
>         }
>
>         ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
> @@ -657,6 +666,7 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>         enum pci_barno peer_spad_reg_bar = BAR_1;
>         enum pci_barno ctrl_reg_bar = BAR_0;
>         enum pci_barno db_reg_bar = BAR_2;
> +       enum pci_barno mw_bar = BAR_2;
>         struct device *dev = &pdev->dev;
>         struct ntb_epf_data *data;
>         struct ntb_epf_dev *ndev;
> @@ -671,17 +681,16 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>
>         data = (struct ntb_epf_data *)id->driver_data;
>         if (data) {
> -               if (data->peer_spad_reg_bar)
> -                       peer_spad_reg_bar = data->peer_spad_reg_bar;
> -               if (data->ctrl_reg_bar)
> -                       ctrl_reg_bar = data->ctrl_reg_bar;
> -               if (data->db_reg_bar)
> -                       db_reg_bar = data->db_reg_bar;
> +               peer_spad_reg_bar = data->peer_spad_reg_bar;
> +               ctrl_reg_bar = data->ctrl_reg_bar;
> +               db_reg_bar = data->db_reg_bar;
> +               mw_bar = data->mw_bar;
>         }
>
>         ndev->peer_spad_reg_bar = peer_spad_reg_bar;
>         ndev->ctrl_reg_bar = ctrl_reg_bar;
>         ndev->db_reg_bar = db_reg_bar;
> +       ndev->mw_bar = mw_bar;
>         ndev->dev = dev;
>
>         ntb_epf_init_struct(ndev, pdev);
> @@ -729,6 +738,14 @@ static const struct ntb_epf_data j721e_data = {
>         .ctrl_reg_bar = BAR_0,
>         .peer_spad_reg_bar = BAR_1,
>         .db_reg_bar = BAR_2,
> +       .mw_bar = BAR_2,
> +};
> +
> +static const struct ntb_epf_data mx8_data = {
> +       .ctrl_reg_bar = BAR_0,
> +       .peer_spad_reg_bar = BAR_0,
> +       .db_reg_bar = BAR_2,
> +       .mw_bar = BAR_4,
>  };
>
>  static const struct pci_device_id ntb_epf_pci_tbl[] = {
> @@ -737,6 +754,11 @@ static const struct pci_device_id ntb_epf_pci_tbl[] = {
>                 .class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
>                 .driver_data = (kernel_ulong_t)&j721e_data,
>         },
> +       {
> +               PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
> +               .class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> +               .driver_data = (kernel_ulong_t)&mx8_data,
> +       },
>         { },
>  };
>
> --
> 2.24.0.rc1
>
