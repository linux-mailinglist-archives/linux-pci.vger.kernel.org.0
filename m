Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0462952A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 11:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiKOKCf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 05:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbiKOKCe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 05:02:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A79240A5;
        Tue, 15 Nov 2022 02:02:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B2B860C25;
        Tue, 15 Nov 2022 10:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52269C433D6;
        Tue, 15 Nov 2022 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668506550;
        bh=ncdKJ7n+5xnqMWJ69JS/iDQYOdJqOI7Xhk/xeUSmdGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ov69RXAVqqnc4ZIYgsHDD+uUtC3B7R6l7HEy7XzykroTSHwpQhK5noX9SEo3dHs5g
         Edw5NJau1o6JXw5rCM9mM7sSaIOTlgy+HHfO3+cqt7oij3x+TJKypIkPSW13HI2huz
         J3fXPFfOXAZnaKNWdElTV1uzmNorKE/du/ALlCsdsgDXznZ32+Ul4mdZVa6VvKOqNc
         +3OqHKqG8RHAhSIwoYYJFngxqjJF/WWtx07xf/jcIZGR38/FyIXsfAz9txEKD7EvTn
         bATIObRj9r8VZOsaacEDPtl8txaxoKiMaqGqcLMKuIsQS9GaTQr+n7ps0hu/EGp4qe
         70PU23GOSRMow==
Date:   Tue, 15 Nov 2022 12:02:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     Oliver O'Halloran <oohall@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianjay.zhou@huawei.com, zhuangshengen@huawei.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, xiehong@huawei.com
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
Message-ID: <Y3NjslijVKfLQo3W@unreal>
References: <Y256ty6xGyUpkFn9@unreal>
 <0b2202bf-18d3-b288-9605-279208165080@huawei.com>
 <Y3Hoi4zGFY4Fz1l4@unreal>
 <d7327d46-deb5-dc75-21c3-1f351d7da108@huawei.com>
 <Y3I+Fs0/dXH/hnpL@unreal>
 <3a8efc92-eda8-9c61-50c5-5ec97e2e2342@huawei.com>
 <Y3JOvTfBwpaldtZJ@unreal>
 <CAOSf1CG+VGdeXGQetfMArwpafAx2yj3nmA_y7rN4SNdt=1=08w@mail.gmail.com>
 <Y3NOo3DaLKb219IV@unreal>
 <638b2550-7da8-1b48-4038-52f71947ff05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <638b2550-7da8-1b48-4038-52f71947ff05@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 05:36:38PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> 
> 
> 在 2022/11/15 16:32, Leon Romanovsky 写道:
> > On Tue, Nov 15, 2022 at 12:50:34PM +1100, Oliver O'Halloran wrote:
> > > On Tue, Nov 15, 2022 at 1:27 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > > 
> > > > *snip*
> > > > 
> > > > Anyway, I'm aware of big cloud providers who are pretty happy with live
> > > > migration in production.
> > > 
> > > I could see someone sufficiently cloudbrained deciding that rebooting
> > > the hypervisor is fine provided the downtime doesn't violate any
> > > customer uptime SLAs. Personally I'd only be brave enough to do that
> > > for a HV hosting internal services which I know are behind a load
> > > balancer, but apparently there are people at Huawei far braver than I.
> > 
> > My main point in this discussion that Huawei team doesn't actually
> > provide any meaningful justification why it is great idea to add new
> > sysfs file. They use HPC as an argument, but in that world, you won't
> > see many VMs on one server, as it is important to provide separate MSI-X
> > vectors and CPUs to each VM.
> > 
> > They ask from us optimization (do not add device hierarchy for existing HW)
> > that doesn't exist in the kernel.
> > 
> > I would say that they are trying to meld SIOV architecture of subfunctions
> > (SFs) into PCI and SR-IOV world.
> > 
> I may not agree with you on this point. 

The bright side of open source that you don't need to agree with everyone.
If you success to convince others, it will be merged.

> The sriov_numvfs interface mixes the
> operation of enabling hardware VFs and the addition of VFs. I just want to
> split these two operations and also can selectively add some VFs earlier
> than others. I think there's no violation of PCI spec.

Right, it just doesn't fit into Linux kernel device initialization model.

Thanks

> 
> > Thanks
> > .
