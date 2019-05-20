Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C0F239E3
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbfETOYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 10:24:04 -0400
Received: from casper.infradead.org ([85.118.1.10]:46420 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbfETOYB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 May 2019 10:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qpo5LDUiv3RWeUdYDR/6jtqrxtFTQ421WWKV/4Yo++s=; b=sBE2ufPAs9Lbu3ZiZBgfLpymrB
        eaqOa+E+pqMdpORzpIo/4/4njkz0LMfduZrLzGtN0vQqMtyd/4rkf6P1DU2TQrHOaiwNUNJvKotfq
        MaJ1k0ncxBp/fVd5tuiWSUNGpU3PuoNXrea0pqP/+c5iQhicbGpbXfQWzmLCj3mQIV/NPafQ3sj3M
        udHReu4B9ZoIgAjA/c1dbcE/S1bv1Mk6jeUAdP83CZnhK3Y1iQoKc7U6+knEOv9e/JlzUWX3o9WRi
        V1Scd5qCIVNWfNFgB1bUo64y4Z7mtcP9751F64j93doJsre86cax4CYrmMFf4UM+e74RhuSF8yR1c
        7OWfYb0Q==;
Received: from 179.176.119.151.dynamic.adsl.gvt.net.br ([179.176.119.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSjCm-0003xd-CA; Mon, 20 May 2019 14:23:56 +0000
Date:   Mon, 20 May 2019 11:23:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190520112350.4679df1c@coco.lan>
In-Reply-To: <20190520061014.qtq6tc366pnnqcio@mail.google.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
        <20190520061014.qtq6tc366pnnqcio@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Mon, 20 May 2019 06:10:15 +0000
Changbin Du <changbin.du@gmail.com> escreveu:

> Bjorn and Jonathan,
> Could we consider to merge this serias now? Thanks.

Before merging it, did you check if the renames won't cause broken
reference links? There were such breakages with your x86 and acpi
patch series. I'm sending the fixes right now, but it would be
great if you could run the ./scripts/documentation-file-ref-check
script and address any file name change this series would be
introducing. There's even a --fix option there that allows
to automatically fix them (you need to double-check the results).

Regards,
Mauro

> 
> On Tue, May 14, 2019 at 10:47:22PM +0800, Changbin Du wrote:
> > Hi all,
> > 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted most of the Linux PCI docs to rst
> > format in this serias.
> > 
> > For you to preview, please visit below url:
> > http://www.bytemem.com:8080/kernel-doc/PCI/index.html
> > 
> > Thank you!
> > 
> > v2: trivial style update.
> > v3: update titles. (Bjorn Helgaas)
> > v4: fix comments from Mauro Carvalho Chehab
> > v5: update MAINTAINERS (Joe Perches)
> > v6: fix comments.
> > 
> > Changbin Du (12):
> >   Documentation: add Linux PCI to Sphinx TOC tree
> >   Documentation: PCI: convert pci.txt to reST
> >   Documentation: PCI: convert PCIEBUS-HOWTO.txt to reST
> >   Documentation: PCI: convert pci-iov-howto.txt to reST
> >   Documentation: PCI: convert MSI-HOWTO.txt to reST
> >   Documentation: PCI: convert acpi-info.txt to reST
> >   Documentation: PCI: convert pci-error-recovery.txt to reST
> >   Documentation: PCI: convert pcieaer-howto.txt to reST
> >   Documentation: PCI: convert endpoint/pci-endpoint.txt to reST
> >   Documentation: PCI: convert endpoint/pci-endpoint-cfs.txt to reST
> >   Documentation: PCI: convert endpoint/pci-test-function.txt to reST
> >   Documentation: PCI: convert endpoint/pci-test-howto.txt to reST
> > 
> >  .../PCI/{acpi-info.txt => acpi-info.rst}      |  15 +-
> >  Documentation/PCI/endpoint/index.rst          |  13 +
> >  ...-endpoint-cfs.txt => pci-endpoint-cfs.rst} |  99 ++---
> >  .../{pci-endpoint.txt => pci-endpoint.rst}    |  92 +++--
> >  ...est-function.txt => pci-test-function.rst} |  84 +++--
> >  ...{pci-test-howto.txt => pci-test-howto.rst} |  81 ++--
> >  Documentation/PCI/index.rst                   |  18 +
> >  .../PCI/{MSI-HOWTO.txt => msi-howto.rst}      |  85 +++--
> >  ...or-recovery.txt => pci-error-recovery.rst} | 287 +++++++-------
> >  .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++----
> >  Documentation/PCI/{pci.txt => pci.rst}        | 356 ++++++++----------
> >  .../{pcieaer-howto.txt => pcieaer-howto.rst}  | 156 +++++---
> >  .../{PCIEBUS-HOWTO.txt => picebus-howto.rst}  | 140 ++++---
> >  Documentation/index.rst                       |   1 +
> >  MAINTAINERS                                   |   4 +-
> >  include/linux/mod_devicetable.h               |  19 +
> >  include/linux/pci.h                           |  37 ++
> >  17 files changed, 938 insertions(+), 710 deletions(-)
> >  rename Documentation/PCI/{acpi-info.txt => acpi-info.rst} (96%)
> >  create mode 100644 Documentation/PCI/endpoint/index.rst
> >  rename Documentation/PCI/endpoint/{pci-endpoint-cfs.txt => pci-endpoint-cfs.rst} (64%)
> >  rename Documentation/PCI/endpoint/{pci-endpoint.txt => pci-endpoint.rst} (83%)
> >  rename Documentation/PCI/endpoint/{pci-test-function.txt => pci-test-function.rst} (55%)
> >  rename Documentation/PCI/endpoint/{pci-test-howto.txt => pci-test-howto.rst} (78%)
> >  create mode 100644 Documentation/PCI/index.rst
> >  rename Documentation/PCI/{MSI-HOWTO.txt => msi-howto.rst} (88%)
> >  rename Documentation/PCI/{pci-error-recovery.txt => pci-error-recovery.rst} (67%)
> >  rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)
> >  rename Documentation/PCI/{pci.txt => pci.rst} (68%)
> >  rename Documentation/PCI/{pcieaer-howto.txt => pcieaer-howto.rst} (72%)
> >  rename Documentation/PCI/{PCIEBUS-HOWTO.txt => picebus-howto.rst} (70%)
> > 
> > -- 
> > 2.20.1
> >   
> 



Thanks,
Mauro
