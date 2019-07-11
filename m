Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7826524B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfGKHM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 03:12:59 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:8482 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbfGKHM6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 03:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562829178; x=1594365178;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=i0oqF+c0+Re2PcA5c78rq4daYcOFwAY+aLzqK4ocFpA=;
  b=uSpKp1UA7/cx3Bnpju5SyjFsKPX2oPmeDZa/qHdLoCHOnR6Ovf3HJ6eA
   RZze0z7L3XGkkuEvt1fNBjkK3JM13ql8TY622lkqBdsYcHITrGfE4sk66
   0lijGNG36GsjGDoEKOUBT7FYN8G5f9yWVZmk7y6sCDl0IgF6pqoLB3ZKs
   E=;
X-IronPort-AV: E=Sophos;i="5.62,476,1554768000"; 
   d="scan'208";a="810584310"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Jul 2019 07:12:54 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 6B737A22BA;
        Thu, 11 Jul 2019 07:12:50 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 07:12:49 +0000
Received: from [10.125.238.52] (10.43.162.128) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 11 Jul
 2019 07:12:40 +0000
Subject: Re: [PATCH 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe
 host bridge binding
To:     Jonathan Chocron <jonnyc@amazon.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190710164519.17883-1-jonnyc@amazon.com>
 <20190710164519.17883-6-jonnyc@amazon.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <36e8c3b0-feeb-db8f-3808-0218b54adcec@amazon.com>
Date:   Thu, 11 Jul 2019 10:12:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710164519.17883-6-jonnyc@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.162.128]
X-ClientProxiedBy: EX13D01UWA004.ant.amazon.com (10.43.160.99) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/10/2019 7:45 PM, Jonathan Chocron wrote:
> Document Amazon's Annapurna Labs PCIe host bridge.

That is the way! (best to keep same wordings (Amazon's)

>
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>   .../devicetree/bindings/pci/pcie-al.txt       | 45 +++++++++++++++++++
>   MAINTAINERS                                   |  1 +
>   2 files changed, 46 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
> new file mode 100644
> index 000000000000..d92cc529490e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
> @@ -0,0 +1,45 @@
> +* Amazon Annapurna Labs PCIe host bridge
> +
> +Annapurna Labs' PCIe Host Controller is based on the Synopsys DesignWare

Amazon's


and what is the s' ? should it be for all

> +Example:
> +
> +	pcie-external0 {
probably should have a reference with the address
> +		compatible = "amazon,al-pcie";
> +		reg = <0x0 0xfb600000 0x0 0x00100000
> +		       0x0 0xfd800000 0x0 0x00010000
> +		       0x0 0xfd810000 0x0 0x00001000>;
> +		reg-names = "config", "controller", "dbi";
> +		bus-range = <0 255>;
> +		device_type = "pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-map-mask = <0x00 0 0 7>;
> +		interrupt-map = <0x0000 0 0 1 &gic_main GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>; /* INTa */
gic_main->gic
> +		ranges = <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5a6137df3f0e..d555beb794bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12205,6 +12205,7 @@ PCIE DRIVER FOR ANNAPURNA LABS
AMAZON!
>   M:	Jonathan Chocron <jonnyc@amazon.com>
>   L:	linux-pci@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/pcie-al.txt
>   F:	drivers/pci/controller/dwc/pcie-al.c
>   
>   PCIE DRIVER FOR AMLOGIC MESON
