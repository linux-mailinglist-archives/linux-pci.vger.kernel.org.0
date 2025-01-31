Return-Path: <linux-pci+bounces-20611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E0A24422
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 21:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9304166C3D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 20:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEBF1B87E9;
	Fri, 31 Jan 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5+q8yTY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51399158862;
	Fri, 31 Jan 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355660; cv=none; b=ii2MbR/zGqK6ID3Qn3XVO+V1eAMD9aBrQT7NlTdqggx0BkrReAtdDUtk5CnQWaon8bKz7BvmCYMbGZjej7rqAE9cclMtzD0i4Zuf8mwGOxzAkC1eb+A4RAQVkTy0W0bGfkqYT/7KgSKLXTYwBTA91qyANzgQh68MQFVzjYHiniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355660; c=relaxed/simple;
	bh=5915g4GltMCspmdoLxw5SvDnTyhW/302DC11aNuOhfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mgm20lIG8VetTm+QpbWNnNs00bhhttZ1302hch4Fp3BMRXe8cJm56bh3dMbPWLQjJOaqSNYt7lXEhEEbqgqEQnIDsHfTg8VG/Zzfnf0OIhUE6Hxc3yEE5ojmvFp/7CetiKEAwHRIBJxilj+FzPQ/QR3wtJKDs9bumY3+9nBqQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5+q8yTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A3EC4CED1;
	Fri, 31 Jan 2025 20:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738355659;
	bh=5915g4GltMCspmdoLxw5SvDnTyhW/302DC11aNuOhfo=;
	h=Date:From:To:Cc:Subject:From;
	b=H5+q8yTYv/yYFi3VaoTiMTmtoAUt6H+4e1tKOl5lMG7dkFlPnj149p9OV1WMUDnJD
	 uOW5SK58wZK8mM7VNUakDAemkikw3/Ci03Nj7hvXBUGdMuBfZMype0gBNrMr/O3vUf
	 gV8AZcInZwgkxPQHhrFwYKY3iUyAlLJmEuJEW/7oDVOjNFJD6OPFGcQgAJVKo8WBF5
	 xP4Z7i1L3afdwU7X0X9536ZP63NQSai0CwhMLzMar3/myviRMQd0v38QY/lmHLcHtD
	 3q3hLRzd7zp3VtgFTFwusDIREbwoWZt1I8EOKxI/kzmk3/iNxfae1qVUDGROMTIA3l
	 Z5zpI3bi3wE0w==
Date: Fri, 31 Jan 2025 14:34:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Takashi Iwai <tiwai@suse.de>, Philipp Stanner <pstanner@redhat.com>
Subject: [GIT PULL] PCI changes for v6.14
Message-ID: <20250131203417.GA697126@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 647d69605c70368d54fc012fce8a43e8e5955b04:

  Merge tag 'pci-v6.14-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2025-01-25 16:03:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.14-fixes-1

for you to fetch changes up to d555ed45a5a10a813528c7685f432369d536ae3d:

  PCI: Restore original INTX_DISABLE bit by pcim_intx() (2025-01-27 12:55:12 -0600)

----------------------------------------------------------------
- Save the original INTX_DISABLE bit at the first pcim_intx() call and
  restore that at devres cleanup instead of restoring the opposite of the
  most recent enable/disable pcim_intx() argument, which was wrong when a
  driver called pcim_intx() multiple times or with the already enabled
  state (Takashi Iwai)

----------------------------------------------------------------
Takashi Iwai (1):
      PCI: Restore original INTX_DISABLE bit by pcim_intx()

 drivers/pci/devres.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

