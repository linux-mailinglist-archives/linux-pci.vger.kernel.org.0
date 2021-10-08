Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC9426DE7
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbhJHPqD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 11:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243124AbhJHPp6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 11:45:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 480C360F6F;
        Fri,  8 Oct 2021 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633707842;
        bh=wWza1QQ9A9nM5fzLLXELMHyuv+B06Am2Aiioy23VP9o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dqc4/43k9WhL/oZuH5OftnuaSiFI09ToEfJ4kyjfVxRS7yQSmEZif4PAeY4VaZOh0
         a7qWeIB0mX7yRv1YiclalOat2N4AGO9y243//ouETQM30jB3A9/UVLwVph4Wg5MFYQ
         2oGirOHedt7CgIkHmPxpVKhPpSWSJIqtC9TlIBsWp3byN66mqSIQ0I2a/R8Jn4tM6B
         /gayz51jAuK/3JLmY1HR4xZn5Py6xQ23go3jm9Cbc6vvnln0NX8IHgC649NBqRDHoM
         qsowzae4BDaDiPorfha+BrZOmEn2EYIF5BmFsT2d4mGZHH1Kjtt3GxzUYW7kFXmL0y
         7z3eSzpJ39jrg==
Date:   Fri, 8 Oct 2021 10:44:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>, benoitg@coeus.ca,
        bhelgaas@google.com, hpa@zytor.com, juhapekka.heikkila@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/resource: Do not exclude regions that are
 marked as MMIO in EFI memmap
Message-ID: <20211008154400.GA1342961@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008105638.GA1313587@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 08, 2021 at 05:56:40AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 08, 2021 at 11:45:38AM +0200, Borislav Petkov wrote:
> > On Fri, Oct 08, 2021 at 12:23:31PM +0300, Mika Westerberg wrote:
> > > On Fri, Oct 08, 2021 at 10:55:49AM +0200, Werner Sembach wrote:
> > > > Is there any update on this matter? Also happens on discrete Thunderbolt 4 chips:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=214259
> > > 
> > > AFAICT no updates.
> > > 
> > > @Bjorn, x86 maintainers,
> > > 
> > > If there are no alternatives can we get this patch merged so that people
> > > don't need to carry out-of-tree patches to get their systems working?
> > 
> > Just my 2¢ from briefly skimming over this:
> > 
> > So this reads yet again as BIOS is to blame but what else is new?
> > 
> > "All in all, I think we can fix this by modifying
> > arch_remove_reservations() to check the EFI type as well and if it is
> > EFI_MEMORY_MAPPED_IO skip the clipping in that case."
> > 
> > And this like we should trust EFI to mark those regions properly, which
> > is more of the same but in different color.
> > 
> > That original commit talks about windoze doing a different allocation
> > scheme and thus not trusting the untrustworthy firmware anyway and that
> > sounds like something we should do too. But WTH do I know?!
> 
> There are a couple other threads reporting similar issues:

Bug reports from these threads:

>   https://lore.kernel.org/r/20210624095324.34906-1-hui.wang@canonical.com

  http://bugs.launchpad.net/bugs/1931715
  http://bugs.launchpad.net/bugs/1932069
  http://bugs.launchpad.net/bugs/1921649

>   https://lore.kernel.org/r/20211005150956.303707-1-hdegoede@redhat.com

  https://bugzilla.redhat.com/show_bug.cgi?id=1868899
  https://bugzilla.redhat.com/show_bug.cgi?id=1871793
  https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279

Most of these bug reports mention "pci=nocrs" as being a workaround.
Obviously not a solution, but may be a way to limp along in the
meantime.
