Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C327179914
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 20:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDTeo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 14:34:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20910 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727137AbgCDTeo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 14:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583350483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LVZr990W9iLEEqbjHHLM4X6TgtqyzP5bDocd/dkFa7Q=;
        b=jHXRiSev2wxWV10iQltFQ9CpPReiNf5wAB2O7YDEqHcExdNtoRbP4Rk6JeNImVvMDT/rDg
        kAUkn0n+a48AS2ICLoiv0crpoMEeWqxW+70hU/AlK1nn00H0wZmi6iIG37JLkwb5d3aqR5
        fKDcg+7US1Qanu04Bi8TZBsgaHtkzIo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-EdStmuNaNVOL3ieMxE7c-A-1; Wed, 04 Mar 2020 14:34:41 -0500
X-MC-Unique: EdStmuNaNVOL3ieMxE7c-A-1
Received: by mail-qk1-f197.google.com with SMTP id h6so2065797qkj.14
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2020 11:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVZr990W9iLEEqbjHHLM4X6TgtqyzP5bDocd/dkFa7Q=;
        b=lId/a2LXvArTg7FjZpIZaIMTj8MNoAp69EZCSQdqvf3oKfSMMGyquVndHDlIlCVwJc
         iD/IILofF0mgdcxJoKFSQsQC2tGen1RFY+rt5XLhhYvmG+GH3Lxu/NsFxJd3pUWDLgY7
         2F1KUoCLMcGZ3+jQFuGLUrL3kops67w3qSOJjrkQZj3kIGdAR1KkhZgrbhjQWqYrO4Gz
         2SHv8pOOKV0fRfFc9caQTBYRgFoHBh5LwBdf7bfCpYx2w58k/wDNkESKmHVXECaH1fUX
         vx7+lpdC44hAU0MggDOzM6IZ7iNe+0PUe9dsBZ0GnBWXBcW5TU/GnBUxY9bohoCRzxX2
         dovQ==
X-Gm-Message-State: ANhLgQ3yqj7GbFj1VpQ8YwwP0JFFk1dvHIlpNTBI3QTRJalpefA2e9VQ
        7oL40d0Y/k1+dtLw1FK2xxBmEJi2FOoBPAiNh1+Bxz32+ZKlU0Z7lTdAwCVrsHQliIHsjQil7Bw
        kRjx6gq4nlzoi6uJcW5bN
X-Received: by 2002:ac8:4581:: with SMTP id l1mr3852948qtn.59.1583350481207;
        Wed, 04 Mar 2020 11:34:41 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsHn2bzjYBh7yhIwOYSFDd0efbpFoWGSCiIqYDJtY0uHAZJqjWQvAouRmL7W3iDyAP6JRkM+g==
X-Received: by 2002:ac8:4581:: with SMTP id l1mr3852927qtn.59.1583350480930;
        Wed, 04 Mar 2020 11:34:40 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id k4sm14181293qtj.74.2020.03.04.11.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:34:40 -0800 (PST)
Date:   Wed, 4 Mar 2020 14:34:33 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
        robin.murphy@arm.com
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Message-ID: <20200304142838-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
 <20200303105523-mutt-send-email-mst@kernel.org>
 <20200304133707.GB4177@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304133707.GB4177@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 04, 2020 at 02:37:08PM +0100, Joerg Roedel wrote:
> Hi Michael,
> 
> On Tue, Mar 03, 2020 at 11:09:41AM -0500, Michael S. Tsirkin wrote:
> > No. It's coded into the hardware. Which might even be practical
> > for bare-metal (e.g. on-board flash), but is very practical
> > when the device is part of a hypervisor.
> 
> If its that way on PPC, than fine for them. But since this is enablement
> for x86, it should follow the x86 platform best practices, and that
> means describing hardware through ACPI.

For hardware, sure.  Hypervisors aren't hardware
though and a bunch of hypervisors don't use ACPI.


> > This "hardware" is actually part of hypervisor so there's no
> > reason it can't be completely self-descriptive. It's specified
> > by the same entity as the "firmware".
> 
> That is just an implementation detail. Yes, QEMU emulates the hardware
> and builds the ACPI tables. But it could also be implemented in a way
> where the ACPI tables are build by guest firmware.

All these extra levels of indirection is one of the reasons
hypervisors such as kata try to avoid ACPI.

> > I don't see why it would be much faster. The interface isn't that
> > different from command queues of VTD.
> 
> VirtIO IOMMU doesn't need to build page-tables that the hypervisor then
> has to shadow, which makes things much faster. If you emulate one of the
> other IOMMUs (VT-d or AMD-Vi) the code has to shadow the full page-table
> at once when device passthrough is used. VirtIO-IOMMU doesn't need that,
> and that makes it much faster and efficient.


IIUC VT-d at least supports range invalidations.

> 
> > Making ACPI meet the goals of embedded projects such as kata containers
> > would be a gigantic task with huge stability implications.  By
> > comparison this 400-line parser is well contained and does the job.  I
> > didn't yet see compelling reasons not to merge this, but I'll be
> > interested to see some more specific concerns.
> 
> An ACPI table parse wouldn't need more lines of code.

It realies on ACPI OSPM itself to handle ACPI bytecode, which is huge.


> For embedded
> systems there is still the DT way of describing things.

For some embedded systems.

> Regards,
> 
> 	Joerg

