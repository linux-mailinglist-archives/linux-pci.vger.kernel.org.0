Return-Path: <linux-pci+bounces-23195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44DA57E63
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 22:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B8B7A66D1
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 21:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92F11A08B1;
	Sat,  8 Mar 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxkgdO5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7A19597F
	for <linux-pci@vger.kernel.org>; Sat,  8 Mar 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468042; cv=none; b=EvgoJ+lozPFzCVSEunxoDOdD2T4P1HAjuSVL+ctRB3E2anDvZjAEE2QWC+b7eM3i1P8fvxFfMAbFbnWNcbl3ya64XCiN25wgDEoksKpQ4n4UxuYcqdgPov0aFt7Bk3+PjvoCjzhyt8voCC0p9jnlt3X+d4G5kn195/qyco3heqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468042; c=relaxed/simple;
	bh=8qBfutaco1FKz7HNRS/JT9gTC8Adls3DlayZ6gj0ruk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VMgzkAACW+ujsAXkBeuP4LdBE6E3HHga1RU8QZQ5XzL5AgAgdl+DTqjz7CxxMx5cutp4g/JSbV2TCGohsiOjxUIjmvM1bw2z38hcY5ATzE9f/Z0u2Gs4EeMfX2EPlxkuXsYDELzxP8mSzOzy+eVN6t4Ow1zsyrWAtB+RBI79sIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxkgdO5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EF0C4CEE0;
	Sat,  8 Mar 2025 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741468042;
	bh=8qBfutaco1FKz7HNRS/JT9gTC8Adls3DlayZ6gj0ruk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DxkgdO5Vxr47M0tbLQGgtcHRiwiTmdmbN1EDZQt8hsYlUuWjdQlEBOudJ3ezuhUHN
	 FTisRuytMEq7CvD5jIIeLdkusB50hxYowqG1NuLNIIqsCC3akpACnscBtOT8kM01hE
	 jnppmHZoL4AwQfVqErcfiBoSahPP+l1S1FgxVTkrMNo2QCyBYnWdeCTMot0bwvL8Qz
	 BjBUqkyPa0lpSccpHvtaGuoie4HsoyY+EIBIYipC7sAZu9nawNaRjSMlc4NEBrxcF7
	 ljbwcT1yCfX1jEMqXiTRGUhqQLRp7M5Dwxr89tSWcGbKENCFrdy47Vn5K6lkM2vfbo
	 d+xsXppgeF9Tw==
Date: Sat, 8 Mar 2025 15:07:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: Check BAR index for validity
Message-ID: <20250308210720.GA469242@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b116a86-d235-4a77-8002-7de0be61e24f@stanley.mountain>

On Sat, Mar 08, 2025 at 01:23:28PM +0300, Dan Carpenter wrote:
> Hello Philipp Stanner,
> 
> Commit ba10e5011d05 ("PCI: Check BAR index for validity") from Mar 4,
> 2025 (linux-next), leads to the following Smatch static checker
> warning:
> 
> 	drivers/pci/devres.c:632 pcim_remove_bar_from_legacy_table()
> 	error: buffer overflow 'legacy_iomap_table' 6 <= 15

Thanks, I dropped this patch for now.

> drivers/pci/devres.c
>     621 static void pcim_remove_bar_from_legacy_table(struct pci_dev *pdev, int bar)
>     622 {
>     623         void __iomem **legacy_iomap_table;
>     624 
>     625         if (!pci_bar_index_is_valid(bar))
> 
> This line used to check PCI_STD_NUM_BARS (6) but now it's checking
> PCI_NUM_RESOURCES (15).
> 
>     626                 return;
>     627 
>     628         legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
>     629         if (!legacy_iomap_table)
>     630                 return;
>     631 
> --> 632         legacy_iomap_table[bar] = NULL;
>                 ^^^^^^^^^^^^^^^^^^^^^^^
> Leading to a buffer overflow.
> 
>     633 }
> 
> regards,
> dan carpenter

