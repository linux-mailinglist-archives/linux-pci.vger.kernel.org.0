Return-Path: <linux-pci+bounces-16469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4D9C458E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B665C2835A1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 19:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D51A76CD;
	Mon, 11 Nov 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPFV1mjS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3731AA7A4
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351981; cv=none; b=lZ5JTSmqXVT91ZtVhrBfUKL6WTceW/tVPagzEeeig3JEPAtks+h9ukewKOG4YlVcsYbi/g5EdmZyUKy0Uw5VwsmoMZwY0kn/YCGUlCtmVDmV+YZF7EnwnRbJ/cikinePt4qlB3LTCEOG+QV56Msfdp2bvQ8EhdV9dYUpi+16cmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351981; c=relaxed/simple;
	bh=WW3rO6Ai0CdmiUyCYY8guRZ+EQuTbQE+OJuptL+toEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pxozdbOl0vQGpxPjQumQ6XCcPoAmpzVKeCGkyLLASvbeYb+KtONuwXUseTC0Suy6oYBppk8VahAG7gaS7DJj09YY/jIZx6liYGyrKRI1Wg+qRY2Qfq804CRNBrY55SWP4w49ANhq9AnOJHHvEiF2LA6T9LVg5vj95HJ5e3P3eVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPFV1mjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A619AC4CECF;
	Mon, 11 Nov 2024 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731351979;
	bh=WW3rO6Ai0CdmiUyCYY8guRZ+EQuTbQE+OJuptL+toEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qPFV1mjSYOO5uq318LJaCl2ov9Ln+CGd49xquWUi9k1Bgoj/uGuOs9S4ZHzRE83JS
	 kw8/LtfMr2UaLODJQxL171yHmM9vskZmgJmiHGaA0bRTWtmuJi879uhOUyGMKVV4AV
	 ieZ3qen3dz4+fqLL2BjY20h/FmxvNnrTAlEKz15t/gNTALaGnqpB+o9sC+oVrhHMTP
	 cOQpD4/d43VBFmEsMXQ/ME/3O2tqQirq+ZWbcyFJ9/pKL26bLwx1YOFLr4LdM+Y/4B
	 Xu18w3GwZE/i+xvRGFSKRQZZ6WNy96DpDqsvr1g1FEC9o2ZqfLoOYsBqpu75yu56gf
	 InqDY5NYKzmHA==
Date: Mon, 11 Nov 2024 13:06:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lukas@wunner.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pci: always clear pme on stop
Message-ID: <20241111190618.GA1808020@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111180659.3321671-1-kbusch@meta.com>

On Mon, Nov 11, 2024 at 10:06:59AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This used to be called unconditionally, but was inadvertently changed to
> call it only once. Restore the previously existing behavior.
> 
> Fixes: 6d6d962a8dc2 ("pci: make pci_stop_dev concurrent safe")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Squashed into 6d6d962a8dc2, thanks!

> ---
>  drivers/pci/remove.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 2e940101ce1bf..36467558c0144 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -31,10 +31,10 @@ static int pci_pwrctl_unregister(struct device *dev, void *data)
>  
>  static void pci_stop_dev(struct pci_dev *dev)
>  {
> +	pci_pme_active(dev, false);
> +
>  	if (!pci_dev_test_and_clear_added(dev))
>  		return;
> -
> -	pci_pme_active(dev, false);
>  	device_for_each_child(dev->dev.parent, dev_of_node(&dev->dev),
>  			      pci_pwrctl_unregister);
>  	device_release_driver(&dev->dev);
> -- 
> 2.43.5
> 

