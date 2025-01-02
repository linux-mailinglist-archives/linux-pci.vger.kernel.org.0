Return-Path: <linux-pci+bounces-19154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FAE9FF84C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 11:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10383A22BE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jan 2025 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953411953A1;
	Thu,  2 Jan 2025 10:38:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9F1917CD;
	Thu,  2 Jan 2025 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814319; cv=none; b=RBcS3ELOPF4RA+SX2pNEwyzhX6LpzH5qZR017zX2UqjbyfwUnjPQwR10p/4kIZvnS5ZU96qKJTwuqhnTFODHiBwKF1i7T481HntNbbJ3G50nBGdqLlgC4vN22zff6x5VbrBfoquG+rEDkDbW6Yin2jSNoV4lsGC641AKd0MZqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814319; c=relaxed/simple;
	bh=LpUnQDiio+JlMiPsNZKiGTW5Zem5ne95MKjZGD+pFi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp3vZwMPVoQ4BkGvCtjj+2eGLxtASkQsFFYcJ/aedJ4NBZs0iNR1YmzzuHgOF9XLggrn/jaE2GF7wbx/THDTEWKwmH0OluQ9oSKsgYR0yFDhk1415RcYqbGuN3wzn8otTj4c+Frz/OUJRmPmLxWG+h95+SQE54DRnSmqfDrQvhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id DE5572800B4B7;
	Thu,  2 Jan 2025 11:38:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C4A7B533CEB; Thu,  2 Jan 2025 11:38:27 +0100 (CET)
Date: Thu, 2 Jan 2025 11:38:27 +0100
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
Subject: Re: [PATCH v9 7/9] PCI/bwctrl: Add API to set PCIe Link Speed
Message-ID: <Z3Zso3vXrzR79s2o@wunner.de>
References: <20241018144755.7875-1-ilpo.jarvinen@linux.intel.com>
 <20241018144755.7875-8-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018144755.7875-8-ilpo.jarvinen@linux.intel.com>

On Fri, Oct 18, 2024 at 05:47:53PM +0300, Ilpo Järvinen wrote:
> @@ -142,9 +304,11 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  	if (ret)
>  		return ret;
>  
> -	scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> -		port->link_bwctrl = no_free_ptr(data);
> -		pcie_bwnotif_enable(srv);
> +	scoped_guard(rwsem_write, &pcie_bwctrl_setspeed_rwsem) {
> +		scoped_guard(rwsem_write, &pcie_bwctrl_lbms_rwsem) {
> +			port->link_bwctrl = no_free_ptr(data);
> +			pcie_bwnotif_enable(srv);
> +		}
>  	}

The "data" pointer is allocated with devm_kzalloc().
There's no __free(kfree) anywhere.

So what's the motivation for the no_free_ptr()?
Is this a remnant of an earlier version of the patch set that can be deleted
or is there actually a purpose to it?

Thanks,

Lukas

