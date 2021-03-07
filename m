Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37183304E1
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 22:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhCGVeu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Mar 2021 16:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhCGVee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Mar 2021 16:34:34 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686BC06174A
        for <linux-pci@vger.kernel.org>; Sun,  7 Mar 2021 13:34:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f12so9349644wrx.8
        for <linux-pci@vger.kernel.org>; Sun, 07 Mar 2021 13:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L2mQ8sfRJfgxc+duINWsifkWkIZ/FSlZYOmdECcEUfk=;
        b=hILCI6bvXBzjyoIOVMizRTgZTobMJGYaX/krevOu6cWxrDCsPv/OiKjx5rdPjyepDB
         2GI1dWBuBhM0W2Se1ND22zeQDBaqXEAgowARV6gj/NApYVigi2MFRLolmN93T0EEXwc0
         QbNvHvTNVGr0WgIwEVladt2OcZO0NJMxkuwUvyzGHW8WYBZI+qu2W60zAvs0LPNaFI4l
         Z3QfU/7mdJR4qM2obT4k1fnJN0eufZEAo2yTdjXf44Lw/YrAmYcLuQbk/yVeHnmZWgPP
         aOOiKFSnAxQllKjvW2+VCUxOdflty6LNn7D3nf/RsG1gwK/habTl93ixuoMb6Y/gBCOP
         uQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L2mQ8sfRJfgxc+duINWsifkWkIZ/FSlZYOmdECcEUfk=;
        b=EFru/HFZb2JBMRazCSjmVyGq0g1bHo6EgsNI+rt9VnaM7U/UW2ooCqvxH9il7QFvAc
         Rm4anBC3MWAvQTLGS6W5+GdL115A2XpHaTH5uO60mn9Wf+fmgKIMei8zwFFTxdL+EcEh
         xrwMBt8HNYQlOWJJY8/EimicSYdWvxE0OsmZPUp7PWmdwL7oyoxnOIEBRlCoezOgslNr
         yFRjtRV5oBngxycKmoAdip5Ifubgh2wk13JBvzec1Sbi7cIRxPD1xlgjZQu84ZFDYbDw
         FMmb5qn4LKUtDq0xSom4Nr/nWshJlipoCUEOyIYbqHnCNu+ESpKjy/GuW1MbWGl0W58n
         CPag==
X-Gm-Message-State: AOAM531r9C3zd6JnZnzeL/n+r0Tyk9zNHOX6FA5RSnSf6/oTr6ki6GZS
        z8CFBaeGdREJWom0zqrH+T2hh/us3jULHw==
X-Google-Smtp-Source: ABdhPJzCE/ljuKmtD9mVe7E+8mxrPCEU51aE+gKK+YM8LRUK7osQYmcxXKTZbcXFRRe5QeB5JPeKoA==
X-Received: by 2002:adf:8b58:: with SMTP id v24mr4159138wra.160.1615152870476;
        Sun, 07 Mar 2021 13:34:30 -0800 (PST)
Received: from ?IPv6:2003:ea:8f1f:bb00:5c7c:e8f6:7307:2191? (p200300ea8f1fbb005c7ce8f673072191.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:5c7c:e8f6:7307:2191])
        by smtp.googlemail.com with ESMTPSA id l2sm15160613wrv.50.2021.03.07.13.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 13:34:29 -0800 (PST)
Subject: Re: [PATCH] PCI/VPD: Silence warning if optional VPD PROM is missing
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <b04a0e46-0b97-da3d-aa77-b05c9b37d21f@gmail.com>
 <YEUbAi8jV6mzKvp4@rocinante>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <87b23db1-a177-190e-a792-eef621a78597@gmail.com>
Date:   Sun, 7 Mar 2021 22:34:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEUbAi8jV6mzKvp4@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07.03.2021 19:27, Krzysztof Wilczyński wrote:
> Hi Heiner,
> 
>> Realtek RTL8169/8168/8125 NIC families indicate VPD capability and an
>> optional VPD EEPROM can be connected via I2C/SPI. However I haven't
>> seen any card or system with such a VPD EEPROM yet. The missing EEPROM
>> causes the following warning whenever e.g. lscpi -vv is executed.
>>
>> invalid short VPD tag 00 at offset 01
>>
>> The warning confuses users, I think we should handle the situation more
>> gentle. Therefore, if first VPD byte is read as 0x00, assume a missing
>> optional VPD PROM as and silently set the VPD length to 0.
> [...]
> 
> True.  I saw people on different forum and IRC asking for clarification
> assuming their NIC broke, or that something is wrong, so this would
> indeed save them some worry, nice!
> 
> Having said that, I also saw this particular warning showing up for some
> storage controllers (often some SAS cards), so a question here: would it
> warrant adding a pci_dbg() with an appropriate message rather than just
> returning 0?  I wonder if this might be useful for someone who is trying
> to troubleshoot and/or debug some issues with their device.
> 
> What do you think?
> 
I don't have a strong opinion here, but yes, that's something we could do.

> Krzysztof
> 

