Return-Path: <linux-pci+bounces-32330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A25B07F11
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E065A7AC3C6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E6F2C178E;
	Wed, 16 Jul 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGCYj5/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DF2C15B5;
	Wed, 16 Jul 2025 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698529; cv=none; b=bOAPFhFsL4U39/4J9ReOm+hpK0ZcUBHS60mbLOe2WJJzT62N1cCtb/ZT+uopekobgb72e0vDo2stV186K9e7DkYzhS9gXksb3t4+c27ZJGpOJc3hniRxvkaLpwZnrBsEj0cAsTpwHdmcIG2ZYxMO1xkdkqOYhzQLZvC+EbhCTm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698529; c=relaxed/simple;
	bh=bOjYuzw7/nV/QXztvKR/9wxevijYcmuDZGg6FJsuCdY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fjuth+KqV1OWVrLViCugPw5SjExUk6GO/DF3qHdL2Rl1Pb7NXDMBny55kTk7xyfZh4LmPFufppAHi4d41MjxFaefLR44AjMvfDpExVdHSfK0PY9AvPfNicasTN1YEo06lyR6TKdeNiC0z0SEpzc/kzAWmY9NZIY9WeHLxIsZtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGCYj5/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C73BC4CEF1;
	Wed, 16 Jul 2025 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752698529;
	bh=bOjYuzw7/nV/QXztvKR/9wxevijYcmuDZGg6FJsuCdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RGCYj5/m+8BGAP7nMkjg2jJ+YpnyXiPgaxbWv29MtsTmYhud95FUdhQNlOz6l1A3r
	 m1XADHbovkwVcHNjocbsXSTs9shcPHmN6zxS2EokcyMl7NBCg/7J6aw3QWJXxjZo8Y
	 e5wH4ODW8L9Bg39rIFcnPAIv6eQQaSsJxYRJkVVbO38BJ6IPSQHRFlg+v34h0IQWcE
	 W183v4bZSuH+kTajqgSiZBHQj3ijmz3YOduuPyQIVL3X4ioY/jkwBXjVNkRrLpSCb1
	 9Ze26cXgdTeUx/q4jHEjDPurI3PuG+lQ82q3rU4sS7TD21pPNOJK6/I0cnNlgL4HBD
	 IH2jJiPafr6Ww==
Date: Wed, 16 Jul 2025 15:42:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.li@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <20250716204207.GA2554240@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfgpWsC1GlQUIEm@google.com>

On Wed, Jul 16, 2025 at 10:25:57AM -0700, Brian Norris wrote:
> On Wed, Jul 16, 2025 at 09:35:38PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 16, 2025 at 08:20:38AM GMT, Brian Norris wrote:
> > > On Wed, Jul 16, 2025 at 12:47:10PM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Jul 02, 2025 at 04:44:48PM GMT, Brian Norris wrote:
> > > > > On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > > > > OTOH, I do also believe there are SoCs where DWC PCIe is
> > > > > available, but there is no external MSI controller, and so
> > > > > that same problem still may exist. I may even have such SoCs
> > > > > available...
> > > > 
> > > > Yes, pretty much all Qcom SoCs without GIC-v3 ITS suffer from
> > > > this limitation.  And the same should be true for other
> > > > vendors also.
> > > > 
> > > > Interestingly, the Qcom SoCs route the AER/PME via 'global'
> > > > SPI interrupt, which is only handled by the controller driver.
> > > > This is similar to the 'aer' SPI interrupt in layerscape
> > > > platforms.
> > > 
> > > Yeah, I have some SoCs like this as well. But I also believe
> > > that I have INTx available, and that even when MSI doesn't work
> > > for AER/PME, INTx might.
> > > 
> > > Do Qcom SoCs route INTx?
> > 
> > Yes, they do. But currently, we can only use it by booting with
> > pcie_pme=nomsi cmdline parameter.

Ugh.  I think these controllers might be out of spec (or maybe we're
not configuring MSI/MSI-X correctly for them).  Per PCIe r7.0, sec
6.1.4.3:

  While enabled for MSI or MSI-X operation, a Function is prohibited
  from using INTx interrupts (if implemented) to request service (MSI,
  MSI-X, and INTx are mutually exclusive).

If the controller advertises MSI or MSI-X, I think we will enable it
and expect AER, PME, hotplug, etc. to use it.

Bjorn

