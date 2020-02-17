Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9106B161239
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2020 13:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgBQMkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Feb 2020 07:40:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54258 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgBQMkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Feb 2020 07:40:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so17004767wmh.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2020 04:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VM4sr45eMsFNfm3I8AuewKPZ2mzCi8kc40UVw+7O2LQ=;
        b=xB+yOUMH1+HqPIVwYA3f+1KohCCBUZKzi2se4L7bK+0Hs0L2ST4OcrzccxNLIKZSZL
         meF2am7U3/daqiwqZ2iYjulCYMVLvp6cA+U2CEevmBa4//Ar02kR0gI8SOaoXc2FPtNM
         4mii9R/d783fyE/dxumDzGZA8y7IOZs1u0FLd3Z4kzBmSygQEGxTGUYOe5fqlT9fjxx2
         FBivVrn9YMs6qKmDf7fYx4XhyXb2rq9Zz7yxrlKls/r0+mqTuKY6553nH6pjvXf0vhDz
         dxEhqGpoCEOSpWjK878ms0OPbBVieYrKP3NYoCNhXJO1KEiCzbAQp4gwPxSiLHMZGPv/
         8yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VM4sr45eMsFNfm3I8AuewKPZ2mzCi8kc40UVw+7O2LQ=;
        b=Bu4+Ce1LcnrTkFBqRv/sYuGbXvVIyfv/yytI6Kv3edkirZtYFssH+6pZxA30kDEGRW
         +OXDyr5lrNXFPV3NpvU7ZWBkDwftEqM1aI1N5UxeFlnUHJXHOHtPbeCE/Y4HVnk8lCxv
         Mv9dIoWOtESIO37vuLGpqTisLcoN1KDPZnO9WpcN8bBglKLgyH2EJq5x5YbWu9V7t5vl
         cvOmaHvBuG4/cIaTQXpa8cJlmEVa0vdFB4/TGt8TJVnNDxrLv2uf+GrKgaCjuA7PfKYc
         PtybT45fYjPUfIXWjdDfJ4BNVVF4yMJlWcVVexAO0n7HG8L5w/QqOimQER7V4Go/ERlS
         arsQ==
X-Gm-Message-State: APjAAAUUNcaLPd7Hv0WkMkFEhwtUX8Vw5wLELiIn9VTCc8+9TRh6kzJF
        phSSk5wiGpp+2vBtIR0a4f4RipY6tKqG5A==
X-Google-Smtp-Source: APXvYqw7OaMmOiCFpqSYiEkkioeWfbwcKs6q33Y3t8Kyrhd1NgY0z99Vh6YZxCeeeslYOpZSiSCuUQ==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr21509184wmh.98.1581943237117;
        Mon, 17 Feb 2020 04:40:37 -0800 (PST)
Received: from myrica ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d16sm917782wrg.27.2020.02.17.04.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 04:40:36 -0800 (PST)
Date:   Mon, 17 Feb 2020 13:40:28 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 03/11] PCI: OF: Check whether the host bridge supports ATS
Message-ID: <20200217124028.GC1650092@myrica>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
 <20200213165049.508908-4-jean-philippe@linaro.org>
 <CAL_JsqKZP9u7bFsVT=5TzqmnHWm_bvH39ffkbN3q9-k32ynVig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKZP9u7bFsVT=5TzqmnHWm_bvH39ffkbN3q9-k32ynVig@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 12:26:46PM -0600, Rob Herring wrote:
> On Thu, Feb 13, 2020 at 10:52 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Copy the ats-supported flag into the pci_host_bridge structure.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/pci/controller/pci-host-common.c | 1 +
> >  drivers/pci/of.c                         | 9 +++++++++
> >  include/linux/of_pci.h                   | 3 +++
> >  3 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> > index 250a3fc80ec6..a6ac927be291 100644
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> > @@ -92,6 +92,7 @@ int pci_host_common_probe(struct platform_device *pdev,
> >                 return ret;
> >         }
> >
> > +       of_pci_host_check_ats(bridge);
> >         platform_set_drvdata(pdev, bridge->bus);
> >         return 0;
> >  }
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index 81ceeaa6f1d5..4b8a877f1e9f 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -576,6 +576,15 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_parse_request_of_pci_ranges);
> >
> > +void of_pci_host_check_ats(struct pci_host_bridge *bridge)
> > +{
> > +       struct device_node *np = bridge->bus->dev.of_node;
> > +
> > +       if (!np)
> > +               return;
> > +
> > +       bridge->ats_supported = of_property_read_bool(np, "ats-supported");
> > +}
> 
> Not really any point in a common function if we expect this to be only
> for ECAM hosts which it seems to be based on the binding.

I'll move this to pci-host-common.c

Thanks,
Jean
