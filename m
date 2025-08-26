Return-Path: <linux-pci+bounces-34783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158FCB372CD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E5A3B8B92
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AAA2D1F40;
	Tue, 26 Aug 2025 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/ImNijk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1947931A565;
	Tue, 26 Aug 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234977; cv=none; b=XWOLx15naNlVmROS5Rk8kfB7S/aTV8EHnwdTbGQ7IR+bJ6sxukHXIxFogrooz8js98AU+UgrPwtweTdzJTpLRiKC9u09rlAMLB9pQVol7P3aBIvkHVdkPhi8ECFqIwVcvYzpEbmOYJxAaWwNB3SmC6mzxhHzLI0x2VmCTrRlnDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234977; c=relaxed/simple;
	bh=HoeGDszNuFW+IfkSD9Q1Huy9h2iGCbPh+5egsU7hGh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=O7zbpN5KURCKLGI+anKBMYoXCv3rIYTkh2t1IO6zAUhodu0Tgrk9w6RjCqyk2yLoOO3V+5uzHJ4It1K2qLgtsoQPayWx1ixBs4Rciht5Ng5YS/7HebzU278JpZ1kfHIrk3Xd+MpYQLBduPtB3M9cA8Nj/UoWrgJdncU6j7Gi1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/ImNijk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840E1C4CEF1;
	Tue, 26 Aug 2025 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756234976;
	bh=HoeGDszNuFW+IfkSD9Q1Huy9h2iGCbPh+5egsU7hGh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u/ImNijkyHQIAfwQfHx1y3ohc9MWMHug+zFdLmlLS0SlpmRilzTdcdMUsQDOt8H6E
	 K2Nj+/WR0TwW7AtHFwY0PPK+AQfAYXPqh8DKFg/FJrQg9riE/PGnbB8IPJIuNW5G/L
	 9BDBPlbQN03gLKVkMP1gDqQhL93JixxI7hOGR5AunAqi1ry/HPEZWk8yhtRiDzDVbT
	 2JgkEqMMplXmf56O1btuZnpCtfJ3gZkfgdTfNEP4zps0RzU5A1USXs2EKzB6bqKVWF
	 i+pJPL8yY8kER3NYQrKFNPfGwy90euM/TkvKO8ltetjb51XhBnbo1lZMAH7nzfB6yU
	 NjCvkADdzksXw==
Date: Tue, 26 Aug 2025 14:02:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR HISILICON STB" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] PCI: dwc: histb: Simplify clock handling by using
 clk_bulk*() functions
Message-ID: <20250826190255.GA851588@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgTLS+fNTUrx4F5G_5BrFwoq9vixDAFervqokDgJxPhP2Q@mail.gmail.com>

On Tue, Aug 26, 2025 at 11:32:34PM +0530, Anand Moon wrote:
> Hi Bjorn,
> 
> Thanks for your review comments.
> On Tue, 26 Aug 2025 at 21:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > In subject, remove "dwc: " to follow historical convention.  (See
> > "git log --oneline")
> >
> Ok I will keep it as per the git history.
> 
> > On Tue, Aug 26, 2025 at 05:12:40PM +0530, Anand Moon wrote:
> > > Currently, the driver acquires clocks and prepare/enable/disable/unprepare
> > > the clocks individually thereby making the driver complex to read.
> > >
> > > The driver can be simplified by using the clk_bulk*() APIs.
> > >
> > > Use:
> > >   - devm_clk_bulk_get_all() API to acquire all the clocks
> > >   - clk_bulk_prepare_enable() to prepare/enable clocks
> > >   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
> >
> > I assume this means the order in which we prepare/enable and
> > disable/unprepare will now depend on the order the clocks appear in
> > the device tree instead of the order in the code?  If so, please
> > mention that here and verify that all upstream device trees have the
> > correct order.
> >
> Following is the order in the device tree
> 
>        clocks = <&crg HISTB_PCIE_AUX_CLK>,
>                                  <&crg HISTB_PCIE_PIPE_CLK>,
>                                  <&crg HISTB_PCIE_SYS_CLK>,
>                                  <&crg HISTB_PCIE_BUS_CLK>;
>                         clock-names = "aux", "pipe", "sys", "bus";

The current order in the code is:

  histb_pcie_host_enable
    clk_prepare_enable(hipcie->bus_clk);
    clk_prepare_enable(hipcie->sys_clk);
    clk_prepare_enable(hipcie->pipe_clk);
    clk_prepare_enable(hipcie->aux_clk);

  histb_pcie_host_disable
    clk_disable_unprepare(hipcie->aux_clk);
    clk_disable_unprepare(hipcie->pipe_clk);
    clk_disable_unprepare(hipcie->sys_clk);
    clk_disable_unprepare(hipcie->bus_clk);

After this patch, it looks like we'll have:

  histb_pcie_host_enable
    clk_bulk_prepare_enable
      aux
      pipe
      sys
      bus

  histb_pcie_host_disable
    clk_bulk_disable_unprepare
      bus
      sys
      pipe
      aux

So it looks like this patch will reverse the ordering both for
enabling and disabling, right?  I'm totally fine with this as long as
it works.

Bjorn

