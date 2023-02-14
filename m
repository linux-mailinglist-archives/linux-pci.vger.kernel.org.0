Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FC2695767
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 04:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBNDYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 22:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjBNDYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 22:24:52 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336A1556D
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 19:24:51 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id r8so15721810pls.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Feb 2023 19:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YGMqgl5LW97AfsYc7W+xzShnJuseYgX2N3E9oQfC+t8=;
        b=SH6A/885VYHXN9okhjHo8OtXfA1hRSX8gboZgnc4QaxbNQAAEmXLZErOZatPzAH0Ru
         ZMntbixHRtH50YAENZZjrKrQgCrThfbTwJwiwv8LtUKpgqxkXbA03Fpx9wfZBdsdcPzQ
         o/cfSIEX8EH/7aV+FM1k3ZslVTo0BvdOO7B2sDT0txr0UgUAX/bl2z9nY/cEb6ABB5/8
         FS/UIrLLpP4n6cs3bdynndE2bv04sYfMLTxDmrhlxkIBsp1c+175AyY9TqHs5/kmkNCJ
         uvtg7/Be0XVyZQj9Av1wEZGA8rxLu3bMba6NC9bYM4DlpogeWPsEuD8RNBVnwgxTs9Kv
         wR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGMqgl5LW97AfsYc7W+xzShnJuseYgX2N3E9oQfC+t8=;
        b=3lwxQx2qFHkZtYJXBTxT8daz2wM2WPtYITyTDwQmBrcKeOyw+7whflixHPxvij5vj8
         7PH10ceAkWDlANYHUtN0WDmQ9B4oJToc68oazK6X6p84UQcCDog6LqB1q3hRyaIkHCKI
         byTwLoFI4bpMEIgnDmnBlQC+DTJZ9fZxaRLWRy17yfh8cwVnYyz79HCmHJpiGVSNz5fP
         +oNuuwdDLx6FGtufLVekR05Nhojhi0yfDI7ptN3Ui2wPLRY9HK2Z2ayPq50qWnK0njlT
         Z4fNo3EtfVHMcZcOqsCgcTCAzbF4+6JBNDNnMPwnHpR+9/qaNxcb/b1bRw/9bIDhHn5K
         Ly2A==
X-Gm-Message-State: AO0yUKUgCAjsB6yu8vsGUdBWLtILiX4h55Gzpbu1eaaxy+jaVmq13nMM
        kiWwlPNx7Qu/tPe1Dpzy6RRi2g==
X-Google-Smtp-Source: AK7set+n/OQl8f+Pt808/MeY0liwC8YzfyLLbiOQmoBusBO7Lrudi/iQCUkvtjWFIPnPqiprJbvNCQ==
X-Received: by 2002:a17:902:d102:b0:19a:8284:83a2 with SMTP id w2-20020a170902d10200b0019a828483a2mr941860plw.10.1676345090397;
        Mon, 13 Feb 2023 19:24:50 -0800 (PST)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p17-20020a1709028a9100b00198e663a856sm8898968plo.205.2023.02.13.19.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 19:24:49 -0800 (PST)
Message-ID: <9f781dc0-e4d5-4c14-cad9-483f59b2a315@igel.co.jp>
Date:   Tue, 14 Feb 2023 12:24:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
From:   Shunsuke Mie <mie@igel.co.jp>
Subject: Re: PCIe RC\EP virtio rdma solution discussion.
To:     Frank Li <Frank.Li@nxp.com>, imx@lists.linux.dev
Cc:     bhelgaas@google.com, jasowang@redhat.com, jdmason@kudzu.us,
        kishon@kernel.org, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        mst@redhat.com, renzhijie2@huawei.com, taki@igel.co.jp,
        virtualization@lists.linux-foundation.org
References: <20230207194527.4071169-1-Frank.Li@nxp.com>
Content-Language: en-US
In-Reply-To: <20230207194527.4071169-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for organizing the discussion.

On 2023/02/08 4:45, Frank Li wrote:
> From: Frank Li<Frank.li@nxp.com>
>
> Recently more and more people are interested in PCI RC and EP connection,
> especially network usage cases. I upstreamed a vntb solution last year.
> But the transfer speed is not good enough. I initialized a discussion
> athttps://lore.kernel.org/imx/d098a631-9930-26d3-48f3-8f95386c8e50@ti.com/T/#t
I've investigated the vntb + ntbnet device that uses ntb transfer. Is it
difficult to adapt the eDMA to the ntb transfer? It is likely one of the
solutions for the performance problem.
>   
>    ┌─────────────────────────────────┐   ┌──────────────┐
>    │                                 │   │              │
>    │                                 │   │              │
>    │   VirtQueue             RX      │   │  VirtQueue   │
>    │     TX                 ┌──┐     │   │    TX        │
>    │  ┌─────────┐           │  │     │   │ ┌─────────┐  │
>    │  │ SRC LEN ├─────┐  ┌──┤  │◄────┼───┼─┤ SRC LEN │  │
>    │  ├─────────┤     │  │  │  │     │   │ ├─────────┤  │
>    │  │         │     │  │  │  │     │   │ │         │  │
>    │  ├─────────┤     │  │  │  │     │   │ ├─────────┤  │
>    │  │         │     │  │  │  │     │   │ │         │  │
>    │  └─────────┘     │  │  └──┘     │   │ └─────────┘  │
>    │                  │  │           │   │              │
>    │     RX       ┌───┼──┘   TX      │   │    RX        │
>    │  ┌─────────┐ │   │     ┌──┐     │   │ ┌─────────┐  │
>    │  │         │◄┘   └────►│  ├─────┼───┼─┤         │  │
>    │  ├─────────┤           │  │     │   │ ├─────────┤  │
>    │  │         │           │  │     │   │ │         │  │
>    │  ├─────────┤           │  │     │   │ ├─────────┤  │
>    │  │         │           │  │     │   │ │         │  │
>    │  └─────────┘           │  │     │   │ └─────────┘  │
>    │   virtio_net           └──┘     │   │ virtio_net   │
>    │  Virtual PCI BUS   EDMA Queue   │   │              │
>    ├─────────────────────────────────┤   │              │
>    │  PCI EP Controller with eDMA    │   │  PCI Host    │
>    └─────────────────────────────────┘   └──────────────┘
>
> Basic idea is
> 	1.	Both EP and host probe virtio_net driver
> 	2.	There are two queues,  one is the EP side(EQ),  the other is the Host side.
> 	3.	EP side epf driver map Host side’s queue into EP’s space. Called HQ.
> 	4.	One working thread
> 	5.	pick one TX from EQ and RX from HQ, combine and generate EDMA requests,
> and put into the DMA TX queue.
> 	6.	Pick one RX from EQ and TX from HQ, combine and generate EDMA requests,
> and put into the DMA RX queue.
> 	7.	EDMA done irq will mark related item in EP and HQ finished.
>
> The whole transfer is zero copied and uses a DMA queue.
>
> The Shunsuke Mie implemented the above idea.
>   https://lore.kernel.org/linux-pci/CANXvt5q_qgLuAfF7dxxrqUirT_Ld4B=POCq8JcB9uPRvCGDiKg@mail.gmail.com/T/#t
>
>
> Similar solution posted at 2019, except use memcpy from/to PCI EP map windows.
> Using DMA should be simpler because EDMA can access the whole HOST\EP side memory space.
> https://lore.kernel.org/linux-pci/9f8e596f-b601-7f97-a98a-111763f966d1@ti.com/T/
>
> Solution 1 (Based on shunsuke):
>
> Both EP and Host side use virtio.
> Using EDMA to simplify data transfer and improve transfer speed.
> RDMA implement based on RoCE
> - proposal:https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/T/
> - presentation on kvm forum:https://youtu.be/Qrhv6hC_YK4
>
> Solution 2(2020, Kishon)
>
> Previoushttps://lore.kernel.org/linux-pci/20200702082143.25259-1-kishon@ti.com/
> EP side use vhost, RC side use virtio.
> I don’t think anyone works on this thread now.
> If using eDMA, it needs both sides to have a transfer queue.
> I don't know how to easily implement it on the vhost side.
We had implemented this solution at the design stage of our proposal.
This solution has to prepare a network device and register to the kernel
from scratch for the endpoint. There is a lot of duplicated code, so we
think the solution 1 is better, as Frank said.
> Solution 3(I am working on)
>
> Implement infiniband rdma driver at both EP and RC side.
> EP side build EDMA hardware queue based on EP/RC side’s send and receive
> queue and when eDMA finished, write status to complete queue for both EP/RC
> side. Use ipoib implement network transfer.
The new InfiniBand device has to implement an InfiniBand network layer.
I think it is overengineered for this peer-to-peer communication. In
addition, the driver of the InfiniBand device should be implemented or
emulate the existing InfiniBand device to use the upstream driver. We
want to reduce the cost of implementation and maintenance.
> The whole upstream effort is quite huge for these. I don’t want to waste
> time and efforts because direction is wrong.
>
> I think Solution 1 is an easy path.
>
>
>
Best,

Shunsuke.

