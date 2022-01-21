Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8489F496358
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 17:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381542AbiAUQ5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 11:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380427AbiAUQ5L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 11:57:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634F8C06173B;
        Fri, 21 Jan 2022 08:57:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0169B61A5F;
        Fri, 21 Jan 2022 16:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9D0C340E1;
        Fri, 21 Jan 2022 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642784229;
        bh=VAH/EB9un3em4rOt5evA5NBqtb1X5kVyOQuIem/HfhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ObJENak7V3h9A2S++J8N8+hw/43AqvzdDjNkj7XZRkXxp4MYigrM6Xo6DYE5vwt6m
         mx+9CJKOwEMoj5/lC1sFyMvnAzwvNmwpjctkTTvL23WpWWIMsXcayaCyqVypvtr9Wi
         AWMqx38L1s9yBSJNMAYY2awOpbDHZp5CFrkgF7guSO/U+F2L1YHM/QfkRraf2JvmiD
         jPPu1eGOAiPU5LR46o8mCrrsUC3i7kxl3ic9e+sPTq8e+SGNK7WCT/nPTUbc8so8PD
         n0if+30ZJGlfEOymuqqgiDrUGNJhdxLV/PIaJuDHtEnsVCkokb5SxyhKQHbvT5pzz+
         zH0J1q2Mbwm6Q==
Date:   Fri, 21 Jan 2022 10:57:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files (can't boot)
Message-ID: <20220121165707.GA1129091@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3bl05zhjt.fsf@t19.piap.pl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 21, 2022 at 08:14:46AM +0100, Krzysztof Hałasa wrote:
> Hi Bjorn, Krzysztof,
> 
> Bjorn Helgaas <helgaas@kernel.org> writes:
> 
> > On Fri, Jul 30, 2021 at 10:18:44AM +0200, Krzysztof Hałasa wrote:
> >> I'm encountering a problem booting an i.MX6-based device (Gateworks
> >> Ventana SBC). This is apparently a known issue:
> >> https://lkml.org/lkml/2020/7/16/388
> 
> > Hi Krzysztof, is this still an issue?
> 
> Well... I'm still using i.MX6 with 5.14 and Krzysiek Wilczyński's "PCI:
> Race condition in pci_create_sysfs_dev_files (can't boot)" patch (which
> fixes the problem). It seems parts of this patch are now in mainline,
> but most of it is still missing. So I guess the problem isn't fixed.
> 
> Perhaps because the DEC Alpha part of the patch is not yet ready?
> Krzysztof?
> 
> > e1d3f3268b0e ("PCI/sysfs: Convert "config" to static attribute") and
> > similar patches appeared in v5.13,
> 
> Right, but they hadn't fixed the problem. 5.13 was released in June, and
> I have started using the patch in August (apparently with pre-5.14
> first, then with final 5.14).

Thanks.  e1d3f3268b0e and related patches converted individual files
("config", "rom", "vpd", etc) to static attributes, but since the
problem you're seeing is with a directory, it's likely different.

I opened this bugzilla report to try to keep this from getting lost:
https://bugzilla.kernel.org/show_bug.cgi?id=215515

Bjorn
