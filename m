Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD6963320E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 02:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiKVBQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 20:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiKVBQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 20:16:24 -0500
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440B6365
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 17:16:23 -0800 (PST)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 16CC2202E3;
        Tue, 22 Nov 2022 09:16:18 +0800 (CST)
Message-ID: <90d22541-9a13-5a1c-374d-4449a49a5e16@rock-chips.com>
Date:   Tue, 22 Nov 2022 09:16:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     shawn.lin@rock-chips.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dwc: Round up num_ctrls if num_vectors is less than
 MAX_MSI_IRQS_PER_CTRL
Content-Language: en-GB
To:     Han Jingoo <jingoohan1@gmail.com>
References: <1669014996-177686-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPOBaE5_w94UGx+mEkNi+jzjk+Te3K6Mt6KaB5uLsWXSY192mA@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPOBaE5_w94UGx+mEkNi+jzjk+Te3K6Mt6KaB5uLsWXSY192mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaS0kZVh9LGR8ZGUhPGEMdQlUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITkhVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N006Cyo*Hz0vLChPEwIsTh4V
        Sz0KCg9VSlVKTU1CS0xCTExCS0NIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9IT0M3Bg++
X-HM-Tid: 0a849ce844dd2eb6kusn16cc2202e3
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/11/22 7:54, Han Jingoo wrote:
> On Sun, Nov 20, 2022 Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Some SoCs may only support 1 RC with a few MSIs support that the total numver of MSIs is
>> less than MAX_MSI_IRQS_PER_CTRL. In this case, num_ctrls will be zero which fails setting
>> up MSI support. Fix it by rounding up num_ctrls to at least one.
> 
> Hi Shawn Lin,
> 
> If you find only a single case (1RC with a few MSIs), please set it as one
> if the divided value is zero.
> 

Yes we have one such platform. Will set it to one as your comment.

Thanks.

> For example,
> num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> if (num_ctrls < 1)
>      num_ctrls = 1
> 
> Best regards,
> Jingoo Han
> 
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 39f3b37..2cba2a8 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -61,7 +61,7 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
>>          irqreturn_t ret = IRQ_NONE;
>>          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>
>> -       num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> +       num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
>>
>>          for (i = 0; i < num_ctrls; i++) {
>>                  status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
>> @@ -342,7 +342,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>>
>>          if (!pp->num_vectors)
>>                  pp->num_vectors = MSI_DEF_NUM_VECTORS;
>> -       num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> +       num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
>>
>>          if (!pp->msi_irq[0]) {
>>                  pp->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
>> @@ -706,7 +706,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>>          dw_pcie_setup(pci);
>>
>>          if (pp->has_msi_ctrl) {
>> -               num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>> +               num_ctrls = DIV_ROUND_UP(pp->num_vectors, MAX_MSI_IRQS_PER_CTRL);
>>
>>                  /* Initialize IRQ Status array */
>>                  for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
>> --
>> 2.7.4
>>
