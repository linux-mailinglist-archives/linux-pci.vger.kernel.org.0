Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B452B4605C3
	for <lists+linux-pci@lfdr.de>; Sun, 28 Nov 2021 12:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357169AbhK1LNJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 06:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357172AbhK1LLG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 06:11:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB91AC061759;
        Sun, 28 Nov 2021 03:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B12A60F16;
        Sun, 28 Nov 2021 11:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4A1C004E1;
        Sun, 28 Nov 2021 11:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638097663;
        bh=LP5w1pStsMLYl9A0ItyaDsk0BktUxn3nUAp2Niu1JK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAild5U91XUTvfuW4NB7HcceFVxCnC8eRGp0baXouQulOiKmIVsSnvpl7SCpXbg/d
         29G0VNX7mEFfeW8mGVX1oA4Rm/9FtY61TFZ73tCtsl9z0A+GUvwVLSl7PdQwnefFiJ
         p4j3QgjkFl8Gx/29PgAL6U7YoD8cyR8Ie95fTJBg=
Date:   Sun, 28 Nov 2021 12:07:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 07/32] genirq/msi: Count the allocated MSI descriptors
Message-ID: <YaNi/YqN0ARC3h2z@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de>
 <YaIiPISLr7VokL8P@kroah.com>
 <87o865flot.ffs@tglx>
 <87ilwdfkmp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilwdfkmp.ffs@tglx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27, 2021 at 08:45:18PM +0100, Thomas Gleixner wrote:
> On Sat, Nov 27 2021 at 20:22, Thomas Gleixner wrote:
> 
> > On Sat, Nov 27 2021 at 13:19, Greg Kroah-Hartman wrote:
> >> On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
> >>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >>
> >> No changelog?
> >
> > Bah. This one should not be there at all.
> >
> >> Anyway, why do we care about the number of decriptors?
> 
> The last part of this really cares about it for the dynamic extension
> part, but that's core code which looks at the counter under the lock.

Ah, that should be documented well as right now you are saying "this is
done lockless" in the comment :)

thanks,

greg k-h
