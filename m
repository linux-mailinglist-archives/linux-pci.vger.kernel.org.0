Return-Path: <linux-pci+bounces-2122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508682C449
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 18:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50551F248E2
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195EA1B5B3;
	Fri, 12 Jan 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtCFx+wP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBD17C84;
	Fri, 12 Jan 2024 17:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96967C433C7;
	Fri, 12 Jan 2024 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079346;
	bh=5mIpyTO4J5SDuulflKbUDpkvJpfEhCWC4gKHviZApdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UtCFx+wPjkv2hkcwJYBBvo/3fFX7/4aY0H/Jd9SkyJDSv+87PSfvFkvPQGHNgOWvk
	 abYZCdRbc6N5P+kyx3UTZ9/rSp7Oe5UrRvD1LjAYpfKDSh5AeBmXasopGPqsSrsWfw
	 hCgytp+0dg5dmgSiJdhwEqnhRfvO1YhdQfkpdqxcSfjxkyIhjtM84T+l8Rsx8P8s9S
	 1SM9+YbNCKufZhtAyLvTS7ehaRMXlSckjpGuxbinOfJaUz6knIDalpljsEKR0HNTiP
	 4f0zTzvfeB2Bp1U0/0JWbyspVHDbZXXO6CMyRHRJOvLZImPuCtVufZH5HNOz2vD58k
	 Gc5amF/mIomyg==
Date: Fri, 12 Jan 2024 11:09:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Sui Jingfeng <suijingfeng@loongson.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Fix kernel-doc issues
Message-ID: <20240112170905.GA2272861@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111162850.2177655-1-helgaas@kernel.org>

On Thu, Jan 11, 2024 at 10:28:50AM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix kernel-doc issues reported by
> "find include -name \*pci\* | xargs scripts/kernel-doc -none":
> 
>   include/linux/pci.h:731: warning: Function parameter or member 'pdev' not described in 'pci_is_vga'
>   include/linux/pci-epc.h:154: warning: Function parameter or member 'list_lock' not described in 'pci_epc'
>   include/linux/pci-epf.h:83: warning: expecting prototype for struct pci_epf_event_ops. Prototype was for struct pci_epc_event_ops instead
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied with Randy's Acked-by and Tested-by for v6.8.  Thanks for the
other replies; I would certainly add them but for the fact that I've
already tagged what I intend to ask Linus to pull for v6.8.

Bjorn

