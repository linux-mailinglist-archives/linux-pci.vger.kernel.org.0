Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03254629346
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 09:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiKOIcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 03:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKOIcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 03:32:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7AE631F;
        Tue, 15 Nov 2022 00:32:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0161961576;
        Tue, 15 Nov 2022 08:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925F4C433C1;
        Tue, 15 Nov 2022 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668501160;
        bh=qvc4PkjbFLd4d9FhXUQJc9o0AtNm4ofX85R/Lkx1n2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWbubnBI1qXAmT9YJM8uICvKoBgnifdj8lYcpO/3SbrGURsWQAqoILnDn9fly3wlt
         8feq45FgKdoGQ2PxCK6uDetR0y0Cq6YXs3K6RxR/CoAONUXuq8aZ0u1+0HzBimz8uR
         FkYQgeZBMggFeBhMhaR37zXzNqtk4vchiBQlOXnjVm8rUKakxiy6WHL11+xAblnac6
         iZCdRdg55asb/6qEkGtKABPmLLRcy6sm2fizsRnf1MOrkIDrY7asmN0im5CeQ9m8IQ
         vJWupfvTQBz7PrMEblCyill8286guDqdwRjrN127NB5d6zC9LjB1qkjbQERgP5OFTb
         DsUpJ2Tv3QH0A==
Date:   Tue, 15 Nov 2022 10:32:35 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianjay.zhou@huawei.com, zhuangshengen@huawei.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, xiehong@huawei.com
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
Message-ID: <Y3NOo3DaLKb219IV@unreal>
References: <20221111142722.1172-1-longpeng2@huawei.com>
 <Y256ty6xGyUpkFn9@unreal>
 <0b2202bf-18d3-b288-9605-279208165080@huawei.com>
 <Y3Hoi4zGFY4Fz1l4@unreal>
 <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com>
 <Y3I+Fs0/dXH/hnpL@unreal>
 <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com>
 <Y3JOvTfBwpaldtZJ@unreal>
 <CAOSf1CG+VGdeXGQetfMArwpafAx2yj3nmA_y7rN4SNdt=1=08w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CG+VGdeXGQetfMArwpafAx2yj3nmA_y7rN4SNdt=1=08w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 12:50:34PM +1100, Oliver O'Halloran wrote:
> On Tue, Nov 15, 2022 at 1:27 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > *snip*
> >
> > Anyway, I'm aware of big cloud providers who are pretty happy with live
> > migration in production.
> 
> I could see someone sufficiently cloudbrained deciding that rebooting
> the hypervisor is fine provided the downtime doesn't violate any
> customer uptime SLAs. Personally I'd only be brave enough to do that
> for a HV hosting internal services which I know are behind a load
> balancer, but apparently there are people at Huawei far braver than I.

My main point in this discussion that Huawei team doesn't actually
provide any meaningful justification why it is great idea to add new
sysfs file. They use HPC as an argument, but in that world, you won't
see many VMs on one server, as it is important to provide separate MSI-X
vectors and CPUs to each VM.

They ask from us optimization (do not add device hierarchy for existing HW)
that doesn't exist in the kernel.

I would say that they are trying to meld SIOV architecture of subfunctions
(SFs) into PCI and SR-IOV world.

Thanks
