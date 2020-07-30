Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4EB2336EE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 18:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgG3QgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgG3QgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 12:36:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA4C061574
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 09:36:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so4677095wmc.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S1aCYdPoeGMHVigqDhmSVS/0iI3rH3XUxq93UBUBmLE=;
        b=GinZB+IjDhATAZzkBkVQPc4JRFNmEQoZtM02fD1e8PWKM+pXL7nm+HAY94nbSuiF0a
         k5bq0TsfF2Pf9UMQv4NWb0K5BJb1eLuusLTX1cVKexHV2N9NHw8hQL4I7+Mb1tWYlCE7
         VBz/RToE9FgU/AKDoV5WVmNX+Oh1z//upqDlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S1aCYdPoeGMHVigqDhmSVS/0iI3rH3XUxq93UBUBmLE=;
        b=rixTN1AEdCU7n0DNWo+mIL+fkC4ndeuW7XyHlpzn5Z2ZZ8NSjXgea1WmNDCI4mgpzK
         GlpuSklnH23YgL6Fq/TxTs9DdfETeg7SJjdMxv4U3luB/WxdId92DSzVQ+1cyJ1y+Rau
         Q9WTYLyUdUlaLsu3PBd9ZtJAGbY2TzZ2lcsncGIGMoMPlIOkJzoFR8ZpK7i6DzhRWIDI
         /i1Esgsf3ZqpDDRbHwbWW4dM22UIZg4abTykIzULufQgSTC2IybbhnZbRisTyJXZ1UkZ
         iqTBaKFZBOGiNft0pxtEsvoy0bjGOnz+DituUHLKydrlk6vDAAo2F4co71ZFnc95r/LP
         l88w==
X-Gm-Message-State: AOAM530Zhz4sWZJGJqD6v8o1uuEcQ3MBX1H6a5VfDdYCPv8gUPwF5xfT
        y9/szVadtaMi5XGhnejybU3rog==
X-Google-Smtp-Source: ABdhPJyLMrcvytiMUQhGXw5eKV0bYn4zHwfWrBBit4SgNN4+eQcYTXWc5FxGizhobNot6NZrA5rYQg==
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr75889wmc.187.1596126981222;
        Thu, 30 Jul 2020 09:36:21 -0700 (PDT)
Received: from [10.136.8.246] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm9064543wmb.24.2020.07.30.09.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 09:36:19 -0700 (PDT)
Subject: Re: [PATCH 2/3] PCI: iproc: Stop using generic config read/write
 functions
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Cc:     bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
References: <20200730160958.GA2038661@bjorn-Precision-5520>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <18c0d88e-8aa0-c0a4-52f7-c9ae9fc5f495@broadcom.com>
Date:   Thu, 30 Jul 2020 09:36:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730160958.GA2038661@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/30/2020 9:09 AM, Bjorn Helgaas wrote:
> [+cc Lorenzo, Rob]
> 
> On Thu, Jul 30, 2020 at 03:37:46PM +1200, Mark Tomlinson wrote:
>> The pci_generic_config_write32() function will give warning messages
>> whenever writing less than 4 bytes at a time. As there is nothing we can
>> do about this without changing the hardware, the message is just a
>> nuisance. So instead of using the generic functions, use the functions
>> that have already been written for reading/writing the config registers.
> 
> The reason that pci_generic_config_write32() message is there is
> because, as the message says, a read/modify/write may corrupt bits in
> adjacent registers.  
> 
> It makes me a little queasy to do these read/modify/write sequences
> silently.  A generic driver doing an 8- or 16-bit config write has no
> idea that the write may corrupt an adjacent register.  That leads to
> bugs that are very difficult to debug and only reproducible on iProc.
> 
> The ratelimiting on the current pci_generic_config_write32() message
> is based on the call site, not on the device.  That's not ideal: we
> may emit several messages for device A, trigger ratelimiting, then do
> a write for device B that doesn't generate a message.
> 
> I think it would be better to have a warning once per device, so if
> XYZ device has a problem and we look at the dmesg log, we would find a
> single message for device XYZ as a hint.  Would that reduce the
> nuisance level enough?
> 

I'm in favor of this. I agree with you that we do need the warnings
because some PCIe config registers that are read/write to clear.

But the current amount of warning messages generated from these config
register access is quite massive and often concerns the users who are
less familiar with the reason/purpose of the warnings. We were asked
about these warnings by multiple customers. People freaked out when they
see "corrupt" in the warning messages, :)

Limiting the warning to once per device seems to be a reasonable
compromise to me.

Thanks,

Ray

> So I think I did it wrong in fb2659230120 ("PCI: Warn on possible RW1C
> corruption for sub-32 bit config writes").  Ratelimiting is the wrong
> concept because what we want is a single warning per device, not a
> limit on the similar messages for *all* devices, maybe something like
> this:
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..e5f956b7e3b7 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>  	 * write happen to have any RW1C (write-one-to-clear) bits set, we
>  	 * just inadvertently cleared something we shouldn't have.
>  	 */
> -	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
> +	if (!(bus->unsafe_warn & (1 << devfn))) {
> +		dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset %#x may corrupt adjacent RW1C bits\n",
>  			     size, pci_domain_nr(bus), bus->number,
>  			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
> +		bus->unsafe_warn |= 1 << devfn;
> +	}
>  
>  	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>  	tmp = readl(addr) & mask;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c79d83304e52..264b009fa4a6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -613,6 +613,7 @@ struct pci_bus {
>  	unsigned char	primary;	/* Number of primary bridge */
>  	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
>  	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
> +	u8		unsafe_warn;	/* warned about R/M/W config write */
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	int		domain_nr;
>  #endif
> 
>> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
>> ---
>>  drivers/pci/controller/pcie-iproc.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
>> index 2c836eede42c..68ecd3050529 100644
>> --- a/drivers/pci/controller/pcie-iproc.c
>> +++ b/drivers/pci/controller/pcie-iproc.c
>> @@ -709,12 +709,13 @@ static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>>  {
>>  	int ret;
>>  	struct iproc_pcie *pcie = iproc_data(bus);
>> +	int busno = bus->number;
>>  
>>  	iproc_pcie_apb_err_disable(bus, true);
>>  	if (pcie->iproc_cfg_read)
>>  		ret = iproc_pcie_config_read(bus, devfn, where, size, val);
>>  	else
>> -		ret = pci_generic_config_read32(bus, devfn, where, size, val);
>> +		ret = iproc_pci_raw_config_read32(pcie, busno, devfn, where, size, val);
>>  	iproc_pcie_apb_err_disable(bus, false);
>>  
>>  	return ret;
>> @@ -724,9 +725,11 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
>>  				     int where, int size, u32 val)
>>  {
>>  	int ret;
>> +	struct iproc_pcie *pcie = iproc_data(bus);
>> +	int busno = bus->number;
>>  
>>  	iproc_pcie_apb_err_disable(bus, true);
>> -	ret = pci_generic_config_write32(bus, devfn, where, size, val);
>> +	ret = iproc_pci_raw_config_write32(pcie, busno, devfn, where, size, val);
>>  	iproc_pcie_apb_err_disable(bus, false);
>>  
>>  	return ret;
>> -- 
>> 2.28.0
>>
