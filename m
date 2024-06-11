Return-Path: <linux-pci+bounces-8616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6C790474F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399811F24642
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D04155A39;
	Tue, 11 Jun 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvG5hfJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA5171C4;
	Tue, 11 Jun 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718146565; cv=none; b=SUrNRT9p1s/P+IyKTaPV0ZWlH9pkqqPkK67PphgRMH78UHrZCK/a2RRmyGtjTIN5AIceNiQZdrOi0cE1+j7DPpEUBIrtjy+LEdqRLKrxDEIvJFevm97Ryj+MCCULr2jwqQVSE6ojsDJoRGNJdCgLVbea7ztPSDjcSByXxbTgSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718146565; c=relaxed/simple;
	bh=e+yEenAa0DBKBAH1JDI7Art8IiR8vko+Q5ejQxwgRgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=a2si+pWjz+Wv4Ml53+UneVSc7JtWrzoJFLx3xC6hriJ20KqlUYbT92Et+vT29i7001tYs7DLMMR+APC5xIL7ZeDq+/q/5/NCLMQdC8gxi74Wyb5lCPaehS8FXXwmB0zMsaR6+FJIkwHS9Ldyz2Un/nZ2J2d22JLs78M8OSYXnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvG5hfJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F39C2BD10;
	Tue, 11 Jun 2024 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718146565;
	bh=e+yEenAa0DBKBAH1JDI7Art8IiR8vko+Q5ejQxwgRgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OvG5hfJPF+ZFKDXc8gWwryQhBayku2+B8u+fC9uzzr7nfGli565gerUMIqyvQ8xhh
	 D4McVRpS+rqeHTb+xEsXa+HUgAq8qWuH5JZ5NSjWP7kvetD0rpu0Eg7lwgZjjjabw6
	 YMZ2z4sY4N3Cit6Po1fzGzJevdjLZcddYtqShxtwAvYzkFXaSqWQvdzP+omZjjDbV6
	 Azwun9MqTlLj0iNAPVD8FT3Hyy/bzNe0znsk1fSHnNkJAPz/YqmS9BV+Rau6GhdoP8
	 yqy9SCNAiPsSajUpCwQJgO23bSjU7ufbAu1nLTbf2Yx6jE7ZVJMqvjdJq9dKEFqxc/
	 PCWkwc/rUH6BQ==
Date: Tue, 11 Jun 2024 17:56:03 -0500
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
Subject: Re: [PATCH v8 13/17] PCI/pwrctl: reuse the OF node for power
 controlled devices
Message-ID: <20240611225603.GA1005810@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pwrseq-v8-13-d354d52b763c@linaro.org>

On Tue, May 28, 2024 at 09:03:21PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With PCI power control we deal with two struct device objects bound to
> two different drivers but consuming the same OF node. We must not bind
> the pinctrl twice. To that end: before setting the OF node of the newly
> instantiated PCI device, check if a platform device consuming the same
> OF node doesn't already exist on the platform bus and - if so - mark the
> PCI device as reusing the OF node.
> 
> Tested-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With s/reuse/Reuse/ in subject to match history,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Would be good to get Rob's ack as well.

> ---
>  drivers/pci/of.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 51e3dd0ea5ab..b908fe1ae951 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -6,6 +6,7 @@
>   */
>  #define pr_fmt(fmt)	"PCI: OF: " fmt
>  
> +#include <linux/cleanup.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -13,6 +14,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/platform_device.h>
>  #include "pci.h"
>  
>  #ifdef CONFIG_PCI
> @@ -25,16 +27,20 @@
>   */
>  int pci_set_of_node(struct pci_dev *dev)
>  {
> -	struct device_node *node;
> -
>  	if (!dev->bus->dev.of_node)
>  		return 0;
>  
> -	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> +	struct device_node *node __free(device_node) =
> +		of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
>  	if (!node)
>  		return 0;
>  
> -	device_set_node(&dev->dev, of_fwnode_handle(node));
> +	struct device *pdev __free(put_device) =
> +		bus_find_device_by_of_node(&platform_bus_type, node);
> +	if (pdev)
> +		dev->bus->dev.of_node_reused = true;
> +
> +	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
>  	return 0;
>  }
>  
> 
> -- 
> 2.43.0
> 

