Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD5434E767
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhC3MVy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 08:21:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2747 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhC3MVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 08:21:49 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F8pHF2yQQz6827G;
        Tue, 30 Mar 2021 20:12:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 30 Mar 2021 14:21:46 +0200
Received: from localhost (10.47.27.39) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 30 Mar
 2021 13:21:45 +0100
Date:   Tue, 30 Mar 2021 13:20:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config
 regions
Message-ID: <20210330132026.00006346@Huawei.com>
In-Reply-To: <CAPcyv4h_c46tBpemKksciHL4DWu356h7T8A-0eHKUW9H3CZkKw@mail.gmail.com>
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20210326161247.GA819704@bjorn-Precision-5520>
        <CAPcyv4h_c46tBpemKksciHL4DWu356h7T8A-0eHKUW9H3CZkKw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.39]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 29 Mar 2021 09:46:15 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Fri, Mar 26, 2021 at 9:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Christoph]
> >
> > On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:  
> > > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > > configuration cycles. It assumes one initiator at a time is
> > > reading/writing the data registers. If userspace reads from the response
> > > data payload it may steal data that a kernel driver was expecting to
> > > read. If userspace writes to the request payload it may corrupt the
> > > request a driver was trying to send.  
> >
> > IIUC the problem we're talking about is that userspace config access,
> > e.g., via "lspci" or "setpci" may interfere with kernel usage of DOE.
> > I attached what I think are the relevant bits from the spec.
> >
> > It looks to me like config *reads* should not be a problem: A read of
> > Write Data Mailbox always returns 0 and looks innocuous.  A userspace
> > read of Read Data Mailbox may return a DW of the data object, but it
> > doesn't advance the cursor, so it shouldn't interfere with a kernel
> > read.
> >
> > A write to Write Data Mailbox could obviously corrupt an object being
> > written to the device.  A config write to Read Data Mailbox *does*
> > advance the cursor, so that would definitely interfere with a kernel
> > user.
> >
> > So I think we're really talking about an issue with "setpci" and I
> > don't expect "lspci" to be a problem.  "setpci" is a valuable tool,
> > and the fact that it can hose your system is not really news.  I don't
> > know how hard we should work to protect against that.  
> 
> True, the threat is smaller than I was reading, I apologize for that
> noise. Temporary blocking over kernel DOE cycles seems sufficient for
> now.

Was on vacation. Glad I read the whole thread before replying.  The
key point as Bjorn identified is that reads don't hurt and as noted
setpci can break many things anyway so I think we are safe on this.

There are more 'exciting' questions to be addressed about firmware
vs OS ownership of particular DOE mailboxes but that's a whole
separate bit of fun for the future.

Jonathan
