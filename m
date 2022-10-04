Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD95F4CC4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 01:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJDXpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Oct 2022 19:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDXpC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Oct 2022 19:45:02 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA4B70E50
        for <linux-pci@vger.kernel.org>; Tue,  4 Oct 2022 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
        MIME-Version:Date:Message-ID:cc:content-disposition;
        bh=ul6oLaMJ+7ees8TH3Whzbb525lmZJ0Ol/GK410c00+I=; b=m23y50dVkafqpdCQ2piapTIrLt
        YNJXghpczMhX6I2+tPwt+gF4ghXoOMYJNuFy0HS9wDIzWmdSthLh2JE5bynlhXtFOcLTPA3DhsX90
        xxH4AV136p8ZBSAZsGNQH31r3cah6jj9iGzT/xQvJ/rANi3LjCnwai8fHx+sW7Pex8A/YkFlssULQ
        YLTU5PTdapbyJ0gSchrr98WyeWkyQLMVttLGirRzNQoy8tE61GJmArRpgJtgjvZu1YNXRcNzr1b9n
        ktxmh8KWJsnmx/h7fyoHkjdvd1NOvhUHbgGCLznvalXxVlEEMf5bndUKK6kMBwHxhxNe9CH7vu99f
        TBnskgvw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1ofraB-000JWr-J5; Tue, 04 Oct 2022 17:44:16 -0600
Message-ID: <014978f9-9ab6-7ef5-25e3-905bf1f7516b@deltatee.com>
Date:   Tue, 4 Oct 2022 17:44:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Ramesh Errabolu <ramesh.errabolu@gmail.com>,
        linux-pci@vger.kernel.org
References: <CAFGSPrzM_pRZ-JEWimKYDPzv76t_Nw2Q6od19S_3dzbG_0-bDA@mail.gmail.com>
Content-Language: en-CA
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAFGSPrzM_pRZ-JEWimKYDPzv76t_Nw2Q6od19S_3dzbG_0-bDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: ramesh.errabolu@gmail.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: Understanding P2P DMA related errors
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-10-04 17:23, Ramesh Errabolu wrote:
> Could I request some help in understanding some PCIe P2P related errors.
> 
>     [72.896624] amdgpu 0000:67:00.0: cannot be used for peer-to-peer DMA
>     as the client and provider (0000:19:00.0) do not share an upstream
>     bridge or whitelisted host bridge
> 
> 
> *System Information*:
> 
>   * The kernel is tagged as 5.14.21
>   * The last entry in the whitelist is   {PCI_VENDOR_ID_INTEL, 0x2030 -
>     31, 32, 33, 20,  0}
>       o p2pdma.c - LINK
>         <https://elixir.bootlin.com/linux/v5.14.21/source/drivers/pci/p2pdma.c>
>   * Output of PCIe device on the system that might reference root
>     complex is:
>       o fe:00.3 Host bridge [0600]: Intel Corporation Device [8086:0998]
>       o Could you confirm if the command I ran is correct. I am not sure
>       o *sudo lspci -nn | grep  -C 1 -i host*
>       o If above command is not correct, how can I get root complex
>         device's id correctly
> 
> I tried to reason if the two AMD devices are connected to two different
> root complex devices. Looking at the PCIe device tree, I don't see that
> to be the case. Perhaps I am not interpreting the PCIe device tree
> correctly. Including below a short fragment:
> 
> 
>     +-[0000:e2]-+-00.0  Intel Corporation Device 09a2
>      |           +-00.1  Intel Corporation Device 09a4
>      |           +-00.2  Intel Corporation Device 09a3
>      |           +-00.4  Intel Corporation Device 0998
>      |          * \-02.0-[e3-e5]*----00.0-[e4-e5]----00.0-[e5]----00.0
>      Advanced Micro Devices, Inc. [AMD/ATI]
> 
>     I am reading this as follows:
> 
>       o Device E2:02.0, a Intel PCI bridge is connected to Domain 0000
>       o Device E3:00.0, a PCI bridge from AMD is connected to Intel PCI
>         bridge device E2:02.
>       o Device E4:00.0, a PCI bridge from AMD is connected to AMD PCI
>         bridge device E3:00.0
>       o Device E5:00.0, a Display controller is connected to AMD PCI
>         bridge E4:00.0
> 
> Per my reading, in the above tree devices *E2:02.0* (*8086:347A*)
> and *E2:00.4* (*8086:09A2*) are not connected to each other directly.
> More importantly they should be considered as PEERs / SIBLINGs.
> Downstream from E2:02.0 is the AMD device E5:00.0 (*1002:740F*). In this
> reading AMD device is not connected to the root complex device. A
> similar pattern is seen with regards to other AMD devices. Basically all
> of the AMD devices connect to the domain (*0000*) via different buses.
> Importantly in their connection to the domain there is no root complex
> device. *Is my reading WRONG*? What is also not clear is how adding the
> device *8086:09A2* to the whitelist helps as the packets do not go
> through that device?
> 

Hmm, looks like a really new Ice-Lake system. Doesn't even have proper
PCI database entries yet. The topology seems a bit unusual, but those
have been getting ever stranger with each new generation.

09a2 looks like the host bridge device id. I'd probably try adding that
to the white list and see what happens.

Logan


