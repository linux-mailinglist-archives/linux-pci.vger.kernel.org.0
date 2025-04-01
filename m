Return-Path: <linux-pci+bounces-25061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8776A778D1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CC71886AF7
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 10:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423811F03C1;
	Tue,  1 Apr 2025 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkzmIt//"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129331E0E0B;
	Tue,  1 Apr 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503365; cv=none; b=FG/yiDCbIO4IvI2YUJd3t6XSDgGSsQoOJozYXJGdgF7uU+YkAinSzZRnXzb+ZsSw2jpSCHJ6388BktcJ7RnsORGQbWf9v/xNnnG2SZFU/sm5o3LSPPDkSYwoL0OZ9stWrl7o4pkarfFtYP3kmvCPcc6oZC5Ii3WdSkKpU3d0UGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503365; c=relaxed/simple;
	bh=Ti23H5IR6RvMf5Q2Ipi0RguLenESiqiPAhYyfxiegDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJGRWns7mUAIy1/bLmXMrsx9xNzMHulLmYb0tK1PDRQVMn4GrjvdoI8mQ/WP1wp5FxX/1VdwT3/6hzx1h88lzcySoGg9A651vBm5aNPIefO6BMkW6hSnYMOO35MOd6mg3UDPZ4mNUe+tx1LbNZ9u7LnHnya8dbMWRD0oAw71uzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkzmIt//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E725C4CEE4;
	Tue,  1 Apr 2025 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743503364;
	bh=Ti23H5IR6RvMf5Q2Ipi0RguLenESiqiPAhYyfxiegDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkzmIt//69XtaVE8p+KEuoDtkLzB+IGJJ5Uj7g82bSvgoyiUnlD+KHvSIhb2LR/DG
	 llwY1oc1pgVm8OTc/SH4pAIs+Ems2Qqdvg3pMUlbmTcULZbM8vg7QWCSVvbgsVSY1C
	 8NdgQcKYhShHNu447epbO7tKtyo3awM6DVP6CCLkqg0qLgLe5e4IzIjLzRy5NP48L7
	 +IDUFK+nKoAo+Rp/br5KY4Vniu5iwTteyPv3oxklXnPDHU5Dbgq9KyyOs5tWq8kYy6
	 eVH6IuGREvRTt3aR7IGSIhjHGiTEfySGRT79353+BFMIgpAUXln5QRAUMJzADwGmxM
	 /vQ7bnE2SfikA==
Date: Tue, 1 Apr 2025 12:29:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] misc: pci_endpoint_test: Set .driver_data for
 PCI_DEVICE_ID_IMX8
Message-ID: <Z-u__47R9vprIbCS@ryzen>
References: <20250331182910.2198877-1-Frank.Li@nxp.com>
 <Z-u6cZs6qncIWF98@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-u6cZs6qncIWF98@ryzen>

On Tue, Apr 01, 2025 at 12:05:37PM +0200, Niklas Cassel wrote:
>
> But... I suggest that we just remove the pci_endpoint_test_alloc_irq_vectors()
> call from pci_endpoint_test_probe().

...

Solution 1.


> 
> Or, if we want to keep allocating some kind of IRQ vector in probe(),
> just to rule out totally broken platforms, I guess we could also do:

...

Solution 2.



Considering that this is a test driver, I actually think Solution 1 is better.
That way, even if the platform has issues with IRQs, the user can do still do
all the tests/ioctls() that do not require working IRQs, e.g. PCITEST_BAR and
PCITEST_BARS.


Kind regards,
Niklas

