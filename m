Return-Path: <linux-pci+bounces-40338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5222C35178
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 11:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4C41892B9F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B130274A;
	Wed,  5 Nov 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVk2cw91"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545330217A;
	Wed,  5 Nov 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338492; cv=none; b=OjzDe8Neur2oDq5c5+e0m1hKIYkhcz7ea5MW9m9UxIvpqFS8k5tpPD/RCVw4kjyhccqaTEXo/Nv+tyI5xnLdJPGhBmDXN3Uzc7ILZoIdFJIhHOwOJBvB9Ck+aJfFTd4j3tkDAVcZpFCM7K0o7zKGETaddTsp1FxJepNXN16Epdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338492; c=relaxed/simple;
	bh=sATlqbfCMquHAhiGt98UAjhO81tc66fm/b5s3xZ+bT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzhM+9vu8FefAwsU0hEFpKvJ3iIcUcOR1YNdpG4i1A3XkF2ZJvBBZEs3QvBI3oVQUx7zcQ6xav8jOTNBq3i4xW3gn8dCl3SDmAD0wqOzSQMTM4i+8svGF93qJBdkp8+r7m8Vp23AG5lRH55hBgtwaubzGIvArN9PVT1GpQ+iodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVk2cw91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271F4C4CEF8;
	Wed,  5 Nov 2025 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762338491;
	bh=sATlqbfCMquHAhiGt98UAjhO81tc66fm/b5s3xZ+bT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVk2cw91xb3rYUDPFcGEtjuOOgvOL7LPdFKi9Ek3C8A3pJKShz5NSz1ygG7990U70
	 5MKPxs/CwWggCZ4NBUoVASSOYENYZskX4+KO9mC8L1RewpnSZj56X8WFBZDNFPpUfy
	 YCNph4JFxwP9Up1f+JrWSvK82fQiSY22vGOxTCP6iLTvLpbHlddw5Nn4D6qLqZDe18
	 A0Oj6TSleOyym73rw53E1sx7OYY8l/oHNN3z842GkfoKpnsiK0i2CxbV/gyf2DmldO
	 cFy/IYkMMWOVXppMcDDu5pu2Fn3ak95UF3m2BmecxYlu57lWhbPod+Xmu+3QfoThOH
	 18Og5nj9EJS4w==
Date: Wed, 5 Nov 2025 11:28:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	bhelgaas@google.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/4 v3] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <aQsmtKsTEmf7e7Sd@ryzen>
References: <20251022174309.1180931-4-vincent.guittot@linaro.org>
 <20251022190402.GA1262472@bhelgaas>
 <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCtHquxtK=Zx2WSNm15MmqeUXO8XXi8FkS4EpuP80PP7g@mail.gmail.com>

On Fri, Oct 24, 2025 at 08:50:46AM +0200, Vincent Guittot wrote:
> On Wed, 22 Oct 2025 at 21:04, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > +     dw_pcie_dbi_ro_wr_en(pci);
> > > +
> > > +     val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> > > +     val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
> > > +     dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> > > +
> > > +     /*
> > > +      * Set max payload supported, 256 bytes and
> > > +      * relaxed ordering.
> > > +      */
> > > +     val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
> > > +     val &= ~(PCI_EXP_DEVCTL_RELAX_EN |
> > > +              PCI_EXP_DEVCTL_PAYLOAD |
> > > +              PCI_EXP_DEVCTL_READRQ);
> > > +     val |= PCI_EXP_DEVCTL_RELAX_EN |
> > > +            PCI_EXP_DEVCTL_PAYLOAD_256B |
> > > +            PCI_EXP_DEVCTL_READRQ_256B;
> > > +     dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
> >
> > MPS and relaxed ordering should be configured by the PCI core.  Is
> > there some s32g-specific restriction about these?
> 
> I will check with the team why they did that

Most likely, the reason is that, the PCI core does not set the MPS to the
maximum supported MPS for the root port.

So without that change, the port will use use 128B instead of 256B.

I assume that you should be able to drop (at least the MPS part) if this
change gets accepted:
https://lore.kernel.org/linux-pci/20251104165125.174168-1-18255117159@163.com/


Kind regards,
Niklas

