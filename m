Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D117121FA
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 10:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbjEZIR7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 04:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjEZIR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 04:17:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917BA3;
        Fri, 26 May 2023 01:17:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-95fde138693so298238966b.0;
        Fri, 26 May 2023 01:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685089075; x=1687681075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuRt6dAOm751tuQulnhfMWILFn11xZG+6XyABCY5UmI=;
        b=ZLIgYtH2UgfBtYcPSuVxdRj1OGaA+lGpqyd+ZORNt3C8wO+m+ET9qmnkIdsCts6TAu
         83Ml4c9AJGub3HULQKMvpacTEHxyw9W1084rZSeHIflQD3Y/cCCq/c9uLylZej3JQyEE
         H5zukiTFxRaUbTJGuCo5brSVALLlR9qj3KFnv36F78Y5vCLLrrCl+YB4j2ZMsv3EIA+E
         3h1yptlRCpCKQZnlQjHDorvHCVsMvMbrJepnNF4uyl53lCatjlJsJla8crKd7kXkm+yQ
         XcjwdPb0ZxuWCOGaoDeyA6MiTPe98VIw6CunpV5kR9dkwWWzseceZSDHupMnunxCbHo2
         i8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089075; x=1687681075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuRt6dAOm751tuQulnhfMWILFn11xZG+6XyABCY5UmI=;
        b=UHdHmTVrYsoRbnOmwNL7qep4b3S7RO2Dt4FSASB0W4VjUi0eBF7L+jAkKJiRkKvbHW
         dghBPYGPoNPYZYkJ1lWHOtsAEPfmMaO+cXfoSIkRFWoDAkyWgJ5E34tAmc78J8x7aGTO
         dRZqarXYpcWoWhQvutKgqiY8I1mPmw3hDv4GcZrkDiwKaF4eZukMsho+4jt/4Y329kG7
         I7W6crf+VQbLoqgMi62k8sX/XcbZmJs7IbTAjlIqJLm3rdlTaHVrvp8SVUX8minu0DB1
         cIez7WIkPUgi+IMPpyZceXx7Z/XQq0QnrvsZxdL/IfMcvSUKZFR9ozowvqz/WvT4eos+
         fG4w==
X-Gm-Message-State: AC+VfDzS55VLbk60RS63eBLN8kH/a/G1IHytj1MZS7RoWU1Q/5+Ez34u
        uSstE8Fa5YUeTTVj0Xwafrh0VDY9blG22QEl6+/YOE0n2LYKjbUmNOI=
X-Google-Smtp-Source: ACHHUZ59QhH5H8ZOmVSmXeKDnnlxkNV3y/SbDkI//z7eGAl/S9o5aZ74c3Yq1Kp5yWKC3ocuXwnjPu4cpYtsDxPT7l4=
X-Received: by 2002:a17:907:9692:b0:96a:99d2:a680 with SMTP id
 hd18-20020a170907969200b0096a99d2a680mr866775ejc.34.1685089075063; Fri, 26
 May 2023 01:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H5u8qtXpr-mY+pKq7UfmyBgr3USRTQpo9-w28w8pHX8QQ@mail.gmail.com>
 <ZG/V4C0zlXaFv/1b@bhelgaas>
In-Reply-To: <ZG/V4C0zlXaFv/1b@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 26 May 2023 16:17:39 +0800
Message-ID: <CAAhV-H6jokg2q4d7Of-5yPspzNYKc5Whn+1O9hiwWjtV4ACd1A@mail.gmail.com>
Subject: Re: [PATCH] pci: irq: Add an early parameter to limit pci irq numbers
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>, linux-pci@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongson-kernel@lists.loongnix.cn,
        Juxin Gao <gaojuxin@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
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

Hi, Bjorn and Marc,

On Fri, May 26, 2023 at 5:40=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, May 25, 2023 at 05:14:28PM +0800, Huacai Chen wrote:
> > On Wed, May 24, 2023 at 11:21=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > On Wed, May 24, 2023 at 05:36:23PM +0800, Huacai Chen wrote:
> > > > Some platforms (such as LoongArch) cannot provide enough irq number=
s as
> > > > many as logical cpu numbers. So we should limit pci irq numbers whe=
n
> > > > allocate msi/msix vectors, otherwise some device drivers may fail a=
t
> > > > initialization. This patch add a cmdline parameter "pci_irq_limit=
=3Dxxxx"
> > > > to control the limit.
> > > >
> > > > The default pci msi/msix number limit is defined 32 for LoongArch a=
nd
> > > > NR_IRQS for other platforms.
> > >
> > > The IRQ experts can chime in on this, but this doesn't feel right to
> > > me.  I assume arch code should set things up so only valid IRQ number=
s
> > > can be allocated.  This doesn't seem necessarily PCI-specific, I'd
> > > prefer to avoid an arch #ifdef here, and I'd also prefer to avoid a
> > > command-line parameter that users have to discover and supply.
> >
> > The problem we meet: LoongArch machines can have as many as 256
> > logical cpus, and the maximum of msi vectors is 192. Even on a 64-core
> > machine, 192 irqs can be easily exhausted if there are several NICs
> > (NIC usually allocates msi irqs depending on the number of online
> > cpus). So we want to limit the msi allocation.
> >
> > This is not a LoongArch-specific problem, because I think other
> > platforms can also meet if they have many NICs. But of course,
> > LoongArch can meet it more easily because the available msi vectors
> > are very few. So, adding a cmdline parameter is somewhat reasonable.
>
> The patch contains "#ifdef CONFIG_LOONGARCH", which makes this
> solution LoongArch-specific.  I'm not willing for that yet.
>
> It sounds like the LoongArch MSI limit is known at compile-time, or at
> least at boot-time, so the kernel ought to be able to figure out what
> to do without a command-line parameter.
>
> > After some investigation, I think it may be possible to modify
> > drivers/irqchip/irq-loongson-pch-msi.c and override
> > msi_domain_info::domain_alloc_irqs() to limit msi allocation. However,
> > doing that need to remove the "static" before
> > __msi_domain_alloc_irqs(), which means revert
> > 762687ceb31fc296e2e1406559e8bb5 ("genirq/msi: Make
> > __msi_domain_alloc_irqs() static"), I don't know whether that is
> > acceptable.
>
> I guess you mean msi_domain_ops::domain_alloc_irqs() (not
> msi_domain_info).  If this is really a generic problem, I'm surprised
> that no other arch has needed to override .domain_alloc_irqs().
Yes, I mean msi_domain_ops::domain_alloc_irqs() here.

>
> I think you'll have better luck getting feedback if you can post the
> complete working patch.  At the very least, you'll learn more about
> the problem by doing that.
Emm, I found I can do some small modification on
msi_domain_prepare_irqs(), and solve the problem by overriding
msi_domain_ops::msi_prepare(), thanks. And patches is coming soon.

Huacai
>
> Bjorn
