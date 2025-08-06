Return-Path: <linux-pci+bounces-33479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306AB1CDEE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 22:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E62F7AD17D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4262BD584;
	Wed,  6 Aug 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnTxjp7I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E23220F29;
	Wed,  6 Aug 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512821; cv=none; b=aP+k4QWVPY8JjsxsfPCzoeqW5OCLDeLGUfkWx7Vqo/SBRDQ1LRpfLNUtD/S/fqAU1eD+DNqXXHhYtSgI9zCr3vNEufSMUoo14FSCWE2nlwLcOBrd4JtmKvfksH/uxXJqnxRc6kpWtkn/SZdsoUqN1Hlj4/NAv3tqOjpclZ9C0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512821; c=relaxed/simple;
	bh=NH36ylIEOImfIJAsosvJwcFt5Tcu/AapmVr89U8sXR0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZdG+W15ggmkII6Dq/Rfhgr3BLppQ25xbzbtSsPUDiAwLRvUBD4d5V25n+657LxVRAIzb954k/F9sVUPL+z1uzEHDDMNSVpwZlXnaplqvVvaux5VE8BFeP9SpvUsDtF0jXGHIO2/aD7u1btOpQvT8W3//JE2Umf8AQKIKdybmV2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnTxjp7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7049CC4CEE7;
	Wed,  6 Aug 2025 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754512819;
	bh=NH36ylIEOImfIJAsosvJwcFt5Tcu/AapmVr89U8sXR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PnTxjp7Iw/07Jny/3lPuCICzqt5VPU6IoIFN6GV5MwPFT6Ky1X32qG9fm91TRXLmv
	 +Vgo3UFNwPrGCe9yboehAakqp193rtjf/zC5e3WJue0bO9j5qvPIgoeFt4DDV1D6i3
	 OrslkhvB9WVcTUhfxsrMJ7/HeG8CZmqIBepOX9cGzGvl7CkOpBm2D6ClWDUS2Sp6RS
	 7mZ86hBtlNxJ0CoAx4/lx1PsP1tuwhejzpoEyLTaNCF/r6a1KNDrj/37mAQ++rP9U6
	 oUxda2OIMcwdQx2vQWAHWIGQyGlR2G0ZkAEbEueoy7GiQVUgtk2aOOhqlJz6v+Egii
	 otSB76mH7nFyQ==
Date: Wed, 6 Aug 2025 15:40:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
	ath10k@lists.infradead.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: Packet loss with QCA9377 (ath10k) on ASUS VivoBook E410KA
Message-ID: <20250806204018.GA14933@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b41300c-2034-4cad-8549-2622c224330f@gmail.com>

[+cc Jeff, ath10k maintainer, Mani]

On Fri, Aug 01, 2025 at 12:09:01AM +0530, Bandhan Pramanik wrote:
> Hello,
> 
> I'm helping someone who was having trouble with their Wi-Fi on Asus VivoBook
> E410KA. The device uses the QCA9377 Wireless Chip.
> 
> The device suffered from a single packet loss within 33 seconds while
> running a continuous ping. There might be some PCIe-level communication
> problems too.
> 
> All the relevant logs can be found here in a redacted form:
> 
> First part (ping, hostnamectl, ip addr, lspci): https://gist.github.com/BandhanPramanik/7eefd192c3a728d2473687a786fbbc01/raw/e77f0fa1cf35c748730df220b0057399ac78f539/miscellaneous
> 
> Second part (cat /proc/interrupts, modinfo ath10k_pci): https://gist.github.com/BandhanPramanik/7eefd192c3a728d2473687a786fbbc01/raw/e77f0fa1cf35c748730df220b0057399ac78f539/miscellaneous%25202
> 
> dmesg: https://gist.github.com/BandhanPramanik/7eefd192c3a728d2473687a786fbbc01/raw/e77f0fa1cf35c748730df220b0057399ac78f539/dmesg
> 
> We’re not sure if this is a driver issue, a firmware problem, or maybe
> something hardware-specific.
> 
> Has anyone seen something similar with this chip? Any tips on how to
> troubleshoot or fix the packet loss?

ath10k mucks directly with ASPM, which it definitely shouldn't do
because ASPM configuration is extremely sensitive, it involves both
ends of the link, and the PCI core needs to know about it.  So I'm a
little suspicious of some issue there.

Mani recently posted a patch series to clean that up a bit, but it's
not fully cooked yet, and I don't know whether it will help this
situation:
https://lore.kernel.org/r/20250716-ath-aspm-fix-v1-0-dd3e62c1b692@oss.qualcomm.com

Bjorn

