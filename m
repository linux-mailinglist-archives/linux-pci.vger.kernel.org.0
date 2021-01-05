Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2982EB4F8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 22:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbhAEVnJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 16:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731527AbhAEVnJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jan 2021 16:43:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E631822D71;
        Tue,  5 Jan 2021 21:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609882948;
        bh=RV13AM04SAc6LnhsRXRgRzBjA8MJcHEMYVs3WSv1YU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FnROa/W+BH0PRwdepuf4hbt3XxcxpJwCTOf/sNgiAkEdg5TrxHg0TSd3/7BUv9nlN
         G6Vdo3Kw4D766HGfhzoJPOV1jJGnP0MKrgwAI+ngrMWr1ceJ7VWiwutIC1Nb8BXofj
         niTCDDhgedr5jNEqEsL532UN9Hle9P+UxHUxDpflv38Ly2frAXoNWTVQnvEJ629xpH
         T3B0/1rZuPc06bGxpHZ1ncqjKQDEE/olagfNDkCRoL1GTLvKWQHNX50fdBvBiuvN8L
         Hhu2ndamXhGCDzkGNY0OLLDXcDlVPSvWUpju+vIcIZSdS68d6TscmvAgsZ/nWRUVW5
         4sE/IKKpf085g==
Date:   Tue, 5 Jan 2021 15:42:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     bhelgaas@google.com, devspam@moreofthesa.me.uk,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-pci@vger.kernel.org
Subject: Re: A PCI quirk for resizeable BAR 0 on Navi10
Message-ID: <20210105214226.GA1263318@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105134404.1545-1-christian.koenig@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 05, 2021 at 02:44:00PM +0100, Christian König wrote:
> Hi Bjorn,
> 
> Darren stumbled over an AMD GPU with nonsense in it's resizeable BAR capability dword.
> 
> This is most likely fixable with a VBIOS update, but we already sold quite a bunch of those boards with the problem.
> 
> The driver still loads without this, but the performance isn't the best.
> 
> Do you have any objection to merge this through the drm branch?

I'm OK with this in general, but please pay attention to your commit
logs:

  - Subject line prefix is "PCI: " (capitalized).

  - First word of subject is capitalized ("Add ...", "Export ...").

  - No period at end of subject ("4/4 ... XT Pulse.").

  - No "v2" included in subject line ("PCI: Add BAR ... v2").

  - Include parentheses after function names, e.g.,
    "pci_rebar_get_possible_sizes()".

  - Commit logs should say directly what the patch does using
    imperative mood, not just "to assist with X".  E.g., "Export
    pci_rebar_get_possible_sizes() for use by modular drivers."
    This should make sense even without reading the subject line.

  - No "v2" verbiage included in commit log (you can include it after
    the "---" line if you want).  That verbiage in 2/4 also contains
    two typos.

  - 2/4 does two things, so split it into two patches.  Then the
    subject and commit logs will make more sense.

  - Splitting 2/4 will also give you an opportunity to explain why we
    need to change "static inline" to "static __always_inline".  If we
    don't need that change, don't change it.

    If we *do* need it, that means we likely need it for many other
    things in include/linux/pci.h, and I would want to fix all those
    places at once in a separate patch.

  - 4/4 should be more specific about what's wrong.  Based on the
    code, this device advertises support for BAR 0 being 256MB, 512MB,
    or 1GB, but it actually supports 2GB, 4GB, 8GB, and 16GB as well.
    Please spell that out in the commit log.  "Otherwise the CPU can't
    fully access the BAR" really doesn't tell me what the patch does.
