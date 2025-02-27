Return-Path: <linux-pci+bounces-22472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F1DA47003
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339A816E520
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B881684AC;
	Thu, 27 Feb 2025 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJfB1rL5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539870814;
	Thu, 27 Feb 2025 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615133; cv=none; b=RyD/axUMBBXGELsKg7ndWUxsNxeLHz+FjK/irf5+mQHFfL6NgtTzJFLFe6oH1pz5e4FGNPBzvbl/3pYBDQvFgmw47YERYRl93QfBRKuGgeNfa8EkhZ7+yeHY4Tv0hCDawqB807y0PRjhaShWxwtnOfW4XiigcndxwvuTQGTOdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615133; c=relaxed/simple;
	bh=kFgcrBElLJTonBz0lClAOsPUWgdoPyhvMj791RqwlRA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cs644SjDWiWpPFGk6jZp6hw6r9rdHIxl8N4PDR7w8cNVo4t3atfMf5ioGET1pOMjdZsqbI/Re/LUI1lbzFOZrqpSmcPPDgXs5EEcdc1mbv60yTyBKVDx33vQ5stoHV7PxD/SG2glxgOt7sqpeTtDoeOcmizbzZTl5ACTLQKZ3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJfB1rL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC25C4CEE4;
	Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740615133;
	bh=kFgcrBElLJTonBz0lClAOsPUWgdoPyhvMj791RqwlRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CJfB1rL5oz2xpW+K4hNOju3ADuUKr3b8mhl4wOWC+Qn0heguTMtKgVXVPzr+VjVen
	 Niv05HKBuXK7mv38wfm9zy4Y9KW0j0a2bvoOz5imlD4kZkxdlvs+64HW2uRAzRDyZj
	 KCEewPo383Hdn6XZLd3uJwtK1+181T8UXgaPvqyljnglkIg8loQHfbYjvRKqvzSk1b
	 zA2ZR+J0YJiI+qMtN84BJDDvA6n372iU2EbFephjXf7tNfX9wpCXBozcw0b0JDhpB9
	 JJTswsUJOmP2WY+kKWa8B+wNCZeYATO3GP9Sd4x8qivhBU11PwR0BHRWxCsP7Lf59g
	 bzInoK3C+tTAw==
Date: Wed, 26 Feb 2025 18:12:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 6/7] PCI: dwc: ep: Ensure proper iteration over
 outbound map windows
Message-ID: <20250227001211.GA566164@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pci_fixup_addr-v9-6-3c4bb506f665@nxp.com>

On Tue, Jan 28, 2025 at 05:07:39PM -0500, Frank Li wrote:
> Most systems' PCIe outbound map windows have non-zero physical addresses,
> but the possibility of encountering zero increased with commit
> 700cafbb642b ("PCI: dwc: ep: Add bus_addr_base for outbound window").

I don't know what commit 700cafbb642b is.  It doesn't appear
upstream, and there's no subject line or patch match for
bus_addr_base.

Bjorn

