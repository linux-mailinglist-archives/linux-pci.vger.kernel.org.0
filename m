Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23439E8AC
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 22:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGUpB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 16:45:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230291AbhFGUpB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 16:45:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A547260FDA;
        Mon,  7 Jun 2021 20:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623098589;
        bh=PkOSHdutYw/N1gzeRvQ9b1rv0ngrRIeGldIWf4KjaWk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cb5UObu2jIdMLEWPFdRmcCs8u5B0K2+NDM3EBN/vNiLPYNup8WaqNUxS79GKNzlST
         8LzhGAkJkdhKZouoPCOjQ00YDr/zP0cXB58wksOaE8BqKXXST51Bs+mx27LAw3E7dB
         rMbus+xvtT6y0eoxilCvo2FU3KCpI5xtSiS6d5h7FNJVmqhPB1bWNEP7vcgeZf9Rby
         DSp9QmyRn/cH0KBo/HQt/aAqUurqf8BHroB/qZlzggvfqk/kPe2YQedFnh+JLMZ0DN
         fnJqJ2FIZEHF+kfRof08UtCxze4qMp9MSJoAwUhm8l8HH9D7gMXYz1cJlgFiuG8Hg0
         QhrPsWwM10tvA==
Subject: Re: [PATCH V2 1/4] PCI/portdrv: Don't disable device during shutdown
To:     Huacai Chen <chenhuacai@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>, huangshuai@loongson.cn
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20210528071503.1444680-2-chenhuacai@loongson.cn>
 <20210528214309.GA1523480@bjorn-Precision-5520>
 <CAAhV-H4paNzoF4tEJd1_Z2VgBr64t3evfjdmrrA3CZMw=AXrGw@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <21b1495f-689f-2d75-d896-2a33c03b186b@kernel.org>
Date:   Mon, 7 Jun 2021 23:43:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4paNzoF4tEJd1_Z2VgBr64t3evfjdmrrA3CZMw=AXrGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/4/2021 12:24 PM, Huacai Chen wrote:
>> So you need to explain why we need to allow DMA from those devices
>> even after we shutdown the port.  "It makes reboot work" is not a
>> sufficient explanation.
> I think only the designer of LS7A can tell us why. So, Mr. Shuai
> Huang, could you please explain this?
> 

Could there be some kind of a shutdown/init problem on your graphics
card driver?

During shutdown, remove() callback of all endpoints get called. This is
the opportunity for your graphics driver to put hardware into safe
state.

If there is a problem with the hardware/driver, it should be a quirk as
opposed to changing the default safe behavior for all devices.

The port driver here prevents memory from getting corrupted by rogue
hardware. There is a window during kexec where hardware can write to
system memory addresses if IOVA addresses and system memory addresses
overlap.

