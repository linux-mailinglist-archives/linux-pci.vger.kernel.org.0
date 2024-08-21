Return-Path: <linux-pci+bounces-11912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE695924C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 03:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2736B1C213F7
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 01:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED1142A87;
	Wed, 21 Aug 2024 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/eQUfMX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2E200A0;
	Wed, 21 Aug 2024 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204762; cv=none; b=N7iAJp2zWAA+kBRkpGzQJAmJizENBKWmztNkLcwDw6FgjF8quTxYn+Jn7hLyOL6jhro3q5Bmd8jEwrMXe8xlLLZCo1IRx985dNxJdBheNHBVnlJwZkmJlApRw8P3rgvKow4BVxBK7l6JD/2GPz+fFRe4L4fq6o5ULVcBsQ9fBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204762; c=relaxed/simple;
	bh=9978yQ2Cn9Hs9YGNJLKBmMPFNja2e+lE8eiTOBaOeXM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eoxDqEngL1H4udrszWgHnmRdtu54vxtEzGZ21I0d21KXqNipWIqcWLK3np4mafLciDE9pbEAR03smuZ6TZiX3OuElHPbYjP3keVlJKIdc8wNtXCfkyDXFTnH/BROedTf4LyDsY01TEeQHohirq8EfR9lu9DAasPrLUAW1E1AWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/eQUfMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5945C4AF0E;
	Wed, 21 Aug 2024 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724204762;
	bh=9978yQ2Cn9Hs9YGNJLKBmMPFNja2e+lE8eiTOBaOeXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=H/eQUfMXEC3z7NNwvZvUkWfmBS7G3yEWEGQT2BIVknuZjS+wUUUBR0bnjaXMke5nx
	 7IUZeY9YlwDKUlGwYBlMgf6T9xwf8KLaBA0ksLgUgCqj2GKMOd6m9YFXbF4CPURZvO
	 hVUAkMdgFwYwUkNZI2LuUANq8ZVBWvFkhGlkayZrf0TJte44FhvP4vhHFv2b5LmrxX
	 VPLtq/OefyEnEeD10sGfANuetDt5XwTjTv02gu2uah10EILtmaaWhhOd/U0tkhVT5W
	 /HeWgDOMfLFRa+BSp7l+SFgq8lmc438+pSLlqg3hASE1qlDKiP4bNVD7sJyEBDPkgG
	 s7naEQbnSYcbw==
Date: Tue, 20 Aug 2024 20:45:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240821014559.GA236134@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-pci-bridge-d3-v5-3-2426dd9e8e27@linaro.org>

On Fri, Aug 02, 2024 at 11:25:02AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Currently, there is no proper distinction between D3Hot and D3Cold while
> handling the power management for PCI bridges. For instance,
> pci_bridge_d3_allowed() API decides whether it is allowed to put the
> bridge in D3, but it doesn't explicitly specify whether D3Hot or D3Cold
> is allowed in a scenario. This often leads to confusion and may be prone
> to errors.
> 
> So let's split the D3Hot and D3Cold handling where possible. The current
> pci_bridge_d3_allowed() API is now split into pci_bridge_d3hot_allowed()
> and pci_bridge_d3cold_allowed() APIs and used in relevant places.

s/So let's split/Split/

> Also, pci_bridge_d3_update() API is now renamed to
> pci_bridge_d3cold_update() since it was only used to check the possibility
> of D3Cold.
> 
> Note that it is assumed that only D3Hot needs to be checked while
> transitioning the bridge during runtime PM and D3Cold in other places. In
> the ACPI case, wakeup is now only enabled if both D3Hot and D3Cold are
> allowed for the bridge.
> 
> Still, there are places where just 'd3' is used opaquely, but those are
> hard to distinguish, hence left for future cleanups.

The spec does use "D3Hot/D3Cold" (with Hot/Cold capitalized and
subscripted), but most Linux doc and comments use "D3hot" and
"D3cold", so I think we should stick with the Linux convention (it's
not 100%, but it's a pretty big majority).

> -	if (pci_dev->bridge_d3_allowed)
> +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)

Much of this patch is renames that could be easily reviewed.  But
there are a few things like this that are not simple renames.  Can you
split out these non-rename things to their own patch(es) with their
own explanations?

Bjorn

