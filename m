Return-Path: <linux-pci+bounces-13773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2A98F1EA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 16:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B73FB2154B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9B197A65;
	Thu,  3 Oct 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLULSqjr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F014D6ED
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967261; cv=none; b=CVsTUur5YXowV6bmL/RadLtcpKg0lIqogOz3Je5SYxm/zz0r3vm4dL1+buyYLFccXS4mRkM8uPsI8L36TWq43WHOEzw9nsIc1MIKoctpcb25xrOBxFgcR68nto1NNLRNnYMMAaxFypoJ9eKO1IC+qmOVdRPRqvdw9QkvSCzWIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967261; c=relaxed/simple;
	bh=f20z6j+j143TefyM2A8F7YUkvPrnjaaBD8te6HRNGH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXjRSn8A8GRlxeOq4XNk7TYIqD9x9JttS//crL43+5X0NLcvtvo4mt2lYRaQk7Wz6U0pgBpKGUyAJh51FqWU54NTHDBW6HGg1ZVTL0sfu3BJ+F6MkSHTGT14RUdaOnXP6nOnbphRdLREtTS0Duz6AJGscrSHKA/IxRnqoSGsM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLULSqjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335F4C4CEC5;
	Thu,  3 Oct 2024 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967261;
	bh=f20z6j+j143TefyM2A8F7YUkvPrnjaaBD8te6HRNGH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLULSqjrTEPWWXruHa0jFI0QUjOV1Nf0N6u9fdUBq5qYpICfu70IHFdsBo65GFhKs
	 ewxktChkgAXGsyxzKk+IKCkVl+Cgq46dPAmIOk4JeOW2wb8fAeQbvL9R5RmtG9ZMTp
	 yGmvX2YW1OnvTmEc50sqHvYzBM7DuG1gHAxMik2ucH2aJl/8d7Bvz+r2jZposV55Uf
	 689RxeNuuUMrF+YOacX/J/d9NewuVGzcQ++KvbOPkgmJhfHTkWax1p9eB/+GDQTKYL
	 S01XH3tqw1hNmSShwgs1KoVmfNknMUOqZ6zPys57AgnKal6Fgqh1poajewAhbGYFH7
	 EVGn2LP5BxzPQ==
Date: Thu, 3 Oct 2024 08:54:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 2/5] pci: make pci_destroy_dev concurrent safe
Message-ID: <Zv6wG5qF74J237w2@kbusch-mbp>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-3-kbusch@meta.com>
 <20241003023354.txfw7w4ud247h5va@offworld>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003023354.txfw7w4ud247h5va@offworld>

On Wed, Oct 02, 2024 at 07:34:13PM -0700, Davidlohr Bueso wrote:
> On Tue, 27 Aug 2024, Keith Busch wrote:
> > static void pci_destroy_dev(struct pci_dev *dev)
> > {
> > -	if (!dev->dev.kobj.parent)
> > +	if (pci_dev_test_and_set_removed(dev))
> 
> Doesn't this want to be if (!pci_dev_test_and_set_removed()) ?

No, this function returns the previous value of the REMOVED flag. If
it's already set, then another thread already removed this device.
 
> This also fixes a splat when triggering a removal when you add
> subordinate refcounting is added:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/commit/?h=pci-bus-locking-2024-09-09&id=3883c485d5e45b5e17f685f77ff4020bec162336

Oh, that's pretty neat. Thanks for testing that! I think that reference
counting patch is pretty safe too. I can rebase the series with that one
included next time.

