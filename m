Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D91697812
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 09:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjBOIYB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 03:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjBOIYB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 03:24:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2427D5D;
        Wed, 15 Feb 2023 00:23:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66E9AB81F11;
        Wed, 15 Feb 2023 08:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E802C433D2;
        Wed, 15 Feb 2023 08:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676449437;
        bh=8Lv+5x5vaq2UOptL53EzNlofhZ6WDJ1xNJrmCC+n8iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o38quSWrL0kU02mKh3TGqIC3sURp9dZjhwlIbnnBaOGcDQDzfsrw3z1Xk0skTF3Br
         2fLFIl6BnmMj6dyVlqZ7bYYRYp+Q1IKja0RdwkpkATjt+KNRgSdLip8LBWVxjm5hxX
         fd5bRDeVIBxRXQtIh3qMwT+l5001mdgpZuJCg1Iq/NT1ID/os2dW7NwZLVvjiii1XL
         kfpb0Y4CGT6auZy2Yc9ARVSX7GdCE5lE+1ARrpk3YsSMIXJwUmHnXRXg6NDko8b0d2
         NSTI9bGQJnGPE0o/DKIMGDwkbDqeVZmRMFcCgZVdTcUujQAfCMwQoIuv6/VWkMP3Vm
         Dg5dADlGkGbmg==
Date:   Wed, 15 Feb 2023 13:53:43 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     mie@igel.co.jp, imx@lists.linux.dev, bhelgaas@google.com,
        jasowang@redhat.com, jdmason@kudzu.us, kishon@kernel.org,
        kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
        mst@redhat.com, renzhijie2@huawei.com, taki@igel.co.jp,
        virtualization@lists.linux-foundation.org
Subject: Re: PCIe RC\EP virtio rdma solution discussion.
Message-ID: <20230215082343.GA6224@thinkpad>
References: <20230207194527.4071169-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230207194527.4071169-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 07, 2023 at 02:45:27PM -0500, Frank Li wrote:
> From: Frank Li <Frank.li@nxp.com>
> 
> Recently more and more people are interested in PCI RC and EP connection,
> especially network usage cases. I upstreamed a vntb solution last year. 
> But the transfer speed is not good enough. I initialized a discussion 
> at https://lore.kernel.org/imx/d098a631-9930-26d3-48f3-8f95386c8e50@ti.com/T/#t
>  
>   ┌─────────────────────────────────┐   ┌──────────────┐
>   │                                 │   │              │
>   │                                 │   │              │
>   │   VirtQueue             RX      │   │  VirtQueue   │
>   │     TX                 ┌──┐     │   │    TX        │
>   │  ┌─────────┐           │  │     │   │ ┌─────────┐  │
>   │  │ SRC LEN ├─────┐  ┌──┤  │◄────┼───┼─┤ SRC LEN │  │
>   │  ├─────────┤     │  │  │  │     │   │ ├─────────┤  │
>   │  │         │     │  │  │  │     │   │ │         │  │
>   │  ├─────────┤     │  │  │  │     │   │ ├─────────┤  │
>   │  │         │     │  │  │  │     │   │ │         │  │
>   │  └─────────┘     │  │  └──┘     │   │ └─────────┘  │
>   │                  │  │           │   │              │
>   │     RX       ┌───┼──┘   TX      │   │    RX        │
>   │  ┌─────────┐ │   │     ┌──┐     │   │ ┌─────────┐  │
>   │  │         │◄┘   └────►│  ├─────┼───┼─┤         │  │
>   │  ├─────────┤           │  │     │   │ ├─────────┤  │
>   │  │         │           │  │     │   │ │         │  │
>   │  ├─────────┤           │  │     │   │ ├─────────┤  │
>   │  │         │           │  │     │   │ │         │  │
>   │  └─────────┘           │  │     │   │ └─────────┘  │
>   │   virtio_net           └──┘     │   │ virtio_net   │
>   │  Virtual PCI BUS   EDMA Queue   │   │              │
>   ├─────────────────────────────────┤   │              │
>   │  PCI EP Controller with eDMA    │   │  PCI Host    │
>   └─────────────────────────────────┘   └──────────────┘
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
>  https://lore.kernel.org/linux-pci/CANXvt5q_qgLuAfF7dxxrqUirT_Ld4B=POCq8JcB9uPRvCGDiKg@mail.gmail.com/T/#t
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
> - proposal: https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/T/
> - presentation on kvm forum: https://youtu.be/Qrhv6hC_YK4
> 
> Solution 2(2020, Kishon)
> 
> Previous https://lore.kernel.org/linux-pci/20200702082143.25259-1-kishon@ti.com/
> EP side use vhost, RC side use virtio.
> I don’t think anyone works on this thread now.
> If using eDMA, it needs both sides to have a transfer queue. 
> I don't know how to easily implement it on the vhost side. 
> 
> Solution 3(I am working on)
> 
> Implement infiniband rdma driver at both EP and RC side. 
> EP side build EDMA hardware queue based on EP/RC side’s send and receive
> queue and when eDMA finished, write status to complete queue for both EP/RC 
> side. Use ipoib implement network transfer.
> 
> 
> The whole upstream effort is quite huge for these. I don’t want to waste
> time and efforts because direction is wrong. 
> 
> I think Solution 1 is an easy path.
> 

I didn't had time to look into Shunsuke's series, but from the initial look
of the proposed solutions, option 1 seems to be the best for me.

Thanks,
Mani

> 
> 

-- 
மணிவண்ணன் சதாசிவம்
