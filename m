Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57CA5FB883
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJKQtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 12:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKQtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 12:49:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E4CA598D
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2022 09:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C23EB81637
        for <linux-pci@vger.kernel.org>; Tue, 11 Oct 2022 16:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0012CC433C1;
        Tue, 11 Oct 2022 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665506946;
        bh=6SriIwkaOIcGDHnK+Ozk4u7ZtosENElGgQ/usfRVq/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I1roJaaurTTikLpYTQy+/gaMbZxuECvIWLjmO/bmon0V278V8C3/3TkGf3J25lQ3i
         xgdLhviXB3uxh7GqX5UihNW8m8Hvgk3yuGuarRlKIbYF2R6HRJ20RBfdYrUoqYveSl
         JkS0P/3y2mg8vyb2OezTU5jxQ/+KTyl1xmfv9NDuiqSwK5RZ7vz5H1z3sRawaHjroU
         NGVMODgNWN3A4HP9QvmuO3WhxPablVvQQC2S9VTsi1HRsIKd3Jgla2Eyqv9LHgDuJp
         Ieb5TxgH7ER6Hq6W90SI7dZ1jqQLc388VWWD+BrzFjjk8CE5eIsi7+sU8JKagXsECF
         4jr1PV15Dqawg==
Date:   Tue, 11 Oct 2022 11:49:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils v1] pciutils: add new readpci utility
Message-ID: <20221011164904.GA2995976@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011012741.41961-1-jesse.brandeburg@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 10, 2022 at 06:27:41PM -0700, Jesse Brandeburg wrote:
> Add the new utility 'readpci' in order to allow users to read and write the
> register address space located in the BAR designator + offset.
> 
> The reason that this app is better than what is generally available on the
> internet (there are several) is that this app integrates with the libpci
> and further benefits from pciutils like arguments and device
> specifications.
> 
> help output:
> 
> $ sudo ./readpci -h
> ./readpci: invalid option -- 'h'
> Usage: ./readpci [options] [device]   (/usr/local/share/pci.ids.gz)
> 
> Options:
> -w <value>              Value to write to the address
> -W <value>              Value to write to the address (no read)
> -a <value>              Register address
> -b <value>              BAR to access other than BAR 0
> -m                      Access MSI-X BAR instead of BAR 0
> -D                      PCI debugging
> -q                      Quiet mode, no banner
> -v                      Enable more verbose output
> Device:
> -d [<vendor>]:[<device>]                        Show selected devices
> -s [[[[<domain>]:]<bus>]:][<slot>][.[<func>]]   Show devices in selected slots

I like this idea.  I often use rdwrmem, which is more general-purpose,
but it's a bit of a hassle that it's not commonly installed like
pciutils is, and you have to manually come up with the physical
address of a BAR.

The names:
  "setpci" -- read and write PCI config space
  "readpci" -- read and write PCI MMIO BARs
are slightly confusing since both support reads *and* writes, and
there's no clear config space vs BAR connection in the names.

Would it make any sense to integrate this into setpci, e.g., by
adding an address format for BAR MMIO offsets?

> basic usage to read a register:
> 
> $ sudo ./readpci -s 17:0.0 -a 0xb8000
> 17:00.0 (8086:1592) - Device 8086:1592
> 0xb8000 == 0x1

Possibly annotate with the BAR # and the complete physical address (to
correlate with lspci or dmesg output, especially when debugging via
email)?  Maybe also useful with reading MSI-X BAR.  Looks like maybe
it already does some of this with "v".

Possibly fill out the value to indicate the access width, e.g.,
0x00000001 in this case?

> Currently the utility only allows reading or writing one 32 bit address at
> a time. The utility must be run as root.

Does this mean the *address* is limited to 32 bits, or the access size
is 32 bits?

> +++ b/readpci.man

> +Access to read and write registers in PCI configuration space is restricted to root,

IIUC, readpci is for MMIO, not config space.  But I guess readpci
still needs data from config space to figure out *where* to read?  But
I assume that would normally come from sysfs, not config space
directly, so we can account for _TRA offsets.  I assume that info is
sysfs is also root-only, so it amounts to the same thing.  And
/dev/mem itself is also root-only.

I guess I would say either just "readpci can only be used by root" or
list the items actually required (sysfs config info and /dev/mem) in
case access to them requires different CAP_SYS_* things.

> +So,
> +.I readpci
> +isn't available to normal users.

> +.B -b [<value>]
> +Optional parameter, defaults to 0 if not specified. BAR number to access if
> +other than BAR0.

Maybe move the main point ("BAR number") first, mention the "optional"
part later?

> +on any bus, "0.3" selects third function of device 0 on all buses and ".4" shows only
> +the fourth function of each device.

Isn't "0.3" the *fourth* function?  0.0, 0.1, 0.2, 0.3?  Maybe reword
to avoid the question of whether we start with "zeroth" or "first",
e.g., "0.3 selects function 3 of device 0 on all buses"?

> +There might be some, but none known at this time. If you find one please
> +let the list know.

Does this man page say what "the list" refers to?

Bjorn

[1] https://cmp.felk.cvut.cz/~pisa/linux/rdwrmem.c
