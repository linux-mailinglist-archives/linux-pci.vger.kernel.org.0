Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF057287654
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 16:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbgJHOrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgJHOrJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 10:47:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B541AC061755
        for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2020 07:47:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u19so6459743ion.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2020 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfyqMEd778QyNbtI/v0Y/4c53t1ox1t/PqY3/TlES/c=;
        b=VHGJaG8lcYxKBr8ZUrviwB3LO58EAwFpRxS1d9tiNKSGj948O4EBvxsaGIQcUx64nx
         +S7pTXP0QX0N6YG62tvhobyWwwlmhihK+6FbGKpigc+dc2NqfrLf2ZnBV1Ltk1NZZxKh
         4Wen+xjOlaT3UX+pN4YbuyNpkLCAZQ784Bgmmj7brvPnewQIukU4ZuPfdFIpAn4J0u6u
         GHqgBRYb4zyZlK9ZgEvhIkTHF/ZMZ8smSwQ8iXsrM3qadJZJgPB21yqd6jiNAP+dGWD4
         9xwaGBaQKsFH8mZfZtxwtAnR6/ZbQ/230WOZzLV7N7WWRoZ4JWcjm8ppl5Yb2Yp2CH0N
         Ghlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfyqMEd778QyNbtI/v0Y/4c53t1ox1t/PqY3/TlES/c=;
        b=XQSIGlIHaGROuPx3tqUR/t4LLnWE0Exwaf61InMnwdeiPq+qT6FQ/ifMHjDcJ1ZGhZ
         ELQW8jnBvCAOOIyktIKYcdbtyxtgOU53s/QBH2nL2uHQl5bf2GnVIi2dBf9Zwr7Taqtu
         EQydDPgbaXisaY7rxtykBpSXPwI+qrlIL6e/RtZIWAaoZpj41XpON2rt9J/KVXFDHH1x
         AuLSJUZhau8Wacej4mXK8cevq7inACQw0pMxWyDVzsSISgkn9fSlOYoFDC+RFTpvQc2s
         zfhhu0hkgYXOc2P2Y5xKro2QWXeuUN2P909bMg/fo7rwWsJegkOeCkvPWjAk/QqBN0iA
         8N8Q==
X-Gm-Message-State: AOAM531CPVvt+SHlBfUcPNqLVJBF73saF+9g4jqEixfdhF82M6HxEAiZ
        k64HShe1V6ByOtRi2glWwYrfY6NfRQjxfGXpsl0cQA==
X-Google-Smtp-Source: ABdhPJw75ddyXkeM7k24xVz+a/obQzBxen8AUggFQ4shVf63vktSWKeHv9wbpC3JuJkin1zy+5RAk4ua6HAXEL2CHiY=
X-Received: by 2002:a5e:9b11:: with SMTP id j17mr6086128iok.176.1602168428872;
 Thu, 08 Oct 2020 07:47:08 -0700 (PDT)
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
In-Reply-To: <CA+G9fYtR5MwQ_Gd1=R=815eCAz+5uC67wXV2x094pc_=PtkA2g@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 8 Oct 2020 20:16:57 +0530
Message-ID: <CA+G9fYsubwpT9HY7Dx-+zvYdM1t1m+mrnH8WfHJ-_BpMTt40vA@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Added link up check in map_bus of dw_child_pcie_ops
To:     Zhiqiang.Hou@nxp.com, Rob Herring <robh@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
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

On Fri, 2 Oct 2020 at 14:59, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 1 Oct 2020 at 22:16, Michael Walle <michael@walle.cc> wrote:
> >
> > Am 2020-10-01 15:32, schrieb Kishon Vijay Abraham I:
> >
> > > Meanwhile would it be okay to add linkup check atleast for DRA7X so
> > > that
> > > we could have it booting in linux-next?
> >
> > Layerscape SoCs (at least the LS1028A) are also still broken in
> > linux-next,
> > did I miss something here?
>
> I have been monitoring linux next boot and functional testing on nxp devices
> for more than two week and still the problem exists on nxp-ls2088.
>
> Do you mind checking the possibilities to revert bad patches on linux next tree
> and continue to work on fixes please ?
>
> suspected bad commit: [ I have not bisected this problem ]
> c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
>
> crash log snippet:
> [    1.563008] SError Interrupt on CPU5, code 0xbf000002 -- SError
> [    1.563010] CPU: 5 PID: 1 Comm: swapper/0 Not tainted
> 5.9.0-rc7-next-20201001 #1
> [    1.563011] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
> [    1.563013] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=--)
> [    1.563014] pc : pci_generic_config_read+0x44/0xe8
> [    1.563015] lr : pci_generic_config_read+0x2c/0xe8


This reported issue is gone now on Linux next master branch.
I am not sure which is a fix commit.

- Naresh
