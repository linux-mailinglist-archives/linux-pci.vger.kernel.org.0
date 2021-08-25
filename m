Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0703F7D4A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 22:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbhHYUoo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 16:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231873AbhHYUoo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 16:44:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 325DA61058;
        Wed, 25 Aug 2021 20:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629924238;
        bh=epmZVNLpdoNNDDzsLFMtPJJY8zT6fOFNdSrHyazfAFc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ra5IUkehvbZtQdm7W4WXEm0QjeczmOPSfqAsbPMSfRMwiXielKmUkivmu+qjOvX6t
         MqRi1vlWCH2cLCvRGL9X67vUNfI5uh4KcODGIcrbWEZGBJhU2HNd61JKfiObOwGa30
         AD0hYtLSKq7ys47y2O1whQQ5dpbFdAW97LB+zs36LCxjnKraCcnoFHx2v/HwJNXsvi
         JHb3jiyU3ywhhUasoACqdakRAlcgZQlcd1EnndWwDK4gsEGki16Kmy/vYao4I2S8Xn
         beSoinZSrlnyF0Z78y1WLAbrypZ9HOa8eVHyAIQq/DcPl1GETRXmsF52iDVDWDlxT0
         9oEWkB4cTryiw==
Date:   Wed, 25 Aug 2021 15:43:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergio =?iso-8859-1?Q?Migu=E9ns?= Iglesias <lonyelon@gmail.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, konrad.wilk@oracle.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org,
        Sergio =?iso-8859-1?Q?Migu=E9ns?= Iglesias <sergio@lony.xyz>
Subject: Re: [PATCH] PCI: Fix general code style
Message-ID: <20210825204356.GA3601025@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804222832.1023161-1-sergio@lony.xyz>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 05, 2021 at 12:28:32AM +0200, Sergio Miguéns Iglesias wrote:
> The code style for most files was fixed. This means that blank lines
> were added when needed (normally after variable declarations), spaces
> before tabs were removed, some code alignment issues were solved, block
> comment style was fixed, every instance of "unsigned var" was replaced
> with "unsigned int var"... Etc.
> 
> This commit does not change the logic of the code, it just fixes
> aesthetic problems.

I generally *like* this, and it does fix some annoying things, but I
think it's a little too much all at once.  If we're working in a file
and doing actual bug fixes or new functionality, and we want to fix
some typos or something at the end, that might be OK, but I think the
churn in the git history outweighs the benefit of this huge patch.

So I would encourage you to use some of the PCI expertise you've
gained by looking at all this code to work on something with a little
more impact.  Here are a couple ideas:

  - There are only two uses of __ref and __refdata in drivers/pci/.
    The fact that they're so rare makes me suspect that we don't need
    them.  But I haven't investigated these to see.  Somebody could
    check that out and remove them if we don't need them.  Be aware
    that I will want a clear argument for why they're not needed :)

  - Coverity complains about several issues in drivers/pci/ [1].  Most
    of the time these are false positives, but not always.  Sometimes
    there's an actual bug, and sometimes there's a way to restructure
    the code to avoid the warning (which usually means doing things
    the same way they are done elsewhere).

  - "make C=2 drivers/pci/" (sparse checker, [2]) complains about a
    few things.  Leave the pci_power_t ones alone for now, but there
    are a couple other type issues that could be cleaned up.

[1] https://docs.google.com/spreadsheets/d/19eyNDou83JACzf44j0NRzEWysva6g44G2_Z9IEXGVNk/edit?usp=sharing
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/dev-tools/sparse.rst?id=v5.13

> Signed-off-by: Sergio Miguéns Iglesias <sergio@lony.xyz>
> ---
>  drivers/pci/access.c       | 22 +++++++++++++---------
>  drivers/pci/bus.c          |  3 ++-
>  drivers/pci/msi.c          | 12 +++++++-----
>  drivers/pci/pci-acpi.c     |  3 ++-
>  drivers/pci/pci-driver.c   | 19 +++++++++++++------
>  drivers/pci/pci-sysfs.c    | 14 ++++++++++++--
>  drivers/pci/pci.c          | 16 ++++++++++++----
>  drivers/pci/proc.c         | 15 +++++++++++++++
>  drivers/pci/quirks.c       | 35 ++++++++++++++++++++++++-----------
>  drivers/pci/remove.c       |  1 +
>  drivers/pci/rom.c          |  2 +-
>  drivers/pci/setup-bus.c    |  5 ++++-
>  drivers/pci/setup-irq.c    | 12 +++++++-----
>  drivers/pci/setup-res.c    |  2 +-
>  drivers/pci/slot.c         |  5 ++++-
>  drivers/pci/syscall.c      |  5 +++--
>  drivers/pci/xen-pcifront.c | 20 ++++++++++++--------
>  17 files changed, 133 insertions(+), 58 deletions(-)
