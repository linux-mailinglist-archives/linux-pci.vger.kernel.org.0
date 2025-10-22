Return-Path: <linux-pci+bounces-39036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B101BFD016
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 18:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C71F834481A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0404926ED52;
	Wed, 22 Oct 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqtNhN0B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD126F2B9
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148998; cv=none; b=Rjr9xnBX5Bt0Gq8c8OLqCsMiNAgg3XCGSDDV2JHhVbOros3KN02Gv6MuXthyu4Gfduc3KvLEH1Xc2WOz5EPr/MUyV6AGRTza0H7uMx34F5nrEd3vTQHQH4t/LcxZAaquZY+2KnO9lT3kmxlEsI10xiXEAG9lOVtZt/qHtiluD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148998; c=relaxed/simple;
	bh=BnvvZMhFwTvZJzZlo+B1dRoDTeTaTU3/r/X46TUNx44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bkpQ6oZm1znKzjck9s+HPS4QipGbopx6YWbRNPj0wbbI1EXePHc7sSEWMT7IYZ0xfpcbZ2vMGYuAM7e0EBbuElfUseHdva7CcT3kj07YLHG6MyyH2/4K47oDRRcGnqFEinrJxkgFFg10rkELYwt7zSi6SzpEWqcgcEP17SUb+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqtNhN0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3E5C4CEF7;
	Wed, 22 Oct 2025 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761148997;
	bh=BnvvZMhFwTvZJzZlo+B1dRoDTeTaTU3/r/X46TUNx44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RqtNhN0BiNwBnx52I7c66MTSYORuwHbdl6YK20tP1Jp9Fx0CfURwhLFPtVGQHLsTS
	 y7Qi5hRqm6NQlRDV+VDgOM/DrIQAUonCNYK3b/Ua0fDqwrKR+TrH0AxEr+TMWzd+Sv
	 wEArOzt/wbNxxcQ8R6iQq0VoicqpTIwEYFiD3ioVjkjN+uoxgoSlKK53ns9KFem2aV
	 TDv5KzBq8aUiALrMdBdv+WVTE19em6JlFtYCuzscqTHQlyX58kPMQo/YQEysVuswyZ
	 HOk/e7EL9A/Ymp1Mn712XTVuixHYwqoV0QPnqO1Vle/Bq+xSHO3v4TAcKrt0/qwhDq
	 iq8nGBQTXRJtA==
Date: Wed, 22 Oct 2025 11:03:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Hans Zhang <hans.zhang@cixtech.com>, Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Add L1sub support
Message-ID: <20251022160315.GA1254908@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffe10dbd-1297-45af-86d5-42023820f2c7@rock-chips.com>

On Wed, Oct 22, 2025 at 08:22:39PM +0800, Shawn Lin wrote:
> 在 2025/10/22 星期三 19:52, Hans Zhang 写道:
> > On 10/22/2025 7:35 PM, Shawn Lin wrote:
> > > The driver should set app_clk_req_n(clkreq ready) of
> > > PCIE_CLIENT_POWER reg
> > > to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.

> > > @@ -412,6 +446,8 @@ static int rockchip_pcie_resource_get(struct
> > > platform_device *pdev,
> > >                  return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
> > >                                       "failed to get reset lines\n");
> > > 
> > > +       rockchip->supports_clkreq = of_property_read_bool(pdev-
> > > >dev.of_node, "supports-clkreq");
> > 
> > This line exceeds 80 characters. Can it be like this?
> 
> Thanks for the reivew.
> 
> I think we've been drop this rule[1] for quite a long time :)
> 
> [1]https://www.phoronix.com/news/Linux-Kernel-Deprecates-80-Col
> 
> > rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
> >                            "supports-clkreq");

Yes, but that doesn't mean it's OK for the file to be a mishmash where
most of it fits in 80 but random lines go to 100.  That just makes it
a pain to read.

If going past 80 makes something significantly easier to read, that's
fine, and this file does that occasionally for #defines and the like.
But in this case, wrapping to fit in 80 really doesn't hurt anything.

Bjorn

