Return-Path: <linux-pci+bounces-14887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C051A9A4A06
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 01:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D04B216D8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 23:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E457F188A18;
	Fri, 18 Oct 2024 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npjpqc5I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B2768E1;
	Fri, 18 Oct 2024 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293762; cv=none; b=Wcu3BI11DUra7Ap7tPlBHVe/zUiXecsycqijX78ghS+paDZ3Nf8bRe3ldFPgC1BxM2GVMfyLnA8c+K9Tgp0itiv7nQQttLSgw0mZj3VdZN0MoQWVcuMovCLVnFe9m2f7O39EEkWbmheR4hUUc6Hr7YGjh1KhQ1biF44+EqU2KhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293762; c=relaxed/simple;
	bh=Awclod2d4QNoDtBeg3hpjMzIstaYpw+65mTAfcX0CYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sm+brZGbLwDw1aBQgvcxf2o01m3fNJaDhAmGG+kMjnWXpgn9LpmN4r8kzt7mte/LjSjBXMNvYf3v3EoVz87BJkTBBEljuSsizwekirWYRGKXvqykJxAzCVoY1ZX/KrXI9wZ95oHri6666vCuERrA30NuW+BqEWNVlVYHQztKwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npjpqc5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B197C4CEC6;
	Fri, 18 Oct 2024 23:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729293762;
	bh=Awclod2d4QNoDtBeg3hpjMzIstaYpw+65mTAfcX0CYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=npjpqc5I2N8hguVXQPfSuVWDblo3YQ18gaMgoVtSptw9nZsKZGPvE4vj0x5fpkbDE
	 Kj87kkwO0sVyTpAVG/9gM4AffPFkMgEsmlwW//bW0k2+G7aRivdyhBuIgK9v3Y3JCg
	 1vi0D+ekKKfDgI4BV0bX74rPqQAcqmHdvsGKeTEMkJH0f1/81BLAbfNKYX2NRPjnCQ
	 xNAgFL7xWVMAVMTs18mMgGGctk4sLO2XjWHDuNIMFFUnbX1120Ob9OUdvFQPkheIFB
	 WP+2COMO73oGgarqSgynbMHQofmFKlHpa8CWmR1Rd9MNM4NBXYOb90Xmnj0Twqp80I
	 Uf4BIMfvSEFgQ==
Date: Fri, 18 Oct 2024 18:22:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	Benjamin.Cheatham@amd.com, rrichter@amd.com,
	nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
Subject: Re: [PATCH 0/15] Enable CXL PCIe port protocol error handling and
 logging
Message-ID: <20241018232240.GA768749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008221657.1130181-1-terry.bowman@amd.com>

On Tue, Oct 08, 2024 at 05:16:42PM -0500, Terry Bowman wrote:
> This is a continuation of the CXL port error handling RFC from earlier.[1]
> The RFC resulted in the decision to add CXL PCIe port error handling to
> the existing RCH downstream port handling. This patchset adds the CXL PCIe
> port handling and logging.
> 
> The first 7 patches update the existing AER service driver to support CXL
> PCIe port protocol error handling and reporting. This includes AER service
> driver changes for adding correctable and uncorrectable error support, CXL
> specific recovery handling, and addition of CXL driver callback handlers.
> 
> The following 8 patches address CXL driver support for CXL PCIe port
> protocol errors. This includes the following changes to the CXL drivers:
> mapping CXL port and downstream port RAS registers, interface updates for
> common RCH and VH, adding port specific error handlers, and protocol error
> logging.

Looks like all my comments at
https://lore.kernel.org/r/20241010190726.GA570880@bhelgaas still
apply.

URL broken across lines, distracting timestamps, patch subjects,
no clue about the base commit.

