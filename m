Return-Path: <linux-pci+bounces-4878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB387EE6E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 18:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E5A284747
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 17:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE6055789;
	Mon, 18 Mar 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDpVQYHC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD254BE3;
	Mon, 18 Mar 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781726; cv=none; b=emnbO6d0ku7O8wBHPLXe6TvzvizhhHHbMLbWTqXGhSel6qJ1oGHKZ6SH0JS7c9n7aKWVRXIeAHXlk09zxitYe+SvVkY7LpxTvw+lef6hLoBO3cVtwemQ3aOUwbTDs5UU8wsJQch9tCW9Gt/K0NLsjEY5BwgXuXYuyMk4+LWHt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781726; c=relaxed/simple;
	bh=ZmPRdsYdvMk1O/gZ3oDc5Rz15l5IIb9Dtfx18VBfImc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rcFzkd9jb/bUIyrVUsEacQ7GOA00ArRcAGp1x+Q4uPmcx5UkdvpTLTYiN25skJrGRGW85g8tHR0GxGJd0PnKYAHQAtumLAs5KbjKyDCnz70fWsDYf5vsNDRsmhJS8Pzhn6yxMv7hTQt708NCSq1sZrccghM0FRhoqraIvVFmEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDpVQYHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D8C433F1;
	Mon, 18 Mar 2024 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710781725;
	bh=ZmPRdsYdvMk1O/gZ3oDc5Rz15l5IIb9Dtfx18VBfImc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RDpVQYHC6k54NrE+3ukgLb7d+rvBUnUc/YcBo9tqpDO6oqsqnA47xfxyXnrm4Ae8x
	 h/10876VNVpxJoDlMS1S+MeTAZ8w4KIf77AYMjQc9LhV84rHk++ie2o3T8PQn5DQYL
	 wcaBeSpX5VLLU2PBS9gns/IlRQT1W94MhxtEn0XSkMbs+zVRpz2LrgkRsH5xojJ1j2
	 vdH6oASz+BNvWuyI5Bz7L9rzuY7vgKc9vpegxxJYmC+fA7fCmzuMRyZka2S5V050Ak
	 ZgZmNSn+LMOp3nMSjlqZE0iimYvBnN5V+khEEX+M7cauoSck4X1jr5xgWK8WXiesuL
	 H/IzuwlkdSWIQ==
Date: Mon, 18 Mar 2024 12:08:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for
 outbound window memory allocation
Message-ID: <20240318170843.GA1187538@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>

On Sun, Mar 17, 2024 at 11:39:17AM +0530, Manivannan Sadhasivam wrote:
> As proposed during the last year 'PCI Endpoint Subsystem Open Items
> Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> framework for managing the endpoint outbound window memory allocation.
> 
> PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> driver from the start for managing the memory required to map the host
> address space (outbound) in endpoint. Even though it works well, it
> completely defeats the purpose of the 'Genalloc framework', a general
> purpose memory allocator framework created to avoid various custom memory
> allocators in the kernel.

Nice idea.  I wonder if something like this could be done for PCI BAR
assignment, i.e., the stuff in setup-bus.c.  There are a lot of
constraints there, so maybe it wouldn't be practical.

> The migration to Genalloc framework is done is such a way that the existing
> API semantics are preserved. So that the callers of the EPC mem APIs do not
> need any modification (apart from the pcie-designware-epc driver that
> queries page size).
> 
> Internally, the EPC mem driver now uses Genalloc framework's
> 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> based on the requested size as like the previous allocator. And the
> page size passed during pci_epc_mem_init() API is used as the minimum order
> for the memory allocations.

/as like the previous allocator/as the previous allocator did/

> During the migration, 'struct pci_epc_mem' is removed as it is seems
> redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> is now used to hold the address windows of the endpoint controller.

s/as it is seems/as it seems/

If this is not a logically required part of the conversion, could the
pci_epc_mem removal be a separate patch?

The docs refer to it as "genalloc", i.e., not capitalized:
https://docs.kernel.org/core-api/genalloc.html

Thanks for working on this.

Bjorn

