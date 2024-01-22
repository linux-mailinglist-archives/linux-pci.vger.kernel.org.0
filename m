Return-Path: <linux-pci+bounces-2411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F6835EEE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 11:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3C01F25E9A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 10:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454C439FDE;
	Mon, 22 Jan 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I2QRRhzI"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F193A1BA;
	Mon, 22 Jan 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917692; cv=none; b=cL/atmuLFOwyk3Rcxk3+O/sed4RRW5T3R6Mf29TvLrhiH428C9X+2hqVis+Ie4iU6hLOzodWYkY5MLJw06O8Be+x0yH1niM7lb5cS3D0YDblybHiToGaduCRjc4K9DOIYQbVX5xE3Zo1AStD0ryWPheo5yeWqz6ERRhHM1mRFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917692; c=relaxed/simple;
	bh=ajS6vCk3ctBLii0Yfu/Ypi/g9Z0pLS/eSyn6Mk9usdU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BsWkWK+tqC1QC1cdR+dea4XPeg+nSk+XS1vSwO93TO8ZZ/w+rlfj8JOZ7hQK43diWMW0zL6RHV/pNlQZhqD3jCQAzEQX7zsV02w114Y7XhMNrZZML/BV0z2dYzgcw4NP4wuYG8ZSkWjmFknF8F7MnRKvMNSJxS/1CzWT5a/mZ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I2QRRhzI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MA1Hjd123939;
	Mon, 22 Jan 2024 04:01:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705917677;
	bh=b2aNqFSY/9VXqWgu/6OAtCx3EV2oqfNc5jP2hF/6Wlk=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=I2QRRhzI2/nnxMTlTStBVUZuo8AzzDHbBWNBIzGEQRq2wyfhjveMoKvbmSOPSLA22
	 T4jAS2hJCyhDLCb2Q//iW4FWvdlmtTVvgZfDctpfugo198RkZdu+O1ur57UcWyXCD4
	 li+0/PN9I9Z6OnmTPhub9JmSajzLlRcoEANnTnsw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MA1HCN093558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 04:01:17 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 04:01:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 04:01:17 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MA1C0r016811;
	Mon, 22 Jan 2024 04:01:12 -0600
Message-ID: <f0d41955-6eaa-4931-a65e-84e1906ff0b1@ti.com>
Date: Mon, 22 Jan 2024 15:31:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <afd@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,j721e-pci-host: Add support for
 J722S SoC
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
References: <20240122064457.664542-1-s-vadapalli@ti.com>
 <20240122-getting-drippy-bb22a0634092@spud>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240122-getting-drippy-bb22a0634092@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Conor,

On 22/01/24 15:17, Conor Dooley wrote:
> On Mon, Jan 22, 2024 at 12:14:57PM +0530, Siddharth Vadapalli wrote:
>> TI's J722S SoC has one instance of a Gen3 Single-Lane PCIe controller.
>> The controller on J722S SoC is similar to the one present on TI's AM64
>> SoC, with the difference being that the controller on AM64 SoC supports
>> up to Gen2 link speed while the one on J722S SoC supports Gen3 link speed.
>>
>> Update the bindings with a new compatible for J722S SoC.
> 
> Since the difference is just that this device supports a higher link
> speed, should it not have a fallback compatible to the am64 variant?
> Or is the programming model different for this device for the lower link
> speeds different?

Thank you for reviewing the patch. I shall add the same fallback compatible that
am64 has which is "ti,j721e-pcie-host". I will post the v3 patch with this
change if that's acceptable.

-- 
Regards,
Siddharth.

