Return-Path: <linux-pci+bounces-43515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B24BACD5AAC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 11:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBCA330562D4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 10:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17766329C59;
	Mon, 22 Dec 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VulLewll"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E8329C53
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766400137; cv=none; b=CeXbhBuyIvJ/w1lFtJTw4K+i9DtBk1mh6sXrmnRPJqyuLRSF9Byf2vwRL5C1S2gRTS0cWj3f2AGuRMAl5o5/R8ub0TMZWVwHNaV60TprDHQ75CnDSuB8hFoe6KIogKkEs5jKxpM8i5q6Jau54ehi27M5lye8eYgHuSy5YdODqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766400137; c=relaxed/simple;
	bh=ZEsGApPv/vdLivZORSqzLp/x7zWed9/k6NxI5IlpY5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyiTSfs+WwEyK35pjCOKF6mk/0t8km3xoOjHxhOkPidGCfKn0jj5FAe+NEw0FNlMo2CcsYGdzYs4+QNB7JNG/rDfv0AcnHCzzHv6aih8jUeuQ5lBecmrzh0hsiCFbfYFFar+SsVTYLxOFDH4ulIoehAFClDUbEKjP0zq+cUQAY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VulLewll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA65AC4CEF1;
	Mon, 22 Dec 2025 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766400136;
	bh=ZEsGApPv/vdLivZORSqzLp/x7zWed9/k6NxI5IlpY5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VulLewllIeGtaC+xL7kBTH6N5GALFB44hP3mCQOXyGA2AIdR9kgRRpWTs/7BDuIuS
	 vuqAC3aoowHAbbAkWBQfzPPZr0pvBdScCDN1qHqJsmEJWOWjqcKMaNgcvHPOFrYa/G
	 zL27mdTdFszLr/OgxIQ88UegQzrQeE4seVAM1ZaO6yR6TqM8YMjzgX8cdvjp8h806Z
	 Jq4EXIlShgtzKH/j/by5d5pFo0DnxtrjrDJQ6zjObGtNpFR3Vhm1yedzKqFgrACPpy
	 aa6+f8VGCUxmY3R0SQc6C5u9DqFXK4xSGNaUAQV6PzDgFjP6UZ1lmt9E2kXdlemeuw
	 1tJSYbmkgcxQw==
Date: Mon, 22 Dec 2025 11:42:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
Message-ID: <aUkggy7QJGWMzkE3@ryzen>
References: <20251210071358.2267494-2-cassel@kernel.org>
 <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com>
 <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5mbvhnummcegksauc7kyb2442ao27dwc63gyryetuvxojnxfj@a67nopel52tx>

On Mon, Dec 22, 2025 at 03:28:30PM +0530, Manivannan Sadhasivam wrote:
> > This is wrong, in MSIX each vector can give you different address, you can't
> > expect same address for
> > all the vectors in MSIX table. In ARM based system you might see only single
> > address for X86 this will
> > change.
> > 
> > And also we see in MSIX the address are getting updated at runtime with x86
> > windows host machines.
> > 
> 
> The spec allows changing the MSI-X address/data pair when the corresponding
> vector is *masked*, and classifies the behavior as undefined if address/data
> pair gets changed while the vector is *unmasked*.

MSI also supports masking as an optional feature.

Too bad that the spec just mentions that the cached MSI-X address/data is
allowed to be changed when masked, but does not mention the same for MSI.


> 
> If we were to enable caching, then we need to take note of the above point. But
> the EP implementation doesn't get any notification when the vector gets
> masked/unmasked dynamically, which makes it trickier to implement the caching in
> SW.
> 
> > Use the MSIX doorbell method which will not use iATU at all,
> > dw_pcie_ep_raise_msix_irq_doorbell().
> > 
> 
> I think this is the safe bet since this feature doesn't seem like an optional
> one.
> 
> Niklas, if you can just fix MSI in this patch and leave out MSI-X for the vendor
> drivers to transition to doorbell, I'm OK to merge it. Otherwise, I don't know
> how you can reliably fix MSI-X generation with AXI slave interface.

Sounds like a plan.


Kind regards,
Niklas

