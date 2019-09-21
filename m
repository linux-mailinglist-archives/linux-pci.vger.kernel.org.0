Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C530B9C11
	for <lists+linux-pci@lfdr.de>; Sat, 21 Sep 2019 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405243AbfIUDcZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 23:32:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730800AbfIUDcZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Sep 2019 23:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c1M/zfRrJYyk5NNSwiCtP5Tyw5TICxN7E3pYvG8jzDY=; b=D/1QOhYywb0nCoLJiPG1VrKwg
        I2rGAAZQEKgTupl0LO8eXzv2EVoJ09kRgpZ63k7cj+oeE3dyiLbPRJqsCrvfPVHfOva4PJ01u6EWY
        dmIKINRzjzd4bnqqGHrrOnO7bZTC0ySKUg4vdAZmNui2KCfryYLLwDiuNw5KsVwCl57KH5YE1lxDa
        550Cq9adFvvveEiG2hHeeZUHoDVQK8TwzGWs7xi3zpVTzSt4vuspTA1mVuDGon26LU9qyhJY8M/p2
        Ol97cTjByxxmEVX/3vc4H6SDCAlejRScyCQM5Apt+QLmmv1hGTtVtzFWJWOff/2ZC4lwCa6RuxLid
        1gJnCOCWA==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBW8E-0004YP-F9; Sat, 21 Sep 2019 03:32:22 +0000
Subject: Re: pci: endpoint test BUG
To:     Hillf Danton <hdanton@sina.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190916020630.1584-1-hdanton@sina.com>
 <20190916112246.GA6693@e121166-lin.cambridge.arm.com>
 <815ad936-8b98-0931-89f7-b97922a7c77d@ti.com>
 <20190920152026.GC10172@e121166-lin.cambridge.arm.com>
 <c1e7862c-d61d-6ecd-f70c-73870f343940@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ca8d59d1-df3f-b6fe-37cb-ba3e3bed0440@infradead.org>
Date:   Fri, 20 Sep 2019 20:32:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c1e7862c-d61d-6ecd-f70c-73870f343940@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/20/19 7:04 PM, Hillf Danton wrote:
>> 
> 
>>> It will be resent if no one saw the message.
> 
>> 
> 
>> I didn't see it and I can't find it on lore.kernel.org/linux-pci/.
> 
>> 
> 
> Respin, git send-email works/jj/pci-epf-uaf.txt
> 
> ...
> 
> From: Hillf Danton <hdanton@sina.com>
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> 
> Cc: linux-pci <linux-pci@vger.kernel.org>,
> 
>         LKML <linux-kernel@vger.kernel.org>,
> 
>         Randy Dunlap <rdunlap@infradead.org>,
> 
>         Al Viro <viro@zeniv.linux.org.uk>,
> 
>         Dan Carpenter <dan.carpenter@oracle.com>,
> 
>         Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
> 
>         Kishon Vijay Abraham I <kishon@ti.com>,
> 
>         Andrey Konovalov <andreyknvl@google.com>,
> 
>         Hillf Danton <hdanton@sina.com>
> 
> Subject: [PATCH] PCI: endpoint: Fix uaf on unregistering driver
> 
> Date: Sat, 21 Sep 2019 09:58:28 +0800
> 
> Message-Id: <20190921015828.15644-1-hdanton@sina.com>
> 
> MIME-Version: 1.0
> 
> Content-Transfer-Encoding: 8bit
> 
>  
> 
> Result: 250
> 
>  
> 
> And let me know you see it.

No, not seeing the patch in my Inbox nor on lore.kernel.org.

It's a mystery to me.

-- 
~Randy
