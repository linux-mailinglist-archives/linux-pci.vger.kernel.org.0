Return-Path: <linux-pci+bounces-41139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B5C59209
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43DDB4E8F38
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAF21339A4;
	Thu, 13 Nov 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q50QA/Mo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFEF2264D6
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052747; cv=none; b=brtfgeVMwyeXbf//nrCmAbP5n5+P8RuRNOCsxpOYt8MPSJgtrJ1oyr8UmnfPGkQ4xbtVt+Mgof/kDu26BjPt4gb+yY+h0bHcgddWV5KP8Xkp/jUdcg5Lvuo4qkWSA/3Lwy2wocKRvuI425wKLMDRySl4/+Os5HhtRMNBH1r96f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052747; c=relaxed/simple;
	bh=frSRHkP1fSkBQ1pW4XPyB6240EihIoOPWECTn1Gr0Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BCfpoDYPrsCrcZNeG9L7dTyZq3q0L2OmqCvsV26phCEBdgUbVtwacZIjHEDV4TIKlehMw3HrrIIlN1e1oNbPWj/R+nTPOiuxNOa5yl8fETc4MFAsfPoYV7JJFepv4tXRlzixxPk/XBLZfjgy1N6L0nQ6zM1tX7iBDumlNW45q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q50QA/Mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F687C113D0;
	Thu, 13 Nov 2025 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052746;
	bh=frSRHkP1fSkBQ1pW4XPyB6240EihIoOPWECTn1Gr0Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q50QA/MoicvvbX93vX4K/YQ11kgJ10hOhu4CzEETNXnfDpwYx/2wWyVe+y8QMs582
	 xsF9oUEgE1M62qKN1Dy7K4g9Gqseib+G3+6CukLfUsrnfeTyWRY2phVmvremxhLfLH
	 MzM+WCx5neBoC3xVyeJNmkxGbO59dF67FpYL2nff6+vtsYi1pKPwY6rH7Q/E7NAckN
	 Spoh/YToWRpGZl1vCuj/SniMKug8Ni0DGv94W46v5Nc0Vrtm3WyXeuivUrcRnVy/BB
	 LJqqDIVLzQFaU1lEQFUINoSOLQZARWcbZhJrgYNdR7ZEkTbfsDTNxshXK/KF7KSYjt
	 akMLle6mJcPTQ==
Date: Thu, 13 Nov 2025 10:52:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Subject: Re: [PATCH v4 0/2] PCI: brcmstb: Add panic/die handler to driver
Message-ID: <20251113165225.GA2287147@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029193616.3670003-1-james.quinlan@broadcom.com>

On Wed, Oct 29, 2025 at 03:36:13PM -0400, Jim Quinlan wrote:
> v4 Changes:
>   -- Commit "Add panic/die handler to driver"
>     o s/__MASK/_MASK/g -- (Alok)
>     o Remove underscore of _brcm_pcie_dump_err -- (Bjorn)
>     o Remove _MASK suffix from OUTB constants -- (Bjorn)
>     o Use standard notation %04x:%02x:%02x.%d" -- (Bjorn)
>     o Use BIT(i) instead of hex number (Ilpo)
>     o Remove unused constant (Ilpo)
>     o Use str_read_write() (Ilpo)
> 
> v3 Changes:
>   -- Commit "Add a way to indicate if PCIe bridge is active"
>     o Implement Bjorn's V1 suggestion properly (Bjorn, Mani)
>     o Remove unrelated change in commit (Mani)
>     o Remove an "inline" directive (Mani)
>     o s/bridge_on/bridge_in_reset/ (Mani)
>   -- Commit "Add panic/die handler to driver"
>     o dev_err(...) message changed from "handling" error (Mani)
> 
> v2 Changes:
>   -- Commit "Add a way to indicate if PCIe bridge is active"
>     o Set "bridge_on" correctly when bridge is reset (Bjorn)
>     o Return 0 instead "return ret" and skip ret init (Bjorn)
>     o Use u32p_replace_bits(...) instead of shifts and AND/OR (Bjorn)
>     o Reword error statement regarding bridge reset (Bjorn)
> 
> The first commit sets up a field variable and spinlock to indicate whether
> the PCIe bridge is active.  The second commit builds upon the first and
> adds a "die" handler to the driver, which, when invoked, prints out a
> summary of any pending PCIe errors.  The "die" handler is careful not to
> access any registers unless the bridge is active.
> 
> Jim Quinlan (2):
>   PCI: brcmstb: Add a way to indicate if PCIe bridge is active
>   PCI: brcmstb: Add panic/die handler to driver
> 
>  drivers/pci/controller/pcie-brcmstb.c | 198 +++++++++++++++++++++++++-
>  1 file changed, 192 insertions(+), 6 deletions(-)

Applied to pci/controller/brcmstb for v6.19, thanks!

