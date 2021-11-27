Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE4746011C
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 20:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355983AbhK0T2N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 14:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhK0T0M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 14:26:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209DC061763;
        Sat, 27 Nov 2021 11:22:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638040947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B1qxQCFfbrdFSxQkL8hZX6Zfer69wbZc+107UOQS45k=;
        b=E1FJbCvWO7yuYLjHi6JwLKVgq2jlrRGKU1HBNyRwkQgjKRoSGjUb4pVTuxy8aoeGJGziDl
        r8JphJFwXy3pRd938tJMCqGxnJcUAp9iA6H7wUgVJDLPQYC0hlltbZnQ7fw5eKbBG50NEQ
        FXLOJNHJX5/bywfSByEFauxlCkc/tKg30CWc3nYUoynQmX3k2ccGXnhWmWx3vjTJiI2hhg
        isRToszMiuoEqJ2vNhYq2qaKA1Kc14PumeixOZdyhyijjHMgqhIG/j3ipGInWGCKUkhwTV
        LJZ6KSloel2ZHgcO4LenCtL2OSRR9rqtn2MV2WNvi6r/dOTn5fDEhunBQL8+VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638040947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B1qxQCFfbrdFSxQkL8hZX6Zfer69wbZc+107UOQS45k=;
        b=YbWaCIQ16i7j9FW8GIP6eOod9vGpKoNmsdX1E4W3VcFQqHxjQb/AxNhkFM9vvx1QRhO7Yp
        kNlszx9Qprspl7CA==
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
In-Reply-To: <YaIiPISLr7VokL8P@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.708730446@linutronix.de> <YaIiPISLr7VokL8P@kroah.com>
Date:   Sat, 27 Nov 2021 20:22:26 +0100
Message-ID: <87o865flot.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27 2021 at 13:19, Greg Kroah-Hartman wrote:
> On Sat, Nov 27, 2021 at 02:22:38AM +0100, Thomas Gleixner wrote:
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> No changelog?

Bah. This one should not be there at all.

> Anyway, why do we care about the number of decriptors?
>> +/**
>> + * msi_device_num_descs - Query the number of allocated MSI descriptors of a device
>> + * @dev:	The device to read from
>> + *
>> + * Note: This is a lockless snapshot of msi_device_data::num_descs
>> + *
>> + * Returns the number of MSI descriptors which are allocated for @dev
>> + */
>> +unsigned int msi_device_num_descs(struct device *dev)
>> +{
>> +	if (dev->msi.data)
>> +		return dev->msi.data->num_descs;
>
> As this number can change after it is read, what will callers do with
> it?

I wanted to get rid of this, but then forgot. Getting old.

Thanks,

        tglx
