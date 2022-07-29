Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F05856D2
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jul 2022 00:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiG2WWp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 18:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiG2WWo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 18:22:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3233F318;
        Fri, 29 Jul 2022 15:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44D49B829DA;
        Fri, 29 Jul 2022 22:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960F2C433C1;
        Fri, 29 Jul 2022 22:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659133360;
        bh=bOE0cFSfd9j0Ebec4rZcMchvAjKnySFjPVmPPm0v4SM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IBnQ9kguUzE0r+FypL9wCXYrfXepKex/VI76VfwXTyN8nhXho0sLaY7Q5pzNCkpY6
         XHyPeQ0uu/En8bP9RQdZf6j0uGYoinTiwYE13v/kjE7c/Q3H8xDfggOyVsqJPPxqWs
         NugTwjKjY/7x+821a08n1tSJS+007L9Tk20sU6+VE4YdmuFi4Me1+xyi6tTkYKxKpV
         i+F6qqsgy71d8rh0XPFAT5GUGcNTOgYOqd3o9+K5+fmdcrkvikOCG+W/p/nUZU43Yl
         zpOP/Ln3QrDpEcMGFbPOYncBeg26GB9WChyrqWplvKTxQyJ1dO1CJaMAMH2KB5qsl+
         Hb9AQMD/iomXA==
Date:   Fri, 29 Jul 2022 17:22:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        it+x86@molgen.mpg.de, Robert Dinse <nanook@eskimo.com>
Subject: Re: acpi PNP0A03:00: fail to add MMCONFIG information, can't access
 extended PCI configuration space under this bridge.
Message-ID: <20220729222238.GA491273@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42e3f0f-2156-669a-e15e-51970b438ed4@molgen.mpg.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Robert]

On Mon, Feb 15, 2021 at 05:53:51PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> All the way up to QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-5) and
> Linux 5.10.13, Linux logs the warning below:
> 
>     acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended
> PCI configuration space under this bridge.
> 
> One way to reproduce it:
> 
>     qemu-system-x86_64 -enable-kvm -m 2G -hda /dev/shm/debian.img -kernel
> /boot/vmlinuz-5.10.0-3-amd64 -initrd /boot/initrd.img-5.10.0-3-amd64 -append
> root="/dev/sda1 console=ttyS0,115200" -serial stdio
> 
> Please find more details and the full log in the Bugzilla issue #211765 [1].
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=211765
>      "[Bug 211765] acpi PNP0A03:00: fail to add MMCONFIG information, can't
> access extended PCI configuration space under this bridge."

Do you know whether qemu implements extended config space?  Extended
config space is offsets 0x100-0xfff.  I think Linux only supports
extended capabilities in that area (AER, VC, ACS, SR-IOV, etc).  Most
of these are probably not of interest in a virtualized environment, so
I wouldn't be surprised if qemu doesn't support them.

Bjorn
