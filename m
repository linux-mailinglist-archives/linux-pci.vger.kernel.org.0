Return-Path: <linux-pci+bounces-31998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192D5B02C20
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 19:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9474A6472
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C469288C3D;
	Sat, 12 Jul 2025 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJIuRyQF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135419ABC3;
	Sat, 12 Jul 2025 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752341206; cv=none; b=XslAY3oWFjazVtiBwMStFr+B0xNtVmHxMX8QBdIIRHQmkn5jvv6031CobJHnK0bBFVfrMWZOCpItjJRyNP/ae2fG6CxnsP3gURP6uxXYep9WOVX3BmApClaQmJwQ8VODPp/S70jOEI9CG13ho6mU1f1yIXTzrpyE7Q3timGXPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752341206; c=relaxed/simple;
	bh=SfagO8M+jSCPcKyANTSkZegIfivFTGXV1nN/75dObxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIzyp058d5ZEwzWWZuEhwVIcQphUVqO68PjWSgpksht/8iukju90rj0zhDhrvgYVmh404xMbG4KJrrUDPto5omm2lUH7Rpo+c3tvmL9TJdABM9qYW465CJcFuw4NbidBxvXTTuPp5uPpcfs4D3jOU1F+kGWPfNsvWsF6ts9W3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJIuRyQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F174C4CEEF;
	Sat, 12 Jul 2025 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752341204;
	bh=SfagO8M+jSCPcKyANTSkZegIfivFTGXV1nN/75dObxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJIuRyQFS2iHJBrHgFh8wla0RcBoeFhQYFHpACWBRuI2/tbxoW4meeb2QvSIlqz63
	 5CoFpFhYIH18T736WqWQCXqD4w7KjJF0G46LwqGd0uKpv5gZwx80QSKDcFxmVCjYVK
	 GfYPVq/gKV6LyfYng6RCy5qqICJX054olh0sc5wfH5dJ8WCoiAoRS+SQ0U9orw1Ro7
	 l112GJRIYEnGnm9WheivXASoS80eQtiZ8WOa4koO2v4HMfbtzVR3D8toZtDAVFVONh
	 ngHEmlpL5HbzcHQb7Ci3mAojEbULcZbOnZOYvIFK0w7dO9huRc/40+/JsC5dxJcYmu
	 wpZ2vAPRQRR6Q==
Date: Sat, 12 Jul 2025 22:56:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	linux-kernel@vger.kernel.org, Brian Norris <briannorris@google.com>
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
Message-ID: <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>

On Fri, Jul 11, 2025 at 05:43:33PM GMT, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> We have asymmetry w.r.t. pwrctrl device creation and destruction.
> pwrctrl devices are created by the host bridge, as part of scanning for
> child devices, but they are destroyed by the child device. This causes
> confusing behavior in cases like the following:
> 
> 1. PCI device is removed (e.g., via /sys/bus/pci/devices/*/remove);
>    pwrctrl device is also destroyed
> 2. pwrctrl driver is removed (e.g., rmmod)
> 3. pwrctrl driver is reloaded
> 
> One could expect #3 to re-bind to the pwrctrl device and re-power the
> device; but there's no device to bind to, so it remains off. Instead, we
> require a forced rescan (/sys/bus/pci/devices/*/rescan) to recreate the
> pwrctrl device(s) and restore power.
> 
> This asymmetry isn't required though; it makes more logical sense to
> retain the pwrctrl devices even without the PCI device, since pwrctrl is
> more of a logical ancestor than a child.
> 
> Additionally, Documentation/PCI/sysfs-pci.rst documents the behavior of
> step #1 (remove):
> 
>   The 'remove' file is used to remove the PCI device, by writing a
>   non-zero integer to the file. This does not involve any kind of
>   hot-plug functionality, e.g. powering off the device.
> 
> Instead, let's destroy a pwrctrl device only when its parent (the host
> bridge) is destroyed.
> 

Sounds good to me!

> We use of_platform_device_destroy(), since it's the logical inverse of
> pwrctrl creation (of_platform_device_create()). It performs more or less
> the same things pci_pwrctrl_unregister() did, with some added bonus of
> ensuring these are OF_POPULATED devices.
> 

If you take a look at commit f1536585588b ("PCI: Don't rely on
of_platform_depopulate() for reused OF-nodes"), you can realize that the PCI
core clears OF_POPULATED flag while removing the PCI device. So
of_platform_device_destroy() will do nothing.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

