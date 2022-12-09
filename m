Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910B56489B8
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 21:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLIU4X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 15:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLIU4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 15:56:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54878A848C
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 12:56:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01D36B828CF
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 20:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BCEC433EF;
        Fri,  9 Dec 2022 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670619379;
        bh=gBzCDffehLAymGGylJK8COHi5SdlFnYVi0s1kvL1mFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NIHwYnx/h/LP2r2R9pSi3urCpL6CjZq1AQUneP83FEKlSs2Sjm0FQfIg66NHhzMEx
         veYK+k4P513b15o1cBQ+4UjR3LYkcK/BJrt5AlO0FwraObTeGOBkbsRLDFcYmbUWeh
         VQemLsZoKzkhtjwRnHXoxMUMYQftwfn945KyiWScBXB6rnA5Azuz+ckiPUJzW+X+TH
         cRkJ9hhU0Jz+oGAwD3I8t3Acnb51E4wPZKHpuWiBHnuAPT+gSzDXWLLxBv7eGm7yXd
         k4H/xXU4UqyWn63uczJPZsZXYPyCt2XODX1lMofgZx7y/O6E4Ljv00mIzxeuPhxr4b
         dDzlO9SzHNp0w==
Date:   Fri, 9 Dec 2022 14:56:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: uefi secureboot vm and IO window overlap
Message-ID: <20221209205617.GA1732532@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL3PR02MB798651506589044302A23DFAFE1C9@BL3PR02MB7986.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kallol,

On Fri, Dec 09, 2022 at 06:44:42PM +0000, Kallol Biswas [C] wrote:
> We are observing an io window overlap issue in a secureboot enabled uefi vm.
> 
> Linux displays:
> pci 0000:00:1d.0: can't claim BAR 4 [io  0x92a0-0x92bf]: address conflict with PCI Bus 0000:01 [io  0x9000-0x9fff]
> 
> Eventually conflict gets resolved but we need to understand why get the conflict in the first place.
> 
> Details:
> 
> The VM is a uefi based VM and the issue shows up if secure boot is
> enabled.  We have enabled ovmf log and uefi/ovmf programs a bridge
> IO window with the range 0x9000-0x91ff, but in Linux we see the same
> bridge is programmed with 0x9000-0x9fff. This results in an address
> conflict with subsequent devices.

Linux normally doesn't reassign bridge windows if the existing
configuration (typically from firmware) works.

Booting with "pci=earlydump" should dump the config before Linux
touches anything.

I see your response about being able to reproduce it where it's easier
to debug.  If you need more help, please include the complete dmesg
log so we can see what's happening.

Bjorn
