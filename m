Return-Path: <linux-pci+bounces-24958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E36A74D7C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9593BAAA0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E31C9EAA;
	Fri, 28 Mar 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU1uKX31"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401F1C860C;
	Fri, 28 Mar 2025 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174825; cv=none; b=CwJWJiH5Lx1kAE0yU9AER2nH3e1loV9E8FBid/UFOmK3H1wAJCX6Mh4agr5NHqJEVuTxzPPvJc26TfJPi6UJOHGL2maheGOkhk7ecK/qOOHGlKpObH04rlCrHgZJ5zm3XmIOCb6L9IazwzjH9rhlKZZUKna+p2WHwopzaEebLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174825; c=relaxed/simple;
	bh=Dtnjl7os46EKSTPdEv2lx+mACntQjIU6u4CtZiCQQME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UVcZiOyIwKOt4pG4roMe4zp8zn7fAdRrwylTt6bNcnb3n/h+ZfG+mc+I0lOPBYpS40CRy6NxXtBPV8lkn8hucA5nmSvadmJ7AJR3Dm9T/URMHr+jvSNeNIvwszvdhP8RkMiPI0Mu5hpQK8XYYC3dEhQLlXYXFRVTq3GuhXLlzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU1uKX31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBCBC4CEE4;
	Fri, 28 Mar 2025 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743174824;
	bh=Dtnjl7os46EKSTPdEv2lx+mACntQjIU6u4CtZiCQQME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KU1uKX31NIaglimesxqTFb0KuT4jfPg992rwxEwDDBRmZo4e+KcWh7jK3uM6wRR0O
	 XivE8gGp99t/FKqhRCGrTvMNsGS36IXO6G35woETJXQ6FLPnjuSmri5dVj15LxPF6U
	 3RkABxexXyg2Px6CkfnzwVf26HKwK7gZG1IHwv1nC8FAjSPYGPf3lkGwDpLLy0vo7W
	 wtw7BQyiXoAZej8iX30/hKYam2qPSM0+im66TREcruDoWcrEfgqYIbc8PyJB7J59qO
	 7M84zHKKHia5fYP/gf+79wS1rdLaN7pWVRXRDnWxiscYqkTwHZXmdwkdwXuqp+l354
	 lljSM9ycVccIQ==
Date: Fri, 28 Mar 2025 10:13:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ath11k@lists.infradead.org, ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot
 module
Message-ID: <20250328151343.GA1505019@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328143646.27678-2-johan+linaro@kernel.org>

On Fri, Mar 28, 2025 at 03:36:43PM +0100, Johan Hovold wrote:
> Commits b88cbaaa6fa1 ("PCI/pwrctrl: Rename pwrctl files to pwrctrl") and
> 3f925cd62874 ("PCI/pwrctrl: Rename pwrctrl functions and structures")
> renamed the "pwrctl" framework to "pwrctrl" for consistency reasons.
> 
> Rename also the Kconfig symbols so that they reflect the new name while
> adding entries for the deprecated ones. The old symbols can be removed
> once everything that depends on them has been updated.

I considered changing the Kconfig symbols at the time, but didn't do
it because I didn't want to break existing .config files.  Is that not
a concern?  Or do you think the long-term benefit is worth having
users re-answer these config questions?

We have lots of Kconfig symbols that are not what we would choose
today, e.g., my misguided suggestion years ago to use "CONFIG_PCI_*"
instead of "CONFIG_PCIE_*" for PCIe controller drivers that didn't
have any PCIe content.

If we do want this, I would think we should squash all these so we
don't have breakage between this patch and the following ones.

Bjorn

