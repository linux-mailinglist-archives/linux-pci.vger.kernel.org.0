Return-Path: <linux-pci+bounces-17974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D90B9EA328
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 00:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039B9188746D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 23:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3882D224AE3;
	Mon,  9 Dec 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYsS0ntL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88451F63F1;
	Mon,  9 Dec 2024 23:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788284; cv=none; b=UadOSpAfoHkJ9SvyHafsiaVn4gC0lKG4e7XLplP1nFo2TwQXMCvAJdTgAW0ShGGW2rdX9VAyQyhuqjmM5oQpX6Aahaf1IqAsMhgdgnxLbIDnLPvpDmu9uOHImJB2a2U8GTeCAXz0FMGluSNVWHT4pA3wThUwqC8tj2AWEYzF1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788284; c=relaxed/simple;
	bh=Bu77FI8SuYEVtbsIt0tKw8XRgsWViMxLFwHkuD440h4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=izl9Y2mHbJYfIjEflsEhr27K9C9a+KVHggbz5rMKVbFJ7OHc546lXcVNsUqJ2+31edA8EJDhwcPiGHAkVl2srD8gjfkxdFeA4JqFn5CN38Wjto8iATnT3mTYnYOg7Z8HO2CG/1dYxqpfWgil0KdXwDXsNd2fUqq5Y/gpjao79Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYsS0ntL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F204C4CEE0;
	Mon,  9 Dec 2024 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733788283;
	bh=Bu77FI8SuYEVtbsIt0tKw8XRgsWViMxLFwHkuD440h4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aYsS0ntL4bV/8I2cjwZ/g0DsWB39Ys5ylxkmk1J8OEjMQh0FDsgohNRsHhbWZYvII
	 YXvmwSUUAeGcvpzNZX2V+NwyVg125VGFvfaP3CLJZCXJu4hGEu+vRH5RGEsxv0QLJN
	 One2uIB9Eo6g8F8E8IRfEkIC/MKZ/t9PaJwlxPG40K8DShOQNouD/1nMd5uW2WVflm
	 ozSmVUHHNcqst6Gqx6qVSW3Xh6/0P7PzNlsCLpftTc9kVFcrRm0ByYBK4L0m4t9sbU
	 gDgILxk0WeGM6o7bbk0892Ci7OiFJLE1kjW3no0nDunKkm7RDP6m/rnmbCsAuUL/CV
	 zlAyqBSsOpNsg==
Date: Mon, 9 Dec 2024 17:51:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Frank <Li@nxp.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: PCI: mobiveil: convert
 mobiveil-pcie.txt to yaml format
Message-ID: <20241209235121.GA3221844@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206222529.3706373-1-Frank.Li@nxp.com>

On Fri, Dec 06, 2024 at 05:25:27PM -0500, Frank Li wrote:
> Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
> layerscape-pcie-gen4.txt into this file.
> 
> Additional change:
> - interrupt-names: "aer", "pme", "intr", which align order in examples.
> - reg-names: csr_axi_slave, config_axi_slave, which align existed dts file.

Is there any way to split this into two patches:

  - Convert to yaml and update MAINTAINERS
  - Update interrupt-names, reg-names

It's hard to review the interrupt-names, reg-names when they're mixed
in with the yaml conversion.

