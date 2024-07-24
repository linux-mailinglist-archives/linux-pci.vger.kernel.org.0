Return-Path: <linux-pci+bounces-10700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC7B93AC33
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 07:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFEF1C2254D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC6B45016;
	Wed, 24 Jul 2024 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDluDkQq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55649446AF
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798041; cv=none; b=WdtX4rZILfchyimxe6bYqwFSR3rV4wJyEmWsJRAcVHxRF3yq3ZMfMvE8B+gjVqfX6N+b1Wanj3x3pPnYdfmvoQbIKUv27e5QkI9i63LAYyFvOrczLsjFQoVMYXhYFFzzoJr3wQIjApdQRvMUmio1j1fMrgl9caBedQmhacF+Vj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798041; c=relaxed/simple;
	bh=JSdUY6NsCXuMbX/PBmbul6s/2XK1z1vVagBWdExAscY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Jn8b7XbdHb7+qA7Oj41hNKLeDInLKvDhvHUDwTOmbdtc0QWhSHkgQ9VRG01/rS76kK3akrsxkA0F5lj4iluXj24gb2KfZN+tjekzrho9wNnwudSM4GgY3qXXGwQJFWDTjkLKJgzPykWjtaoHv+/DFnD1EdkK3PLhv0u7UkkA1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDluDkQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EE2C32782;
	Wed, 24 Jul 2024 05:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721798040;
	bh=JSdUY6NsCXuMbX/PBmbul6s/2XK1z1vVagBWdExAscY=;
	h=Date:From:Subject:To:References:In-Reply-To:From;
	b=dDluDkQq4daodplehvGafg2btYS1FIiDiW5D+SNu+CV0v2uBq6t8DInNylHzFwiTv
	 CoWUyvVeB8QBy/BpbHXT3LQl28Xh/paDmkZx0k6N6R1PapGV34xjAa90h9Tep5jVlc
	 LfVpNJaPLs5P+FJb6vZeVkIftqrxqhZtA/0+rGy9S5EvlXzSdsSpWpisgKNx/maYAM
	 BnlVKfRhtLJALDW/1harIsDnfY5MnhkgzAdkbAu46LGXF35h5eAxJoDV6C7jSChz8u
	 XpTR76z/H9xEy8OTmF+Xqbc7TcC/XeRGhcX9NF77p/vSqpvb5AUkw9I45yhod94ryg
	 wrAlwwZz6Z3uQ==
Message-ID: <f0653852-0ae8-4b7d-b01c-3170b22490ff@kernel.org>
Date: Wed, 24 Jul 2024 14:13:59 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: REGRESSION with pcim_intx()
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Philipp Stanner <pstanner@redhat.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/24 1:56 PM, Damien Le Moal wrote:
> 
> Commit 25216afc9db5 ("PCI: Add managed pcim_intx()") is causing a regression,
> which is easy to see using qemu with an AHCI device and the ahci driver
> compiled as a module.
> 
> 1) Boot qemu: the AHCI controller is initialized and the drive(s) attached to
> it visible.
> 2) Run "rmmod ahci": the drives go away, all normal
> 3) Re-initialize the AHCI adapter and rescan the drives by running "modprobe
> ahci". That fails with the message "pci 0000:00:1f.2: Resources present before
> probing"
> 
> The reason is that before commit 25216afc9db5, pci_intx(dev, 0) was called to
> disable INTX as MSI are used for the adapter, and for that case, pci_intx()
> would NOT allocate a device resource if the INTX enable/disable state was not
> being changed:
> 
> 	if (new != pci_command) {
> 		struct pci_devres *dr;
> 
> 		pci_write_config_word(pdev, PCI_COMMAND, new);
> 
> 		dr = find_pci_dr(pdev);
> 		if (dr && !dr->restore_intx) {
> 			dr->restore_intx = 1;
> 			dr->orig_intx = !enable;
> 		}
> 	}
> 
> The former code was only looking for the resource and not allocating it.
> 
> Now, with pcim_intx() being used, the intx resource is *always* allocated,
> including when INTX is disabled when the device is being disabled on rmmod.
> This leads to the device resource list to always have the intx resource
> remaining and thus causes the modprobe error.
> 
> Reverting Commit 25216afc9db5 is one solution to fix this, and I can send a
> patch for that, unless someone has an idea how to fix this ? I tried but I do
> not see a clean way of fixing this...
> Thoughts ?

This change works as a fix, but it is not pretty...

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..4e14f87e3d22 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -466,13 +466,22 @@ static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
 int pcim_intx(struct pci_dev *pdev, int enable)
 {
        struct pcim_intx_devres *res;
+       u16 pci_command, new;
 
-       res = get_or_create_intx_devres(&pdev->dev);
-       if (!res)
-               return -ENOMEM;
+       pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+       if (enable)
+               new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+       else
+               new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+       if (new != pci_command) {
+               res = get_or_create_intx_devres(&pdev->dev);
+               if (!res)
+                       return -ENOMEM;
 
-       res->orig_intx = !enable;
-       __pcim_intx(pdev, enable);
+               res->orig_intx = !enable;
+               pci_write_config_word(pdev, PCI_COMMAND, new);
+       }
 
        return 0;
 }


-- 
Damien Le Moal
Western Digital Research


