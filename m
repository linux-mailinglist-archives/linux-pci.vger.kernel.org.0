Return-Path: <linux-pci+bounces-8620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AAE904788
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 01:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA711F23DF9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 23:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16490155CA0;
	Tue, 11 Jun 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy0yqy9D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC01553B5;
	Tue, 11 Jun 2024 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147529; cv=none; b=ImuSUcnuFkywJaAFXM05A8mxrz53Dx2FpBNK00BBwFRxkAyfwasmx0PLp9xcrbe5ksKppsqRd4BQsKiaTsAPA/Z89zDPc+On9blM+67pFh+bfcCy+Fe6hxcP60gm6t9pA4sPdSlapfAqDbQQDDhjtbpPz3JNXy39ytONTPvZ0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147529; c=relaxed/simple;
	bh=MACc46yuSjIiQa17hk+zIT1nViet/Ev+PmPT+idd+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FMRrITetq52zLkdy/YUxCGx/viCSRFqREFZX8PbgP7WL6+zq65o0kQUg5NXxt+bfzNEciJVZmoZeQLppR8BTBilVswKab+nbeLKMFIjcKrl0P2vfuA2xbrkf+ux6Cat8R2jwRHAbq0M9iRDOcUAMtVwgrgxM6KjNYprut8y3+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy0yqy9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B77EC2BD10;
	Tue, 11 Jun 2024 23:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718147528;
	bh=MACc46yuSjIiQa17hk+zIT1nViet/Ev+PmPT+idd+dE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Iy0yqy9DyGnisUUjUH+UOSBpIIhLTFzOcxoZ4E41BcskLZw0BuZU3BgymOMl9Ep3v
	 GHkD3qETu7yZ9W40XsL1huICkgC6nXfJeZoXa891zCc1sJfDxOCnSUkpdINkBYkmqw
	 plBW4H8fsmNfVKtfurzpGMiTxwa/palH5zTeFbZEvvBJ67alCgaLLH7l8/RKKv7YRX
	 X+qiNYWOUx1jN2jRU5TxiXd8m9XufEArHBNpGr3WBU1MlrIxg3h0vAoor7rvhKsfwx
	 QbFIvwr7QYpi259XT+Ak7iJI8jRQUmfxjLIKpcgCnx3XgLb3cvBfJbiEr6Vft4VAUv
	 1QlTvFuVz7ybA==
Date: Tue, 11 Jun 2024 18:12:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] PCI: Solve two bridge window sizing issues
Message-ID: <20240611231206.GA1006467@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <253622e9-378c-4699-886e-2240216eef59@linux.intel.com>

On Tue, May 28, 2024 at 04:10:48PM +0300, Ilpo Järvinen wrote:
> On Tue, 7 May 2024, Ilpo Järvinen wrote:
> 
> > Hi all,
> > 
> > Here's a series that contains two fixes to PCI bridge window sizing
> > algorithm. Together, they should enable remove & rescan cycle to work
> > for a PCI bus that has PCI devices with optional resources and/or
> > disparity in BAR sizes.
> > 
> > For the second fix, I chose to expose find_resource_space() from
> > kernel/resource.c because it should increase accuracy of the cannot-fit
> > decision (currently that function is called find_resource()). In order
> > to do that sensibly, a few improvements seemed in order to make its
> > interface and name of the function sane before exposing it. Thus, the
> > few extra patches on resource side.
> > 
> > v3:
> 
> Hi Bjorn,
> 
> It's a bit unclear to me what is your view about the status of this 
> series? I see you placed these first into some wip branches and then into 
> resource branch but the state of the patches in patchwork is still marked 
> as "New" nor have you sent any notice they'd have been "applied".
> 
> I'm thinking this from the perspective of whether I should send v4 with 
> those minor comments from Andy addressed or not? I could also send those
> minor things as separate patches on top of the series if that's 
> easier/better for you.

Sorry, I dropped the ball in the middle here.  The pci/resource branch
has been in linux-next since May 29, but I forgot to send a note.  If
you want to tweak for Andy's comments, send an incremental patch and
I'll be happy to squash it/them in.

