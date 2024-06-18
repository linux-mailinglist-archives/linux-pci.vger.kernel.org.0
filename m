Return-Path: <linux-pci+bounces-8920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B394390D8D7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 18:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9A51F26064
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07622152164;
	Tue, 18 Jun 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/5zDuIk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63F8157487
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718727155; cv=none; b=p+MJQGUUkH+TVI1zDDeVEx8sRu5a+oH5nUu8yxuvVrubAHgRJU1aXn5H5L9iiWKB2+aVPYn7ocIckcaA2BoL6wEktvAZYwEqCRUqOXwrZGbYnMOKeAckBYOmcoRbpJLKxgBHZRJrBumRKZ5uNdcgkM+/AFhor1L+OqOaDN9Huow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718727155; c=relaxed/simple;
	bh=+/Gak2vx9dqZ+RAE4zTHh+tx5Oo5b3Skt6vFySW+E/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRFNHzzM6OX72D/UvHkLkr4izvirT+ZnyoBKMdsROGdJ8pVP7SBWaxYIyFTmOSk7CMEbNuJXSVRDjEX2Fsi+VX6V46L47VBR9mEr4a8VqS8cbpYPJ6MccuAuo1yvM9H+RD2r8jDs33ZRVeUyRpC9EJblRWTTBNHv+EHdMXr1j7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/5zDuIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED4EC4AF48;
	Tue, 18 Jun 2024 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718727155;
	bh=+/Gak2vx9dqZ+RAE4zTHh+tx5Oo5b3Skt6vFySW+E/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/5zDuIkqe1yOXY2KsH7TXxo2iSTA/tofNjcFCY7kzAO9OX91oyQpFNTGs0Setu16
	 nz+hlaD0wIaelM+zG/uSQ8YR3zr6w7kxwfOX1JSvTx8kid5ltHD83mD9vMl71YMOpp
	 eKgKoGQ0x+7MOl1chg6rAJ5BFL1qAnshnrxNM185jBTHpp/JbCwZpRhbJPlEoQzp7E
	 hT3hkHAFpjQheTBAuMyjb9XYlcMoC3V0D7rpkbo/hB4NO0nWkE4SZL8bYsfoaHCFnG
	 L33Fm7XeZQAfdJqWD6VCVSEd6q4utTBCTeSJziOz0jKxN5CV5q3Phat3A2a8yjo2QX
	 1s+8NZyl7reaA==
Date: Tue, 18 Jun 2024 10:12:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Fix use-after-free on concurrent DPC and
 hot-removal
Message-ID: <ZnGx8PN6CWGmUC6J@kbusch-mbp.dhcp.thefacebook.com>
References: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4bcd4116fd94f592f2bf2749f168099c480ddf.1718707743.git.lukas@wunner.de>

On Tue, Jun 18, 2024 at 12:54:55PM +0200, Lukas Wunner wrote:
> However starting with v6.3, pci_bridge_wait_for_secondary_bus() is also
> called on a DPC event.  Commit 53b54ad074de ("PCI/DPC: Await readiness
> of secondary bus after reset"), which introduced that, failed to
> appreciate that pci_bridge_wait_for_secondary_bus() now needs to hold a
> reference on the child device because dpc_handler() and pciehp may
> indeed run concurrently.  The commit was backported to v5.10+ stable
> kernels, so that's the oldest one affected.

Caution on applying this to 5.10 and 5.15 stable branches: they don't
have the fancy "__free" cleanup you're using here. The newer active
stables are okay, though.

>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
>  {
> -	struct pci_dev *child;
> +	struct pci_dev *child __free(pci_dev_put) = NULL;
>  	int delay;

