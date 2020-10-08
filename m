Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6E2876D7
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 17:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgJHPM2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 11:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbgJHPM2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Oct 2020 11:12:28 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E7421D24;
        Thu,  8 Oct 2020 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602169948;
        bh=8F7IKYPdyEkQ5+ilFOZ4E/Td1drT5/jN039WnHHDGDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SjvbUktr1mIFydvTrLp7/Y4dC5TdxsLvSCsyiweYVrbkF6AvfpMhq2pZgkA6aLLA9
         MfEZfXQR9iEeQJS61YFlMtEaPUdaa37VEHMZo77iUabi1fXeeojEEVp+QWWJN3jY6+
         ciX3IGlikZCnOCpNHY7ufOUhWI7Xi0Rfem1bkNio=
Received: by mail-oo1-f52.google.com with SMTP id w7so1546638oow.7;
        Thu, 08 Oct 2020 08:12:27 -0700 (PDT)
X-Gm-Message-State: AOAM533nfsiwjM76PUmX07qPZO3NmSeoo2GbPwjouCmwCmoicsqp4eFO
        vVfAJ5l3T74vaLF4DZwFtkWL3++Yn5+5nCibyw==
X-Google-Smtp-Source: ABdhPJzsuMJxj3A0SOI3qwTv0mAde+XyqceFsKsNefeucc+I+1n5lqIYSXjAv8ROXFx+DUeBW40J+AuS2kF4iVlEjaA=
X-Received: by 2002:a4a:b30d:: with SMTP id m13mr5645883ooo.50.1602169947137;
 Thu, 08 Oct 2020 08:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200916054130.8685-1-Zhiqiang.Hou@nxp.com> <CAL_JsqJwgNUpWFTq2YWowDUigndSOB4rUcVm0a_U=FEpEmk94Q@mail.gmail.com>
 <HE1PR0402MB3371F8191538F47E8249F048843F0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <CAL_JsqLdQY_DqpduaTv4hMDM_-cvZ_+s8W+HdOuZVVYjTO4yxw@mail.gmail.com>
 <HE1PR0402MB337180458625B05D1529535384390@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <20200928093911.GB12010@e121166-lin.cambridge.arm.com> <HE1PR0402MB33713A623A37D08AE3253DEB84320@HE1PR0402MB3371.eurprd04.prod.outlook.com>
 <DM5PR12MB1276D80424F88F8A9243D5E2DA320@DM5PR12MB1276.namprd12.prod.outlook.com>
 <CAL_JsqJJxq2jZzbzZffsrPxnoLJdWLLS-7bG-vaqyqs5NkQhHQ@mail.gmail.com>
 <9ac53f04-f2e8-c5f9-e1f7-e54270ec55a0@ti.com> <CAL_JsqJEp8yyctJYUjHM4Ti6ggPb4ouYM_WDvpj_PiobnAozBw@mail.gmail.com>
 <67ac959f-561e-d1a0-2d89-9a85d5f92c72@ti.com> <99d24fe08ecb5a6f5bba7dc6b1e2b42b@walle.cc>
 <CA+G9fYtR5MwQ_Gd1=R=815eCAz+5uC67wXV2x094pc_=PtkA2g@mail.gmail.com> <CA+G9fYsubwpT9HY7Dx-+zvYdM1t1m+mrnH8WfHJ-_BpMTt40vA@mail.gmail.com>
In-Reply-To: <CA+G9fYsubwpT9HY7Dx-+zvYdM1t1m+mrnH8WfHJ-_BpMTt40vA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Oct 2020 10:12:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+uFJp5Vt=u2ZFhGCTTM62mb_1rKOz_Dj2=ez5bKJad1Q@mail.gmail.com>
Message-ID: <CAL_Jsq+uFJp5Vt=u2ZFhGCTTM62mb_1rKOz_Dj2=ez5bKJad1Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of dw_child_pcie_ops
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "Z.Q. Hou" <Zhiqiang.Hou@nxp.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Walle <michael@walle.cc>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 8, 2020 at 9:47 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Fri, 2 Oct 2020 at 14:59, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Thu, 1 Oct 2020 at 22:16, Michael Walle <michael@walle.cc> wrote:
> > >
> > > Am 2020-10-01 15:32, schrieb Kishon Vijay Abraham I:
> > >
> > > > Meanwhile would it be okay to add linkup check atleast for DRA7X so
> > > > that
> > > > we could have it booting in linux-next?
> > >
> > > Layerscape SoCs (at least the LS1028A) are also still broken in
> > > linux-next,
> > > did I miss something here?
> >
> > I have been monitoring linux next boot and functional testing on nxp devices
> > for more than two week and still the problem exists on nxp-ls2088.
> >
> > Do you mind checking the possibilities to revert bad patches on linux next tree
> > and continue to work on fixes please ?
> >
> > suspected bad commit: [ I have not bisected this problem ]
> > c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
> >
> > crash log snippet:
> > [    1.563008] SError Interrupt on CPU5, code 0xbf000002 -- SError
> > [    1.563010] CPU: 5 PID: 1 Comm: swapper/0 Not tainted
> > 5.9.0-rc7-next-20201001 #1
> > [    1.563011] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
> > [    1.563013] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
> > [    1.563014] pc : pci_generic_config_read+0x44/0xe8
> > [    1.563015] lr : pci_generic_config_read+0x2c/0xe8
>
>
> This reported issue is gone now on Linux next master branch.
> I am not sure which is a fix commit.

There isn't one, better double check that. We're still waiting on
respinning of the revert patch.

BTW, why is the kernelci NXP lab almost always down? I have a branch
now to test things and I'm not done breaking the DWC driver. :)

Rob
