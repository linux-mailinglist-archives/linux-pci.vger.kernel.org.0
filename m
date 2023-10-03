Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BF97B729F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 22:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjJCUlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjJCUlC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 16:41:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270EAC
        for <linux-pci@vger.kernel.org>; Tue,  3 Oct 2023 13:40:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC70AC433C7;
        Tue,  3 Oct 2023 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696365659;
        bh=lXQA3J28FiKzoJcCZ9u40FbLOex888CcuDkMtxe3o90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MWwIKCOCg7A5ndi0ONb+Wav1izd2kB5Fa08vjDK6U7eFk2PXZmlaB000JrV4YNxki
         EvYT0mslc967AFXrwzYIvQNFo4P2ksnrHjSMV2rE5SobzR9jJPZKlWl2AsLbftYL+T
         M368RZ6zlKtXxdnG2oICgiVe7nZ/hkezglzVWtA5JL4ZaUy8vlQiMtC+ODVVTy2DaE
         eSeJOQN/AjvAVkdkwVmZiSlwsod+8bBH/HTF7gR49d8dsHLMxl4JcZgaY/bleCuWnf
         8N+5KSak5POgLextgb1SolEUGHRwd29Rh9nFEwIn0w6pqa+x8rm8F+xaV6mwnizTtf
         iQPEsMdAReWdA==
Date:   Tue, 3 Oct 2023 15:40:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        kernel@pengutronix.de, Xiaowei Song <songxiaowei@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/4] PCI: kirin: Don't put .remove callback in .exit.text
 section
Message-ID: <20231003204056.GA687507@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003202330.zsmqckgbk2wbhvos@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 03, 2023 at 10:23:30PM +0200, Uwe Kleine-König wrote:
> On Tue, Oct 03, 2023 at 12:15:24PM +0200, Uwe Kleine-König wrote:
> > On Mon, Oct 02, 2023 at 05:12:18PM -0500, Bjorn Helgaas wrote:
> > > On Sun, Oct 01, 2023 at 07:02:52PM +0200, Uwe Kleine-König wrote:
> > > > With CONFIG_PCIE_KIRIN=y and kirin_pcie_remove() marked with __exit, the
> > > > function is discarded from the driver. In this case a bound device can
> > > > still get unbound, e.g via sysfs. Then no cleanup code is run resulting
> > > > in resource leaks or worse.
> > > 
> > > kirin_pcie_driver sets .suppress_bind_attrs = true.
> > > 
> > > Doesn't that mean that we can't unbind a device via sysfs in this
> > > case?
> > 
> > Oh indeed, that's something I missed.
> >  
> > > I don't expect modpost to know about .suppress_bind_attrs, so maybe we
> > > should remove the __exit annotation even if it would be safe to keep
> > > it in this case.  It's a tiny function anyway.
> > 
> > the right thing to do then is something like:
> > https://lore.kernel.org/linux-rtc/20231002080529.2535610-7-u.kleine-koenig@pengutronix.de
> > 
> > And then it would be consequent to also switch to
> > module_platform_driver_probe and move .probe to __init. Or drop
> > .suppress_bind_attrs and keep/put .probe() and .remove() in .text.
> 
> The other three patches in this series don't suffer from this oversight
> and so are (from my POV) ready to go in.

Agreed.  My first impression was that this would be v6.7 material, but
based on
https://lore.kernel.org/linux-kbuild/CAK7LNATyRg6Hc-fnTETERj-tdMFGaBDt0Fyhy9+jKCzAvzQ6Pg@mail.gmail.com/,
I guess that modpost change must be headed for v6.6?

And while I haven't seen problem reports, branching into the weeds
because of a sysfs "remove" would be a pretty bad outcome, so I can
see a case for v6.6 and stable tags as well.  Is that your thought
process, too?

> If you tell me, which option you prefer for the kirin driver, I'll
> follow up with a matching patch. (If you don't know, my preference would
> be to drop .suppress_bind_attrs and move .probe() and .remove() to
> .text.)

I agree, dropping .suppress_bind_attrs would be desirable, although I
would hope for some kind of assurance that it's not there because of
an issue with removal or something.

Bjorn
