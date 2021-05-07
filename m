Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9473768FB
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhEGQmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 12:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236405AbhEGQmT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 12:42:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0265760232;
        Fri,  7 May 2021 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620405678;
        bh=8qu3pcdWdcBMrLO+cWfb7Fgok5Qi7EPzYPQFmIT4w3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t1dJgVdaJQCgQbGm7k3ibCU2iN3hS/7Snik0+4p63b9ctcA/i2QWfTsk32V91Q41v
         J+zymwDmoKMGrSkLxWJ8dyIzQEp3NqcA+RRKULMIQXr/vN1Bqqh4GJdN/ie2yVkwBc
         4qHKmAVqnhN7Y4rylf1aG8rYHHtg4N6KFm3jb2sCiObfOVfjd4n6YEA4RJn/YkLbtE
         3VE7xooyuAJpOO3+weSv54uS+3KPjzy7sqAlHGbaNFeESE15L9nr6POeEuKxo7FooB
         qhIb+sKA1XtczhbSev5CJ8Pwtk8Ws/bnjWjnz/9QGj7ThU6098sm0sHVRk1ZbFAoeG
         tDGhUaISjiaNQ==
Date:   Fri, 7 May 2021 11:41:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/42] PCI: pci-bridge-emul: Add PCIe Root Capabilities
 Register
Message-ID: <20210507164116.GA1512466@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210507144015.bol3qeqsdoo7nmju@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 07, 2021 at 04:40:15PM +0200, Pali Rohár wrote:
> On Thursday 06 May 2021 18:10:09 Bjorn Helgaas wrote:
> > On Thu, May 06, 2021 at 05:31:16PM +0200, Pali Rohár wrote:

> > > Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
> > > Cc: stable@vger.kernel.org # e0d9d30b7354 ("PCI: pci-bridge-emul: Fix big-endian support")
> > 
> > I'm not sure how people would deal with *two* SHA1s.
> 
> I guess that this is fine per stable document as it mention such example:
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Oh, I see what you mean: the SHA1 on the stable tag is a prerequisite.
I had forgotten that, but it makes sense.  Thanks!

> > This patch adds functionality, so it's not really fixing a bug in
> > 23a5fba4d941.
> 
> I'm not sure what is the correct meaning of Fixes tag. I included it to
> easily determinate in which commit was introduced member name "rsvd"
> which should have been named "rootcap".

IMO, the point of "Fixes: X" is to say that "if your kernel includes
commit X, you should consider also including this patch because it
fixes a problem with X."

In this case, the fact that your kernel includes 23a5fba4d941 is not
an indication that you should include this patch because this patch
doesn't fix a defect in 23a5fba4d941.

> Submitting patches document is not fully clear for me as I understood it
> that Fixes and CC:stable are two different things. E.g. it mention
> "Attaching a Fixes: tag does not subvert ... the requirement to Cc:
> stable@vger.kernel.org on all stable patch candidates." which I
> understood that patch for backporting needs to have Cc:stable:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Yes, I think you're right.  "Fixes:" by itself just indicates that
this fixes a defect in a previous patch.  But the fix may not rise to
the level of being considered for stable, because historically we only
wanted small, critical fixes for stable kernels.

I think this patch should omit both Fixes: and the stable tag.

If a future patch that depends on this one is a candidate for stable,
*that patch* should have a stable tag with this patch as a
prerequisite.

Useful tidbit I found recently -- a URL like this:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.12#n554

is more specific and won't become stale as the doc changes.  (If you
follow that URL five years later, the doc will have changed so the
v5.12 version will be stale, but at least the URL still makes sense in
the context of this conversation.)

Bjorn
