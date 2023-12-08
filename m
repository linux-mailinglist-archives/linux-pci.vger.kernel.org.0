Return-Path: <linux-pci+bounces-717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D480AF8E
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 23:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CA51C20B30
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 22:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE9450279;
	Fri,  8 Dec 2023 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp9eSxuk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F547A5E;
	Fri,  8 Dec 2023 22:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9862C433C7;
	Fri,  8 Dec 2023 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702073780;
	bh=4jtOxyTXC1Zhc3BU449OCvozRrSno/0pGK9xBwiWzj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Dp9eSxukWivDGnnqLm5p/1dy7Fycj/b4VPi99MUlFRCHlyGjLCzShqX4wOwgNVjXc
	 0nMkD//n2AOPmDzWG8i+ROc6PpEmWarre208FQsWrYdE9Br1tyPS7kT3ACy66f4ssG
	 jmcj1F8opaDg0xM6/C7SxCDgEC0Fxo1zfeMpFWfsVzxpNdzglEoeS74stneAFvEKg7
	 1z/btf3sNG6a8MCKSLPMdY6zTZU+66yq4s+Zdr5zidA8aR0ZozKZ6kYtupqqIt4SHl
	 6slbDKkyVoQM8etCnOSEvxtI90E0+p8EiO/Bu1pO6eOuYaGF9MQbcRwGzBeBUjngkR
	 lnP40GBp5HXNA==
Date: Fri, 8 Dec 2023 16:16:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] pci: loongson: Workaround MIPS firmware MRRS settings
Message-ID: <20231208221618.GA834006@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201115028.84351-1-jiaxun.yang@flygoat.com>

On Fri, Dec 01, 2023 at 11:50:28AM +0000, Jiaxun Yang wrote:
> ...

> +		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },

P.S. I notice most of these Device IDs are not in the lspci database
at https://admin.pci-ids.ucw.cz/read/PC/0014.  It's easy to add them;
there's a link at the bottom of that page.

Some, e.g., 0x7a09 (DEV_LS7A_PCIE_PORT0), are described as "PCI-to-PCI
Bridge".  I had the impression these were Root Ports.  If so, the
description could be more specific.

Bjorn

