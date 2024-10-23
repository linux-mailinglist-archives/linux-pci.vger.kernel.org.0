Return-Path: <linux-pci+bounces-15156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 906FD9AD757
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 00:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350581F21069
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C31494B3;
	Wed, 23 Oct 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9BOIzfO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA413B7BE
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729721244; cv=none; b=D7pBFxl0qP7FkQ/G3YCKHJzYDJC7ykykqSL4aRP5a63CKgb6z5cDhuWW+ivzwsrIh0mB7fIURGDS9J9nA7fEm8qTyn9Hr5/dERgSCet0TZ9aRGkm8lFBm/qWZLUaLJC+A8HxMgkDp9lu7zBTjiIBhVe/JeuDABXMqjmHLg18yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729721244; c=relaxed/simple;
	bh=vnfnrvulBTOqkObqa5vWVHf89oZDpbkg9OJU6ifMKLk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bjh/rFlxXVjy2bv1QQFXSfCagg4iV4fq7Yy0nKULDJ9lktkVNgNbxpQ5HhQ+1hxd8be3DjG7kRdW+q/JS+ZzAsb6qXJV+67H5PhjApwi/mk179pHXcIzsyvTwECKSaUXNkEmz5oRmKMWBOo63hpAlBM/deyye0E+1Xhm5CzeEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9BOIzfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B1DC4CEC6;
	Wed, 23 Oct 2024 22:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729721243;
	bh=vnfnrvulBTOqkObqa5vWVHf89oZDpbkg9OJU6ifMKLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=L9BOIzfO5Lyho2NjunTbMFQfz9LP/Knp5Xm5GMmtNJNdghaJmrA1JMEtqiqWoA8Lr
	 7R/2xkZLLz7Tv9ltxWOJyv1cASZP2K/c6iRmbXKGIsXaBnuWxGyddqrlG5YY6W7AqW
	 +EVtVFsih1dHo+KjMcKPdtidZ0PCH3dHAR3muJKK2nW8d2CsAT7Gko1pWe5mBcAauA
	 kUI9s+sQNR8k5vgxm5X+AsXuRUZxntMblIztLbJ1OLGk+W3CWyVdnd63df49DAlaOE
	 6RjOZurpv/6MNvZ06omriOiZMKD+9Hh/DIV9pTEGGbvlNHkSJlH6S5fCY3D3jhpEoC
	 7PHHSroq27Msw==
Date: Wed, 23 Oct 2024 17:07:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, lukas@wunner.de,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCHv3 5/5] pci: unexport pci_walk_bus_locked
Message-ID: <20241023220722.GA940224@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxlyCvf1DQS9GYvS@kbusch-mbp>

On Wed, Oct 23, 2024 at 04:00:42PM -0600, Keith Busch wrote:
> On Wed, Oct 23, 2024 at 04:43:20PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 22, 2024 at 03:48:51PM -0700, Keith Busch wrote:
> > > @@ -445,7 +445,6 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *
> > >  
> > >  	__pci_walk_bus(top, cb, userdata);
> > >  }
> > > -EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
> > 
> > I think we could also move the declaration from include/linux/pci.h to
> > drivers/pci/pci.h, right?
> > 
> > I guess there's some argument for keeping it in include/linux/pci.h
> > next to the pci_walk_bus() declaration, but I certainly don't want to
> > encourage more use of either one, especially outside the PCI core.
> 
> Thanks, that's a good point! Not only are modules not using this,
> neither does any kernel code outside drivers/pci/, so no need to
> declare this in include/linux/.

I'll make this change locally so you don't need to repost for it.

