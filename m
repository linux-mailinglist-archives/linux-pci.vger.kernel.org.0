Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABF34550A8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 23:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbhKQWoW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 17:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbhKQWoW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 17:44:22 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB5CC061570
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 14:41:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so7588252wrr.8
        for <linux-pci@vger.kernel.org>; Wed, 17 Nov 2021 14:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=3Xog6KRJSBNHCaE0UbI1LliJNRROeL4/g6wZV+C2IA8=;
        b=ZtPRlNiybHAEBss4Nh0zPZnRxMvb9UQ1vmdR4X/Jr3SLbq4k/EW99Wa7R9hjjJoFBv
         uuJY39kxp/s0Hs4gJ52hOWBjqfCSLgmVNB31fVNS7H6rUJh9NuVCX4JR28zhySyUxIOT
         A4WIUv84L/om5jT/TXA3brfcqgqCNaAyWi2Mnqt57/649i0Nu8mBotjjaqXdj4esKfql
         tJe4c9lXHK865lNLOjjsu1Pb2U023MMB07fzeTikqz3hNSFbN3JQyu5OCPvmmwSwhbUa
         LvL/3LzSQufZ13Ghjy7+zVEb4ze7Q1PtMlgE1+kdpAPU9phx0J1aXZXPZoEHBz/GmMtT
         0lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=3Xog6KRJSBNHCaE0UbI1LliJNRROeL4/g6wZV+C2IA8=;
        b=GHH7B4hOwY/eL207afFI2pXDsqNQ6qU2iaDcJJIMA7T0EcCmOCrf+bYcmVIrM1k/Uy
         jSvoX4w0xPyic4SaSvd62VpqYTg2tC8hC3lcYuLEBDY1bxJz+y7IHWb8ZpX0LsWRjXzk
         C08pzZ9bVEmGx298LQPUdjLSYOmPJxSHCRErIunpQA+hYWnE5valm4yjHPN6gu29CxFp
         I59XMbLcG41QAIHslUU2g+WvdTlHyoIw+k7rcn98Y6ThGavcZgsp91Tzd06jhjrpIWOW
         SJWLmwBKEyw+F2DJExAhzr3z8BvjIcwcrsZehrZGOS/1qpE3Vv30NYnQT9fzI96XcEXG
         KYhg==
X-Gm-Message-State: AOAM533j/nhJPWMBK29b79HnGgGVeeLNtjGPLfIZvr01T1AivGZHaQ1o
        KG4IEIk7ClaCEyuPj9+ZJkf9D0RUOnY=
X-Google-Smtp-Source: ABdhPJyYnnvtImdCrFx8CHUkn9fvyCkEykZkUQ/3aAkS4MEDR260SqZwNYGTtmVyGMTNX1INiLmexA==
X-Received: by 2002:a5d:64eb:: with SMTP id g11mr24983153wri.438.1637188881520;
        Wed, 17 Nov 2021 14:41:21 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:f0f5:b870:7292:e828? (p200300ea8f1a0f00f0f5b8707292e828.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:f0f5:b870:7292:e828])
        by smtp.googlemail.com with ESMTPSA id 38sm1157230wrc.1.2021.11.17.14.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 14:41:21 -0800 (PST)
Message-ID: <4a71d004-e23b-37e8-3702-a059be248210@gmail.com>
Date:   Wed, 17 Nov 2021 23:41:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
References: <20211117221955.GA1780304@bhelgaas>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] PCI/VPD: Add simple sanity check to pci_vpd_size()
In-Reply-To: <20211117221955.GA1780304@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17.11.2021 23:19, Bjorn Helgaas wrote:
> On Wed, Nov 17, 2021 at 10:31:51PM +0100, Heiner Kallweit wrote:
>> On 13.10.2021 20:37, Heiner Kallweit wrote:
>>> We have a problem with a device where each VPD read returns 0x33 [0].
>>> This results in a valid VPD structure (except the tag id) and
>>> therefore pci_vpd_size() scans the full VPD address range.
>>> On an affected system this took ca. 80s.
>>>
>>> That's not acceptable, on the other hand we may not want to re-add
>>> the old tag checks. In addition these tag check still wouldn't be able
>>> to avoid the described scenario 100%.
>>> Instead let's add a simple sanity check on the number of found tags.
>>> A VPD image conforming to the PCI spec [1] can have max. 4 tags:
>>> id string, ro section, rw section, end tag.
>>>
>>> [0] https://lore.kernel.org/lkml/20210915223218.GA1542966@bjorn-Precision-5520/
>>> [1] PCI 3.0 I.3.1. VPD Large and Small Resource Data Tags
>>>
>>> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/pci/vpd.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
>>> index a4fc4d069..921470611 100644
>>> --- a/drivers/pci/vpd.c
>>> +++ b/drivers/pci/vpd.c
>>> @@ -56,6 +56,7 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>>>  {
>>>  	size_t off = 0, size;
>>>  	unsigned char tag, header[1+2];	/* 1 byte tag, 2 bytes length */
>>> +	int num_tags = 0;
>>>  
>>>  	while (pci_read_vpd_any(dev, off, 1, header) == 1) {
>>>  		size = 0;
>>> @@ -63,6 +64,10 @@ static size_t pci_vpd_size(struct pci_dev *dev)
>>>  		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
>>>  			goto error;
>>>  
>>> +		/* We can have max 4 tags: STRING_ID, RO, RW, END */
>>> +		if (++num_tags > 4)
>>> +			goto error;
>>> +
>>>  		if (header[0] & PCI_VPD_LRDT) {
>>>  			/* Large Resource Data Type Tag */
>>>  			if (pci_read_vpd_any(dev, off + 1, 2, &header[1]) != 2) {
>>>
>>
>> Can this one be picked up for next?
> 
> I'm hesitating because we (or maybe just "I" :)) worked so hard to
> avoid interpreting the VPD data, and now we're back to that.
> 
> There's nothing of value in this particular device's VPD.  Is there
> any reason we shouldn't just use quirk_blacklist_vpd() for it?
> 
The bogus device we talk about has vendor/device id of an Intel card,
we could blacklist just based on subvendor/device id. Seems the
quirk mechanism doesn't support subvendor id level.

In general: Once we blacklist this device, tomorrow another similarly
broken one may come. Therefore I'd prefer the more general approach.
But I see your point. If (theoretically) the next PCI spec would introduce
a new VPD tag, then we most likely would get to know about this only
once somebody complains about reading VPD from his shiny new card fails.
So it's a tradeoff ..

> Bjorn
> 
Heiner
