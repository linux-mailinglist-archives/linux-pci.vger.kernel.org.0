Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898837270F2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 23:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFGVyC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjFGVxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 17:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4512695
        for <linux-pci@vger.kernel.org>; Wed,  7 Jun 2023 14:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4670564A40
        for <linux-pci@vger.kernel.org>; Wed,  7 Jun 2023 21:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74687C433A7;
        Wed,  7 Jun 2023 21:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686174808;
        bh=Z9JLulpyoJayy5Gua5CmTFtVD+Uz4BOuWXgnWQdZ3Sc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nAUBjv+T3m5itQLnhfSVocBuC4wlirV9Nw5NXiZxH3HYyghWCkJU7EcaXS82HQ7X5
         dA0QLRBKhGh22LZDHupAsTr19fm41fQNzEi/LcbDHEU/zl+xQo44CGpnQX6+/VSwZJ
         sKUEZgvJNa5RcO1NPmAdJneq3fYVtn25egaX+Khm4atiKEuvvrPJN8SbRpqdL4CXu1
         Cy5vbM8czFuZFnQP6ElYPVrSdQf7WDwXaVYD03hmgR5kE796JalYujRc/I4Qb7baLy
         kB3Ak/yyDy6C/IQya6Oy0tifblzkSp76/361O2871jeg0ssCy6a3QVt+7pvqBv6h0A
         BepnMr3kQItbg==
Date:   Wed, 7 Jun 2023 16:53:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Dejean <dam.dejean@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Old Asus doesn't seem to support MSI
Message-ID: <20230607215326.GA1176980@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErgN1CYEA6a954vHHv3hkJe1jDY0eyEX0DPKf75nyd4_tD3UA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 07, 2023 at 06:24:34PM +0200, Damien Dejean wrote:
> You'll find the results of the two commands in attachment. I ran them
> without the pci=nomsi option set just in case.

Thanks!

The kernel does check the ACPI table [1] to see whether MSI is
supported, and I don't see the "system doesn't support MSI" message
[2] in your dmesg log, so I don't think that's the problem.  It is
possible that the chipset doesn't support MSI but the BIOS neglected
to set the ACPI_FADT_NO_MSI bit in ACPI, although Windows looks at the
same table and should be similarly broken in that case.

I poked around on the web for similar reports of needing "pci=nomsi"
for Asus X73SL or Asus F70SL, but I really didn't find anything.  The
linux-hardware database [3] claims this chipset is used in quite a few
systems, so I would think we'd see some reports of problems if the
chipset were broken.  Unfortunately that database doesn't have enough
information to see whether systems use MSI (no "lspci -vv" output) and
I don't see a way to contact the reporters to find out.

We do have an existing quirk [4] that disables MSI for the [1039:0761]
chipset, and maybe we could add an entry for the [1039:0671] that you
have.  The fact that I couldn't find any reports makes me worry that
doing that would make it work for you, but unnecessarily disable MSI
for others.

It's also conceivable that MSI used to work in older kernels, but we
broke something by v5.10.  Do you know whether any old kernels ever
worked without "pci=nomsi"?

What exactly is the symptom you see without "pci=nomsi"?  I know we
turned on more AER reporting recently, which exposed issues on some
machines.  I think using "pci=nomsi" basically disables the AER
reporting, too.  If the problem you see is related to AER, you can
turn that off with "pci=noaer", and you may not need "pci=nomsi".
Obviously my goal is that you should not need either one!

Bjorn

[1] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html?highlight=fadt#ia-pc-boot-architecture-flags
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci-acpi.c?id=v6.3#n1475
[3] https://linux-hardware.org/?view=search&vendorid=1039&deviceid=0671#list
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c?id=v6.3#n2557
