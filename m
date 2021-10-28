Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3209643E51F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJ1PcO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 11:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhJ1PcN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 11:32:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE9A260D43;
        Thu, 28 Oct 2021 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635434986;
        bh=0pEtuBbJbKS62a7MHHyfHpuBZ1PrBLK9hi7o7dnBpxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kpdtv3/+6NY9VzeByzgc4MKTutV6el3IKzNVnC8Zt2YZVV4f97Q3xX9rf4Ki+0o/M
         r0h98G7F05VwZd1fp4PlQBM9VE5C30x22G0ytX+O/7GhoRd5DbByl/4T5V9cd6URUb
         yTWjWf91SpcNgMLxS7L0zgNGZz2k9etJpY5Km9295SENiKkeiuvdgf5zdYrqy9yb/j
         eLmHI06gBAbafV1lE0AE0mVtz4VifBljibuy+RHKMD/6pN+E67OvlvS3ycSB+t6iqN
         P2kRE7XFV1NKdLQeRiwgXWS4WfHT8esQ9tge9EraIRr/Z2c57wr52E0EmRB2R/VxFy
         o3b0u3orGRomA==
Received: by pali.im (Postfix)
        id 70192689; Thu, 28 Oct 2021 17:29:44 +0200 (CEST)
Date:   Thu, 28 Oct 2021 17:29:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211028152944.5dlxciqhkrg6wx3b@pali>
References: <20211012164145.14126-1-kabel@kernel.org>
 <20211012164145.14126-11-kabel@kernel.org>
 <20211027141246.GA27543@lpieralisi>
 <20211027142307.lrrix5yfvroxl747@pali>
 <20211028110835.GA1846@lpieralisi>
 <20211028111302.gfd73ifoyudttpee@pali>
 <20211028113030.GA2026@lpieralisi>
 <20211028113724.gm6zhqt7qcyxtgkq@pali>
 <87r1c59nqf.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1c59nqf.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 28 October 2021 16:24:08 Marc Zyngier wrote:
> On Thu, 28 Oct 2021 12:37:24 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > On Thursday 28 October 2021 12:30:30 Lorenzo Pieralisi wrote:
> > > On Thu, Oct 28, 2021 at 01:13:02PM +0200, Pali Rohár wrote:
> > > 
> > > [...]
> > > 
> > > > > > In commit message I originally tried to explain it that after applying
> > > > > > all previous patches which are fixing MSI and Multi-MSI support (part of
> > > > > > them is enforcement to use only MSI numbers 0..31), it makes driver
> > > > > > compatible with also MSI-X interrupts.
> > > > > > 
> > > > > > If you want to rewrite commit message, let us know, there is no problem.
> > > > > 
> > > > > I think we should.
> > > > > 
> > > > > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > > > > Reviewed-by: Marek Behún <kabel@kernel.org>
> > > > > 
> > > > > By the way, this tag should be removed. Marek signed it off, that
> > > > > applies to other patches in this series as well.
> > > > 
> > > > Ok! Is this the only issue with this patch series? Or something other
> > > > needs to be fixed?
> > > 
> > > The series looks fine to me - only thing for patch[4-10] I'd like
> > > to have evidence MarcZ is happy with the approach
> > 
> > Marc, could you look at patches 4-10 if you are happy with them? Link:
> > https://lore.kernel.org/linux-pci/20211012164145.14126-5-kabel@kernel.org/
> 
> Started with patch #4, and saw that you are still using
> irq_find_mapping + generic_handle_irq which I objected to every time I
> looked at this patch ([1], [2]).
> 
> My NAK still stands, and I haven't looked any further, because you
> obviously don't really care about review comments.

I passed to Marek all patches including handling and fixing these
issues. But because Lorenzo wanted smaller patch series, Marek probably
has not included them in this batch 2.

> 	M.
> 
> [1] https://lore.kernel.org/r/8735r0qfab.wl-maz@kernel.org
> [2] https://lore.kernel.org/r/871r6kqf2d.wl-maz@kernel.org
> 
> -- 
> Without deviation from the norm, progress is not possible.
