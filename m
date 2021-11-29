Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F641462869
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 00:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhK2XlW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 18:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhK2XlU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 18:41:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9367FC061714
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 15:38:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so13462316plf.3
        for <linux-pci@vger.kernel.org>; Mon, 29 Nov 2021 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYUgzSx85IMEiy6aEM9L+mu0d5BJnoi6geQ2ifsxC9E=;
        b=b2LjiueyPtEUlhN7lfxdSF25Cij8SKLEKzeyGk4QJIJ8UnMPkv51zrO+TiTG/uAqNd
         8044RGbIfcihZguXhO0kDIQAlvuLF/QhJ5f2WNfOSDnDERde6R0KExquAKjOLRnk4dlH
         fq26hb2Y5DKuY1+LuBI/BGbZEL6fsU523RXbGFeCCiIq+qa+5lqph2qdV2IxBQk8LxOv
         NNHmbxK5orXlPy1gdd8skssRv1Lw8Mhk9obu/zTuxpVwc2o9t8mPFPqZAg3nZBtezkKG
         T26m9pT1JR9heDv5J4uIe1+JEG6YszC+mSOyPbRvAebVGBoNWdkle4EUOYq7+acMtxT6
         dLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYUgzSx85IMEiy6aEM9L+mu0d5BJnoi6geQ2ifsxC9E=;
        b=SCFaKqWg6Y1vMmIbeTUw/+IfkWWRN6gHzoDjLa7Y/6F5GmEeTpWx4NQB2ikBjABPer
         il2kAGcpyuqgCAGekIrjXOWa7N/GzZqEo9Zmfe6TYdF4M5vh+7MuXAbMjyK+h2Rf0Osu
         KKUv3BuyLx6tW9MPck2yctCiJ5S8Za26CdPhWI+xDvxutLAwYC5zT3guc7oNIJM9RP0s
         vZOMgYHrAB37jHCotONA/HXFDxA2DZF9JVPihLHeq5HUNf5XKfi6fndD1lHx6S5XdNMT
         Cn1t3MfJuTIeZQR0RpEH+nUyq1s1+AJLSSe0DSERdwQiv//YRO3BkeeaVXmDBI1RPLvh
         08Mw==
X-Gm-Message-State: AOAM533Gu4xsMcnjjICoS7S5io0864Ssr1HXTLilN//bO050/Z9wFcN3
        A7T3WR0JQrksmfziDo7S8i22I2IRWqgzUoUaOZeE8A==
X-Google-Smtp-Source: ABdhPJx17raNY5tzcIn/lUtntYBrt9gHjxN9P9/vsWHS/jZ55/Snu6zzKwLB0SXg+QrFDzoEkopTD4Kq8sVea9+DsOM=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr62803540plb.4.1638229082171; Mon, 29
 Nov 2021 15:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20211117122335.00000b35@Huawei.com> <20211117221536.GA1778765@bhelgaas>
 <20211119064830.GA15425@lst.de>
In-Reply-To: <20211119064830.GA15425@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Nov 2021 15:37:56 -0800
Message-ID: <CAPcyv4g+=fkMyzoKtRbJfFyM=hq3B=RMJotNWyGoJDZk0d38uQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 18, 2021 at 10:48 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 17, 2021 at 04:15:36PM -0600, Bjorn Helgaas wrote:
> > > Agreed though how it all gets tied together isn't totally clear
> > > to me yet. The messy bit is interrupts given I don't think we have
> > > a model for enabling those anywhere other than in individual PCI drivers.
> >
> > Ah.  Yeah, that is a little messy.  The only real precedent where the
> > PCI core and a driver might need to coordinate on interrupts is the
> > portdrv.  So far we've pretended that bridges do not have
> > device-specific functionality that might require interrupts.  I don't
> > think that's actually true, but we haven't integrated drivers for the
> > tuning, performance monitoring, and similar features that bridges may
> > have.  Yet.
>
> And portdrv really is conceptually part of the core PCI core, and
> should eventually be fully integrated..

What does a fully integrated portdrv look like? DOE enabling could
follow a similar model.

>
> > In any case, I think the argument that DOE capabilities are not
> > CXL-specific still holds.
>
> Agreed.

I don't think anyone is arguing that DOE is something CXL specific.
The enabling belongs only in drivers/pci/ as a DOE core, and then that
core is referenced by any other random PCI driver that needs to
interact with a DOE.

The question is what does that DOE core look like? A Linux device
representing the DOE capability and a common driver for the
data-transfer seems a reasonable abstraction to me and that's what
Auxiliary Bus offers.
