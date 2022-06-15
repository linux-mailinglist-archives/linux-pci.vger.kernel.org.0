Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113DD54C982
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349070AbiFONOc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 09:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiFONOa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 09:14:30 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604482A943;
        Wed, 15 Jun 2022 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655298868; x=1686834868;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=37JFSAJb+yBqLEcxkMyXiMXO+ToiIUZywb5Saztiwu4=;
  b=zW51S3AJsNwfIHyOl4/MqGjNSHNVqSFPfNRhksDyoYPtW1UauTODvq2X
   DCTOklkOsIN6csdpm9InhJPBZx83oZWPARSISmVa5TLouXNyKq8FGN7k7
   eUcPCsqMcKZOXclg1VmSLy0pFAqaYExK1fYAVyjbVN6Nk0DG1iWhhiGOR
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2022 06:14:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 06:14:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 15 Jun 2022 06:14:27 -0700
Received: from [10.216.37.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 15 Jun
 2022 06:14:22 -0700
Message-ID: <1e92745e-6fa4-a3bd-d0cb-5c1f78efbead@quicinc.com>
Date:   Wed, 15 Jun 2022 18:44:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1] PCI: qcom: Allow L1 and its sub states on qcom dwc
 wrapper
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_ramkri@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1654240730-31322-1-git-send-email-quic_krichai@quicinc.com>
 <CAE-0n52hpKxMG=gq1rPGx0cM2VKNRo+WHVW+ExCScJ8UwZKgGA@mail.gmail.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAE-0n52hpKxMG=gq1rPGx0cM2VKNRo+WHVW+ExCScJ8UwZKgGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/9/2022 3:47 AM, Stephen Boyd wrote:
> Quoting Krishna chaitanya chundru (2022-06-03 00:18:50)
>> Allow L1 and its sub-states in the qcom dwc pcie wrapper.
>> By default its disabled. So enable it explicitly.
>>
> Would be good to add some more details about why it's disabled by
> default. I guess it's disabled by default in the hardware and enabling
> it is OK to do unconditionally for all qcom dwc pcie devices?

This is disabled by default in the hardware. We can enable this for all 
qcom devices unconditionally because

Adding this patch alone will not allow aspm transitions we need to 
enable aspm configs. If particular devices doesn't want aspm

they can disable using aspm configs.

