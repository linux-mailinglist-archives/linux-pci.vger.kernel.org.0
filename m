Return-Path: <linux-pci+bounces-12836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB096DD45
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652181F2380E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE9578283;
	Thu,  5 Sep 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ7RVCKh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E438443169;
	Thu,  5 Sep 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548767; cv=none; b=UM3bR+D3fNeJXj2L1pO7/P1niwxFKTmLov7HAWoEflcpBWTjpP5TReCY2gqf82GXMCQ1kDFN9r1rE+y+mQ0BGfUCuwcO2triaXj1PEolDAtohzcF+VvCu9m3fZ4zZFk5bs3TGR3WKvEwEAaTSkvGV0OA9wQ15Sc7MnYMtQkavho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548767; c=relaxed/simple;
	bh=wKMrcMC+PizjREdK8NWSLgrBh6C8Cak5TkypWtYvC1M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tLhdOLdHayg1GTJPJbtydLWqTNpM8rf7Kye3xkPgapDn46pJsNJAFOIcUkeCf7GOOqZxPf+B1tlJc9cVISAHad+O69LFEim1FgFx38efOqEtM97CoXYnOzliiOl9f440Zia7ysyaXCyFdyqVUlEhBN7Zgy/68fgPwVXzimsjc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ7RVCKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70837C4CEC3;
	Thu,  5 Sep 2024 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725548766;
	bh=wKMrcMC+PizjREdK8NWSLgrBh6C8Cak5TkypWtYvC1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eZ7RVCKh6TicVGC73Kha7CA5VSvBAEbtxH1eGCsoexkmCtBlNAnfVWBcP16bLZX3u
	 iqdG9h1Or6J2oTIf32AZNjJe21mRc4Hgrlt6J/1/WzoWcc0tRzRiNm6ffDhFGB2JMg
	 K9HSn6lLt76WyvyEg+2YcWSJgXgdBYn9XdKQFPIe6Jqi5cUNW8XNXa2Tsrq7pWSlWF
	 zYXCZWN6e3VKyHMwXhNZCGLgpVHGwcNYQpkVWLAV3o+r+D/PyG+/w+w5/bJtoOgwi4
	 yMNWnSDhKYyXe2RosSmAh41itKL2CtaAu0Fq1OcSxa/nTaJktmGX8ub88P59gvgqz/
	 yb1xlWEg7VTEw==
Date: Thu, 5 Sep 2024 10:06:04 -0500
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
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20240905150604.GA387441@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822204120.3634-12-wei.huang2@amd.com>

On Thu, Aug 22, 2024 at 03:41:19PM -0500, Wei Huang wrote:
> From: Manoj Panicker <manoj.panicker2@amd.com>
> 
> Implement TPH support in Broadcom BNXT device driver. The driver uses
> TPH functions to retrieve and configure the device's Steering Tags when
> its interrupt affinity is being changed.

> +	/* Register IRQ affinility notifier */

s/affinility/affinity/

