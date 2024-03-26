Return-Path: <linux-pci+bounces-5163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E488BE4F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 10:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D521C38E34
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197264CE09;
	Tue, 26 Mar 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRSkwRiD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24604C635;
	Tue, 26 Mar 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446589; cv=none; b=LWno5fMHewhPR4uMw21q63AK/7i79v9oG/ZzkSMrerQJlmvQDL8qhwhK/LccI/jmz2LLfbzgcCLUHt7lqi6CB1/ajNzh8MJwUuDs+S83EIEN7XE5yrfZKf83YEzYlqdY8yOU7+WY3Dh37bXKqlz4OG+DKC4WlmWsXu0JiIK6qXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446589; c=relaxed/simple;
	bh=1TOSFjtroPOGfQTkxCHWFvG9NRdrsRwmbCHxxp90yfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLEWrlfGxnL02O0PFqdPouEzOAk3JBKTNV6IA4c89loQaXNCjRO9F1EY4AZ0+u7lQfPrI8g6d+aQflgx0GWuloQrDXjvrCKNW9voy8+/Rs9jnTHsX05ILifPk7zU7UdF2/mycmPHtk8W/PRZnozvCRz2/S9nYKXzv/sy751jeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRSkwRiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06753C433F1;
	Tue, 26 Mar 2024 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711446588;
	bh=1TOSFjtroPOGfQTkxCHWFvG9NRdrsRwmbCHxxp90yfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRSkwRiDhQ1SejXmzHwiP3wHPaal0hQIpI1nHudod3/6gQNssiHnGyq2YJ20M4SXG
	 P1L2M5Vv87t7J5SwAMmiR1nhD+o6sfqV91r2tWUKi5XAbp4frdj07Au2OdW8iH06WK
	 RFCFbfhIjzYH9I1xQZDVHmAiSRjbHxK0KT8OO5VIH2rrlPEutKaB+IyUcgqOyIxnyh
	 BvtCzqFNV7YfnGcmdypTi2Bdiblo2mvDDvEIV+gCHStAPWyjyfnZoqKU6UjzvbJyCV
	 sBHcei4sKtm+waJSHh4cVtHlqIkOKqrewaweQCYym24Cia3ZXdMCO8tB6fefoCqS7R
	 R2KPBCeXhFv5g==
Date: Tue, 26 Mar 2024 10:49:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com, u.kleine-koenig@pengutronix.de,
	dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v4] PCI: keystone: Fix pci_ops for AM654x SoC
Message-ID: <ZgKaNrhoReJ0A525@x1-carbon>
References: <20240325053722.1955433-1-s-vadapalli@ti.com>
 <ZgFemQ8gHpB8yMef@ryzen>
 <ea0294d4-85d1-4784-acd7-dd247165f69b@ti.com>
 <ZgF_5fYsI5lOFjOv@ryzen>
 <750df13b-ee2f-4067-a9e0-7fd1ace384cf@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750df13b-ee2f-4067-a9e0-7fd1ace384cf@ti.com>

On Tue, Mar 26, 2024 at 10:29:10AM +0530, Siddharth Vadapalli wrote:
> On Mon, Mar 25, 2024 at 02:45:09PM +0100, Niklas Cassel wrote:
> > 
> > In fact, if you move this code to ks_pcie_msi_host_init(), instead of
> > ks_pcie_host_init(), you would not need a comment (or a if (!ks_pcie->is_am6)),
> > since ks_pcie_msi_host_init() is only executed by !am654.
> 
> This seems much better :)
> 
> In the current code, the execution is as follows:
> 
> 	ks_pcie_probe()
> 	    dw_pcie_host_init()
> 	        pci_host_probe()
> 	            ks_pcie_v3_65_add_bus()
> 
> Moving the contents of ks_pcie_v3_65_add_bus() to ks_pcie_msi_host_init()
> will result in:
> 
> 	ks_pcie_probe()
> 	    dw_pcie_host_init()
> 	    	if (pci_msi_enabled())
> 			if (pp->ops->msi_init) {
> 				ret = pp->ops->msi_init(pp);
> 					ks_pcie_msi_host_init()
> 	        pci_host_probe()
> 
> I will update this patch based on your suggestion. If it's alright, may I
> also add your "Suggested-by" tag for the v5 patch? Please let me know.

Fine by me :)


Kind regards,
Niklas

