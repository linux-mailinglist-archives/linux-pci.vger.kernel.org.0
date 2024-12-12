Return-Path: <linux-pci+bounces-18332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1989EFBEC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CC7188F46B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219771C9B97;
	Thu, 12 Dec 2024 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdLt3LRd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11291D9592
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029729; cv=none; b=OrK7Xi1fXUr4lrSgiMkLqobbcECJTWDBS0+DkutGPUbFv0hvyc5sjY8zxO8vS2HpGEO6tTin7VVm8q3haOoj8JhDnH73iNKNheSPDhADiL0oQa1k7lps3Xixz3zBGEKB0SiuThnY13LgtAlK1A+V17iWLTJzAsvT1FwihpqPNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029729; c=relaxed/simple;
	bh=iC63c2TfMwutN6CHlOx6ciqpXlH4loUdJcyZovJHIwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IfVxn2KxHnFlrp4HQR3f+tq6/jQef7TA5o5v2DAHoarkgbM5eRQ9XMkIZzOMmZLJrM8iyTEqye/lol8w5DzvnIxAlseHJso2hWw/puyaEwb7AL/elT/YnKfd6/tYDDma+0zGVP1dQ+SBiokDZUshP/p8cyrVn9etsLHVm75JHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdLt3LRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D4FC4CECE;
	Thu, 12 Dec 2024 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029728;
	bh=iC63c2TfMwutN6CHlOx6ciqpXlH4loUdJcyZovJHIwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CdLt3LRdRxlehMKz4zIBkBo/OKzlURCHDEkmxHQDI5TfmgA6/hr1ZKA88Xblwa21h
	 Q8c58GT5edDsbsKbt6R0IFL8giY0ocGxd9pWVDqmmgGdMLm1++IhD3Cd+uKBLeFQc8
	 T1WJq9ViN9YeD9hYvPRIOnKCI/GGIgAfDiKnQSvnQvLuXhZCSUfUNdHqtmlzZLL8NW
	 qKu5iSVXt443Y+tO3x9+dw0q8gLgyjRZ75/SBJs5dgj/54YmLhsTxQOtQwTBjmtGp+
	 SDqYMmDn3Qe8d8WJPTvjzRJHzMLF80wtEw4CqQ9LEtd+08JwJQpeYNciACRbCbgQ+p
	 3soTaSulMEgEQ==
Date: Thu, 12 Dec 2024 12:55:27 -0600
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
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <20241212185527.GA3356063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212113440.352958-18-dlemoal@kernel.org>

On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:

>    This ensure correct operation if, for instance, the host reboots
>    causing the PCI link to be temporarily down.

s/ensure/ensures/

> The configuration of a NVMe PCI endpoint controller is done using
> configfgs. First the NVMe PCI target controller configuration must be
> done to set up a subsystem and a port with the "pci" addr_trtype
> attribute. The subsystem can be setup using a file or block device
> backed namespace or using a passthrough NVMe device. After this, the
> PCI endpoint can be configured and bound to the PCI endpoint controller
> to start the NVMe endpoint controller.

s/addr_trtype/addr_type/ ?
s/configfgs/configfs/

