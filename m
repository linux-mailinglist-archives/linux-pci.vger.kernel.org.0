Return-Path: <linux-pci+bounces-16445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E618B9C3F7E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 14:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221BD1C21B32
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA319CCF5;
	Mon, 11 Nov 2024 13:23:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172615746E;
	Mon, 11 Nov 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331427; cv=none; b=tfakAvf/i2wPiC12LRSN+6rrOhaXp50qsj7gO5NfocoSmdcKEKFyzCdEelWwyftecfpWL/KYnQQiJ8sy0W272PgIyvHs9SfZHs/OX66Z/nH4YZzLMXvdNjpLq4qCWlBBzHhi5Jbv2IHV1cqSaC3HLWf4abW/KThaBDb8h+3thgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331427; c=relaxed/simple;
	bh=8U9tCmOmMXG67QFN7yjI3McqSda9vyJxQGnM7HySwg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8otg94ca88ybjSUl/Pq9XZW6rl6urb2tnta2ZQGa6rfXLYV1xS17SNvtk6oSAQV6Pe/GEWIbdSon7FAjzYhwHy5sWZgp8LKQqvoiNBeO3lO+pGjgmOz2D37pJc/qmI2R935KF/jel9JRmh57RuR/1Ey+IPnV75DJpA8kMWr+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id DF2E430008A20;
	Mon, 11 Nov 2024 14:23:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C79213F54CD; Mon, 11 Nov 2024 14:23:35 +0100 (CET)
Date: Mon, 11 Nov 2024 14:23:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 3/9] PCI: Store all PCIe Supported Link Speeds
Message-ID: <ZzIFV8UNYSvgZtQM@wunner.de>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
 <20241018144755.7875-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018144755.7875-4-ilpo.jarvinen@linux.intel.com>

On Fri, Oct 18, 2024 at 05:47:49PM +0300, Ilpo Järvinen wrote:
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index be5ed534c39c..a02b77fe7865 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -303,6 +303,7 @@ enum pci_bus_speed {
>  	PCI_SPEED_UNKNOWN		= 0xff,
>  };
>  
> +u8 pcie_get_supported_speeds(struct pci_dev *dev);
>  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>  

I realize this is now already queued as commit 73ee11953294 on pci/bwctrl,
nevertheless one belated comment:

Since there are no callers of pcie_get_supported_speeds() outside the
PCI core, the above declaration should probably rather live in
drivers/pci/pci.h.

Thanks,

Lukas

