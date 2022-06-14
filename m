Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA5154A6FF
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 04:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354493AbiFNCq1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 22:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353729AbiFNCqF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 22:46:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FEC56417;
        Mon, 13 Jun 2022 19:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 788EC6140C;
        Tue, 14 Jun 2022 02:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43116C34114;
        Tue, 14 Jun 2022 02:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655173420;
        bh=2JdpeLCcSB+EkvAsWhfjyJ3Yq+6ICihCOSoee4FwUcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FVjARZi0H5LFS8bhfKScyQVBoSEzNU+8aBH6w34TAaQnKjP+eyQtJA8doYV0+0VaH
         hu/J6hoKUDKk7djV8XqOM63HxSrVP+I83gjyRqIZPc0Vdpjx4O61iDPlJ/M3ORtQo5
         wFH0R9tzirOAOeoy6ZkmGZKUkoyRTYEH85Hud28eO/L7sXKp3/RA1hO/TNntlAzNZH
         WzWgdBDUibYMB1X8NsQA0p4us7MSncByO2y3RHpRf2l1JmsUsuTbDqvr8ajCWiorDI
         B8I2m8FusgQOy3xGUxrUpwcq/1js8hok7vstbhGMItiYioOdI43j6Xo/xNBuc68BCZ
         Ll4BDqx6YYKQg==
Date:   Mon, 13 Jun 2022 20:23:37 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <YqfxKanxbZNN7Kfw@kbusch-mbp.dhcp.thefacebook.com>
References: <20220609235329.4jbz4wr3eg2nmzqa@shindev>
 <717734c9-c633-fb48-499e-7e3e15113020@nvidia.com>
 <19d09611-42cc-5a81-d676-c5375865c14c@nvidia.com>
 <20220610122517.6pt5y63hcosk5mes@shindev>
 <YqNZiMw+rH5gyZDI@kbusch-mbp.dhcp.thefacebook.com>
 <CAHj4cs9G0WDrnSS6iVZJfgfOcRR0ysJhw+9yqcbqE=_8mkF0zw@mail.gmail.com>
 <20220614010907.bvbrgbz7nnvpnw5w@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614010907.bvbrgbz7nnvpnw5w@shindev>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 01:09:07AM +0000, Shinichiro Kawasaki wrote:
> (CC+: linux-pci)
> On Jun 11, 2022 / 16:34, Yi Zhang wrote:
> > On Fri, Jun 10, 2022 at 10:49 PM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > And I am not even sure this is real. I don't know yet why this is showing up
> > > only now, but this should fix it:
> > 
> > Hi Keith
> > 
> > Confirmed the WARNING issue was fixed with the change, here is the log:
> 
> Thanks. I also confirmed that Keith's change to add __ATTR_IGNORE_LOCKDEP to
> dev_attr_dev_rescan avoids the fix, on v5.19-rc2.
> 
> I took a closer look into this issue and found The deadlock WARN can be
> recreated with following two commands:
> 
> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/rescan
> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/remove
> 
> And it can be recreated with PCI devices other than NVME controller, such as
> SCSI controller or VGA controller. Then this is not a storage sub-system issue.
> 
> I checked function call stacks of the two commands above. As shown below, it
> looks like ABBA deadlock possibility is detected and warned.

Yeah, I was mistaken on this report, so my proposal to suppress the warning is
definitely not right. If I run both 'echo' commands in parallel, I see it
deadlock frequently. I'm not familiar enough with this code to any good ideas
on how to fix, but I agree this is a generic pci issue.
