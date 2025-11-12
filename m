Return-Path: <linux-pci+bounces-41005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFD7C53425
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 17:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 201AD355F71
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2143431E9;
	Wed, 12 Nov 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Poky9x1K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4573342CBC;
	Wed, 12 Nov 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962676; cv=none; b=UmOht5QBD0n6AHsV8iXK/GEe64DOVssI6ADTnoVJzz/ESt8Mi+xbEMhcqlMGFqTGHg4OAQ5I8NW7wMScvwLZV9puH92HCVE/QvZIXod8HwKe5TnAdPOZ5r5qTGFm7GeeyH5vRNpFKdF0YZ490coTP8/xnBEZJ4MQF8rLTK1wWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962676; c=relaxed/simple;
	bh=u5ESzxUqeIUXpNvJKjm152o+SRtiujAE19ZGW+GxdNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqEUneRVozZHeD1enPqlTUk0jS1IEh4phQ6Ws8EUyKjvJ15Cv/1H2212IxvcGpLOaSkDKu3eC802YLIuSj4JbUT0xUpI0V01yjQGeTwV4WZX7HXOtKGNyxB7ZOjfJxfQy71rFgHz1J/Pzzo+P9REz/dMkG82h7Bv63rkOYDLqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Poky9x1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F47CC4CEF8;
	Wed, 12 Nov 2025 15:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762962675;
	bh=u5ESzxUqeIUXpNvJKjm152o+SRtiujAE19ZGW+GxdNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Poky9x1KlKCgf+rsX9JUWdq804cVgnpsS0hfzM0JlzHIqRYMAKQQOavG7eOywtdrG
	 BldjaJwhemrAvaAFxZ2KtzanWDLoAMA92Vw7rsZQeAcsNUUpUvBQVcuLxtM/k2zbmF
	 NeknmECKdXvIx92FUOiPhDBNfAKjva16wejUc+wBYBrcH4VtQSfPWYW6ShiJUoVKfz
	 IoaKXvjxPwDY4qVlsl3OBJdaqVM6GBWNvTec1cUObCqfYyc3311+Qc597P7KoP4vm/
	 /+j7Y9JSD7SRxNhHgU1t0z1PFor5qnc0niTAkvvNmC5Sf36jf4DZrME783VkwR5Q8F
	 BM4ksKsjOukkw==
Date: Wed, 12 Nov 2025 21:21:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] power: sequencing: Add the Power Sequencing
 driver for the PCIe M.2 connectors
Message-ID: <upicsvybnw6by37ofry5zij5uqrejrdw5qkm5325ti4ayd7saa@iccgisoo63yp>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-4-e8bc4d7bf42d@oss.qualcomm.com>
 <CAMRc=Mfh-5D4Fv+HGJLFMUcOGKPkq7Jsz64LZcTiYxP0b87goQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfh-5D4Fv+HGJLFMUcOGKPkq7Jsz64LZcTiYxP0b87goQ@mail.gmail.com>

On Wed, Nov 12, 2025 at 04:04:51PM +0100, Bartosz Golaszewski wrote:
> On Sat, Nov 8, 2025 at 4:24 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> >
> > +
> > +static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
> > +                                struct device *dev)
> > +{
> > +       struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +       struct device_node *remote, *endpoint;
> > +
> > +       /*
> > +        * Traverse the 'remote-endpoint' nodes and check if the remote node's
> > +        * parent matches the OF node of 'dev'.
> > +        */
> > +       for_each_endpoint_of_node(ctx->of_node, endpoint) {
> > +               remote = of_graph_get_remote_port_parent(endpoint);
> > +               if (remote && (remote == dev_of_node(dev))) {
> > +                       of_node_put(remote);
> > +                       of_node_put(endpoint);
> > +                       return PWRSEQ_MATCH_OK;
> > +               }
> > +               of_node_put(remote);
> > +       }
> > +
> > +       return PWRSEQ_NO_MATCH;
> > +}
> 
> Nit: I would simplify this function with __free(device_node) since
> there'll be a v3 anyway. Other than that it looks good, so when the
> bindings get acked I assume this can go into the pwrseq/for-next?
> There don't seem to be any build-time dependencies between this and
> the PCI part.
> 

Yes. Pwrseq patches can go independently. It won't affect functionality as well,
since I haven't submitted the devicetree changes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

