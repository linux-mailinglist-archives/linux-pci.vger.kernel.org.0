Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A299D177821
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 15:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgCCOAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 09:00:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42038 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727804AbgCCOAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 09:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583244016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aa6HtSeh49MIF/xjAgoQ7EQau/N+kwzDq7RM+vAw+Uo=;
        b=idd0hF0HzLrt9N4JAL6p2MgfJHMl1rOYhQcnYk8y5kNu9jvhn9Bq42IGjoH0qmCBZfu56J
        Mu2GLx9fG+gSzuXywk6E1dmYPNKhNAWy8LaSaDuzo2qGMcS55fnjwXL1pCiLh2lflee+P5
        0IsPPknNIWIZ+/Bm9aZ9tRsurEaYiCg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-NCMDcq-zPIyCwkc3tSwcsw-1; Tue, 03 Mar 2020 09:00:13 -0500
X-MC-Unique: NCMDcq-zPIyCwkc3tSwcsw-1
Received: by mail-qt1-f197.google.com with SMTP id k20so2228612qtm.11
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2020 06:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aa6HtSeh49MIF/xjAgoQ7EQau/N+kwzDq7RM+vAw+Uo=;
        b=gP5t16JXDBr6M/Tj/QjYpiLQKZECMY54ujUhd3nZML86OhcBts7ia0MqdTvze/+t9e
         LUG1ro1IdlauzBZ1yjRkTqC9fynwxCWgR1YITmesCyVG4E59mYeNv6B5hpJ97yNB1R17
         xcIEUNnZEtVvYUL8hQQ2ehC0dHXi8+XDz8dtrTSmreGu7AXp9GIJBTrRUlSkPJKyPK80
         W/2YTusPAf5n0bHApKbNEyFXwEek7iM+5D4A35Ddvc4MrDHsGukmUP85cDXyo+07KO4Y
         BSB28DHiSmbGEzPeRftSUYiUau9y57Zxti51MMu/EWGwEcK29Jc4GT+b4+wFtZnr6J5N
         /4+w==
X-Gm-Message-State: ANhLgQ1aKTsSzQHZo1cZe1FOImkFcI3kkcVs0IUeJkeq/y9kr7fj2c2/
        Y+84yhPCGwMIAYSHlhs07nbu+oXA1FhW9dIS2m+7l1lpsyjVDDyJgkWGolcQbART8swwI2UtWzp
        XDkwO7Csb29NSLunHDXFH
X-Received: by 2002:ac8:1c7a:: with SMTP id j55mr4453349qtk.311.1583244012062;
        Tue, 03 Mar 2020 06:00:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuZwadsAvkhUcJH4/W47LkbDsji9AWmjLQIpqUobhWh56z5UC579vb1nzWGmKUdc6OPFj59sQ==
X-Received: by 2002:ac8:1c7a:: with SMTP id j55mr4453330qtk.311.1583244011778;
        Tue, 03 Mar 2020 06:00:11 -0800 (PST)
Received: from redhat.com (bzq-79-180-48-224.red.bezeqint.net. [79.180.48.224])
        by smtp.gmail.com with ESMTPSA id j1sm9081095qtd.66.2020.03.03.06.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:00:10 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:00:05 -0500
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
Message-ID: <20200303084753-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303130155.GA13185@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 03, 2020 at 02:01:56PM +0100, Joerg Roedel wrote:
> Hi Eric,
> 
> On Tue, Mar 03, 2020 at 11:19:20AM +0100, Auger Eric wrote:
> > Michael has pushed this solution (putting the "configuration in the PCI
> > config space"), I think for those main reasons:
> > - ACPI may not be supported on some archs/hyps
> 
> But on those there is device-tree, right?

Not necessarily. E.g. some power systems have neither.
There are also systems looking to bypass ACPI e.g. for boot speed.


> > - the virtio-iommu is a PCIe device so binding should not need ACPI
> > description
> 
> The other x86 IOMMUs are PCI devices too and they definitly need a ACPI
> table to be configured.
> 
> > Another issue with ACPI integration is we have different flavours of
> > tables that exist: IORT, DMAR, IVRS
> 
> An integration with IORT might be the best, but if it is not possible
> ther can be a new table-type for Virtio-iommu. That would still follow
> platform best practices.
> 
> > x86 ACPI integration was suggested with IORT. But it seems ARM is
> > reluctant to extend IORT to support para-virtualized IOMMU. So the VIOT
> > was proposed as a different atternative in "[RFC 00/13] virtio-iommu on
> > non-devicetree platforms"
> > (https://patchwork.kernel.org/cover/11257727/). Proposing a table that
> > may be used by different vendors seems to be a challenging issue here.
> 
> Yeah, if I am reading that right this proposes a one-fits-all solution.
> That is not needed as the other x86 IOMMUs already have their tables
> defined and implemented. There is no need to change anything there.
> 
> > So even if the above solution does not look perfect, it looked a
> > sensible compromise given the above arguments. Please could you explain
> > what are the most compelling arguments against it?
> 
> It is a hack and should be avoided if at all possible.

That sentence doesn't really answer the question, does it?

> And defining an
> own ACPI table type seems very much possible.

Frankly with platform specific interfaces like ACPI, virtio-iommu is
much less compelling.  Describing topology as part of the device in a
way that is first, portable, and second, is a good fit for hypervisors,
is to me one of the main reasons virtio-iommu makes sense at all.

> 
> Regards,
> 
> 	Joerg

