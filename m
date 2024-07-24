Return-Path: <linux-pci+bounces-10699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418C93AC15
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 06:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55711C2257D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 04:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD303D982;
	Wed, 24 Jul 2024 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbjZDWpc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA03B295
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721797018; cv=none; b=TKMn66XtqQtFOG367yX/6u278X8O5MrKV2z44OsoQAIer58f7ge/6jqGFU6DNnq87TI34XA18ED/P8SUbeYK7wtbrxxAuNzdMCizIYPDWZ1GjJonhz+BTuIAFuCBekyLW3NgJ+hR9rUSAI2r9SvsP2ci1XBj1fLyfZk52A0OR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721797018; c=relaxed/simple;
	bh=XV/KrWPP/b/chu9eictDGCmG+RB3lQgTNoD8t8IlTqY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OxcFU03xjiQbv3MWO4vMRURtgScEFWYvCB8YLR8UCqW3NvKuGRlZ4DQh2WpuZbDqLnktIwVyonfa3RtLHtBeZltm61icZhNVJqDbRhY8PYhB+ievvQJdkixlHJaE8CjLiQE39mPxRxIE5YGnnB7f1IrYoVLmurRnHGlaA/bIeUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbjZDWpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F56C32782;
	Wed, 24 Jul 2024 04:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721797017;
	bh=XV/KrWPP/b/chu9eictDGCmG+RB3lQgTNoD8t8IlTqY=;
	h=Date:To:From:Subject:From;
	b=sbjZDWpcRV+1iWGWssNXfz1t15/eU8XA0TBDN22ItG+1S0lYVkO1TAnmQOpWHZyWJ
	 IF+4panRofYKrqnOWjTZffIXb6OeFs4wKvdcsueIIWVFpITVS/AMXBBp0GJ5O2Ind9
	 shGPCOpK0X8otRgmBnDNMcrbCMyBqQK1SBU4WhGPQ/lr6jdLUmw55jgNycvZrEy6Af
	 5Yf+DxM22dqELZXgSoh6Umb5BE/x2WW3AHAUB/8bNQHnTyGSgw4AdFQRuU7WfV2E4h
	 DlGo2r69gFAIsX75E6s7u5xOFqyl7c+CuTEN6s0NJpot3U8vNc0ORrhdS53bFBm8kH
	 CZ4+EJBQZQMow==
Message-ID: <b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel.org>
Date: Wed, 24 Jul 2024 13:56:56 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Philipp Stanner <pstanner@redhat.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Subject: REGRESSION with pcim_intx()
Organization: Western Digital Research
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Commit 25216afc9db5 ("PCI: Add managed pcim_intx()") is causing a regression,
which is easy to see using qemu with an AHCI device and the ahci driver
compiled as a module.

1) Boot qemu: the AHCI controller is initialized and the drive(s) attached to
it visible.
2) Run "rmmod ahci": the drives go away, all normal
3) Re-initialize the AHCI adapter and rescan the drives by running "modprobe
ahci". That fails with the message "pci 0000:00:1f.2: Resources present before
probing"

The reason is that before commit 25216afc9db5, pci_intx(dev, 0) was called to
disable INTX as MSI are used for the adapter, and for that case, pci_intx()
would NOT allocate a device resource if the INTX enable/disable state was not
being changed:

	if (new != pci_command) {
		struct pci_devres *dr;

		pci_write_config_word(pdev, PCI_COMMAND, new);

		dr = find_pci_dr(pdev);
		if (dr && !dr->restore_intx) {
			dr->restore_intx = 1;
			dr->orig_intx = !enable;
		}
	}

The former code was only looking for the resource and not allocating it.

Now, with pcim_intx() being used, the intx resource is *always* allocated,
including when INTX is disabled when the device is being disabled on rmmod.
This leads to the device resource list to always have the intx resource
remaining and thus causes the modprobe error.

Reverting Commit 25216afc9db5 is one solution to fix this, and I can send a
patch for that, unless someone has an idea how to fix this ? I tried but I do
not see a clean way of fixing this...
Thoughts ?

-- 
Damien Le Moal
Western Digital Research

