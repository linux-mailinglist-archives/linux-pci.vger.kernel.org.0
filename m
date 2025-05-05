Return-Path: <linux-pci+bounces-27125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA75AA8C1D
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 08:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACA517080E
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 06:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE131885B4;
	Mon,  5 May 2025 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEq41/2b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2734EBE;
	Mon,  5 May 2025 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425470; cv=none; b=tcZGdd5IVxfQqt6gamwONh7UrbPlfxZpDgdbQDKUngIrb+xd4j7XpnsOPoqvz9Fhd1/uCM5NpkuLBYGkX/l5yqh1w3SwyIOu1A0itkV+lraVkbFdYBz0/4n/qhHC6wD6Ba4v17Ka8Ve396B0S+gB9rTtlx+E4GbJ/On9dwgARHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425470; c=relaxed/simple;
	bh=/onU3pytGq7Cti4enjejB+4KbBxk8UDjILs73f4T614=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W88XOY/e0gi2PFMvB2JbSFguLroJ+SnTHEHOtiooZdNgGPNnR/tmYSL2ii1R22Ht4zwb2nfq78k+JC14WP4cbyYXpTOHeJqWkwT3jv7UUBtCeKACiTf1ezIDkDZl/1urYaSw2PodHKT6winhRg5XXkcLlXkqFjTNckcctdDN094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEq41/2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C00C4CEE4;
	Mon,  5 May 2025 06:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746425470;
	bh=/onU3pytGq7Cti4enjejB+4KbBxk8UDjILs73f4T614=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEq41/2bIMms9ypRF6tqEG2GaM8ZICDmeIYyf68vMNKTZAVWTaiIMbnxTJA2+fujG
	 LNyKY59iW28U9Uu8fST/vZqVMPmitZUSDjh7/GcBwmleRaLFCnYV+pN6gcdS9NFBT/
	 toijjkXxSxKbq40/PMFhmsy4Cy0kEhSFSZ+nr9FKtMMHnvpJ+0Lvq7OEl3f6417vPk
	 pMZ2UD2yZN6NHvgK5gHdWnECiokPa+Az1iTyBWgQz94OEObQVNFiA/Juh0a5YaYoiy
	 QfaXlVDtfNZqNTj8sDn+1BppmXnACwtdNM/I2iIEBIQxPTAEPLlW7S2abwlPEVXVqT
	 wjwXhvLhhtq4A==
Date: Mon, 5 May 2025 08:11:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2] PCI: dwc: Add support for slot reset on link down
 event
Message-ID: <aBhWdySIH7jlIZMA@x1-carbon>
References: <20250501-b4-pci_dwc_reset_support-v2-1-d6912ab174c4@wdc.com>
 <aBRtNOLQ6R-5iOB4@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBRtNOLQ6R-5iOB4@ryzen>

Hello Wilfred,

When submitting V3, please change the subject prefix to:
"PCI: dw-rockchip:", as the prefix: "PCI: dwc:" is only for patches
that are generic (and not glue driver specific).

Kind regards,
Niklas

