Return-Path: <linux-pci+bounces-3553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 471AA856F97
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 22:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E974E282089
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785313DBA4;
	Thu, 15 Feb 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiFsYFRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37DF1420CA;
	Thu, 15 Feb 2024 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033886; cv=none; b=nt9BfuPjZHACT4vI5ZAqIXK9cq7VHQdrzYBBBvkKqY28OoOfJtOkv0w1qtUJcSHASJCOO88YjFQXydsosUZ3M/zgs8I98odrI8Muf2bWRMYBVl4iQfrdw4jq1TswOaK/n5HEcfmYYIehsHlCWawAkzmD3YGU4wbJrsm8n2DJCks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033886; c=relaxed/simple;
	bh=FQpn500JHv51WzKlC0dgUWu4e2OmVblZmPGVoliTIkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HRYJ57x2AJOcmFodzyugZc3dkJwyaN88lcyUNPOlkGbEoTkSSKqcUeP32ofQul1dMnTfwU206z8w0tIAEumF0cDA1qCp8jKKNiWUyZdO5WjEuWHE6ZeiIHF3pN7gYpZDaOABTeFdfQcWByizQVu7ruhYuPj4nE5saQGyraskylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiFsYFRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FB7C433F1;
	Thu, 15 Feb 2024 21:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708033885;
	bh=FQpn500JHv51WzKlC0dgUWu4e2OmVblZmPGVoliTIkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FiFsYFRfZc4Rejsej4pFUMpr9Iu4gUR0SpIlPJI/UaFp0oRS624YGj72tKctsbebb
	 dtq8zjHR0UtL88hlpf+W0Fm6ebFh3YZJn+5n2JbDh8Jv8Hb+j0per5cQlpw5uz8LSt
	 7IZDbcp1x62itOpNG3XMaJX50v+s4KtLouRxAENSusmns/TBZuRS2m/1rKppo5L1AZ
	 l4Uho9/6ccCor46U+nhXka9yzAgE8K7GtBCQiJqQVxa+fKBsKk4OWuZ3V+5E8R8hGf
	 NbjmgOoONHkzIwblFQMyFBBvm2G2E0GfuZfg9/aC7qyocAElRlljIZChKq20jmSFoa
	 Nk1qk8OyIrQfA==
Date: Thu, 15 Feb 2024 15:51:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com
Subject: Re: [RFC PATCH 5/6] pcie/portdrv: Add CXL MSI/-X allocation
Message-ID: <20240215215123.GA1311182@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215194048.141411-6-Benjamin.Cheatham@amd.com>

On Thu, Feb 15, 2024 at 01:40:47PM -0600, Ben Cheatham wrote:
> Allocate an MSI/-X for CXL-enabled PCIe root ports that support
> timeout & isolation interrupts. This vector will be used by the
> CXL timeout & isolation service driver to disable the root port
> in the CXL port hierarchy and any associated memory if the port
> enters isolation.

Wrap to fill 75 columns.

