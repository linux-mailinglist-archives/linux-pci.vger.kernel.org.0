Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750155E1EC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbiF1Gjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 02:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244915AbiF1Gjq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 02:39:46 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A44963F2;
        Mon, 27 Jun 2022 23:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656398385; x=1687934385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dTErzmLH5ZHIjQUkNmNaIb3uNsi2iBqM4S69SRgvXmk=;
  b=NiDGev/5TfWJUyklFbD1Db4JJq5J1JdmpK02faM+PWI1SYtwW0LY6H7O
   qFa49psXi4aKp2xr/6jSQNbMEwnrnAauf24bRzgLot65B1cAZ9grm1MEu
   gxo/Lo5KiUMK+WYp4F062j1FSgrkdcss+D+mPy+Sp7l83P/zTi+wsm3D+
   E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 23:39:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 23:39:44 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 23:39:43 -0700
Received: from [10.216.62.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 23:39:36 -0700
Message-ID: <050108d3-20fc-fb10-dd79-093974bcc401@quicinc.com>
Date:   Tue, 28 Jun 2022 12:09:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/3] PCI: qcom: Add missing sc7280 clocks in PCIe
 driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <swboyd@chromium.org>,
        <dmitry.baryshkov@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@codeaurora.org>
References: <20220624170501.GA1541553@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220624170501.GA1541553@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/24/2022 10:35 PM, Bjorn Helgaas wrote:
> [+cc Prasad, who added sc7280]
> On Fri, Jun 24, 2022 at 02:49:49PM +0530, Krishna chaitanya chundru wrote:
>> Add missing clocks in the pcie driver.
> s/pcie/PCIe/ as in subject.  Also, please mention the names of the
> clocks here, too.
Will correct in next patch.
> Does this add new functionality, or did sc7280 just never work in the

When ever system goes to suspend the pcie link is also going down even 
though

we didn't unvote any clocks/regulators.

When we added these two missing clocks, the link is stable now after 
suspend and resume also.

We didn't test suspend/resume previously that is reason we didn't see 
any issue.

> first place?
>
> If this fixes a problem, it's nice to mention the user-visible symptom
> in the commit log to make it easier to connect this fix with the
> problem.
Will update in the next patch.
> Looks like sc7280 was added by Prasad with b89ff410253d ("PCI: qcom:
> Replace ops with struct pcie_cfg in pcie match data"), and I assume it
> was tested at that time.
>
> If I had noticed, I would have asked that b89ff410253d be a strict
> conversion to struct qcom_pcie_cfg with no functional changes, with
> sc7280 support being added in a separate patch by itself.
FYI. Prasad has left our org and no longer associated with our org now.
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 2ea1375..a7202f0 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1548,7 +1548,10 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
>>   static const struct qcom_pcie_cfg sc7280_cfg = {
>>   	.ops = &ops_1_9_0,
>>   	.has_tbu_clk = true,
>> +	.has_ddrss_sf_tbu_clk = true,
>>   	.pipe_clk_need_muxing = true,
>> +	.has_aggre0_clk = true,
>> +	.has_aggre1_clk = true,
>>   };
>>   
>>   static const struct qcom_pcie_cfg sc8180x_cfg = {
>> -- 
>> 2.7.4
>>
