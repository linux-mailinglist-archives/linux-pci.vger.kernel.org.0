Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D8767401E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 18:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjASRhZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 12:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjASRhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 12:37:24 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1160074EAC;
        Thu, 19 Jan 2023 09:37:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ss4so7545978ejb.11;
        Thu, 19 Jan 2023 09:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skCjK8Ehs2vpIzjtng4j+q/vUwd4dwBrnfYahefpdtI=;
        b=L7Z3rdN86G5q6AZ8YE51rD91eQOO6GlYARE6O4QMbdYpIpJ0yGG5T0PzefyetZy9+w
         iprM1RyJWgZjeCLe/JtKHpTemzk/dPDMG4Njekp7Z88syPsm3JH4EKc7kXj7sjOu2ivU
         ZVFYAlPR0Vi/X+WayNkRwUBkFopM3k9X5Yrrcv/On4NZjIv7izDrw9lWUBwffBz/Qry3
         VVNMWm8n7l/eAmhC2Ar1qqRwcnKqBiG2QaMF70lFgENLCN+pmeHJ2O8JxWt1fTNPIBPH
         9oZVYWPJqJ6JlXlthqANpKfYQY8LDalfRC32CGFPX2i+MfLTCRivuucbPhzyDfKRljpR
         twTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skCjK8Ehs2vpIzjtng4j+q/vUwd4dwBrnfYahefpdtI=;
        b=WoRtAfWzjy/wkEi7jEgIBy/sGzJj7C6IMMoiCvMrovfh3ZXy3bIkTtS5LzzEjaKeVx
         GZhw1zyfr/UNQrLBuiOiAc3hQkAbm4oVXQtyD4zQGu0w5WUUszMIFkq588UieiUMhlRI
         vhvhiazEmsuY/Z3lSfv0TNqRQbVsV56BAzdSIuhJDcVK7AMMcdUMPmCtZiJ825KKU3Oo
         pchHDonxqCWSFZ2eb6fAInC19h8rDgceqTJ6EZugCipnEkqL43wMRAG5pKhRynCu4EqV
         dCHkkmmmhW+9eDD2nJBJh3nDCo5ks1cGwG6Ew5UVShY0ph61za8p/Ayi5yUNbjr/sT5p
         MZuQ==
X-Gm-Message-State: AFqh2kpcJUwdGYYI97K5awq+ntnnu/lRGHoj3SsWXdZiYh0H1SPrc8Ir
        PWK/ng6VFhxhQJypTOHoOOp08NuO88mI4dCsvaU=
X-Google-Smtp-Source: AMrXdXsrU2o8SkVw33QKcHY9nLlzV5UPsvb+f0Jv9NniNNd8/pKm2LLNEm0hieq5AC0k4kgbcxGiayfrwXEEeyaLlHI=
X-Received: by 2002:a17:906:c017:b0:84d:4dbb:ffcd with SMTP id
 e23-20020a170906c01700b0084d4dbbffcdmr806111ejz.153.1674149821500; Thu, 19
 Jan 2023 09:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20230119000458.GA275446@bhelgaas> <20230119170003.GA316230@bhelgaas>
In-Reply-To: <20230119170003.GA316230@bhelgaas>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Thu, 19 Jan 2023 18:36:50 +0100
Message-ID: <CAOkhzLXbpgGfVEuUpBzTr3WoJfjcOa8uAQaLH28VKpF8uM1W-w@mail.gmail.com>
Subject: Re: [Bug 216859] New: PCI bridge to bus boot hang at enumeration
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Moreira-Guedes <brunodout.dev@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bjorn@helgaas.com>
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

Dear Bjorn

On Thu, Jan 19, 2023 at 6:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc bjorn@helgaas.com to avoid spamassassin]
>
> On Wed, Jan 18, 2023 at 06:04:58PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 06, 2023 at 05:42:33PM +0100, Zeno Davatz wrote:
> > > On Fri, Dec 30, 2022 at 7:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Dec 28, 2022 at 12:42:34PM -0600, Bjorn Helgaas wrote:
> > > > > On Wed, Dec 28, 2022 at 06:42:38PM +0100, Zeno Davatz wrote:
> > > > > > On Wed, Dec 28, 2022 at 1:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Wed, Dec 28, 2022 at 08:37:52AM +0000, bugzilla-daemon@kernel.org wrote:
> > > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > > > > > >
> > > > > > > >            Summary: PCI bridge to bus boot hang at enumeration
> > > > > > > >     Kernel Version: 6.1-rc1
> > > > > > > > ...
> > > > > > >
> > > > > > > > With Kernel 6.1-rc1 the enumeration process stopped working for me,
> > > > > > > > see attachments.
> > > > > > > >
> > > > > > > > The enumeration works fine with Kernel 6.0 and below.
> > > > > > > >
> > > > > > > > Same problem still exists with v6.1. and v6.2.-rc1
> > > > > > >
> > > > > > > Thank you very much for your report, Zeno!
> > > > > > >
> > > > > > > v6.0 works, v6.1-rc1 fails.  Would you mind booting v6.1-rc1 with the
> > > > > > > "ignore_loglevel initcall_debug" kernel parameters and taking a photo
> > > > > > > when it hangs?
> > > > > >
> > > > > > I will try this after Januar 7th 2023.
> > >
> > > I updated the issue:
> > >
> > > https://bugzilla.kernel.org/show_bug.cgi?id=216859
> > >
> > > I booted with the option: "ignore_loglevel initcall_debug"
> >
> > Thanks!  There's so much pcie output in that picture that we can't see
> > any of the initcall logging.  Can you capture another movie, but use
> > kernel parameters like "ignore_loglevel initcall_debug boot_delay=100"
> > to slow things down?  The full-speed boot is too fast for the camera
> > to capture all the output.  You can do this on any convenient kernel
> > that hangs.
>
> Thanks for the new movie!  The last initcalls I see before the hang
> are:
>
>   init_mqueue_fs
>   key_proc_init
>   jent_mod_init
>
> We must have returned from jent_mod_init() because I think the "saving
> config space" messages we see at the hang are from
> pcie_portdrv_init().
>
> I built 833477fce7a1 ("Merge tag 'sound-6.1-rc1' of
> git://git.kernel.org/pub/scl) with your .config and when I boot it on
> qemu, I see this:
>
>   calling  jent_mod_init+0x0/0x32 @ 1
>   initcall jent_mod_init+0x0/0x32 returned 0 after 27185 usecs
>   calling  af_alg_init+0x0/0x45 @ 1
>   NET: Registered PF_ALG protocol family
>   ...
>   calling  sg_pool_init+0x0/0xb4 @ 1
>   initcall sg_pool_init+0x0/0xb4 returned 0 after 462 usecs
>   calling  pcie_portdrv_init+0x0/0x43 @ 1
>   pcieport 0000:00:1c.0: vgaarb: pci_notify
>   pcieport 0000:00:1c.0: runtime IRQ mapping not provided by arch
>   pcieport 0000:00:1c.0: enabling bus mastering
>   pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
>   pcieport 0000:00:1c.0: AER: enabled with IRQ 24
>   pcieport 0000:00:1c.0: saving config space at offset 0x0 (reading 0x34208086)
>   pcieport 0000:00:1c.0: saving config space at offset 0x4 (reading 0x100507)
>   pcieport 0000:00:1c.0: saving config space at offset 0x8 (reading 0x6040002)
>   ...
>
> Would you mind trying again with "boot_delay=1000 pcie_ports=compat"?
>
> "boot_delay=1000" should slow it down more (all the action is in the
> last 3 seconds and it's still hard to see) and "pcie_ports=compat"
> should turn off the PCIe port driver.

Done. Please see:

https://bugzilla.kernel.org/show_bug.cgi?id=216859#c42

Best
Zeno
