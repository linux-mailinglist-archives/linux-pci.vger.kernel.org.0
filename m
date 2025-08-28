Return-Path: <linux-pci+bounces-35050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F784B3AAC4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B0B1BA7712
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28386206F23;
	Thu, 28 Aug 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyvCtjep"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BDC2566;
	Thu, 28 Aug 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408857; cv=none; b=S3Jbaf/YUx2Dt5H3RkyHtkh2XFvb6R7X/VdkycAft4ck80kuOzwbo8SvSwmYB9ld2KKlNN8uCOItANvZ8qRzUlfdaZG7C3HaLOkJkd1c9lO2mV497cvCWc2DnnMByJwOjhj1FpFL6ZdXXs+KlOq73rlPhYL6udifUuMotFk0vO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408857; c=relaxed/simple;
	bh=xgoO4M24DDsETImgJteajsEhHPcXATQbldGDe37SjjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Or3+Fl0VAJBG80dudsulyhOODlrmr4QSsYofz4Su/IhI/aX/ZfznWi4b5npVUbA1q8w1K8nEmJkxPaEJytzSLdo2jk0EDwzwuP5RPBOlCZV6U4sxvGFhdxr0giwnF/i7P7LJQh6TUq4vbdq6GagAMMTzuLLgghHgvM3D+97BkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyvCtjep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39148C4CEEB;
	Thu, 28 Aug 2025 19:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756408856;
	bh=xgoO4M24DDsETImgJteajsEhHPcXATQbldGDe37SjjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HyvCtjepwxlQbLPWbRwQxWRSnxUoo3KIxjt0L7MzUTd1nz/g3xGlxKDaQZDRrCRVp
	 Je656D48eJo7JycZf5LXz5JFHotSFgwUbjuWJVl4egWp/77DFSfpoo6y52p+fpxsjJ
	 nuQINnQtKhLOu6FW2Szrrd06eA+l/Kw/QojwNhzyiHPPXl0A+ee97N4oSSXItZFnOA
	 NmiWpaHWxCv9ON02pbwnXXazsuEtCi0cPDMlqt5PGMy6AlF1x99nu73KtzsPByG0+4
	 MeQStzP2fN6VGd/giQIpXjZcv+hYaiat58ztolRCJHSQAOUSsNIZZXAMmZCWPk/Y7Z
	 3wZFycMpNCiXg==
Date: Thu, 28 Aug 2025 14:20:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linus.walleij@linaro.org,
	corbet@lwn.net, p.zabel@pengutronix.de, shradha.t@samsung.com,
	mayank.rana@oss.qualcomm.com, namcao@linutronix.de,
	qiang.yu@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, quic_schintav@quicinc.com,
	johan+linaro@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 06/11] PCI: stm32: Add PCIe Endpoint support for
 STM32MP25
Message-ID: <20250828192054.GA957771@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fbf4be0-af6e-4119-a838-e3fc9ab1fc9d@foss.st.com>

On Thu, Aug 28, 2025 at 09:06:33PM +0200, Christian Bruel wrote:
> On 8/28/25 19:22, Bjorn Helgaas wrote:
> > On Wed, Aug 20, 2025 at 09:54:06AM +0200, Christian Bruel wrote:
> > > Add driver to configure the STM32MP25 SoC PCIe Gen1 2.5GT/s or Gen2 5GT/s
> > > controller based on the DesignWare PCIe core in endpoint mode.
> > > ...
> > 
> > > +static int stm32_pcie_start_link(struct dw_pcie *pci)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > +	int ret;
> > > +
> > > +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
> > > +		dev_dbg(pci->dev, "Link is already enabled\n");
> > > +		return 0;
> > > +	}
> > 
> > While looking at the "incorrectly reset" comment, I noticed
> > stm32_pcie->link_status and wondered why it exists.  It looks like
> > it's only used in stm32_pcie_start_link() and stm32_pcie_stop_link(),
> > and I don't see similar tracking in other drivers.
> > 
> > It feels a little racy because the link might go down for reasons
> > other than calling stm32_pcie_stop_link().
> 
> I think that as an excess of paranoid that was meant to protect against a
> driver unbind when the link hasn’t started yet. In that case,
> stm32_pcie_remove() would disable a link that’s already disabled.
> 
> But that shouldn’t be a problem to disable twice the ltssm enable bit, as
> well as the perst irq. I’ll look into removing it. Is it okay if I do this
> with a fixup patch?

Sure.  We'll put it in pci/next as-is, and if/when you post a patch to
remove link_status, we'll squash it in.

Bjorn

