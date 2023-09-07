Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0718F796F2F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 05:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjIGDNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjIGDNN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 23:13:13 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE3133;
        Wed,  6 Sep 2023 20:13:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 120CE3200945;
        Wed,  6 Sep 2023 23:13:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 06 Sep 2023 23:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694056384; x=1694142784; bh=OXTmpIBOV1UxZ2xEwVd1/NfVXC6bFY0UiDJ
        AKT3kajw=; b=OVaTFjB+tJuF36xZSClXZas6bTYFmPOna6qLbLDFZhgSatZrtnn
        4gwbd9eHcFxub5sNNfvCMVkTtnimU1fwez+9V7e0zTaW/X/C2fZ7gxKOk+qYOFLY
        cklVFF3/25+2RJgahWL+o99rbtAsi1F5SBZF+vMgljIHFHmmH6KBh7ce97sG4rLn
        A/ZZef/pctp+jl59atieAklcNx7KuuxMKvbDMIXKjX9zJsmaLzSnolf28VzKG6rn
        nahZt+Ilho7A485CAtM8EyrzTsN60v7fiB5aFn+vnbBYqZxOElXheNzQaQ3ivFaO
        WvmuRkMHm57zE7ygqq1lHVZ4+aOzPk8U4IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694056384; x=1694142784; bh=OXTmpIBOV1UxZ2xEwVd1/NfVXC6bFY0UiDJ
        AKT3kajw=; b=dcvtZApRAQ25C9kUF/inYTfY+NZ59bEC5fBt0T+fDcowjKXOp6G
        3Xw7319JGehT03+VzQKfLTYdXixXa+NVKtPP3d/fIusvNhIeB92RSozSsJMD3DhS
        1GsJfFsJ3I5v61jz61Xftirt2wmY6de3ILDhZkFzBTKCPcePJnfn//XOk1KD1uEK
        KMZ3UZM6C893FXLYsGuQPFMSe1U6USSegGqn/ciciIUo3h1u2iObsk5mvmBGtsR6
        Kq/LNsN5AWudHQ2jBjOnzl0BNVo8k4pTvXEqbxIlkxWLI/s4ydJIUgZtq6rP+gU2
        ZuXb0VaGknVvX8fFdxeCElbj7E2TCWqQfQg==
X-ME-Sender: <xms:wD_5ZLP_chSquTqoyxrVvL8UEBegLh6ZYbEc04LGbx2vRtF-BnkTQg>
    <xme:wD_5ZF_Nq0Hd891p2lCG29m-rQkXW-BQhlS19SoL9YlBxg6LzBIWQokKsCTSCja5y
    inJLvzSGfTrEBte-Us>
X-ME-Received: <xmr:wD_5ZKQjnv1GQ5RbsUWYOUWBCFijHAuBksc8JWZAeVTLHhL4nMKSKOSrhdyVOzHUKAWx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehgedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhephfehveeggeevieehgfdtveeigffgteehieehffetleetffeh
    hfeuteffudehfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wD_5ZPvwbWgx_JGmNH8GwhIdVSybYLKOBDnObtybPy7PkK6de4nb_Q>
    <xmx:wD_5ZDfh-EqlwMPbl7J3IPNZkDikT273jogD2FjiGcG8LnZ9QF8bvg>
    <xmx:wD_5ZL3q6VewV6BjH7guA4Z8WopUXw0u-pf88iDH4XDNYGm4GsIQPA>
    <xmx:wD_5ZLS3u7_Utkx4heRsal_gPtub5k5DqgnX5wgOHwsJ4clQ-psq8g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 23:13:02 -0400 (EDT)
Message-ID: <6e1bdebf-f335-23a5-c79f-d603c5d0150c@flygoat.com>
Date:   Thu, 7 Sep 2023 11:13:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org, kw@linux.com,
        lpieralisi@kernel.org, stable@vger.kernel.org
References: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
 <e9c103dc-98ac-9a51-7291-f5da1467b2ff@flygoat.com>
 <CAAhV-H7_OjTaU_wn6mUW0-JSrXS+=A2rXCiBc8cyce5ob49BLg@mail.gmail.com>
 <861a809d-3df1-327e-e033-87506f6d89e5@flygoat.com>
 <20230907011828.GA2865@thinkpad>
Content-Language: en-GB
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
In-Reply-To: <20230907011828.GA2865@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/9/7 9:18, Manivannan Sadhasivam 写道:
[...]
> Why do you need to walk through every single device instead of just bridges?
> I'm not the maintainer, but my suggestion is to go for Huacai Chen's solution.
Hi Mani,

Thanks for your reply, unfortunately Huacai's solution is impractical in 
this case.

The problem we have, is firmware (or BIOS) setting improper MRRS for devices
attached under those bridges. So we have to fix up MRRS for every single 
device.
We can't iterate child device in bridge quirk because there is no 
guarantee that
bridge will be probed before  it's child device, partly due to hotplug.

This quirk has been in tree for a while, until Huacai refactored it and 
broke some
systems in 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases").

Also to note that ks_pcie_quirk in drivers/pci/controller/dwc/pci-keystone.c
uses similar approach.
> This avoids iterating over bridges/devices two times.
>
> Also, please rename firmware to BIOS, as firmware commonly represents the
> software running on PCIe endpoint devices.
Ack, will fix in next reversion.

Thanks
- Jiaxun
>
> - Mani
[...]
