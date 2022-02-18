Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAAC4BBD3C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbiBRQRh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 11:17:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiBRQRe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 11:17:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A75A21E2B;
        Fri, 18 Feb 2022 08:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 370B2B82685;
        Fri, 18 Feb 2022 16:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EB3C340F0;
        Fri, 18 Feb 2022 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645201033;
        bh=tCeT+Bo4+/T9ZkNyZsZjBce9KY5pPvJWWLCo0Pn/L5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4dN/YAAZshUE1Epd4uR0mpQeEU27iLZYKVkOvSK8Z/VV/pG+yh/5a4xN9rt4NPCq
         +t9do+9jYBIfM8c9d0ZYLYMlSatnXOsiLFx5ulPn4kDUvCqg9h6CB3jCHwPNZLa5DD
         3LGY63NDHyMcBUCuASATzyq53BvjulurY/NrABXruwnnKWTPhYO3DKcrnA3NSu2seh
         x7D4UFmr/z6Hr3004kY86waQ8Fxw0NKJO7Twus0d5KAraMN0abczwddt/SOiCBkTqu
         +H4nc7+Tbx2hsX4RpJAe1tWba3tLjhCIsdcROnkfcmhgn01wbWusYEi3s5w9wIDBug
         F9GiNUUtgklow==
Received: by pali.im (Postfix)
        id BCDA92BAE; Fri, 18 Feb 2022 17:17:10 +0100 (CET)
Date:   Fri, 18 Feb 2022 17:17:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which
 triggered an exception
Message-ID: <20220218161710.rkalq3oyd3negplj@pali>
References: <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
 <20220123164936.cmzvkkkuw5chz3ek@pali>
 <9d89314c-8757-8965-0f5d-14fd95669320@gmail.com>
 <20220124093752.l2kpenot6wj76753@pali>
 <65a09af0-f09d-cf46-3d04-d7c9d2750227@gmail.com>
 <20220131125341.7jzckjihz3cwrxg3@pali>
 <20220217112949.xt6saomde47prbom@pali>
 <ae4dcb09-98d0-64e8-79a8-1bff16505abc@gmail.com>
 <20220217130405.xq73bqshvldy2vn2@pali>
 <4901fe69-5bf2-0083-d890-bfaee467f57d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4901fe69-5bf2-0083-d890-bfaee467f57d@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 18 February 2022 02:53:39 Marek Vasut wrote:
> On 2/17/22 14:04, Pali Rohár wrote:
> 
> [...]
> 
> > > > > > Flipping either bit makes no difference, suspend/resume behaves the same and
> > > > > > the link always recovers.
> > > > > 
> > > > > Ok, perfect! And what happens without suspend/resume (just in normal
> > > > > conditions)? E.g. during active usage of some PCIe card (wifi, sata, etc..).
> > > > 
> > > > PING? Also what lspci see for the root port and card itself during hot reset?
> > > 
> > > If I recall, lspci showed the root port and card.
> > 
> > This is suspicious. Card should not respond to config read requests when
> > is in hot reset state. Could you send output of lspci -vvxx of the root
> > port and also card during this test? Maybe it is possible that root port
> > has broken BRIDGE_CONTROL register and did not put card into Hot Reset
> > state?
> 
> Yes, I could set the hardware up again and run more tests, it will take some
> time, but I can still do that.
> 
> But before I spend any more time running tests for you here, I have to
> admit, it seems to me running all those tests is completely off-topic in
> context of these two bugfixes here.

I do not think this is off-topic. Issue here is caused when controller
is not in L0 state and this test is something which deterministically
put controller into non-L0 state (Hot Reset). The best verification of
all race conditions and similar timing problems is to to setup scenario
in which timing windows can be under full control. Which this can can
do.

I saw more issues related to PCIe slave errors and I'm feeling that this
patch is just hacking one or two consequences and not fixing the source
of the problem globally.

In most cases slave errors are (incorrectly) reported to CPU when PCIe
controller receive UR/CA response from the bus or if controller itself
generate UR/CA response for request from CPU.

> So maybe it would make sense to stop the discussion here and move it to
> separate thread ?
> 
> I have to admit, I also don't quite understand what it is that you're trying
> to find out with all those tests.

Moreover if this test shows that PCI Bridge registers do not work
properly then it is something which must be fixed too.

There were more discussions about catching and recovering from ARM CPU
aborts and all patches for catching asynchronous exceptions were
rejected because they cannot work by their _imprecise_ nature.

And also there were discussions (not sure if on ML or IRC) if the PCI
core / drivers are the correct place for ARMv7 exceptions / data aborts.
