Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EABD497FCF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 13:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbiAXMrI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 07:47:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44344 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241919AbiAXMrH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 07:47:07 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20O8b4HJ017026;
        Mon, 24 Jan 2022 13:46:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=+pV8mMKlXLFf5NYQROWV+2C2Ijjojkt13YkzYJPqHQg=;
 b=cV/dJZxXq3B/lcdO6YNQadx63XECmxq/3DJAkgDiS7lPRcRrUR6u96Tes1UwkjzND6gk
 aa65v6eAZJKGBiWaxgvnaf65cHqWFgU4JvFUjcgV/MMbWRcVsyiPp6mAdnJZOnM3tNWs
 9HUA8AT7hp643Fc8EWmHyO9vpj8mAxfgnyF0P3FrXAbopzHvXzJujB11JpA7iPfPc4Fu
 r4TTnSzzBThswVlQ11dJkcIHRyq4UNvxb1JdhpgoX+yUJQ/3/G/cZ74jUGSJhNW+JFEt
 gqXsR7k5bgsCDscF9DDWlQOp5grFj42QxBZdcLBshQN+VW7+pcchfWHiI9zmzJUp3bT/ Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dsrru18tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 13:46:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C534A10002A;
        Mon, 24 Jan 2022 13:46:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BD78821423F;
        Mon, 24 Jan 2022 13:46:51 +0100 (CET)
Received: from [10.201.21.201] (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 24 Jan
 2022 13:46:51 +0100
Message-ID: <d198270b-9280-68d0-af70-5c6efcb4aac6@foss.st.com>
Date:   Mon, 24 Jan 2022 13:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2 3/5] MAINTAINERS: add entry for ST STI PCIE
 driver
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <20220103074731.3651-1-avolmat@me.com>
 <20220103074731.3651-4-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20220103074731.3651-4-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
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
> Add PCIE Driver entry for STI family from ST Microelectronics.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 360e9aa0205d..081ccdfbd89c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14666,6 +14666,12 @@ L:	linux-samsung-soc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/pci/controller/dwc/pci-exynos.c
>  
> +PCI DRIVER FOR ST STI PLATFORM
> +M:	Alain Volmat <avolmat@me.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/controller/dwc/pcie-sti.c
> +
>  PCI DRIVER FOR SYNOPSYS DESIGNWARE
>  M:	Jingoo Han <jingoohan1@gmail.com>
>  M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
