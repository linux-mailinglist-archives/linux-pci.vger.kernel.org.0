Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172395B7C53
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 22:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIMUx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 16:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIMUx6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 16:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC8753B3;
        Tue, 13 Sep 2022 13:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E3CF615A3;
        Tue, 13 Sep 2022 20:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA438C433D6;
        Tue, 13 Sep 2022 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663102437;
        bh=0O2LmCUyvqei0RPpnrAKX0X8sRRsI097LTK04EHg0l0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JLecM6vmyABPSHuy0ZFBwuZstnfgkx9J0ThHLJvkGcFkBgo8Pjosxh4kkj9lo1R59
         dQoAG3Ntvs7D7g3H1TKAgsZHAlQ64t4FKScAdnnpPMMRKh3rpLkhhxX6bht9RmOI2j
         DgCUCvd3H5SB8QTIVh6edMb1rekJET/JQ5W+MEy4zu9+dpyMsQd6WvHM6HtdpinBeO
         Ts01RFoTcEUY3a3uMGzJ9/ckmxV2rE7sorT6MNDkLFv2LDcDpJxvs7mpEqiVfs/hw6
         PsFqdv7Tlrm951coz2z2Trm5L1cVqDGuDvuHojxeZyjaZdDcoMJ7dwheZHCTb0YwSS
         q6f3a0X2/izJg==
Date:   Tue, 13 Sep 2022 15:53:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: Dell XPS 13 9360/Dell DA300: USB Type-C: PCIe Bus Error:
 severity=Corrected, type=Data Link Layer, (Receiver ID)
Message-ID: <20220913205355.GA622822@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae28dabe-d339-b56d-4a8e-ce4291c9b836@molgen.mpg.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 12, 2022 at 03:36:09PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell XPS 13 9360/0596KF, BIOS 2.21.0 06/02/2022, connect a Dell DA300
> to the only USB Type-C port on the left side (with a network cable connect),
> Linux logs the warnings below:

> Linux version 5.19.0-1-amd64 (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.19.6-1 (2022-09-01)

> [    5.710957] pci 0000:01:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> [    5.710959] pci 0000:01:00.0:   device [8086:1576] error status/mask=00000080/00002000
> [    5.710962] pci 0000:01:00.0:    [ 7] BadDLLP

Your dmesg log has many (51!) BadDLLP errors (which are corrected) and
one Replay Timer Timeout error (also corrected).  I'm not a hardware
person, but I don't know how software could cause these errors.

Unless this is a regression, I suspect a hardware issue like a bad
cable or connector.

> I created the bug report #216474 [1] with the output of `lspci -nn`, `lsusb`
> and `dmesg`.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=216474
>      "Bug 216474 - Dell XPS 13 9360/Dell DA300: USB Type-C: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)"
