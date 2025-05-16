Return-Path: <linux-pci+bounces-27873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219BAB9F24
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003011C01719
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480FA189906;
	Fri, 16 May 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsLIR5Lc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D215747D;
	Fri, 16 May 2025 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407460; cv=none; b=m09uy5tYvVEjW/IWA24Mxyz01YLWcpjMlfhNz4FFcWVPHsf5qaKWKMQMD/5XUAIyaZrDoxLAzAYRVKesEvmuMcNrnzPdObHUcbvFkn89Jj5iDpf3Xp4L0KKG3vdlad52HRYCcarSiRBIYNmrCLrkT0z6s3qPvrPH6e3z3LfYAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407460; c=relaxed/simple;
	bh=eomaWBTgutHIQD5q6uqB48v7pntyLBxZ13+KCALYF9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBdqf9AgubUTL3cPR/yNNljQIh5XHsnJbtfq27lzmGcb3YcA/RbmezLa5IQGcIx6Iadcwmv05hRCIUdQQHtXF6uxfvvJdurVn6FGlCwfYuXAS1HOQPsTHouE+gIvzJvwCCKkfxmMmCwK6EnGqK6wTlUjAFCEOF0OsbZAhJsT0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsLIR5Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680E0C4CEE4;
	Fri, 16 May 2025 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747407459;
	bh=eomaWBTgutHIQD5q6uqB48v7pntyLBxZ13+KCALYF9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsLIR5Lc4ZzhzBNsZevQwVvKKiPGTK+eEu8vvPJxaSYqLZrTsh3muWBs/7EqNcHPf
	 zKyteGmOTx4BuHGuu9XhXtG9+FyfJe0GlhsT8QotHKktniz4rCvD8Q+fojOlDJq5pB
	 Tq2hbSqwDumXfR0N0pC1KBt/n2BZYtD5nLsbq7bUO/Z8PSc9gDMJfdwA2PxGq2fidj
	 7161b438tQoU4C50b17uYsNdcAbDZjPsLcfiF7TYLejnfnsarMh08R/6EE6extz1IB
	 dp0RpHek87KPghbsALLapVqJ7/hW8in1f+qLiuidN05jf/vi7sKOL9o1fEoDZNuEGR
	 Znzk7Op6JYEcw==
Date: Fri, 16 May 2025 15:57:34 +0100
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, jingoohan1@gmail.com, 
	Hans Zhang <18255117159@163.com>, robh@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
Message-ID: <wwhxwxibc4ogr62pxpjjrhnofltaqptuearba6lxylfdr2ng35@fkexvg2ydlpp>
References: <20250510160710.392122-1-18255117159@163.com>
 <174712882946.9059.1080501209546808704.b4-ty@linaro.org>
 <aCb8wauW4h85F8YS@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aCb8wauW4h85F8YS@ryzen>

On Fri, May 16, 2025 at 10:52:17AM +0200, Niklas Cassel wrote:
> Hello Mani,
> 
> On Tue, May 13, 2025 at 10:33:59AM +0100, Manivannan Sadhasivam wrote:
> > 
> > On Sun, 11 May 2025 00:07:07 +0800, Hans Zhang wrote:
> > > 1. PCI: dwc: Standardize link status check to return bool.
> > > 2. PCI: mobiveil: Refactor link status check.
> > > 3. PCI: cadence: Simplify j721e link status check.
> > > 
> > 
> > Applied, thanks!
> > 
> > [1/3] PCI: dwc: Standardize link status check to return bool
> >       commit: f46bfb1d3c6a601caad90eb3c11a1e1e17cccb1a
> > [2/3] PCI: mobiveil: Refactor link status check
> >       commit: 0a9d6a3d0fd1650b9ee00bc8150828e19cadaf23
> > [3/3] PCI: cadence: Simplify j721e link status check
> >       commit: 1a176b25f5d6f00c6c44729c006379b9a6dbc703
> > 
> 
> This was all applied to the dw-rockchip branch.
> 
> Was that intentional?

Yes it was.

> 
> My guess is that perhaps you thought that
> "PCI: dwc: Standardize link status check to return bool"
> was going to conflict with Hans's other commit:
> 5e5a3bf48eed ("PCI: dw-rockchip: Use rockchip_pcie_link_up() to check link
> up instead of open coding")
> 
> but at least from looking at the diff, they don't seem to touch the same
> lines, but perhaps you got a conflict anyway?
> 

I think I got a conflict and I saw that the cover letter mentioned dw-rockchip
as a dependency, so I applied to that branch.

> 
> 
> mobiveil and cadence patches seem unrelated to dw-rockchip
> (unrelated to DWC even).
> 
> If it was intentional, all is good, but perhaps the branch
> should have a more generic name, rather than dw-rockchip,
> especially now when the reset-slot and qcom-reset slot patches
> are also on the same branch.
> 

Yeah, I agree. Since there are 3 series on this branch, we need to pick a smart
name ;) I will do so. Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

