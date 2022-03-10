Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B54D4313
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 10:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiCJJHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 04:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240614AbiCJJHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 04:07:14 -0500
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF5137766;
        Thu, 10 Mar 2022 01:06:12 -0800 (PST)
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.21])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1nSEkK-0006xw-Oi; Thu, 10 Mar 2022 09:06:08 +0000
Message-ID: <53bccf99-c183-78f9-f6cb-2921228ced48@codethink.co.uk>
Date:   Thu, 10 Mar 2022 09:06:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC] PCI: fu740: Force Gen1 to fix initial device probing on
 some boards
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org
References: <20220310001539.GA94315@bhelgaas>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20220310001539.GA94315@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/03/2022 00:15, Bjorn Helgaas wrote:
> On Tue, Mar 08, 2022 at 09:45:36AM +0000, Ben Dooks wrote:
>> On 28/02/2022 23:22, Ben Dooks wrote:
>>> The fu740 PCIe core does not probe any devices on the SiFive Unmatched
>>> board without this fix (or having U-Boot explicitly start the PCIe via
>>> either boot-script or user command). The fix is to start the link at
>>> Gen1 speeds and once the link is up then change the speed back.
>>>
>>> The U-Boot driver claims to set the link-speed to Gen1 to get the probe
>>> to work (and U-Boot does print link up at Gen1) in the following code:
>>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_dw_sifive.c?id=v2022.01#L271
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> --
>>> Note, this patch has had significant re-work since the previous 4
>>> sets, including trying to fix style, message, reliance on the U-Boot
>>> fix and the comments about usage of LINK_CAP and reserved fields.
>>
>> The internal feedback is this version is passing on our CI.
>>
>> If there are no comments on this soon, I will post this as either the
>> v5 of the original or as a new patch.
> 
> Seems like this isn't quite baked yet.  Lorenzo has the v4 of this on
> his pci/fu740 branch, but I'm going to drop that for now because (a)
> this one is better and (b) it'd be nice to have an ack from a FU740
> maintainer (Paul or Greentime).

Yes. I'll fix the comments up and try and get this out later in the
week. I hope the GPIO patch is easier and can be merged on its own.

It would be great if someone at SiFive could comment on this, I don't
really have a lot of info other than this doesn't work for any of our
boards. I just assume that everyone else boots from NVME and it just
works for them.

> I'm also not clear on whether this works around a general FU740 defect
> or something specific to the Unmatched board or the ASMedia ASM2824
> switch.  This patch currently limits to 2.5GT/s on *all* FU740
> devices.

I am not sure on this either, all I have is a pair of Unmatched boards
and neither work without this fix in. Has the FU740 been used by anyone
other than this board?

I have not verified with a speed test any of this yet. It should do
2.5GT/s as initial probe and then attempt to get the link back to
the maximum speed once the device has probed. It seems once the
ASM2824 has done the first initialisation it will then continue
back at the higher speed.

Once the ASM2824 is working it seems the rest will follow.

> I'd prefer to use "2.5GT/s" instead of "Gen1" in the subject, commit
> log, and comments because it's more specific and matches the
> PCI_EXP_LNKCAP_SLS_2_5GB in the code.

Ok, will do.

>>> ---
>>>    drivers/pci/controller/dwc/pcie-fu740.c | 51 ++++++++++++++++++++++++-
>>>    1 file changed, 50 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
>>> index 842b7202b96e..16ad52f53490 100644
>>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>>> @@ -181,10 +181,59 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
>>>    {
>>>    	struct device *dev = pci->dev;
>>>    	struct fu740_pcie *afp = dev_get_drvdata(dev);
>>> +	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>> +	int ret;
>>> +	u32 orig, tmp;
>>> +
>>> +	/*
>>> +	 * Force Gen1 when starting link, due to some devices not
>>> +	 * probing at higher speeds. This happens with the PCIe switch
>>> +	 * on the Unmatched board. The fix in U-Boot is to force Gen1
>>> +	 * and hope later resets will clear this capaility.
> 
> s/capaility/capability/
> 
> But the sentence still doesn't quite make sense.  Are you saying that
> if we bring the link up at 2.5GT/s, it will stay there?
> 
> And that a future reset may clear Link Capabilities?  Actually, I
> guess you don't want it *cleared*, you would just want it to
> accurately reflect the real max link speed, which would not be 0000b
> in the register (since that's not even a defined encoding).

So what I've seen is if U-boot does the initial probe at 2.5GT/s and
then Linux comes along and does the reset itself, the LINKCAP gets
set back to the original full speed then the device probe works under
Linux. I've not verified with any NVME speed test yet.

> And the reset would also cause link retrain that would then use the
> real max link speed?

I think so, the only verification I have done is lspci to check what
the link is reporting.

>>> +	dev_dbg(dev, "cap_exp at %x\n", cap_exp);
>>> +	dw_pcie_dbi_ro_wr_en(pci);
>>> +
>>> +	tmp = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCAP);
>>> +	orig = tmp & PCI_EXP_LNKCAP_SLS;
>>> +	tmp &= ~PCI_EXP_LNKCAP_SLS;
>>> +	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
>>> +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
>>>    	/* Enable LTSSM */
>>>    	writel_relaxed(0x1, afp->mgmt_base + PCIEX8MGMT_APP_LTSSM_ENABLE);
>>> -	return 0;
>>> +
>>> +	ret = dw_pcie_wait_for_link(pci);
>>> +	if (ret) {
>>> +		dev_err(dev, "error: link did not start\n");
>>> +		goto err;
>>> +	}
>>> +
>>> +	tmp = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCAP);
>>> +	if ((tmp & PCI_EXP_LNKCAP_SLS) != orig) {
>>> +		dev_dbg(dev, "changing speed back to original\n");
>>> +
>>> +		tmp &= ~PCI_EXP_LNKCAP_SLS;
>>> +		tmp |= orig;
>>> +		dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCAP, tmp);
>>> +
>>> +		tmp = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>>> +		tmp |= PORT_LOGIC_SPEED_CHANGE;
>>> +		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>>> +
>>> +		ret = dw_pcie_wait_for_link(pci);
>>> +		if (ret) {
>>> +			dev_err(dev, "error: link did not start at new speed\n");
>>> +			goto err;
>>> +		}
>>> +	}
>>> +
>>> +	ret = 0;
>>> +err:
>>> +	// todo - if we do have an unliekly error, what do we do here?
> 
> Wrong comment style (use /* */, not //), and s/unliekly/unlikely/

Ok, if no-one has a better idea I am just going to return the error
code for now.

> 
>>> +	dw_pcie_dbi_ro_wr_dis(pci);
>>> +	return ret;
>>>    }
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
