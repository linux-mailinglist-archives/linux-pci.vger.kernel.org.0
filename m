Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2E11D1FBA
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbgEMTzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 15:55:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732218AbgEMTzR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 15:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589399716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8G4dTWAKJCrXKphaPif980nP4FaCLRTX4A3ArJCEZU=;
        b=iodkCZjKRZoIvFdf1k1n1GM51Tezdd9fEvP59rwgptuhuurpssiZq2gWr2uNWqo74bjQCg
        q4S+Z9QGjIGn4LE2d0yGC6UKUIonzyMjOXQdFd9jM8qpXLRgwrCt7dIYhAYwwHtWNXUyM5
        5w6xadUCF1qiIr8/iNSt6ZwLdXYSOvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-OUox1nNiPX2Qq2XDIIr1Vw-1; Wed, 13 May 2020 15:55:11 -0400
X-MC-Unique: OUox1nNiPX2Qq2XDIIr1Vw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16654EC1A0;
        Wed, 13 May 2020 19:55:10 +0000 (UTC)
Received: from x1.home (ovpn-113-111.phx2.redhat.com [10.3.113.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC165C1BB;
        Wed, 13 May 2020 19:55:08 +0000 (UTC)
Date:   Wed, 13 May 2020 13:55:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH for QEMU v2] hw/vfio: Add VMD Passthrough Quirk
Message-ID: <20200513135508.162809da@x1.home>
In-Reply-To: <bd733dccd9cf67c50e757845332e6f8b95719776.camel@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
        <20200511190129.9313-2-jonathan.derrick@intel.com>
        <20200511165927.27b41d65@w520.home>
        <91c6795937035d6ad72cb78c7997ba8168f643c5.camel@intel.com>
        <20200513115540.59a2f57d@w520.home>
        <bd733dccd9cf67c50e757845332e6f8b95719776.camel@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 May 2020 19:26:34 +0000
"Derrick, Jonathan" <jonathan.derrick@intel.com> wrote:

> On Wed, 2020-05-13 at 11:55 -0600, Alex Williamson wrote:
> > On Wed, 13 May 2020 00:35:47 +0000
> > "Derrick, Jonathan" <jonathan.derrick@intel.com> wrote:
> >   
> > > Hi Alex,
> > > 
> > >   
> [snip]
> 
> > 
> > Thanks for the confirmation.  The approach seems ok, but a subtle
> > side-effect of MemoryRegion quirks is that we're going to trap the
> > entire PAGE_SIZE range overlapping the quirk out to QEMU on guest
> > access.  The two registers at 0x2000 might be reserved for this
> > purpose, but is there anything else that could be performance sensitive
> > anywhere in that page?  If so, it might be less transparent, but more
> > efficient to invent a new quirk making use of config space (ex. adding
> > an emulated vendor capability somewhere known to be unused on the
> > device).  Thanks,
> > 
> > Alex  
> 
> Seems like that could be a problem if we're running with huge pages and
> overlapping msix tables.

FWIW, MSI-X tables are already getting trapped into QEMU for emulation.
We have a mechanism via x-msix-relocation=<OffAutoPCIBAR> in QEMU to
deal with that when it becomes a problem by emulating the MSI-X
structures in MMIO space that doesn't overlap with the actual device
(ie. virtually resizing or adding BARs).  The issue is what else can be
in that 4K page or will this device be supported on archs where the
system page size is >4K more so than huge pages (as in hugetlbfs or
transparent huge pages).  Thanks,

Alex

