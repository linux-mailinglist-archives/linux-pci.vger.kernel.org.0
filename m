Return-Path: <linux-pci+bounces-2239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067CC82FDD9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 00:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795B9B24BC1
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 23:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB467C5D;
	Tue, 16 Jan 2024 23:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlSoDRge"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAD67C50
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 23:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705449248; cv=none; b=Jdd4NgC06EWiqKLZ7ooE2BFKbujnfdF67xROU85iJAN0Onp0iIUg8pOtne5T+FEilwrxHOViBR3q/wJb+Jakl/P0V3P2zkuRXeZLB+93yYhK84vAPVElgKM7NbT254b65PNnmE6Cbll3D2YwfEnTwLvrwDFtO2jJpfKHfSSV9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705449248; c=relaxed/simple;
	bh=sEBCwKiR5hjmre4jZ+2nLQiYzz/HQ3WCcShoHn6N2gE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=W4LtmXs4mutEvZkPNFpSucNJpdp7aO9VwCcoEtspJbdYivwM1nyaEiAVaZ3qd0pgH2sq1ama2jMQQk7I3rrQQ494kvh7ViYuQ1rRYSd8PjIzABSrO91t8hOEUqJ/WJIYRE2LamZrQntC+wqwGN+kyGjtS9DDXsXcp4mjHAEKjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlSoDRge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77453C433F1;
	Tue, 16 Jan 2024 23:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705449247;
	bh=sEBCwKiR5hjmre4jZ+2nLQiYzz/HQ3WCcShoHn6N2gE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HlSoDRgekRUrJXJhL0epP+YrmvRgaa4ohaMNKQsDlwIGVmkzlgDb5zD+Ez6nBiz/U
	 39bqZiZXKrN7dnXB3ukNU1FoU4v0fqgNi2nfCrqcTTb0hOzWgwolf5wYvgSfvmWCI6
	 I/XjDJAEUzLxL1NJzGITaXtfr/iQPlisMOsJyOTjd4RKAu2QaVdY/o1IQ8IJWwhGj8
	 M4HnFRfFe8KLccv6fHS+wX82lhNs/A0ugGRB8cn0Kp+UsXALrgjJ0ChLQiUuk9MsSq
	 mjNl7ud1ISCdqnJshvizS0BK89cdS2NlWF8Nw3kKFdGqULKZgHnAav0HAlfyRr6zJ0
	 52Vt3l5H4//xA==
Date: Tue, 16 Jan 2024 17:54:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240116235405.GA111628@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2728ad9d38442510c5e0c8174d0f7aae6ff247ac.camel@linux.intel.com>

On Tue, Dec 05, 2023 at 03:20:27PM -0700, Nirmal Patel wrote:
> ...

> In guest, vmd is passthrough including pci topology behind vmd. ...

IIUC this says the VMD bridge itself is passed through to the guest,
as well as the VMD Root Ports and devices below them.

Why is the VMD bridge itself passed through to the guest?  I assume
the host OS vmd driver enables the VMD bridge functionality, i.e., in
vmd_enable_domain()?

I gleaned this from the dmesg logs at
https://bugzilla.kernel.org/show_bug.cgi?id=215027.  I assume these
are from the host:

  pci 0000:00:0e.0: [8086:467f] type 00         # VMD Endpoint
  vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
  pci_bus 10000:e0: root bus resource [bus e0-ff]
  pci 10000:e0:06.0: [8086:464d] type 01        # VMD Root Port
  pci 10000:e0:06.0: PCI bridge to [bus e1]
  pci 10000:e1:00.0: [144d:a80a] type 00        # NVMe
  nvme 10000:e1:00.0: PCI INT A: not connected

What does it look like in the guest?  Does the guest see all three of
these devices (VMD Endpoint, VMD Root Port, NVMe)?

If the guest sees the VMD Endpoint, what does it do with it?  Does the
host vmd driver coordinate with the guest vmd driver?

Bjorn

