Return-Path: <linux-pci+bounces-3043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1075847ABB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5011F246D9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB17C09F;
	Fri,  2 Feb 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+iEuzMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9027E111;
	Fri,  2 Feb 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907081; cv=none; b=LSRGAwO5/hS6V/ZS8TsUr+yEXzGs5y6lI6EbQ3y34dE7mzYGns5nGX6LxcJKV2iajBRPU7JSUBJRO2ck1v2yTRsngveJ5+ExALOOEhzgWVggTFZZ0Vx+O5QUoQkt5kNGSoIvG5sj/MC9NfeI731pQZcK1uqu7PmW6ILzjbc1abM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907081; c=relaxed/simple;
	bh=FaAgbg7RvrOWppB8K5AXgEJTeKBDcx4AJrabI7Nkxo8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R2aL7ohuC9kRAKlqWQ5u0rWWMam8HDxLS3ocp1LFX6ggk90WcUzYzdk0SzIKlz0xS0mEH8IHH3RsAdqmb3E2TfDg8KV+tyjcgTF1+RdO1OCxfbwt4nxp4hsYItC5cdHhcQpPz/+U7Ml6RdYwnPrBA8MFMPL4zw2Tw6WkUhETfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+iEuzMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3050DC433C7;
	Fri,  2 Feb 2024 20:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907080;
	bh=FaAgbg7RvrOWppB8K5AXgEJTeKBDcx4AJrabI7Nkxo8=;
	h=Date:From:To:Cc:Subject:From;
	b=Z+iEuzMA7qAiyG7R9up6o3GCDI0JpIKjibN1Ne5pOqV9SuqD5cqZIi44jAsqhFu3r
	 YfypQK8MmR+qTLvttYe9wqe9iTTwPDkMXk43RskvhJXIgc0g4Vp+isv4iMFbf2LON2
	 QndsdHxnqxqp7QNH7UXIYnR9Zpa57TpFhddLQD1HoV4cT1x0uwkIu2kjoP2PmNg3uF
	 RLnnWFOcvM+tB7HES6gV+ioKLIB3vAJb7JUfldVnZrweV/HNmEX28aKMfhtRvXu4BH
	 kC4O+PZ4iqSVZFYb4jA5el+SoshhDT3dlojC2cfqonN8GondZyLVtk7jtyky7YlCp+
	 y6bSagdNwaScw==
Date: Fri, 2 Feb 2024 14:51:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.8
Message-ID: <20240202205118.GA690750@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-1

for you to fetch changes up to 925bd5e08106bd5bfbd1cb8e124c89a0b4003569:

  MAINTAINERS: Add Manivannan Sadhasivam as PCI Endpoint maintainer (2024-01-31 09:04:10 -0600)

----------------------------------------------------------------
- Fix a potential deadlock that was reintroduced by an ASPM revert
  merged for v6.8 (Johan Hovold)

- Add Manivannan Sadhasivam as PCI Endpoint maintainer (Lorenzo Pieralisi)

----------------------------------------------------------------
Johan Hovold (1):
      PCI/ASPM: Fix deadlock when enabling ASPM

Lorenzo Pieralisi (1):
      MAINTAINERS: Add Manivannan Sadhasivam as PCI Endpoint maintainer

 MAINTAINERS                            |  3 +-
 drivers/pci/bus.c                      | 49 +++++++++++++--------
 drivers/pci/controller/dwc/pcie-qcom.c |  2 +-
 drivers/pci/pci.c                      | 78 ++++++++++++++++++++++------------
 drivers/pci/pci.h                      |  4 +-
 drivers/pci/pcie/aspm.c                | 13 ++++--
 include/linux/pci.h                    |  5 +++
 7 files changed, 102 insertions(+), 52 deletions(-)

