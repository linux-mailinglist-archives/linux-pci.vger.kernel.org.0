Return-Path: <linux-pci+bounces-6434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015188A9D22
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941721F25049
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA5168B11;
	Thu, 18 Apr 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adFE2rRT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7636A8CA;
	Thu, 18 Apr 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450598; cv=none; b=PR3oPQpHMOCmIwobDJMkenuEzak7ViiB/Sukm8c9R6lzPTdE8orTwMlkZxPylHtfOieY95qfZP+P5jPr6A8KK/vU4+50vpowtox3C9nbJTkuc77Js7b70gkDpcO4Ioki75ZHJcSZY3TNsVxrQeEldPNDTUjZuQX0auPIhRhvTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450598; c=relaxed/simple;
	bh=397GVEGYbJQ7o030+SIw56SSDOb9yvxIBUZuoZ+8sUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm2fFMPKIXSYAlOW8ZoIxHkuJdV0S4Djv9oSIcOUaFEsYn8+PkVxK6M2kOS6vYMjOaH4Zr+wrZdZ+CZbQWh1SXK7kPeQss9+csrtjWGUGjLPcHD6hUcAi+p8LycJ7o0Ebhu7GG2H0oky/rfCHxXEr6OSz1OSXTMJ4sqqfKKxfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adFE2rRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5D7C113CC;
	Thu, 18 Apr 2024 14:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713450597;
	bh=397GVEGYbJQ7o030+SIw56SSDOb9yvxIBUZuoZ+8sUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adFE2rRTIuhaF2fqVVuxanQlIMSSWuypZf4jqitXbRMydllkwHmao9RDDQl7Rl7JW
	 lk7o44ydc0mZ86efJx8M5bt1N36Us5RFQ3ow0r02Mk1Z0aJOC8W6vf7Lt0oOQnSSGF
	 AxkuzG4SGFfmr2XMR0wrzQT4e+h+ilJ/PhfKJWAZ76qf1KB4+gCZ0zpkHhypFZsKqN
	 fCRKWcP3tc/IQ1IQd6TBSsR/syAa5ElJuR75sfMU+Gf3VWcetKozHAVrteiNYjpfVQ
	 jRroMZz07EEVg5by6Up8DO2rmJLbnVfgk6WBF51DUqbK5owdsT+fqJ5CnednyaW2os
	 8JF0twCcj2Q2Q==
Date: Thu, 18 Apr 2024 16:29:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/9] PCI: endpoint: Make host reboot handling more
 robust
Message-ID: <ZiEuXpoFI-up2pmE@ryzen>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>

On Thu, Apr 18, 2024 at 05:28:28PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This is the follow up series of [1], to improve the handling of host reboot in
> the endpoint subsystem. This involves refining the PERST# and Link Down event
> handling in both the controller and function drivers.
> 
> Testing
> =======
> 
> This series is tested on Qcom SM8450 based development board with both MHI_EPF
> and EPF_TEST function drivers.
> 
> Dependency
> ==========
> 
> This series depends on [1] and [2] which are currently in pci/next.
> 
> @Niklas: I've dropped your Tested-by tags as there were some changes in between
> and I want to make sure this version gets tested again. So please give it a go!

For the series:
Tested-by: Niklas Cassel <cassel@kernel.org>

