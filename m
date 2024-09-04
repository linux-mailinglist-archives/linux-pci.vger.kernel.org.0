Return-Path: <linux-pci+bounces-12787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA296C844
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 22:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 408F51F22415
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 20:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C8813D532;
	Wed,  4 Sep 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iykJ4OQG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A461EBFEC;
	Wed,  4 Sep 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481218; cv=none; b=HFE2OLyCbLjvOYCGuglkPCW2Y/v39mNMDTxhmOSLl6qH/FEZ6ELwLz5aE7dkPQql/v8NGrywKw0A0mKAptU+JyLV727wJejdOX4gI1tcGA8y22l+3lktUVIznSOvtwyCZB/jlxTY6N1ONGcuF6cuu1XC2y8DP579VFLItVdWb2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481218; c=relaxed/simple;
	bh=AreiRYl4YMxl+1sotIvthQAw/hRlmJfOg8jh+NLyftE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gQTLlWxFNt2inoMemTPDtPHn6YD2FzrAunsJm0jrnCNy+6qsQ9q0Xt/mZ2F+TsReR/0Qz0P74p4cDL2mZMMwLVET5gDobhlbrhGv9vujykhgg9LAbJVF+lZnk/pD6LLf561/KhU6yNCc8XTg3or3G0vjVxI6Nz69+Xna2o4RBXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iykJ4OQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C03C4CEC2;
	Wed,  4 Sep 2024 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725481218;
	bh=AreiRYl4YMxl+1sotIvthQAw/hRlmJfOg8jh+NLyftE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iykJ4OQGXby6YoYFu7IWsK347j4YcGj6tQkIUm0IDHk8ao1mWNOozaxKCls1UcV2y
	 q6yyH2yPvAY/KcvQzGEF/kG841xZgiayxEFDLtqQ1gFXg55dkCiP0WB8oV2My42jkM
	 gdJjPS/H8uOcPOpXTCMRu0VgO3KSA4fNM/dhf5ICeusBDSQ4QhAgZGKHJZcD+wK48M
	 l2bYx7NzcG81sPdSKLU4QnzZknFc/qT3ndKBH527BB9ItLmjVS3l5FD+gJvREWX1ye
	 hsqLSy0+IcTMP4YR1LwbkxYog8Nc2gxUokd2daA6uf6P1dTfI336ESTEv7oTzmJ3pN
	 LzIUgKRYEGLpg==
Date: Wed, 4 Sep 2024 15:20:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 00/12] PCIe TPH and cache direct injection support
Message-ID: <20240904202016.GA345873@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>

On Thu, Aug 22, 2024 at 03:41:08PM -0500, Wei Huang wrote:
> Hi All,
> 
> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint
> devices to provide optimization hints for requests that target memory
> space. These hints, in a format called steering tag (ST), are provided
> in the requester's TLP headers and allow the system hardware, including
> the Root Complex, to optimize the utilization of platform resources
> for the requests.

> Paul Luse (1):
>   PCI/TPH: Add save/restore support for TPH
> 
> Wei Huang (9):
>   PCI: Introduce PCIe TPH support framework
>   PCI: Add TPH related register definition
>   PCI/TPH: Add pcie_tph_modes() to query TPH modes
>   PCI/TPH: Add pcie_enable_tph() to enable TPH
>   PCI/TPH: Add pcie_disable_tph() to disable TPH
>   PCI/TPH: Add pcie_tph_enabled() to check TPH state
>   PCI/TPH: Add pcie_tph_set_st_entry() to set ST tag
>   PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag
>   PCI/TPH: Add pci=nostmode to force TPH No ST Mode

To me, this series would make more sense if we squashed these
together:

  PCI: Introduce PCIe TPH support framework
  PCI: Add TPH related register definition
  PCI/TPH: Add pcie_enable_tph() to enable TPH
  PCI/TPH: Add pcie_disable_tph() to disable TPH
  PCI/TPH: Add save/restore support for TPH

These would add the "minimum viable functionality", e.g., enable TPH
just for Processing Hints, with no Steering Tag support at all.  Would
also include "pci=notph".

  PCI/TPH: Add pcie_tph_set_st_entry() to set ST tag
  PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag

And squash these also to add Steering Tag support in a single commit,
including enhancing the save/restore.

  PCI/TPH: Add pcie_tph_modes() to query TPH modes
  PCI/TPH: Add pcie_tph_enabled() to check TPH state

And maybe we can get away without these altogether.  I mentioned
pcie_tph_modes() elsewhere; seems possibly unnecessary since drivers
can just request the mode they want and we'll fail if it's not
supported.

Drivers should also be able to remember whether they enabled TPH
successfully without us having to remind them.

