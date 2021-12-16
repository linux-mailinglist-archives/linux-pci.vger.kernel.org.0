Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C710647747A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbhLPO1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 09:27:37 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58229 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237962AbhLPO1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 09:27:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C6BB25801B1;
        Thu, 16 Dec 2021 09:27:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 16 Dec 2021 09:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=e
        H8d2go/nfWuWo9QuPJJYgW84fuf/WnGhiZoEnjq2TY=; b=mHs4vauY9BCdthoIr
        WNPl3jzocY8TRPIgqI+qXBvpsji+BU6Q8UMGuaH2RzdQG8iIHoSCDVi34mzoF107
        Sf8GlZh/znPaCdXTPQIUU1lbP2sG3wTQvoA6ZLMwdz3/8FAwC0brO1JcZseRmIEH
        JjRlCUI30rD8eD6j5FOeIKwJdqcCNp+hLhbEcClvC/6ZRw/JFkLI2erKiBOPgnLC
        Y5r5g96otTKLNIUwG3NeE0VpuCeMEQCBom2kcuKFDcQHt6Raj+9NT1bXGsFP7OcH
        4t9Unkq1wrCnh3zT+uYD+BABuVgQ9n+ssN6xoxbjPCjCwXQa667acI8aMWbcOHHS
        IwbbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=eH8d2go/nfWuWo9QuPJJYgW84fuf/WnGhiZoEnjq2
        TY=; b=HF9ft757/j6oWnGM4/ZD8FmjWb2F3Jg9cRK+pQ+GD3V4owlornwv4DZrt
        a+9rcgpPC161VtE0f09qItUDE+VzGc2U2hr9eSKAHMgZGvk7Zls9wQOfuGtbp7vU
        bun5pJq5bXdK1P9Z6JbB3KQUrovY+Rai3rRFvmAP0hYGdLj6+lh/ly2YiQujxs/d
        wxKA+rPePMxwM3/8OcDFRBfPFrxetxoRLr7gkbfT48P+iCtAeoqJ28nygbhvgcjp
        o700haoeZq+iAD3LwCW1ZAkARSv4YB8l3y2d6zJC/OUAvpntqb+n6x6rgAXD/T1U
        HJ4XXzxa+CAMsgvhH0UZv82y5tQLQ==
X-ME-Sender: <xms:2Ey7YRLuL2uUO-f_NQv1mVA1qVkrpPpDvW1cx5VEEjgJWVjjWDVKWg>
    <xme:2Ey7YdKl2g_7hLcIGkFye-tt_muu1xS0y4UsKxYEAjdUuD9dkC58CD5jWvSP9DF0v
    RwlOGlsiVtKj7S-sAU>
X-ME-Received: <xmr:2Ey7YZueCyLgqKO6XKcdkDdSEtq-8vIS8XPa4jRXge0pQ6eemNrbcDpsZRTqB8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:2Ey7YSY2OdVXeYenGKDXtZY2MJKzBjnqPSUbHAs0FdpPor-zRh2zvg>
    <xmx:2Ey7YYb2TUu-2ap8XIrjfR9RJU3PmCRTaPz4W3cdyusQSDUQ_0Zd5w>
    <xmx:2Ey7YWD3HBTCX2u0oew_7Z9CoEjUqJdTAXHOOEOU_wkFktAz_jFgzg>
    <xmx:2Ey7YYqfn2CFD3Ch0PDU-mDQZz7JdSVUUwfbqUuyVgtggpERbq64hQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 09:27:34 -0500 (EST)
Message-ID: <88d1835f-cee5-0fb2-f7de-7fc06e8e671d@flygoat.com>
Date:   Thu, 16 Dec 2021 14:27:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v3 5/6] MIPS: implement architecture-specific
 'pci_remap_iospace()'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Xi Ruoyao <xry111@mengyan1223.wang>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
 <20210925203224.10419-6-sergio.paracuellos@gmail.com>
 <67687e579e633d42dc501cfb6746c1cb9f600112.camel@mengyan1223.wang>
 <6ee31420-ef67-471e-a924-a0158b4a9428@www.fastmail.com>
 <CAK8P3a2i6eW8JunE_6h6OTCa51eHfPahQQhaGHGWePX+r4ybww@mail.gmail.com>
 <bfdfb7b3-1322-573d-eddc-1d337c4616e6@flygoat.com>
 <CAK8P3a2iQhxckn0MfLyLpKmyKN_MwAJ0t2yh6DLsS0MvdreYNA@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAK8P3a2iQhxckn0MfLyLpKmyKN_MwAJ0t2yh6DLsS0MvdreYNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2021/12/16 14:18, Arnd Bergmann 写道:
> On Thu, Dec 16, 2021 at 3:14 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>> 在 2021/12/16 13:50, Arnd Bergmann 写道:
>>> On Thu, Dec 16, 2021 at 2:07 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>>> 在2021年12月16日十二月 上午11:44，Xi Ruoyao写道：
>>>> Another way could be keeping a linked list about PIO->PHYS mapping instead of using the single io_port_base variable.
>>> I think that would add a lot of complexity that isn't needed here. Not
>>> sure if all MIPS CPUs
>>> can do it, but the approach used on Arm is what fits in best with the
>>> PCI drivers, these
>>> reserve a virtual address range for the ports, and ioremap the
>>> physical addresses into
>>> the PIO range according to the mapping.
>> Yes, the Arm way was my previous approach when introducing PCI IO map
>> for Loongson.
>>
>> It got refactored by this patch as TLB entries are expensive on MIPS,
>> also the size of IO range doesn't always fits a page.
> Are PIO accesses common enough that the TLB entry makes a difference?
> I would imagine that on most systems with a PCI bus, there is not even
> a single device that exposes an I/O resource, and even on those devices that
> do, the kernel drivers tend to pick MMIO whenever both are available.

Actually that was claimed by the author of this patch :-)
I can understand the point. As he is working on a ramips system utlizes 
1004Kec,
which has only 32 TLB entries, saving a entry can give considerable 
improvement.

For Loongson as we have legacy i8042/i8259 which can only be accessed via
PIO, the access is very common.

For other systems I guess it's not that common.

Thanks.


>
>        Arnd
- Jiaxun
