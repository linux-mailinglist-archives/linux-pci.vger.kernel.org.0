Return-Path: <linux-pci+bounces-43995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C581CF301C
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 11:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5CC530084CE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A52F5A24;
	Mon,  5 Jan 2026 10:35:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBC313E00;
	Mon,  5 Jan 2026 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609314; cv=none; b=FlaP4cJOMj4jDiW68JLVTTUo4GqI94P7Nua6RJpkUrlLRM7IR1bzfe28yUottaMtww/X+n2/WFkuuQ6+seoXPheaa0BQHx711u2mZCXfdIvWLGSwabrCBiR72o5sVS/HO6D2+b9W0UOJZ4/QDmjIP1NW/6I0XDToOIuHKrdLNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609314; c=relaxed/simple;
	bh=BEK8vp7tT3P9d3V4uTCAgtRMAfCYYccZ6fPbZsKvzzo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5HbfbHHsPLUAD5EV8wp5lU1s5mt3d0nR42R4vkSOuUoFcytR3USpqSPZ1AnnlMGq3etAnckmn3+3y2yjWgAX9fQyzvyrz2hC2a8NSIv7xEOBUtn5EIyYdmNMC1ff/pMgeBrPPPQsPoPOhdILGz3dGAv8J3dA10KGZObpg3SgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dl9fb4yvKzHnH7p;
	Mon,  5 Jan 2026 18:35:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id B4AB540565;
	Mon,  5 Jan 2026 18:35:05 +0800 (CST)
Received: from localhost (10.48.146.88) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 5 Jan
 2026 10:35:04 +0000
Date: Mon, 5 Jan 2026 10:35:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?UTF-8?Q?Roh?=
 =?UTF-8?Q?=C3=A1r?= <pali@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, Tyrel Datwyler <tyreld@linux.ibm.com>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/3] PCI: mvebu: Simplify with scoped for each OF child
 loop
Message-ID: <20260105103502.00002efe@huawei.com>
In-Reply-To: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri,  2 Jan 2026 13:49:01 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Hi Krzysztof,

Drive by review.  Your changes are functionally equivalent and lgtm.
However, I am curious at whether the lack of reference count for child
when stashed in port->dn (and then used in the for loop) is a potential
issue.

Jonathan

> ---
>  drivers/pci/controller/pci-mvebu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index a72aa57591c0..4d3c97b62fe0 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1452,7 +1452,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  	struct mvebu_pcie *pcie;
>  	struct pci_host_bridge *bridge;
>  	struct device_node *np = dev->of_node;
> -	struct device_node *child;
>  	int num, i, ret;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
> @@ -1474,16 +1473,14 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	i = 0;
> -	for_each_available_child_of_node(np, child) {
> +	for_each_available_child_of_node_scoped(np, child) {
>  		struct mvebu_pcie_port *port = &pcie->ports[i];
>  
>  		ret = mvebu_pcie_parse_port(pcie, port, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> +		if (ret < 0)
>  			return ret;
> -		} else if (ret == 0) {
> +		else if (ret == 0)
>  			continue;
> -		}
>  
>  		port->dn = child;
>  		i++;
> @@ -1493,6 +1490,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  	for (i = 0; i < pcie->nports; i++) {
>  		struct mvebu_pcie_port *port = &pcie->ports[i];
>  		int irq = port->intx_irq;
> +		struct device_node *child;
>  
>  		child = port->dn;
>  		if (!child)


