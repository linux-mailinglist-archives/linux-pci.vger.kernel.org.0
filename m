Return-Path: <linux-pci+bounces-36910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6EB9CB62
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733E11B259AB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 23:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F2C156F20;
	Wed, 24 Sep 2025 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKnu8Apl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99894611E;
	Wed, 24 Sep 2025 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757687; cv=none; b=ORZVFRVTQ3aiEX83Okv2bi8XtCMmZsw9pUCQs005Y7i5pS498dl2CChSYtRD80Oxj9yqobtPdHUhelVUIPOhmov+nK6wmk7fMKP+/T69LNsOY4mlqmNoj8d0HZdidnp8XVRtZJCj05CLihh+L70s5fjUA78pQgIDRfScyazrp7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757687; c=relaxed/simple;
	bh=KuT5OYotedPvp6otwFAF+gYzvWPXraYRxTdHI1877ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F1HqbHcPbT1B7ks4CB6tKTR6HvvA3PdrObc1jWVKPE6cYSMqJ22sjYSjFvGtASySbqv04jGWcvfsYakr/0BOPlomRNIXr4gSzfDPKLR5Eq0E5Hrm0fHSvwgcNNsKwpzs6nDaH5wp+1rKuGfJo/SXNui42w8eIeDpzOTI7JPVMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKnu8Apl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096ABC4CEE7;
	Wed, 24 Sep 2025 23:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758757687;
	bh=KuT5OYotedPvp6otwFAF+gYzvWPXraYRxTdHI1877ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AKnu8AplhYCS5zzyvD5otEqDjJKSa+MA2V+jI7eG/MdBGPx06drJvtSwVWFWWwE6D
	 v/7LlmCeKgF5mVWL30E+o1CF61+O0Kxz1KpkU39AJaBAbS8a1Cv4xJRSwwjDuVhyiF
	 lGw7UYS5Yo2VRJu5pyAdvuSmGBZHsx+9bQ28j/rUGwQmMRzQwhoNCErGEfMPrh9PUg
	 4FhiMVC3/KEP9xmFOK1EbH6qP07npoWqKzFPLDqmfVc6GQIKVx6ff9KuBkDfSkazFx
	 naZx1eRf3IwdkueX+7ZM5fW8GMuQnDuRqWgx3Hd9LFOQfwX4Li8ddnUG1gnOxuTGS+
	 1XCJ6r83KAL5w==
Date: Wed, 24 Sep 2025 18:48:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 0/2] PCI: Fix bogus resource overlaps
Message-ID: <20250924234805.GA2142481@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924134228.1663-1-ilpo.jarvinen@linux.intel.com>

On Wed, Sep 24, 2025 at 04:42:26PM +0300, Ilpo Järvinen wrote:
> Hi all,
> 
> I noticed a few bogus resource overlaps in logs which occurred for PNP
> resource addresses that collided with large zero-based resources
> (typically IOV resources). It turns out, the problem boils down to not
> marking resources properly with IORESOURCE_UNSET when BAR is read into
> the struct resource.
> 
> I've long wanted to mark resource not within their window with
> IORESOURCE_UNSET as done in patch 2, however, my first attempt to do it
> failed because the bridge window resources were not yet available. I
> assumed the bridge window change would require more extensive changes
> and postponed it, but it turns there were no big complications from it
> (at least so far).
> 
> But things may be more complicated than I know so if you think there's
> a good reason why the filling of bridge resources is delayed to the
> second read, please speak up!
> 
> There are extra notes in both patches under --- line, please check
> them as well.
> 
> This series does not removed the second read of the bridge resources,
> it's probably unnecessary work now but confirming that requires more
> testing and code reading than I currently have time for so just sending
> the obvious fix series out (and adding a TODO entry for myself for
> later).
> 
> Ilpo Järvinen (2):
>   PCI: Setup bridge resources earlier
>   PCI: Resources outside their window must set IORESOURCE_UNSET
> 
>  drivers/pci/probe.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)

Applied to pci/resource for v6.18, thanks!

