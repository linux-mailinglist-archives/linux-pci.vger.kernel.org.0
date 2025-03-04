Return-Path: <linux-pci+bounces-22904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B59A4EE67
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 21:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4123A98BB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 20:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8226E2641D5;
	Tue,  4 Mar 2025 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aulpz27l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB8246335;
	Tue,  4 Mar 2025 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120308; cv=none; b=ip88h2LLDmvMHqpcFcbL3bazmCLnfFclxPwhzBmXauxTFv3yeBevF/hIIka4z9yBYgmjFZJoRFeF0LAjgbYwAonJXFm4iU6kFMNhu2axcB5NDOT1RvHm35tsGaoOJR53buTm8CtCt2Ab7d3/zbw6dU0wsl8eobHHmT0MqkSBDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120308; c=relaxed/simple;
	bh=2cRsyEaRlJFchgyZwhW0xRb74ZHZVckWgHMV1JwiSGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ml+GG5/x3qt2k29CZ4sgbDcEJlE3ykHEqilF6BtoSNIOjW6LgVqFDwQ6sCEXB3Wvbu6dYKg5gnBOySo0aFIhcTUgjS/R9FT0D8NpM8XYGuGPfY5Toc3563EykfcRPnmILK/Br6ddGmkDfM+NB4X4qdlH3boXaP1wI0xB4qFQBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aulpz27l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4E9C4CEE5;
	Tue,  4 Mar 2025 20:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741120307;
	bh=2cRsyEaRlJFchgyZwhW0xRb74ZHZVckWgHMV1JwiSGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aulpz27lXrSJrUS196mpqWya5NAdpRoSyJUpatYVbVeS54gioUXDioLTZnHZa7/l8
	 zgyvqRt6hXmgqo+P0wEOrrWxLXkqwUzKfDlibklzMXYLSafYRWecUJ8/c4RTH8XWQl
	 a8LW8bUTdoxRYEPB58Xk+njj/9R+IlxfJNzj2TNPT9Dnb9zdAzQCHxolXT6qv1ayxR
	 qXAaGY3q2trNb7M8ewp7wsrRXsd+P0E9yvw8FA4lx8UOHyu4prwNrApWn/BFLkK0Qr
	 89oafOlDZgkEMD92LsswXs1N84gcrYg7FX6h5S4QkiKcsIhSc0nv7VDDjMLxVdzq5k
	 yVJClIRHBZzCA==
Date: Tue, 4 Mar 2025 14:31:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC NOT TESTED 2/2] PCI: artpec6: Use
 use_parent_dt_ranges and clean up artpec6_pcie_cpu_addr_fixup()
Message-ID: <20250304203146.GA256660@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8dem5gBf3xLxSIT@lizhi-Precision-Tower-5810>

On Tue, Mar 04, 2025 at 03:12:11PM -0500, Frank Li wrote:
> On Tue, Mar 04, 2025 at 01:08:16PM -0600, Bjorn Helgaas wrote:
> > On Tue, Mar 04, 2025 at 12:49:36PM -0500, Frank Li wrote:
> > > Remove artpec6_pcie_cpu_addr_fixup() as the DT bus fabric should provide correct
> > > address translation. Set use_parent_dt_ranges to allow the DWC core driver to
> > > fetch address translation from the device tree.
> >
> > Shouldn't we be able to detect platforms where DT doesn't describe the
> > translation correctly?  E.g., by running .cpu_addr_fixup() on a
> > res.start value and comparing the result to the parent_bus_addr()?
> > Then we could complain about it if they don't match.
> 
> Can't detect because:
> 
> There are case, driver have not provide .cpu_addr_fixup, but dts still be
> wrong. such as
> 
> bus@10000000
> {
> 	ranges = <0xdeaddead 0x1000000 size>;
> 	pci@90000000 {
> 
> 		reg = <...>, <0xdeaddead>;
> 		reg-names = <...>, <config>;
> 	}
> 
> };
> 
> above dts can work with current driver, but parent bus address 0xdeaddead
> is totally fake address. We can't detect this case because no
> .cpu_addr_fixup() at all.

If there's no .cpu_addr_fixup(), primary-side ATU addresses must be
identical to CPU addresses.  If the DT parent bus address is
different, can't we assume the DT is broken?

