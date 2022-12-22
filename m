Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D271654810
	for <lists+linux-pci@lfdr.de>; Thu, 22 Dec 2022 22:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLVV4X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Dec 2022 16:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLVV4W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2022 16:56:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1681560E4;
        Thu, 22 Dec 2022 13:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE5B5B81F68;
        Thu, 22 Dec 2022 21:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA30C433EF;
        Thu, 22 Dec 2022 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671746179;
        bh=o/IOhMQYjqUZfDUiHQwOp3Yn4c+ddHZr9IY7DkkCCxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGZJbQTRLGeWFggUnFPXha93VxiZ/1T4wAGgjdC+JkAvqgmsHLUsJl7RYgZV2vpXj
         47joN8toEM1NtWrvW4aORQY0tzKVb99VQ5H0tYPEIRbDAFSjiJ4mRVuMXyXHpvt3/0
         kOFpMXnfMEzzZbe0bWsE7P7vBDF4zRiC+rPST8XDvwFsp8DU4zelTHf8JVU+2wcGKN
         sX5rqrc4QZloUONLJryC/J/5HPg93/lY9wN74cA5EruyAwuf1EyH/U3I83Y2IKphVV
         u2wTcr2PjHfEn0HgS/gIM7yJ5E8xbSzKZlmJE0LvZvzvkwaIT3g7ZE6SDLGEoTEf5b
         y6mkoXUc9G57w==
Date:   Thu, 22 Dec 2022 14:56:16 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     korantwork@gmail.com, nirmal.patel@linux.intel.com,
        lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH] PCI: vmd: Do not disable MSI-X remapping in VMD 28C0
 controller
Message-ID: <Y6TSgGdCTvkwPiVg@kbusch-mbp.dhcp.thefacebook.com>
References: <20221222072603.1175248-1-korantwork@gmail.com>
 <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1834d9-7905-1225-741a-f298dd5b8a8e@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 22, 2022 at 02:15:20AM -0700, Jonathan Derrick wrote:
> On 12/22/22 12:26 AM, korantwork@gmail.com wrote:
> > 
> > However, the bypass mode could increase the interrupts costs in CPU.
> > We test 12 disks in the 6 CPU,
>
> Well the bypass mode was made to improve performance where you have >4
> drives so this is pretty surprising. With bypass mode disabled, VMD will
> intercept and forward interrupts, increasing costs.
> 
> I think Nirmal would want to to understand if there's some other factor
> going on here.

With 12 drives and only 6 CPUs, the bypass mode is going to get more irq
context switching. Sounds like the non-bypass mode is aggregating and
spreading interrupts across the cores better, but there's probably some
cpu:drive count tipping point where performance favors the other way.

The fio jobs could also probably set their cpus_allowed differently to
get better performance in the bypass mode.
