Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F935915E1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiHLTVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 15:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHLTVa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 15:21:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D33298C82;
        Fri, 12 Aug 2022 12:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E2F0B82530;
        Fri, 12 Aug 2022 19:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E11EC433D6;
        Fri, 12 Aug 2022 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660332086;
        bh=DiulluXt2MGJ4B28v5CxKTvpqUlkZV1FWnX/0fmxOh0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GwvHUA4Uw0X9HQ7p2auCnj43eK+w6HaKvWncKQ49YJeCbMYpl0aRLfXJhnjI6yAdT
         fFybfVinHyDu5gvKPcnIn4IPlssxNdC4i7YqM3izrcwH/2kAXqqJQPTm8qH7jrzD5c
         BZd3gqDrw5UFOUAy1gLnRFC313W3gh+dfiQ+CehE18H9y0PraCO88IRiu1daCyziac
         kydUokbuUpBrrYk2/xrTV+JaXOJ7lw7bjQliR9n71iYOdt5Gj9UOXh3ImyKh+7vkxD
         9dfKi+/x5IRO35G9cJ6Jf7MosvVGit5GYZzNvjzBLq71hycPZZ++U3XdXMvwyYIqQY
         hHrDqB85dV1+g==
Date:   Fri, 12 Aug 2022 14:21:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Tom Rix <trix@redhat.com>, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, Frank.Li@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: reduce several globals
 to statics
Message-ID: <20220812192124.GA1678588@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvZgJ4IGEG8levOA@kudzu.us>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 12, 2022 at 10:13:59AM -0400, Jon Mason wrote:
> On Tue, Jul 12, 2022 at 03:05:27PM -0500, Bjorn Helgaas wrote:
> > Handled via Jon, I guess?
> > 
> > I'm unclear on the future direction of pci-epf-vntb.c.  Jon, are you
> > signing up to maintain this?  MAINTAINERS doesn't seem to reflect
> > that, even in next-20220712, so you're not being copied on everything.
> > 
> > If you are planning to merge and maintain this file, it would be
> > helpful to me if you acknowledge patches you merge so I know to ignore
> > them.
> 
> I massively dropped the ball on all the EPF stuff.  I appologize profusely.

No worries, sounds like you're getting everything sorted out :)

> I'm pulling it into my ntb tree bcause of the patch dependencies.  If
> you want me to own this stuff because it has ntb in it, then I can do
> a matainers entry to reflect it.  My assumption is that because it is
> under the drivers/pci umbrella it is yours (unless you want me to own
> it).  100% defer to your decision.

This patch dependency thing feels like a one-time or at least unusual
situation.  Unless it becomes a problem, I think it makes sense to
keep the drivers/pci umbrella instead of carving bits out of the
middle.

Even if I continue to merge everything under drivers/pci, maybe we
should consider an update like this just so you get cc'd on updates to
these files?

diff --git a/MAINTAINERS b/MAINTAINERS
index 08a5d70ceef9..5bafe7e8c2b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14466,6 +14466,7 @@ W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
 F:	drivers/net/ntb_netdev.c
 F:	drivers/ntb/
+F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
 F:	include/linux/ntb.h
 F:	include/linux/ntb_transport.h
 F:	tools/testing/selftests/ntb/
