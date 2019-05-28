Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445352D07D
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2019 22:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfE1UgT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 May 2019 16:36:19 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:43612 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbfE1UgT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 May 2019 16:36:19 -0400
Received: from [192.168.1.6] (hst-221-75.medicom.bg [84.238.221.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id D61BDCE7A;
        Tue, 28 May 2019 23:36:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1559075775; bh=g+Hfg4posZg3AUYJ3It3ByOqzPQB98FnrethUDe+8Xg=;
        h=Subject:To:Cc:From:Date:From;
        b=TBXkb60YPLkal0//XJbR3vlXRAvOxWsHpZaXB5HIpivsJ/8xI51yryQ2k14pdbSVJ
         rr5avRAE01zaNaCQ3T1j+45NagX9o7tHZACFkdi5LuB9sFzIlcrR7PC+Yu483ldOZX
         GvJ7LdRtxrB3wsLMEZMWllixayCalR39FozLoizCokOCfCoyvNoAQ7F8NWpUX09QYy
         qpzQIVkzMJMlD0G+F3D7183tv92az6htxnGVWPzO1JmAhYhP1w0TtQylL/ODKshUxZ
         +4DxazuU+g2HbN9fpt0cWHdwOeJWX9pMEFgbohTAb1phDhO5xF0dok6iAViTjpjjlW
         IFb4H9F7yDXVw==
Subject: Re: [PATCH] PCI: qcom: Ensure that PERST is asserted for at least 100
 ms
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Andy Gross <agross@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190523194409.17718-1-niklas.cassel@linaro.org>
 <5d743969-e763-95c5-6763-171a8ecf66d8@free.fr>
 <20190527171521.GA7936@centauri>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <0fa706f8-1aae-4cf6-08c9-6f12ba342eab@mm-sol.com>
Date:   Tue, 28 May 2019 23:36:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527171521.GA7936@centauri>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Niklas,


On 27.05.19 г. 20:15 ч., Niklas Cassel wrote:
> On Fri, May 24, 2019 at 02:43:00PM +0200, Marc Gonzalez wrote:
>> On 23/05/2019 21:44, Niklas Cassel wrote:
>>
>>> Currently, there is only a 1 ms sleep after asserting PERST.
>>>
>>> Reading the datasheets for different endpoints, some require PERST to be
>>> asserted for 10 ms in order for the endpoint to perform a reset, others
>>> require it to be asserted for 50 ms.
>>>
>>> Several SoCs using this driver uses PCIe Mini Card, where we don't know
>>> what endpoint will be plugged in.
>>>
>>> The PCI Express Card Electromechanical Specification specifies:
>>> "On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL) from
>>> the power rails achieving specified operating limits."
>>>
>>> Add a sleep of 100 ms before deasserting PERST, in order to ensure that
>>> we are compliant with the spec.
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 0ed235d560e3..cae24376237c 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -1110,6 +1110,8 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>>>   	if (IS_ENABLED(CONFIG_PCI_MSI))
>>>   		dw_pcie_msi_init(pp);
>>>   
>>> +	/* Ensure that PERST has been asserted for at least 100 ms */
>>> +	msleep(100);
>>>   	qcom_ep_reset_deassert(pcie);
>>>   
>>>   	ret = qcom_pcie_establish_link(pcie);
>>
>> Currently, qcom_ep_reset_assert() and qcom_ep_reset_deassert() both include
>> a call to usleep_range() of 1.0 to 1.5 ms
>>
>> Can we git rid of both if we sleep 100 ms before qcom_ep_reset_deassert?
> 
> These two sleeps after asserting/deasserting reset in qcom_ep_reset_assert()/
> qcom_ep_reset_deassert() matches the sleeps in:
> https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n1942
> 
> and
> 
> https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n1949
> 
> I would rather not remove these since that might affect existing devices.
> 
> 
> This new sleep matches matches the sleep in:
> https://source.codeaurora.org/quic/la/kernel/msm-4.14/tree/drivers/pci/host/pci-msm.c?h=LA.UM.7.1.r1-14000-sm8150.0#n3926
> 
>>
>> Should the msleep() call be included in one of the two wrappers?
> 
> This new sleep could be moved into qcom_ep_reset_deassert(),
> added before the gpiod_set_value_cansleep(pcie->reset, 0) call,
> if Stanimir prefers it to be placed there instead.

yes, please move the sleep in qcom_ep_reset_deassert()

with that:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

regards,
Stan
