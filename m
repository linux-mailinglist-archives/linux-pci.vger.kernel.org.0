Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC344B895
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 23:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbhKIWo6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 17:44:58 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:43007 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbhKIWm4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 17:42:56 -0500
Received: by mail-lf1-f41.google.com with SMTP id bi35so1094926lfb.9
        for <linux-pci@vger.kernel.org>; Tue, 09 Nov 2021 14:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SMmGA0UyBNtIe/bJUCzHKc6EzFLQmLHSh4vfSbEgnwQ=;
        b=3FxeowCrWqBlw5z/PmbChAsRb/SCsyV9hvynOQZ5FHn8A08VmFisl8+RFGDMuM87Jz
         vlNi60MdCF4b21a6GH1OFZJriA/9O3+b5vW0iK06HE78XJJdBG/umSNdnyqcAfSEpYvV
         Sr6fcDmhKvIo8N34z7g9scOYq/VrhUY9tcC7kq8xumNQItaeTU2YkBaanBFKOIjRqdq5
         SGhYlZd4h8pb58ZQqtm9m/lZaFeIQL00j8BrPSAMUlPQjxUxcRAwZM5tmdkpaOu/n50z
         fgWKo9lgP9W0GUkaLvXhJFOEq2LIvVwwuE6vSVbA+CPSBE+ixEKbkNzujhZ7FnQltUeK
         gISw==
X-Gm-Message-State: AOAM530/iH9vj4mwqvveV52J+Pxd9GCNE9N07UYJNGuedhZ7FBB2hgJD
        Vs1hXfx9rM43mACC5bsxSJQ=
X-Google-Smtp-Source: ABdhPJzDIcYqlgDjAYqusMtGJFzjceKGfVSfm2TrgguYU5jEZWNc5otiC1IjW9b0lP88LvtU1AsfZw==
X-Received: by 2002:a05:6512:3f8b:: with SMTP id x11mr10206874lfa.486.1636497609131;
        Tue, 09 Nov 2021 14:40:09 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b4sm2264065lft.206.2021.11.09.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 14:40:08 -0800 (PST)
Date:   Tue, 9 Nov 2021 23:40:07 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Matthew Leaman <matthew@a-eon.biz>,
        Christian Zigotzky <info@xenosoft.de>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Message-ID: <YYr4x1xWfptXRmqt@rocinante>
References: <ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de>
 <20211109165848.GA1155989@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211109165848.GA1155989@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Adding Jens and Damien to get their opinion about the problem at hand]

Hello Jens and Damien,

Sorry to bother both of you, but we are having a problem that most
definitely requires someone with an extensive expertise in storage,
as per the quoted message from Christian below:

> > > The Nemo board [1] doesn't recognize any ATA disks with the pci-v5.16
> > > updates [2].
> > >
> > > Error messages:
> > >
> > > ata4.00: gc timeout cmd 0xec
> > > ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> > > ata1.00: gc timeout cmd 0xec
> > > ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> > > ata3.00: gc timeout cmd 0xec
> > > ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)

The error message is also not very detailed and we aren't really sure what
the issue coming from the PCI sub-system might be causing or leading to
this.

> > >
> > > I was able to revert the new pci-v5.16 updates [2]. After a new compiling,
> > > the kernel recognize all ATA disks correctly.
> > >
> > > Could you please check the pci-v5.16 updates [2]?
> > >
> > > Please find attached the kernel config.
> > >
> > > Thanks,
> > > Christian
> > >
> > > [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
> 
> Sorry for the breakage, and thank you very much for the report.  Can
> you please collect the complete dmesg logs before and after the
> pci-v5.16 changes and the "sudo lspci -vv" output from before the
> changes?
> 
> You can attach them at https://bugzilla.kernel.org if you don't have
> a better place to put them.
> 
> You could attach the kernel config there, too, since it didn't make it
> to the mailing list (vger may discard them -- see
> http://vger.kernel.org/majordomo-info.html).

Bjorn and I looked at which commits that went with a recent Pull Request
from us might be causing this, but we are a little bit at loss, and were
hoping that you could give us a hand in troubleshooting this.

Thank you in advance!

	Krzysztof


