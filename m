Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8165675BC52
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 04:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGUCez (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 22:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGUCey (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 22:34:54 -0400
X-Greylist: delayed 896 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 19:34:52 PDT
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com [115.236.118.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40D211B;
        Thu, 20 Jul 2023 19:34:52 -0700 (PDT)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11876.qiye.163.com (Hmail) with ESMTPA id B6C3D3C0985;
        Fri, 21 Jul 2023 10:09:18 +0800 (CST)
Message-ID: <6f1eb449-5609-0b17-1323-0d114c38d969@rock-chips.com>
Date:   Fri, 21 Jul 2023 10:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     shawn.lin@rock-chips.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Content-Language: en-GB
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Frank Li <Frank.li@nxp.com>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad> <20230720142509.GB48270@thinkpad>
 <ZLlGsM/D/b+udmAD@lizhi-Precision-Tower-5810>
 <20230720160738.GC48270@thinkpad>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20230720160738.GC48270@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoZTVYaS0xOTE4YSEtDH0pVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpMVUpLS1VLWQ
        Y+
X-HM-Tid: 0a89763569f62eb2kusnb6c3d3c0985
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6Hzo4FD1NSAJCORIRQk5C
        OUkKCTxVSlVKTUNCQktOSE5CQ0NCVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU5PQ0w3Bg++
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2023/7/21 0:07, Manivannan Sadhasivam wrote:
> On Thu, Jul 20, 2023 at 10:37:36AM -0400, Frank Li wrote:
>> On Thu, Jul 20, 2023 at 07:55:09PM +0530, Manivannan Sadhasivam wrote:
>>> On Tue, Jul 18, 2023 at 03:34:26PM +0530, Manivannan Sadhasivam wrote:
>>>> On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
>>>>> On Mon, Jul 17, 2023 at 10:15:26PM +0530, Manivannan Sadhasivam wrote:
>>>>>> On Wed, Apr 19, 2023 at 12:41:17PM -0400, Frank Li wrote:
>>>>>>> Introduced helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.
>>>>>>> Added API pme_turn_off and exit_from_l2 for managing L2/L3 state transitions.
>>>>>>>
>>>>>>> Typical L2 entry workflow:
>>>>>>>
>>>>>>> 1. Transmit PME turn off signal to PCI devices.
>>>>>>> 2. Await link entering L2_IDLE state.
>>>>>>
>>>>>> AFAIK, typical workflow is to wait for PME_To_Ack.
>>>>>
>>>>> 1 Already wait for PME_to_ACK,  2, just wait for link actual enter L2.
>>>>> I think PCI RC needs some time to set link enter L2 after get ACK from
>>>>> PME.
>>>>>
>>>
>>> One more comment. If you transition the device to L2/L3, then it can loose power
>>> if Vaux was not provided. In that case, can all the devices work after resume?
>>> Most notably NVMe?
>>
>> I have not hardware to do such test, NVMe driver will reinit everything after
>> resume if no L1.1\L1.2 support. If there are L1.1\L1.2, NVME expect it leave
>> at L1.2 at suspend to get better resume latency.
>>
> 
> To be precise, NVMe driver will shutdown the device if there is no ASPM support
> and keep it in low power mode otherwise (there are other cases as well but we do
> not need to worry).
> 
> But here you are not checking for ASPM state in the suspend path, and just
> forcing the link to be in L2/L3 (thereby D3Cold) even though NVMe driver may
> expect it to be in low power state like ASPM/APST.
> 
> So you should only put the link to L2/L3 if there is no ASPM support. Otherwise,
> you'll ending up with bug reports when users connect NVMe to it.
> 


At this topic, it's very interesting to look at

drivers/pci/controller/dwc/pcie-tegra194.c


static int tegra_pcie_dw_suspend_noirq(struct device *dev)
{
         struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);

         if (!pcie->link_state)
                 return 0;

         tegra_pcie_downstream_dev_to_D0(pcie);
         tegra_pcie_dw_pme_turnoff(pcie);
         tegra_pcie_unconfig_controller(pcie);

         return 0;
}

It brings back all the downstream components to D0, as I assumed it was 
L0 indeed, before sending PME aiming to enter L2.

> - Mani
> 
>> This API help remove duplicate codes and it can be improved gradually.
>>
>>
>>>
>>> - Mani
>>>
>>>
>>> -- 
>>> மணிவண்ணன் சதாசிவம்
> 
