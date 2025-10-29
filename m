Return-Path: <linux-pci+bounces-39696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA1C1C917
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2353585008
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECAC34CFAF;
	Wed, 29 Oct 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWuHWZJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68EB3112B7;
	Wed, 29 Oct 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758756; cv=none; b=qLJzXNSVm7tsSdyKAMJjGxjQFKF+TlGRt56wiFmefa8YsO1a+NN02kBOlKUxs3CFrn7IHUUu+Qq7ukMcLlCVMiu05CQmRsOVtWPf3QjgP9GLNCroKk5UEgtA8v3QGS7lYt8tS1XXqoelvr+g18krpDnyLmGDv8ZFM9Qwwf8wzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758756; c=relaxed/simple;
	bh=UNCv/SLEKVdIM0/F5Qh+o3LkOisYzz/k4Ngw7LOuDtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p0lugZHE2BIj377K/CMISoCk59TqCapBwoxAI1ezwql2M6k7brcMu6U885L74Xmx4HBZvuPkKtSziO3mIJp9LgNWf8V2vNEzeOPxuzuMycx8Ll7y17Lfl1/npkCbuLRbspg2bRiEa4L0cjqAG1GRVJA2jM8avcKC+lnaruCRw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWuHWZJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4A8C4CEF7;
	Wed, 29 Oct 2025 17:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761758756;
	bh=UNCv/SLEKVdIM0/F5Qh+o3LkOisYzz/k4Ngw7LOuDtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PWuHWZJ+oT416PmcdJeCl9fvjHCkJFvtKNX1frItmY4dqgCUDhAjz0oSZ9qODt2ef
	 Io0O15PkPD/uyhqnbe/y9MiXW+KucYH9xYGU25wyKLDab0A3ELRwYUAHplXUIumVdO
	 rg60yYQWUd/mefNR48m2K6ssxnsTARoDO0CREaMYhAARUKqxOwe1UMO0QEws9iAxai
	 4VXTheLLFK1WBzjkyTWZiYk4EVK/ZqrBXYe63qdVM/xS0geger8Twg0mQvBB1ZwZKS
	 dFAY9v4BQ9fbHFwx9W76Wrc0ho0S+1pglHvzoKxq8/sE+EVHKfhHGHBcgXvgxLqnGX
	 STD/Opd53ruzQ==
Date: Wed, 29 Oct 2025 12:25:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Johan Hovold <johan@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Naoki FUKAUMI <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Dragan Simic <dsimic@manjaro.org>, linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Frank Li <Frank.li@nxp.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	mad skateman <madskateman@gmail.com>, hypexed@yahoo.com.au,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <20251029172554.GA1571455@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6280EFB-08D7-41EC-BAC6-FD7793A98A16@xenosoft.de>

On Wed, Oct 29, 2025 at 06:47:19AM +0100, Christian Zigotzky wrote:
> > On 29 October 2025 at 00:33 am, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > ﻿On Mon, Oct 27, 2025 at 06:12:24PM +0100, Christian Zigotzky wrote:
> >> Hi All,
> >> 
> >> I activated CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT again for the RC3 of
> >> kernel 6.18. Unfortunately my AMD Radeon HD6870 doesn't work with the latest
> >> patches.
> >> 
> >> But that doesn't matter because we disable the above kernel options by
> >> default. We don't need power management for PCI Express because of boot
> >> issues and performance issues.
> > 
> > If you have a chance, could you try the patch below on top of
> > v6.18-rc3 with CONFIG_PCIEASPM=y?
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..2b6d4e0958aa 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >  * disable both L0s and L1 for now to be safe.
> >  */
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
> > 
> > /*
> >  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> 
> Thanks for the patch. 
> 
> I will test it on my FSL Cyrus+ board over the weekend.
> BTW, I also tested my PASemi Nemo board with the RC3 of kernel 6.18
> and with power management for PCI Express enabled. Unfortunately,
> the installed AMD Radeon HD5870 does not work with power management
> for PCI Express enabled either.

Oops, I made that fixup run too late.  Instead of the patch above, can
you test the one below?

You'll likely see something like this, which is a little misleading
because even though we claim "default L1" for 01:00.0 (or whatever
your Radeon is), the fact that L0s and L1 are disabled at the other
end of the link (00:00.0) should prevent us from actually enabling it:

  pci 0000:00:00.0: Disabling ASPM L0s/L1
  pci 0000:01:00.0: ASPM: default states L1

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..27777ded9a2c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  * disable both L0s and L1 for now to be safe.
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain

