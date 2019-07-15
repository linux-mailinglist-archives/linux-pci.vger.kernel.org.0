Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2578A69F8C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 01:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbfGOXhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 19:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbfGOXhT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Jul 2019 19:37:19 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D9220693;
        Mon, 15 Jul 2019 23:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563233839;
        bh=rG3h1CCwAFZcD67QhSxNdHQ/Kh5vcwoW6i8O8rEvLxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4A+RIVv9w6aNcb2AVOqzfA76/Z/mJYm9CUvm+FOJSElGvHz5RJIEE6B0+P/krc93
         uZUO6RD1vpx5dmlRAX67rdUug14E06LKigjQuU9byBl1w+Ohs1pxLGLDgMgycI2GZb
         EQKXNxH2fL2zXPa2aMicYFftOFt2VVJbXV9xVX0k=
Date:   Mon, 15 Jul 2019 18:37:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] PCI: Remove functions not
 called in include/linux/pci.h
Message-ID: <20190715233717.GA79424@google.com>
References: <20190715175658.29605-1-skunberg.kelsey@gmail.com>
 <20190715181312.31403-1-skunberg.kelsey@gmail.com>
 <alpine.DEB.2.21.1907152138120.2564@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907152138120.2564@felia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 15, 2019 at 09:42:47PM +0200, Lukas Bulwahn wrote:
> On Mon, 15 Jul 2019, Kelsey Skunberg wrote:
> 
> > Remove the following uncalled functions from include/linux/pci.h:
> > 
> >         pci_block_cfg_access()
> >         pci_block_cfg_access_in_atomic()
> >         pci_unblock_cfg_access()
> > 
> > Functions were added in patch fb51ccbf217c "PCI: Rework config space
> > blocking services", ...

> Also note that commits are referred to with this format:
> 
> commit <12-character sha prefix> ("<commit message>")

FWIW, I use this shell alias to generate these references:

  gsr is aliased to `git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'

  $ gsr fb51ccb
  fb51ccbf217c ("PCI: Rework config space blocking services")

Documentation/process/submitting-patches.rst mentions a 12-char (at
least) SHA-1 but the e21d2170f36 example shows a *20*-char SHA-1,
which seems excessive to me.

I personally skip the word "commit" because I figure it's pretty
obvious what it is, but it's fine either way.

Bjorn
