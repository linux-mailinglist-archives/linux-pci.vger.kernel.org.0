Return-Path: <linux-pci+bounces-39043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A99ABFD500
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24893B6F35
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455C2737E1;
	Wed, 22 Oct 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGGplLuD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2032C11DB
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150151; cv=none; b=OkwEfaUU5qGWU3AZh+KbXc4eLMZ427q39EfgVczY03Ihwh5xGLtbH6n4P1kZEdWmNBaFb+VIdet0u4j10V7TjdtseTGp3osR8+C9EQ1nYgeTDeqEK9gdY/5CyuQqs8sELrNy+GqCMlSmC9syWiTG+V0m5k1mO70xJ/TPldH1zms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150151; c=relaxed/simple;
	bh=a7qOX4vLoFXsF/KBfrnam9mJzdoRDBYaNwPXMz2uNuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mCZpOqRMThyZgUpkWWv0N7tqAjyyG8H21Fx0i4CWoctIgtL/77YQBLVbkcEkl0a2emvUACe9VQ10zkl/EXi8iiY4eg7CgL4jq5D1UNsjArsNLB3IrdJuvQzBkJYTdqFAkCzq3z3Lg/2wVXW8NHl88ooEkjC0488Hba3Ki6F8hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGGplLuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BFEC4CEE7;
	Wed, 22 Oct 2025 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761150150;
	bh=a7qOX4vLoFXsF/KBfrnam9mJzdoRDBYaNwPXMz2uNuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bGGplLuDFaHooPKYXkkLnO0fT658NLWhLbrVWp7iph5O9GbYMn+X6444lfkAHDx4w
	 xoF140XquMlg2io5MeFGghQsq82gDml4gRXLm7EhiDy2gCNxG48Fb2xjDMYRw+FmHT
	 tIcyYjn3iYqrpRZoOYfK39bCymRDVXEf2cxVnOEttZ6ogY/WMma2Ss6nDXWReyL0H5
	 29aTyUKGfr/5Sm3+jX/3QZk8AK4JNCe4AFHTrh5VYt7IY9jnaOepUsIT3b9N+3wO8F
	 5qMzktaacfqUpRh4+oZKNgmv4Bx9SqkIGiB07YVS4dSILgMF496cfNi0RFdIo1NZfM
	 Yq9b1uQZs2quw==
Date: Wed, 22 Oct 2025 11:22:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
Message-ID: <20251022162229.GA1256220@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3ky7mynu6p7noyx7d3frxhwsq7izlh6sgkbbnyg5txx3kufke@nvftvg4l5gzk>

On Wed, Oct 22, 2025 at 03:59:13PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 22, 2025 at 06:13:59PM +0800, Shawn Lin wrote:
> > 在 2025/10/22 星期三 18:02, Manivannan Sadhasivam 写道:
> > > On Tue, Oct 21, 2025 at 03:48:24PM +0800, Shawn Lin wrote:
> > > > of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
> > > > is properly connected and could enable L1.1/L1.2 support.
> > > > 
> > > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > > ---
> > > >   drivers/pci/of.c  | 18 ++++++++++++++++++
> > > >   drivers/pci/pci.h |  6 ++++++
> > > >   2 files changed, 24 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > index 3579265f1198..52c6d365083b 100644
> > > > --- a/drivers/pci/of.c
> > > > +++ b/drivers/pci/of.c
> > > > @@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
> > > >   	return 0;
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> > > > +
> > > > +/**
> > > > + * of_pci_clkreq_present() - Check if the "supports-clkreq" is present
> > > 
> > > I don't see a benefit of this API, tbh. The API name creates an
> > > impression that the API will check for the presence of CLKREQ#
> > > signal in DT, but it checks for the presence of the
> > > 'supports-clkreq' property. Even though the presence of the
> > > property implies that the CLKREQ# routing is available, I'd
> > > prefer to check for the property explicitly instead of hiding it
> > > inside this API.
> > 
> > It makes sense.
> > 
> > Will the name of_pci_supports_clkreq_present() look good? Or we
> > just drop it and let host drivers to explicitly check
> > supports-clkreq inside their code?
> 
> I'd prefer to drop the API.

An API might help with consistency across DT bindings.  We don't want
drivers to pick their own names for 'supports-clkreq'.

But the pci-bus-common schema already includes 'supports-clkreq', and
that's probably enough:
https://github.com/devicetree-org/dt-schema/blob/979fea8f3c18/dtschema/schemas/pci/pci-bus-common.yaml#L155

