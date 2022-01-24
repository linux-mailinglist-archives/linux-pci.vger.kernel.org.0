Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED57497FD4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 13:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiAXMsA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 07:48:00 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:55240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242165AbiAXMr5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 07:47:57 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OAm7cn005142;
        Mon, 24 Jan 2022 13:47:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SpGq1e54inBBE4KXvpK+ctakiEyLoCA43ZRFJUWKYlE=;
 b=aafvZWfgb5zkhTZy1z+GMTWhmlAvirrr3oFqghUxPYMoWjgRn8NVuqrO0bw+WYm9QRyP
 GXvV/NwCatE15Uf6oRA8tKI1RmViLRs2RBFXZvqv1GD7j+9lZId4VqA9yvMfjTtahEk9
 UauDfkPOrC/Kbm7gS9K+UMXQfh64kOiVMNzt0kPUgCP+6b+FF2XQUmyK4GZLrA6rPvCu
 ZiaIrBsLpN3NRZUkKYawNc7h8TG1hXvnNFhOHkk7+I7ZDoWxizTuaRWMmsvRyeWOI4xZ
 acSYlawBFBtQ0pAzrlP8IweLtnAZVPA23qwsgr609LO9scCccm7NR+qAP2iTrZeE8h9n sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ds9v1kyyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 13:47:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 357DA10002A;
        Mon, 24 Jan 2022 13:47:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2D7DF216EC3;
        Mon, 24 Jan 2022 13:47:41 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.51) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 24 Jan
 2022 13:47:40 +0100
Message-ID: <6d45806f-d8f0-dabd-ae65-a820c1880ed4@foss.st.com>
Date:   Mon, 24 Jan 2022 13:47:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2 4/5] ARM: dts: sti: add the PCIe controller node
 within stih407-family
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20220103074731.3651-1-avolmat@me.com>
 <20220103074731.3651-5-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220103074731.3651-5-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_07,2022-01-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alain

On 1/3/22 08:47, Alain Volmat wrote:
> Add the pcie1 entry within stih407-family dtsi.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 21f3347a91d6..fe4ea2d5b583 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -631,6 +631,46 @@ spifsm: spifsm@9022000{
>  			status = "disabled";
>  		};
>  
> +		pcie1: pcie@9b10000 {
> +			compatible = "st,stih407-pcie";
> +			device_type = "pci";
> +			reg = <0x09b10000 0x00001000>,	/* cntrl registers */
> +			      <0x3fff0000 0x00010000>,	/* config space */
> +			      <0x40000000 0xc0000000>;	/* lmi mem window */
> +
> +			reg-names = "dbi",
> +				    "config",
> +				    "mem-window";
> +
> +			st,syscfg = <&syscfg_core 0xdc 0xe4>;
> +
> +			#interrupt-cells = <1>;
> +			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &intc GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			/* non-prefetchable and prefetchable */
> +			ranges = <0x82000000 0 0x30000000 0x30000000 0 0x05550000>,
> +				 <0xc2000000 0 0x35550000 0x35550000 0 0x0AAA0000>;
> +			bus-range = <0x00 0xff>;
> +
> +			resets = <&softreset STIH407_PCIE1_SOFTRESET>,
> +				 <&powerdown STIH407_PCIE1_POWERDOWN>;
> +
> +			reset-names = "softreset", "powerdown";
> +
> +			phys = <&phy_port1 PHY_TYPE_PCIE>;
> +			phy-names = "pcie";
> +
> +			status = "disabled";
> +		};
> +
>  		sata0: sata@9b20000 {
>  			compatible = "st,ahci";
>  			reg = <0x9b20000 0x1000>;
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
