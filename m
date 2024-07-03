Return-Path: <linux-pci+bounces-9761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD339269B5
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 22:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC901F21F7A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A701862B3;
	Wed,  3 Jul 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE8g+G66"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1817BA9;
	Wed,  3 Jul 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039674; cv=none; b=h6VVYnEXHGP7LkJcPAFhBk+9/nEKIHlPDlaSuj23f+e8ACWbEtp9kvE3LnZSUmX8RRL1BrpO9OUPGhrLNPJAU9ymSjaS+PgtZwLwlaabzZLPJgysiJhT+X82NHPzQZwMp2ciVdwA9ryDw4cDXFXHbjy3gtaFo/BuJFjI4uW16Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039674; c=relaxed/simple;
	bh=Jd/tImvsQRd4eOrB2nymxgGFq2kqlbVzG8bqRF/WKfg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aU4+td+j54qqIDJnopoaUfCXZI8qIR5kQastrhByh25+nsKpzKNsOKidr8aZA1w2zD3w4QyStjKmvlGS/Y2yQIQqC4qL84ymVcGw2dcnri5i4lAcpUHULRFQSnxKRAimJzHoAzVHOYIR1i7pTVsY0AU2aUq4Zb/8eZiSFTvpVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE8g+G66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9558EC2BD10;
	Wed,  3 Jul 2024 20:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720039673;
	bh=Jd/tImvsQRd4eOrB2nymxgGFq2kqlbVzG8bqRF/WKfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rE8g+G66RHM0lywX9/LI7kc2Pjf8sJ9xky2WruTaR03dHLvCZgW3Mi7bLolnb/tD1
	 AGrpcI59/KODxBkboZ19Kj8abh/urO8jThUds7fy/G6dsaGs8DGA3mRE+phxJx0lGZ
	 QkSE+htihVGmgnU5S8Irt/iaY7QBSpokMNzysrBFGHK8E3BAJlAAZLbtA6ExnnCdCB
	 2cGlkYNgXT1wEl/3t5jhuX4HCaNTIknE8q2vYzi3DcQiYEKCzZ4lp292ag6UKpAqRX
	 gciYdqMaYKy4vwa+2w01+RRaD8a1POKCHLDJEMkpAMtAicNzPNHmVn4sGHati19PhS
	 uhbOXfhDdtkcA==
Date: Wed, 3 Jul 2024 15:47:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com,
	linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Message-ID: <20240703204751.GA63492@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVtwLI5nIRpS2al@lore-desk>

On Wed, Jul 03, 2024 at 05:26:56PM +0200, Lorenzo Bianconi wrote:
> > On Tue, Jul 02, 2024 at 11:12:21AM +0200, Lorenzo Bianconi wrote:
> > > > On Sat, Jun 29, 2024 at 03:51:54PM +0200, Lorenzo Bianconi wrote:
> > > > > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > > > > PCIe controller driver.
> > > > 
> > > > > +/* PCIe reset line delay in ms */
> > > > > +#define PCIE_RESET_TIME_MS		100
> > > > 
> > > > Is this something required by the PCIe base spec, or is it specific to
> > > > EN7581?  Either way it would be nice to have a citation to the spec
> > > > (revision and section number).  If it's generic to PCIe, it should be
> > > > in drivers/pci/pci.h so other drivers can use the same thing.
> > > 
> > > It is just the time needed by the EN7581 reset controller to
> > > complete the operation, it is not something PCIe generic (it is
> > > something just related to EN7581 SoC).  Do you think we should move
> > > it in EN7581 reset controller codebase?
> > 
> > I have no opinion about moving it.  But it sounds like maybe it should
> > have a less generic name so it doesn't look like a generic PCIe thing.
> > And also a spec citation would be helpful for future maintenance.
> 
> ack, naming is always hard :)
> I do not have any specific spec for it. It is in the vendor sdk and the Airoha
> folks confirmed just this time is needed to complete PCIe reset.

Even a note that this came from an SDK from a specific vendor might be
useful since it shows that it wasn't picked out of thin air and it
gives a hint of who to ask about it.

