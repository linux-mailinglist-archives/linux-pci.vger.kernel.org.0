Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6557D955
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 06:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGVELe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 00:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGVELe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 00:11:34 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F189AA0
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 21:11:33 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id q26so3320838vsp.11
        for <linux-pci@vger.kernel.org>; Thu, 21 Jul 2022 21:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKeazHBRWFdH6yT9LzHWGBODfyX1z5Vakay1e/M5RsY=;
        b=IJwaJFITxIeQjrmZ7JtHCMRXkZCD219g/whY4Gm51wpS4bDkUflH+lzrVpzi7yBr9U
         o7OI5reCW6NHdoXErAE2cgcBbFGW3qI4XC5KfzXXUydoN3rDJOazYyu1DDARBO3YTRgM
         pMcGrEsLGc/L9TYDMF1T6ykm6g3W0hEet33tJ87JVsAdsJPET+SeMjWaA5gl6ge8DXK7
         gCtBqfVOIlZuO49crPBZwrqdeCqPQMipxqkeAd5zLAdwkWrW0V7H0sq5MYKWgFJ/YSYF
         3n8xqjVm9gKf2F7nw9rHCdsy4LK+O3cvXM1V+2sa080bCt2auMMbFI8kF3WD+U+zof89
         Fpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKeazHBRWFdH6yT9LzHWGBODfyX1z5Vakay1e/M5RsY=;
        b=uvttYPol3QflaYe8J5V+SnQ0+mqJg4ZpK42EVYDF9zHypM3soT8K17XxmdX+q9N2um
         oihotgmjsH5RLonE4VGE2FRFfplrsoew8tfR9Nwa6Zfh9L+IxJ1SEVAhvBPU4K/xDDwV
         4UFPU+7XYo4gtsGhkffkLfVwnSYnk9OEqBGPdGl6C4fafJ8kr9EUyuQ8IPuoPy8PjODS
         uVJFTzIA7e+yurJ21R3rlOZd72zoOhXXzsUOvI+Q1SDNy2w5eENhGOZw9V06ACQg/Y18
         n27Lzoy5XaL3aTlCdkNbHDw9aQVkFJcsu+6HA68bZEkit0xA0ijKGAZPfv4CbNQpwliZ
         ksRw==
X-Gm-Message-State: AJIora854YFtAhFxQEhqaA4blgXfa23JYbCxq3CJUOdHw+mBuk7XFsdN
        EnE7jmoACIhVOhPEFkGtCvxGnSIgrcMuSuKGmvl8K7fCboamhA==
X-Google-Smtp-Source: AGRyM1vFLtZVLDu8CmsbocazfMo7s+AfT5a1dtOgCS3O42ofJ+81ebdSz9d5ErNVkJVcG5umQHpKe3tQ7hkAzEQnt8c=
X-Received: by 2002:a05:6102:3543:b0:357:3ae7:bbd0 with SMTP id
 e3-20020a056102354300b003573ae7bbd0mr518639vss.84.1658463092672; Thu, 21 Jul
 2022 21:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H40_o+9KS1t67O98GusM38pDaiB4bssxd3KQZpAByfnLg@mail.gmail.com>
 <20220721175048.GA1738677@bhelgaas>
In-Reply-To: <20220721175048.GA1738677@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 22 Jul 2022 12:11:18 +0800
Message-ID: <CAAhV-H6XimeV1yf3LpQrixUu-rhSM=j02XKxF=+GtNDV4MESOQ@mail.gmail.com>
Subject: Re: [PATCH V16 7/7] PCI: Add quirk for multifunction devices of LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Fri, Jul 22, 2022 at 1:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jul 21, 2022 at 12:47:18PM +0800, Huacai Chen wrote:
>
> > Unfortunately, this patch only lists devices in LS7A1000, but some of
> > LS7A2000 (GNET and HDMI) also need to quirk, can they be squashed in
> > this patch? If not, we will add them in a new patch.
> >
> >  #define DEV_LS7A_CONF  0x7a10
> >  #define DEV_LS7A_LPC   0x7a0c
> >  #define DEV_LS7A_GMAC  0x7a03
> > +#define DEV_LS7A_GNET  0x7a13
> >  #define DEV_LS7A_DC1   0x7a06
> >  #define DEV_LS7A_DC2   0x7a36
> >  #define DEV_LS7A_GPU   0x7a15
> >  #define DEV_LS7A_AHCI  0x7a08
> >  #define DEV_LS7A_EHCI  0x7a14
> >  #define DEV_LS7A_OHCI  0x7a24
> > +#define DEV_LS7A_HDMI  0x7a37
>
> I squashed these in.  Let me know if I did anything wrong:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=930c6074d7dd
The logic is surely correct. But what is the principle of device list
order? If the order is value ascending, then LPC should be after AHCI;
if not, I prefer to group them with functions as below. :)
---
diff --git a/drivers/pci/controller/pci-loongson.c
b/drivers/pci/controller/pci-loongson.c
index 05997b51c86d..a7c3d5db3be8 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -22,6 +22,13 @@
 #define DEV_LS2K_APB   0x7a02
 #define DEV_LS7A_CONF  0x7a10
 #define DEV_LS7A_LPC   0x7a0c
+#define DEV_LS7A_DC1   0x7a06
+#define DEV_LS7A_DC2   0x7a36
+#define DEV_LS7A_HDMI  0x7a37
+#define DEV_LS7A_AHCI  0x7a08
+#define DEV_LS7A_EHCI  0x7a14
+#define DEV_LS7A_GMAC  0x7a03
+#define DEV_LS7A_GNET  0x7a13

 #define FLAG_CFG0      BIT(0)
 #define FLAG_CFG1      BIT(1)
@@ -103,6 +110,25 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
                        DEV_PCIE_PORT_2, loongson_bmaster_quirk);

+static void loongson_pci_pin_quirk(struct pci_dev *pdev)
+{
+       pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+                       DEV_LS7A_DC1, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+                       DEV_LS7A_DC2, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+                       DEV_LS7A_HDMI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+                       DEV_LS7A_AHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+                       DEV_LS7A_EHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+                       DEV_LS7A_GMAC, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+                       DEV_LS7A_GNET, loongson_pci_pin_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
        struct pci_config_window *cfg;

---
Huacai
