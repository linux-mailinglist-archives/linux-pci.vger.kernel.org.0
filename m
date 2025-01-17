Return-Path: <linux-pci+bounces-20053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2AA14DD5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BC5188940F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE171F9EBD;
	Fri, 17 Jan 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjJrdCf6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61511F91FF;
	Fri, 17 Jan 2025 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110456; cv=none; b=HiSd5prCnwyuFf6lG9vsxgnyx/eB5YZm/mredSytiWTAfTSBYXoj5PMYPz/O1nWIXSapQM5z1+O9P7fJBwcinc5mRfBi/S0eQtpZa8bjNwY2o+L6CWuP6BKEKVymF0UWYEedxLJCQLFOqChsjO9bUTKt4DCZ+tYhRqFOR7wn9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110456; c=relaxed/simple;
	bh=voBY9AQeKUHVp7xfOsCun8uG0/epGhnPUWf4sj2htoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxUp7/olLA/x5+QLyWCJ7a3B2Fjju2b47NIrXPqnZHQEescpHbOJF4Q2L0dOVViXwILd80XGzYtkG6zh+Veiq3X5SoeaTiK7Zyj2sEaRZ0kPPJ7T0lrDHDjgKgPIhESBfsJMJ7QXjXNHYtfZPXKXNN4RYuvj41tLe4+uqLQNNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjJrdCf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EA1C4CEDD;
	Fri, 17 Jan 2025 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737110455;
	bh=voBY9AQeKUHVp7xfOsCun8uG0/epGhnPUWf4sj2htoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjJrdCf6ueBGnOniuc+uy0eZz9AlhjKsgi3xHH6ReGLPmC11s/kkHt0tVHn/33hhL
	 o/BUoQ2CxSH581A0FnL1Na/oRV0YPs0PQjtypZIQKbBgDfsE0rFhG2o6sK574VYKs3
	 XFFQFkcjmK9zMw38wjZGDuDOSZSkY0AKESmcCwcXTNN3ChI9kpt+facpBL0gTviBtu
	 k24qKVx0MjCKEH7ksgi43o5xP2aETpXi5qC8Qts8YXOViiwroU55Y8g1Vq9CUFXu1U
	 c3MISoQw8IrkA1B4hRnfSiIcf4QSOfSCaNq37+fv4rDRZymR8fR4CX+dv7SDbgrqma
	 DLsh5t+CFqJrw==
Date: Fri, 17 Jan 2025 11:40:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com, dlemoal@kernel.org,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Fix double free Oops
Message-ID: <Z4ozsi_Le-Nk_25N@ryzen>
References: <20250117090903.3329039-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117090903.3329039-1-christian.bruel@foss.st.com>

On Fri, Jan 17, 2025 at 10:09:03AM +0100, Christian Bruel wrote:
> Fixes an oops found while testing the stm32_pcie ep driver with handling
> of PERST# deassertion:
> 
> [   92.154549] ------------[ cut here ]------------
> [   92.159093] Trying to vunmap() nonexistent vm area (0000000031e0f06f)
> ...
> [   92.288763]  vunmap+0x58/0x60 (P)
> [   92.292096]  dma_direct_free+0x88/0x18c
> [   92.295932]  dma_free_attrs+0x84/0xf8
> [   92.299664]  pci_epf_free_space+0x48/0x78
> [   92.303698]  pci_epf_test_epc_init+0x184/0x3c0 [pci_epf_test]
> [   92.309446]  pci_epc_init_notify+0x70/0xb4
> [   92.313578]  stm32_pcie_ep_perst_irq_thread+0xf8/0x24c
> ...

Personally, I would omit the stack trace.


> 
> During EP initialization, pci_epf_test_alloc_space allocates all BARs,
> which are further freed if epc_set_bar fails (for instance, due to
> no free inbound window).
> 
> However, when pci_epc_set_bar fails, the error path:
>      pci_epc_set_bar -> pci_epf_free_space
> does not reset epf_test->reg[bar].
> 
> Then, if the host reboots, PERST# deassertion restarts the BAR allocation
> sequence with the same allocation failure (no free inbound window).
> 
> So, two subsequent calls to the sequence:
> 
>   if (!epf_test->reg[bar])
>       continue;
> 
>   ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
>   if (ret) {
>       pci_epf_free_space(epf, epf_test->reg[bar], bar, PRIMARY_INTERFACE);
>   }

Personally, I would omit the copy pasted code.


> 
> create a double free situation since epf_test->reg[bar] was deallocated
> and is still non-NULL.
> 
> This patch makes pci_epf_alloc_space/pci_epf_free_space symmetric
> by resetting epf_test->reg[bar] when memory is deallocated.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

