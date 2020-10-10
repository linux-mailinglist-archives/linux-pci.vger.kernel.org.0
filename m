Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5C289F80
	for <lists+linux-pci@lfdr.de>; Sat, 10 Oct 2020 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgJJJOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Oct 2020 05:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgJJJEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Oct 2020 05:04:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341A0C0613D0;
        Sat, 10 Oct 2020 02:04:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q5so12002760wmq.0;
        Sat, 10 Oct 2020 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=obzmRsA49+kN9nLLhhuvco3Uy76XSh6EQ8QxAczkyH4=;
        b=UrufEpvAYBZDtrrcoVOX9u4Pa8c9JgWK9jAKhwQTprgcMonbFk7+1RbceT8lkr9kIP
         fuYTOjjvCMYDqJAhfkfTRmeC7Zc24xCU0nUPruSBeKcsfxCOEtGvyxfXjxy5jmR5lwkc
         4IHuLX5zzEcBwqiI9DYmt7Pnvio6PlgU1NAglSmkpujqdrFo/ydqKh+ij/ZepBzukj84
         hEjvDSIdfZEXIbNilmASTz0RkWI01lmk4of//xPRrWpPaQkU/TMtBkX2spLA4s/Um91P
         2ocQRU5XcfHhddSN2aL7H10MrzrCho9B6bdiky5yTbOlyEYG0NheJgihs109l6jO1/yV
         gJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=obzmRsA49+kN9nLLhhuvco3Uy76XSh6EQ8QxAczkyH4=;
        b=YjaiUOs1/OWZ3WY9TC7xIpMt8gcA+XyC1k8P+0o76GMLBDmqme222zi/MRZyaRHKLV
         vsJHQjM8uI4fpRX98KhYx5eu/cPcnOGkeHItG4o2vk6OEVPjgJ6HDoueQRAxuYqMQUYx
         sZbuR8oD7WHoMm5aV3oh2HsQrGpg8FGnJmQmr5bNzMpbfxPwGSgYNYLSCroXWY972vi3
         ODK3JavlK2GhaWDLZa6uN8jrVPkITmTLOufY6Q3sGnf2VQZhV97paA1RDwKqkxook65A
         zC0GUzs0lgiMnM3ugc2oiSvyxezOwUoM9f2gnZQL2e6H1A3F1oiOGTKsnMPq7qCdt6ta
         Fkyg==
X-Gm-Message-State: AOAM5305Hwy2X5j7APvYoaUdg4s2lMGFrDal5eiJEwe5UMs27UZXYEeX
        uKthH9xfGb/ttRynDfIT884=
X-Google-Smtp-Source: ABdhPJyOWCYq8HTIrJ10s9a6rJjjy3r0hgPGOb9G/M5AN/JBrJ/WFJZVlbpWRluU+DZIwA/MsjWUNQ==
X-Received: by 2002:a1c:2c0a:: with SMTP id s10mr1920266wms.103.1602320673727;
        Sat, 10 Oct 2020 02:04:33 -0700 (PDT)
Received: from [192.168.0.66] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id j17sm15700595wrw.68.2020.10.10.02.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2020 02:04:33 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: keystone: Enable compile-testing on !ARM
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     Rob Herring <robh@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-pci@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <20200906194850.63glbnehjcuw356k@lenovo-laptop>
 <20200906195128.279342-1-alex.dewar90@gmail.com>
 <20200930182138.GA3176461@bogus>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <91c7c7b5-fc97-325c-7cba-520d99eede9a@gmail.com>
Date:   Sat, 10 Oct 2020 10:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930182138.GA3176461@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 30/09/2020 19:21, Rob Herring wrote:
> On Sun, 06 Sep 2020 20:51:27 +0100, Alex Dewar wrote:
>> Currently the Keystone driver can only be compile-tested on ARM, but
>> this restriction seems unnecessary. Get rid of it to increase test
>> coverage.
>>
>> Build-tested with allyesconfig on x86, ppc, mips and riscv.
>>
>> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
> Acked-by: Rob Herring <robh@kernel.org>

Ping ping? :-)
