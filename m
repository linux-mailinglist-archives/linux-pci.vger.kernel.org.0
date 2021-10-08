Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D68426857
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJHK6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 06:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhJHK6f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 06:58:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C56BE60FC1;
        Fri,  8 Oct 2021 10:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633690600;
        bh=gPD2dLQZJxejC7F6YoYRsU33148JMVotY1liLeLhOtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ebXdow8iZxUmJdzf5lQNXq1BKus0CpYy4CKGmUc41oJsnsw+S/CB98WZy9F5LJ6Jw
         y+Z8bC7NN3mbtMGS8I8gtJYT5+Z85/NefqB5AzjaEFAgnTA3qTUJ1Mw4+riYzHunfi
         C5DlhUCwrUFndrIl16wOOskvhkdKU6xAmMZkUiByc/WJyGDmvWmU0A/lVmgIQGHIfA
         tIRBd5gQsv9uGwjKENJBrnurGsXQrD47EGgv9FNIqAaNUw7y5xg+EHTjpUb4JJWmrS
         sn2Ut0ibgH6KUsLin0qA7JxNqnWzoJ8L/xuhf6IrHGIZQJg9wtQI9e0mmU1SMJyPBc
         IVCWyYLJxCjdw==
Date:   Fri, 8 Oct 2021 05:56:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>, benoitg@coeus.ca,
        bhelgaas@google.com, hpa@zytor.com, juhapekka.heikkila@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/resource: Do not exclude regions that are
 marked as MMIO in EFI memmap
Message-ID: <20211008105638.GA1313587@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YWATQgGOFQIlLOlV@zn.tnic>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Fri, Oct 08, 2021 at 11:45:38AM +0200, Borislav Petkov wrote:
> On Fri, Oct 08, 2021 at 12:23:31PM +0300, Mika Westerberg wrote:
> > Hi,
> > 
> > On Fri, Oct 08, 2021 at 10:55:49AM +0200, Werner Sembach wrote:
> > > Is there any update on this matter? Also happens on discrete Thunderbolt 4 chips:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=214259
> > 
> > AFAICT no updates.
> > 
> > @Bjorn, x86 maintainers,
> > 
> > If there are no alternatives can we get this patch merged so that people
> > don't need to carry out-of-tree patches to get their systems working?
> 
> Just my 2¢ from briefly skimming over this:
> 
> So this reads yet again as BIOS is to blame but what else is new?
> 
> "All in all, I think we can fix this by modifying
> arch_remove_reservations() to check the EFI type as well and if it is
> EFI_MEMORY_MAPPED_IO skip the clipping in that case."
> 
> And this like we should trust EFI to mark those regions properly, which
> is more of the same but in different color.
> 
> That original commit talks about windoze doing a different allocation
> scheme and thus not trusting the untrustworthy firmware anyway and that
> sounds like something we should do too. But WTH do I know?!

There are a couple other threads reporting similar issues:

  https://lore.kernel.org/r/20210624095324.34906-1-hui.wang@canonical.com
  https://lore.kernel.org/r/20211005150956.303707-1-hdegoede@redhat.com

I think 4dc2287c1805 ("x86: avoid E820 regions when allocating address
space") was a mistake and we should remove that instead of adding more
complexity to it.

But that requires another approach to fix the issue that 4dc2287c1805
addressed.

Bjorn
