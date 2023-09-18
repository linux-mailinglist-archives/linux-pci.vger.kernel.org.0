Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77F87A5022
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjIRRAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjIRRAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 13:00:13 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C037495
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 10:00:01 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id EF3C1280014E2;
        Mon, 18 Sep 2023 16:26:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D9E06527B26; Mon, 18 Sep 2023 16:26:37 +0200 (CEST)
Date:   Mon, 18 Sep 2023 16:26:37 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user
 space
Message-ID: <20230918142637.GA28754@wunner.de>
References: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
 <20230918130742.GU1599918@black.fi.intel.com>
 <fd432ea4-247a-49ca-88e6-c9f88485eb98@amd.com>
 <20230918132424.GA11357@wunner.de>
 <888824f7-06b5-4df4-ac04-c6cd599ff6f7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888824f7-06b5-4df4-ac04-c6cd599ff6f7@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 18, 2023 at 08:28:51AM -0500, Mario Limonciello wrote:
> On 9/18/2023 08:24, Lukas Wunner wrote:
> > On Mon, Sep 18, 2023 at 08:14:21AM -0500, Mario Limonciello wrote:
> > > What's the history behind why userspace is allowed to opt a device out of
> > > D3cold in the first place?
> > > 
> > > It feels like it should have been a debugging only thing to me.
> > 
> > That's a fair question.
> > 
> > Apparently the default for d3cold_allowed was originally "false"
> > and user space could opt in to D3cold.  Then commit 4f9c1397e2e8
> > ("PCI/PM: Enable D3/D3cold by default for most devices") changed
> > the default to "true".  That was 11 years ago.
> > 
> > I agree that today this should all work automatically and a
> > user space option to disable D3cold on a per-device basis only
> > really makes sense as a debugging aid, hence belongs in debugfs.
> > 
> 
> Thanks.  Then perhaps as part of moving it to debugfs it makes sense to
> simplify the logic.

d3cold_allowed is documented in Documentation/ABI/testing/sysfs-bus-pci,
so it's user space ABI which we're not allowed to break.  We'd have to
declare it deprecated, emit a warning when it's used and slowly phase
it out over the years.

Until then, the $SUBJECT_PATCH probably still makes sense to reinstate
the behavior we had until 2016...

Thanks,

Lukas
