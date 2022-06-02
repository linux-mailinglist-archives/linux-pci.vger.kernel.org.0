Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200FD53BF38
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiFBUBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 16:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbiFBUBI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 16:01:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB160B84
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 13:01:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 932E45C02A0;
        Thu,  2 Jun 2022 16:01:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 02 Jun 2022 16:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654200060; x=
        1654286460; bh=JjfG+RXBCua4hjsnNkYdZXVXviBXaHqSGYvkNJYD4Gc=; b=K
        8Ca0V1mVmGx1trWJLtSIRZmnd4+8yBqJ6V3Cc6rsc/VPprQkRUHOHAODsOCZLdBa
        f6at9xN0Tr2+v/U2ckGJDPYOjkYTWWvGK1efWyXv+R/ulyQxlT2duJINREneJF8a
        xXboLKq54afIPQf1g4hf9EBbg2KN1alxF37vyq2TJ1KGEu0F66gbiIgLbJB71cqp
        DpH9XCUiNhuy4nCq/8jcbZRCvwYauF+3BNjJkpr+SHLPhpKNY8b1W5VwhKJO1Xui
        E3SiupxDUK0X5peYVKKB98JbSOjJqrmNwfDUP4msI2bLH/wgFFZyGblFEOIlLC5j
        8BvktSR3FwLXzVubl/9Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654200060; x=
        1654286460; bh=JjfG+RXBCua4hjsnNkYdZXVXviBXaHqSGYvkNJYD4Gc=; b=f
        L3lCiVg/g3LLx8ADeYC15dLnLk7h9icx9BrUc9vuM6Ivl+ZSCXaMRI9FYD+aBwWl
        PRbk6tZy58L8gzUh03HuqUsSKfk5+d93+Y9qmS7dokX/ZEtIinl+VYGG8GPjkusU
        6ERlhCvcUMT2nlwWy2xHJKy5tMcm1nOSUc/mdWBCfU+d8nOvPsqrCk+ulzO2DDfc
        RF92u5P5JXM93AGGkQwpJAOgvD7wGqAS/ftC3fyYFe28ObFrXOG+lmux+kbLcGDp
        y5hZn92uej6vQGy151yc03ZenSUqieYHpktfC0cA8A34u6N3TQGdFEFysa+cZDah
        1sEfa9g4Oh8P8OTAviMXQ==
X-ME-Sender: <xms:-xaZYuyS-DrlVKXx7138hU3bIM_hLm402DHBP_xOshqBZwyE3XPzNw>
    <xme:-xaZYqSyXNFmILNIlQv71sBXQ2lD7EEue-hmDBk0sKqgUihy3Pl8rj_SIJQ8ge84t
    Sl_pzOzNDebn3fM3ok>
X-ME-Received: <xmr:-xaZYgXAh0vnaq2L7QRWVvbfRtNgOreedC3vKk-TtMkJgOtSlHjaFpqH3hK3CO8tlOBeum4zfN6brq6cMG55EvC0O0Qw7J_YYPeTw5IetyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleeggddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeegieeh
    vefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_BaZYkis0L73Jj6wGbgZqipFaAAuUkoCHqWLfw7XiTmpdoDu4IlFxQ>
    <xmx:_BaZYgDPRTjSnWSkmPSwstxyipsaj23_UAi_bZcMspX-mDu5nLMnzA>
    <xmx:_BaZYlK_mQIkhcIEN2VOqgIVqWOGbHRvRVr-QoknwWMlhwRH-psfEA>
    <xmx:_BaZYuAtqEbNmL2H6EsYcn9diggnakDDH-It0xC0E_e10Kp_pjDZLg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jun 2022 16:00:58 -0400 (EDT)
Message-ID: <22d1d8af-27b2-dce3-c832-8a95adf04b36@flygoat.com>
Date:   Thu, 2 Jun 2022 21:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V13 3/6] PCI: loongson: Don't access unexisting devices
Content-Language: en-GB
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <20220602162324.GA21622@bhelgaas>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20220602162324.GA21622@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/6/2 17:23, Bjorn Helgaas 写道:
> On Thu, Jun 02, 2022 at 12:28:40PM +0800, Huacai Chen wrote:
>> Hi, Bjorn,
>>
>> On Wed, Jun 1, 2022 at 7:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Sat, Apr 30, 2022 at 04:48:43PM +0800, Huacai Chen wrote:
>>>> On LS2K/LS7A, some unexisting devices don't return 0xffffffff when
>>>> scanning. This is a hardware flaw but we can only avoid it by software
>>>> now.
>>> What happens in other situations that normally cause Unsupported
>>> Request or similar errors?  For example, memory reads/writes to a
>>> device in D3hot should cause an Unsupported Request error.  I'm
>>> wondering whether other error handling assumptions might be broken
>>> on LS2K/LS7A.
>> Hardware engineers told me that the problem is due to pin
>> multiplexing, under some configurations, a PCI device is unusable but
>> the read request doesn't return 0xffffffff.
> What happens if a driver does a mem read to a device that's in D3hot?
Just did experiment on my hardware (which is a MIPS-era LS3A4000 with
LS7A).

It turns out that the hardware simply returns 0xffffffff for all reads and
ignore writes.

The PCIe controller of LS7A is a customized dwc and it should response
with a SLVERR transaction on LS7A's internalAXI bus. However the bus
we used to connect LS7A with CPU is incapable to pass this SLVERR
information to CPU and thus it just provides a false result.

All LS7A's on-chip devices connected on PCI bus don't expose any
PCI power management capability. Though they have power management
registers elsewhere  and generally we won't touch them when kernel
is running.

Thanks
- Jiaxun

