Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A6724E48
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjFFUp0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 16:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjFFUp0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 16:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15909E7E;
        Tue,  6 Jun 2023 13:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9948C630EA;
        Tue,  6 Jun 2023 20:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B098BC433D2;
        Tue,  6 Jun 2023 20:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686084324;
        bh=68tKpI2HU5uWW5UQM+HSKSBXNSVkchVHaoEuof6BVrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O/fYW8OkKSbLgX9E4bsHNn6FXN94l0YBRl/nbW+Hu54Mr4Nl02Swt9a4rhQk44upo
         oNCe5d9yx76ksPnD/TQv3zLToVEdsQ/AH/Gxgkf7v+38IiH2mGEuvS05vZKbRW0wQE
         rRx+gsJueSaPFogOzlT1TDJJBzScoYmuiTaU7oXUeihrp9k/PACWSzdjW5aEO+9GvG
         1RhHhkRrkHA/qUOYjJotqlB6fvQh3otd/S6P8952M2Co/P261HrpXzRlOg8UDjgcV0
         0hwiqQrr2VE0cdl1Zj4PaDlaPlaTbFzAfxkVnHJKJAu8gAhIxKtKJllGtTIxUn/oTj
         FzKLsXT7tuL7Q==
Date:   Tue, 6 Jun 2023 15:45:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "bibo, mao" <maobibo@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI: Align pci memory space base address with page
 size
Message-ID: <20230606204522.GA1142773@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57c428e9-6d7c-c0b7-be5f-365373ab1b9c@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 06, 2023 at 06:06:04PM +0800, bibo, mao wrote:
> Huacai,
> 
> Although I post this patch, I think this should be arch specified
> rather than general problem.  X86 has solved this problem, arm64
> with 64K page size is not popular. However LoongArch has this
> problem, page size is 16K rather than 4K. It is the problem of
> LoongArch system rather than generic issue.

I think this is only related to the page size, not to any
LoongArch-specific details.  If that's the case, I don't think the
change should be arch-specific.

> There is such discussion before:
> https://patchwork.kernel.org/project/linux-pci/patch/22400b8828ad44ddbccb876cc5ca3b11@FE-MBX1012.de.bosch.com/#19319457
> 
> UEFI bios sets pci memory space 4K aligned, however Loongarch kernel rescans the pci
> bus and reassigns pci memory resource. So it it strange like this, here is pci memory info on
>  my 7A2000 board.
> root@user-pc:~# lspci -vvv | grep Region
>         Region 5: Memory at e003526e800 (32-bit, non-prefetchable) [size=1K]
>         Region 0: Memory at e003526ec00 (64-bit, non-prefetchable) [size=1K]

I guess these BARs are from different devices, and the problem you're
pointing out is that both BARs end up in the same 16K page (actually
even the same 4K page):

  (gdb) p/x 0xe003526e800 >> 12
  $1 = 0xe003526e
  (gdb) p/x 0xe003526ec00 >> 12
  $2 = 0xe003526e

I agree that's a potential issue because a user mmap of the first
device also gets access to the BAR of the second device.  But it
doesn't seem to be a *new* or LoongArch-specific issue.

So I *think* the point of this patch is to ensure that BARs of
different devices never share a page.  Why is that suddenly an issue
for LoongArch?  Is it only because you see more sharing with 16K pages
than other arches do with 4K pages?

> 在 2023/6/6 16:45, Bibo Mao 写道:
> > Some PCI devices have only 4K memory space size, it is normal in general
> > machines and aligned with page size. However some architectures which
> > support different page size, default page size on LoongArch is 16K, and
> > ARM64 supports page size varying from 4K to 64K. On machines where larger
> > page size is use, memory space region of two different pci devices may be
> > in one page. It is not safe with mmu protection, also VFIO pci device
> > driver requires base address of pci memory space page aligned, so that it
> > can be memory mapped to qemu user space when it is passed-through to vm.

The minimum memory BAR per spec is 128 bytes (not 4K).  You just
demonstrated that even with 4K pages, different devices can share a
page.

> > It consumes more pci memory resource with page size alignment requirement,
> > it should not be a problem on 64 bit system.
> > 
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> >  drivers/pci/setup-res.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > index 967f9a758923..55440ae0128d 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> > @@ -339,6 +339,14 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
> >  		return -EINVAL;
> >  	}
> >  
> > +#ifdef CONFIG_64BIT
> > +	/*
> > +	 * force minimum page alignment for vfio pci usage
> > +	 * supposing there is enough pci memory resource on 64bit system
> > +	 */
> > +	if (res->flags & IORESOURCE_MEM)
> > +		align = max_t(resource_size_t, PAGE_SIZE, align);
> > +#endif

Why is this under CONFIG_64BIT?  That doesn't have anything to do with
the BAR size.  The only reason I can see is that with CONFIG_64BIT=y,
we *might* have more MMIO space to use for BARs.

> >  	size = resource_size(res);
> >  	ret = _pci_assign_resource(dev, resno, size, align);
