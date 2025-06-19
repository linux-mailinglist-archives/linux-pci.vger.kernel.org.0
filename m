Return-Path: <linux-pci+bounces-30176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CBAE021B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E253BAD19
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87118221276;
	Thu, 19 Jun 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfbyxoKV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1E2206B5
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326841; cv=none; b=aum4MjTpGKqEtacEEg2bSudf+AHehFHlciHz/pYZBZHdhk+jDS7khrUIWIhCNkTKgablUzS/4SFqcVv+/MXFb9kanFWusf+arvvvXNaBu5CsBCDY04fbp6EIux+yqRfdCN4dU0BJJa3Hw0yKku3HRVsKqKnFTHEfSqnjreIy0Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326841; c=relaxed/simple;
	bh=3kDiPSCG/YSn0QGi0c8Zra1rZG6c2gbaqXpd8Muw3N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0Sg9qzt0htQjtmlSoR0gvutgAqqkF/jWqg9k8gE4BxEYEEW/21/KLhRrrqXz1NCJreZeXoeet7NVJn6bwouGV5yObWVLYbjr3yHVd0msmG2bquo2MltRuesPLqXBPrsO0/bnyhk5IgFwKeAdlYJRXQSVkJqdbz3nL/AHp3iDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfbyxoKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98164C4CEEA;
	Thu, 19 Jun 2025 09:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750326840;
	bh=3kDiPSCG/YSn0QGi0c8Zra1rZG6c2gbaqXpd8Muw3N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfbyxoKV+C8IW2ITf7tcRxFv7ovSQRozIwhrvYVvfzncgmpFzwrsoijrTidHx4w9J
	 ykg1odCt52H0hrPNksfyqDcR5qyGz+Me8RJQtR5m46Z6S4RbvGSWJBzfwrG7wZMGXB
	 l4M6K9pk9Dea2wuiMRPLDdwkrnQs8j/FNz9dXUYguxKlUs5JDMzE9N/6CElXBx9c+9
	 tABKRJA7WLRWCWgQZh/R9KmHu9LGFLVCc2cygWVM/uneYxsVAS3wyE3GwZhFmkK3zO
	 KZUvm4TyaXfpzqGxHyWu1RHZpVd01N6aU8FvaRxGtT1s5J1Fq3JnRK0JepYrn/6O4r
	 s81N+V/2KSkDQ==
Date: Thu, 19 Jun 2025 11:53:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Delay link training after hot reset
 in EP mode
Message-ID: <aFPeMzLxbiXEOQCt@ryzen>
References: <aFLHYfs1iDgwMdcp@ryzen>
 <20250618195959.GA1207191@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618195959.GA1207191@bhelgaas>

On Wed, Jun 18, 2025 at 02:59:59PM -0500, Bjorn Helgaas wrote:
> > 
> > Well, because currently, we do NOT delay link training, and everything
> > works as expected.
> > 
> > Most likely we are just lucky, because dw_pcie_ep_linkdown() calls
> > dw_pcie_ep_init_non_sticky_registers(), which is quite a short function.
> 
> I'm just making the point that IIUC there's a race between link
> training and any DBI accesses done by
> dw_pcie_ep_init_non_sticky_registers() and potentially EPF callbacks,
> and the time those paths take is immaterial.
> 
> If this is indeed a race and this patch is the fix, I think it's
> misleading to describe it as "this path might take a long time and
> lose the race."  We have to assume arbitrary delays can be added to
> either path, so we can never rely on a path being "fast enough" to
> avoid the race.

I agree 100%.

When writing the commit message, we simply wanted to be transparent that we
have not observed the problem that this fix (theoretical fix?) is solving.

However, from reading the TRM (trust me, a lot of hours...), we are certain
that this feature DLY2_EN + DLY2_DONE was implemented such that there would
not be a race between link training and reinitializing registers via the DBI.


> 
> Is the following basically what we're doing?
> 
>   Set PCIE_LTSSM_APP_DLY2_EN so the controller never automatically
>   trains the link after a link-down interrupt.  That way any DBI
>   updates done in the dw_pcie_ep_linkdown() path will happen while the
>   link is still down.  Then allow link training by setting
>   PCIE_LTSSM_APP_DLY2_DONE.

Yes.

s/link-down interrupt/link-down or hot reset interrupt/

When Hot Reset or Link-down reset occurs, controller will assert
smlh_req_rst_not as an early warning. This warning is an interrupt bit in
Client Register group(link_req_rst_not_int).

(It is the same IRQ, so we can't tell the difference, at least not from
only looking at the IRQ status.)


> 
> We don't set PCIE_LTSSM_APP_DLY2_DONE anywhere in the initial probe
> path.  Obviously the link must train in that case, so I guess
> PCIE_LTSSM_APP_DLY2_EN only applies to the case of link state
> transition from link-up to link-down?

Yes.

The register description for dly2_en:
Set "1" to enable delaying the link training after Hot Reset.

The register description for dly2_done:
Set "1" to end the delaying of the link training after Hot Reset.


Kind regards,
Niklas

