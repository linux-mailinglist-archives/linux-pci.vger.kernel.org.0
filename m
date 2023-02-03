Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9377689260
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 09:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjBCId4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 03:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjBCIdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 03:33:55 -0500
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 00:33:51 PST
Received: from mail-m11875.qiye.163.com (mail-m11875.qiye.163.com [115.236.118.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4B070987
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 00:33:50 -0800 (PST)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11875.qiye.163.com (Hmail) with ESMTPA id 5224928017B;
        Fri,  3 Feb 2023 16:23:53 +0800 (CST)
Message-ID: <8b40a27b-8480-dd74-3fd1-6f6493dc0ce1@rock-chips.com>
Date:   Fri, 3 Feb 2023 16:23:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     shawn.lin@rock-chips.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [RESEND PATCH v2] PCI: dwc: Round up num_ctrls if num_vectors is
 less than MAX_MSI_IRQS_PER_CTRL
Content-Language: en-GB
To:     Han Jingoo <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1669080013-225314-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPOBaE6KNXn56Gs8DCUg9nMqDPF494OaM58JYHsaKVsFRbvt5A@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPOBaE6KNXn56Gs8DCUg9nMqDPF494OaM58JYHsaKVsFRbvt5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEpPVk8fHU4YTU9MSR5MTVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6Ayo6Hj0OTTA1TwEiSTY1
        CRcaFCpVSlVKTUxOT0pJTUhPS05KVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9KSk83Bg++
X-HM-Tid: 0a86165ff7be2eb1kusn5224928017b
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/11/23 6:04, Han Jingoo wrote:
> On Mon, Nov 21, 2022 Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Some SoCs may only support 1 RC with a few MSIs support that the total number of MSIs is
>> less than MAX_MSI_IRQS_PER_CTRL. In this case, num_ctrls will be zero which fails setting
>> up MSI support. Fix it by rounding up num_ctrls to at least one.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thanks, Jingoo!

Hi Lorenzo,

Is there any chance this patch be applied? :)

> 
> Best regards,
> Jingoo Han
> 
>> ---
>>
>> Changes in v2:
>> - set num_ctrls to 1 if it's less than one
>>
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 39f3b37..cfce1e0 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -62,6 +62,8 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>>          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>
>>          num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> +       if (num_ctrls < 1)
>> +               num_ctrls = 1;
>>
>>          for (i = 0; i < num_ctrls; i++) {
>>                  status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
>> @@ -343,6 +345,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>          if (!pp->num_vectors)
>>                  pp->num_vectors = MSI_DEF_NUM_VECTORS;
>>          num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> +       if (num_ctrls < 1)
>> +               num_ctrls = 1;
>>
>>          if (!pp->msi_irq[0]) {
>>                  pp->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
>> @@ -707,6 +711,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>>
>>          if (pp->has_msi_ctrl) {
>>                  num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> +               if (num_ctrls < 1)
>> +                       num_ctrls = 1;
>>
>>                  /* Initialize IRQ Status array */
>>                  for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
>> --
>> 2.7.4
>>
