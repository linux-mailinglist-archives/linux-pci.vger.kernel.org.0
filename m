Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C03E46BB97
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 13:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhLGMtv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 07:49:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52754 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbhLGMtu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 07:49:50 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638881179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKzQcfpFrakF1gaQnErus44+ZE9ndLllCgtGuvnr0lo=;
        b=zkOUIyV/MINXrUxqZ9LTk6Hht+Xmk8q0kbB/5Y19WuZGmYCp1YnKcRHA/Ud2ZzNf0tBhD1
        5ewm51F2t/LbVeitPsQv0NzSQYvxBgYBwS2c0MPgw3mJzPZAZ6q2GBlz1ILLKxM7NY+q56
        y6FO2Jf6F60qKB/xuNibwDIcpP0cREBO9k1rd9lF2bKMpcZfrjSZUCAv611PzYSfI9kaYD
        ozerFcwa3CJXVTsQElTER2+/qf7c08a86zn5ZozkKNQ9QsA7UC2wyWhtESX00QKpP6+lNz
        FelqwJ4Bd7vCMzYyeRjT3d7rSGV/Gz0CUgOyfaKzjKzk1KOF0aTbcueGSTp9SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638881179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QKzQcfpFrakF1gaQnErus44+ZE9ndLllCgtGuvnr0lo=;
        b=yZ3GrlUbR1OmCFoNBVL41nwID0yawuJjFK0MUow1uzlkJmWNC0fYtNtLkZbCEAFV92VP56
        kQjuYi/bhsZdtdDA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch V2 29/31] genirq/msi: Add abuse prevention comment to
 msi header
In-Reply-To: <Ya8Zj+bADtKEISSP@kroah.com>
References: <20211206210600.123171746@linutronix.de>
 <20211206210749.170847844@linutronix.de> <Ya8Zj+bADtKEISSP@kroah.com>
Date:   Tue, 07 Dec 2021 13:46:18 +0100
Message-ID: <87lf0w37mt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07 2021 at 09:21, Greg Kroah-Hartman wrote:
> On Mon, Dec 06, 2021 at 11:51:49PM +0100, Thomas Gleixner wrote:
>>  #include <linux/cpumask.h>
>>  #include <linux/mutex.h>
>>  #include <linux/list.h>
>> 
> Ah, to be young and idealistic and hope that kernel developers read
> comments in header files :)

Hope dies last.

> You might want to add this to the driver-api kernel doc build?

When I do the next round of refactoring, I'm going to move the functions
which are available for drivers into a separate header file.

Thanks,

        tglx
