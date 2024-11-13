Return-Path: <linux-pci+bounces-16622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A36459C6AC3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FF4B21CA4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638E18A6D7;
	Wed, 13 Nov 2024 08:44:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77965185955;
	Wed, 13 Nov 2024 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487458; cv=none; b=A71GWSw8qucvoB+PKdk4tfo44H5FqTVoqHA6i/AWqlBi1HYAwVIZDSZavQPWD7gDXaoAcciQ4k5HQcHuV8ByZfqGijvPc9Nvwp1OlcLKmu+/HmrD1WfWKRx9w7Hx4yiBWlJ9b0PbaBt4ZIMniY7A4Vqj+o0g9HLQ/C2kKRUQu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487458; c=relaxed/simple;
	bh=02/dpSmbWQts+pjFlcYlfn4bGHtUtDohp05R4xagVy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExNqqVneZPi5Mo9AGSraU0U3IKPN3+jAOKGku0g/KEENd6lGohu50yeHhOHU+PnyY3KmiO9VH0FWhaa5V5OZMfK92aKsuCQnXXEO8ccEsd556k1Md0v/bIB+EPdvuErHdSpV3IMOp5n6e2x7CKZD+JHwKfrrhvHWL1FF6ecxoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AF8E1102BCBBF;
	Wed, 13 Nov 2024 09:44:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 72DDF21F84D; Wed, 13 Nov 2024 09:44:05 +0100 (CET)
Date: Wed, 13 Nov 2024 09:44:05 +0100
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
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 8/9] thermal: Add PCIe cooling driver
Message-ID: <ZzRm1SJTwEMRsAr8@wunner.de>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
 <20241018144755.7875-9-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018144755.7875-9-ilpo.jarvinen@linux.intel.com>

On Fri, Oct 18, 2024 at 05:47:54PM +0300, Ilpo Järvinen wrote:
>  static void pcie_bwnotif_remove(struct pcie_device *srv)
>  {
> +	struct pcie_bwctrl_data *data = srv->port->link_bwctrl;
> +
> +	if (data->cdev)
> +		pcie_cooling_device_unregister(data->cdev);
> +

Just noting a minor nit here in what is now commit 7206400cda87
on pci/bwctrl:  The NULL pointer check for data->cdev seems
redundant as pcie_cooling_device_unregister() just calls
thermal_cooling_device_unregister(), which in turn contains
this at the top:

	if (!cdev)
		return;

Thanks,

Lukas

