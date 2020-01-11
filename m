Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937F7137C5A
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 09:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgAKI3b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jan 2020 03:29:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51974 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728619AbgAKI3a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jan 2020 03:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578731369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VjskE7QYirsyLkHK4vYj4bUUrVGIXYTjpde1ExKUqAo=;
        b=JVXQDLwHyKVTX64i8YmMjCt1X/D8TT5CFlwGfcuNnSGfKru+SZ38MdFBH1lHlRDhIhRWOW
        Qig2MqFmcrMPkJhz8pdbttH9sEyKxlT/F2KZ/nryuq1XWPN9IDoe09XZlNBbh0tH5/PnpS
        ehL+gm552Yz5w9xwBhKbyapXQ126NvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-475RIkF1NdW8scuglD1kwQ-1; Sat, 11 Jan 2020 03:29:25 -0500
X-MC-Unique: 475RIkF1NdW8scuglD1kwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 623DF801E76;
        Sat, 11 Jan 2020 08:29:24 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 396EC5DA60;
        Sat, 11 Jan 2020 08:29:21 +0000 (UTC)
Date:   Sat, 11 Jan 2020 13:59:18 +0530 (IST)
From:   P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pci@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: Re: About pci_ioremap_bar null dereference
In-Reply-To: <20200110201258.GA83593@google.com>
Message-ID: <nycvar.YSQ.7.76.2001111351300.129933@xnncv>
References: <20200110201258.GA83593@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  Hello Andy, Bjorn,

+-- On Fri, 10 Jan 2020, Bjorn Helgaas wrote --+
| On Fri, Jan 10, 2020 at 02:10:22PM +0200, Andy Shevchenko wrote:
| > On Fri, Jan 10, 2020 at 1:54 PM P J P <ppandit@redhat.com> wrote:
| > >   -> https://git.kernel.org/linus/ea5ab2e422de0ef0fc476fe40f0829abe72684cd
| > >
| > > I was wondering if(or how) it is reproducible for unprivileged user? Do you
| > > happen to have a reproducer for it?
| > 
| > It's very unlikely to see IRL such problem. Theoretically  it may
| > happen if the system in question has a LOT of devices connected to PCI
| > and suddenly there is no window for a resource left (usually 4k) under
| > PCI Root Bridge. Other than that I can't imagine what can go wrong.
| > Ah, of course the virtual space starvation is another possibility.
| 
| pci_ioremap_bar() can return NULL if the BAR is an I/O port BAR or if it's a 
| memory BAR but we haven't assigned space for it.  It's a good idea to check 
| the return value of pci_ioremap_bar().

  It is good to check the return value.
 
| ea5ab2e422de ("8250_lpss: check null return when calling pci_ioremap_bar") 
| looks like a valid patch to add that check.  My guess is that the patch was 
| prompted by a static checker like Coverity, not by an observed problem.

  Right, likely.

| drivers/dma/dw/core.c (for the Synopsys DesignWare DMA Controller) *does* 
| use that pointer via dma_readl(), but the references in the commit log 
| (drivers/dma/dw/core.c:1154 and drivers/dma/dw/core.c:1168) are obsolete and 
| not very useful.

  I see, okay. Thank you for the information.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D

