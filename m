Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 145E5161659
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 16:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgBQPkY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 10:40:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46843 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgBQPkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 10:40:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so20253244wrl.13
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2020 07:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uBL44HTwPsTzK1hTlXHwrWPFvRz4I8cxeuhUA7nfr3s=;
        b=QUNDlRjh2O+ooQ41KWBChztMd4j9tV2M8HiE6TDGhh6KZcCXQYdQmMqHkRy/oPre/d
         E+T64sT8TUAqvGZCkZWcpAPXMK/psI/SMbqtUXH8WD/97O+XqMwt7rE0VgfYpg4SGCTu
         72DvsxmGQ2FHB1KOF86wT5RUdwe9l5E14uXBkwlKILpzWF5nOlDot/mlGYQpzffkiZng
         dV1PcmwTrlY7TdA4Y7kgPv5XUqhxhLqt6oG02ccYRx64/bgjYrAaemMkV8MHRgYP/RlA
         RNsfj1wDY4F+M6s4FATLU+2N+UfYeGwZGxIXM15btV8V9U0AnPqJn9J60Be6mPZjxKkb
         OLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uBL44HTwPsTzK1hTlXHwrWPFvRz4I8cxeuhUA7nfr3s=;
        b=WIy+VFRWT03b95RJM1R4VUMIF7ro0FBLa/pCFsvP8HwDYt69TymB5bObdIgqFM6QGv
         X04FZBJ79gU6rz1JiOWbP4UoeemKWZrsT9lKpy54ECNpAKNIjBTGTgnHCKyLYX6rUZde
         M+ixS8UPFUBB+0jskCg/smwX7E8n8lwaK0Vj1Q1UmNmSbNojUQYl0QGNpU5NXNpwOFgd
         9PelNVMHIcoBqWwM012gGCoUPQraKbJQjZgG8qg+KT55HYH2k1YfV4CFAlHdaz/rs1lb
         swR/Rlqzt3JrxPb8YU4G+qJ4NJo5/Zb76RRvFUGozzqW/T1LlGKcCBeJH3EjSH3ghcTB
         dASw==
X-Gm-Message-State: APjAAAXBYALunFlL9h+ggczrUxex8G1AR9RzqJ7QxeB7az/XVmPNLSrN
        /R7sTj+0eM+e5KEcODIhF8TzPQ==
X-Google-Smtp-Source: APXvYqyK3wvWFPYLO6Oneazyxhd5g+tje1jkIBunochJVdUjHRcEMjjKDjk9tOFHPoHKB9Cr5dnXww==
X-Received: by 2002:adf:f109:: with SMTP id r9mr22236398wro.406.1581954021861;
        Mon, 17 Feb 2020 07:40:21 -0800 (PST)
Received: from myrica ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v131sm1106010wme.23.2020.02.17.07.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 07:40:21 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:40:12 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     will@kernel.org, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        joro@8bytes.org, baolu.lu@linux.intel.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH 02/11] PCI: Add ats_supported host bridge flag
Message-ID: <20200217154012.GD1650092@myrica>
References: <20200213165049.508908-3-jean-philippe@linaro.org>
 <20200215211047.GA124796@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215211047.GA124796@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 15, 2020 at 03:10:47PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 13, 2020 at 05:50:40PM +0100, Jean-Philippe Brucker wrote:
> > Each vendor has their own way of describing whether a host bridge
> > supports ATS.  The Intel and AMD ACPI tables selectively enable or
> > disable ATS per device or sub-tree, while Arm has a single bit for each
> > host bridge.  For those that need it, add an ats_supported bit to the
> > host bridge structure.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/pci/probe.c | 7 +++++++
> >  include/linux/pci.h | 1 +
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 512cb4312ddd..75c0a25af44e 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -598,6 +598,13 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
> >  	bridge->native_shpc_hotplug = 1;
> >  	bridge->native_pme = 1;
> >  	bridge->native_ltr = 1;
> > +
> > +	/*
> > +	 * Some systems may disable ATS at the host bridge (ACPI IORT,
> > +	 * device-tree), other filter it with a smaller granularity (ACPI DMAR
> > +	 * and IVRS).
> > +	 */
> > +	bridge->ats_supported = 1;
> 
> The cover letter says it's important to enable ATS only if the host
> bridge supports it.  From the other patches, it looks like we learn if
> the host bridge supports ATS from either a DT "ats-supported" property
> or an ACPI IORT table.  If that's the case, shouldn't the default here
> be "ATS is *not* supported"?

The ACPI IVRS table (AMD) doesn't have a property for the host bridge, it
can only deselect ATS for a sub-range of devices. Similarly the DMAR table
(Intel) declares that ATS is supported either by the whole PCIe domain or
for sub-ranges of devices. I selected ats_supported at the bridge by
default since IVRS needs it and DMAR has its own fine-grained ATS support
configuration.

I'm still not sure this is the right approach, given that the
ats_supported bridge property doesn't exactly correspond to a firmware
property on all platforms. Maybe the device-tree implementation should
follow the IORT one where each device carries a fwspec property stating
"root-complex supports ATS". But it isn't nice either so I tried a cleaner
implementation (as discussed with Robin back on the ATS-with-SMMUv3 series
[1]).

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/c10c7adb-c7f6-f8c6-05cc-f4f143427a2d@arm.com/
