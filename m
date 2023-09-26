Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAAC7AF6E4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 01:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjIZXqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Sep 2023 19:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjIZXoA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Sep 2023 19:44:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C79008;
        Tue, 26 Sep 2023 16:02:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD1EC433C7;
        Tue, 26 Sep 2023 23:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695769369;
        bh=je6g4sK4peKsh1qGI9bWWT/XBfOKZh3dIb4/VXqVR94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EAvZ3vNy2vbk5wk/qfuZFLTEzYgxPC0IYYVZYNR1ywjJCc/PknMAGU9l9YgkeUC0D
         IuCC0cbREtDSWvQO/d+8xxXF+rvW+7sIJh4gkPkycF0XSKWoHqOd8kzk10XbDgzylE
         y6loJllN6SBw6Lqj3JNsIraIOGu+Q1prRZTdWYcFyEXnYtiHcGW/Nbdv9wpENKYprW
         3Zt76Rn69EOBuO3S/HiKtmJg9qR2z4o6HsIVeHe3BhsCs8hvQWo1SEXbnScSnTsI0w
         bLtk+MvKaBJqKNx4vERctWe0Lk/crpGPtb3oigWZknhckvTcDY3fmVO5ShaLZpfJxG
         5z1iuIuI0PrsA==
Date:   Tue, 26 Sep 2023 18:02:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "tanxiaofei@huawei.com" <tanxiaofei@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>, gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        mahesh@linux.ibm.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linux PCI <linux-pci@vger.kernel.org>, bhelgaas@google.com,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: Re: Questions: Should kernel panic when PCIe fatal error occurs?
Message-ID: <20230926230247.GA429368@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc7a4ee-250f-7ec8-ca15-32cbd480bd3e@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 22, 2023 at 10:46:36AM +0800, Shuai Xue wrote:
> ...

> Actually, this is a question from my colleague from firmware team.
> The original question is that:
> 
>     "Should I set CPER_SEV_FATAL for Generic Error Status Block when a
>     PCIe fatal error is detected? If set, kernel will always panic.
>     Otherwise, kernel will always not panic."
> 
> So I pull a question about desired behavior of Linux kernel first :)
> From the perspective of the kernel, CPER_SEV_FATAL for Generic Error
> Status Block is not reasonable. The kernel will attempt to recover
> Fatal errors, although recovery may fail.

I don't know the semantics of CPER_SEV_FATAL or why it's there.
With CPER, we have *two* error severities: a "native" one defined by
the PCIe spec and another defined by the platform via CPER.

I speculate that the reason for the CPER severity could be to provide
a severity for error sources that don't have a "native" severity like
AER does, or for the vendor to force the OS to restart (for
CPER_SEV_FATAL, anyway) in cases where it might not otherwise.

In the native case, we only have the PCIe severity and don't have the
CPER severity at all, and I suspect that unless there's uncontained
data corruption, we would rather handle even the most severe PCIe
fatal error by disabling the specific device(s) instead of panicking
and restarting the whole machine.

So for PCIe errors, I'm not sure setting CPER_SEV_FATAL is beneficial
unless the platform wants to force the OS to panic, e.g., maybe the
platform knows about data corruption and/or the vendor wants the OS to
panic as part of a reliability story.

Presumably the platform has already logged the error, and I assume the
platform *could* restart without even returning to the OS, but maybe
it wants the OS to do a crashdump or shutdown in a more orderly way.

Bjorn
