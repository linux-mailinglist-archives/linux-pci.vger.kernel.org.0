Return-Path: <linux-pci+bounces-21096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC63A2F4A9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C683A3C4A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7624BD1E;
	Mon, 10 Feb 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlAUBWmj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDEC24BD14;
	Mon, 10 Feb 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207237; cv=none; b=QWTL6TMKIzC1yoxZVc7Mrc8uE8+7FQ5kNPkGhMsoxsZxCuGD2asudsMiMWgKL7a8PZNQFKXTKxSPZRitIinerYKOddNl8VtZbdyheSTHBxm6eShcntWVwA7hG3aIc/Go8KZnWwaPxWp0rgJIpCkNIK1kxPIUj6eZkMggG/Kz0JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207237; c=relaxed/simple;
	bh=DxTJ/BZQwxqMrlHz+wi5HBb7dswEUmrT+uzB0yIckIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QaknRyV2/Kg1ndM6mMf8EPnUU8T87yfslTJqE9IMxbZwlAZj1pShXSpMnhe9cms2RH4iaAMDIFo2wPkSv7flJ1BPXWeUh5Nz1+FEGZKgkPBHIk5hgZCGwGBNs9hxY4d4A6hlK6HqPsEqap30cyk+Sj3sAp7pZ13GtZ8CH5bVX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlAUBWmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18E3C4CEE9;
	Mon, 10 Feb 2025 17:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739207236;
	bh=DxTJ/BZQwxqMrlHz+wi5HBb7dswEUmrT+uzB0yIckIQ=;
	h=Date:From:To:Cc:Subject:From;
	b=qlAUBWmjPdEXngb9Ey5BNmIYhfSukGsI243GoTOB3yt6Sk6VKcT/DOliRZ0SXJ5qS
	 6zHKEb85yTfawt53u8sBF5AdjEcVr1dGHGNf8uZegtpDC5ypVaD9eYGA1KbK5l74gY
	 hrIExWSmoTLJgaw7ACtzP+H7X8E1rKt8OdHW10iXXb76Wck7Q0ZhCPr/QPJSL7qdCB
	 2uIJRCWWFkXihSv3eh0gBI8E9QYnDZz6wQ3GkzwcWdGvCDJhl5i2oFsh/EZ6Yo8NWM
	 FSpHTLU7GhuKu6no1DpoXZCkShqvTl+4Q4Dxti8il5gfNKokWm1Y9Qf7v08cd+XIPd
	 AcKaKZoQLxw2A==
Date: Mon, 10 Feb 2025 11:07:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-pm@vger.kernel.org,
	regressions@leemhuis.info
Subject: [bugzilla-daemon@kernel.org: [Bug 219765] New: Regression: VFIO
 NVIDIA GPU Passthrough Fails in Linux 6.13.0 (GPU Reset & Audio Controller
 Disappears)]
Message-ID: <20250210170715.GA8877@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=219765

I don't see an obvious culprit between v6.12 and v6.13, suggested
bisection if possible.

Workaround: boot with pcie_port_pm=off

Given the workaround, maybe it's worth trying a revert of this:

  dc421bb3c0db ("PCI: Enable runtime PM of the host bridge")


----- Forwarded message from bugzilla-daemon@kernel.org -----

https://bugzilla.kernel.org/show_bug.cgi?id=219765

Created attachment 307599
  --> https://bugzilla.kernel.org/attachment.cgi?id=307599&action=edit
dmesg logs for the kernel in which gpu passthrough works

After upgrading from Linux 6.12.10 to Linux 6.13.0, VFIO GPU passthrough fails
for an NVIDIA GPU (AD107). The GPU is not passed through to the VM, and its
audio device (01:00.1) disappears from Virt-Manager. This issue does not occur
in Linux 6.12.10.

I have attached the logs.

