Return-Path: <linux-pci+bounces-41019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8649DC54817
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 21:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5C93B38DF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 20:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF872D7D47;
	Wed, 12 Nov 2025 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKMYKfcQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CBA2D7386;
	Wed, 12 Nov 2025 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980422; cv=none; b=CFzpR1gL4DeEivqZoPmpx5ygNUIPXQHj1mFrxkiPgVqfKZ7I+5fWcBEuUjeOBo4L+fxUFd5NTh2eIR/M2Yl44itKK3oR2ifVWskqHwJzfTG6RcpUL5CsaZXsYXzvbNoTCfj+cg/HiSZD3WkHtKI0nxkSDrkSy92+tNuOJznJ9nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980422; c=relaxed/simple;
	bh=lJDXcU4HmyqsCodwOYZlrF98db34gvUMj2RqmNG9p5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ttO3A45Nkjhkqop77+g8zwCWJF3DjkG3F8PGGZCqVrzVf0xUCewM5CVoMeYJXASwWUe9N39OsxPsUlbH/yJ2F+uPR0+fo813l3qhzN/tolyU4WwduYSPsEsGLsu/Os4mb2HucijDrELwsuzq+IIjnjkcYHwLdvytsddY6cVdMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKMYKfcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945E9C4CEF5;
	Wed, 12 Nov 2025 20:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762980419;
	bh=lJDXcU4HmyqsCodwOYZlrF98db34gvUMj2RqmNG9p5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dKMYKfcQlGxHL5i1//TBakdBTUaKDr8+kyK5mNZ04ErIRVeFBpq7rdCGhLYjB2IfQ
	 rJyc16fvGYnkrVawDsSf06LF6buucCuJkpA3KV5ZgpxpettYlwykHvmNyVBCmaSiW6
	 bt+Mm92ci37oJvf8ycARugxsFcHxnnNK/EEXtqXSxLv2v90zzLCBcc67+o9cgd/oro
	 U9glheJHz/iIimMEoR54E/Ph9oPL3HhUnd103YrVWqQquaeiip8kLQMEBn2LoXJDmI
	 URQZ+Pl9xzFOtv+MMrQxAMXTACJTh1B06qv7Uak2+lET4Qldkwsz944qrZUwCOxdc7
	 ZEnc1glDsuFbg==
Date: Wed, 12 Nov 2025 14:46:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	mad skateman <madskateman@gmail.com>,
	"R. T. Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/4] PCI/ASPM: Add pcie_aspm_remove_cap() to override
 advertised link states
Message-ID: <20251112204658.GA2242023@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xkrehb72sk7x5iyxbkvydu356hgo5t2xr3asnwiddvhtz5eqam@jlzd6gwg256n>

[-cc Roland]

On Wed, Nov 12, 2025 at 10:57:07PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 10, 2025 at 04:22:26PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Add pcie_aspm_remove_cap().  A quirk can use this to prevent use of ASPM
> > L0s or L1 link states, even if the device advertised support for them.

> > +void pcie_aspm_remove_cap(struct pci_dev *pdev, u32 lnkcap)
> > +{
> > +	if (lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)
> > +		pdev->aspm_l0s_support = 0;
> > +	if (lnkcap & PCI_EXP_LNKCAP_ASPM_L1)
> > +		pdev->aspm_l1_support = 0;
> > +
> > +	pci_info(pdev, "ASPM:%s%s removed from Link Capabilities to avoid device defect\n",
> > +		 lnkcap & PCI_EXP_LNKCAP_ASPM_L0S ? " L0s" : "",
> > +		 lnkcap & PCI_EXP_LNKCAP_ASPM_L1 ? " L1" : "");
> 
> I think this gives a false impression that the ASPM CAPs are being
> removed from the LnkCap register. This function is just removing it
> from the internal cache and the LnkCap register is left unchanged.

Very true, this is confusing since we're not actually changing the
LnkCap register, so lspci etc will still show these states as
supported.  The quirk needs to work for arbitrary devices, and there's
no generic way to change LnkCap, so the quirk can't do that.

Any ideas for better wording?  I don't like "disable" because that
suggests that we're clearing bits in LnkCtl.

"L0s L1 in Link Capabilities will be ignored ..."?

"ignoring Link Capabilities L0s L1 ..."?

"L0s L1 treated as unsupported ..."?

