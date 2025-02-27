Return-Path: <linux-pci+bounces-22473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3040A47008
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 01:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D01616E5DE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ECE10F4;
	Thu, 27 Feb 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5gY2KkK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2979CF;
	Thu, 27 Feb 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615258; cv=none; b=YZrXGskuRAjqkj5yCqeNWDybVS2PVtucuOqyYu4ieH9gaXVzMp5HkmN9u+BXk6IepgA3k2wETpc9dBdYJ7bkkq0f98AeIE16ju0RGWpgUd71/c4GxRQbF6yST8Zn+dxFZfnW8ehSP18bSVZz4Fk0sIyqFzxeeLUySpp7HITIgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615258; c=relaxed/simple;
	bh=IJhzRI5FvZjHtS5FsY6CYde4Ud9At1eLFATFNVXmvmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DUUkY048rSQxQI6OvaRaa5V1ojrzhAxVftkpythhkoKI7xQW51zKruLdke4P42AH0mmii6K8h5R+Z/mKic7ergKQCo6fsK43TNI/H2RC3Bpt70yXmbRwaQ/5nfZb4sxBGs/NHgfqPgQjpYlWGDH6mJ3pp7tW7Hk5aALOpc+wKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5gY2KkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7857C4CEE4;
	Thu, 27 Feb 2025 00:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740615257;
	bh=IJhzRI5FvZjHtS5FsY6CYde4Ud9At1eLFATFNVXmvmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=m5gY2KkKsdtpUFD1g8/Sxy/IgPIMpjbJaMk6IJb2+7Oa4e6UO9xn8uxrgsLGWq+nz
	 zUVLwbjg93GR1rbkoU4nsWC8vQmFnGNDK7BakN2lLOdD3K/ZaSCysIV+h0jJiDNnRH
	 3ZHVygXiNAfEuuF4zdIz9kgmCjPbgL89p7UnpmwdKzb7Jfbg0o06lWF2xM5YLsegyx
	 jVhnMlO1S6M3Bre/xwfQN0oc5O2YQ6q0kFsokXDObQjFx7NUiCda7i6kOfCO8QH8+9
	 wbvGyRN1zMJKSqbvc6R+gFesykDrTQYZonoZqM6gM3kYVGa30yhJiLT/6D+v2ALKtm
	 BSAqeNJTHjWxg==
Date: Wed, 26 Feb 2025 18:14:16 -0600
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
Message-ID: <20250227001416.GA566334@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227001211.GA566164@bhelgaas>

On Wed, Feb 26, 2025 at 06:12:13PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 28, 2025 at 05:07:39PM -0500, Frank Li wrote:
> > Most systems' PCIe outbound map windows have non-zero physical addresses,
> > but the possibility of encountering zero increased with commit
> > 700cafbb642b ("PCI: dwc: ep: Add bus_addr_base for outbound window").
> 
> I don't know what commit 700cafbb642b is.  It doesn't appear
> upstream, and there's no subject line or patch match for
> bus_addr_base.

Never mind, I see it's patch 5/7 of *this* series.  I looked at the
0/7 list, but missed it.

In any case, the commit ID will be different since we apply patches
from email, so the ID from your tree won't be useful.

Bjorn

