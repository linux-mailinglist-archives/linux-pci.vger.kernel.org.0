Return-Path: <linux-pci+bounces-3264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C284EB70
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 23:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB3EB29BAF
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C64F21A;
	Thu,  8 Feb 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqSDKFlx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8D4F5E5;
	Thu,  8 Feb 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430387; cv=none; b=WsCIaBLgFiUdo00aho9412+Is4YwCM8F6BC+R0AVWuCQ5QuhMeZFL0WRIBLAC8Ok0B8c5sI0MnZpfCzIE7j4nuHoGKo5zd5uwUBbgMc6qgwMazU1/5zR4VMwjcA4N7oGFM4woqh3WN5tCNvE/3tmCS5iFr4T3jVVpAdYlZPtrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430387; c=relaxed/simple;
	bh=WWDXQWrNQ+UG8hZH9g7vZULFOzSTgSLQuIw2a8Lkx8s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ICRhfZE/SKcg8ywMB9mxq0TXTi3qYINyRUGHYshKdXzWB0a7L1jyLnnHwfiWOnWA3ex4mFPXkmLWYAdyaN/NCJEmp8k/WSvF+Iql5i+ZbwNAm3yylC5DTltMsaNYKZWal3lGO37trFovGLeYmYBImBc0G451F+IsNNmgYtfWVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqSDKFlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF49EC433F1;
	Thu,  8 Feb 2024 22:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707430386;
	bh=WWDXQWrNQ+UG8hZH9g7vZULFOzSTgSLQuIw2a8Lkx8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rqSDKFlxCA+eYeuATi2CEYSAZ5I7ReXxd8dHhlwoli27YnGbzTKzqVavkDguG6gFY
	 nzxkor0F2vq5eWG0pYKCoGwt7bpxitZK6Ib1XyqUo530USi1eZGo1MdHvQ3/F9kdQN
	 gnSSVIBzB4wAiyfFotVowIr+ohoJT6iUgIFvwUPcDsyJk56qiE2dMm5Mz9BjT+vaMj
	 S4SBPmruxQvtuo5yTqEfo3TdM/aDclnWuY9gWDQwyCIywGmTI28FWvq7Ab2dLmyv+V
	 /hwa1HqTa3WBUYsz43F1KqcWYu9wSs8ktKZnhWMG/uoJ2BsDRv4Dc950xZUjMe9yak
	 ZVFCinf0WyIkA==
Date: Thu, 8 Feb 2024 16:13:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Wu Hao <hao.wu@intel.com>,
	Yilun Xu <yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20240208221305.GA975512@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>

On Tue, Jan 30, 2024 at 01:24:14AM -0800, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted
> Execution Environment (TEE) Device Interface Security Protocol (TDISP).
> This interface definition builds upon CMA, component measurement and
> authentication, and IDE, link integrity and data encryption. It adds
> support for establishing virtual functions within a device that can be
> assigned to a confidential VM such that the assigned device is enabled
> to access guest private memory protected by technologies like Intel TDX,
> AMD SEV-SNP, RISCV COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a device security manager (DSM) and
> system software in both a VMM and a VM. From a Linux perspective the TSM
> abstracts many of the details of TDISP, IDE, and CMA. Some of those
> details leak through at times, but for the most part TDISP is an
> internal implementation detail of the TSM.
> 
> Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> attribute, and add more properties + controls in a tsm/ subdirectory of
> the PCI device sysfs interface. Unlike CMA that can depend on a local to
> the PCI core implementation, PCI_TSM needs to be prepared for late
> loading of the platform TSM driver. Consider that the TSM driver may
> itself be a PCI driver. Userspace can depend on the common TSM device
> uevent to know when the PCI core has TSM services enabled. The PCI
> device tsm/ subdirectory is supplemented by the TSM device pci/
> directory for platform global TSM properties + controls.
> 
> All vendor TSM implementations share the property of asking the VMM to
> perform DOE mailbox operations on behalf of the TSM. That common
> capability is centralized in PCI core code that invokes an ->exec()
> operation callback potentially multiple times to service a given request
> (struct pci_tsm_req). Future operations / verbs will be handled
> similarly with the "request + exec" model. For now, only "connect" and
> "disconnect" are implemented which at a minimum is expected to establish
> IDE for the link.
> 
> In addition to requests the low-level TSM implementation is notified of
> device arrival and departure events so that it can filter devices that
> the TSM is not prepared to support, or otherwise setup and teardown
> per-device context.

Gulp, this is a good start and covers a lot of what I asked about
[1/5].  Should have read the whole series first ;)

