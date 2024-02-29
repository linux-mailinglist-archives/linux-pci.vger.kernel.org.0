Return-Path: <linux-pci+bounces-4232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64A886C630
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D963B1C24705
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0A629F9;
	Thu, 29 Feb 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjTTNoaO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85BC629F8;
	Thu, 29 Feb 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200610; cv=none; b=hCkbOWr6WePGidmeBWh6YwScWyCB2+OF+4RlZcjpzh5hTaCbdRto+afo7PsjzrViKF78e4YbR8idOwofsK31kb54h85+sWEmOfXn8ovY+zOKxw9MuoxLUhYpvFUDBxEjW+Xr93vYC8nBHYp5axFWCNSvFOfLhcFNzr//FvOEwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200610; c=relaxed/simple;
	bh=ppq03LkPVFT8XGFcgYLvalWjL2zQMQQTUsLWOIlltzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1MffAvpuajQqUJzRWQZIe/6qt0saY8Ris96BA1BHFBlwFE29agct4mUmRz5qasnbtRhQQVvdhdRnHgX+br+362rFNRgytPdiBxdwOfiKh/TO+NtOFpqJhyXOCH1DJ7G6dCK1nhI2zUJLXf/S8xIZ5JASI15c5S+dqk+h3D5e8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjTTNoaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB882C433F1;
	Thu, 29 Feb 2024 09:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709200609;
	bh=ppq03LkPVFT8XGFcgYLvalWjL2zQMQQTUsLWOIlltzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjTTNoaOwiRMz2sATCPHbdOKjqdn0+wWijzm4YwxmK5L0PkqCC/22BJIimXzPb3TD
	 1t2UDEjHuaO7Ak4UeB9jQfGSDkdIXufhjgG8TW16UqEdcy1bhFvyFaUwUJzkgTVz1K
	 s5i3XH59aUJtC1OSQ/dMyoOgh5hNbZmdMhx7wttTwr10rgK5YNp5clPJkH01UhPFjN
	 dN5VXYC5ewB5HCv/DZkZff7D8Kz6o9Uvq5ON4HlTW0LYvvu6DR2PBJeNtI4HotGacD
	 sqJAgNDC7EVlVBuV0B3Tp88FW41U6Q2B4Q1oOFMTs9n1My8WL85RV1kYY0gY81ZAu+
	 J0+ePrx+1PslA==
Date: Thu, 29 Feb 2024 10:56:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: lchen.firstlove@zohomail.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com
Subject: Re: [PATCH v4] PCI: endpoint: Add prefetch BAR support
Message-ID: <ZeBU23Ccvv8WqFx_@fedora>
References: <17e7ad65ff5.d9de88b4962.1109678039880040918@zohomail.com>
 <CGME20240228134451epcas5p1b974d61fcab67fb5f52a7b291cf85966@epcas5p1.samsung.com>
 <20240228134448.56372-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228134448.56372-1-shradha.t@samsung.com>

On Wed, Feb 28, 2024 at 07:14:48PM +0530, Shradha Todi wrote:
> Reviewed-by: Shradha Todi <shradha.t@samsung.com>
> 
> This patch looks useful. Can we revisit this and get it merged?

Hello Shradha,

This patch is two years old, and no longer applies to pci-next.


However:
Usually, fixed hardware requirements are specified in
struct pci_epc_features (more specifically struct pci_epc_bar_desc).

A requested BAR configuration by an EPF is specified in struct epf_bar.


I don't think that Prefetch is a fixed hardware requirement,
so I do not think that we should put it in struct pci_epc_features.

It seems more like something that an endpoint function driver can
chose to request (or not to request), just like MEM_TYPE_64.

From the PCIe base spec:
"Generally only 64-bit BARs are good candidates, since only Legacy
Endpoints are permitted to set the Prefetchable bit in 32-bit BARs,
and most scalable platforms map all 32-bit Memory BARs into
non-prefetchable Memory Space regardless of the Prefetchable bit value."

"For a PCI Express Endpoint, 64-bit addressing must be supported for all BARs
that have the Prefetchable bit Set. 32-bit addressing is permitted for all BARs
that do not have the Prefetchable bit Set."

"Any device that has a range that behaves like normal memory should mark the
range as prefetchable. A linear frame buffer in a graphics device is an example
of a range that should be marked prefetchable."

We are not a legacy endpoint, so we should never set Prefetch for 32-bit BARs.
For 64-bit BARs, we should always set it, if the EPF-core allocated the memory
(regular memory) for that BAR.


Thus, I think the best solution is to do:

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index cd4ffb39dcdc..186c8cd87bb3 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -879,7 +879,8 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
        for (i = 0; i < PCI_STD_NUM_BARS; i++) {
                epf_bar = &epf->bar[i];
                if (epc_features->bar[i].only_64bit)
-                       epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+                       epf_bar->flags |= (PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                                          PCI_BASE_ADDRESS_MEM_PREFETCH);
        }
 }
 
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 0a28a0b0911b..acb93055181b 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -305,7 +305,8 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
        epf_bar[bar].size = size;
        epf_bar[bar].barno = bar;
        epf_bar[bar].flags |= upper_32_bits(size) ?
-                               PCI_BASE_ADDRESS_MEM_TYPE_64 :
+                               (PCI_BASE_ADDRESS_MEM_TYPE_64 |
+                                PCI_BASE_ADDRESS_MEM_PREFETCH) :
                                PCI_BASE_ADDRESS_MEM_TYPE_32;
 
        return space;


Now when I look at it, the whole "if (epc_features->bar[i].only_64bit)"
should move to pci_epf_alloc_space() IMO, so that not all EPF drivers need to
duplicate this code.


Kind regards,
Niklas

