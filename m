Return-Path: <linux-pci+bounces-27752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4B9AB72CA
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE80A3BDDA7
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F521B043A;
	Wed, 14 May 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekam3DZv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4550183CA6;
	Wed, 14 May 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243717; cv=none; b=XSlpPZgHSCo76XbM89SXyXWJpjqCzrHn02kujn0bWEFbQfDFiRH430Rjx5uqdYoTBbCMdggzznHWvNZHMTp6quP7g+i6NP+HEV151nnC02GWKaiNZq4okE5Wa/WGR+4VTmYz2gzqvNbL5jLtudERdsnq9wFuXMr6DtD6BfU8J7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243717; c=relaxed/simple;
	bh=6dUZjkhEHuLjj6ruUivwbJgvWYboOGCKXgAC9/qI6dQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3QvT/n/OKapmeKcfvP51GnKgUhnZYi4m6LChgTlYqPRd/C0At6Dl/HLiNBJZJWY8Gcnka4wDYU19yHWopOHZPoCTEpLxzAcIFDZdVedQtHmTDG5cMm+uxMmAwE23QNJtfr2DOapGrGocxJ2wnptq1MLZBwnPa1H5EY7lZHfpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekam3DZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395A9C4CEED;
	Wed, 14 May 2025 17:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243716;
	bh=6dUZjkhEHuLjj6ruUivwbJgvWYboOGCKXgAC9/qI6dQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ekam3DZvdH6CSvc8088cvk+deXmXEbGyK7oyVUNnyaZ7L1pTnhC8zDOZlfKrVOMIf
	 xwJQsGWLsTk+TOytBx0VDUuhGzxTYjZ6La49nNeTvmOM4pqeTHaPab3YuDenLR5HQ5
	 GkjIZI2cqRMiyIwPbfuqOdQJsWyQqWsc3Kbahzxw1RAm7xnPZAEtnSx0ol4bKxsIRW
	 KdYWrJGefhnSMN7EPuSn8+7vRIdoHRYjVg+Vss6yPrAmc+juDw2TF18Qn/l/9r6Jh4
	 GBPc2FAI35GSwheOpUPof8HqiMUpLoY5thOamlOQ9pHjNBvYsO4MStY221eKWG6oTb
	 Tt3gFjginmD5g==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Date: Wed, 14 May 2025 17:28:33 +0000
Message-ID: <174724335628.23991.985637450230528945.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello,

> The commit 0238f352a63a ("PCI/bwctrl: Replace lbms_count with
> PCI_LINK_LBMS_SEEN flag") remove all code related to
> pcie_bwctrl_lbms_rwsem but forgot to remove the rwsem itself.
> Remove it and the associated info from the comment now.
> 
> 

Applied to bwctrl, thank you!

[1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
      https://git.kernel.org/pci/pci/c/256ab8a30905

	Krzysztof

