Return-Path: <linux-pci+bounces-39048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0249BFD9D2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A4C3A7158
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9702F274B53;
	Wed, 22 Oct 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJB36TMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352823C51D
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154561; cv=none; b=F/TwVpYzq+pcxY9uaExx/rZeJOAEPBMNihXn6Ljmm52douHGafuehqIQHGPJKB8dmhVmpMSedCSkpAgs8qWEQ7ha+qSW4VdyqdmJFQ87KMSWt0fsK/5jC46UGgCH/oXC06IjVfaGQQ2PRv7peAhcpsUCeLRj6SLD6lnQ2ieGbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154561; c=relaxed/simple;
	bh=yNlx8B2q6AS0HUhxFGOdOrqrs+XeyF/GTSmEnedO8Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBl7dm/c7VQCMFRTzqsc/ScoMucZEFcKhUWmgrJuVyKumZRK6gk/gbKWRLDAAuHRoBuC86mwaGUGUzJKrw1jiLN8IjJaiYttG9e9ASu1d7MlxyJRvKtcpE/Cr8pYYiCh2lK3g6h6+2DFthnQoYEcBzs7a1Jg4PDnBWzVna80C8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJB36TMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02071C4CEE7;
	Wed, 22 Oct 2025 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761154561;
	bh=yNlx8B2q6AS0HUhxFGOdOrqrs+XeyF/GTSmEnedO8Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJB36TMRyVLlGuAZbIKc1Q3vha09gPZUGB7D/o9DPVLMnGmsQECJVBrAVoOXERkqf
	 GKXcsJlhRtaX3C7yUCQgu+JwzW5Yj54HPW1i9F1HCzR2Sb0WKo10YU7a1bAgq5USXV
	 qMZXnx5qF9AyKH9N+QPtcJRJBjtBoJLCre9C6XJFRWeOEQeFoGRfi2Ls4+Y03xu5EM
	 a5MtomUDJGvcO+HXD6jVOop/RAReqEAMg/lVZUKkAn52a+fpOKS49kFplqlkXDNflB
	 4DroqhIijsd37DgnhG56tp7hz8519qei/tgx2Q8hlM1n1hLrF5oZPVY/hO4p5bBALA
	 AB60pN7orsh9w==
Date: Wed, 22 Oct 2025 23:05:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
Message-ID: <oiqs7vjw3hxbrp3tnlgut5zh3547tgowsixip5cgagyuh3uv4e@n7wielcx6hmc>
References: <a3ky7mynu6p7noyx7d3frxhwsq7izlh6sgkbbnyg5txx3kufke@nvftvg4l5gzk>
 <20251022162229.GA1256220@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022162229.GA1256220@bhelgaas>

On Wed, Oct 22, 2025 at 11:22:29AM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 22, 2025 at 03:59:13PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Oct 22, 2025 at 06:13:59PM +0800, Shawn Lin wrote:
> > > 在 2025/10/22 星期三 18:02, Manivannan Sadhasivam 写道:
> > > > On Tue, Oct 21, 2025 at 03:48:24PM +0800, Shawn Lin wrote:
> > > > > of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
> > > > > is properly connected and could enable L1.1/L1.2 support.
> > > > > 
> > > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > > ---
> > > > >   drivers/pci/of.c  | 18 ++++++++++++++++++
> > > > >   drivers/pci/pci.h |  6 ++++++
> > > > >   2 files changed, 24 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > index 3579265f1198..52c6d365083b 100644
> > > > > --- a/drivers/pci/of.c
> > > > > +++ b/drivers/pci/of.c
> > > > > @@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
> > > > >   	return 0;
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> > > > > +
> > > > > +/**
> > > > > + * of_pci_clkreq_present() - Check if the "supports-clkreq" is present
> > > > 
> > > > I don't see a benefit of this API, tbh. The API name creates an
> > > > impression that the API will check for the presence of CLKREQ#
> > > > signal in DT, but it checks for the presence of the
> > > > 'supports-clkreq' property. Even though the presence of the
> > > > property implies that the CLKREQ# routing is available, I'd
> > > > prefer to check for the property explicitly instead of hiding it
> > > > inside this API.
> > > 
> > > It makes sense.
> > > 
> > > Will the name of_pci_supports_clkreq_present() look good? Or we
> > > just drop it and let host drivers to explicitly check
> > > supports-clkreq inside their code?
> > 
> > I'd prefer to drop the API.
> 
> An API might help with consistency across DT bindings.  We don't want
> drivers to pick their own names for 'supports-clkreq'.
> 

I don't know what you mean by 'drivers to pick their own names'. With or without
this API, the drivers have to use a local variable:

-	pcie->supports_clkreq =
-		of_property_read_bool(pcie->dev->of_node, "supports-clkreq");
+	pcie->supports_clkreq = of_pci_clkreq_present(pcie->dev->of_node);

What this API does is, just hiding the 'supports-clkreq' property, nothing more.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

