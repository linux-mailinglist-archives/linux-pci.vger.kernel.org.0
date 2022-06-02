Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF553B283
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 06:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiFBESZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 00:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiFBESY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 00:18:24 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE165EDDD
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 21:18:23 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id f12so2695100ilj.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Jun 2022 21:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p4T4wm5J/GeyXB6+xr0MQzq9TS2FAigMuMi/ZAyxUPQ=;
        b=bx6HKYDxpU8EGJQsoWFxK9RX0pu1O/OGkIDUNGV32uwgDAyOw5u4oIXLHtGIpSwVwt
         l5Stb20r7dfY2Dg7iVq3BRcKJsTVY7gxqWWXlzG/Noszcrx4+vlAWpXgAJp/vezieAfK
         MvL/NqHZCLiPJwnnNgs0ZITr9OZvKjBaq7+HsEfVXOAZ/6UFVsHOLSRzt1H1sHjbQt1H
         pC2xwQ76VwmcjMPQjXtzuHNDlkCBCeUrPGnlpRoK0uH32FEMIs3EKzhghCBrKRPf31VT
         7puwAA3mlI044lrwnTzRu8kTsuD55IazPnifq5DaHbvVccGiuQK+ZlBhJ1OnV64sELMn
         DaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p4T4wm5J/GeyXB6+xr0MQzq9TS2FAigMuMi/ZAyxUPQ=;
        b=WK/r+uUZX09b9VMDwBP+0iU9tM70duGd7NS0a7Ii21VoXWIFAwhnQxE1vhiCp1Vtch
         KCNeTjA8GPwkUZyhF2IoKy+PjMC1+QfpHF3Mo1Y+6qq7kbPLlJmLdan8xiwe/jN42duo
         8c1i/xZEN4HXNSwVR7SZBSbI92F7SXz+eN8HG66IMArYeA28PrbNXg5Mt2Rjjg5SNFsV
         sPnx2cpmuAqwdOlnrdYZBVhtP7sGaTe/gGIbRB6sOWv5MpcscdldMibIFRSxcOlFTjEW
         uxAeD4sv6C+MguCEN1inJxs+v0nJ+7jXO+J1ahfKinkFW2tE2YTsVf+DP3zynBRDitjm
         xA1A==
X-Gm-Message-State: AOAM530OoECug4TkpQPfRACIunq24aG/7dTWnbGCxekbW+tKS5vCsBm8
        6cE0Z5qSYgf7hvKPAlGIwdvSFk1lki1ri3djKQ0=
X-Google-Smtp-Source: ABdhPJx041YUx417mLtxkypa9K6m3/s50fNgUXbTsPnSy2cz7UlaPuQYkwtcWquof7J15D+OtK0klWoQQw7RognSdmE=
X-Received: by 2002:a92:d10e:0:b0:2d3:a495:d535 with SMTP id
 a14-20020a92d10e000000b002d3a495d535mr2017833ilb.54.1654143502827; Wed, 01
 Jun 2022 21:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220430084846.3127041-2-chenhuacai@loongson.cn> <20220601020806.GA793482@bhelgaas>
In-Reply-To: <20220601020806.GA793482@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 2 Jun 2022 12:18:13 +0800
Message-ID: <CAAhV-H7xJMpQiS4GCuVdit-y5GiAwJ-BpT_Mm0T1UVmHBHkM6w@mail.gmail.com>
Subject: Re: [PATCH V13 1/6] PCI: loongson: Use generic 8/16/32-bit config ops
 on LS2K/LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

Hi, Bjorn,

On Wed, Jun 1, 2022 at 10:08 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Apr 30, 2022 at 04:48:41PM +0800, Huacai Chen wrote:
> > LS2K/LS7A support 8/16/32-bits PCI config access operations via CFG1, so
> > we can disable CFG0 for them and safely use pci_generic_config_read()/
> > pci_generic_config_write() instead of pci_generic_config_read32()/pci_
> > generic_config_write32().
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> After removing cast below,
OK, thanks.

Huacai
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> > @@ -193,20 +220,20 @@ static int loongson_pci_probe(struct platform_device *pdev)
> >
> >       priv = pci_host_bridge_priv(bridge);
> >       priv->pdev = pdev;
> > -     priv->flags = (unsigned long)of_device_get_match_data(dev);
> > +     priv->data = (struct loongson_pci_data *)of_device_get_match_data(dev);
>
> No cast needed.
