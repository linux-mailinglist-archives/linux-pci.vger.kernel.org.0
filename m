Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185303310C3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 15:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhCHO2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 09:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCHO2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 09:28:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6BFC06174A;
        Mon,  8 Mar 2021 06:28:11 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id m11so16279539lji.10;
        Mon, 08 Mar 2021 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Tx7iM5/yDvqIEFiuaAtchQiAX0fZCuVvfKdSztb6qc=;
        b=TDYBDrBCriR9cjYkY3F4y+0jYt0cu6kj/EMJye/kwXLUZ3arB3XzCW43yePDA4YfYc
         tB4d7JKketl6MELigit3fT+egHHKb/F+tOUoTiGVz7y83lh+QzwlZM0aD6Jed4dlqI6g
         7nSO04IbNA9ZnOreHWEa4JY3WdS8DOHrSi2KJ/V7Gf7YNH6yzFpNmCs5ooikoWCcu+WP
         OCcE6RHv9ClT/Xy/lENFD+nv5M7A47+WrA47hvedADDA8QeIlj+6hWzLnLCyAGgicYlW
         8G6a9Gz1tEwqIC+ryDCFcvkRsm3LppD15ynL9Z2rhTEsvd+8bqez8o8AY8EVSMVFnkNJ
         Cayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Tx7iM5/yDvqIEFiuaAtchQiAX0fZCuVvfKdSztb6qc=;
        b=O2S5bJwydobGcv3a5PjSXHNbtqUvMdDEWxfdSD8PiVWtYiUpDGbA9sfFR2DvBk2073
         Bbg73wSIM4vNruQfKdlg5f9fnlE7b/aObtWlibatiJSbPUBCFo/w99Mpr02dzQ6pqbOb
         N1/YCnXrpxBVaV1OtUiDCn/vFb5QOw1SgEIBedEmdi7vCK61VuxFLW2W/L5JiU03kP8D
         iuAYN/RzDXVySX9CTYEgfqa+sOscOixg7rWzurrZ7wHlz5Kq0xS8dju/Lm/f76oMwGoA
         GrdYbCCJGiWyu2sZfZxYa0bJYbsrhryYu39UcXOyo8dH2GYqrj3MPoKDaasd+YtP9JUl
         6OzA==
X-Gm-Message-State: AOAM532E649GGzSmlJV0W41MKpmL9EqQmsTEnuXxF3Aj4Q6E0XA9i0eg
        xSHXwRLlX1equiouP/rRhMs=
X-Google-Smtp-Source: ABdhPJyjVR8wO8OpzFoOevKwIErhOsJ7qLQZxMia0B40cv/hPCdQI9hu7JhCNrnkYzOOhuTbHT8NNA==
X-Received: by 2002:a2e:b55a:: with SMTP id a26mr12150911ljn.297.1615213689870;
        Mon, 08 Mar 2021 06:28:09 -0800 (PST)
Received: from ?IPv6:2001:14ba:efe:51f0:513f:8184:2b7b:4a52? (db7-gd8cvj0y4km77llly-3.rev.dnainternet.fi. [2001:14ba:efe:51f0:513f:8184:2b7b:4a52])
        by smtp.gmail.com with ESMTPSA id d8sm1420576lfm.160.2021.03.08.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 06:28:09 -0800 (PST)
Subject: Re: [PATCH v2] PCI: quirk for preventing bus reset on TI C667X
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     helgaas@kernel.org, alex.williamson@redhat.com,
        bhelgaas@google.com, kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, m-karicheri2@ti.com
References: <20210217211817.GA914074@bjorn-Precision-5520>
 <20210228135311.668-1-antti.jarvinen@gmail.com> <YEQcyBVLIaGWb4sk@rocinante>
From:   =?UTF-8?Q?Antti_J=c3=a4rvinen?= <antti.jarvinen@gmail.com>
Message-ID: <461e12f3-fb0a-9615-09c6-91efcfd8aaa9@gmail.com>
Date:   Mon, 8 Mar 2021 16:28:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YEQcyBVLIaGWb4sk@rocinante>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7.3.2021 2.22, Krzysztof Wilczyński wrote:
> Hi Antti,
> 
> A few nitpicks, so feel free to ignore these, of course.
> 
> If possible, capitalise the subject line.  Also, perhaps "Add quirk to
> prevent bus (...)" might read better.
> 
>> Some TI keystone C667X devices do no support bus/hot reset. Its PCIESS
> [...]
> 
> It would be KeyStone in the above sentence.
> 
> [...]
>> With this change device can be assigned to VMs with VFIO, but it will
>> leak state between VMs.
> 
> Following-up on Bojrn's question about the state leak, see:
>   https://lore.kernel.org/linux-pci/20210129234946.GA124037@bjorn-Precision-5520/
> 
> Would there be anything else that has to be done?
>

To my understanding this is all that needs to be done. At least on other similar
case, adding quirk was the only change https://lore.kernel.org/patchwork/patch/1086083/

