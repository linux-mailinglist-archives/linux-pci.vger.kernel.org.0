Return-Path: <linux-pci+bounces-13069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D1976190
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 08:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3C11C21EB4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57B3189530;
	Thu, 12 Sep 2024 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdZIxRI1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72129188903;
	Thu, 12 Sep 2024 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122908; cv=none; b=WQ5e2lAcSf7tlSI4C3wvqModAJhU5RA0zmhesh0G4H1tozSKpZPAYpvMZijE32oufZkRcc5Xjl5B0K32bgmgRDMv9SgrrApefgbzQ4X6OmeEezYGN0k0a7MfBMu8XD+Nw9DiPdW4dgxwwbzEK7VVyaQ+xkaQ9hweqh6DP60iXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122908; c=relaxed/simple;
	bh=JiVBt1seEou3ZPmEnMtRuyu8frlYcMJJC/6b2VpHDWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEggFZnzwe9IgIislO74Y2WSC0bqYjxorq08TlRyr3WwIpCIS6PnC/h/zEX5Zny2FMApUnIQC9mhjdx2mL09/IuN0kSmvjQOhLP95i4oU5uTtAPElE5eK8Pg3RxBTj9KsbMhg8NMkeupxNNXoHOg1y4Evq8cOIQdc01aOWADPO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdZIxRI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE25DC4CEC3;
	Thu, 12 Sep 2024 06:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726122907;
	bh=JiVBt1seEou3ZPmEnMtRuyu8frlYcMJJC/6b2VpHDWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdZIxRI19axF1Zq3ZQ1qRJ8bgLqVgoDd1WzpYt2Q/CDqsu85UCFTRIgk6nRpNlWZz
	 IN/ftegFBtj0okCEhAuXxPBBOfbCnrxihswr4zOzLbqPxvyigiPuxLFWqa94hvm6Xs
	 GoSpns45e2m8oqILIFQFDwQXl9PdIWv5ooi/Z0QxqsW32duIK3hxraKAhebZSZNPB7
	 mRzsuHzdZOZFGI2u+K0y+aoUSC9Wi9tGrJJgJx3/O3C4Be3jXJorVZKaj+aBQtnneQ
	 mltk7u+ddWz7PgCHn7YMbPqm5E2sY1rNmUGlSfqMbL1TWhNkb7vZkCGOXxRbhIHCe3
	 7Vi+TT9HL7w+A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sodQL-000000005F9-30EC;
	Thu, 12 Sep 2024 08:35:26 +0200
Date: Thu, 12 Sep 2024 08:35:25 +0200
From: Johan Hovold <johan@kernel.org>
To: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, abel.vesa@linaro.org,
	johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-tegra@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 0/4] PCI: qcom: Add 16.0 GT/s equalization and
 margining settings
Message-ID: <ZuKLrTriES9w5G_a@hovoldconsulting.com>
References: <20240911-pci-qcom-gen4-stability-v7-0-743f5c1fd027@linaro.org>
 <ZuKJYGVwXrvAuRIv@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuKJYGVwXrvAuRIv@hovoldconsulting.com>

On Thu, Sep 12, 2024 at 08:25:37AM +0200, Johan Hovold wrote:

> Bjorn, it would be great to have these in 6.12 since we're currently
> seeing lots of NVMe link errors on x1e80100 platforms (e.g. the Lenovo
> ThinkPad T14s) without them.
> 
> These errors are also blocking the enabling of using the GIC ITS for
> interrupts since that will cause all these AER reports to spam the
> logs. So if you pick this one up, please consider also picking up:
> 
> 	https://lore.kernel.org/lkml/20240711090250.20827-1-johan+linaro@kernel.org/

Heh, this one should of course go through the qcom tree once the Gen4
stability fixes have been merged by you. Sorry about the confusion.

Johan

