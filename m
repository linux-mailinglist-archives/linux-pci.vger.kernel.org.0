Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FEA40FFA7
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 21:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240610AbhIQTIh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhIQTIf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 15:08:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8D2C061574
        for <linux-pci@vger.kernel.org>; Fri, 17 Sep 2021 12:07:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u15so16757589wru.6
        for <linux-pci@vger.kernel.org>; Fri, 17 Sep 2021 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KAr/CemH1ozcE7mtWIn9drDu7X80Io8kMgcBbJzhUzQ=;
        b=KK9diLie0IcYPJHdbGEmSO3OXVwB40iOqRJEGe6T/HUGR6r44X7sUOMVM0Of3O88Cb
         26S/MCg99JBwJkFHI/i5dZb6uIr7Uddvv8LDgGnR4AWtQqmMuiS4+eqLeYUUEMjD6f0z
         pors2edd9auEfzIxf7AGP6vTY4TQF2FZkUKQr9hQxLf81HPiIacAAF19rGPPPIPeO5nl
         TIN6P6/in7HzcG+OpGQve/ADDTxeWSjP25+15WH05h0F9U+39D/4UhOGpIVtM999Jsol
         d1OufQ7dL+UlqxoZ5TJ6ZA31tfOy5qwu2GqumPiRV+ibffuikKxCPqYVFw7QVWyDdvjI
         QHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KAr/CemH1ozcE7mtWIn9drDu7X80Io8kMgcBbJzhUzQ=;
        b=uiDl3YRu3YSaO/AZWZu6izU5mp/kPLswsU72fbmVHORkDCOIBRPqBKRXR5AAzqPBr6
         CYkaHqQGrQa6KBxP+asADKWTonZRal81i364uul+NvUBmE72VspFhmggw/VKFbjQeqGB
         cbAkBL46zMQHpEv3Y2vCOUlTeRJ8FJ8VGQLsCLDs+hZYnVk5fLdn+qlt2L3tky6GW1AO
         qz62SMZCHya4WnntZJt8Ho0wrjLGCsmIYnUdNjFQCIsXkpLgZQcFwCyhp60uFl7zj3s4
         twpBHpauDqQ93y0bGF1D7lww3PXhfMor5yf3Xap5mLvmvhjVdM2H1Y+OTJ32sEKJCETm
         iHiQ==
X-Gm-Message-State: AOAM5302b40y/V7PQRsOFECjQ8yBRySwbdxe/xW+LziZ4PbhJO3rJnuQ
        M4C1u5eF3dGFIJqPN3PgKOISDn0v89s=
X-Google-Smtp-Source: ABdhPJzRlhdyk2P/r+hnaT8Ck+3cO8dMeAaaighhSEk8mK7w6TgoJDc+iItNNpIlzg0YfS6rujSoiA==
X-Received: by 2002:a5d:4e47:: with SMTP id r7mr14041343wrt.417.1631905631031;
        Fri, 17 Sep 2021 12:07:11 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:3505:3d5:24d5:d1b6? (p200300ea8f084500350503d524d5d1b6.dip0.t-ipconnect.de. [2003:ea:8f08:4500:3505:3d5:24d5:d1b6])
        by smtp.googlemail.com with ESMTPSA id i5sm7387045wrc.86.2021.09.17.12.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 12:07:10 -0700 (PDT)
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <135abde5-dc5b-826e-e20d-0f53bf32d2dc@gmail.com>
 <20210917135342.GB1518947@rocinante>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] PCI/VPD: Add simple sanity check to pci_vpd_size()
Message-ID: <371af84d-a709-074e-5424-1870eb1c460c@gmail.com>
Date:   Fri, 17 Sep 2021 21:07:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210917135342.GB1518947@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 17.09.2021 15:53, Krzysztof Wilczyński wrote:
> Hi Heiner,
> 
> [...]
>> Instead let's add a simple sanity check on the number of found tags.
>> A VPD image conforming to the PCI spec can have max. 4 tags:
>> id string, ro section, rw section, end tag.
> 
> It's always nice to check if something is compliant with the specification.
> 
> Would you be able to either cite this part of the official specification or
> mention where to find it?  Like we do in other such changes related to some
> official standards, mainly for posterity to benefit others that might look
> at this commit in the future.
> 
Right, I should have mentioned that:
PCI 3.0 I.3.1. VPD Large and Small Resource Data Tags

> [...]
>> +		/* We can have max 4 tags: STRING_ID, RO, RW, END */
>> +		if (++num_tags > 4)
>> +			goto error;
> 
> Do we want to let someone know that their device (or a device they might
> have in the system) has non-compliant and/or malformed VPD which is why we
> decided to return an error?  I wonder if this would help with
> troubleshooting or just simply had some informative value.  So perhaps
> a warning or debug level message?  What do you think?
> 
A message is printed, see code after error label.  We differentiate
between "hard" and "soft" error. Soft error here means that the VPD EEPROM
is optional, in such a case it's not an actual error that the VPD reads
return non-VPD data.

> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> 
> 	Krzysztof
> 

