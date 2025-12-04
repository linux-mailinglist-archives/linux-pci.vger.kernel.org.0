Return-Path: <linux-pci+bounces-42629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E690CA3C47
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 14:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2F4A30DA716
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475234214F;
	Thu,  4 Dec 2025 13:13:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D9341AA0;
	Thu,  4 Dec 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764854016; cv=none; b=a5jgxxRYxo0qbpd56r/zl99MGRXkMd27hydCDcM0GaIykT6h9KZqP2hHpVjLCynBIZxO3OJM2DIazi6xq1r3UDL9N+4pzGH5/sG+DNpA9Mq48NGhIjqdYkAYa/ap3D5IkaCpYeOtjVSyFB+QrTPmYK2Sb2eZFv6et3I8xeX4seo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764854016; c=relaxed/simple;
	bh=/sHGEc18MFWomZ5tiEQ9CitQQjXHF5nKlJEesB1j1bo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uBAZkR9dtaYEixzlrxLRNU+OzcWZrda/zRHEyan+mNGVj9IrppeP8JAg3O/advpVOSi/CamLDKTSBYJzpxB5w42Q47xcmR+dBFBNDakUzXuHxp6+q/lXSTmd4v9aNtwGfz4ZjAQD4312vYO0jhxWyB1WCtLyS/xDac0vFqPkm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 5BD9092009D; Thu,  4 Dec 2025 14:13:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 5147792009C;
	Thu,  4 Dec 2025 13:13:33 +0000 (GMT)
Date: Thu, 4 Dec 2025 13:13:33 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
    Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
In-Reply-To: <20251203-ecam_io_fix-v1-2-5cc3d3769c18@oss.qualcomm.com>
Message-ID: <alpine.DEB.2.21.2512041313000.49654@angie.orcam.me.uk>
References: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com> <20251203-ecam_io_fix-v1-2-5cc3d3769c18@oss.qualcomm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Dec 2025, Krishna Chaitanya Chundru wrote:

> To resolve these issues, the ECAM iATU configuration is moved into
> dw_pcie_setup_rc(). At the same time, dw_pcie_iatu_setup() is invoked
> when ECAM is enabled.

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

