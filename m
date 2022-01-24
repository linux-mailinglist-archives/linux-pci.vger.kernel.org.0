Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E1497FDA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 13:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiAXMsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 07:48:19 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:55392 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240290AbiAXMsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 07:48:19 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20OBagXk007310;
        Mon, 24 Jan 2022 13:48:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=bqwL6hqSp5x5klnXSfmh2igRxF2EDjCRhC63tgZ/70M=;
 b=PhmNVOWXKXnxB3exZrVaKyxh3ZH1fMvKh1NS3ftgRlpvBlScAnJtt/wMq8iZ+f1gsEPQ
 O7p0k+l+RDQIDWjeahOXE7hl3wYnaAPg1X9NDbexy0j0qM49Cw+kpCtPrITQ2UY8sZ4A
 rY7QOiaVa1igNsHafNYCezIcAsSeIXNmFqxpstcTTqlcyduF12vfX2zZMSWRGZ7uDg4K
 3j2pWZn6dgL7Hh6oBy+tETZDVjNTRPhDLYlnssQu/pVnLW8HqtV14bBjiJbB7Kx2W1bp
 Rv6KzhkMHGNkzEK/O6V0Cz4PKO+4Umtz999Fki7tbuJayhsJge+xVfc1bERtz+89APqG XA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ds9v1m02h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 13:48:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DD58D10002A;
        Mon, 24 Jan 2022 13:48:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D552A21515E;
        Mon, 24 Jan 2022 13:48:06 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 24 Jan
 2022 13:48:06 +0100
Message-ID: <26d5410e-60c7-6f75-6624-a393ffcffe9a@foss.st.com>
Date:   Mon, 24 Jan 2022 13:48:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2 5/5] ARM: dts: sti: enable PCIe on the
 stih418-b2264 board
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20220103074731.3651-1-avolmat@me.com>
 <20220103074731.3651-6-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220103074731.3651-6-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_07,2022-01-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Alain

On 1/3/22 08:47, Alain Volmat wrote:
> Enable the PCIe controller with proper reset gpio pin for this board.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  arch/arm/boot/dts/stih418-b2264.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih418-b2264.dts b/arch/arm/boot/dts/stih418-b2264.dts
> index a99604bebf8c..ed183292a669 100644
> --- a/arch/arm/boot/dts/stih418-b2264.dts
> +++ b/arch/arm/boot/dts/stih418-b2264.dts
> @@ -130,6 +130,11 @@ &ohci1 {
>  	status = "okay";
>  };
>  
> +&pcie1 {
> +	reset-gpios = <&pio34 5 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
>  &pwm1 {
>  	status = "okay";
>  };
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
