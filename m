Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8057F169D45
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 05:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBXE4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Feb 2020 23:56:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58092 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727186AbgBXE4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Feb 2020 23:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582520199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ma1EjT0/cgYKBYRBzJpsYw4qpXSIefQrEzpAraMKVJo=;
        b=JYJPWxROw4M5h7p65s8rRYiZQcVOSwKtpa9w3TDQP9sTJ73sdbLfxwZ8Hm2ZTgcgy6qW05
        /SStKzzLas7tYjLJbkSr3BBbePnjRqBao80wvfVXGb0SbPeH5APsroaRwMpSW9i6sFnNe7
        ZHJ2qHh53AkQI/aSIuoeZ6L1A4XJLFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-vRlxWOaAPRG_qk-QUfcrmg-1; Sun, 23 Feb 2020 23:56:37 -0500
X-MC-Unique: vRlxWOaAPRG_qk-QUfcrmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1099800D54;
        Mon, 24 Feb 2020 04:56:35 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-44.pek2.redhat.com [10.72.13.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02CB55D9C9;
        Mon, 24 Feb 2020 04:56:22 +0000 (UTC)
Date:   Mon, 24 Feb 2020 12:56:18 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kairui Song <kasong@redhat.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Baoquan He <bhe@redhat.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Randy Wright <rwright@hpe.com>,
        Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200224045618.GA16543@dhcp-128-65.nay.redhat.com>
References: <20191225192118.283637-1-kasong@redhat.com>
 <20200222165631.GA213225@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222165631.GA213225@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
On 02/22/20 at 10:56am, Bjorn Helgaas wrote:
> [+cc Khalid, Deepa, Randy, Dave, Myron]
> 
> On Thu, Dec 26, 2019 at 03:21:18AM +0800, Kairui Song wrote:
> > There are reports about kdump hang upon reboot on some HPE machines,
> > kernel hanged when trying to shutdown a PCIe port, an uncorrectable
> > error occurred and crashed the system.
> 
> Did we ever make progress on this?  This definitely sounds like a
> problem that needs to be fixed, but I don't see a resolution here.
> 

I'm not familar with the PCI details,  but if this only adds a quirk for
kdump use and no other risks added then it should be good to have.

Or we can provide a kernel parameter for the quirk?  Then it is even
limited to only be effective when in-kdump && the-param-is-used

Anyway still prefer to people who know more about this area to evaluate
the risk.

Thanks
Dave

