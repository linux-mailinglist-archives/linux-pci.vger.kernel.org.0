Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07260727C93
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 12:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjFHKRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 06:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbjFHKRl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 06:17:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A3272A;
        Thu,  8 Jun 2023 03:17:38 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 607406606E80;
        Thu,  8 Jun 2023 11:17:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686219457;
        bh=8wEtLq+k1gpOUloiODBgmlAG8KGRJX9TF1jNJ/Nv8js=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H0Sf5wzWDIx0dtyIlUX0Ej8yasaRyBn+OjU44dyImkOagbqJHRynkV9IYpME92tkW
         5IaPR7qh4z6xulH72soV+bUoBG3qOE3XftTKUqa8Ry6xr0XebMI433O3KNMm/8xRpW
         mhwCS7OqQDpoHfBpGbH8PIWxaY/lemPW/NdCd8IxhnISypNph6CvgAJrHdfLo5gdhs
         jXVLKkevPsmjfPxF5WrNSyWN7r9Ak5NCSZ/OjR6Vt864U5cmrzmTVcwLnBiJoITapQ
         gpUqFVKdQcUIe1SJQGZCWgajaN/0POAuQj7dhjFFrGr7t+p5zpdBOQqv7kcjaUEySI
         idXbPdSQUnXbA==
Message-ID: <6d31e143-1b8f-21ba-8ffe-cee9cac324ea@collabora.com>
Date:   Thu, 8 Jun 2023 12:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] PCI: mediatek-gen3: Stop acquiring spinlocks in
 {suspend,resume}_noirq
Content-Language: en-US
To:     Oliver Neukum <oneukum@suse.com>, ryder.lee@mediatek.com
Cc:     jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230504113509.184633-1-angelogioacchino.delregno@collabora.com>
 <20230504113509.184633-2-angelogioacchino.delregno@collabora.com>
 <479acc85-2349-d0ac-851c-f57b1bf6aa9e@suse.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <479acc85-2349-d0ac-851c-f57b1bf6aa9e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 08/05/23 09:44, Oliver Neukum ha scritto:
> On 04.05.23 13:35, AngeloGioacchino Del Regno wrote:
> 
> Hi,
> 
> looking at your patch I am afraid there is an issue.
> 
>> In mtk_pcie_suspend_noirq() and mtk_pcie_resume_noirq() we are,
>> respectively, disabling and enabling generation of interrupts and
>> then saving and restoring the enabled interrupts register: since
>> we're using noirq PM callbacks, that can be safely done without
>> holding any spin lock.
> 
> Why? You can still race with another CPU in task context.
> That is if you say that you do not need locking to touch
> PCIE_INT_ENABLE_REG that is fine, but then why do you remove
> it from one place only?
> It is also touched in mtk_pcie_probe() at a minimum.
> 
> 
>> That was noticed because of, and solves, the following issue:
>>
>> <4>[   74.185982] ========================================================
>> <4>[   74.192629] WARNING: possible irq lock inversion dependency detected
>> <4>[   74.199276] 6.3.0-next-20230428+ #51 Tainted: G        W
>> <4>[   74.205664] --------------------------------------------------------
>> <4>[   74.212309] systemd-sleep/809 just changed the state of lock:
>> <4>[   74.218347] ffff65a5c34c65a0 (&pcie->irq_lock){+...}-{2:2}, at: 
>> mtk_pcie_resume+0x50/0xa8
>> <4>[   74.226870] but this lock was taken by another, HARDIRQ-safe lock in the past:
>> <4>[   74.234389]  (&irq_desc_lock_class){-.-.}-{2:2}
>> <4>[   74.234409]
>> <4>[   74.234409]
>> <4>[   74.234409] and interrupts could create inverse lock ordering between them.
>> <4>[   74.234409]
>> <4>[   74.251704]
>> <4>[   74.251704] other info that might help us debug this:
>> <4>[   74.258785]  Possible interrupt unsafe locking scenario:
>> <4>[   74.258785]
>> <4>[   74.266126]        CPU0                    CPU1
>> <4>[   74.270942]        ----                    ----
>> <4>[   74.275758]   lock(&pcie->irq_lock);
> 
> Lock A
> 
>> <4>[   74.279627]                                local_irq_disable();
> 
> strictly speaking irrelevant
> 
>> <4>[   74.285836]                                lock(&irq_desc_lock_class);
> 
> lock B
> 
>> <4>[   74.292667]                                lock(&pcie->irq_lock);
> 
> lock A
> 
>> <4>[   74.299061]   <Interrupt>
> 
> You do not need that interrupt.
> 
>> <4>[   74.301960]     lock(&irq_desc_lock_class);
> 
> lock B
> 
>> <4>[   74.306438]
>> <4>[   74.306438]  *** DEADLOCK ***


Sorry for the very late reply. I just noticed this.

I'm unsure, at this point, about how to solve this warning; ideas?

Thanks,
Angelo
