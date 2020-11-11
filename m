Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E412AF7DF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 19:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgKKS1y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 13:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgKKS1x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 13:27:53 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B17C0613D6
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 10:27:52 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o23so4056678ejn.11
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 10:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaIQwQ+15TEIyZyj8/aGmJs71bDkEvM66klWaC5vlLw=;
        b=cnRi1TRg7jw+Q2T7s80k8pjxHp2E5efgzbSibQo+wp0XYHn6gCIhi3vNHWCxptg9Nz
         jGfzwu0NWVsuKRnP9w2nD9AnEdmLkkVNSjB3vDpMYog/W0vHnXhUzJxwGm1XUaHJvDMt
         a6AhEicgbyD1kVVvpqKJc4wSVXrHptK1B3U8WBilNceCSKVEhKmNjkUak68xGcMmygjV
         9x3OdkxyOqZ5x4cTKB3QUXAn1XFPJaFLEg/1FRP021/QuMG89u9neAGRG5y0mAD9D2u9
         mId9w4sM6GZFqJHiK0BfdgPyAvkCWLFrxs9XhsRj4XNwSEXWnbFndg8+Yes9F0MqPbpZ
         3W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaIQwQ+15TEIyZyj8/aGmJs71bDkEvM66klWaC5vlLw=;
        b=cDNK6CIQGP6Nuq7A1+1W4HGGBkoQJhDQwVHCieI75OSvri8FgvEuRwDW5F8EhzNiFn
         G6BaTPo6dhRrZxI+WliQaBHIKHxGvWgPCYTi6/STBc2EF2nAEqdaJVQmI/1af9i3207r
         OlqIctZtXv/53vhQnDgRrVlE7/ISLFE+Jpga4oRS0nmDQaSrhqBDgy6QOS0u/56RvJpc
         Awli9GC3Q1CWKcxfBQMug3M4iNfXiyYibkO70pIpejvk5/5rFl14c2znv3rluVr6tYzZ
         ccxLUKKR3TU2Ju4Q2uiHVGq5dDTFQxZgetefpFVTBXDdH7WssE/BeCIlGAVQ3t6zQby5
         fykg==
X-Gm-Message-State: AOAM530l6XhkOWYjWT2BHxP1Qiizu/u+eg8qcUDNTvrslOwF/AY39DdH
        +U53tSy2y+d3zZPlYcKvzss3s+AlluRXeKittv/2hA==
X-Google-Smtp-Source: ABdhPJzROlVJ4lA34wzyb9HvHhqu0mRf5kwgVaNxyAE7k7nKG3aTa/QRqzTSgMFmoZ8jVa9/01KcLJhtrdpoiTDHIQg=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr26103639ejb.472.1605119270879;
 Wed, 11 Nov 2020 10:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com> <20201111071231.GC7829@infradead.org>
 <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
In-Reply-To: <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Nov 2020 10:27:38 -0800
Message-ID: <CAPcyv4g=pcai9FrKaGcAHtyfm=Lzzgh8xFyG6QLA4J6FPdy5yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11, 2020 at 9:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > > +
> > > +             pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> > > +             pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> > > +             if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> > > +                     return pos;
> > > +
> > > +             pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> >
> > Overly long lines again.
>
> I thought 100 is the new 80 these days?

Saw your clarification to Vishal, I had missed that. Will trim.
