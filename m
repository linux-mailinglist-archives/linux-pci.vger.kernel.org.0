Return-Path: <linux-pci+bounces-35626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13E2B482E6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 05:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EFA17BACD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 03:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A01C54AF;
	Mon,  8 Sep 2025 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAHUGtf0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5A315D3A;
	Mon,  8 Sep 2025 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302760; cv=none; b=Ue09QyNTloHwtSCOtR48BLgUpb3gi1ysHnx9S565wnme7WKxtatkZ+17aoBLxRn5E1qo2mJAPgRwChwSP+a6aI4DcaYFHDjSbTW7JpzUFcN3u7AAwXhSeUrfB7GsoK4aiLZbEANUiHanx+t3TAwhoulOKrE354xIoyroR3zQdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302760; c=relaxed/simple;
	bh=lVaQogxRxHTcdSmnAEDjTJ71tx8RD2jm4+c/+FwJSyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mADq0IRGd9EvJHP9YPz1BpFuLTiPw6XdJyfXwl3q7COpqZUJwZELcLUxF8Egn3z5/Zu/TckjLhpD8GbkS5whfdyPPI51zC1Ua1SUFICltPG6Z7wXmVwdSriWFV3VtO7mURzZNV8afqm/UYd6Ew3x+e80cRmnSf9Jo1C/cb4xdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAHUGtf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263B2C4CEF5;
	Mon,  8 Sep 2025 03:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757302759;
	bh=lVaQogxRxHTcdSmnAEDjTJ71tx8RD2jm4+c/+FwJSyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAHUGtf0ZWmD1BzjTl7H7Sc0d3vF4lov+wuMx7bLdXAyX9tfYide8ARlgvL247BVD
	 6pty0/0GhHOqMwME5JIfCbDVWXip7nbj61JTjDyKp6RbFlpn7PJhS9SMqoVOQujpZ7
	 tnaCbZypF1xWMznCZISz5uRnPkHE05vuyheacvOQe9OD5Jk6RfrRLUYk936fPnZVAc
	 7PTbqBQ2cmlr7xR6cXAlGKVQBOU+Bx7EfNLFuitjg+moNn+vM2TIO7PfA5tR4lENCT
	 hrJzn7qq0Te+FVFhxiT/+M+ynx4yZbxwwZU+I5l4NYurpfxqdIePQPWODIidGOcaBu
	 fwvLrCfG6NkzA==
Date: Mon, 8 Sep 2025 09:09:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, fan.ni@samsung.com, 
	quic_wenbyao@quicinc.com, namcao@linutronix.de, mayank.rana@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, quic_schintav@quicinc.com, shradha.t@samsung.com, 
	inochiama@gmail.com, cassel@kernel.org, kishon@kernel.org, 18255117159@163.com, 
	rongqianfeng@vivo.com, jirislaby@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH 00/11] PCI: Keystone: Enable loadable module support
Message-ID: <2gzqupa7i7qhiscwm4uin2jmdb6qowp55mzk7w4o3f73ob64e7@taf5vjd7lhc5>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903124505.365913-1-s-vadapalli@ti.com>

On Wed, Sep 03, 2025 at 06:14:41PM GMT, Siddharth Vadapalli wrote:
> Hello,
> 
> This series enables support for the 'pci-keystone.c' driver to be built
> as a loadable module. The motivation for the series is that PCIe is not
> a necessity for booting Linux due to which the 'pci-keystone.c' driver
> does not need to be built-in.
> 

There are concerns from the irqchip maintainers that unloading an irqchip
controller is a bad idea. We had a lot of previous discussions on this topic.

But I would certainly welcome the idea of building a controller driver as a
module (tristate) and prevent unloading it during runtime (by keeping it as
builtin_platform_driver).

> Series is based on linux-next tagged next-20250903.
> 

No need to base your patches on top of linux-next. Either do it on top of -rc1
or pci/next.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

