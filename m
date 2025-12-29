Return-Path: <linux-pci+bounces-43806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DC4CE72CB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 16:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27FB8300A9D0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B8E30FF36;
	Mon, 29 Dec 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwETxTuy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D681E8826;
	Mon, 29 Dec 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767021114; cv=none; b=eHV0uY/xwjlQ92ZFsomNe0FdXxM+Z0llSGiPIu2+PLvVmOCfdLAkRIzQKAtjPPGMBL+nd6GVsr0Ixb8AXXMIrnKxNVmBbAbEU/cTrHFzYo1Ctuvd6VDUJYR4POrjRAqY4atL+WJsQVld9+vev41KZNCyWY8KksLrR+C96UV5fSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767021114; c=relaxed/simple;
	bh=U3RerkmBMhFujmcWE0DQfbj1pFbuSaRAlrOlKqHv8VI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tgjt7PKrbcu1+m2tuELM0tweciGkS4sSWl7gosehMeld4ySqk+Wuc5gNnxdjApTACALDmwRB1IwycHTFEbwBOgIHH5JDq1PA2b2XYutds+bUcDmM70xQfN0VQc8BdXclOMb8oJnegD8NVp4UUD7RXOwhBog7Ub74WjSFqE/G/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwETxTuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E0AC4CEF7;
	Mon, 29 Dec 2025 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767021114;
	bh=U3RerkmBMhFujmcWE0DQfbj1pFbuSaRAlrOlKqHv8VI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MwETxTuypcfy5ogpON6HHzYKwBPYNReAh64fmRplQdRqq64JX1gIkB5ViwJKqR7xP
	 OPElE0Ep629Axs03eiPiPeyFxBqCMkZPmcV0EZv7oyBRlF1mgStUcxZiOb+KkFGv3H
	 hCRHn2bmqZt+h8TItazyAkNezun3yF0sa+W2m8hSVUuIHnKztAJUOIkIyfXZrDzayF
	 NXVwrKKt+ZBarvbYOm5mSEXuHj2In551PX7TkuR8bSgY0d30TEOrBs6dlR0s2GgjqE
	 AeQog2UhNOCOv9KQxb0H6liIVTJiB1hGa+DqOddlrCkRp4K5MLKioZjDtiwAAi1Hwu
	 7Oh+6nV28LmnQ==
Date: Mon, 29 Dec 2025 09:11:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Han Gao <rabenda.cn@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042/2044 PCIe
 Root Ports
Message-ID: <20251229151152.GA57954@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA5PR01MB1250074A97978ACB5C88D1363FEBFA@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>

On Mon, Dec 29, 2025 at 08:17:40AM +0800, Chen Wang wrote:
> On 12/27/2025 12:30 AM, Bjorn Helgaas wrote:
> > On Thu, Dec 25, 2025 at 06:05:27PM +0800, Inochi Amaoto wrote:
> > > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> > > states for devicetree platforms") force enable ASPM on all device tree
> > > platform, the SG2042/SG2044 PCIe Root Ports breaks as it advertises L0s
> > > and L1 capabilities without supporting it.
> > > 
> > > Override the L0s and L1 Support advertised in Link Capabilities by the
> > > SG2042/SG2044 Root Ports so we don't try to enable those states.
> > > 
> > > Inochi Amaoto (2):
> > >    PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe [1f1c:2042] Root Ports
> > >    PCI/ASPM: Avoid L0s and L1 on Sophgo 2044 PCIe [1f1c:2044] Root Ports
> > > 
> > >   drivers/pci/quirks.c    | 2 ++
> > >   include/linux/pci_ids.h | 2 ++
> > >   2 files changed, 4 insertions(+)
> ...

> > 2) Why don't we have a MAINTAINERS entry for this driver?  I failed to
> > notice that the series we applied
> > (https://lore.kernel.org/all/cover.1757643388.git.unicorn_wang@outlook.com/)
> > does not include a maintainer.  Chen, since you posted that series,
> > are you willing to sign up to maintain it?
>
> Sorry, I didn't realize I needed to submit maintainer information
> separately for each driver when I submitted the PCIe driver code.
> 
> Yes, I will be maintaining the SG2042 PCIe driver. Do I need to add
> an entry to the MAINTAINERS file?

Yes, please.

  $ ./scripts/get_maintainer.pl drivers/pci/controller/cadence/pcie-sg2042.c
  Lorenzo Pieralisi <lpieralisi@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
  "Krzysztof Wilczyński" <kwilczynski@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
  Manivannan Sadhasivam <mani@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS,commit_signer:2/2=100%)
  ...
  Chen Wang <unicorn_wang@outlook.com> (commit_signer:2/2=100%,authored:1/2=50%,added_lines:134/134=100%)

This does list you, but only as a commit signer.  It should list you
as a maintainer of the driver so people know to send patches to you
(and cc linux-pci, of course).

Bjorn

