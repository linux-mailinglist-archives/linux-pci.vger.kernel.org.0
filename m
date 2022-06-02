Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F8853B27F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 06:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiFBER2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 00:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiFBER1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 00:17:27 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC345EDDD
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 21:17:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id p1so2671516ilj.9
        for <linux-pci@vger.kernel.org>; Wed, 01 Jun 2022 21:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lBq0mAlcVmKfMDt+bZA6c7kUkxklw8APStcTJx4g33s=;
        b=Omj2SSxyHbQ4akq7xj/lhIh/r7CFkTRrnTmKWqDIg/BQPOWMiTCLA+IAoj9RV8/w0D
         QiKgQLrzp6dDOA1oWXOKq94WxVBjakEmDGDnFUDNqC2nUfdfpxmvKugJUVNeSVfLnLIg
         JXQf9eLX0+82BjDMZTN8tO7Cm5hJWcTNk3y5inSs6tFZEBFmxzHVo9JpG8I4do2yfxhD
         OOl2cfAfQYgpN4NeJsMHroBFAaNWV3iIdeP0qpjlGNoA0DMyFO01guJF68+RDvGLwock
         F7qfN9dmOW1CYW0ucnlqIK2RMo0/EgSM/3V2gKgdsEkRoT0kRWrlz6mhLlHQlLPTGd8D
         /MZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lBq0mAlcVmKfMDt+bZA6c7kUkxklw8APStcTJx4g33s=;
        b=tCNlVlyI6dZrzxZkC9THE67v3pJxuGDAErT17VZ8JijcYxyfJHsGBVCGKgBMJ5uHgs
         wecz9kRxAb0LQWyp2/f+oB5PPk7Qy1Vn/Abpvsq5ntwaXZLbgkspVZTkojiidNlnvs0Q
         ap8tjiLpa5+iO+7vECFF2ZGUuqcPmHS1DXeITQN2VQehXC5nuZzjcocoNIc10chw5NRa
         IHds+v2ZxK5ur6RXSSDQlij1kKcF554JCRPNA7wq1dyqMnws8aM6Brt54TiQYr4I8vtY
         yDT2yi/oQKohf+k7hC5vFjuiry09tqmcEBi6CDgODjL6XToyejXHj0MCcPcLlidkiuaY
         oQZA==
X-Gm-Message-State: AOAM530gsM/XjHI9AzZkNhGglSlM/3uIE+Z+D8Dk7qOszfEbmNvG6gEp
        ZcB8sodrfUf9/3lr4HJNDc4+e+1eSilpUc+DoCI=
X-Google-Smtp-Source: ABdhPJwgoI/QGiOA+P+BQGXaty3HpNXisn6ILbkJ2yfCeNB+0CExYtM7/tYJ508g0L0BhD6quWFcElKVDA1HJ3ySRa4=
X-Received: by 2002:a92:194c:0:b0:2c8:2a07:74e7 with SMTP id
 e12-20020a92194c000000b002c82a0774e7mr2070428ilm.272.1654143443594; Wed, 01
 Jun 2022 21:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220601022210.GA796391@bhelgaas> <06d1f3d1-2864-458a-a1f0-ed3047b1cddf@www.fastmail.com>
In-Reply-To: <06d1f3d1-2864-458a-a1f0-ed3047b1cddf@www.fastmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 2 Jun 2022 12:17:13 +0800
Message-ID: <CAAhV-H4N6pub_83YY1ym4oWf=qeMFR7B=i0DaJCiLx848BPYAg@mail.gmail.com>
Subject: Re: [PATCH V13 4/6] PCI: loongson: Improve the MRRS quirk for LS7A
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jun 1, 2022 at 8:00 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=883:22=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> > On Sat, Apr 30, 2022 at 04:48:44PM +0800, Huacai Chen wrote:
> >> In new revision of LS7A, some PCIe ports support larger value than 256=
,
> >> but their maximum supported MRRS values are not detectable. Moreover,
> >> the current loongson_mrrs_quirk() cannot avoid devices increasing its
> >> MRRS after pci_enable_device(), and some devices (e.g. Realtek 8169)
> >> will actually set a big value in its driver. So the only possible way
> >> is configure MRRS of all devices in BIOS, and add a pci host bridge bi=
t
> >> flag (i.e., no_inc_mrrs) to stop the increasing MRRS operations.
> >>
> >> However, according to PCIe Spec, it is legal for an OS to program any
> >> value for MRRS, and it is also legal for an endpoint to generate a Rea=
d
> >> Request with any size up to its MRRS. As the hardware engineers say, t=
he
> >> root cause here is LS7A doesn't break up large read requests. In detai=
l,
> >> LS7A PCIe port reports CA (Completer Abort) if it receives a Memory Re=
ad
> >> request with a size that's "too big" ("too big" means larger than the
> >> PCIe ports can handle, which means 256 for some ports and 4096 for the
> >> others, and of course this is a problem in the LS7A's hardware design)=
.
> >
> > This seems essentially similar to ks_pcie_quirk() [1].  Why are they
> > different, and why do you need no_inc_mrrs, when keystone doesn't?
> >
> > Or *does* keystone need it and we just haven't figured that out yet?
> > Are all callers of pcie_set_readrq() vulnerable to issues there?
>
> Yes actually keystone may need to set this flag as well.
>
> I think Huacai missed a point in his commit message about why he removed
> the process of walking through the bus and set proper MRRS. That=E2=80=99=
s
> because Loongson=E2=80=99s firmware will set proper MRRS and the only thi=
ng
> that Kernel needs to do is leave it as is. no_inc_mrrs is introduced for
> this purpose.
>
> In keystone=E2=80=99s case it=E2=80=99s likely that their firmware won=E2=
=80=99t do such thing, so
> their workaround shouldn=E2=80=99t be removed.
> And  no_inc_mrrs should be set for them to prevent device drivers modifyi=
ng
> MRRS afterwards.
Yes, the fact is the same as Jiaxun says.

Huacai
>
> Thanks
> - Jiaxun
>
> >
> > Whatever we do should be as uniform as possible across host
> > controllers.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/pci/controller/dwc/pci-keystone.c?id=3Dv5.18#n528
> >
> --
> - Jiaxun
