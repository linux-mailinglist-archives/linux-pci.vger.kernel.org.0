Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512FAC290E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 23:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfI3VqY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 17:46:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55039 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfI3VqY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 17:46:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so1023626wmp.4;
        Mon, 30 Sep 2019 14:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kHAHEXN15wvmynaJGT3rJH0GsGVNspou+8jnYevcxoc=;
        b=ZwJ9Rc76Fl+Mv4Zmks8JizSOJUmzGhpLnGp1tzhIFucJoYzpfLltObnA3uxm/1wMsT
         Hbp9LojucWCWZPOKw7vToYFdJN9x4L9FKngfOlZk3Z3rBtCzCd2ZticzmefETY598PGx
         iiNFmIxtopPfPXc6XV9P1qebu6npZP/Wc05plLZ1FXdAZ185Wl9HbxpZaGj96WYC/R5p
         Bs5/8nE0y1s2tl7jYzBH2gk8ih/4aksYeZryuCqhpjybgEgnuAVLE7v59rEqoglfQi6o
         oGiNdBVre5/P6dZNNQ+JSz75162E5QQb7GwNDWkMVsNdRPUdzgbEQtKkgqeaCih8cZ5C
         KcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kHAHEXN15wvmynaJGT3rJH0GsGVNspou+8jnYevcxoc=;
        b=dZK7uaMyt9hG8JBS13y/ksI+5+fOWEK+N8I0a98xlYkgZsaw01imWwmtWO9gVAdlDo
         zQEPTNxaZVBQ/s+3ZRcSWG8d53xZ144j3BMz6Q75pmHcbzArZ1dEzzaQwLX9ov00wE0G
         I4gBYe4lMKzjgCG8nbsi89tYeSg/AkapDd8CJTNkrTWFsr1lpGeFGZ8t9a+IVHJlLO72
         sWBUN1xtOFAMnVu4zTWOp9oH+uPlGrtAS5JwPk4PsGLTeLrAqTAvyVG8vhRVq+8e6flm
         wNitnsY+R6FqHOepiY56tJL8rj+A5Cy2IUNqbnLMagTKQ4nu0tjNDld9MgzDAIQuxVyc
         akVA==
X-Gm-Message-State: APjAAAVLxvcjj1rsM+Q2wuLZjtTG3m0dnZyeSsNCKjUbfwDtvpzfGShK
        +CYxpqNnamDpvmo12K327B3f6VN0
X-Google-Smtp-Source: APXvYqw5fwQ4XOoo+kMCeyKVGWBa0lxAjioPYyHgQy91sWLfdRfqdIlu2NG0jASyCqvGTBh6f+Ckxw==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr949138wmb.60.1569879980008;
        Mon, 30 Sep 2019 14:46:20 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id z125sm1274768wme.37.2019.09.30.14.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 14:46:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] OF/PCI: Export inbound memory interface to PCI RC
 drivers.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Oza Pawandeep <oza.oza@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190930214046.GA201622@google.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <bfe084be-48ee-3005-e9e1-7fe03d4f406c@gmail.com>
Date:   Mon, 30 Sep 2019 23:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190930214046.GA201622@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/30/19 11:40 PM, Bjorn Helgaas wrote:
> This would follow the convention for subject lines:
> 
>   PCI: OF: Add of_pci_get_dma_ranges() for inbound DMA restrictions
> 
> On Fri, Aug 09, 2019 at 07:34:48PM +0200 wrote:
>> From: Oza Pawandeep
>>
>> The patch exports interface to PCIe RC drivers so that,
>> Drivers can get their inbound memory configuration.
> 
> IIUC this interface (of_pci_get_dma_ranges()) is not used directly by
> *drivers*; it is used by of_bus_pci_get_dma_ranges() in the next
> patch, and it's called by the driver core via this path:
> 
>   really_probe
>     pci_dma_configure                     # pci_bus_type.dma_configure
>       of_dma_configure
> 	of_dma_get_range
> 	  bus->get_dma_ranges
> 	    of_bus_pci_get_dma_ranges     # of_busses[0].get_dma_ranges
> 	      of_pci_get_dma_ranges
> 
>> It provides basis for IOVA reservations for inbound memory
>> holes, if RC is not capable of addressing all the host memory,
>> Specifically when IOMMU is enabled and on ARMv8 where 64bit IOVA
>> could be allocated.
>>
>> It handles multiple inbound windows, and returns resources,
>> and is left to the caller, how it wants to use them.
> 
> This should say exactly what the problem is, maybe even with a link to
> a problem report.  I assume it is something like "RC <X> cannot
> address all of host memory, and if we happen to allocate a buffer
> that's not addressable, DMA to the buffer fails".  It'd be nice to
> know what the failure looks like (SERR# asserted, panic, reboot, etc).

[...]

While it's good that someone finally looked at these patches, these were
since superseded by the following series:
https://patchwork.ozlabs.org/cover/1168166/

-- 
Best regards,
Marek Vasut
