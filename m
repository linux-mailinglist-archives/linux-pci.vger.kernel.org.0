Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFD0642B20
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 16:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLEPNQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 10:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiLEPMl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 10:12:41 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54C7271F;
        Mon,  5 Dec 2022 07:12:39 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so7429356otb.1;
        Mon, 05 Dec 2022 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PPBqbySTXATzozEbLBZecs9jcnWXaQpJ4ipGl050YEg=;
        b=nH2iZzM9ApCfezIAEC9x39cuyoWpFZxoiRfp/Cr9m6UCEe/L1fK+ndytb/qYGCM9MU
         S6Y5x8mAJThsonwLgrI59Md3RMGkO1cZnxi1Xjz4BQc5/P3KzBZZr2B51aBDs/V72lHx
         pcnflFeW4m35kFaM8vF3swaZazGRpl0CGMU6FkKQ92a3x8plfIEtG8JLU2jAvJ9Oz/mG
         nMlls4xpMxY3N3TOC9TxW69Ttgvc/e00Q0tVDnfJfnYw56RLNo17FA3PzLzs8C2/4IJf
         ufuK4WXEf1ktrt6bcEvvybMIDooLoyWYVN3vEyvAxF53nzgE86DkAwYn62EmWpz3Dmvs
         ryzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPBqbySTXATzozEbLBZecs9jcnWXaQpJ4ipGl050YEg=;
        b=vEoJ7zdxTTBxV0+P+/WLlSolKEgZXkWlg5n3CzRfiDdY0EXyy4wHdFecUr5nNzORcv
         DxZaBHtXH0f6L7GuFl3xu+C83B2nO9+/vqPIcO5epmVkA6KIAx95DXeg+Kdh6VMizp+4
         in+VIj6IKdWtCD7xoMZGia/8vLmqGvdbpNFASKBqGP/MCA9hvojNKoFrGRm3Thst1+8z
         myBCVdTtGyHeqizgDoc49FBJNiEMdLboad1PwzvnWYN/TBRcHVm3BpI3vI542KLQMOY3
         zj6bLzzNWHDZ17obAMHpi7y8JI0ZQJ1C3hCyqGXStuUhRO0cEzGTCPG5/y7J3MswuiCp
         SYCg==
X-Gm-Message-State: ANoB5pnzgFe+u7O8QdNFcCnF5oH8kQrQbHqbggpt2FYfy28nL270Trqe
        Hk5bczquhN79IOMzDUKFs0ELuvvkYVgDrS472V8=
X-Google-Smtp-Source: AA0mqf4xxmJweLjSmwR4AjAAP3UK0trE9dsrshk5r1DWy3yLvZfMnTG/86QaRqemLYHn+c9xICft0WkKVQyH94JowRs=
X-Received: by 2002:a05:6830:1e65:b0:661:b632:4259 with SMTP id
 m5-20020a0568301e6500b00661b6324259mr32439951otr.304.1670253159124; Mon, 05
 Dec 2022 07:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20221114012036.2870067-1-git@johnthomson.fastmail.com.au> <CAMhs-H-uKrn-OXX2POPr3ewXUx=h835yBSUcJWun7pC3dPj66w@mail.gmail.com>
In-Reply-To: <CAMhs-H-uKrn-OXX2POPr3ewXUx=h835yBSUcJWun7pC3dPj66w@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 5 Dec 2022 16:12:26 +0100
Message-ID: <CAMhs-H8uCgCgPvesXXg+p-t_CnfChYGNk2oZC2yfs8+s06Nbsg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: mt7621: add sentinel to quirks table
To:     John Thomson <git@johnthomson.fastmail.com.au>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 14, 2022 at 7:05 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi John,
>
> On Mon, Nov 14, 2022 at 2:20 AM John Thomson
> <git@johnthomson.fastmail.com.au> wrote:
> >
> > With mt7621 soc_dev_attr fixed to register the soc as a device,
> > kernel will experience an oops in soc_device_match_attr
> >
> > This quirk test was introduced in the staging driver in
> > commit b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
> > using 'soc_device_attribute'"), and the staging driver was moved in
> > commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
> > controller driver") for the 5.16 kernel
> >
> > Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
> > Fixes: b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision using 'soc_device_attribute'")
> > Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> > ---
> > v1 Link: https://lore.kernel.org/lkml/20221104205242.3440388-3-git@johnthomson.fastmail.com.au/#t
> > v2: no newline in middle of Fixes tag
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> I am pretty sure I already gave my Acked-by in the previous version of
> this patch. You should add tags when you submit new versiones. Anyway:
>
> Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Thanks,
>     Sergio Paracuellos

Gentle ping for this patch :)

Thanks,
    Sergio Paracuellos
