Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01D6A5DB5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 17:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjB1Qyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 11:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB1Qya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 11:54:30 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E6433669D
        for <linux-pci@vger.kernel.org>; Tue, 28 Feb 2023 08:54:02 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id AC854E0EB4;
        Tue, 28 Feb 2023 19:35:03 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=CuNkOupsAqXo74CzsFjX
        z2B4PdfP8UnQM9Atgh14Tdc=; b=Pm5ly4gnRYRRSuGzuxynxW5677hdqTiDpDYl
        gY7BT0wOUqg399GqVjmw3gYAr5UQxWAZ+ht65BYEyec5fOy1kFNWaGaH2D5fNW/b
        TQXzLsiI1Kpd3m9DJrXyPPsuen0QblaiyBK2OWtfwBEkLU6iFrb1kpU3xPv/2yYy
        C9PVhRw=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 90EB3E0E1D;
        Tue, 28 Feb 2023 19:35:03 +0300 (MSK)
Received: from mobilestation (10.8.30.22) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 28 Feb 2023 19:35:02 +0300
Date:   Tue, 28 Feb 2023 19:35:01 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>, Anton <smalltalk@swismail.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, <smalltalk@swismail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Bug 217100] New: Bifurcation between pcie3x1 & pcie3x2 doesn't
 work in RK3568J.
Message-ID: <20230228163420.e4tskh3bwposkxji@mobilestation>
References: <bug-217100-41252@https.bugzilla.kernel.org/>
 <20230228124427.GA114786@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230228124427.GA114786@bhelgaas>
X-Originating-IP: [10.8.30.22]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

* Cc += Linux ARM mailing list

Hi Anton

On Tue, Feb 28, 2023 at 06:44:27AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 28, 2023 at 08:53:50AM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=217100
> > 
> >            Summary: Bifurcation between pcie3x1 & pcie3x2 doesn't work in
> >                     RK3568J.
> > ...
> 
> > Hello.
> > 
> > First, I want to say that pcie3x1 crashes if started before pcie3x2 . Driver
> > > pcie-designware.c 
> > 
> > in function 
> > 
> > > void dw_pcie_version_detect(struct dw_pcie *pci)
> > 
> > tries to read parameter from dbi register (PCIE_VERSION_NUMBER) and fails on
> > it.

Could you give more details what crashes? Log/Stack-trace would be
nice to see.

Do you know the DW PCIe IP-core version? Could you try to manually get the
content of the PCIE_VERSION_NUMBER and PCIE_VERSION_TYPE registers after
the system successfully boots up?

On the first glance what you see here might be caused by the DBI
reference clock race condition/malfunction. The
dw_pcie_version_detect() function doesn't do much. It just reads the
IP-core version/type registers content. So if the reference clock
isn't enabled by the time of the function call then the system bus may
return an error, which could be caught by the system errors handler
module, which driver can cause the kernel crash. Though the LLDD
enables all the supplied clocks before calling dw_pcie_host_init(). So
what you've discovered seems unexpected and most likely caused by some
other place. Thereby here are several questions:

1. Are you sure your DT-file has all the required reference clocks
specified for all the Rockchip PCIe DT-nodes?

2. Are you sure there were no updates in the platform-clock
driver(s) which could cause a possible clock malfunction?

3. Could you have a look whether the pcie3x1 and pcie3x2 reference/DBI
clock sources are unrelated? That might give a clue to the problem
solution and could confirm the race.

4. Are you sure that the problem is in the dw_pcie_version_detect()
function? Could you try to replace all the dw_pcie_readl_dbi() calls
with the actual content of the PCIE_VERSION_NUMBER and PCIE_VERSION_TYPE
registers and then have a look whether the crash still happens?

Anyway Log/Stack-trace would give better understanding of the problem.

> > So I changed sequence of declaration PCIE in rk3568.dtsi: first - pcie3x2 next
> > pcie3x1. Now Linux first starts pcie3x2, then successfully starts pcie3x1.
> > 
> > But main problem is that bifurcation in phy driver 
> > > phy-rockchip-snps-pcie3.c 
> > 
> > doesn't work. I tried add next lines in function

It seems to me that this problem and the problem above might be weakly
related. Let's dive deeper in the first problem. Then we can go
towards the second problem if it will be actual by that time.

> > 
> > > static int rockchip_p3phy_probe(struct platform_device *pdev)
> > 
> > right after block check
> > 
> > > if (priv->num_lanes == -EINVAL) {
> > > }
> > 
> > > priv->num_lanes = 2;
> > > priv->lanes[0] = 1;
> > > priv->lanes[1] = 2
> > 
> > And driver writes during Linux boot process that bifurcation is enabled, but
> > 
> > lspci
> > 
> > does't show second device.
> > 
> > Best regards,
> > Anton.
> 
> Thanks much for your report, Anton.  People don't really pay attention
> to the bugzilla, so I'm forwarding this to the mailing list and to
> some folks who've worked on that driver in the past.
> 

> MAINTAINERS doesn't list an entry for pcie-dw-rockchip.c; I'm not sure
> if that's an oversight or if nobody cares enough to actually maintain
> it.

Hi Bjorn

It seems that the driver is currently supported by the Rockchip SoC maintainer:
ARM/Rockchip SoC support
F:      drivers/*/*/*rockchip*
F:      drivers/*/*rockchip*
So @Heiko might give a more experienced advice about the bug.

-Serge(y)

> 
> Bjorn
> 

