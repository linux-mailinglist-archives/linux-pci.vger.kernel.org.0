Return-Path: <linux-pci+bounces-15347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323FB9B0BB2
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 19:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5181F29717
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 17:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18E618B499;
	Fri, 25 Oct 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbfmPqhF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17D18452E;
	Fri, 25 Oct 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877487; cv=none; b=mhQTBT78E9+y6S6AS8Tv6eydv0jnjwx/5j7vY/eCRxQ1QFMFhFiHEY3pCUsXc4z5/iW1z6DX5VN6fOQWD6hGRfFglIh0eILlqRN7uVE7Kk56nZCshAs91nxe4ooZZEhRwPihj5u1A0TtsyPEg++MK+PoL6D06EUdn23IzV19Szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877487; c=relaxed/simple;
	bh=DC/+LkoXq7nUuvZxjShmyyiKPIJ9gQiOieFvR+D/1w0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S1VUu6wNcttxZ7mppPLR6YMBfg9KSnOIkcgYn8t9vH4XNM/2A48Y3iaFzhmh8+hdrgIPwLdnmKrV2/U1SZcRRS94H+CXBt5vM8rU2Lp0Bd6cmVV0mBQ5jFPMXV+KkCX9X+YX1QTfCMIMd2pXOV4daTWgBJe4LC8SAnLCGhTRYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbfmPqhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2685C4CEC3;
	Fri, 25 Oct 2024 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729877487;
	bh=DC/+LkoXq7nUuvZxjShmyyiKPIJ9gQiOieFvR+D/1w0=;
	h=Date:From:To:Cc:Subject:From;
	b=TbfmPqhFth9hj9i9EtLVjXNaiu0adNpF9cVmT+6rdwOPjJarhayXFTZu4XANaetVV
	 Y4zIclfjK8xY18lSr+MdQdMLt2Cn27RMeGdpglsx4Eg7iWWZZrZAnw3vf/abeX5RiP
	 XPhfUYl5y4ycXy2R2qzLCxEPwa5KmCUo8kloAwKkCzQ9BqnjJc2h4ePCNm3Tl7NA0G
	 bUz/6B9nHbAxvY9qj27WQoxanJ8KCGTNG/kvH/sU16CPpW/jD7oBf697hhak/n9gxJ
	 cKbrDbCY4hwR7T7EYRnJpyIT80ehXCUlE6lxcckCa1K3o8adRfpoAuIphZ6XNd12/w
	 MS7FbdoLgdesw==
Date: Fri, 25 Oct 2024 12:31:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.12
Message-ID: <20241025173125.GA1026995@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.12-fixes-1

for you to fetch changes up to ad783b9f8e78572fff3b04b6caee7bea3821eea8:

  PCI/pwrctl: Abandon QCom WCN probe on pre-pwrseq device-trees (2024-10-23 13:34:41 -0500)

----------------------------------------------------------------
- Hold the rescan lock while adding devices to avoid race with concurrent
  pwrctl rescan that can lead to a crash (Bartosz Golaszewski)

- Avoid binding pwrctl driver to QCom WCN wifi if the DT lacks the
  necessary PMU regulator descriptions (Bartosz Golaszewski)

----------------------------------------------------------------
Bartosz Golaszewski (2):
      PCI: Hold rescan lock while adding devices during host probe
      PCI/pwrctl: Abandon QCom WCN probe on pre-pwrseq device-trees

 drivers/pci/probe.c                    |  2 ++
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 55 ++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 5 deletions(-)

