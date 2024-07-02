Return-Path: <linux-pci+bounces-9596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A744D9243A6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639FD281F30
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 16:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FEA1BC094;
	Tue,  2 Jul 2024 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC26Fg4G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353414293;
	Tue,  2 Jul 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719938083; cv=none; b=JQVut5UyDNtrrUEIoAz17oAy1vkahCmG24KQtzy/JdwUb/3p7oXTeTTd/O5cizPfaKjyiDPfMoGnh94RPlvLyyfpp0dRqyYO+woamrMQVc2MlcqvhC6zpuvYPNJPnjBWtqxZkTvuRuZSUV/jbUEM769TRdb+Z/uxlURdSQO+WZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719938083; c=relaxed/simple;
	bh=khiZR101rp5P36Em7z0sEdIWe+tz1ChCcX6aGVTw7R8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OYcxkMeG/wO8Zj4nx0FgJDm4TcgA2t0DcoNRZEaQugi/wRh/FoL/YkRW32rS/6yoKdBWzGy1d5fa9iJ841esMDYaMKPgIKQphC6UByPWUImfqT7/osGzziwwsa8dQ1XirGh/erYJDhM/U63tqjW3uLOjCWTxjnvLymkf/kgxM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC26Fg4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A5DC116B1;
	Tue,  2 Jul 2024 16:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719938082;
	bh=khiZR101rp5P36Em7z0sEdIWe+tz1ChCcX6aGVTw7R8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FC26Fg4Gd9lQlTIDmJQO798iX3AYRLV1N3K+ubVnJUNOnyiMRgamzwaviQih2uMar
	 2eqA7yr6mEPkDQlTrC1gC4buih5/fNvkxdcsF8mVQRaLwMcmLjvggJx40ehgTvt8NZ
	 kAwOeVPjqvK1+IHsKBTYaAUhgI4Xn5zOR7OYBzwmbztl1AbshcIK5glMCU1Wrct7SN
	 z/cUg/GPjp46Y204PlCk7RdylWDvknYjyx0P9fQJbigEsEu1bz5e6oDHaPutmh3oFz
	 KsXv99kGH+I+pAb6t5BDEifiP1VJ6igQ/mQLOJMIYdtxRLPSAMcUIRQL8iyZ5mzF4+
	 3r20PudmQeWWQ==
Date: Tue, 2 Jul 2024 11:34:39 -0500
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
Message-ID: <20240702163439.GA24344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoPEdU0Eg-f-mbgC@lore-rh-laptop>

On Tue, Jul 02, 2024 at 11:12:21AM +0200, Lorenzo Bianconi wrote:
> > On Sat, Jun 29, 2024 at 03:51:54PM +0200, Lorenzo Bianconi wrote:
> > > Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
> > > PCIe controller driver.
> > 
> > > +/* PCIe reset line delay in ms */
> > > +#define PCIE_RESET_TIME_MS		100
> > 
> > Is this something required by the PCIe base spec, or is it specific to
> > EN7581?  Either way it would be nice to have a citation to the spec
> > (revision and section number).  If it's generic to PCIe, it should be
> > in drivers/pci/pci.h so other drivers can use the same thing.
> 
> It is just the time needed by the EN7581 reset controller to
> complete the operation, it is not something PCIe generic (it is
> something just related to EN7581 SoC).  Do you think we should move
> it in EN7581 reset controller codebase?

I have no opinion about moving it.  But it sounds like maybe it should
have a less generic name so it doesn't look like a generic PCIe thing.
And also a spec citation would be helpful for future maintenance.

