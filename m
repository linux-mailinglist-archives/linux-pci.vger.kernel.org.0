Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADBD493183
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350204AbiASAAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 19:00:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38722 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbiASAAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 19:00:17 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642550414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJoRNYCC0qaPQvmOXkM+nCsiL5/VV0xKtAJ9Mq0RcS0=;
        b=a9MMj8QkoBwPjJ9s10Nj5dcTSEk5744AcGkY+mIqMyhSCNoNM/Icm0kXybWpkbKJFQighH
        1X9AZdGGKDLG3+SXqsfjv3JU9dRsBhgMjiZAZM0AF1fjiNoc/kyGj1WDfc13cCOD1x5fM6
        DWSEKg44FhgPmXAqIs3WIgSBCgxKc4pq7CN7jLxDnudGUV+EF6aJnCe5DaLVzCN42mwLal
        ceQwErmCYN5iHW/wBdHkoTdvHTRAkVF0oCvKcxs9zruKkcZH+DR26Tu171bTrPE0yo9FHi
        4rwrLMfSKfXYBCD5gQy/e3+J5TmjTVIfxiIu8I3nLvdQFvwghW7JJWPQwhCnjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642550414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJoRNYCC0qaPQvmOXkM+nCsiL5/VV0xKtAJ9Mq0RcS0=;
        b=m3IN+KU7X9XD5oXfHjNVtst6/jOc72hQesIDxbDqdrCWfpXMC6egl9W2w2q0aW8wkvWOLE
        kL3K2AGDiz3SUfAA==
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch] genirq/msi: Populate sysfs entry only once
In-Reply-To: <1d5711be-c26d-d57b-10db-1b45d279515d@socionext.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.224917330@linutronix.de> <87leznqx2a.ffs@tglx>
 <1d5711be-c26d-d57b-10db-1b45d279515d@socionext.com>
Date:   Wed, 19 Jan 2022 00:59:58 +0100
Message-ID: <87a6fsa935.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kunihiko,

On Wed, Jan 12 2022 at 09:05, Kunihiko Hayashi wrote:
> Is this fix the same as below?
> https://marc.info/?l=linux-kernel&m=164061119923119&w=2

pretty much the same, but I missed that patch. I was off for 2+ weeks
and on return Boris poked me about this issue and I fixed it. Then I
went ahead and marked all vacation mail read as I always do :)

So sorry for not noticing that patch.

Thanks,

        Thomas
