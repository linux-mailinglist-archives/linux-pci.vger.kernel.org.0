Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB947742A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 15:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhLPOOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 09:14:46 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38567 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231689AbhLPOOp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Dec 2021 09:14:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 279435803CE;
        Thu, 16 Dec 2021 09:14:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 16 Dec 2021 09:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=g
        ed4FFFcjgkDifJUOgGUJxm7AfG60QGrUaKolzmkI0U=; b=j/csWXJ1a0PG4YIjQ
        7Fo5/UCcZ+Jn28Bw+X92ieVCWMB7AO/74KBDJX6/E8Q+gZk7JnqGGzqWGnF85NNj
        4+UpajIu4IH5ofLVISUQhUpQXESwa9gnONzFXdLASk3chybsCju3ncvMgps3aQf8
        TOUFgXQcmnOAm/822cZsJ3xSItevLe0SyW1uA4r7AQxVNDf2FO7zmhIKKIMcTcFD
        3jH8ELCBW0/YeeTy9mqcb3Belo3+pfgzQZ+vVbtxe9stYB+jhNEHUf3WW1Resbfs
        FTDFQYtBxna7nfrvyrQJYBAekOybN2XrBTU2nc93I0nVx+cryeOjkAEMvzhWtjcC
        BfFrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=ged4FFFcjgkDifJUOgGUJxm7AfG60QGrUaKolzmkI
        0U=; b=oMjhjF/h1ANMDRtirtEtzDg196wI9FCctYYydOCn6virKHb3kTnFMVmoN
        9t3UoEgtSNexmL+lvYvQXh5ZePU4dwVokGIxmZrtliLzhxGxr/+F2DA1GZA3E5E5
        waWUmXTRD6AvmoxE7+yktY+EIqpIil0gO4pbjZG9d3hxmIgg+7DwdA16K5DJ+agq
        Hi/jhuTVkoY8hGCIeNMmM8vyKy7x7DMg4sEnZtG5wpchF3upPJrJUf+3WDh61Q7Z
        wH5diJEwadwufMwvof/bqk8FqX9Y/cNRpD35JE+XURfnAP6TVhrBXyJQwpZj2jGR
        +i6dp85kU8Q0+7+4vFCmCLvh6EjeA==
X-ME-Sender: <xms:1Em7YSfmDVhcckYI-Nehx2HLmo2IQpKLwJJY5SvmFqtH3PrkN2IZ6g>
    <xme:1Em7YcMknEAhMYP-iSSrP48EH7uVeQrc1cmBiCqElx1q6Ere9O4gMIcaFjAlNQD5w
    dO4cqZvDZPTGGe7ve4>
X-ME-Received: <xmr:1Em7YTgxp8AkcNdCSNtJoiW-BwYwtHLNp6A2FpiItIGC_4DCHsUOQAfThoJKRU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
    geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:1Em7Yf-w63GwbcnFA0WMRF65ZgFNE24NH9iUZMIl7cnJUwwOyRW6JQ>
    <xmx:1Em7Yes6t8uRE7dH6irMC_jDDF8yOVjQoiJXHeTz8s6E8sCaWAgTqA>
    <xmx:1Em7YWHUffelw9yQ3Q6d510NVrZtcMXYzNsdNx9WNp-VNlUTSdBvpQ>
    <xmx:1Um7YTP7ekTUDANke-bm6pE4fI5FbfusEHm7TSNvrIsrmSGfJdxTdg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 09:14:42 -0500 (EST)
Message-ID: <bfdfb7b3-1322-573d-eddc-1d337c4616e6@flygoat.com>
Date:   Thu, 16 Dec 2021 14:14:41 +0000
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
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAK8P3a2i6eW8JunE_6h6OTCa51eHfPahQQhaGHGWePX+r4ybww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2021/12/16 13:50, Arnd Bergmann 写道:
> On Thu, Dec 16, 2021 at 2:07 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>> 在2021年12月16日十二月 上午11:44，Xi Ruoyao写道：
>> Another way could be keeping a linked list about PIO->PHYS mapping instead of using the single io_port_base variable.
> I think that would add a lot of complexity that isn't needed here. Not
> sure if all MIPS CPUs
> can do it, but the approach used on Arm is what fits in best with the
> PCI drivers, these
> reserve a virtual address range for the ports, and ioremap the
> physical addresses into
> the PIO range according to the mapping.

Yes, the Arm way was my previous approach when introducing PCI IO map
for Loongson.

It got refactored by this patch as TLB entries are expensive on MIPS,
also the size of IO range doesn't always fits a page.

>
> For the loongson case specifically, that's not even needed though, as
> the two buses
> have physically contiguous I/O port ranges, the code just needs to
> detect this special
> case.

We have MIPS Boston board (from imgtec) which has discontinuous IO
range.

Thanks.

>
>          Arnd
- Jiaxun
