Return-Path: <linux-pci+bounces-15816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90039B99A9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 21:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1033D1C21513
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 20:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82B71D5AA3;
	Fri,  1 Nov 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHcneHkE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E612168DA;
	Fri,  1 Nov 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494271; cv=none; b=pnPKOZd7PKDpm+U9HNTR6Wsq7ruvI8qsGcnb9CCxkdcN+2+/80/fqcLK5CvJ7QT6ssynMc42kffzdAojf1098nA6orhT4BC6a8YG21keAwZcGZkdnKmUd4UF2h/UDa2nl4WzpYWdVCC0KN/OZJmutFhSVgCIX/yro2ZvYM9bq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494271; c=relaxed/simple;
	bh=TvKepAswi9Hdn59MG5Gfa3pLNihGNOShTZ99K+cI+Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=im8pziFX+4cNTL1zJlhZS6OsPa3IjsJRGoxam3PhcGmhUMSG4JxeudYq3kJ8KerQ4alZXReRQrjio/CuGzSfzxpMSjGvi64fJmBIk/G7I/1C3hdioXDS9zTI4kN9Gpx62GiqnB05+Uhw91pk0Iis7EILniv8O0glM+wfzhgOl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHcneHkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F65C4CED1;
	Fri,  1 Nov 2024 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730494270;
	bh=TvKepAswi9Hdn59MG5Gfa3pLNihGNOShTZ99K+cI+Kc=;
	h=Date:From:To:Cc:Subject:From;
	b=cHcneHkEMlHGdS5uisEScGR573ACppM1dCtq98TO+p9EhcR5jjcj1pu0IPSSoZW+i
	 omV/pxhXFxvqlY5B2OmUjutzk1xmImNj2JFx3T8AEHyAKPmdWs7Kz+T6kWu0vSahOE
	 aDD2NoJghjG4l5H0gmBZYOxhLcySOQQBaLerJpQ8GIT8KXj+Mds0tt8rvcEhdwk6t0
	 4O7ZoR9RtpvernPBiBGSd+COPqdkXM0Z3Qbr1l5ZTyHS1JSCeQa2ADSXVhUgewZ0tN
	 ZO9HWFmFoOEVCKb0Nsgbm6ofUfQl/eKJDwBIzWKyZyii3KobrdJgJ67EmfsSzjfbTE
	 iuzgVXvPI410A==
Date: Fri, 1 Nov 2024 15:51:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Slaby <jirislaby@kernel.org>,
	Steffen Dirkwinkel <me@steffen.cc>
Subject: [GIT PULL] PCI fixes for v6.12
Message-ID: <20241101205109.GA1320603@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-fixes-2

for you to fetch changes up to f3c3ccc4fe49dbc560b01d16bebd1b116c46c2b4:

  PCI: Fix pci_enable_acs() support for the ACS quirks (2024-10-29 11:35:52 -0500)

----------------------------------------------------------------
- Enable device-specific ACS-like functionality even if the device doesn't
  advertise an ACS capability, which got broken when adding fancy ACS
  kernel parameter (Jason Gunthorpe)

----------------------------------------------------------------
Jason Gunthorpe (1):
      PCI: Fix pci_enable_acs() support for the ACS quirks

 drivers/pci/pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

