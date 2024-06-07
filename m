Return-Path: <linux-pci+bounces-8470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC3900A9C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 18:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142F11F2117F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402DF195804;
	Fri,  7 Jun 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDGgMQ62"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E66D1B9;
	Fri,  7 Jun 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778535; cv=none; b=aHRaDAKs/Wok+GGT6OHX1S1yOZNFvyd+B6MLXwjPhZ7X/9hMLPoaMBivEQmRFAC+8rwQuM5gLunNt/QLKMjK1D0HP+Pouwszy3pTO5mI/zAqGLgIOv/X9YcpsRsdjiyfkwGbUtXSNYpY+++6sdLqAiuS5ZvIpSMv93C8OaKetXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778535; c=relaxed/simple;
	bh=17Rm0c56+lqAAAeOiSXB/h23mSa17FdYfWjscUEGqcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EG925sQ010dSbh/S/uGWwViCg9P0E+CWxyTjz46EY3e3QCdvxM0WMwQmDGvkrrEpspyvWnz8gIP+R0RnsXEtfLRFx4IvLq81g+GPdZo5VFyya8zreJlY1iRNBWBSXt8lcNfZBiw24LebQJJCf9pR4o0gE4/cSmDcljW91pzYJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDGgMQ62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE08C2BBFC;
	Fri,  7 Jun 2024 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717778534;
	bh=17Rm0c56+lqAAAeOiSXB/h23mSa17FdYfWjscUEGqcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EDGgMQ62bpIql3FU15A/tEqWLIIPML4B4w3AC2fWSjpVnGspn8jj9Js11rnE0kbce
	 UZIXLzBJR+sSv/0qxeqfZvQNAQInBtwCKEpK4ckDKUXsdI83FNK+Yx34X+YGZMNC2I
	 4VU6NNT5L2lKwGhp2m/oWrr5i9ACfm8+LmeoMHlHePUywEqHx2NHMNR69KSoZEn5rI
	 J247YJXE5f360bADMtm8mWW5OkCcyxZojmYDCZJ0jrC/+kRMi6Co0tdrPa7ZS3endQ
	 rKKXO44/FcuPNJDaeC3FdiBcCaWzKdFwRBZCR4ngbp5UqO0TU578oyqmtxfGooVH7s
	 4zZULefLB1siw==
Date: Fri, 7 Jun 2024 11:42:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH V2 2/9] PCI: Add TPH related register definition
Message-ID: <20240607164212.GA850739@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531213841.3246055-3-wei.huang2@amd.com>

On Fri, May 31, 2024 at 04:38:34PM -0500, Wei Huang wrote:
> Linux has some basic, but incomplete, definition for the TPH Requester
> capability registers. Also the control registers of TPH Requester and
> the TPH Completer are missing. This patch adds all required definitions
> to support TPH enablement.

s/This patch adds/Add/

> +#define PCI_EXP_DEVCAP2_TPH_COMP_SHIFT		12
> +#define PCI_EXP_DEVCAP2_TPH_COMP_NONE		0x0 /* None */
> +#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY	0x1 /* TPH only */
> +#define PCI_EXP_DEVCAP2_TPH_COMP_TPH_AND_EXT	0x3 /* TPH and Extended TPH */

Drop the _SHIFT definitions and use FIELD_GET() and FIELD_PREP()
instead.

>  /* TPH Requester */
>  #define PCI_TPH_CAP		4	/* capability register */
> +#define  PCI_TPH_CAP_NO_ST	0x1	/* no ST mode supported */
> +#define  PCI_TPH_CAP_NO_ST_SHIFT	0x0	/* no ST mode supported shift */

Drop _SHIFT and show full register width for PCI_TPH_CAP_NO_ST, e.g.,

  #define  PCI_TPH_CAP_NO_ST 0x00000001

The existing PCI_TPH_CAP_* definitions don't follow that convention,
but the rest of the file does, and this should match.

