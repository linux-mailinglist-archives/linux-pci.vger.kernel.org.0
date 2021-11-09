Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06E344B19E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 17:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhKIRBg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 12:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234305AbhKIRBf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Nov 2021 12:01:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93DC0611AF;
        Tue,  9 Nov 2021 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636477129;
        bh=WiI7yiSsRyGyxbH0M5tEnpuJ2pCthlZoRHEJQiwJXHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rwjrjNITo8A74sOBNwFp7ddx6D88aNYNGeIWRE178PEaprjfU7cpkyf+GDManuJEv
         13FTDmQsolCNxzMrEIxf5iKFaLd1kHsYyGlpfKOZfhNr2E+fBdQxMis1KVPYfT5ee3
         2QqkOv3lVj/szLGdo6wrg6UUTDsDLcpo3jwym70c+/aqVYcfk5IVIWzvRvtzw9tCom
         ks2KMjmt7/XwE0Hg0csvj4shtSjVAoTMOZBSvw6ez60wpHYc3o7dr/4TWcJGEnE+Kp
         ZCWqTJqZ25AUSrs/nOn/oHd5XM3rTzYKYmyYb2v4DARXaEhQRzkMfmdZon+Uzgwx9Q
         1NMqS6kUcruFQ==
Date:   Tue, 9 Nov 2021 10:58:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Matthew Leaman <matthew@a-eon.biz>,
        Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Message-ID: <20211109165848.GA1155989@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 09, 2021 at 04:10:14PM +0100, Christian Zigotzky wrote:
> On 09 November 2021 at 03:45 pm, Christian Zigotzky wrote:
> > Hello,
> >
> > The Nemo board [1] doesn't recognize any ATA disks with the pci-v5.16
> updates [2].
> >
> > Error messages:
> >
> > ata4.00: gc timeout cmd 0xec
> > ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> > ata1.00: gc timeout cmd 0xec
> > ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> > ata3.00: gc timeout cmd 0xec
> > ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> >
> > I was able to revert the new pci-v5.16 updates [2]. After a new compiling,
> the kernel recognize all ATA disks correctly.
> >
> > Could you please check the pci-v5.16 updates [2]?
> >
> > Please find attached the kernel config.
> >
> > Thanks,
> > Christian
> >
> > [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4

Sorry for the breakage, and thank you very much for the report.  Can
you please collect the complete dmesg logs before and after the
pci-v5.16 changes and the "sudo lspci -vv" output from before the
changes?

You can attach them at https://bugzilla.kernel.org if you don't have
a better place to put them.

You could attach the kernel config there, too, since it didn't make it
to the mailing list (vger may discard them -- see
http://vger.kernel.org/majordomo-info.html).

Bjorn

