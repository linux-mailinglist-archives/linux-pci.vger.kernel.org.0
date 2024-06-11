Return-Path: <linux-pci+bounces-8598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC5904219
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDBE1F238C5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4540861;
	Tue, 11 Jun 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdyZk8sc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75B3FB83;
	Tue, 11 Jun 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125453; cv=none; b=TUf5/DpDaiFCnQAcTrw0EaQOJHqz8Qid1uD58Qnsf9IffkcpsBMIbOXnqNJZvt+cbFJMqVFQ9olsoQCnoedyxmliLS3cGm7w2HPkyrBHVtSfKfmnt9FzP4xisw4P9RtM0WUY6bwVyWey/qcq22+/a+jBNKdTC1dWlb9cMcZmJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125453; c=relaxed/simple;
	bh=D7nsRPRmxIs0jY7N1vqy4P7tamwNORJta5X6eAl1P1E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bc5tk1+zklMFl5r/KRP/Hbrwuhp1kTjU1sL7p4joXZiyZ7koBM45EFj4SS9oIB0GqpKWyoKeO2BWM5wIwOKxNO4IJsREaO1lxePAaUX11v1VoHvP8VJFSmiqK2Xrl1MBwBhu7u5zZqu/qwrVtddLI/kstqQKfPTpJaXKfkPe6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdyZk8sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62977C2BD10;
	Tue, 11 Jun 2024 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718125452;
	bh=D7nsRPRmxIs0jY7N1vqy4P7tamwNORJta5X6eAl1P1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pdyZk8scEe3XbhVlanhkDHhDlGCT6hFwwfx2X7Z/YREiPn2gXlWFWnWxVHg+wKQ5W
	 3ZVwmblInsG8/Tdaf4L+u9azaV1zjmjATCizQqPiEfTjdE4aVTejjigcISknSy8xoU
	 gWSf4jTZIYypzX7WSw5I+wlK+PLB11jA6qcy1+4FlrJULQ5BHlJch79iH9WzBdUjR5
	 FygURBx42o293b5CIdfVWcdXZY5wqX58HgIqWxvuawbTXwVUaRVj1HIe33VG5nKcn6
	 psvsAxLoiAql6T8/lKqhu2N/7oK/We7jmC8ZzTdHtFr+lYZJ34nh1549FW04+r+lrR
	 X/PylG3G4OfUw==
Date: Tue, 11 Jun 2024 12:04:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] PCI: altera: support dt binding update
Message-ID: <20240611170410.GA989554@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611163525.4156688-2-matthew.gerlach@linux.intel.com>

On Tue, Jun 11, 2024 at 11:35:25AM -0500, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add support for the device tree binding update. As part of
> converting the binding document from text to yaml, with schema
> validation, a device tree subnode was added to properly map
> legacy interrupts. Maintain backward compatibility with previous binding.

If something was *added* to the binding, I think it would be helpful
to split that into two patches: (1) convert to YAML with zero
functional changes, (2) add the new stuff.  Adding something at the
same time as changing the format makes it hard to review.

Then we could have a more specific subject and commit log for *this*
patch.

> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/pci/controller/pcie-altera.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index a9536dc4bf96..88511fa2f078 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -667,11 +667,20 @@ static void altera_pcie_isr(struct irq_desc *desc)
>  static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> -	struct device_node *node = dev->of_node;
> +	struct device_node *node, *child;
>  
>  	/* Setup INTx */
> +	child = of_get_next_child(dev->of_node, NULL);
> +	if (child)
> +		node = child;
> +	else
> +		node = dev->of_node;
> +
>  	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
> -					&intx_domain_ops, pcie);
> +						 &intx_domain_ops, pcie);
> +	if (child)
> +		of_node_put(child);
> +
>  	if (!pcie->irq_domain) {
>  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
>  		return -ENOMEM;
> -- 
> 2.34.1
> 

