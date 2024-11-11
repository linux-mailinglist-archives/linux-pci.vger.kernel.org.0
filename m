Return-Path: <linux-pci+bounces-16472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9CB9C466E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 21:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4C9B27707
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D31AB6FB;
	Mon, 11 Nov 2024 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1TBBsVa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44322159596;
	Mon, 11 Nov 2024 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356090; cv=none; b=rFRn4jOVdzxCHIzUm/rrlpRXbrCnDLIv3KHs3ssRbxIUbCM3hZqx5tEu1KZkZHlHn+r3WEjMa6FQ6Px+XSm1H8bukW2w1cuploqtRvY9FEARZ056Tfm6Jo5vrg+oIyas2Ethuc2sX+yTqs0WLj+XFs6IC/slu5AJ7EVFpKcAYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356090; c=relaxed/simple;
	bh=SrjtaIdKJS7bJOBErGq8Is2rp89VJCeImbgSZk1ay5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fOJRewFW5mwTbzkgPSUyNhTymJPnViW4wnwsBqW2O9chPRiek2LVb3pwWp7+hYXW3wXgyaezG/TPv2acitRD25PauKb8WPfq2u8pDmzsj0Tvk1ej+Ln2bji522TWtGG9jQffR07cGQZXY1T2mif2HsmYsEkJ5WSMHvBT6gOncog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1TBBsVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F47C4CECF;
	Mon, 11 Nov 2024 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731356089;
	bh=SrjtaIdKJS7bJOBErGq8Is2rp89VJCeImbgSZk1ay5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U1TBBsVadrFBK9AMqgxoUOkRkglr3lw7dCtJjYZWHxnzciqdmTwZcBTd5afj+uTot
	 L5RQuj/df1gdzNKTUITykdlPIhZUt6yZjBhA3V/S0nqKP2rtvAWDEiacErhnLVHxG/
	 QF7NJUHgiKd3i4vDgpOVUarnebuuev9j5AwYmq48Dcpgw94WaJEbM17tSwpomG8mjY
	 aBIJE+KKljf0toznKVaF3D07qmgeJH8SUfmVkAAHU4kUaqipdy6lprLFeE7U/WoNxX
	 CPVEbEb3EXS+rJjdrkc+q1J7S2XWavBNQ81qE61nRd2w9QNtqPe+wHX8baomWsgdeT
	 lL1N3Jg03ukXQ==
Date: Mon, 11 Nov 2024 14:14:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org,
	scott@os.amperecomputing.com, jerinj@marvell.com,
	schalla@marvell.com, vattunuru@marvell.com
Subject: Re: [PATCH v4] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Message-ID: <20241111201448.GA1814761@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111134523.2796699-1-sthotton@marvell.com>

On Mon, Nov 11, 2024 at 07:15:11PM +0530, Shijith Thotton wrote:
> This patch introduces a PCI hotplug controller driver for the OCTEON
> PCIe device. The OCTEON PCIe device is a multi-function device where the
> first function serves as the PCI hotplug controller.
> 
>                +--------------------------------+
>                |           Root Port            |
>                +--------------------------------+
>                                |
>                               PCIe
>                                |
> +---------------------------------------------------------------+
> |              OCTEON PCIe Multifunction Device                 |
> +---------------------------------------------------------------+
>              |                    |              |            |
>              |                    |              |            |
> +---------------------+  +----------------+  +-----+  +----------------+
> |      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
> | (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
> +---------------------+  +----------------+  +-----+  +----------------+
>              |
>              |
> +-------------------------+
> |   Controller Firmware   |
> +-------------------------+
> 
> The hotplug controller driver enables hotplugging of non-controller
> functions within the same device. During probing, the driver removes
> the non-controller functions and registers them as PCI hotplug slots.
> These slots are added back by the driver, only upon request from the
> device firmware.
> 
> The controller uses MSI-X interrupts to notify the host of hotplug
> events initiated by the OCTEON firmware. Additionally, the driver
> allows users to enable or disable individual functions via sysfs slot
> entries, as provided by the PCI hotplug framework.

Can we say something here about what the benefit of this driver is?
For example, does it save power?

What causes the function 0 firmware to request a hot-add or
hot-removal of another function?

Bjorn

