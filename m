Return-Path: <linux-pci+bounces-22202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB36DA421B0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6601F3A84FE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B19248885;
	Mon, 24 Feb 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GESaeklG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B922192E6;
	Mon, 24 Feb 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404330; cv=none; b=YS9d74YJgFFf/PllC0/8DrgokjS1GfajxsKmA5McDetCehA6eQOV6CuYaQR/niFFECmgVQjcIuLDyYp+6P8LCIMO9ub4krRCuFqC9pxoHWfcGoqsVO2oBBJZrIr6nsYQCh26Xnjn2boHF5X2f+SXC/13SUoyPKudrTmtwEqNzeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404330; c=relaxed/simple;
	bh=07TDAHcupyN1ro5la8Us1Uyo2VMN2zQJwcUW/RkR67k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHgUpZrIeLk8SZXVoG/vvjb6og+P7HkHZc1LmdLQKPtAKt4k5lfp9WV9jFzfrC4nHY7sMhKqoU5hUvMPvSedIs7tsBtcWSkMoCupVtbcZfbaoXRm0+jfFhDb9mvb753j7332Jv6/ZrIlPLE8Hagr0NBhnYzl9ePB02/DynhOgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GESaeklG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D19C4CED6;
	Mon, 24 Feb 2025 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740404329;
	bh=07TDAHcupyN1ro5la8Us1Uyo2VMN2zQJwcUW/RkR67k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GESaeklGA3Eh3UlkTSSEMsagsxmePLdXaqAFgxkVBBPCC8q8QMsYBr46B2GYmLd/z
	 O5Ztuf1K/BuKESV5EvUEBEi1r35nMT+qzAWXq+TT8i272OqagA5Y9KP7LuKN+jNRoX
	 tNyNbuHCKxTpQd2QYNLQk3WUHZgV0lHP3BJfvtOgeLhhNvrmjzX0nbQJgqRyhmqWLx
	 mRrql3W0fcSCcQ7lwex0HUDo6D8vdO7lVdD0oXhQtBSzDs9UEZME2K3HUWULfY3E8q
	 4Xk1bFNIItJ3qzTEr5C+Cr9EaLPb2dt25L3kcFmc/x0pcnFSPNyV2MBa2+9A0/BPH2
	 DnHs4AxfoHfBw==
Date: Mon, 24 Feb 2025 14:38:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	jingoohan1@gmail.com
Subject: Re: [PATCH v14 0/3] Add support for AMD MDB IP as Root Port
Message-ID: <Z7x2ZLOiNK4cBCp2@ryzen>
References: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224073117.767210-1-thippeswamy.havalige@amd.com>

On Mon, Feb 24, 2025 at 01:01:14PM +0530, Thippeswamy Havalige wrote:
> This series of patch add support for AMD MDB IP as Root Port.
> 
> The AMD MDB IP support's 32 bit and 64bit BAR's at Gen5 speed.

Which PCIe controller does not support 64-bit BARs?

Seems like quite a random sentence IMO.


> As Root Port it supports MSI and legacy interrupts.

You are not submitting Endpoint mode support for your controller,
so it seems a bit weird to talk about "As Root Port ...".

Your patch only includes Root Complex mode, and makes no reference
to Endpoint mode anywhere, so perhaps just state that the controller
supports MSI and INTx interrupts.


Kind regards,
Niklas

