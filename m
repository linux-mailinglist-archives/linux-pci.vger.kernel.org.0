Return-Path: <linux-pci+bounces-24792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60222A71FC3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 20:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC791899C36
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D791F6664;
	Wed, 26 Mar 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAXn0GaP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280313C9A3
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019109; cv=none; b=aj3dO+hayYvfwh0JZl+Ux0QRdYZXn0ZwuT8wALdz6/fcHluh14J7otXNE40v5+JP828wkokDH9ApAjLgixtZ75SmnNtbLNqkpmkQblP5q/nYwakuCAzW5n2nHyjqSi5wdpsUI0M0ut9CvOHgpg2o1GYGQDyD02wV0TVsdfHHdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019109; c=relaxed/simple;
	bh=EkaQmyaqptJZMbb2x61OZnn9XWL3V3xBLF4VVvl8ai8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OFHiHMnEkgkF0q9Vc0amY8GQULGLMTlHfuY7Xgr6Xs/v5pAmFn3vMKAcmch3kWFdx6P6dhChMp4XQxLRP0o96J6pt7slJ2vfVmc0384KOlg8N6kG0reASjbpu4MTFMO21OZRzk9tcVok+SOS3rz2sg0imgtmkfZH7JJuIRMTMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAXn0GaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35527C4CEE2;
	Wed, 26 Mar 2025 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743019108;
	bh=EkaQmyaqptJZMbb2x61OZnn9XWL3V3xBLF4VVvl8ai8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tAXn0GaPRFq8pVDUBEzCWzEzpP2g7139aQwf+DAAzuySrPj0QJlLbpeiyZkuFp8f3
	 sFzPSfBSHTwz5qiHRktH3EPseutcebsXReSjX2Zlf99ZYGI5E8t9zvzqHDv8FaXxyz
	 G64yqgBesQSNT6rcZdR11uux3yZmO5FFnvbwVMitovtiBwzU9YEubO9qTKu5k036ml
	 MwHY5Tzy/yasM5Kfst1RO+5BO/bZS3nt4gmz9jgwjRCQu1qiDTpgjIDGwO6QYrrYkR
	 VaxqlG7YsdFVd8R3YFRyEvYLT/BliwRzGg1lsOkaJJJT4gUJkfaq6qGyjmygrld9om
	 EuejtZc3wdLGw==
Date: Wed, 26 Mar 2025 14:58:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <20250326195826.GA1347259@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+RT4BxBzK68Crac@x1-carbon>

On Wed, Mar 26, 2025 at 08:22:08PM +0100, Niklas Cassel wrote:
> On Wed, Mar 26, 2025 at 09:47:18PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 26, 2025 at 10:39:50AM -0400, Niklas Cassel wrote:
> > > 
> > > Can all Qcom platforms raise INTx in EP mode?
> > 
> > Yes, all Qcom platforms support INTx. But if we start setting the
> > flag to true, there is no need to set it to false as that would be
> > the default value. So let's just set 'true' for INTx capable
> > platforms and assume others as not supported. I know that you had
> > added justification in the commit message, but I think we'd have
> > to drop the below commit:
> > 
> > PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts
> 
> Well, with that logic, we should also remove the following:
> 
> $ git grep "msi_capable = false"
> drivers/pci/controller/dwc/pcie-tegra194.c:     .msi_capable = false,
> 
> $ git grep "msix_capable = false"
> drivers/pci/controller/dwc/pci-dra7xx.c:        .msix_capable = false,
> drivers/pci/controller/dwc/pci-imx6.c:  .msix_capable = false,
> drivers/pci/controller/dwc/pci-imx6.c:  .msix_capable = false,
> drivers/pci/controller/dwc/pcie-artpec6.c:      .msix_capable = false,
> drivers/pci/controller/dwc/pcie-qcom-ep.c:      .msix_capable = false,
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:    .msix_capable = false,
> drivers/pci/controller/dwc/pcie-tegra194.c:     .msix_capable = false,
> drivers/pci/controller/dwc/pcie-uniphier-ep.c:          .msix_capable = false,
> drivers/pci/controller/dwc/pcie-uniphier-ep.c:          .msix_capable = false,
> drivers/pci/controller/pcie-rcar-ep.c:  .msix_capable = false,
> drivers/pci/controller/pcie-rockchip-ep.c:      .msix_capable = false,
> 
> Feel free to send patches that removes all:
> {msi_capable,msix_capable,intx_capable}=false;
> 
> I will be happy to help out with reviews.
> 
> However, I'm slightly leaning towards thinking that there actually is some
> value in _explicitly_ seeing that something is not supported.

IMO, this value is pretty weak.  I think we should only mention
features that *are* supported.  The universe of possibly supported
features is unbounded.  Suppose new hardware adds a new feature X.
Obviously we have to mark hardware that supports X.  But I do not want
to go back and mark all the old hardware as "not supporting X".

Bjorn

