Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF1662763A
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 08:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiKNHEw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 02:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiKNHEw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 02:04:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43082616F;
        Sun, 13 Nov 2022 23:04:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF454B80CAF;
        Mon, 14 Nov 2022 07:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D99AC433D6;
        Mon, 14 Nov 2022 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668409488;
        bh=TkPGi2ue/2fLbYejENb2MuMC8p5M06Z4KwCn039Kci0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PjSYHUSrazaQYc0ynLL8XIPE8zeK3mZwPv66gCB18Uy1mB0oLyxjmNg1Wt+aIWZQz
         3KrnrPKWCKDLgoEF7q/YxUlPSpxmvHEqxgWrHrIGrcQoEGfDue4xOzO4a98NnwZ1pn
         yIaUwLsKfHYwabJfmY3ZOOjavcqhk1enOqBv9fmzav3KDYXbery67JQ/8EZc5TZkn6
         hBdage6e1GCcVdrrxrkQA65VTGRDnmIRk0JOJwoImFmhS6UHgS1MuXTAlTWCBe+FQL
         kh6tVdO5+sPCtes2f/4OG9ZtpaXhkzeLuVXcBKUdXHz29bYkVCoo3+dICa5JHPyiZT
         2wgZohYRYNjVA==
Date:   Mon, 14 Nov 2022 09:04:43 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jianjay.zhou@huawei.com,
        zhuangshengen@huawei.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com, xiehong@huawei.com
Subject: Re: [RFC 0/4] pci/sriov: support VFs dynamic addition
Message-ID: <Y3Hoi4zGFY4Fz1l4@unreal>
References: <20221111142722.1172-1-longpeng2@huawei.com>
 <Y256ty6xGyUpkFn9@unreal>
 <0b2202bf-18d3-b288-9605-279208165080@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b2202bf-18d3-b288-9605-279208165080@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 13, 2022 at 09:47:12PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> Hi leon,
> 
> 在 2022/11/12 0:39, Leon Romanovsky 写道:
> > On Fri, Nov 11, 2022 at 10:27:18PM +0800, Longpeng(Mike) wrote:
> > > From: Longpeng <longpeng2@huawei.com>
> > > 
> > > We can enable SRIOV and add VFs by /sys/bus/pci/devices/..../sriov_numvfs, but
> > > this operation needs to spend lots of time if there has a large amount of VFs.
> > > For example, if the machine has 10 PFs and 250 VFs per-PF, enable all the VFs
> > > concurrently would cost about 200-250ms. However most of them are not need to be
> > > used at the moment, so we can enable SRIOV first but add VFs on demand.
> > 
> > It is unclear what took 200-250ms, is it physical VF creation or bind of
> > the driver to these VFs?
> > 
> It is neither. In our test, we already created physical VFs before, so we
> skipped the 100ms waiting when writing PCI_SRIOV_CTRL. And our driver only
> probes PF, it just returns an error if the function is VF.

It means that you didn't try sriov_drivers_autoprobe. Once it is set to
true, It won't even try to probe VFs.

> 
> The hotspot is the sriov_add_vfs (but no driver probe in fact) which is a
> long procedure. Each step costs only a little, but the total cost is not
> acceptable in some time-sensitive cases.

This is also cryptic to me. In standard SR-IOV deployment, all VFs are
created and configured while operator booted the machine with sriov_drivers_autoprobe
set to false. Once this machine is ready, VFs are assigned to relevant VMs/users
through orchestration SW (IMHO, it is supported by all orchestration SW). 

And only last part (assigning to users) is time-sensitive operation.

> 
> What’s more, the sriov_add_vfs adds the VFs of a PF one by one. So we can
> mostly support 10 concurrent calls if there has 10 PFs.

I wondered, are you using real HW? or QEMU SR-IOV? What is your server
that supports such large number of VFs?

BTW, Your change will probably break all SR-IOV devices in the market as
they rely on PCI subsystem to have VFs ready and configured.

Thanks
