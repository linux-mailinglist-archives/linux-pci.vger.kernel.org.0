Return-Path: <linux-pci+bounces-16557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B999C5C3B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F341F22AA6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D16202628;
	Tue, 12 Nov 2024 15:48:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878C1FF043;
	Tue, 12 Nov 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426481; cv=none; b=Yi3Nv+IV0mfSMP4zaBBCjxlnlpflbfZw6uYLC8I907KwmmZS6WAQDmUMlezoKPoS6Wa2VhETB0M45OFgtTD8du+IyTPrHwscoOvwwvDdJTikeKm8sR4SQhhi4lgdXI+2QxEFwzARlmKANMGZi++TPleAaU5dD1lP+0Ycj/X0B9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426481; c=relaxed/simple;
	bh=tNvpUgxn+I045QVoUNaZK9haXsjU9vpkV1RQTDKN+2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP/S6/WIFaMEXq3ue9Dglgw3k0BA+vASHGEKaXSVjfj6iFj5a7PGuVOMENLvmQzIHSG7RRMtC8c/JWU2VulnejbFTQV/MSU+foPDFziSf/pkhzalroa88Ms6GWcCTo+nSTvc+N0vGDAVMlSLftMDN+rPe644+LC5f9BiNPtyBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id DC22F300102A6;
	Tue, 12 Nov 2024 16:47:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ABA495F83DD; Tue, 12 Nov 2024 16:47:48 +0100 (CET)
Date: Tue, 12 Nov 2024 16:47:48 +0100
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
Message-ID: <ZzN4pO0lJDTSySaz@wunner.de>
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
> +EXPORT_SYMBOL_GPL(pcie_set_target_speed);

My apologies for another belated comment on this series.
This patch is now a688ab21eb72 on pci/bwctrl:

I note that pcie_set_target_speed() is not called my a modular user
(CONFIG_PCIE_THERMAL is bool, not tristate), so the above-quoted export
isn't really necessary right now.  I don't know if it was added
intentionally because some modular user is expected to show up
in the near future.


> @@ -135,6 +296,7 @@ static int pcie_bwnotif_probe(struct pcie_device *srv)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	devm_mutex_init(&srv->device, &data->set_speed_mutex);
>  	ret = devm_request_threaded_irq(&srv->device, srv->irq, NULL,
>  					pcie_bwnotif_irq_thread,
>  					IRQF_SHARED | IRQF_ONESHOT,

We generally try to avoid devm_*() functions in port service drivers
because if we later on move them into the PCI core (which is the plan),
we'll have to unroll them.  Not the end of the world that they're used
here, just not ideal.

Thanks,

Lukas

