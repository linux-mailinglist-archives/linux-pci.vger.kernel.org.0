Return-Path: <linux-pci+bounces-2729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C28409B7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8511428C095
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C51153BC1;
	Mon, 29 Jan 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tA9L37g+"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5A815443F;
	Mon, 29 Jan 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541595; cv=none; b=qpLZ9/8yoqoq1QL64c0MscwGETwYvPtDhCOl//r2eHn1lLK2ogQEEbQbhVQuiXNh6w5ye8/Tnsbg+bjqcacOac0IIcrEkPZDm+QwkPs91tATe6XTkJsW1PGpcfREw1JfcV8hmkEFFg/ggtXo6/EQcXAj271RDsUKeNwNrY3fdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541595; c=relaxed/simple;
	bh=ZP/y7rwTNXQRRS57Mj+sf0zKJdTCjZmzL7LSP32iLCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nn/HaWDky8/AVw6/U9zRQVEMpBpDot1i6FxU4qqxNGl3k1Gi8nuNQAPwDX/jZhENs1hu2oCrHACHss1v3ablWSMLHIyLRNEyWgi+o29OPv9Rsmq1mYkn7+3XuqIhRwjJWfbmMG/jJGTcmJwZ7r4c68aJ9abycnqbwCbTzC8gAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tA9L37g+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TFJfSl091902;
	Mon, 29 Jan 2024 09:19:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706541581;
	bh=LfcJ9zlfwzsGfl0+LgvF4CNibbNNKcmZOBPqSOAfWHE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tA9L37g+pjnQgFLbIPV3hITGSdJ5U6xepE4CRSItBY+A36zluNNw7cm4dr5JK0CZd
	 WBvwQzXPQ3dCgBacqCSN4krPJsnsWEz93fTeCl6LlLL48TSbNcGD2/m3NE6graaNxK
	 BQ9BRJEIsi3kP5axXUsMYQEMjw/6laK+Kv07SDnE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TFJfMj019376
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jan 2024 09:19:41 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 09:19:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 09:19:40 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TFJew2086755;
	Mon, 29 Jan 2024 09:19:40 -0600
Message-ID: <077682de-7789-4f1f-8dcc-aa47f4fb2dff@ti.com>
Date: Mon, 29 Jan 2024 09:19:40 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: j721e: Extend j721e_pcie_ctrl_init() for non syscon
 nodes
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <vigneshr@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20240129104958.1139787-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240129104958.1139787-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/29/24 4:49 AM, Siddharth Vadapalli wrote:
> The "ti,syscon-pcie-ctrl" device-tree property is used to obtain
> reference to the "pcie_ctrl" register within the System Controller Module
> in order to configure the link speed, number of lanes and the mode of
> operation of the PCIe controller. The existing implementation of the
> "j721e_pcie_ctrl_init()" function handles the case where the compatible for
> the System Controller Module node specified using the "ti,syscon-pcie-ctrl"
> property is "syscon". Since the System Controller Module can be modelled as
> a "simple-bus" as well, extend the implementation of the
> "j721e_pcie_ctrl_init()" function to handle the "simple-bus" case.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20240129.
> 
> The System Controller Module is modelled as a "simple-bus" in J784S4 SoC at
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi#L45
> The existing SoCs such as J721E and J7200 which currently model the node as
> a Syscon node will also be updated to model it as a "simple-bus".
> Therefore this patch aims to update the driver in order to handle the
> migration of the System Controller Module to the "simple-bus" compatible
> without breaking PCIe functionality on existing TI SoCs which make use
> of the pci-j721e.c driver.
> 
> Regards,
> Siddharth.
> 
>   drivers/pci/controller/cadence/pci-j721e.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 85718246016b..2ace7e78a880 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -224,12 +224,20 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>   {
>   	struct device *dev = pcie->cdns_pcie->dev;
>   	struct device_node *node = dev->of_node;
> +	struct device_node *scm_conf;
>   	struct of_phandle_args args;
>   	unsigned int offset = 0;
>   	struct regmap *syscon;
>   	int ret;
>   
> -	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-ctrl");
> +	scm_conf = of_parse_phandle(node, "ti,syscon-pcie-ctrl", 0);
> +	if (!scm_conf) {
> +		dev_err(dev, "unable to get System Controller node\n");
> +		return -ENODEV;
> +	}
> +
> +	syscon = device_node_to_regmap(scm_conf);

Turning the entire "simple-bus" region into a regmap using this
function is just as broken as having it as a "syscon". The core
problem we are solving by getting rid of the blanket syscon nodes
is that it causes multiple mappings of the same register. This
can cause issues with regmap caching, read–modify–write, etc..

What you want to do is add a subnode to the simple-bus, have that
encapsulate just the registers used for PCIe, and have the PCIe
node point to that. Then this patch isn't needed.

For an example, see how it's done for DSS[0].

Andrew

[0] https://github.com/torvalds/linux/blob/41bccc98fb7931d63d03f326a746ac4d429c1dd3/arch/arm64/boot/dts/ti/k3-am65-main.dtsi#L502

> +	of_node_put(scm_conf);
>   	if (IS_ERR(syscon)) {
>   		dev_err(dev, "Unable to get ti,syscon-pcie-ctrl regmap\n");
>   		return PTR_ERR(syscon);

