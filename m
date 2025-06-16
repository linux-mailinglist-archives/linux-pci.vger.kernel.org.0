Return-Path: <linux-pci+bounces-29862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FADAADB11B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73824170758
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C6292B5A;
	Mon, 16 Jun 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFQ3h8Gy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B98292B21;
	Mon, 16 Jun 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079199; cv=none; b=ABYeTOTBRY0uhnG+ykIAmxFgT269ztGvcmZwCKQQ9jwXb86aeYncrhMO5jbuEnXAxsrOW4tDhmkcs8f1OUn40GWiAlHmVX991hEfk//EW507rlZf8wxYq6hc0ZbxJ2Kn9CZ5xsbETWOj818hT1+UXRcIxuHC0QK6WGl6BptULXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079199; c=relaxed/simple;
	bh=NQ/uTaXQm+5pI/D0ALLCM1ErofRKvQ8nTZmQVPhdF/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhOxnVDdV7KDVmQ/M09FEUu5n1attFmTcFM3Wk9jA6qO0acQgyndBLIk4x5SKr4+v4j1BtTlJgFgUJjIKXdDULoPQwgKc41KLooalyOp5Oyrs6w90xUo0NBOywTHMVQRbi19rqdnmvYJIRe0vI2XYjMa9nhFn75lsLUPjiNJU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFQ3h8Gy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B7FC4CEEA;
	Mon, 16 Jun 2025 13:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750079198;
	bh=NQ/uTaXQm+5pI/D0ALLCM1ErofRKvQ8nTZmQVPhdF/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFQ3h8GykiNiFRZvbSuii7ZZZCed6JC8rk/l6wq69MksRM8/TPTd+/XCctwI6XCgF
	 gwXnyOw4AO1Oojn3rambPa/V9prktw8WZTNSUN1JwhQ8583tREQpE/SYcGR2gTz7j2
	 Mf/KX9bybmP3RMpcrB8kJ1J62otvJ3EpQenpknnh0nPukvKVkxOLyOwcW4nouUKgbG
	 9ov3o44QC0GjkJsPYkN0HlPorYyc2biM8wartNly45bVRa0Shl5cwV53gdftuNSzxk
	 /aMmxd0RSIOlvM5K0kjdQP/+hz82X8I3O+R2lqDweSO6FaHGwyqTuNFR9/yGUyjWL8
	 q9Lq495YJTFcw==
Date: Mon, 16 Jun 2025 18:36:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: brgl@bgdev.pl, kernel test robot <lkp@intel.com>, bhelgaas@google.com, 
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI/pwrctrl: Move pci_pwrctrl_create_device()
 definition to drivers/pci/pwrctrl/
Message-ID: <f7i6zdebo2cxwbf5bkjh3v6ibnlwhumdytakrziwb5gfcsalc6@464tcaykwd4u>
References: <20250616053209.13045-1-mani@kernel.org>
 <202506162013.go7YyNYL-lkp@intel.com>
 <ji3pexgvdkfho6mnby5jumkeaxdbzom574kbiyfy4dcqumtgz2@h4nmwjvox7nl>
 <aFATcxj0ulo1RKxU@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFATcxj0ulo1RKxU@wunner.de>

On Mon, Jun 16, 2025 at 02:52:03PM +0200, Lukas Wunner wrote:
> On Mon, Jun 16, 2025 at 06:07:48PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 16, 2025 at 08:21:20PM +0800, kernel test robot wrote:
> > >    ld: drivers/pci/probe.o: in function `pci_scan_single_device':
> > > >> probe.c:(.text+0x2400): undefined reference to `pci_pwrctrl_create_device'
> > 
> > Hmm, so we cannot have a built-in driver depend on a module...
> 
> Does it work if you export pci_pwrctrl_create_device()?
> 

No it doesn't. And that's expected since the export is usually *for* the
modules and not the other way around.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

