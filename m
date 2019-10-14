Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A86AD6BFD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 01:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfJNXXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 19:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfJNXXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 19:23:48 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A62217F9;
        Mon, 14 Oct 2019 23:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571095428;
        bh=AoS9bumm7eRsNMYlt9JxKKDtGznr35Rexk3AX3JJ7z4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mv7GkiSSdYCYgHVoYCHdesx8vq8x2FUIhVSFSlbxNMeits476kgsTUQpe3TL/XXim
         kIiNjeXfnMtUH8m8AEQAT/jQYcDjPhsf9M9Gazc0aJU1/2xDtcxvhGvmne/MsC08nB
         phnBI50cCKjQQNUs8VHxCotQkRw2fo/Pe25AMaZ0=
Date:   Mon, 14 Oct 2019 18:23:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kuldeep Dave <kuldeep.dave@xilinx.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pci@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for
 Microblaze
Message-ID: <20191014232345.GA246093@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008154652.GB7903@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 08, 2019 at 08:46:52AM -0700, Christoph Hellwig wrote:
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index a304f5ea11b9..9d259372fbfd 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -52,7 +52,7 @@ config PCI_MSI
> >  	   If you don't know what to do here, say Y.
> >  
> >  config PCI_MSI_IRQ_DOMAIN
> > -	def_bool ARC || ARM || ARM64 || X86 || RISCV
> > +	def_bool ARC || ARM || ARM64 || X86 || RISCV || MICROBLAZE
> 
> Can you find out what the actual dependency is so that we can
> automatically enabled this instead of the weird arch list?

Hi Michal, I'll wait for your response on whether it's feasible to do
something smarter than listing every arch here.  Please ping here or
post a v3; since I marked this patch "Changed Requested" in patchwork,
it's fallen off my to-do list.

Bjorn
