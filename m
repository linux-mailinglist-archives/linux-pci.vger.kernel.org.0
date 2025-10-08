Return-Path: <linux-pci+bounces-37742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B73BC6CAD
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F300F3AFD26
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C702C21C9;
	Wed,  8 Oct 2025 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak45r30B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5E1E25F9;
	Wed,  8 Oct 2025 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759962347; cv=none; b=trE2PcBVHOo+d4Bt0YFWj8NrXzqXEURdz9qalQjxy6ClZRv2Y9vnhYFOk0dRf5PD1Ji6Nn1oNdNFazHAt2PAXsreOLLmMvaN49lQEg0Hi9H6erd5vRRNyUjNNWXBkggYhsbjYnPxo5ZK84SIBsMprjl4wL4ZIcp/lY0uyq3BVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759962347; c=relaxed/simple;
	bh=R3RymRKSRgrt4lsHS6xcQus+09X389Ih5lK/rRUZ9W0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RqCWDVVs96fh73BuLzkdYrEj9fQs2+B5q4+x4xoVwMBpkKuNeAvvDCw64zCyKxcrfxDDAJYulUBZKhtOI6vF7Z8kMhOfbOp8oY6+MI5p4+GKLtL1NxFoADm/NOjtOudZNrjz9lobx2uN2d/wkjkaq2OFaQhlecwV6wiNM0LuWHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak45r30B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895B4C4CEF8;
	Wed,  8 Oct 2025 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759962346;
	bh=R3RymRKSRgrt4lsHS6xcQus+09X389Ih5lK/rRUZ9W0=;
	h=Date:From:To:Cc:Subject:From;
	b=ak45r30BlOmlIsN/o11aOkbT5gUJ7H0XRDW1Vo/ieQMFE8aFiGvOItmfXi0AfHRJ/
	 dPfYTdDbmUKV0eryJrSPBIVx0elBVUwMj4YNyvLVdaswA6eJZZKsEcQ+kkcc3nH5/h
	 Z43UhCNkV8hm0NjakN8h4NA8DKvxLDwt3RhuuRgDvzVxUeJmt5bSpfJrLsCTx2MlRs
	 yEP8kEUQkLjKDi+tD2BOn8AQQrm4NR0ywo/I1nysrXa8+vwliTSIKm3gVxINNxa7lV
	 +0StI1OI1x+IBpddf12DvUwiGXo0OL7eDZPVooVLQ5T5NF/cs0wEBPazdfdeEqVGLX
	 vcOshkV2WozMw==
Date: Wed, 8 Oct 2025 17:25:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	"Kenneth R. Crudup" <kenny@panix.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v6.18
Message-ID: <20251008222545.GA648136@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92:

  Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2025-10-06 10:41:03 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-1

for you to fetch changes up to a154f141604acacc0ec64a445d8058a045c308ef:

  PCI: Fix regression in pci_bus_distribute_available_resources() (2025-10-08 16:36:31 -0500)

----------------------------------------------------------------

- Fix a resource lookup regression that broke enumeration of hotplugged
  Thunderbolt devices on several platforms (Yangyu Chen)

----------------------------------------------------------------
Yangyu Chen (1):
      PCI: Fix regression in pci_bus_distribute_available_resources()

 drivers/pci/setup-bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

