Return-Path: <linux-pci+bounces-37756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18EBC8564
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 11:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24B594F584F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2015B2D73B9;
	Thu,  9 Oct 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAPXlwHN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0E01862A;
	Thu,  9 Oct 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002655; cv=none; b=LOmNRtuEhxnIirLiLbSuSRAXmf1lzUNciIk9Ga5GdaaaL056YRHT0T69LS0oZziW6ipf1uE/4DTZYwNEIahEa3srWrNnX7fmm51/eynH/sRbPVGiWs7UKCup3bamOsXf7q2e5WDTTmuNWAK75WAvEc4rE1d6Qu1eo2ezk1eKvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002655; c=relaxed/simple;
	bh=N/gjUr2lVrXXogKsWG8xKu9GToDlKsb11WL0Ihzsn/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlq9+evFzcY7O2B7R2JOdFEee2ViWFY1C77pMIm1P6c5TVLWbKUz66kM4VsuECT6iQ6QfDsxAuhaNj6PL/cN4rk0EBgdMdnkooxpXelVBorF/ZegzQ+CZcZOSKbAMxGd1ZZPlBXfIIE3YBCz7FnBNZd4PlORHJRsAdWsNBz7+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAPXlwHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E6BC4CEF9;
	Thu,  9 Oct 2025 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760002654;
	bh=N/gjUr2lVrXXogKsWG8xKu9GToDlKsb11WL0Ihzsn/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAPXlwHNIc+YGAw4OVanXq08d8Dz9hup1PXb4aeDV2/PWbVbtAFbU9zxO7WrbY5vw
	 v1Imfvqf7dREwQXwIQEy0ucfw7NYTKBLYWymmKILAhsBkRbgMbRW9S5ArPqAAKPCAc
	 XTZNXjGGECSkfUMY+2vfQJKe8ikzYj9Wlqc0JHgsYL7SJYWACfpyR/hzYu3avjcgdt
	 PlZmJmUzPMLqQXjvm+3mMTHMbF98BVmlQtbDypnK8K+K+zU2DhFC3Y1yq7DCN+qy1r
	 nANv3kGDvWnyIZTkocQnja7E32BSTL4p7ooKbvH1wAj9cR2KdDoqsPx9uNaFascI6J
	 VP2iucvRgT5Hg==
Date: Thu, 9 Oct 2025 11:37:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com, dlemoal@kernel.org,
	christian.bruel@foss.st.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Fix sleeping function
 being called from atomic context
Message-ID: <aOeCWdbdfMpWIKv_@ryzen>
References: <20250930023809.7931-1-bhanuseshukumar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930023809.7931-1-bhanuseshukumar@gmail.com>

On Tue, Sep 30, 2025 at 08:08:09AM +0530, Bhanu Seshu Kumar Valluri wrote:
> When Root Complex(RC) triggers a Doorbell MSI interrupt to Endpoint(EP) it triggers a warning
> in the EP. pci_endpoint kselftest target is compiled and used to run the Doorbell test in RC.
> 
> [  474.686193] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
> [  474.710934] Call trace:
> [  474.710995]  __might_resched+0x130/0x158
> [  474.711011]  __might_sleep+0x70/0x88
> [  474.711023]  mutex_lock+0x2c/0x80
> [  474.711036]  pci_epc_get_msi+0x78/0xd8
> [  474.711052]  pci_epf_test_raise_irq.isra.0+0x74/0x138
> [  474.711063]  pci_epf_test_doorbell_handler+0x34/0x50
> 
> The BUG arises because the EP's pci_epf_test_doorbell_handler is making an
> indirect call to pci_epc_get_msi, which uses mutex inside, from interrupt context.
> 
> To fix the issue convert hard irq handler to a threaded irq handler to allow it
> to call functions that can sleep during bottom half execution. Register threaded
> irq handler with IRQF_ONESHOT to keep interrupt line disabled until the threaded
> irq handler completes execution.
> 
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> ---

All other calls to pci_epf_test_raise_irq() is done from the workqueue.

While we could change pci_epf_test_doorbell_handler() to queue some work on
the workqueue (and let that work call pci_epf_test_raise_irq()), converting
pci_epf_test_doorbell_handler() to be a threaded IRQ handler seems like the
less invasive change, thus:

Reviewed-by: Niklas Cassel <cassel@kernel.org>

