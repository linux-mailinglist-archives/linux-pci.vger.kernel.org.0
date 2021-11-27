Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C362A460141
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 20:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhK0Tuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 14:50:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhK0Tsf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 14:48:35 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638042319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8WWNXMmW79pVSrPL0FWh6ZTHY3JhoVaogmqsWvu1CY=;
        b=YpU2GaGNIsgiAwIE6TN7TQoRulWDkvpT/mU7+2cjUQCsG8/PAHAnanKqLrVRzal+4QQWFa
        p5d2YlraFk22JKq6Rnvdk4UDEBX2reh8mkJgFInfB+F1lV0TvWCr3SkUYY0dr9A1NMeTyk
        bV3BvmOGwcl1+C+CDvBknVjf7kt4VMx0q8no/QgJELgCQIqYjez0ZUkWW9zwxIhw/xaTHB
        YZhYhP2akWbEcm+omIuQjpXfqBSCi3ZTwi8tVpj4vSI9UO4baZ/tnaYqOfEaf4s4dJ6dhl
        MpQC68ysDBW+zgs7JQDpQj3k2VFZiQV4o6ZciQ7heFPEdJk4hglgiQYP3PNY0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638042319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8WWNXMmW79pVSrPL0FWh6ZTHY3JhoVaogmqsWvu1CY=;
        b=jwdySK+JWphhWmD4zIG3S6sjgLdS7cTJOrVJus4e9NWxCRIPTM3qtYneclhxNS688nNu5G
        TbFzpgYoGqon+6Dg==
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
In-Reply-To: <87o865flot.ffs@tglx>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de> <YaIiPISLr7VokL8P@kroah.com>
 <87o865flot.ffs@tglx>
Date:   Sat, 27 Nov 2021 20:45:18 +0100
Message-ID: <87ilwdfkmp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27 2021 at 20:22, Thomas Gleixner wrote:

> On Sat, Nov 27 2021 at 13:19, Greg Kroah-Hartman wrote:
>> On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>
>> No changelog?
>
> Bah. This one should not be there at all.
>
>> Anyway, why do we care about the number of decriptors?

The last part of this really cares about it for the dynamic extension
part, but that's core code which looks at the counter under the lock.

Thanks,

        tglx
