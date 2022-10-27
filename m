Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6960F4CE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 12:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiJ0KVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 06:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiJ0KV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 06:21:26 -0400
X-Greylist: delayed 1529 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Oct 2022 03:21:22 PDT
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7B9A3F53;
        Thu, 27 Oct 2022 03:21:19 -0700 (PDT)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.17])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1onzbq-000Jzi-LI; Thu, 27 Oct 2022 10:55:35 +0100
Message-ID: <6bba0876-3002-0614-5aeb-c4cf901938ca@codethink.co.uk>
Date:   Thu, 27 Oct 2022 10:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH V1] PCI: dwc: Use dev_info for PCIe link down event
 logging
Content-Language: en-GB
To:     Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20221018164329.GA3808783@bhelgaas>
 <8670e757-7275-57eb-3f5c-0a21ba354e37@nvidia.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <8670e757-7275-57eb-3f5c-0a21ba354e37@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/10/2022 12:39, Jon Hunter wrote:
> Hi Lorenzo,
> 
> On 18/10/2022 17:43, Bjorn Helgaas wrote:
>> On Tue, Oct 18, 2022 at 07:21:54AM +0100, Jon Hunter wrote:
>>> Hi Bjorn,
>>>
>>> On 13/09/2022 11:12, Vidya Sagar wrote:
>>>> Some of the platforms (like Tegra194 and Tegra234) have open slots and
>>>> not having an endpoint connected to the slot is not an error.
>>>> So, changing the macro from dev_err to dev_info to log the event.
>>>>
>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
>>>> b/drivers/pci/controller/dwc/pcie-designware.c
>>>> index 650a7f22f9d0..25154555aa7a 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>> @@ -456,7 +456,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>>>>        }
>>>>        if (retries >= LINK_WAIT_MAX_RETRIES) {
>>>> -        dev_err(pci->dev, "Phy link never came up\n");
>>>> +        dev_info(pci->dev, "Phy link never came up\n");
>>>>            return -ETIMEDOUT;
>>>>        }
>>>
>>>
>>> Are you OK to take this change?
>>
>> When this came up, Lorenzo was in the middle of a big move and I was
>> covering for him while he was unavailable.  But he's back, and I'm
>> sure he will resolve this soon.
>>
>> Personally I'm OK either way.
>>
>> Bjorn
> 
> 
> Can we come to a conclusion on this?
> 
> We have tests that fail when errors/warning messages are reported. We 
> can choose to ignore these errors, but given that this is not an error 
> in this case, we were thinking it is better to make it informational.

Is there any hardware presence detect available to just avoid even
trying to bring a link up on an disconnected port?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

