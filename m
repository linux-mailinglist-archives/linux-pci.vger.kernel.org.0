Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E139F4BFA7B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 15:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiBVOLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 09:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiBVOLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 09:11:39 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389115FC81;
        Tue, 22 Feb 2022 06:11:13 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MEAxjP067667;
        Tue, 22 Feb 2022 08:10:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645539059;
        bh=CszZ7b7p5altQ3N0IR46/M0Kc7F2va/NMGOvBxW49hg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bE0rb2PzINSbqvn3IwMH2NpjHrx4xnfykv8x/0/whPY1PEWwT0i2xa7XL2XwvjhLL
         ekT3njg72oEfkWDrSDzXmTZP21SdbvQCwVI/sIE5n3sKyJmfX/eN2CR/h+ojV0NZ9d
         QZNVFSPQkLoTXHvZTqFXjDuw0QOEpmZg2PwW5118=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MEAxeO090573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 08:10:59 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 08:10:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 08:10:58 -0600
Received: from [10.250.234.209] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MEAsO8042175;
        Tue, 22 Feb 2022 08:10:55 -0600
Subject: Re: [PATCH] PCI: cadence: respond to received PTM Requests
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
References: <20220218132037.GA345784@bhelgaas>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <116138f6-8f44-66be-c6b9-ccfbab6b8ca2@ti.com>
Date:   Tue, 22 Feb 2022 19:40:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20220218132037.GA345784@bhelgaas>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 18/02/22 6:50 pm, Bjorn Helgaas wrote:
> On Fri, Feb 18, 2022 at 04:26:48PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Bjorn,
>>
>> On 01/02/22 3:35 am, Bjorn Helgaas wrote:
>>> Update subject line to match previous conventions ("git log --oneline
>>> drivers/pci/controller/cadence/pcie-cadence-host.c" to see).
>>>
>>> On Mon, Jan 31, 2022 at 01:08:27PM +0100, Christian Gmeiner wrote:
>>>> This enables the Controller [RP] to automatically respond
>>>> with Response/ResponseD messages.
>>>
> 
>>>> +static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
>>>> +{
>>>> +	u32 val;
>>>> +
>>>> +	val = cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
>>>> +	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
>>>
>>> I assume this is some device-specific enable bit that is effectively
>>> ANDed with PCI_PTM_CTRL_ENABLE in the Precision Time Measurement
>>> Capability?
>>
>> That's correct. This bit enables Controller [RP] to respond to the
>> received PTM Requests.
> 
> Great!  Christian, can you update the commit log to reflect that
> both this bit *and* PCI_PTM_CTRL_ENABLE must be set for the RP to
> respond to received PTM Requests?
> 
> When CDNS_PCIE_LM_TPM_CTRL_PTMRSEN is cleared, do PCI_PTM_CAP_ROOT
> and the PTM Responder Capable bit (for which we don't have a #define)
> read as zero?

I see both PTM Responder Capable bit and PTM Root Capable is by-default set to '1'.

root@am64xx-evm:~# devmem2 0xD000A24


/dev/mem opened.
Memory mapped at address 0xffffa8980000.
Read at address  0x0D000A24 (0xffffa8980a24): 0x00000406

And this bit can be programmed through the local management APB
interface if required.

But with this patch which enables PTM by default for RC, it wouldn't be required
to clear those bits.

Thanks,
Kishon
> 
> I think that would be the correct behavior per PCIe r6.0, sec
> 7.9.15.2, and it would avoid the confusion of having the PTM
> Capability register advertise functionality that cannot be enabled via
> the PTM Control register.
> 
>>>> +/* PTM Control Register */
>>>> +#define CDNS_PCIE_LM_PTM_CTRL 	(CDNS_PCIE_LM_BASE + 0x0DA8)
> 
> Other #defines in this file use lower-case hex.
> 
> Bjorn
> 
