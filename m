Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46804460961
	for <lists+linux-pci@lfdr.de>; Sun, 28 Nov 2021 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbhK1T2w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 14:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbhK1T0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 14:26:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13782C061748;
        Sun, 28 Nov 2021 11:23:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638127396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lv8OHlL9mgf3j1bUYluo2SmQppu0Dcs5/MYDfTpMBUA=;
        b=BfNvN2XPJExUJf25sWvyU6A3iVW5Iq13MmrrIHsmpEnjuZhSUZ611iD+6kdn5YqgZRjYmU
        A1ZU0/OvdVfD7sc3/Tl1nFcBbwG35bCvXKei1UGIbJUPGTBx6P1BscQJnG0TpsImRODDxh
        6z2W9UxUcmmuI41cr1pRI+vwIGE2awbWUiRH0MdfxOmu1zIi+NypOrD/Eqe5CaCHpFSmCO
        slY47fgI1VHuZ/bGbJscE6FJNmx4+dqv3Zx9AEJBSiawb/406mR4TDUmnABLIWUuARcIMB
        KQLE8EREsCEq8nw0KfK+rckSD+sKqkr8UCIbWt+WPbFrjUGdGg+mMq/rrlar8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638127396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lv8OHlL9mgf3j1bUYluo2SmQppu0Dcs5/MYDfTpMBUA=;
        b=g4yec4TKfYXpXQd0hARhZXIKLFA/GbNwEi04EbCzHbNctO5rxPxnA1x7Pf1YQ2mdlWYiE1
        jJ3flE2DM1kqhuCA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
In-Reply-To: <YaNi/YqN0ARC3h2z@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de> <YaIiPISLr7VokL8P@kroah.com>
 <87o865flot.ffs@tglx> <87ilwdfkmp.ffs@tglx> <YaNi/YqN0ARC3h2z@kroah.com>
Date:   Sun, 28 Nov 2021 20:23:15 +0100
Message-ID: <874k7wf5jw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 28 2021 at 12:07, Greg Kroah-Hartman wrote:
> On Sat, Nov 27, 2021 at 08:45:18PM +0100, Thomas Gleixner wrote:
>> On Sat, Nov 27 2021 at 20:22, Thomas Gleixner wrote:
>> 
>> > On Sat, Nov 27 2021 at 13:19, Greg Kroah-Hartman wrote:
>> >> On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
>> >>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> >>
>> >> No changelog?
>> >
>> > Bah. This one should not be there at all.
>> >
>> >> Anyway, why do we care about the number of decriptors?
>> 
>> The last part of this really cares about it for the dynamic extension
>> part, but that's core code which looks at the counter under the lock.
>
> Ah, that should be documented well as right now you are saying "this is
> done lockless" in the comment :)

I already zapped the whole patch as the function is not required for the
core code.

Thanks,

        tglx
