Return-Path: <linux-pci+bounces-25617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4755CA83DF8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 11:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409E6179312
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 09:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87BC20E030;
	Thu, 10 Apr 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lXw/zGFs"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA956205AA5;
	Thu, 10 Apr 2025 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275954; cv=none; b=J7VWHCsiK+00p2SAVzTkw4HojpH2zUXZOOCcKBhOeaM+zR9vH9MP0bH380QVfYZj3xPcvl20CTG5CEkeTuuA+a3cUOVh6/r5ZmN9ss5HtOFrNcRif8WRGRW0EcErveLq2h+IdIstnHYmQbeKAyN/WsnukwItkwu2YD1ziVXssQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275954; c=relaxed/simple;
	bh=SyNgFYqShoX8sG1EvElMpp2wgQICe5/LIovg4bPhTLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYFrk8RRSUqmxnL+2deceAomsyq/YWlrDMbqI1bKOKwcMhW/uZB69iI7OA3UcaAcz/m3qq4kRgvMQWwEt0xTpe61TUYCB+ffhg+eDi+84x+ZKgkSlw6t0fJ2r2H/SO7PZDsWKR+9g2wAYKrZZnIocWr8P5nS3yQ1F82Y4hAMc5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lXw/zGFs; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53A95OH71769035
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 04:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744275924;
	bh=SD7cOLHPNPRn+FrhFL4jj5FK1/KNQWomyZ99DtlTZeo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=lXw/zGFsunICye/4+h6fJgF860Fh84ljOwinYE5ODgpWsnA7QcvEKWuxpcVnVddle
	 rTMdN6bbQFVP/3oIwr9QgvX3r9VeqqkQdDJJ8B9ZJx58SlMz3onu+Kqsb96dywsKSS
	 WAkMgmYnwZxWC0f9FiEzjsdlCPK8SSxyifS9vBxo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53A95Out047438
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Apr 2025 04:05:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 04:05:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 04:05:23 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53A95MPQ048842;
	Thu, 10 Apr 2025 04:05:22 -0500
Date: Thu, 10 Apr 2025 14:35:21 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Frank Li <Frank.Li@nxp.com>
CC: <s-vadapalli@ti.com>, <bhelgaas@google.com>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <krzk+dt@kernel.org>, <kw@linux.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lpieralisi@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <robh@kernel.org>, <tony@atomide.com>, <vigneshr@ti.com>
Subject: Re: [PATCH 1/1] Revert "ARM: dts: Update pcie ranges for dra7"
Message-ID: <9bd626d5-8fcd-4076-af52-deea6cf2dedc@ti.com>
References: <20250409153518.3068176-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250409153518.3068176-1-Frank.Li@nxp.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Apr 09, 2025 at 11:35:18AM -0400, Frank Li wrote:

Hello Frank,

> This reverts commit c761028ef5e27f477fe14d2b134164c584fc21ee.
> 
> The previous device tree correctly reflects the hardware behavior.
> The reverted commit introduced a fake address translation at pcie's parent
> bus node.

More details are required in the commit message. The commit being
reverted states:

"The range for 0 is typically used for child devices as the offset from the
module base. In the following patches, we will update pcie to probe with
ti-sysc, and the patches become a bit confusing to read compared to other
similar modules unless we update the ranges first. So let's just use the
full addresses for ranges for the 0x20000000 and 0x30000000 ranges."

The commit message in this patch should probably indicate something
along the lines of:
The commit being reverted updated the "ranges" property for the sake of
readability but that is no longer required because <your reason here>.

Tony Lindgren is the author of the commit being reverted. Tony could
clarify if the purpose of the commit was more than just improving
readability.

> 
> Reverting this change prepares for the cleanup of the driver's
> cpu_addr_fixup() hook.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Previous disscusion at
> https://lore.kernel.org/linux-pci/20250314064642.fyf3jqylmc6meft7@uda0492258/
> ---
>  arch/arm/boot/dts/ti/omap/dra7.dtsi | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> index b709703f6c0d4..711ce4c31bb1f 100644
> --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> @@ -195,24 +195,22 @@ axi0: target-module@51000000 {
>  			clock-names = "fck", "phy-clk", "phy-clk-div";
>  			#size-cells = <1>;
>  			#address-cells = <1>;
> -			ranges = <0x51000000 0x51000000 0x3000>,
> -				 <0x20000000 0x20000000 0x10000000>;
> +			ranges = <0x51000000 0x51000000 0x3000
> +				  0x0	     0x20000000 0x10000000>;
>  			dma-ranges;

[...]

Regards,
Siddharth.

