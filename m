Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F107538A5B4
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 12:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhETKSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 06:18:54 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46678 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235731AbhETKQt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 May 2021 06:16:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621505723; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RimnFyHnEwmSSWhM/3E14U80346pavoF8LlaOtDcD8Y=;
 b=vhv+PBlG1RPb70r4A0xQ3h1IHdnFyYS3Ex/NgPeWmqV0AvCAwhRDIh4nmKVmw/Hui8RfCjM2
 OvdFofxhOekc0fxcTi+YAyUy4li+0yfN0iRMk2RJRTjYtoMupCXZlaZYApSUXwagqQ0VWo9f
 NVBblzVDnBDN4l37g87sn5g1vlI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI2YzdiNyIsICJsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60a636b8c4456bc0f1d46044 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 May 2021 10:15:20
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 550CFC00914; Thu, 20 May 2021 10:15:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12116C4314A;
        Thu, 20 May 2021 10:15:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 15:45:15 +0530
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mgautam@codeaurora.org, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org
Subject: Re: [PATCH] PCIe: qcom: Add support to control pipe clk mux
In-Reply-To: <20210509023547.GJ2484@yoga>
References: <1620520860-8589-1-git-send-email-pmaliset@codeaurora.org>
 <20210509023547.GJ2484@yoga>
Message-ID: <3447606ba9ade9d578c609838e63dbb3@codeaurora.org>
X-Sender: pmaliset@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-05-09 08:05, Bjorn Andersson wrote:
> On Sat 08 May 19:41 CDT 2021, Prasad Malisetty wrote:
> 
>> PCIe driver needs to toggle between bi_tcxo and phy pipe
>> clock as part of its LPM sequence. This is done by setting
>> pipe_clk/ref_clk_src as parent of pipe_clk_src after phy init
>> 
>> Dependent on below change:
>> 
>> 	https://lore.kernel.org/patchwork/patch/1422499/
> 
> In what way is this change to the driver dependent on the addition of
> the node to DT?
> 
I will move this patch to DT series patches in next version.
>> 
>> Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c 
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 8a7a300..a9f69e8 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -9,6 +9,7 @@
>>   */
>> 
>>  #include <linux/clk.h>
>> +#include <linux/clk-provider.h>
> 
> Can you help me see why this is needed?
> 
Its needed for set_parent function prototype.
>>  #include <linux/crc8.h>
>>  #include <linux/delay.h>
>>  #include <linux/gpio/consumer.h>
>> @@ -166,6 +167,9 @@ struct qcom_pcie_resources_2_7_0 {
>>  	struct regulator_bulk_data supplies[2];
>>  	struct reset_control *pci_reset;
>>  	struct clk *pipe_clk;
>> +	struct clk *pipe_clk_src;
>> +	struct clk *pipe_ext_src;
>> +	struct clk *ref_clk_src;
>>  };
>> 
>>  union qcom_pcie_resources {
>> @@ -1168,7 +1172,19 @@ static int qcom_pcie_get_resources_2_7_0(struct 
>> qcom_pcie *pcie)
>>  		return ret;
>> 
>>  	res->pipe_clk = devm_clk_get(dev, "pipe");
>> -	return PTR_ERR_OR_ZERO(res->pipe_clk);
>> +	if (IS_ERR(res->pipe_clk))
>> +		return PTR_ERR(res->pipe_clk);
>> +
>> +	res->pipe_clk_src = devm_clk_get(dev, "pipe_src");
>> +	if (IS_ERR(res->pipe_clk_src))
> 
> How does this not fail on existing targets?
I will add platform check in next version.
> 
>> +		return PTR_ERR(res->pipe_clk_src);
>> +
>> +	res->pipe_ext_src = devm_clk_get(dev, "pipe_ext");
>> +	if (IS_ERR(res->pipe_ext_src))
>> +		return PTR_ERR(res->pipe_ext_src);
>> +
>> +	res->ref_clk_src = devm_clk_get(dev, "ref");
>> +	return PTR_ERR_OR_ZERO(res->ref_clk_src);
>>  }
>> 
>>  static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>> @@ -1255,6 +1271,11 @@ static void qcom_pcie_deinit_2_7_0(struct 
>> qcom_pcie *pcie)
>>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>>  {
>>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>> +	struct dw_pcie *pci = pcie->pci;
>> +	struct device *dev = pci->dev;
>> +
>> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sc7280"))
> 
> Why is this specific to sc7280?
> 
Newer targets including sc7280 require changing pipe-clk mux to switch 
between pipe_clk and XO for GDSC enable.

>> +		clk_set_parent(res->pipe_clk_src, res->pipe_ext_src);
> 
> The naming here is not obvious to me, but I think you're going to use
> this to set parent of gcc_pcie_0_pipe_clk_src to pcie_0_pipe_clk?
> 
> But in the commit message you're talking about switching back and forth
> between the pipe clock and tcxo, can you please help me understand 
> where
> this is happening?
> 
Shall I add the naming convention for above clocks "pipe_clk_mux and 
pcie_0_pipe_clk_src" .
Switching between pipe clk and tcxo are added in suspend/resume 
callbacks. I will update the commit message
in next version.
> 
> PS. The new clocks should be mentioned in the binding.
> 
> Regards,
> Bjorn
> 
>> 
>>  	return clk_prepare_enable(res->pipe_clk);
>>  }
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
