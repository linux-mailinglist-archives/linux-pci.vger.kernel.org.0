Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5877209AC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 21:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbjFBTTi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 15:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjFBTTh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 15:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96EE1BF;
        Fri,  2 Jun 2023 12:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351ED6123C;
        Fri,  2 Jun 2023 19:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657E9C433EF;
        Fri,  2 Jun 2023 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685733574;
        bh=2DysCi0izWWkAAQmUSsVWD5RYIHiULBjqxwGXFltK9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iUqz86/VndTNM37qAyzcaE9ACYVoZ0nOT0mmMltHr0RnOYzg7qc+uA/tAqlpqbazK
         Z7GkQb9StW9vbjFNPSqQCBN/uZQ9Z/q7pdRdITFaahlyxwfkwcCB9ThkZriZ8togNk
         Riw5sbqDeNoDaXtiFlZXGahLfcMunuvcfISxIhP9TOyC9OoBZaJYN5eqfEqJ/VFS/F
         e3OhYl4H6X+FMnUeBfrZZZDvVzDJeU1NPZSNuJnMBbqHqTeETEzR/YJxqbQdwSJ/3b
         9OpVFFBcZ8hKjzCDJTTv9JMaBkSaPM0Bs2pNrDIEJdB12sQH/SMoxZ0XUaamcw80TN
         5xyxZoebe1ZDA==
Date:   Fri, 2 Jun 2023 14:19:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Bibo Mao <maobibo@loongson.cn>, WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Align pci memory base address with page size
Message-ID: <ZHpAxC1aedBsR3K2@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H58dR4JWtCdqCR553H1-pbppKyi114BMhsrV74Zb_c58Q@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci, beginning of thread:
https://lore.kernel.org/all/20230602030732.1047696-1-maobibo@loongson.cn/]

On Fri, Jun 02, 2023 at 12:11:02PM +0800, Huacai Chen wrote:
> On Fri, Jun 2, 2023 at 11:07 AM Bibo Mao <maobibo@loongson.cn> wrote:
> >
> > LoongArch linux kernel uses 16K page size by default, some pci devices have
> > only 4K memory size, it is normal in general architectures. However memory
> > space of different pci devices will share one physical page address space.
> > This is not safe for mmu protection, also UIO and VFIO requires base
> > address of pci memory space page aligned.
> >
> > This patch adds check with function pcibios_align_resource, and set base
> > address of resource page aligned.
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> >  arch/loongarch/pci/pci.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
> > index 2726639150bc..1380f3672ba2 100644
> > --- a/arch/loongarch/pci/pci.c
> > +++ b/arch/loongarch/pci/pci.c
> > @@ -83,6 +83,29 @@ int pcibios_alloc_irq(struct pci_dev *dev)
> >         return acpi_pci_irq_enable(dev);
> >  }
> >
> > +/*
> > + * memory space size of some pci cards is 4K, it is separated with
> > + * different pages for generic architectures, so that mmu protection can
> > + * work with different pci cards. However page size for LoongArch system
> > + * is 16K, memory space of different pci cards may share the same page
> > + * on LoongArch, it is not safe here.
> > + * Also uio drivers and vfio drivers sugguests that base address of memory
> > + * space should page aligned. This function aligns base address with page size
> > + */
> > +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> > +               resource_size_t size, resource_size_t align)
> > +{
> > +       resource_size_t start = res->start;
> > +
> > +       if (res->flags & IORESOURCE_MEM) {
> > +               if (align & (PAGE_SIZE - 1)) {
> > +                       align = PAGE_SIZE;
> > +                       start = ALIGN(start, align);
> I don't know whether this patch is really needed, but the logic here
> has some problems.
> 
> For example, if PAGE_SIZE=16KB, align=18KB, what should we do? Align
> to 16KB or align to 32KB? IMO it should align to 32KB, but in your
> patch it will align to 16KB.
> 
> Huacai
> > +               }
> > +       }
> > +       return start;
> > +}
> > +
> >  static void pci_fixup_vgadev(struct pci_dev *pdev)
> >  {
> >         struct pci_dev *devp = NULL;
> > --
> > 2.27.0
> >
