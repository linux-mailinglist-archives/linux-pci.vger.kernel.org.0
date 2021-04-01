Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A33518D9
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 19:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhDARr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhDARmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 13:42:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36E7C0225A4
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 08:27:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d191so1249437wmd.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GaEJQ5/vSpkw3N9ro5IHQy88KDveSAJD4br6dNdWdn4=;
        b=lfpzF1T/zwUWJJs+mEN8ZeTXirmdqdzYinbLKFA5iPOrjPWbnlenr42H7/10SqsUTg
         ZOlpWGzF7oNlW7easxy1ZDqCucquTewm1LVichUfN2oK0/YreerJgqAHqCLcNxM7AS3E
         Grrr8sf4sCWdMzmlqgK+0iQETY0jSSIIAAnpStVD9D5pqsB5gJNAiXCpKcKZpx5bwCox
         /cZKgqsiKjmEqi2FjutHygIiUxuXd4u6CEuiTg00ceYCl6mgI1wk8yvh+7mDj3Dg91kP
         CsrgXV8p6Xjvv1ijuQoOUnXcVlUsbXKLKmNhSY4NVW3EsogFX3pWR94TojZlzOLDI2Nc
         me/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GaEJQ5/vSpkw3N9ro5IHQy88KDveSAJD4br6dNdWdn4=;
        b=WbBPdTkDAuYbcXg2GftaIGbrmdkLwpmdWSQVtMCeXx+3oFv788qDqINLZdY621j+Gj
         vdPnQVkQAlLjzwaV7h2Heq5E6nHgbQInhs67XfY6Kjbxjn0vw4PXEyKYpfsJDAog1lPp
         cY12cIcLO4NRJmvgcyfzBDZr3x844dYL4q75ZlAHcY4dyZcufLt9DNNKkII4hS2Lwel/
         TEDhdkbdK97hcU/Cd9lZbhy9qEYKLjLeL7fDPUixJJDuCZxKyiwiE9PITliRA4C5XJ8V
         AHbeHm1k/NwXW8DqKJTXh1J09LhZx/X8TjumYtRicLpjB23Esl1lG2HmYffzJNa4KnnI
         uW8Q==
X-Gm-Message-State: AOAM533NkJFtdDI6+A2g8b1p9S6rIFhk+MKBgtQ15Y7fffUALjIIi1ZH
        BZFoS1iKKENxhew72zLK6nze2tz4+fUEXA==
X-Google-Smtp-Source: ABdhPJwlrxRnfW0zye/m/C+xrYAYpTXfQCAlRZm33GDcZ6pzso2tJlrvup6Hi9errK+Ejofn6kIwQA==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr8554446wmg.37.1617290823161;
        Thu, 01 Apr 2021 08:27:03 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:5544:e633:d47e:4b76? (p200300ea8f1fbb005544e633d47e4b76.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:5544:e633:d47e:4b76])
        by smtp.googlemail.com with ESMTPSA id u17sm7957344wmq.3.2021.04.01.08.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 08:27:02 -0700 (PDT)
Subject: Re: [PATCH] PCI: Don't try to read CLS from PCIe devices in
 pci_apply_final_quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20210331210044.GA1421276@bjorn-Precision-5520>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4549ac90-8830-100e-2f53-8ba1a622cb71@gmail.com>
Date:   Thu, 1 Apr 2021 17:26:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331210044.GA1421276@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 31.03.2021 23:00, Bjorn Helgaas wrote:
> On Tue, Dec 08, 2020 at 02:26:46PM +0100, Heiner Kallweit wrote:
>> Don't try to read CLS from PCIe devices in pci_apply_final_quirks().
>> This value has no meaning for PCIe.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/quirks.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index d9cbe69b8..ac8ce9118 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -163,6 +163,9 @@ static int __init pci_apply_final_quirks(void)
>>  	pci_apply_fixup_final_quirks = true;
>>  	for_each_pci_dev(dev) {
>>  		pci_fixup_device(pci_fixup_final, dev);
>> +
>> +		if (pci_is_pcie(dev))
>> +			continue;
> 
> This loop tries to deduce the platform's cache line size by looking at
> the CLS of every PCI device.  It doesn't *write* CLS for any devices.
> 
> IIUC skipping PCIe devices would only make a difference if a PCIe
> device had a non-zero CLS different from the CLS of other devices.
> In that case we would print a "CLS mismatch" message and fall back to
> pci_dfl_cache_line_size.
> 
> The power-up value is zero, so if we read a non-zero CLS, it means
> firmware set it to something.  It would be strange if firmware set it
> to something other than the platform's cache line size.
> 
> Skipping PCIe devices probably doesn't hurt anything, but I don't
> really see a benefit either.  What do you think?  In general I think
> we should add code to check PCI vs PCIe only if it makes a difference.
> 
There is no functional change, right. The benefit is just that we
avoid some unnecessary traffic on the PCI bus.
If you think that this is not really worth a patch, then this is also
fine with me.


>>  		/*
>>  		 * If arch hasn't set it explicitly yet, use the CLS
>>  		 * value shared by all PCI devices.  If there's a
>> -- 
>> 2.29.2
>>

