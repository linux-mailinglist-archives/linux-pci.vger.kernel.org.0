Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59218667C40
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 18:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbjALRLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 12:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbjALRKe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 12:10:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E0960857;
        Thu, 12 Jan 2023 08:48:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F04062092;
        Thu, 12 Jan 2023 16:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE85C433EF;
        Thu, 12 Jan 2023 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673541726;
        bh=F609UnYf0WMG5QfHIvhOUjsUndJBWWCnct0nm6EhNSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OPsjwdv4nwXuXqDGZ+Grn5wxcXDYn9RTtehvqMpkLU44l/jIIjLHEeLJglh3X32Vw
         zk40TZLH73wxhMWeRaB7cwvF8cyRdMfmc1R5gDhcH0keIHTS5CNYEEuWIkc82okltr
         hizJFSnMs8oyj3vSvvwBJ/giPdIuMoRLIrM+LipXifeGxnnYKEZK2U4fvjsq4TmSyG
         /IvtdslpbWYDh4o6Rw0bCq3GcVflqAKEBxOkt96H8Ss/38ALdrOzhY+PNappYNAVFh
         SNGAuGpcMsrpwHp3a/KayLg8FoowcfN1tbkgGVPBPDW3A12rbOdVid5+7T0IU8WqVW
         Oy3o9fbvnfJjg==
Date:   Thu, 12 Jan 2023 10:42:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Julian =?iso-8859-1?Q?Gro=DF?= <julian.g@posteo.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Regression in Kernel 6.0: System partially freezes with "nvme
 controller is down"
Message-ID: <20230112164204.GA1768006@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d46a35f-5830-9761-ca2c-eaa640e9cc86@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 03:48:46PM +0100, Linux kernel regression tracking (Thorsten Leemhuis) wrote:
> ...
> On 11.01.23 23:11, Julian Groß wrote:
> > Dear Maintainer,
> > 
> > when running Linux Kernel version 6.0.12, 6.0.10, 6.0-rc7, or 6.1.4, my
> > system seemingly randomly freezes due to the file system being set to
> > read-only due to an issue with my NVMe controller.
> > The issue does *not* appear on Linux Kernel version 5.19.11 or lower.
> > 
> > Through network logging I am able to catch the issue:
> > ```
> > Jan  8 14:50:16 x299-desktop kernel: [ 1461.259288] nvme nvme0:
> > controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> > Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Does
> > your device have a faulty power saving mode enabled?
> > Jan  8 14:50:16 x299-desktop kernel: [ 1461.259293] nvme nvme0: Try
> > "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
> > Jan  8 14:50:16 x299-desktop kernel: [ 1461.331360] nvme 0000:01:00.0:
> > enabling device (0000 -> 0002)
> > ...
> > 
> > I have tried the suggestion in the log without luck.
> > 
> > Attached is a log that includes two system freezes, as well as a list of
> > PCI(e) devices created by Debian reportbug.
> > The first freeze happens at "Jan  8 04:26:28" and the second freeze
> > happens at "Jan  8 14:50:16".
> > 
> > Currently, I am using git bisect to narrow down the window of possible
> > commits, but since the issue appears seemingly random, it will take many
> > months to identify the offending commit this way.
> > 
> > The original Debian bug report is here:
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1028309

For some reason the log [1] has very little of the kernel dmesg log.
It does seem like the freeze is partial (I see messages for hundreds
or thousands of seconds after the nvme reset), but requires a reboot
to recover.

The lspci information [2] shows the 00:1b.0 Root Port leading to the
01:00.0 NVMe device.

Is it possible to collect lspci output after the nvme freeze?  If so,
please save the output of:

  sudo lspci -vv -s00:1b.0
  sudo lspci -vv -s01:00.0

Make sure to run lspci as root so we can see the error logging
registers for these devices.

If you can collect more of the dmesg log after the freeze, e.g., via
the "dmesg" command, that might be helpful, too.

Bjorn

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=1;bug=1028309;filename=x299-desktop_crash.log.xz;msg=5
[2] https://bugs.debian.org/cgi-bin/bugreport.cgi?att=0;bug=1028309;msg=5
