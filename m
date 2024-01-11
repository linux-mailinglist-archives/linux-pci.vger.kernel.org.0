Return-Path: <linux-pci+bounces-2066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8114282B413
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 18:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A8D1C241C8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 17:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991AA51C44;
	Thu, 11 Jan 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWrm8UpQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E1537E4;
	Thu, 11 Jan 2024 17:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C516C433C7;
	Thu, 11 Jan 2024 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704994126;
	bh=UIJqY2ZS5BKXIP6hcLPUvyuDwrfX4nJVEGG8zUnDmng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jWrm8UpQAVGHyH4zLjc3Xnx/gDrhuFukTgNW66Bpr7BZSSar/gwwP0D9vX2avv87u
	 AKARqcRvSzKf8318gdgMDiteMsiM7iswKLyqAXMAvN4GszNszBaMAzduGPP7jLvqwk
	 6uajGTIGS1oq1JBKsHtfu0oqg2keQZe+N2GkUz87/H7zAovmmGBqL/YeUaNWrvWNti
	 w3bhzCWmouKz5MnBrB4yfYAzCBd+sxiHHd8mvZ3gVVdr+rBImuepIvvB/q1OrRn+FE
	 14zQ9fIGgdB2zWLaZSPbe3w3+Piwjis2o8mH7bWCUelIvnRHMyO64rh0PMMFQkWz/P
	 7UGa1CuOmY2FQ==
Date: Thu, 11 Jan 2024 11:28:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/2] PCI: brcmstb: Configure HW CLKREQ# mode
 appropriate for downstream device
Message-ID: <20240111172844.GA2184973@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113185607.1756-3-james.quinlan@broadcom.com>

On Mon, Nov 13, 2023 at 01:56:06PM -0500, Jim Quinlan wrote:
> The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
> deliberately set by the PCIe RC HW into one of three mutually exclusive
> modes:
> 
> "safe" -- No CLKREQ# expected or required, refclk is always provided.  This
>     mode should work for all devices but is not be capable of any refclk
>     power savings.
> 
> "no-l1ss" -- CLKREQ# is expected to be driven by the downstream device for
>     CPM and ASPM L0s and L1.  Provides Clock Power Management, L0s, and L1,
>     but cannot provide L1 substate (L1SS) power savings. If the downstream
>     device connected to the RC is L1SS capable AND the OS enables L1SS, all
>     PCIe traffic may abruptly halt, potentially hanging the system.
> 
> "default" -- Bidirectional CLKREQ# between the RC and downstream device.
>     Provides ASPM L0s, L1, and L1SS, but not compliant to provide Clock
>     Power Management; specifically, may not be able to meet the T_CLRon max
>     timing of 400ns as specified in "Dynamic Clock Control", section
>     3.2.5.2.2 of the PCIe Express Mini CEM 2.1 specification.  This
>     situation is atypical and should happen only with older devices.
> 
> Previously, this driver always set the mode to "no-l1ss", as almost all
> STB/CM boards operate in this mode.  But now there is interest in
> activating L1SS power savings from STB/CM customers, which requires "aspm"
> mode.  

I think this should read "default" mode, not "aspm" mode, since "aspm"
is not a mode implemented by this patch, right?

> In addition, a bug was filed for RPi4 CM platform because most
> devices did not work in "no-l1ss" mode.

I think this refers to bug 217276, mentioned below?

> Note that the mode is specified by the DT property "brcm,clkreq-mode".  If
> this property is omitted, then "default" mode is chosen.
>
> Note: Since L1 substates are now possible, a modification was made
> regarding an internal bus timeout: During long periods of the PCIe RC HW
> being in an L1SS sleep state, there may be a timeout on an internal bus
> access, even though there may not be any PCIe access involved.  Such a
> timeout will cause a subsequent CPU abort.

This sounds scary.  If a NIC is put in L1.2, does this mean will we
see this CPU abort if there's no traffic for a long time?  What is
needed to avoid the CPU abort?

What does this mean for users?  L1SS is designed for long periods of
the device being idle, so this leaves me feeling that using L1SS is
unsafe in general.  Hopefully this impression is unwarranted, and all
we need is some clarification here.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 96 ++++++++++++++++++++++++---
>  1 file changed, 86 insertions(+), 10 deletions(-)
> ...

