Return-Path: <linux-pci+bounces-45068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFF3D33971
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 17:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F5D0303C616
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2D739A808;
	Fri, 16 Jan 2026 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKEgZxVI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69FD2222D0;
	Fri, 16 Jan 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582477; cv=none; b=CglDaVntOzRS/kozeI/kjbWxRtyHvDJFhN4bTQ+u7j2UgvC739W8OQDSDwPxBpGADu8Sut8+3DjeyUEHaGdUTn/p0q01l25YTXP2vdfCp8QqOJ+KYACX2sjZXe5TRoS9WwPUdnHJg3i6eT3f2gMjWEYbKiummBbm3/3NjY51ca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582477; c=relaxed/simple;
	bh=Pj4I8+xw/fR8pVYw0oPh4uEoEpxH62S9I1BCLXt3GcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G0ibFvoQoH8Ffyqr4NRB7YjmYOdWS9yM6jc3oTA6cJlp97pV7WuQE9un95njhe/X8/YpLSVVY8wlGeb9pK64T/xN272G0qX8S8q4F91dtQxqKZo3UBlAdiMIpqY+xwqOQMqlxu2HwMolbTDVg5VZNBNC3TNK7NxWsEIbAq6yUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKEgZxVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5830C16AAE;
	Fri, 16 Jan 2026 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768582477;
	bh=Pj4I8+xw/fR8pVYw0oPh4uEoEpxH62S9I1BCLXt3GcU=;
	h=Date:From:To:Cc:Subject:From;
	b=cKEgZxVIrs8qxZb/As6Uc/Y49ZlUuU0Dw8aGQpSD3qNjE3+UssXjCHI2B4xvMD7sL
	 qvv9D+DgClQ6wJD7QyG9/aNX6RnbDnMDuQrO3INCJ+c9szu+FbqTRZbTj5Idbc+bb6
	 kC6oe9t6ipAhljiBR5KJsLMiFWFh7oMzSt2xMhQs5FwdY/8w7N3QODjiXBiYK+Ilaf
	 TSR+zMoPVRSficiPqwyB0ddK3Jwsq3mRaLjrSiRNSrNoaoohxQgSTBSaUCcUHQ31c5
	 aIF2WbiuSTwnlezfo3zQZazHwHl4ooPzwAucPSqq4Ct4rDIvh0wbsTA55JAcIBHbBv
	 D8sK7bCb6YoZg==
Date: Fri, 16 Jan 2026 10:54:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Liang Jie <liangjie@lixiang.com>, Drew Fustini <fustini@kernel.org>,
	David Gow <davidgow@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.19
Message-ID: <20260116165435.GA928390@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.19-fixes-3

for you to fetch changes up to 05f66cf5e7a5fc7c7227541f8a4a476037999916:

  PCI: Provide pci_free_irq_vectors() stub (2026-01-12 10:45:31 -0600)

----------------------------------------------------------------

- Add a pci_free_irq_vectors() stub to fix a build issue when CONFIG_PCI is
  not set (Boqun Feng)

----------------------------------------------------------------
Boqun Feng (1):
      PCI: Provide pci_free_irq_vectors() stub

 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

