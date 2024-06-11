Return-Path: <linux-pci+bounces-8615-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39F904744
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F0A1C2333F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A60155A2B;
	Tue, 11 Jun 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7pxdhgD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61F171C4;
	Tue, 11 Jun 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146544; cv=none; b=BUVN0ROzsELCuT9FhLmJb8NptcehOoVn6dpJusOM+y476dZGlMuQVGWxdsCjCYgLTjxMSY42eTSo1CsODSFoGUJJ7f8OuhEIXSvn3nuhf3zOP1X8bcBxKq46Kk6N71ter0UPDDri75aYHyERtVRixN2qEzDNRNd8DYW+LITYOFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146544; c=relaxed/simple;
	bh=tfmwzXhu9BMvZdNucjHAIFq8O+nZOSTOqKttExZG0P0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GafEwndMNLMGAIERlCul4GZymuSrdE6pnn6aIrayIMYqHSXFKNKlPMGh1gR+hrXdDC8mbH8samgjqjDkei6L/qsx+D4OLTezmUFaFK7EFNFx72QZQfR46+vajCVytz5KOdNoByawh0oONNuWULD61uuLiN3j2gQNHOOQ45y11hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7pxdhgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0C9C2BD10;
	Tue, 11 Jun 2024 22:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718146543;
	bh=tfmwzXhu9BMvZdNucjHAIFq8O+nZOSTOqKttExZG0P0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A7pxdhgDNwl0CRAVasMm9Q18XFML4ebWwMMtwSRB078ntHxIYEfNrp+4t38McKEym
	 9Mbu/3WwIfhYbMrZlqu3YigWp9p6tLAcrQ8t8fNDVsrNom4keCoxM5P2uaoc3BisfH
	 Tv1NvrM/CehSzwVFu7gHEYo1MtWv8/9ofoqWcwm7ZwZWCaMHSTgriGAA44d3oC9/l7
	 xfGAWXlG8hZSKHlh+CZUcvtc3MgVBnyhPwXZyg9L3FuzoLkKbLX0T6yyh1Iyx8D2xA
	 1r/7dxQE3RbzF2CaEURzoqsdakZBbpuAmP7pxyBtCIwFhtSV5lL1BUgyKr8wESuNwO
	 493hSgD34nxaw==
Date: Tue, 11 Jun 2024 17:55:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath12k@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel@quicinc.com, Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v8 12/17] PCI: hold the rescan mutex when scanning for
 the first time
Message-ID: <20240611225541.GA1005771@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-12-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:20PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With the introduction of PCI device power control drivers that will be
> able to trigger the port rescan when probing, we need to hold the rescan
> mutex during the initial pci_host_probe() too or the two could get in
> each other's way.
> 
> Tested-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With s/hold the/Hold the/ in subject to match history,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/probe.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8e696e547565..604fc96b1098 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3072,7 +3072,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  	struct pci_bus *bus, *child;
>  	int ret;
>  
> +	pci_lock_rescan_remove();
>  	ret = pci_scan_root_bus_bridge(bridge);
> +	pci_unlock_rescan_remove();
>  	if (ret < 0) {
>  		dev_err(bridge->dev.parent, "Scanning root bridge failed");
>  		return ret;
> 
> -- 
> 2.43.0
> 

