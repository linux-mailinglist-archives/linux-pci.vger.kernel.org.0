Return-Path: <linux-pci+bounces-15915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F99BAE15
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673971F21EED
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326DB18B49C;
	Mon,  4 Nov 2024 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfafH5Hr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4F176AA1;
	Mon,  4 Nov 2024 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709051; cv=none; b=jSz+75jbGTzO2FawtOsdDCKIykvYTcjkvVq+WjQA8EjgaqqZa6h0oInMMjXEtk2j0zqACdFZXpvKJ/TjiUPFRJSPrxd/dfGNymctGGHBh0LwqoeHC/mEM/Xrnw+TlsuwnhVx3pfpUCBM5OTKGhSR+XjVmJj34vdNwp5qbw27/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709051; c=relaxed/simple;
	bh=B0fqf2iWnN7dDMz2HBM0FGajZMaJODn1EVAiOn415ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E//DNXFEAQ3Up2PhTz7DP5FHwj2bnbrH7/wHB1EwyKA8IR0ZTqjA5V3Y+hXAUs9hrl1QMxY3OnBN06yCwMds5rMsyYxFD/s7AbUgdP/jBocupQq9pX2ckz6KBKTIZCwOiz3fw2VV2R8vfcMGI0tJGWr6TKiJ1+nH6uyJkJLwPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfafH5Hr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56119C4CED3;
	Mon,  4 Nov 2024 08:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730709050;
	bh=B0fqf2iWnN7dDMz2HBM0FGajZMaJODn1EVAiOn415ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GfafH5HrYBAkMvJskmyj3DGY6F6D4/1SQtt7nvAOvYHT/ou61zzhwnv1PGdccaQxH
	 1VRaf+qm5bIFgdb9cMHlOF2fJqH+EOo0YC7SeEXW4dXtHrdPv3mGObVSf49nOam/9x
	 xtBwiH/8HbFOfg7LbgTPulCC3usQtHPrVMgP+Y9V3pXoq2LcbnrG63a/5cZ8IZbyPx
	 8EDPciJBVYX3JyxarKH4SzCywAUw1AZ54jLnxM916XOuzyO3kgHB5zE9jVX7jkS3w+
	 rpEh5FsOwn22ZIFGH3JUvNc51U15aQA/bn5YmNWgziIBvbVuFNsi6/ncqHBxLV/yw3
	 a1eBgbwECHRbA==
Date: Mon, 4 Nov 2024 09:30:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Subject: Re: [PATCH] ata: ahci: Don't call pci_intx() directly
Message-ID: <ZyiGNtLMSY1vTQH7@ryzen>
References: <c604a8ac-8025-4078-ab90-834d95872e31@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c604a8ac-8025-4078-ab90-834d95872e31@gmail.com>

On Fri, Nov 01, 2024 at 11:38:53PM +0100, Heiner Kallweit wrote:
> pci_intx() should be called by PCI core and some virtualization code
> only. In PCI device drivers use the appropriate pci_alloc_irq_vectors()
> call.

Hello Heiner,

as you might or might not know, this patch conflicts with a Philipp's
already acked patch:
https://lore.kernel.org/linux-ide/20241015185124.64726-10-pstanner@redhat.com/


Kind regards,
Niklas

