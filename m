Return-Path: <linux-pci+bounces-3262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA8784EB4D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 23:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483EA281C3F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451624B5CA;
	Thu,  8 Feb 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT+8tKSB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6AE50254;
	Thu,  8 Feb 2024 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430152; cv=none; b=LpJH1oDH1zlkW1Y2YNSoWulFWkXL6I0wOOyGtmyzBf3dLvjN6huYWkmPNT/6lyEyD6FlM++8o3+9Fxc1Y1ovKx8aG1BbD82eVSkvwz7LhUVktW3+LvfOyo1CfE65VHfCs5JOmslSF56ccYci5s77jbHZQN3eCkvuwST+BgelW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430152; c=relaxed/simple;
	bh=zCTdDIPjuasHpxRE5ZrlrLvYc6g4okK5pNPNcQLFAzk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DcEWCr678xv6nYe38KzqZTr1csdsrq0H0j8BKejKqd6sBJRdbh/YaJS7qPJQEEKRJtqlEsDxnLR1Q/C5cJLaOskLoiIRkVWX12lrlqCU2gA4HbHkEtLBIlvl5xOn31WdoPw0sCqzT+ElHs0I0Ko562C4b5gfSNAAAvufJ6fJyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT+8tKSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64736C433F1;
	Thu,  8 Feb 2024 22:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707430151;
	bh=zCTdDIPjuasHpxRE5ZrlrLvYc6g4okK5pNPNcQLFAzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mT+8tKSBg8wEHst4eh5rqoZerbYW911kDFB100NX0quIf+L2OTudcJdj13bov/BYD
	 15mVAszuHlw5873PPuRtsIjsr8syMJn3vd6xfSBpyCpWA2nTiR9IctGMZ8ZSq3SEKy
	 g6Amgg1GcaHAvt/NHA9znoqeTMoS1GzyOu7inTs3wAe+lnXXh1ygshiyUzs/MN+sm0
	 ZJkf8kIzydsmLII4i4ugEI5areu4fFtp5IOIITSun/3p4mm7ZiS6D9fGxM6EOzA+Rb
	 M6wKtLGu5EBwozo/7LByzWpEIrpn0NOPcJwA4MTlvnhB4eJuOkq6kV1KL0D+7OWvm7
	 36N9Lmqv4xiZA==
Date: Thu, 8 Feb 2024 16:09:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Wu Hao <hao.wu@intel.com>,
	Yilun Xu <yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 1/5] PCI/CMA: Prepare to interoperate with TSM
 authentication
Message-ID: <20240208220909.GA975234@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170660663177.224441.2104783746551322918.stgit@dwillia2-xfh.jf.intel.com>

On Tue, Jan 30, 2024 at 01:23:51AM -0800, Dan Williams wrote:
> A TSM (TEE Security Manager) is a platform agent that facilitates TEE
> I/O (device assignment for confidential VMs). It uses PCI CMA, IDE, and
> TDISP to authenticate, encrypt/integrity-protect the link, and bind
> device-virtual-functions capable of accessing private memory to
> confidential VMs (TVMs).
> 
> Unlike native PCI CMA many of the details of establishing a connection
> between a device (DSM) and the TSM are abstracted through platform APIs.
> I.e. in the native case Linux picks the keys and validates the
> certificates, in the TSM case Linux just sees a "success" from invoking
> a "connect" API with the TSM.
> 
> SPDM only allows for one session-owner per transport (DOE), so the
> expectation is that authentication will only ever be in the "native"
> established case, or the "tsm" established case.

Holy cow, this is tasty nested acronym soup.  TEE, CMA, IDE, TDISP,
TVM, DSM, SPDM, DOE?  I know these will all become common knowledge in
a few years, but this is a big mouthful right now.  Is there any
overview or glossary in Documentation/ or similar?

Bjorn

