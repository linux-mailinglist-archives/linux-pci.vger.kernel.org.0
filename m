Return-Path: <linux-pci+bounces-37985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D53BD657E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2389A3B35EF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015791A9F9B;
	Mon, 13 Oct 2025 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y02ovThe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CF2DEA6E
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390296; cv=none; b=mjt9Xs/cIiqzGXz3llxE/0pN1eXHN64bRoaSWeP3seXsl9mEh1hnXWcLzdmsXf6IUK3SS76Z/Nuca2z5xikoAGX5T+PEHtZJIgtgpdZYQQUhjDwE00jLU621YnvXUvQgkm0pwuHj82Ph3SKyRV22mGfmlvI1qCu2/YaH4zu/pTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390296; c=relaxed/simple;
	bh=3ONjSP63/u0x8AdOoa0cSrfqMGyNCxclDohik3JfmjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W83wLIdwVv+K3OO5nmhb5ZZufYzPGK7ee7QIfZg/mTeRysOj/hqEouJvMDvblWpso0rtswSA3Dusal/Sp9QlPg2rr7vB2Dhjm1KBeZNUp/m3u+tAZNDTW/8+o2+2Y4M8vqZnaVdZ/5BAF3m2FqlxpXt88a1bOukt87BdIXlCWFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y02ovThe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ADFC4CEE7;
	Mon, 13 Oct 2025 21:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760390296;
	bh=3ONjSP63/u0x8AdOoa0cSrfqMGyNCxclDohik3JfmjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Y02ovThedtt8POGTv2TOHRZT0T4rf+IZPt0+09OdEaHZgPCRS5DtjQSLscrhCag8L
	 GC++6xsC18zKB1n25o3rwblNMA1V1P7/e4JyEFf67K7gbz/ziDA46AGrSOqMjMNTct
	 jueZNSB2nzKNDbbUoc+a1r/rJ0FZkPOj21COzMpuA0tzIoYnOM/p1CV2+pUE06J+4+
	 kn/is6y+YG3a23kXfu9EIwf8oYkHsq9T8Efig89l88VW9IdMqf65eGDi3CEWw4xYL/
	 7Lnvvu/7o3HXyCYUXyeIcAZF8CEOhXc15PUbAd2c2n4z1iku+RQEnlM/2cHpz3HGTL
	 dQeRp+hxnrKgQ==
Date: Mon, 13 Oct 2025 16:18:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: inochiama@gmail.com, tglx@linutronix.de, bhelgaas@google.com,
	unicorn_wang@outlook.com, linux-pci@vger.kernel.org,
	Genes Lists <lists@sapience.com>, Jens Axboe <axboe@kernel.dk>,
	Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <20251013211815.GA864904@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>

[+cc Gene, Jens, Todd]

On Thu, Oct 02, 2025 at 10:04:17AM -0700, Kenneth Crudup wrote:
> 
> I'm running Linus' master (as of 7f7072574).
> 
> I bisected it to the above named commit (but had to back out ba9d484ed3
> (""PCI/MSI: Remove the conditional parent [un]mask logic") and then
> 727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
> cond_[startup|shutdown]_parent()") first for a clean revert.)
> 
> I have a Dell XPS-9320 laptop, and booting would hang before it switched to
> the xe video driver from the EFI FB driver (not sure if this is a symptom or
> partial cause) and I'd see a message akin to "not being able to set up DP
> tunnels, destroying" as the last thing printed before it hangs. (If it's
> important to see those messages I believe I can force a pstore crash to get
> them where they can be saved off, let me know).

#regzbot introduced: 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device domains")
#regzbot link: https://lore.kernel.org/all/3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com/
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=220658

