Return-Path: <linux-pci+bounces-18328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5D9EFB73
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924B5188D07C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A94918B484;
	Thu, 12 Dec 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrywXcPk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6426F189B9C
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029310; cv=none; b=IzwKgSY/mqgxuzwfnUgGaRiJxa8vJ4hp4mRKNj+uvYHPNaSKtLsKHeDn4Dcf6hzOy4/+fbCCjwxrAwnPSRS71QERtuo96xPUb6cUbyjE0hXORQStRm6ytp5V4oHrje4+LX93Vuag+FNSTcAXKtVBLEW+RWend/ekq/2VVSdYB7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029310; c=relaxed/simple;
	bh=tOGMju40dv2/vvov0Gt5CZ9asbT5RPj1IsGYlrPDuWc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fgf/zpFwrEOTTj+nrPWWdVy7sWGXFGRjQVFATDUyITGkXeM4iNtLVjILFDaJ6b/MZgJS50o+ySCha/EGF/jgFsREq+qJikuyd7p+1f78DgiGbkKjJ8ASXXAxLQ6kFdla3tLkkyyfp/x4YnRsx/ncQ9sDm/HgDslZe7J0gStyJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrywXcPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38F1C4CECE;
	Thu, 12 Dec 2024 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029309;
	bh=tOGMju40dv2/vvov0Gt5CZ9asbT5RPj1IsGYlrPDuWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GrywXcPkz1K16BghTpnDVl+HI5dqFkRdXuaU8bIFT+gOlNQfBTW7zuqyok64nlsVl
	 2W+8XKf1x1ZbEcbVbUAvb3UHz8GWzhJpc1U/w9euaRUoHA4tAyp2i+JJ0bZ8Ba/heD
	 mYkeb718epWf3scMI7hjGPZ8QOXDuB/TYH81k/fpnAzTBp7gFM6DZcbCOwYiW6PoNE
	 oLhjXDYAkd3ANF1/QT8bgwFucdEh8LTy0NSVKzaV46Hd9m0bzxC5E+0ExsAKl4rMiO
	 d528wzG1dBGuVJphKf7n9NdiDRa3q1FbE1e6j8Uo4Rbxkxzorgmz2TPRT9TZWzKbVp
	 /XmA+XqaTrhxA==
Date: Thu, 12 Dec 2024 12:48:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 18/18] Documentation: Document the NVMe PCI endpoint
 target driver
Message-ID: <20241212184828.GA3354708@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212113440.352958-19-dlemoal@kernel.org>

On Thu, Dec 12, 2024 at 08:34:40PM +0900, Damien Le Moal wrote:
> Add a documentation file
> (Documentation/nvme/nvme-pci-endpoint-target.rst) for the new NVMe PCI
> endpoint target driver. This provides an overview of the driver
> requirements, capabilities and limitations. A user guide describing how
> to setup a NVMe PCI endpoint device using this driver is also provided.
> 
> This document is made accessible also from the PCI endpoint
> documentation using a link. Furthermore, since the existing nvme
> documentation was not accessible from the top documentation index, an
> index file is added to Documentation/nvme and this index listed as
> "NVMe Subsystem" in the "Storage interfaces" section of the subsystem
> API index.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

  Applying: Documentation: Document the NVMe PCI endpoint target driver
  .git/rebase-apply/patch:43: new blank line at EOF.
  +
  warning: 1 line adds whitespace errors.

> +The NVMe PCI endpoint target driver allows exposing a NVMe target controller
> +over a PCIe link, thus implementing an NVMe PCIe device similar to a regular
> +M.2 SSD. The target controller is created in the same manner as when using NVMe
> +over fabrics: the controller represents the interface to an NVMe subsystem
> +using a port. The port transfer type must be configured to be "pci". The
> +subsystem can be configured to have namespaces backed by regular files or block
> +devices, or can use NVMe passthrough to expose an existing physical NVMe device
> +or a NVMe fabrics host controller (e.g. a NVMe TCP host controller).
> +
> +The NVMe PCI endpoint target driver relies as much as possible on the NVMe
> +target core code to parse and execute NVMe commands submitted by the PCI RC
> +host. However, using the PCI endpoint framework API and DMA API, the driver is
> +also responsible for managing all data transfers over the PCI link. This
> +implies that the NVMe PCI endpoint target driver implements several NVMe data
> +structure management and some command parsing.

Sort of a mix of "PCIe link" vs "PCI link", maybe make them
consistent.

Does "PCI RC" mean "Root Complex"?  If so, maybe "PCIe Root Complex"
the first time, and "PCIe RC" subsequently?  I don't know enough about
this to know whether "Root Complex" is necessary in this context, or
whether "host" might be enough.

> +4) The boot partition support (BPS), Persistent Memory Region Supported (PMRS)
> +   and Controller Memory Buffer Supported (CMBS) capabilities are never reported.

Gratuitous >80 column line.

> +If the PCI endpoint controller used does not support MSIX, MSI can be
> +configured instead::

s/MSIX/MSI-X/ as is used elsewhere

> +The NVMe PCI endpoint target driver uses the PCI endpoint configfs device attributes as follows.

Gratuitous >80 column line.

