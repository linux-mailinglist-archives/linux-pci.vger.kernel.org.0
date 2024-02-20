Return-Path: <linux-pci+bounces-3789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2407E85C177
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E90B2490E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3E762E0;
	Tue, 20 Feb 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX9sKyh0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CFC1C2E;
	Tue, 20 Feb 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446727; cv=none; b=XcQF1WgHYepTq4cX/1AxDenGdHsAt3T4DkhAlw92nWnBb+XczRVPtvszMzJCe6jnWMV0Jfysj9wqDihbrp2ASPei2eu7ucdW9QZBuDm2NXkrUbhtltkBDvHVReEtv327Zj2vh0lQEqMdGt2EKNHwwVHVwpIEUW029++27AOFaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446727; c=relaxed/simple;
	bh=D+jojySyxHflylV0x+i2wU7HYWzfj4v2dVxzzimPGlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DhwqqCYToDt3exHxgS7mukSj+mGSzKAuQ2NE3Bj9UXTe06G+J3OmVg/egC15FGFPZQyKNPfjXZP0AR5FUy8Q4z5aM1641EGktvnPnelpvdecrd+ftjY3cys6UHi0/r5fB2yMWtUWpHYBBaEGLkRUUu7XDEfhVyLmJlUy20vAxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dX9sKyh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD49C433C7;
	Tue, 20 Feb 2024 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708446726;
	bh=D+jojySyxHflylV0x+i2wU7HYWzfj4v2dVxzzimPGlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dX9sKyh0rd5HWd9IX1RLfZyvRlhh3UPuzrTE+KlfQqp/Tm/OXA5GSqER4mlfYgiCB
	 e3q1Z3m/eiA3D0bxAer4C1W75Ichz3QUHYKm08WYU/0CZ0sMfObTwL3NItQ38u0klS
	 unoWiWt+rdJhVH7UmrYRTdC+49zfn+iV2F2/MAYO5Is9h6Md54AmNyq+k9f0hPjhoB
	 jvD9n7b7Gq4uPbeMLtgBHBzBspxCgEJs0gPKiFlsIGomrP9nGCBAeS8MwwXOzEIIU8
	 SS9kb52+pcZ4rZ+qeCE/Db7I8d+YEm/51DynEMqoYKjSAD+X0U3vwHslgvgU7yyH/+
	 at//MnzuV576Q==
Date: Tue, 20 Feb 2024 10:32:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI/AER: Fix rootport attribute paths in ABI docs
Message-ID: <20240220163205.GA1492099@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdRc_RkaaSMxz8HW@hovoldconsulting.com>

On Tue, Feb 20, 2024 at 09:04:13AM +0100, Johan Hovold wrote:
> Hi Bjorn,
> 
> On Fri, Feb 02, 2024 at 05:24:35PM -0600, Bjorn Helgaas wrote:
> > On Fri, Feb 02, 2024 at 02:16:33PM +0100, Johan Hovold wrote:
> 
> > > Johan Hovold (2):
> > >   PCI/AER: Fix rootport attribute paths in ABI docs
> > >   PCI/AER: Clean up version indentation in ABI docs
> 
> > Applied to pci/aer for v6.9, thanks!
> 
> I noticed that these have not shown up in linux-next yet. Did you forget
> to push the branch?

Indeed I did forget.  Updated and pushed, thanks!

Bjorn

