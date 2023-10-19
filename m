Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07627CECF7
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 02:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjJSAxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 20:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJSAxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 20:53:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9F11D
        for <linux-pci@vger.kernel.org>; Wed, 18 Oct 2023 17:53:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7085DC433C8;
        Thu, 19 Oct 2023 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697676828;
        bh=uNMAhPzGTszsYSQImNvwl65cDQTSsOk0szBJaflFAh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ae5ae9X5ap/zTM5hWuDz+lXHPreTicTc+xnvFTZObiGfvO1ORVB2s95qLxbjtVDsu
         zDMw+C0nI3cafQwxuJYszR6IHPKhNuG5JEcT8t9zTpy18ydrJHXD1KA8Kb5XWACF8x
         xsdbzo6Hs1AnZwoUhjVDrTFAls8FAKlBBAPxI88qAlJUwcHbsr+OExAWc5nfFimSE0
         ohVutm0ieuyXTc6edIrmicnRZKy9mXeNleiFoxivCGvct4B6TNlza5FNh4betho/+s
         f2NFJOmZIcHMxY/AmQHWrJo+imkIzp3D7TKy2mta0e7cNH2zIsGevFg9rxDu7+OOhk
         4a7SH/7OTN01A==
Date:   Wed, 18 Oct 2023 17:53:47 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
        <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        <lukas@wunner.de>, <petrm@nvidia.com>, <jiri@nvidia.com>,
        <mlxsw@nvidia.com>
Subject: Re: [RFC PATCH net-next 01/12] netdevsim: Block until all devices
 are released
Message-ID: <20231018175347.67d5ccf4@kernel.org>
In-Reply-To: <20231017074257.3389177-2-idosch@nvidia.com>
References: <20231017074257.3389177-1-idosch@nvidia.com>
        <20231017074257.3389177-2-idosch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 17 Oct 2023 10:42:46 +0300 Ido Schimmel wrote:
> Like other buses, devices on the netdevsim bus have a release callback
> that is invoked when the reference count of the device drops to zero.
> However, unlike other buses such as PCI, the release callback is not
> necessarily built into the kernel, as netdevsim can be built as a
> module.
> 
> This above is problematic as nothing prevents the module from being
> unloaded before the release callback has been invoked, which can happen
> asynchronously. One such example is going to be added in subsequent
> patches where devlink will call put_device() from an RCU callback.
> 
> The issue is not theoretical and the reproducer in [1] can reliably
> crash the kernel. The conclusion of this discussion was that the issue
> should be solved in netdevsim, which is what this patch is trying to do.
> 
> Add a reference count that is increased when a device is added to the
> bus and decreased when a device is released. Signal a completion when
> the reference count drops to zero and wait for the completion when
> unloading the module so that the module will not be unloaded before all
> the devices were released. The reference count is initialized to one so
> that completion is only signaled when unloading the module.
> 
> With this patch, the reproducer in [1] no longer crashes the kernel.
> 
> [1] https://lore.kernel.org/netdev/20230619125015.1541143-2-idosch@nvidia.com/
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
