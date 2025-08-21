Return-Path: <linux-pci+bounces-34467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A32EBB2FE3A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0D41CC143D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289726F2B0;
	Thu, 21 Aug 2025 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAl57Lx4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14324466C;
	Thu, 21 Aug 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789467; cv=none; b=Fs+t4bpdWUAqonol5crE+HagvxOuWtfcuTPYlk2RZO4zQxjKz41w3D0VJb3/9JhKzEG6fCGlwoxiJJ6FpbGR0lx8oUSBuEJbieLSQwC3pykDDm3lzCEyrSbwRHHDPm+C/qWiTHrCMf2fARy/3Erjz8L0Jj1zBwh+cpsV3KUi5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789467; c=relaxed/simple;
	bh=0XpGm74BbguxLGBqRanv0v2w8l+9/3zZaNNF6DWhSdw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hI8JHQShO+HrE1O97UQO21knBkLkpTugoNtVlG+PlCOD6LhNMrIYal+7K2835Ce3zFG4HQFxeTB/s0X1vWr8toTje3QfP3s48rYfBx0RG6ZczSTGdb/Hc4MDacU7zYgp9iyFIXDgg3T/Di41TYQJMdlWJfecUVXrMQwArcetvUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAl57Lx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365C0C4CEEB;
	Thu, 21 Aug 2025 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755789466;
	bh=0XpGm74BbguxLGBqRanv0v2w8l+9/3zZaNNF6DWhSdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rAl57Lx4GoF5YtEnIq5FxxRT4aRGhF2QvJYd+iTIp1a/4lzqu05sXEXa/Q9w942lk
	 97g59blrObFLKAJtOMjWMZPB9pIltFQtjQZAZgegj0fkdidR44bLQd3mAVR3n3lozd
	 VifXyVisLPUMYuNkOd7rYl1QcgdHQWL8S19Y9mHW/w6WY9unAyfXt70Tdo+O6CrmoR
	 ptvL0QAUT3Uq0Z4csgqZ5b9Mfp58YZKelsMGBlRA5++OB+M3BUDimx+pP2Sh+sKZ7i
	 SOjGuCWO8LosggLIIrED1Q1WE1or15D8bm+OVGc35gpgJVRcxeocRrxrBLeDOb6IRv
	 qwMJN8vkFuAxg==
Date: Thu, 21 Aug 2025 10:17:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 0/3] PCI: Resource fitting algorith fixes
Message-ID: <20250821151744.GA675253@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com>

On Mon, Jun 30, 2025 at 05:26:38PM +0300, Ilpo Järvinen wrote:
> This series addresses three issues in the PCI resource fitting and
> assignment algorithm.
> 
> v2:
> - Add fix to resize problem (new patch)
> 
> Ilpo Järvinen (3):
>   PCI: Relaxed tail alignment should never increase min_align
>   PCI: Fix pdev_resources_assignable() disparity
>   PCI: Fix failure detection during resource resize
> 
>  drivers/pci/setup-bus.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)

Applied to pci/resources for v6.18, thanks!  If you have any URLs or
other tweaks, I'll update with them.

