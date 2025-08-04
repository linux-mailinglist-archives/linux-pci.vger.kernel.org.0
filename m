Return-Path: <linux-pci+bounces-33401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A8B1AAE9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943D118A31C4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBEF28FFC7;
	Mon,  4 Aug 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCUA+TqS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA628FAB7;
	Mon,  4 Aug 2025 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346467; cv=none; b=EKtqp1aKgpmLT4HTrlC0m0rPYGOZeAS9QwECbf1zV/pOw3WVO5LuXjYt+WPPgas8jG67YN8xGjtQ0hHBjYYO68GrMt3tTJUqijpV8U1MOjpgAstJ15znLQUBlxJOnqJXQY1VyBNlcIwTbPhqlTX458+euFmGnrpQ4b3fYFG7Df0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346467; c=relaxed/simple;
	bh=SQkL0B5l5IjdctrHj3Gl99P5F9VDS4wOilY/RtX1PTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hlk/OMOcUqaVE77oR80RZfPvzkcpIaKmTD7NsFsuItEKs47nWiukGwsyIXUyHLBCw9RTPKDvGX8zAH3XoMKVKZ+pK5M1+Crx2y4rAL4qxdgu1XiQ3uAnoHqghkLWim+MCnz/GjjkdYLBQaVi7yS6I5fXjZMiqX23WTd/V5LoNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCUA+TqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC17C4CEE7;
	Mon,  4 Aug 2025 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346466;
	bh=SQkL0B5l5IjdctrHj3Gl99P5F9VDS4wOilY/RtX1PTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dCUA+TqSKgiDrbi8Yua1m4k1ct0xhkrOCxL4Ib5uPhbm+La5GrjSQyO6SChcCq32d
	 HK6xSeGnMKeYjihhJu18HuF+yEy76Qtw9C8kXM5x1W5WO61rhm9PHtEfdERBAWIhWE
	 N/FeCXaEevwGpDvhJSfR86QBJrBGmz+LfcOG3xvQixpngjwAG5I4HhUmxtjLNJbFed
	 obc4+eNOZDU9pyiyUAKKg505Dw5L812k5rxaTooPKzpBwezSkNylN/asPFr0+Fdn2X
	 02da3GSV8+UKz/f5DtSOq1eQDxpRtahhBjlXboTe1jUoEo2mD7/SgxpQ4pUr+jBm74
	 UZOdCe0cWeUBA==
Date: Mon, 4 Aug 2025 17:27:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH v1 18/38] X.509: Move certificate length retrieval
 into new helper
Message-ID: <20250804222745.GA3645133@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-19-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:55PM +0530, Aneesh Kumar K.V (Arm) wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> The upcoming in-kernel SPDM library (Security Protocol and Data Model,
> https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
> ASN.1 DER-encoded X.509 certificates.
> 
> Such code already exists in x509_load_certificate_list(), so move it
> into a new helper for reuse by SPDM.
> 
> Export the helper so that SPDM can be tristate.  (Some upcoming users of
> the SPDM libray may be modular, such as SCSI and ATA.)

s/libray/library/

