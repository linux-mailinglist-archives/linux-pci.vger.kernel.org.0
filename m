Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F094B9E95
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiBQLaL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 06:30:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiBQLaL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 06:30:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3026A2C9;
        Thu, 17 Feb 2022 03:29:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27CE7CE2B16;
        Thu, 17 Feb 2022 11:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D57C340E8;
        Thu, 17 Feb 2022 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645097393;
        bh=LCxdIQMHBhKjMIvf9HzqIMvga5n7AXcluWeSDoahqKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzrPyZ7i1dRGMpyLIb1r7UH9vmeg3PqfjiuNjaj+GnAUSg8n/dj4x0AOc8i7uzwl1
         XS2JQu9I9FOHTarPr6Qd8DHqKlybl9lbdHAGQEAEUtrzXbawGxvx3sYPRBRqTzpsTo
         +tQgK7eg9F60veSzrTspKjDMu4ZiL+bbTCvTe/3ZjF1A/X66Yvo5MTPvuV0KQRANrw
         4C5RfgtGNXa8jDBVTu40lj+5oil+ZD74r8G6imDLngay6LT5ReqFjHMaMm2bpUJv60
         nL05BL8PTvpdd22rU+udfCUAwPIYliF9H8d4/w4zCZ8VfGx7UezSv6CJf5naNJyrep
         N6TRNIiaa8D6g==
Received: by pali.im (Postfix)
        id DB38B1187; Thu, 17 Feb 2022 12:29:49 +0100 (CET)
Date:   Thu, 17 Feb 2022 12:29:49 +0100
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
Message-ID: <20220217112949.xt6saomde47prbom@pali>
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
 <20220123153147.sv6eoayxqvqbaa66@pali>
 <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
 <20220123164936.cmzvkkkuw5chz3ek@pali>
 <9d89314c-8757-8965-0f5d-14fd95669320@gmail.com>
 <20220124093752.l2kpenot6wj76753@pali>
 <65a09af0-f09d-cf46-3d04-d7c9d2750227@gmail.com>
 <20220131125341.7jzckjihz3cwrxg3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220131125341.7jzckjihz3cwrxg3@pali>
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

On Monday 31 January 2022 13:53:41 Pali Rohár wrote:
> On Saturday 29 January 2022 05:39:40 Marek Vasut wrote:
> > On 1/24/22 10:37, Pali Rohár wrote:
> > > On Monday 24 January 2022 06:46:47 Marek Vasut wrote:
> > > > On 1/23/22 17:49, Pali Rohár wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > [...]
> > > > 
> > > > > > > I must admit that this patch from its initial version evolved into giant hack...
> > > > > > > https://lore.kernel.org/linux-pci/20210514200549.431275-1-marek.vasut@gmail.com/
> > > > > > > 
> > > > > > > During review of the previous patch I have asked some important
> > > > > > > questions but I have not got any answer to them. So I'm reminding it:
> > > > > > > https://lore.kernel.org/linux-pci/20210805183024.ftdwknkttfwwogks@pali/
> > > > > > > 
> > > > > > > So could please answer what happens when PCIe controller is in some
> > > > > > > non-L* state and either MMIO happen or config read happens or config
> > > > > > > write happens?
> > > > > > 
> > > > > > What kind of non-L state ?
> > > > > 
> > > > > E.g. Hot Reset, Detect, Polling, Configuration or Recovery.
> > > > > 
> > > > > > Do you have some specific test which fails ?
> > > > > 
> > > > > Yes, by putting PCIe controller into one of those states. I have already
> > > > > wrote you in some previous email to trigger hot reset as this is the
> > > > > easiest test and can be done also by userspace (setpci).
> > > > > 
> > > > > Link goes to Recovery state automatically when doing link retraining
> > > > > (e.g. by setting RT bit in PCIe Root Port config space) and from
> > > > > Recovery to Configuration or directly back to L0. So testing this path
> > > > > needs precise timing and repeating it more times to trigger.
> > > > > 
> > > > > So the easiest test is really via PCIe Hot Reset by setting Secondary
> > > > > Bus Reset bit in Bridge Control register of PCIe Root Port. After this
> > > > > is link in Hot Reset and does not go back to L0 until you clear that
> > > > > bit. So in this state you can do all these operations which cause
> > > > > aborts, like calling that kernel function which is reading from config
> > > > > space which belongs to device on the other end of the PCIe link or doing
> > > > > MMIO read / write operation of mapped memory which again belongs to
> > > > > other end of PCIe link.
> > > > > 
> > > > > Or instead of Hot Reset, you can set link disable bit in config space of
> > > > > PCIe Root Port. Then link also would not be in L0 state (until you clear
> > > > > that bit), so again you have lot of time to do same tests.
> > > > 
> > > > Can you give me the exact setpci invocation ? If so, then I can test this
> > > > for you on the hardware.
> > > 
> > > Call "setpci -s $bdf_root_port BRIDGE_CONTROL" with address of the PCIe
> > > Root Port device (parent of selected device). This will print value of
> > > bridge control register. Logical OR it with value 0x20 (Secondary Bus
> > > Reset Bit) and call "setpci -s $bdf_root_port BRIDGE_CONTROL=$new_value".
> > > After this call is link in the Hot Reset state and you can do any test.
> > > To bring link back, call setpci again with cleared 0x20 bit mask.
> > > 
> > > Similar test you can done also with setting Link Disable bit (bit 4) in
> > > PCIe Link Control register. Offset to this register is not static and
> > > you can figure it out from lspci -s $bdf_root_port -vv output.
> > > Retrain Link is bit 5 in the same register.
> > 
> > Flipping either bit makes no difference, suspend/resume behaves the same and
> > the link always recovers.
> 
> Ok, perfect! And what happens without suspend/resume (just in normal
> conditions)? E.g. during active usage of some PCIe card (wifi, sata, etc..).

PING? Also what lspci see for the root port and card itself during hot reset?
