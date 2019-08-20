Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9895E34
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 14:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfHTMQr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 08:16:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34324 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfHTMQq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 08:16:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so6080477edb.1;
        Tue, 20 Aug 2019 05:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Aqrj4c9BMm607WKqADj4tux8jrP64CdYozdKcQKpxRs=;
        b=ewASI7ty6m5g4yCE06rRZV2auDuRwCy39jW0oXYCPKGv30T2Dc4KcIoNIZlKfq05eJ
         2YiIcshEGNT4u00GEcYjbhahowM4Zc60PJojDj3FUYR99L+dRKL7s/mG8eI4TV/DTPxN
         3wgSn6Qp7T1A4fI1yddxSa9jIih5i42/SRZzLEPDfGEdTN/CUwuv6GogxFZ+a6pc6rCj
         2+/JC7MdceNGTQxOT/wGGH4QmP3Evb1G2moFXrTPGaSNbHilycMJVT29U6PCSYhzKnRc
         kPeIDpEW+RU5DA1UJPH7uuDmMtbF+FfnGHKRkgt2JI1G3S2xQFyB12osRKjbTu9bwW4r
         eO3g==
X-Gm-Message-State: APjAAAX3g+jmaAXGTtxZ4Pc/rKL11mBg0Um7v1gidi3fI/oghXEKpG6V
        nZVruMjrpwZJ3u0yLJYFeGEm4I0S
X-Google-Smtp-Source: APXvYqzEd+H40vyJ3xfj6d0RW5tR1qxm3lLFbeoBzqkYsyCyK2sntwu/nyVS1WkdzhdS9Gav5Hnmew==
X-Received: by 2002:a17:906:a2cd:: with SMTP id by13mr18136971ejb.182.1566303404755;
        Tue, 20 Aug 2019 05:16:44 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id ks7sm2584431ejb.83.2019.08.20.05.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 05:16:44 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH v3 0/4] Simplify PCIe hotplug indicator control
To:     Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190819160643.27998-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <2f4c857e-a7cc-58da-8be5-cba581c56d9f@linux.com>
Date:   Tue, 20 Aug 2019 15:16:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819160643.27998-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/19/19 7:06 PM, Denis Efremov wrote:
> PCIe defines two optional hotplug indicators: a Power indicator and an
> Attention indicator. Both are controlled by the same register, and each
> can be on, off or blinking. The current interfaces
> (pciehp_green_led_{on,off,blink}() and pciehp_set_attention_status()) are
> non-uniform and require two register writes in many cases where we could
> do one.
> 
> This patchset introduces the new function pciehp_set_indicators(). It
> allows one to set two indicators with a single register write. All
> calls to previous interfaces (pciehp_green_led_* and
> pciehp_set_attention_status()) are replaced with a new one. Thus,
> the amount of duplicated code for setting indicators is reduced.
> 
> Changes in v3:
>   - Changed pciehp_set_indicators() to work with existing
>     PCI_EXP_SLTCTL_* macros
>   - Reworked the inputs validation in pciehp_set_indicators()
>   - Removed pciehp_set_attention_status() and pciehp_green_led_*()
>     completely
> 
> Denis Efremov (4):
>   PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
>   PCI: pciehp: Switch LED indicators with a single write
>   PCI: pciehp: Remove pciehp_set_attention_status()
>   PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()

Lukas, Sathyanarayanan, sorry that I've dropped most of yours "Reviewed-by".
The changes in the last 2 patches were significant.

> 
>  drivers/pci/hotplug/pciehp.h      |  5 +-
>  drivers/pci/hotplug/pciehp_core.c |  7 ++-
>  drivers/pci/hotplug/pciehp_ctrl.c | 31 +++++++-----
>  drivers/pci/hotplug/pciehp_hpc.c  | 82 ++++++++++---------------------
>  include/uapi/linux/pci_regs.h     |  3 ++
>  5 files changed, 54 insertions(+), 74 deletions(-)
> 

