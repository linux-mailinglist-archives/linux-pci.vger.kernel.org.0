Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700734B0638
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 07:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiBJGXM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 01:23:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiBJGXL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 01:23:11 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630241AE
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 22:23:12 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 03E1E30000642;
        Thu, 10 Feb 2022 07:23:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EC2F718E42; Thu, 10 Feb 2022 07:23:08 +0100 (CET)
Date:   Thu, 10 Feb 2022 07:23:08 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "anatoli.antonovitch@amd.com" <anatoli.antonovitch@amd.com>,
        "Kumar1, Rahul" <Rahul.Kumar1@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
Subject: Re: Question about deadlock between AER and pceihp interrupts during
 resume from S3 with unplugged device
Message-ID: <20220210062308.GB929@wunner.de>
References: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc31d9a-f414-a412-3765-5519cbb9b7ff@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 09, 2022 at 02:54:06PM -0500, Andrey Grodzovsky wrote:
> Hi, on kernel based on 5.4.2 we are observing a deadlock between
> reset_lock semaphore and device_lock (dev->mutex). The scenario
> we do is putting the system to sleep, disconnecting the eGPU
> from the PCIe bus (through a special SBIOS setting) or by simply
> removing power to external PCIe cage and waking the
> system up.
> 
> I attached the log. Please advise if you have any idea how
> to work around it ? Since the kernel is old, does anyone
> have an idea if this issue is known and already solved in later kernels ?
> We cannot try with latest since our kernel is custom for that platform.

It is a known issue.  Here's a fix I submitted during the v5.9 cycle:

https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73dab4b6.1595329748.git.lukas@wunner.de/

The fix hasn't been applied yet.  I think I need to rework the patch,
just haven't found the time.

Since the trigger in your case are AER-handled errors during a
system sleep transition, you may also want to consider the
following 2-patch series by Kai-Heng Feng which is currently
under discussion:

https://lore.kernel.org/linux-pci/20220127025418.1989642-1-kai.heng.feng@canonical.com/

That series disables AER during a system sleep transition and
should thus prevent the flood of AER-handled errors you're seeing.
Once AER is disabled, the reset-induced deadlocks should go away as well.

Thanks,

Lukas
