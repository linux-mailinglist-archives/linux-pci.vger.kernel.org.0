Return-Path: <linux-pci+bounces-39057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4000BFDCAC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 20:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F4484E87CC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A82E283A;
	Wed, 22 Oct 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZt9WTaa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EA238C3B
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156884; cv=none; b=eplMOsTGX8wtHePYhtDOYPYpxpN430FRjgZGyKJExHS3qPjdH+wfDktDfWP0SNOKD0LQwYa/h6XlKvHodi2Tis5xAgQEx0RYqBA839KZNjWmjt2Mr4SO2GagiCsdojgPYnSPQ+61MuANLZGvo1kKQni71XE/UzDSX8R3EkFgMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156884; c=relaxed/simple;
	bh=26/KYMiJ1t7xGbWwSC1tDrt57nh16G4z027IIlphW+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AOTddeiPJlEL8y48v1bR7BXRJn/jftGg0KuBZ89AiFaIMXb8xAPwTwJMbwVOWA9O7CuONFSwSlrPsIZwExH1KUEWe+Ci2j/3wrLMwCQxOTzV0h/nvYAML85YUyEyKLdAqSoIm4sDWMsnQuqvPhgQWbsoCwPsR0WnMk6M+32nzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZt9WTaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83394C4CEE7;
	Wed, 22 Oct 2025 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761156883;
	bh=26/KYMiJ1t7xGbWwSC1tDrt57nh16G4z027IIlphW+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dZt9WTaaqniF+LKvJC2y899pn0HG6mFKQvvYwhJYn2WLwLMpO2dxcJjA8CTrGcgLy
	 gRkOa2zWjSklXzxkpCvcM/j7cHtHWeE4bJZ35FBqm7s2n9WCUW27PJCpCmQbvUsJtY
	 GosxWg/kB7THNHF8xBTijqb9wXDjN+Lh2QtC46kFiV2IFk28d309eJYR1W3CYvFrEB
	 K7Hmlsmz2Lhnd+LEbk87MapoXCdZlwOEvchsOTV49hPcvymMOgiY+It3lvUgSFy6MF
	 1tXlRMW7zJzik9BZCklQmUuvgJkd7Cl/T8+ucxeogluV6RsQrN3as5EjlAHBrGSE/3
	 h0/Wut8ZOmijw==
Date: Wed, 22 Oct 2025 13:14:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
Message-ID: <20251022181442.GA1262389@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oiqs7vjw3hxbrp3tnlgut5zh3547tgowsixip5cgagyuh3uv4e@n7wielcx6hmc>

On Wed, Oct 22, 2025 at 11:05:50PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 22, 2025 at 11:22:29AM -0500, Bjorn Helgaas wrote:
> > On Wed, Oct 22, 2025 at 03:59:13PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Oct 22, 2025 at 06:13:59PM +0800, Shawn Lin wrote:
> > > > 在 2025/10/22 星期三 18:02, Manivannan Sadhasivam 写道:
> > > > > On Tue, Oct 21, 2025 at 03:48:24PM +0800, Shawn Lin wrote:
> > > > > > of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
> > > > > > is properly connected and could enable L1.1/L1.2 support.
> > > > > > 
> > > > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > > > ---
> > > > > >   drivers/pci/of.c  | 18 ++++++++++++++++++
> > > > > >   drivers/pci/pci.h |  6 ++++++
> > > > > >   2 files changed, 24 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > > index 3579265f1198..52c6d365083b 100644
> > > > > > --- a/drivers/pci/of.c
> > > > > > +++ b/drivers/pci/of.c
> > > > > > @@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
> > > > > >   	return 0;
> > > > > >   }
> > > > > >   EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> > > > > > +
> > > > > > +/**
> > > > > > + * of_pci_clkreq_present() - Check if the "supports-clkreq" is present
> > > > > 
> > > > > I don't see a benefit of this API, tbh. The API name creates an
> > > > > impression that the API will check for the presence of CLKREQ#
> > > > > signal in DT, but it checks for the presence of the
> > > > > 'supports-clkreq' property. Even though the presence of the
> > > > > property implies that the CLKREQ# routing is available, I'd
> > > > > prefer to check for the property explicitly instead of hiding it
> > > > > inside this API.
> > > > 
> > > > It makes sense.
> > > > 
> > > > Will the name of_pci_supports_clkreq_present() look good? Or we
> > > > just drop it and let host drivers to explicitly check
> > > > supports-clkreq inside their code?
> > > 
> > > I'd prefer to drop the API.
> > 
> > An API might help with consistency across DT bindings.  We don't want
> > drivers to pick their own names for 'supports-clkreq'.
> 
> I don't know what you mean by 'drivers to pick their own names'.
> With or without this API, the drivers have to use a local variable:

I just meant different names for the 'supports-clkreq' DT property.
But the schema I mentioned should be enough for that.

