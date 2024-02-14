Return-Path: <linux-pci+bounces-3444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD7E854911
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 13:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752D31F29EA9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 12:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA11B959;
	Wed, 14 Feb 2024 12:19:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04D1B952;
	Wed, 14 Feb 2024 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913198; cv=none; b=EG2sr8mUFxUtGggJx13grO+mnxC7ZjYfOyvDXDabeoTD2+9Bo/z5Gqs/wA6sLTXhvI4Nzdd39WEE5RLmdCv2Zu2rsPGXAsLfuZsvbbL8YTHlv6dqQ8DrTTh8y3mwtNC0xfaWEuTVWK8ZknvehaUao88pG0auZwSPhezpFNn/0ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913198; c=relaxed/simple;
	bh=SyRbVdRxwgUBVwTZvXCHUbYB1IO48tqnUpjgw16QHoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDw+kIb69ux5PeyL0MCHdWEjfqhJ32gl2rNv6K0md5oHTPI/OzHU1QBrO1IR81EoOidbv3YdDmMG61lqEDPUEVdh4vUvszJXMtKAJzYgTB3SFhHbP43k3g4TcYRGv+/SI4mr7xb3S+u4Ia5n/ou8WxOC5ikjz4EnqljNHv0YyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id BA2DE101C062C;
	Wed, 14 Feb 2024 13:19:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 88DA14EE672; Wed, 14 Feb 2024 13:19:46 +0100 (CET)
Date: Wed, 14 Feb 2024 13:19:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240214121946.GA6838@wunner.de>
References: <20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-pcie-qcom-bridge-v3-1-3a713bbc1fd7@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 14, 2024 at 05:16:09PM +0530, Manivannan Sadhasivam wrote:
> Currently, PCI core will enable D3 support for PCI bridges only when the
> following conditions are met:
> 
> 1. Platform is ACPI based
> 2. Thunderbolt controller is used
> 3. pcie_port_pm=force passed in cmdline
> 
> While options 1 and 2 do not apply to most of the DT based platforms,
> option 3 will make the life harder for distro maintainers. Due to this,
> runtime PM is also not getting enabled for the bridges.
> 
> To fix this, let's make use of the "supports-d3" property [1] in the bridge
> DT nodes to enable D3 support for the capable bridges. This will also allow
> the capable bridges to support runtime PM, thereby conserving power.
[...]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

