Return-Path: <linux-pci+bounces-8473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2D900B6F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36511B23CC1
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4F219AD57;
	Fri,  7 Jun 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIwXHJ+D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CFE13793E;
	Fri,  7 Jun 2024 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782160; cv=none; b=sE023S2FISsk5VsKtLj3UJYLHSCXF6ImflSWz87JCuMOSd2zNGQSMKz3lghXmr3ERBdzYFJFosMf7jEf3dznJaM0bk89sOVvUafbzrf8tWMDLmMV4Rv+OgaGq7yncid+Djv2IpUbAj18WAG3mXtHNW5iBLrk4aB//LrrqfqcvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782160; c=relaxed/simple;
	bh=f/Gzsxd+eQ/cbzkdzNthU2SrdFC/gyNJ6J4i3UG2L8c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=euo85/VJyoICY6wRzu+qmDrWsh60tCBCmuJK51RNkt+t0ih+euBAw7yT6tMUk2UU6zT32VZCXzKjUdZScEyALI5cCN0h/svMMANAMG/zULOGAJIvLCXISedcJsjxTvZzXg0acbloUUGKqW74UR09lFyii/YJIHK2dzBGf9TRKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIwXHJ+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EB6C2BBFC;
	Fri,  7 Jun 2024 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782159;
	bh=f/Gzsxd+eQ/cbzkdzNthU2SrdFC/gyNJ6J4i3UG2L8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NIwXHJ+D/tS2Se2b0FvpeowBahmQ7+buX+CNSGzFME93XigN3t53gZcrhrJ6HJXKX
	 fpQ8DB1Kev7tkyc41aHutru1cMLho4nGn5PLmZyLcYfc0dT97sxs8jd1IRw7W2qc2Y
	 FW5VlBmxbtxgBogUJZ9paCnaI+hkmQQA7k66gZ0Lez01wOO7m7ogbDM/5vp4Ca5JBC
	 eyCL2D3KMhRFGJVv5hLM/CIM0f8gzU2CE/GlnuSlbR1RqfJgOwWSGDcptDJyXYsUjn
	 WOq0GlGtJeLxOXZgETfvFtmv4jLOp8cNGf5eULOgeJ2NGfgqd4eqhhCUSDt1wmZLPG
	 SQ114lhIXviFg==
Date: Fri, 7 Jun 2024 12:42:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH V2 4/9] PCI/TPH: Implement a command line option to force
 No ST Mode
Message-ID: <20240607174237.GA853301@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531213841.3246055-5-wei.huang2@amd.com>

On Fri, May 31, 2024 at 04:38:36PM -0500, Wei Huang wrote:
> When "No ST mode" is enabled, end-point devices can generate TPH headers
> but with all steering tags treated as zero. A steering tag of zero is
> interpreted as "using the default policy" by the root complex. This is
> essential to quantify the benefit of steering tags for some given
> workloads.

>  #ifdef CONFIG_PCIE_TPH
>  int pcie_tph_disable(struct pci_dev *dev);
> +int tph_set_dev_nostmode(struct pci_dev *dev);

Exported functions need a "pci" or "pcie_" prefix.  We haven't been
completely consistent on this; we have "pci_acs_*", which is obviously
PCIe-specific, but we do also have pcie_find_root_port() etc.

