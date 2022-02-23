Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22304C1070
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiBWKj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 05:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiBWKj7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 05:39:59 -0500
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 02:39:31 PST
Received: from extserv.mm-sol.com (ns.mm-sol.com [37.157.136.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4DE2981F;
        Wed, 23 Feb 2022 02:39:31 -0800 (PST)
Received: from [192.168.1.9] (hst-221-41.medicom.bg [84.238.221.41])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: svarbanov@mm-sol.com)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 97409D266;
        Wed, 23 Feb 2022 12:30:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1645612254; bh=ajxAmhJ/kg+ZW0t22kOED7gRVLvKb3z8gDoN8cYcEQQ=;
        h=Date:Subject:To:Cc:From:From;
        b=QPZtU3pdaZvbL/HcGGdgNWKrtT1f5AWuiuW5mSbxsbV31xvQd7cTT41yWWUytymlT
         X+GB0OBwK3WM660G1eVrWxRFwyKQ32w5XXCjJMIQtVnjvby2XDX6HuKeR7lvXzCARh
         UFi1K6SJS/HObOZPhyuXaOwglQwk0kYpqY0advgQ/29TNzZWWPIKGsuyUq2QUUhToQ
         3JbM2QJ3salFHproQeSYqy6DsDnVDVPhPP2Mbj1cBgKjLWKUXrjtcNUziS/J8FDAEM
         hx2s3EsFaqhyNPALiKThUaibh9IUe22Ij8V7fPoI7wqtFHF/eHQWbbsM3ScpxUK+MI
         3KHb/GnqU6ywg==
Message-ID: <b713b30c-5941-06d7-bb96-fddcaaec2a8f@mm-sol.com>
Date:   Wed, 23 Feb 2022 12:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] PCI: qcom: Add support for handling MSIs from 8 endpoints
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
In-Reply-To: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/14/21 12:13, Manivannan Sadhasivam wrote:
> The DWC controller used in the Qcom Platforms are capable of addressing the
> MSIs generated from 8 different endpoints each with 32 vectors (256 in
> total). Currently the driver is using the default value of addressing the
> MSIs from 1 endpoint only. Extend it by passing the MAX_MSI_IRQS to the
> num_vectors field of pcie_port structure.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1c3d1116bb60..8a4c08d815a5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1550,6 +1550,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  	pp = &pci->pp;
> +	pp->num_vectors = MAX_MSI_IRQS;
>  
>  	pcie->pci = pci;
>  

-- 
regards,
Stan
