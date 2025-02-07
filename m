Return-Path: <linux-pci+bounces-20887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01FDA2C30D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B31C1885F5F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6A1E0DE5;
	Fri,  7 Feb 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHvt6snT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07D1DFE04;
	Fri,  7 Feb 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738932554; cv=none; b=CaTygLo+8DXzB4bFzxcXnfrI7DkkG1PZ+yTwffExN5q6CNLj+fp9GRdg7USgg39P7zsAbLGan49wyrvsdnsZiz4Q7apWD6AOHO1ZZfw1jKLKbQu4oU5RyfJBATULWpozv8KGEPZ1JURsXALLWlWXDyx7rdcCKorYqkipDSjEKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738932554; c=relaxed/simple;
	bh=rewFqSNHRICHMfqkDxgVEbgGirdxnhjcREMT1ec102k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fbXioQtKfxLjTXPDtX0H2G1mqTuo4xnok2t/menyT+iksmFjhNmbGnnalKqjl2evdunnOnR16XOzXH68UBLDAK+fHL8dGeoy6ktRibbQhkiisQA1fFZ083AHBIqn4kjnz60re+j2011LXUESwDh+WU9yIEZNQP2YAhQ68OuRwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHvt6snT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA43C4CED1;
	Fri,  7 Feb 2025 12:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738932553;
	bh=rewFqSNHRICHMfqkDxgVEbgGirdxnhjcREMT1ec102k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jHvt6snT8i5LVK0+zxXKmikH/dFAT8bh55vD4J+GS0yGZY9e1An4XHhqrV/KG7Mn3
	 fZ3aPT8L9xIjwyktOU2tSf4mYly9Z6RhMW+k7C06amDzCUwio1BgcidR926HKam6HG
	 npEVrC2x9DWWOfF8cYLrEu/X1JbwU4xZRGNzDgt0LNbupTSowKYR+WXJn0U6Ws9uHV
	 5Txb88152dscL/tPpw/cUIiu2afCvOwNBKloajCBMShon3DO+6QQVJQO6RR/bp+mSq
	 BYLxAEs1AVUA9edvNm1hDGwD3LA2LRdaroXEBTB7jsJUk7Iz9JCOI4fR0dU1z5a/r5
	 LjzzXjZAGLdiQ==
Date: Fri, 7 Feb 2025 13:49:10 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: Remove deprecated PCI API calls
In-Reply-To: <20250128101156.77868-2-phasta@kernel.org>
Message-ID: <96151032-84p2-17q9-3997-sn60r0n13sp9@xreary.bet>
References: <20250128101156.77868-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Jan 2025, Philipp Stanner wrote:

> intel-thc-hid reintroduced the already deprecated PCI API functions
> 
> 	pcim_iomap_table(),
> 	pcim_iomap_regions(),
> 	pcim_iounmap_regions(),
> 
> none of which should be used anymore.
> 
> Furthermore, calling managed (pcim_*) functions in remove() and probe()
> for cleanup is not necessary, since the managed functions clean up
> automatically.
> 
> Replace / remove the deprecated functions.
> 
> Fixes: 61bb2714dc3a1 ("HID: intel-thc-hid: intel-quicki2c: Add THC QuickI2C driver skeleton")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Hi,
> 
> I'm trying to remove this API since a year. Please pay attention to the
> docstrings in PCI which mark certain functions as deprecated.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


