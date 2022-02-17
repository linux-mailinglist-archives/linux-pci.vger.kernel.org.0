Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C64B9D1B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 11:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbiBQKZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 05:25:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiBQKZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 05:25:16 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC127C211;
        Thu, 17 Feb 2022 02:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645093490; x=1676629490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BqvXLH+FOW688ZuI3rFKDQQKxHsIk9sojfRvijbhbPY=;
  b=IWeExx0Gfisac10ZiFYvSS6KU3Xw+sTfAcu51EZ5pCCKIkvR1ZXHR/VN
   K/OmFk1djk81EJeIdFadQdLY6PP0UP4JOaQP0bWvCDPJLZxHKb/DGltbj
   AR9Q2jh8ezKhSKHxgQjROCfFCUiMLgziTVz2tg8AxStXcXVpjQweKinkm
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Feb 2022 02:24:46 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 02:24:46 -0800
Received: from [10.216.32.231] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 17 Feb
 2022 02:24:41 -0800
Message-ID: <6d161f6d-3776-07da-2c09-13e5b10abe29@quicinc.com>
Date:   Thu, 17 Feb 2022 15:53:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] PCI: qcom: Add system PM support
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <swboyd@chromium.org>
References: <1643738876-18572-1-git-send-email-quic_pmaliset@quicinc.com>
 <20220211091409.GB3223@thinkpad>
From:   Prasad Malisetty <quic_pmaliset@quicinc.com>
In-Reply-To: <20220211091409.GB3223@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mani,

Thanks for the review and comments.

I updated my mail client. sending the same responses. I will post the 
new patch version.

Testing is in progress.

Thanks

-Prasad

On 2/11/2022 2:44 PM, Manivannan Sadhasivam wrote:
> On top of Bjorn's review:
>
> On Tue, Feb 01, 2022 at 11:37:56PM +0530, Prasad Malisetty wrote:
>> Add suspend_noirq and resume_noirq callbacks to handle
>> System suspend and resume in dwc pcie controller driver.
>>
>> When system suspends, send PME turnoff message to enter
>> link into L2 state. Along with powerdown the PHY, disable
>> pipe clock, switch gcc_pcie_1_pipe_clk_src to XO if mux is
>> supported and disable the pcie clocks, regulators.
>>
>> When system resumes, PCIe link will be re-established and
>> setup rc settings.
>>
>> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> ---
>> Changes since v1:
>> 	- Removed unnecessary logs and modified log level suggested by Manivannan.
>> 	- Removed platform specific callbacks as PM support is generic.
> This is not still generic... Please see below.
>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 97 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index c19cd506..d1dd6c7 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -73,6 +73,8 @@
>>   
>>   #define PCIE20_PARF_Q2A_FLUSH			0x1AC
>>   
>> +#define PCIE20_PARF_PM_STTS                     0x24
>> +
>>   #define PCIE20_MISC_CONTROL_1_REG		0x8BC
>>   #define DBI_RO_WR_EN				1
>>   
>> @@ -1616,6 +1618,100 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   	return ret;
>>   }
>>   
>> +static int qcom_pcie_send_pme_turnoff_msg(struct qcom_pcie *pcie)
>> +{
>> +	int ret = 0;
>> +	u32 val = 0, poll_val = 0;
>> +	u64 l23_rdy_poll_timeout = 100000;
>> +	struct dw_pcie *pci = pcie->pci;
>> +	struct device *dev = pci->dev;
>> +
>> +	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
>> +	val |= BIT(4);
> Define BIT(4)
Sure, I will update in next patch version.
>
>> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
>> +
>> +	ret = readl_poll_timeout((pcie->parf + PCIE20_PARF_PM_STTS), poll_val,
>> +			(poll_val & BIT(5)), 10000, l23_rdy_poll_timeout);
> Define BIT(5)
Sure, I will update in next patch version.
>
>> +	if (!ret)
>> +		dev_info(dev, "PM_Enter_L23 is received\n");
> Maybe print, "Device entered L23_Ready state"? Also this should be dev_dbg().
>
>> +	else
>> +		dev_err(dev, "PM_Enter_L23 is NOT received.PARF_PM_STTS 0x%x\n",
> Maybe print, "Device failed to enter L23_Ready state"?
Agree, I will update in next patch version.
>
>> +			readl_relaxed(pcie->parf + PCIE20_PARF_PM_STTS));
>> +
>> +	return ret;
>> +}
>> +
>> +static void qcom_pcie_host_disable(struct qcom_pcie *pcie)
>> +{
>> +	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
>> +
> As Bjorn said this would only work for platforms supporting v2.7.0 ops. Please
> make it generic.
I removed platform specific code but forgot to remove above one. will 
update in next patch version.
>> +	/* Assert the reset of endpoint */
>> +	qcom_ep_reset_assert(pcie);
>> +
>> +	/* Put PHY into POWER DOWN state */
>> +	phy_power_off(pcie->phy);
>> +
>> +	writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> Define "1".
Sure, I will update in next patch version.
>
> Thanks,
> Mani
