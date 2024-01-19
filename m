Return-Path: <linux-pci+bounces-2395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659A98330FC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 23:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07051B22FEA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 22:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E94428694;
	Fri, 19 Jan 2024 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPbd2X83"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA260CA4E;
	Fri, 19 Jan 2024 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704773; cv=none; b=rB2Z9N0AZ1nN+Ju/MNaQhM6614elP9JAxEoDlJ1kIDtWnu8Az2tBVR7cqu5jF9cBGCqTdcRl+9ZJ07wOHHjqEbRjNviQ5qv22VJ3uIjGDvSJmGcal15kmv7j2eAdlm8Gec9nMlICXZbk258SfauHK/D4Lt0Cmr5UmEs4YI8nNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704773; c=relaxed/simple;
	bh=0ijwrmTk2cnJeJUszdORJ/iITtlbDTse4Ksm2/cj9MM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=j8m1YxL5kvkpjwbZ/1oNt8oGRYPzb9eymkC7qfyvXbTa/Jp8j5m+HN/V1WYZLJUjC2FqbOCwrEVw/2I9Fqb/puNsltyAdGpWhjw6W1apqXbjAj/2+Z+2s6YuTLc1PYMeZOiDNYH5JFpwE3850p8iU1eL4etP5BX2bFK7IL5fnxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPbd2X83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AD9C433C7;
	Fri, 19 Jan 2024 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705704772;
	bh=0ijwrmTk2cnJeJUszdORJ/iITtlbDTse4Ksm2/cj9MM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FPbd2X83mblIBLmExB3N0keu3JjEQwVSlmgpo4q/2+TuJMvG1HK0bnVCM2812dnyg
	 hLcNc3LPVtMJMT4TKbum/Sp3ThwagoHU0Bbbj8vLxECywo5ZxTzLC8xRSdI7xRQheI
	 Y3kENQ/KZdzF/aZh+H2qSe/lO99RoQ7FmZfxmFnmCNP+W9CyipXmEgA7huBOO2jOHD
	 kYMTXCK2K5DJ7C4ZADJaBu48vGyjLv/NAJtv4Xn3W7wQ3Uova5V0sWsvt4P2umScLG
	 P6ZZ+o5ub8Qk/n8TXsZ0G7Xx7Ewsb+8Dw3AtGyUO1xNLKfFkIJo2+YHjaKgJsL8l+z
	 u5HrrXYQQNDhA==
Date: Fri, 19 Jan 2024 16:52:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 01/10] pci: add new set of devres functions
Message-ID: <20240119225250.GA191270@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1983517bf5d0c98894a7d40fbec353ad75160cb4.camel@redhat.com>

On Wed, Jan 17, 2024 at 09:54:47AM +0100, Philipp Stanner wrote:
> On Tue, 2024-01-16 at 12:44 -0600, Bjorn Helgaas wrote:
> > On Mon, Jan 15, 2024 at 03:46:12PM +0100, Philipp Stanner wrote:
> > > PCI's devres API is not extensible to ranged mappings and has
> > > bug-provoking features. Improve that by providing better
> > > alternatives.
> > 
> > I guess "ranged mappings" means a mapping that doesn't cover an
> > entire BAR?  Maybe there's a way to clarify?
> 
> That's what it's supposed to mean, yes.  We could give it the longer
> title "mappings smaller than the whole BAR" or something, I guess.

"partial BAR mappings"?

> > > to the creation of a set of "pural functions" such as

s/pural/plural/ (I missed this before).

> > >         c) The iomap-table mechanism is over-engineered,
> > > complicated and
> > >            can by definition not perform bounds checks, thus,
> > > provoking
> > >            memory faults: pcim_iomap_table(pdev)[42]
> > 
> > Not sure what "pcim_iomap_table(pdev)[42]" means.
> 
> That function currently is implemented with this prototype:
> void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
> 
> And apparently, it's intended to index directly over the function. And
> that's how at least part of the users use it indeed.
> 
> Here in drivers/crypto/inside-secure/safexcel.c, L.1919 for example:
> 
> 	priv->base = pcim_iomap_table(pdev)[0];
> 
> I've never seen something that wonderful in C ever before, so it's not
> surprising that you weren't sure what I mean....
> 
> pcim_iomap_table() can not and does not perform any bounds check. If
> you do
> 
> void __iomem *mappy_map_mapface = pcim_iomap_table(pdev)[42];
> 
> then it will just return random garbage, or it faults. No -EINVAL or
> anything. You won't even get NULL.
> 
> That's why this function must die.

No argument except that this example only makes sense after one looks
up the prototype and connects the dots.

Bjorn

