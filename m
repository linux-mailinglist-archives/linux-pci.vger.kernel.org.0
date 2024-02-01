Return-Path: <linux-pci+bounces-2903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085D0844F73
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 04:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B603C281D21
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 03:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1DA1DFF3;
	Thu,  1 Feb 2024 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4pUMM2D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A773A1C1
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757256; cv=none; b=HgIZU3AuGO0NTct8EwPFen0B/tywlAqEfeMPEu5ik0TVVMjie11p3c/52n8s3DUCyfIbOrMiKZMMpUwQD4P9EU6wHgdWvuMrALjJBilRcuRsPNRdrau8HN7+eohoDF3XNmLkZkKN8EktYVUyEnuem+8bzFkwa0FOSh/fmghXhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757256; c=relaxed/simple;
	bh=nntoxDzs0YHgXXuhkHCqdjhCmELI2dYHtp7/0A8OvOs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HWKqZDH59P3d5fl7Apiy1DdDXJ7QULuTb1rPbcODmPJBcDO7pP+0n1ooyeGPo+1wzXQPQNAStkAPG9jij3uFWF6yX3848UViXBF6NQ9q7z3RS5piCnmCCEMZzEdg3gtRqy47D9hzFCZW/dXHhThlNnN3N7l3CexOj9qob2fVml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4pUMM2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBC3C433F1;
	Thu,  1 Feb 2024 03:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706757255;
	bh=nntoxDzs0YHgXXuhkHCqdjhCmELI2dYHtp7/0A8OvOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a4pUMM2DyolI3Ba+yXv6OXtLg6oGktCApPG+DNKQQ4RZQcehVHFideo+6i7kYBuJ2
	 RqO/6uNG6MxaG2Oad/b41OKedU0Gyb0N/8G56JXzGbPw2Fy/sovr+RL34vvNu85x1o
	 6HRPfbf642VP91dYgzp+Ga3W7NRzWHlFujU6UVkuNgg8lUxh03gZPLv20EZaNbtraO
	 oWYaltGDhJvyvjhQAsvk2qarCI471iqWuT9Rw9zykKP1/b804rsexajvDcUzd9sdKo
	 /C0nErIt06MF6XSuZ7OsMheA7QUoyTQLE9kqrXqBGeCkSSXpDrTuA1EU1Fe8Ou9nKM
	 vr4gkWS8I/IWQ==
Date: Wed, 31 Jan 2024 21:14:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Chuanhua Lei <lchuanhua@maxlinear.com>
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240201031413.GA614954@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131234817.GA607976@bhelgaas>

[+cc Chuanhua Lei, intel-gw maintainer, sorry I forgot this!]

On Wed, Jan 31, 2024 at 05:48:17PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > In dw_pcie_host_init() regardless of whether the link has been
> > > started or not, the code waits for the link to come up. Even in
> > > cases where start_link() is not defined the code ends up spinning
> > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > gets called during probe, this one second loop for each pcie
> > > interface instance ends up extending the boot time.
> > 
> > Which platform you are working on? Is that upstreamed? You should mention the
> > specific platform where you are observing the issue.
> > 
> > Right now, intel-gw and designware-plat are the only drivers not
> > defining that callback. First one definitely needs a fixup and I do
> > not know how the latter works.
> 
> What fixup do you have in mind for intel-gw?
> 
> It looks a little strange to me because it duplicates
> dw_pcie_setup_rc() and dw_pcie_wait_for_link(): dw_pcie_host_init()
> calls them first via pp->ops->init(), and then calls them a second
> time directly:
> 
>   struct dw_pcie_host_ops intel_pcie_dw_ops = {
>     .init = intel_pcie_rc_init
>   }
> 
>   intel_pcie_probe
>     pp->ops = &intel_pcie_dw_ops
>     dw_pcie_host_init(pp)
>       if (pp->ops->init)
>       pp->ops->init
>         intel_pcie_rc_init
>           intel_pcie_host_setup
>             dw_pcie_setup_rc                        # <--
>             dw_pcie_wait_for_link                   # <--
>       dw_pcie_setup_rc                              # <--
>       dw_pcie_wait_for_link                         # <--
> 
> Is that what you're thinking?
> 
> Bjorn

