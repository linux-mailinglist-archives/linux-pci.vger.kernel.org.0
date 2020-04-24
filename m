Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215D71B6E97
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 09:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDXHC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 03:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725898AbgDXHC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 03:02:27 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63907C09B045
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 00:02:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k12so659383wmj.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CCDUuhsrd79iPy9h/1MYt3DpQA4TodIHzMfteKnp6Us=;
        b=tf563taPAe5LAtfA2HfrfUM44+NuQT2CEm76ajmyiF7y8wHGgJIG/2tZ3Om5CfUpP3
         lw37UXaua/JiU6Gsf4T+rHf5oLYZFj0kjvYcDAjfh7yaBEOrPak3FWCEgYvw1/WD+B/A
         VXmxQrdySSQCECgLmBpYMvvvFOOl615HJhlcG3Dr0GojtCq8Rwm/tbL1siQmo/kYvvLE
         qbjI5uOFKY9rLquRjL3641V9vcSOZzuWeycRO4eYUXA1bCGpdwaYswsWlVBHoKxtRArh
         WJ5ia7/b7nJzvwYxAvZhY3Mhi+Ye4X9mYcZ05F9+0KoMgvjEgft27uTkAXmnEEP04CNM
         ViXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CCDUuhsrd79iPy9h/1MYt3DpQA4TodIHzMfteKnp6Us=;
        b=GkNiWuuJeMY0Ys7+kgGQWHx0SZ+OJovBWa1abtqlozS182QH/0Ql9afqCFda2ydZ95
         hBEBsyKQwqJ1i6qPuKup02mNXKus4jEwmaJBHZ/9+PUGYTa5qiIKUtsexHf7XIzCsRg8
         Sr0kkA6bcP09KLfHsO/3mIA8eleEnJNp4qbhfCQGgOixEnk9oiWuShlmWobdUOYBB1lC
         UT18UFqa6UWaQmtE+/J0H/WKGQAD8G1uq/tFneF3OgfnmTzQlKv8bdyQBD9DRJE0ItGE
         VuAm3aU3zyxZr3AoRDysQ7aL8MnhcCwLqk/RntZnir00ywVmWXO63yscGYmiUom4NeJ6
         9zYw==
X-Gm-Message-State: AGi0PubpapERVZSg7xhf1s8qO4VXBH7vYnPM/UMVBqtpS1dcqVbjEmHI
        uhxGvCAkNeTBqLTFI0qXl/2ETEFZgDpgpg==
X-Google-Smtp-Source: APiQypJ/Tc+WT4HVYoMC7FmO7mZBQmPWh8iz5YQP5xr8gr+BMNBElve95WU7Efgc8U8YXfcbnP4rzw==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr8098530wmb.41.1587711745630;
        Fri, 24 Apr 2020 00:02:25 -0700 (PDT)
Received: from net.saheed (563BD1A4.dsl.pool.telekom.hu. [86.59.209.164])
        by smtp.gmail.com with ESMTPSA id k17sm1585341wmi.10.2020.04.24.00.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 00:02:25 -0700 (PDT)
Subject: Re: [PATCH RFC] pci: Make return value of pcie_capability_read*()
 consistent
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org
References: <20200423223819.GA248903@google.com>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <83f65f3f-6586-3986-4c5e-011735758c7e@gmail.com>
Date:   Fri, 24 Apr 2020 08:02:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423223819.GA248903@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/24/20 12:38 AM, Bjorn Helgaas wrote:
> On Thu, Apr 23, 2020 at 07:55:17PM +0800, Yicong Yang wrote:
>> On 2020/4/19 14:51, Bolarinwa Olayemi Saheed wrote:
>>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>>> index 79c4a2ef269a..451f2b8b2b3c 100644
>>> --- a/drivers/pci/access.c
>>> +++ b/drivers/pci/access.c
>>> @@ -409,7 +409,7 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
>> Maybe provide some comments for the function, to notify the outside
>> users to do the error code conversion.
> A short function comment about the set of possible return values
> wouldn't hurt.  We don't have those for pci_read_config_word() and
> friends, and there are several pcie_capability_*() functions.  I don't
> think it's worth repeating the comment for every function, so maybe we
> could just extend the existing comment at pcie_capability_read_word().

Is enough to adjust the comment on pcie_capability_read_word() to this:

    /*
      * Note that these accessor functions are only for the "PCI Express
      * Capability" (see PCIe spec r3.0, sec 7.8).  They do not apply to the
      * other "PCI Express Extended Capabilities" (AER, VC, ACS, MFVC, etc.)
      *
      * On error, this function returns a PCIBIOS_* error code,
      * you may want to use pcibios_err_to_errno()(include/linux/pci.h)
      * to convert to a non-PCI code
      */

>> BTW, pci_{read, write}_config_*() may also have the issues that
>> export the private err code outside. You may want to solve these in
>> a series along with this patch.
> If you see a specific issue, please point it out.
>
> I looked at pci_read_config_word(), and it can return
> PCIBIOS_DEVICE_NOT_FOUND, PCIBIOS_BAD_REGISTER_NUMBER, or the return
> value from bus->ops->read().
>
> I looked at all the users of PCIBIOS_*.  There's really no interesting
> use of any of them except by pcibios_err_to_errno() and
> xen_pcibios_err_to_errno(), so I'm not sure it's even worth keeping
> them.
>
> But I think it's probably more work to excise all of them than it is
> to simply make pci_read_config_word() and pcie_capability_read_word()
> return the same set of error values.  So I think we should do this
> first.
>
>>>   	*val = 0;
>>>   	if (pos & 1)
>>> -		return -EINVAL;
>>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>   
>>>   	if (pcie_capability_reg_implemented(dev, pos)) {
>>>   		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
>>> @@ -444,7 +444,7 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
>>>   
>>>   	*val = 0;
>>>   	if (pos & 3)
>>> -		return -EINVAL;
>>> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>>>   
>>>   	if (pcie_capability_reg_implemented(dev, pos)) {
>>>   		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);

Also, can I just send this as a single patch while we conclude on 
pcie_capability_write*() ?

Thank you.

- Saheed

