Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80F34BAC8C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 23:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiBQWZZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 17:25:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiBQWZX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 17:25:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A789C45043
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 14:25:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q17so12240756edd.4
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 14:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihEy6KzCD7QFWOSwee9URJOiYpehf+0hjI95FoZ8vTo=;
        b=GGIJlrjFNMJpWdUqAKlOV20ZMaqH6VRuNKVfArpbLVbPiVmKyBVFX0+9SlxkGZ0b10
         pB43tN+3drY4IoXTdR+ezM3/fadru4GW8On9YOZdgY4b9PefvY36/mqNJc0s1EI2g8Y1
         DlAdf9YjA3BcoCYMRT62dBnit4laXh9qhwQvLbC1GJWS9qsZoOaEliCOvi+hwr0gIgb0
         qelpydYiZ+SRWxQVG5/C6l2rf6ng+y7L4yFk3mQ4m4Ke/nm/xQOF3J71U3g0UDVvo0e9
         zxhvsfoI98T2RBcXiAGwrO3rItNFUmwLml4lrrEygbCmRn4aiErbOIjcRcByNbU6vFO8
         7pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihEy6KzCD7QFWOSwee9URJOiYpehf+0hjI95FoZ8vTo=;
        b=lJIVoYPPb9meGMWCdFeqO4YT+K77PjSxPJqRhHYSwLztNeUBdoBhJQ6enkHrrfI+Fy
         W7LCEkGSYO+uYT5CLrm0S2oxHXwJFexg0JLAE5D3j3MXKR4nZlcE6AXh3iwo0rvDevje
         qm9MEPXPyz2DoF7zgmn7dMexn6mVq6LGteoWu1uWyHXicaH2RXzJZs+14IjYnTBMcWrv
         VtnIWyX24oik6ZL1P7RCJAU8LLKSZ9M8fPYOhGYv9BLgiuyqHZuXpJHaYCGZHmL9pvPJ
         hg6Q7Y2YqqfIOEuV9l0PDe/B3UdJk6zuREYFuA8Iqr3X8w9zc5gzUrKKBfxWPs8PKKvb
         3+7w==
X-Gm-Message-State: AOAM531+sCgd03GyvT4jxWbjCa4cIU5/DfWbqWMEJVuSAX57vaqFNwe+
        INlcQTzHjCh+3yxpFlmV9NTfG6RjTm3GUUgIC4s=
X-Google-Smtp-Source: ABdhPJyrEM/gcfLJc7pBJ2PkaJxYEY8BzGuw902G6UP09PTqaN6Dex0X4+cURK5RJMsSyvwxUuc4r7rT1aHYhVHIsXs=
X-Received: by 2002:a50:9d06:0:b0:410:befc:dda7 with SMTP id
 v6-20020a509d06000000b00410befcdda7mr4979715ede.443.1645136706021; Thu, 17
 Feb 2022 14:25:06 -0800 (PST)
MIME-Version: 1.0
References: <20220215053844.7119-3-Frank.Li@nxp.com> <20220217215942.GA308686@bhelgaas>
In-Reply-To: <20220217215942.GA308686@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 17 Feb 2022 16:24:56 -0600
Message-ID: <CAHrpEqSWZaLan18+s_h2fLeKxqOv3yM2Zo7hr_P03bBBKvMYVA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] NTB: epf: Added more flexible memory map method
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
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

On Thu, Feb 17, 2022 at 3:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Jon, Dave, Allen, linux-ntb, since you need at least an ack from
> the NTB folks; beginning of thread:
> https://lore.kernel.org/r/20220215053844.7119-1-Frank.Li@nxp.com]
>
> In subject, s/Added/Add/.
>
> But I don't think it's quite right yet, because this doesn't actually add
> any functions.

How about "Allow more flexibility in the memory bar map method"?

>
> On Mon, Feb 14, 2022 at 11:38:42PM -0600, Frank Li wrote:
> > Supported below memory map method
> >
> > bar 0: config and spad data
> > bar 2: door bell
> > bar 4: memory map windows
>
> s/bar/BAR/
> s/spad/?/ (I don't know what this is)

SCRATCHPAD REGION
https://www.kernel.org/doc/html/latest/driver-api/ntb.html

>
> Presumably these BAR numbers apply to some specific hardware?  This
> probably should specify *which* hardware.

Yes, BAR number on the EP side is configurable, which is controlled in
the 3/4 patch.
The Original BAR memory method can't be used in the new RC->EP NTB usage mode.
Most Other code can be reused, so I enhanced the bar number config part.

>
> Please make the commit log say what this patch does.

Does it help if attach ASCII diagram in patch 3/4 or cover letter one

>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c | 48 ++++++++++++++++++++++++---------
> >  1 file changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index b019755e4e21b..3ece49cb18ffa 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -45,7 +45,6 @@
> >
> >  #define NTB_EPF_MIN_DB_COUNT 3
> >  #define NTB_EPF_MAX_DB_COUNT 31
> > -#define NTB_EPF_MW_OFFSET    2
> >
> >  #define NTB_EPF_COMMAND_TIMEOUT      1000 /* 1 Sec */
> >
> > @@ -67,6 +66,7 @@ struct ntb_epf_dev {
> >       enum pci_barno ctrl_reg_bar;
> >       enum pci_barno peer_spad_reg_bar;
> >       enum pci_barno db_reg_bar;
> > +     enum pci_barno mw_bar;
> >
> >       unsigned int mw_count;
> >       unsigned int spad_count;
> > @@ -92,6 +92,8 @@ struct ntb_epf_data {
> >       enum pci_barno peer_spad_reg_bar;
> >       /* BAR that contains Doorbell region and Memory window '1' */
> >       enum pci_barno db_reg_bar;
> > +     /* BAR that contains memory windows*/
> > +     enum pci_barno mw_bar;
> >  };
> >
> >  static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
> > @@ -411,7 +413,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
> >               return -EINVAL;
> >       }
> >
> > -     bar = idx + NTB_EPF_MW_OFFSET;
> > +     bar = idx + ndev->mw_bar;
> >
> >       mw_size = pci_resource_len(ntb->pdev, bar);
> >
> > @@ -453,7 +455,7 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> >       if (idx == 0)
> >               offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> >
> > -     bar = idx + NTB_EPF_MW_OFFSET;
> > +     bar = idx + ndev->mw_bar;
> >
> >       if (base)
> >               *base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> > @@ -565,6 +567,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
> >                           struct pci_dev *pdev)
> >  {
> >       struct device *dev = ndev->dev;
> > +     size_t spad_sz, spad_off;
> >       int ret;
> >
> >       pci_set_drvdata(pdev, ndev);
> > @@ -599,10 +602,16 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
> >               goto err_dma_mask;
> >       }
> >
> > -     ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> > -     if (!ndev->peer_spad_reg) {
> > -             ret = -EIO;
> > -             goto err_dma_mask;
> > +     if (ndev->peer_spad_reg_bar) {
> > +             ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> > +             if (!ndev->peer_spad_reg) {
> > +                     ret = -EIO;
> > +                     goto err_dma_mask;
> > +             }
> > +     } else {
> > +             spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> > +             spad_off = readl(ndev->ctrl_reg + NTB_EPF_SPAD_OFFSET);
> > +             ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
> >       }
> >
> >       ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
> > @@ -657,6 +666,7 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> >       enum pci_barno peer_spad_reg_bar = BAR_1;
> >       enum pci_barno ctrl_reg_bar = BAR_0;
> >       enum pci_barno db_reg_bar = BAR_2;
> > +     enum pci_barno mw_bar = BAR_2;
> >       struct device *dev = &pdev->dev;
> >       struct ntb_epf_data *data;
> >       struct ntb_epf_dev *ndev;
> > @@ -671,17 +681,16 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> >
> >       data = (struct ntb_epf_data *)id->driver_data;
> >       if (data) {
> > -             if (data->peer_spad_reg_bar)
> > -                     peer_spad_reg_bar = data->peer_spad_reg_bar;
> > -             if (data->ctrl_reg_bar)
> > -                     ctrl_reg_bar = data->ctrl_reg_bar;
> > -             if (data->db_reg_bar)
> > -                     db_reg_bar = data->db_reg_bar;
> > +             peer_spad_reg_bar = data->peer_spad_reg_bar;
> > +             ctrl_reg_bar = data->ctrl_reg_bar;
> > +             db_reg_bar = data->db_reg_bar;
> > +             mw_bar = data->mw_bar;
> >       }
> >
> >       ndev->peer_spad_reg_bar = peer_spad_reg_bar;
> >       ndev->ctrl_reg_bar = ctrl_reg_bar;
> >       ndev->db_reg_bar = db_reg_bar;
> > +     ndev->mw_bar = mw_bar;
> >       ndev->dev = dev;
> >
> >       ntb_epf_init_struct(ndev, pdev);
> > @@ -729,6 +738,14 @@ static const struct ntb_epf_data j721e_data = {
> >       .ctrl_reg_bar = BAR_0,
> >       .peer_spad_reg_bar = BAR_1,
> >       .db_reg_bar = BAR_2,
> > +     .mw_bar = BAR_2,
> > +};
> > +
> > +static const struct ntb_epf_data mx8_data = {
> > +     .ctrl_reg_bar = BAR_0,
> > +     .peer_spad_reg_bar = BAR_0,
> > +     .db_reg_bar = BAR_2,
> > +     .mw_bar = BAR_4,
> >  };
> >
> >  static const struct pci_device_id ntb_epf_pci_tbl[] = {
> > @@ -737,6 +754,11 @@ static const struct pci_device_id ntb_epf_pci_tbl[] = {
> >               .class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> >               .driver_data = (kernel_ulong_t)&j721e_data,
> >       },
> > +     {
> > +             PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
> > +             .class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> > +             .driver_data = (kernel_ulong_t)&mx8_data,
> > +     },
> >       { },
> >  };
> >
> > --
> > 2.24.0.rc1
> >
