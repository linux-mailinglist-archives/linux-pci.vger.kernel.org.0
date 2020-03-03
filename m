Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9285E177B98
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 17:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgCCQJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 11:09:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51218 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729235AbgCCQJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 11:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583251790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wKvfdiF15fmxVLHPj5o9eKPjxoX2xTKxmfQEHSXHh40=;
        b=MhSgFAVQmVKTRdNSzAf6WyyGZXkuNtAU7HCbk/Nr1E22JIS7a43liVks7pRbhzEAnlXH/A
        EvEUpBe8fy+YISyyODMGNwanEnoRMHepxVjVztmHzy5TD9LkXP643kz1BWzsg9k8iA6SLD
        sb/Ztif6K4+0XG2RIV4HINSJyvjwqfY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-nMI9zlulNqulBc_0VW3-2A-1; Tue, 03 Mar 2020 11:09:48 -0500
X-MC-Unique: nMI9zlulNqulBc_0VW3-2A-1
Received: by mail-qk1-f197.google.com with SMTP id h6so2451610qkj.14
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2020 08:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wKvfdiF15fmxVLHPj5o9eKPjxoX2xTKxmfQEHSXHh40=;
        b=Cat7S7JhtJACzz+IFOYGoLgVGOa5L0wnWhELTRf0ICUJkUcIpkxcN4hsjvOlJ2p2jy
         rSEaK/uHp3fyFVoLQ3LRdI5qYS6qO6tUPqCFZ9F28iQfq+oQ1XATlgrgqmr/UF6bsD3V
         odtahgkUg3n3eIIKBT4X+DD4OfQ0WxNdIoPtg+jbG/ZD/YLQtC1LXv1heYgp+HgDkBqm
         NsZkS/CrKqqVRjEbyvrscGtjcS7B2EbjBfBWWVDnnlOdVN3mOJlgVY1jUIDi/cmTcYh7
         D0SJcPo05hcGjgF+WeEoqQGyU9VMRqRUcFDlXB43MIktONV+TUZVusgs5HfXIO2IUj02
         50Bw==
X-Gm-Message-State: ANhLgQ1XOXIACYmZumoWIUAD8bsnN+scCNrftlCywW3NfNHTn4NLyrKn
        DNeCpGrtjrJZEOIUi1zM+RkNsdqtFrjmZv0xvsSJE0Mp44BH8XTjUcE3CRL9K/geSRvjpXipAHe
        6UHQe+iUnvmSTMhZZgaDd
X-Received: by 2002:a05:6214:17c5:: with SMTP id cu5mr4424126qvb.210.1583251788241;
        Tue, 03 Mar 2020 08:09:48 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtJ9GIyZMaGCJIKTXUVP5hZCrw/gJ9Guh3JYChqVs+dNQ8M4rE5nkP++m1WK1jniaFYOb8e4Q==
X-Received: by 2002:a05:6214:17c5:: with SMTP id cu5mr4424097qvb.210.1583251787954;
        Tue, 03 Mar 2020 08:09:47 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id x34sm8269204qta.82.2020.03.03.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:09:47 -0800 (PST)
Date:   Tue, 3 Mar 2020 11:09:41 -0500
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
Message-ID: <20200303105523-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303155318.GA3954@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 04:53:19PM +0100, Joerg Roedel wrote:
> On Tue, Mar 03, 2020 at 09:00:05AM -0500, Michael S. Tsirkin wrote:
> > Not necessarily. E.g. some power systems have neither.
> > There are also systems looking to bypass ACPI e.g. for boot speed.
> 
> If there is no firmware layer between the hardware and the OS the
> necessary information the OS needs to run on the hardware is probably
> hard-coded into the kernel?

No. It's coded into the hardware. Which might even be practical
for bare-metal (e.g. on-board flash), but is very practical
when the device is part of a hypervisor.

> In that case the same can be done with
> virtio-iommu tolopology.
> 
> > That sentence doesn't really answer the question, does it?
> 
> To be more elaborate, putting this information into config space is a
> layering violation. Hardware is never completly self-descriptive


This "hardware" is actually part of hypervisor so there's no
reason it can't be completely self-descriptive. It's specified
by the same entity as the "firmware".


> and
> that is why there is the firmware which provides the information about
> the hardware to the OS in a generic way.
>
> > Frankly with platform specific interfaces like ACPI, virtio-iommu is
> > much less compelling.  Describing topology as part of the device in a
> > way that is first, portable, and second, is a good fit for hypervisors,
> > is to me one of the main reasons virtio-iommu makes sense at all.
> 
> Virtio-IOMMU makes sense in the first place because it is much faster
> than emulating one of the hardware IOMMUs.

I don't see why it would be much faster. The interface isn't that
different from command queues of VTD.

> And an ACPI table is also
> portable to all ACPI platforms, same with device-tree.
> 
> Regards,
> 
> 	Joerg

Making ACPI meet the goals of embedded projects such as kata containers
would be a gigantic task with huge stability implications.  By
comparison this 400-line parser is well contained and does the job.  I
didn't yet see compelling reasons not to merge this, but I'll be
interested to see some more specific concerns.


-- 
MST

