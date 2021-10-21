Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A320D4365EC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhJUPYQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:24:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:13291 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUPYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:24:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634829719; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=hFNY86HNWJlxxkl6jhM5IJFAs+sbpZ936meShRU6elQ=;
 b=gsqf2t9lSdpvbURV8CMsGd80IIXIP6wrbfVqGDuZmhDHYpj2PYgNu2xeAjgtEGbtIIZ152Gy
 8hCrKe2PBpqMrRvynJFLjAkDCFUy9bM76OLTp157/e+k4ykcknCD3LQ3hc8viKOa/VmLzG8G
 9yuAvRTaKxVAQwhi/cSUIKB9HPo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61718589bc302969584722aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Oct 2021 15:21:45
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34E46C43638; Thu, 21 Oct 2021 15:21:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DF53C4360D;
        Thu, 21 Oct 2021 15:21:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 21 Oct 2021 20:51:44 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, vbadigan@codeaurora.org,
        kw@linux.com, bhelgaas@google.com
Subject: Re: [PATCH v1] PCI: qcom: Fix incorrect register offset in pcie init
In-Reply-To: <20211021073647.GA7580@workstation>
References: <1634237929-25459-1-git-send-email-pmaliset@codeaurora.org>
 <20211021073647.GA7580@workstation>
Message-ID: <b70c914a581e6362fe340c499e87fed9@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-10-21 13:06, Manivannan Sadhasivam wrote:
> On Fri, Oct 15, 2021 at 12:28:49AM +0530, Prasad Malisetty wrote:
>> In pcie_init_2_7_0 one of the register writes using incorrect offset
>> as per the platform register definitions 
>> (PCIE_PARF_AXI_MSTR_WR_ADDR_HALT
>> offset value should be 0x1A8 instead 0x178).
>> Update the correct offset value for SDM845 platform.
>> 
>> fixes: ed8cc3b1 ("PCI: qcom: Add support for SDM845 PCIe controller")
>> 
>> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
> 
> After incorporating the reviews from Bjorn H,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks,
> Mani
> 

Thanks Mani for the review. I will incorporate the changes as suggested 
by Bjorn H in next patch version.

-Prasad
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 8a7a300..5bce152 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1230,9 +1230,9 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie 
>> *pcie)
>>  	writel(val, pcie->parf + PCIE20_PARF_MHI_CLOCK_RESET_CTRL);
>> 
>>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> -		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
>> +		val = readl(pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>>  		val |= BIT(31);
>> -		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT);
>> +		writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>>  	}
>> 
>>  	return 0;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
