Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAEA46A05
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 22:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfFNUgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 16:36:38 -0400
Received: from ms.lwn.net ([45.79.88.28]:54134 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbfFNUgi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 16:36:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 656C91429;
        Fri, 14 Jun 2019 20:36:36 +0000 (UTC)
Date:   Fri, 14 Jun 2019 14:36:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linas Vepstas <linasvepstas@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH v4 19/28] docs: powerpc: convert docs to ReST and rename
 to *.rst
Message-ID: <20190614143635.3aff154d@lwn.net>
In-Reply-To: <63560c1ee7174952e148a353840a17969fe0be2d.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
        <63560c1ee7174952e148a353840a17969fe0be2d.1560361364.git.mchehab+samsung@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 12 Jun 2019 14:52:55 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Convert docs to ReST and add them to the arch-specific
> book.
> 
> The conversion here was trivial, as almost every file there
> was already using an elegant format close to ReST standard.
> 
> The changes were mostly to mark literal blocks and add a few
> missing section title identifiers.
> 
> One note with regards to "--": on Sphinx, this can't be used
> to identify a list, as it will format it badly. This can be
> used, however, to identify a long hyphen - and "---" is an
> even longer one.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com> # cxl

This one fails to apply because ...

[...]

> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 83db42092935..acc21ecca322 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -403,7 +403,7 @@ That is, the recovery API only requires that:
>  .. note::
>  
>     Implementation details for the powerpc platform are discussed in
> -   the file Documentation/powerpc/eeh-pci-error-recovery.txt
> +   the file Documentation/powerpc/eeh-pci-error-recovery.rst
>  
>     As of this writing, there is a growing list of device drivers with
>     patches implementing error recovery. Not all of these patches are in
> @@ -422,3 +422,24 @@ That is, the recovery API only requires that:
>     - drivers/net/cxgb3
>     - drivers/net/s2io.c
>     - drivers/net/qlge
> +
> +>>> As of this writing, there is a growing list of device drivers with
> +>>> patches implementing error recovery. Not all of these patches are in
> +>>> mainline yet. These may be used as "examples":
> +>>>
> +>>> drivers/scsi/ipr
> +>>> drivers/scsi/sym53c8xx_2
> +>>> drivers/scsi/qla2xxx
> +>>> drivers/scsi/lpfc
> +>>> drivers/next/bnx2.c
> +>>> drivers/next/e100.c
> +>>> drivers/net/e1000
> +>>> drivers/net/e1000e
> +>>> drivers/net/ixgb
> +>>> drivers/net/ixgbe
> +>>> drivers/net/cxgb3
> +>>> drivers/net/s2io.c
> +>>> drivers/net/qlge  

...of this, which has the look of a set of conflict markers that managed
to get committed...?

jon

