Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4473E79EAF1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjIMOXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 10:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIMOXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 10:23:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEB498;
        Wed, 13 Sep 2023 07:23:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA890C433C7;
        Wed, 13 Sep 2023 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694615016;
        bh=YiQrzuAh1fMDV3leNvWvYNpRFAWU7q18Jvl/4gilNQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xw95oeyZTs8tiMck+I72MQ6IqeSOdGtF+CxXy5/7/Whah8lHm4lFw7iJOgZtC0HGf
         9y3j8VosYGPgeMF3Dc7PKJ4WtWbfb/QmYOWLYRuIHZvuW/+6FzKCwd5sOv2u93pSDY
         /Tz1++6Y+PpHgIiO8HLhRpaHMdpYlMpaQ2lwN+cwhsSvKaUiIu6rtLGyAvlVtfMw6+
         N+6JmuMx4TOF7rbzqNtFif1tTBgtDG1Ya65fHbnUFtTERWmfSw6YP6LR0/6tSmqDeK
         4aM2XCKmWEEHiV3JdPgU9L4CqGJv0nTwEzxVCUu3BFcBush9Ng4IkSSiOinuknKm5l
         C+03B2XfnXrLw==
Date:   Wed, 13 Sep 2023 09:23:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Message-ID: <20230913142333.GA431715@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 13, 2023 at 06:25:31PM +0700, Bagas Sanjaya wrote:
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > After upgrading to 6.5.2 from 6.4.12 I keep getting the following kernel messages around three times per second:
> > 
> > [ 9683.269830] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [ 9683.270399] ata16.00: configured for UDMA/66
> > 
> > So I've tracked the offending device:
> > 
> > ll /sys/class/ata_port/ata16
> > lrwxrwxrwx 1 root root 0 Sep 10 21:51 /sys/class/ata_port/ata16 -> ../../devices/pci0000:00/0000:00:1c.7/0000:0a:00.0/ata16/ata_port/ata16
> > 
> > cat /sys/bus/pci/devices/0000:0a:00.0/uevent
> > DRIVER=ahci
> > PCI_CLASS=10601
> > PCI_ID=1B4B:9130
> > PCI_SUBSYS_ID=1043:8438
> > PCI_SLOT_NAME=0000:0a:00.0
> > MODALIAS=pci:v00001B4Bd00009130sv00001043sd00008438bc01sc06i01
> > 
> > lspci | grep 0a:00.0
> > 0a:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 PCIe SATA 6 Gb/s RAID controller with HyperDuo (rev 11)
> > 
> > I am not using the 88SE9128, so I have no way of knowing whether it works or not. It may simply be getting reset a couple of times per second or it may not function at all.
> 
> See Bugzilla for the full thread.
> 
> patenteng: I have asked you to bisect this regression. Any conclusion?
> ... 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217902

Thanks for the heads-up.  I can't tell whether PCI is involved here.
The bugzilla only mentions the SATA link, which is on the downstream
side of the PCI SATA device.

If PCI is involved, e.g., if the PCI core reset the SATA device
because of an error, there may be hints in the dmesg log.  Can you
attach the complete dmesg log and "sudo lspci -vv" output to the
bugzillla?

Bjorn
