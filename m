Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A826287A5A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 18:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgJHQvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbgJHQvh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 12:51:37 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A09C0613D3
        for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2020 09:51:37 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y20so2777142iod.5
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2020 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/6RY8TKKj+W/1VmDo+d0IEG9PszfHwoIwLRWUh4HqQ=;
        b=tEVYzXdqmEuMxhEQ0rTIN1mKGckoCsmqMQIjcB6YajNa/oz8WyoEoF1AVe91zYP6FT
         nXVJn8QYYMX9zT8mnuQ2gU/9L0W1jBsEhei/V1Z+vyH4TDK7nlolKFf/V/K94bI75nwD
         Xdk9tpFcAVnZyDHm2RWcMkKKfvx+2FE2IpS8JZtNZv7kaYAanz2dJUNYqUqiBJJS1mr7
         JRtnDZ1w/uq69iQHoP3eg+MP6PtOslr6Ktl36/7hqHfjf5gsh+O3BSoDYScW/I+6aPEr
         qR3jGjrUVwyDcsCojhCVpBEsHi94aU33bQTP7HKD0ttsTF45O6xH85mQLR7hVzKTj596
         WQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/6RY8TKKj+W/1VmDo+d0IEG9PszfHwoIwLRWUh4HqQ=;
        b=nwOiizDQSGsQNteOwXhVMI5D19mnSbh3JyIKldw4uBzqp+d5KNhNF32YHFO9ZUBOge
         IxNrQB08sUn8EqKsHUshnheBeiiUvLAYsXen2PQU8JptlEsDunhxUnHvJMrDO0aBYsau
         jYiEx0OdJyibbPq4B4Fb8Ms6kXgv+omBwuXQ4S1whIai01JC5IjbhxFQn1L1B3/xzSfj
         ohk6FII8+be8a74he+lfCDamrkJV4l3BFEPT2Br3o8wjAHKRXfYa2F6r1iTbg0Rf5ntd
         q5PR6QlPim1onmMhIZRsWqW39qmrwMD6bHqW1Mix7oKMIa7sVHejhHHJyJmZKRHSAq+w
         lKgA==
X-Gm-Message-State: AOAM5325rbNFfxtmPuQ2TRrRlagh3cWIgJ+O9Z6xJo1sUSFKvvQRHyFq
        YU1Na9xqPuQbPpDV1U4HT/1q8g+jx0jY4IYwg+HAAQ==
X-Google-Smtp-Source: ABdhPJyz8vN0rhjNpoi55kPcxH5V3GpQx2VePFa+C6kevoO60oURqttQCBcoFzUfKpSvkdcDDYTWKBsRnxXY3mK2Vwk=
X-Received: by 2002:a5e:9b11:: with SMTP id j17mr6488597iok.176.1602175895571;
 Thu, 08 Oct 2020 09:51:35 -0700 (PDT)
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
 <CA+G9fYtR5MwQ_Gd1=R=815eCAz+5uC67wXV2x094pc_=PtkA2g@mail.gmail.com>
 <CA+G9fYsubwpT9HY7Dx-+zvYdM1t1m+mrnH8WfHJ-_BpMTt40vA@mail.gmail.com> <CAL_Jsq+uFJp5Vt=u2ZFhGCTTM62mb_1rKOz_Dj2=ez5bKJad1Q@mail.gmail.com>
In-Reply-To: <CAL_Jsq+uFJp5Vt=u2ZFhGCTTM62mb_1rKOz_Dj2=ez5bKJad1Q@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Oct 2020 22:21:24 +0530
Message-ID: <CA+G9fYufopBTRdqdHy=m17mc2N2Y8o-bcqAz_nON7X6ZYAb7Ug@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of dw_child_pcie_ops
To:     Rob Herring <robh@kernel.org>
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

On Thu, 8 Oct 2020 at 20:42, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 8, 2020 at 9:47 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Fri, 2 Oct 2020 at 14:59, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Thu, 1 Oct 2020 at 22:16, Michael Walle <michael@walle.cc> wrote:
> > > >
> > > > Am 2020-10-01 15:32, schrieb Kishon Vijay Abraham I:
> > > >
> > > > > Meanwhile would it be okay to add linkup check atleast for DRA7X so
> > > > > that
> > > > > we could have it booting in linux-next?
> > > >
> > > > Layerscape SoCs (at least the LS1028A) are also still broken in
> > > > linux-next,
> > > > did I miss something here?
> > >
> > > I have been monitoring linux next boot and functional testing on nxp devices
> > > for more than two week and still the problem exists on nxp-ls2088.
> > >
> > > Do you mind checking the possibilities to revert bad patches on linux next tree
> > > and continue to work on fixes please ?
> > >
> > > suspected bad commit: [ I have not bisected this problem ]
> > > c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
> > >
> > > crash log snippet:
> > > [    1.563008] SError Interrupt on CPU5, code 0xbf000002 -- SError
> > > [    1.563010] CPU: 5 PID: 1 Comm: swapper/0 Not tainted
> > > 5.9.0-rc7-next-20201001 #1
> > > [    1.563011] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
> > > [    1.563013] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
> > > [    1.563014] pc : pci_generic_config_read+0x44/0xe8
> > > [    1.563015] lr : pci_generic_config_read+0x2c/0xe8
> >
> >
> > This reported issue is gone now on Linux next master branch.

I am taking this verdict back.
I have seen the boot pass and the reported issue is gone but after checking
all 20 test jobs the 4 boot passes without the above reported error.
and later the 16 boot failed with the reported error.

> > I am not sure which is a fix commit.
>
> There isn't one, better double check that. We're still waiting on
> respinning of the revert patch.
>
> BTW, why is the kernelci NXP lab almost always down? I have a branch
> now to test things and I'm not done breaking the DWC driver. :)

Now the NXP LAVA lab is back online after upgrade.
LKFT running daily testing on device "nxp-ls2088" [1]

You can monitor and check results on Linaro Linux next project [2]

[1] https://lavalab.nxp.com/scheduler/device_type/nxp-ls2088
[2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20201008/?results_layout=table&failures_only=false#!?details=995,999#test-results

- Naresh
