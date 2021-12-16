Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB2C4774C2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 15:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhLPOiD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 09:38:03 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34213 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238054AbhLPOh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 09:37:58 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id E80D85804DD;
        Thu, 16 Dec 2021 09:37:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 16 Dec 2021 09:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=Y
        WDS6KaFoXhTaIfpyazc6NB71xdSLFFPrMeuUZ1+uUY=; b=mDm79uDf5S/92VNn3
        I/gJocJKIrKQl0vNWIKhzbYRFkcX7ZPvy3yOsuxK+jc1UV9Dq1GOUVIHixjZ7MNv
        dFfZIwBrHzxRiz/RDWSTLOi2OfuQ7fXoD4J0CewcHCGbnnFRP9u7oOTbmccpIWIl
        PrzQtV0O+yD/YrmxBcT+sahrRLMx68b+BkrRmikulXDj4fMb5alFiHOVMty8hpjr
        SFus3iRogxrLbgICGjZf1skBr7TrWeSFkOjYi4gPHEkVIZJsxOQMtWH9XwvD0YlR
        xv6tleDg0mQjtHMmEw4tYurd4wEhrve0pElL9Ii635d0znAbn76U2kBxXoMX2NO4
        FHdYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=YWDS6KaFoXhTaIfpyazc6NB71xdSLFFPrMeuUZ1+u
        UY=; b=Z25W6JhU/mDJaPrOSWYTH9nOrzcCRqJOEx0edmmxN1azhhCUyBkD8Hq8l
        VWO/rJqirbF+6DCQNf1oT1Emg9PmYAWWCtDwLxXir7TWfdGxQR63By0+GySZVWt9
        KsLhvk4+qfieUhHqFrf8wgieNXejD1xd6ouo5gjCeZwM5mYsx3popd8KBX/hb5rM
        IUmo1AytjOjvyIP16NZQAOh9MYYbAXjb4+5tIr6rD/w7AWPD1pMVa6U+Xs1138Te
        KA10Z413ydL2hJctX64xqx8R3OOGgNMUUq1H8aBo4yd/R/3zr9kTQP4Rv/HqWsDk
        muiEwtLTGihwR4cOH87Q/NxPSG+Ag==
X-ME-Sender: <xms:RU-7YZWwJ4Y81LeiSnn_PQkBHdyyKFOnVXloOMUGWuTiZCXrWwWZfw>
    <xme:RU-7YZkp3g5cvvI6Xv8C2XbHhbAO3GBWUJmWThuXXDCeVAiKIf1yW5JDZDcZLHTxk
    bGbY7h07u979qhNCJU>
X-ME-Received: <xmr:RU-7YVaEY-zneuTJDxrnSwGzY9wHwdQQKU1NbLjfoKyL0oFGBkqs-CUWIaXU8Sc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:RU-7YcUIcOe6qTP-cxW4CVbp2prOuzOecNHfb1HHRpwJ-6j_POSRHQ>
    <xmx:RU-7YTl-dFpWYav34ZVNTqmO1kzYfeszluGsW6t5vgRNT8mafGqWoA>
    <xmx:RU-7YZeQc3gEQc6pZyJnjCf_O7xtxFFczpfg65BUf5_E7mrWyi1kCg>
    <xmx:RU-7Ydkex1nVmKjTuRtOWb8TUNOsZkp2pFRiCbBdVne3IURLSVzSlg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 09:37:56 -0500 (EST)
Message-ID: <4e33446d-fbe6-e2c6-c579-672339862c23@flygoat.com>
Date:   Thu, 16 Dec 2021 14:37:55 +0000
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
 <88d1835f-cee5-0fb2-f7de-7fc06e8e671d@flygoat.com>
 <CAK8P3a1nozEpQ_9Q+NhocWZDsrfLmDibrkmoX8ph63wYaFxvjg@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAK8P3a1nozEpQ_9Q+NhocWZDsrfLmDibrkmoX8ph63wYaFxvjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2021/12/16 14:32, Arnd Bergmann 写道:
> On Thu, Dec 16, 2021 at 3:27 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>> 在 2021/12/16 14:18, Arnd Bergmann 写道:
<...>
>> Ah, right. It makes a lot of sense that anything based on ISA PC peripherals
>> would need it, regardless of the PCI support.

I'll draft a RFC patch with linked list approach later on.
For now Tiezhu's 09d97da660ff ("MIPS: Only define pci_remap_iospace() 
for Ralink")
seems working.

Thanks.

>>
>>         Arnd
- Jiaxun
