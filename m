Return-Path: <linux-pci+bounces-33577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5117B1DDC9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622A96213C0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65ACF21D3F2;
	Thu,  7 Aug 2025 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO69Hwyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF02215198;
	Thu,  7 Aug 2025 20:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597559; cv=none; b=aBM3DnP9OWrkhS92FVZNznEbb4B4HYE9Znc3mI9iud6jI2SxBKQZjQmfD3T0UYSaWN+uT6EwicPgeHu1m9QM4PiN/x6yHKxnPE/9rbeM9rw7ty07PIQlQwFUUL0sltRLH4WLvBRsdTKmLB2DtsIAfppgImkgqg32Hg8uNO1vIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597559; c=relaxed/simple;
	bh=TPoM3ei+H+P6hX6PFzcvgTdckfFp1BaLmymUDFszMCE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BOnA+cMDfaOAcTGTG9saygDOozK9GBavjq5kkIhFoMpIeUtkgnjv7/RXc9oGlq6RW7TsWbDW/5fXlJlC+avdXzCEDypL+3uVTF+d9GBkuMonXH16oofPGUcpJ95jhrjkW2AUfden7pV8NuoTOh/vcas9BWyFpR1IBMo8O5e+p70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO69Hwyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CD3C4CEEB;
	Thu,  7 Aug 2025 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754597558;
	bh=TPoM3ei+H+P6hX6PFzcvgTdckfFp1BaLmymUDFszMCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lO69HwytTMvv1bPeuYpzFOSSU8KGDSlsuIrJypXr3F4+Onzvly6auY5/hftBisyNs
	 J39pgQBnQ1Uoqtt1QzI9T8Nx0WjfmCErQKJ0AL8v9r3nxwECg//kRzirAhOYWrK8NA
	 vPyqpXnl3pZfi8sim5ygIL15v0Nb5dHmWam7ypnAZjBXueMoNCD+Ngo6UlUP4rF3o4
	 Xeq5jIypjGXRseYeFGZUBDSpjmseD7SRAS/cLvktfO4ODsmD3/eU2nnqKFI+06MyKf
	 Xfy6L3xnFL7UQyHt+qZtDKxlZBfC+wO79GGEn2g/cpgRgBVRJaTjr5q6RO6SN6Rehh
	 uVmUS9YcXqoOA==
Date: Thu, 7 Aug 2025 15:12:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Yilun Xu <yilun.xu@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20250807201236.GA60870@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-3-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:50AM -0700, Dan Williams wrote:
> Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
> 7.9.26 IDE Extended Capability".

> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#define dev_fmt(fmt) "PCI/IDE: " fmt
> +#include <linux/pci.h>
> +#include <linux/bitfield.h>

Trend is to alphabetize these.  And I think there should be more
#includes here instead of using other things pulled in indirectly:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submit-checklist.rst?id=v6.16#n17

> +++ b/include/uapi/linux/pci_regs.h

> +#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
> +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> +#define  PCI_IDE_CAP_LINK_TC_NUM_MASK	__GENMASK(15, 13) /* Link IDE TCs */
> +#define  PCI_IDE_CAP_SEL_NUM_MASK	__GENMASK(23, 16)/* Supported Selective IDE Streams */

I'm totally OK with dropping the "_MASK" suffix since I think uses are
completely readable without it, especially with __GENMASK()/FIELD_GET()/
FIELD_PREP().

