Return-Path: <linux-pci+bounces-36075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93435B55A51
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 01:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07ABA5C4BDD
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 23:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C542857CB;
	Fri, 12 Sep 2025 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR2z8lhq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489842848B4;
	Fri, 12 Sep 2025 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719694; cv=none; b=Y6rMdzxGJzA6tEd9FlMC2RgSSYheGgJOkq4C0Zec/JzhAM7Pz5M0AMhAaKofyUcZqGTOjHcIcaovVFennMHbGDnvPGa75MVjFT0u8T3DiBUM9Jguq2WLTRIuQI93XX+zUYfZzNxtdgcectjSZV6EeA1Gmm/oVeFU05DdokJ4Tok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719694; c=relaxed/simple;
	bh=8aays/36IMWxKFg+6HUicPJw3dVwhelQvKgnzcrf4y0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=O4nSAEF7OHCIZ/paMQSL+04PtQnOeHQM3B/Fh/ySjcDDdt8jRAnq1T74/iXfAguQrCtojCLT6C0VPmeXInVR8pqIK1T+lxzOGg7j83WBjwNNrcZm3j9jESKGAvBNB3tRFJ+DtJLmU52evOho1dFJawdz1PMWFB1fxZ2KN826cTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR2z8lhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1DBC4CEF1;
	Fri, 12 Sep 2025 23:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757719692;
	bh=8aays/36IMWxKFg+6HUicPJw3dVwhelQvKgnzcrf4y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BR2z8lhq1OeLRpJmgnOWMrQwddzmPMCEtj7jooaxe5IMc/ASnSketFBj+4VIaQSS7
	 pw/b91vEpSZ4w5XWe6h5M1LHFYXH8AqFSm7c6BF2b2NFY3MOj6Sk0Igrzi+4sbPON5
	 kNH2sWzYjDZ+ahDK5cfn/UF70bkw5JyFzyWarE2bGEUos0g0HKdbwUIitMAgRCEU03
	 EAiYT+eN269w0RfCCjisKYlZSyJJdm8h1bkk9q8P9GuMuFdtyQzPbBSC7oR55q7v9C
	 WvbAdn1tHo6iDBtmc4hfTf0kEjlPjvYjVHneb+oiZa7qFsvkldubVRjo/3RrFrfN/+
	 fediSzDgls5PA==
Date: Fri, 12 Sep 2025 18:28:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 3/4] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Message-ID: <20250912232811.GA1653368@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-pci-pwrctrl-perst-v3-3-3c0ac62b032c@oss.qualcomm.com>

On Fri, Sep 12, 2025 at 02:05:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
> nodes, not just in Root Port node. But the current logic parses PERST# only
> from the Root Port nodes. Though it is not causing any issue on the current
> platforms, the upcoming platforms will have PERST# in PCIe switch
> downstream ports also. So this requires parsing all the PCIe bridge nodes
> for the PERST# GPIO.
> 
> Hence, rework the parsing logic to extend to all PCIe bridge nodes starting
> from the Root Port node. If the 'reset-gpios' property is found for a PCI
> bridge node, the GPIO descriptor will be stored in qcom_pcie_perst::desc
> and added to the qcom_pcie_port::perst list.

The switch part doesn't seem qcom specific.  Aren't we going to end up
with lots of drivers reimplementing something like the
qcom_pcie_port.perst list?

