Return-Path: <linux-pci+bounces-40286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC89C32BBB
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 20:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37A93B0B71
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 19:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C902F90CE;
	Tue,  4 Nov 2025 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL+/0LfZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461762D77E2;
	Tue,  4 Nov 2025 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283355; cv=none; b=OwE9pEPIRYYRn/nFVNqQke2GqNot+imR66GItUZxN5B+1xKq1nli3h4EJdU9IoSR6arAzGm2Kts6Y43texiz5aKkg2+4aKfvGqNcnGEnNqhJXFSzx7RwDclU37r1qff6zcWZwp2O3PHCRNALWYj4xqKyPhhopz1dCI9p9Kc/F9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283355; c=relaxed/simple;
	bh=4LBlwu1VcNE+IFsZqaAZ8BTvFzBiurJVnz2YM2UzysI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lbBHIFKdt3Q1S9uqndNcXUfWbqMeS60S1fh5buAYVZwcr1PkZq/iaxDsf860UO/xn7GW9inVCXEVAvrY239mMYVmzJS7EEiGZuAzhOkzGClzQmNit04adMcpIpmV1TVNj2kvprHmZiafQ5v7bdA6lOF50DTDEvjkroUOWqwMbQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL+/0LfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4495C4CEF7;
	Tue,  4 Nov 2025 19:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762283354;
	bh=4LBlwu1VcNE+IFsZqaAZ8BTvFzBiurJVnz2YM2UzysI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cL+/0LfZLOZMRzaPrOk6ZBnxX71OeLU5AfFqtZ1lr5Zse4E9qMsQn4X9GERe/51sh
	 9qnJ2yoWM805vRsDsx1Xf0qS/apsIbz3FQSZFCE4HOoLHyKJ2UzoAUSrAUaZyLg+3s
	 I6IFKZIVbrjD63AhqWm2BZ+NsMdqZ5CRtgRUlniYuPtjRztS6GSPYhgzcWkuEsae8a
	 aiAmueWB9rLr9y9W2sQin8bj6+sJ1zqrbjKfNSXCaCjyaaTl+Qm8aFQG0nHviXssDB
	 Ffi4NVVW0km242/GPK5NzwyXbDikB5892NUD9e3cRG2QJL8MbzBubOsf0povGrv2ku
	 UB74FHHyGa2/g==
Date: Tue, 4 Nov 2025 13:09:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 19/25] cxl/pci: Introduce CXL protocol error
 handlers for Endpoints
Message-ID: <20251104190913.GA1866025@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-20-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:59AM -0600, Terry Bowman wrote:
> CXL Endpoint protocol errors are currently handled by generic PCI error
> handlers. However, uncorrectable errors (UCEs) require CXL.mem protocol-
> specific handling logic that the PCI handlers cannot provide.

> +++ b/drivers/cxl/core/ras.c

> +static bool is_pcie_endpoint(struct pci_dev *pdev)
> +{
> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT;
> +}

Seems like a weird place for this since it's not CXL related.

