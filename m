Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531C0260EA1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgIHJ00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 05:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbgIHJ0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 05:26:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FFFC061755
        for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2020 02:26:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so16530548wme.5
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2020 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7fUecfB9LLaLKdzP7guVOAA/NuO83G9N3hrYCH3AmL8=;
        b=wJYV9lcctSfmuShvtMnwiMIVuVUnaSV031DntX0fPG7kD7YYi7Qfx0Ilnmvxn+Tw25
         0yXFXi/KnDTcytB5oXrQwmbhRANSi9ZHYQ4yA73UBM8JqWiO7gdDn8US5QiiH+3oT6Vo
         kPnjYDMTPDh8b4bAjVNlacArbDfEGQiAkC8c6wOcN91nKyl3efu5sHrsVSsVB7nIZCm5
         so67u6UcFoc9cR19KUwSNswZGeHf/a1Zs9syrBrIgIMzoWRBYOj8DgeNl8shAfXwgYrw
         xeXE+agv6IvHaHR8GHjKeFYvPUpy4gyVAN7n2w9jqaUtiYdWjg+ns9/aw7TICaQv6nYy
         u6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7fUecfB9LLaLKdzP7guVOAA/NuO83G9N3hrYCH3AmL8=;
        b=E47sU/3GsGEAAhRy4PGR+efjiqOKk54plESvdYpJIhnzW6CqUAH3VjpdwsyxyLqzRq
         gB9x1nPysB+O2/4/AZfaDMTOdp4zBSDI56+i0zukIG+Da7c+/y45FTXISTHOKOJYq/1s
         pPwedP7JRye4ALCPonubOpwvirghb6I5Z2aI2HhJZvD7S+wiOjuYnJuUu8C+AYP5f7vV
         T5mLS11HdhhIU5Oy3Y46o7mBR+eYCJ7sLvhe3U9OrBtA9lztxUN2VvJrjeR0S0EyoLap
         U1e9WzPjIq1XCLsWs/xDRt6ZrspkHTpAlhpJoA4+omTZ6cujoxi3SBFHIc74GdrKxT5i
         mDjg==
X-Gm-Message-State: AOAM530j8M0U1+UXpUM1gytqsvdn/EvxqHuB3LCoHJvftQH6AwTCsiZW
        cJtd6bqFrFRGKlzfCd9Ady52kg==
X-Google-Smtp-Source: ABdhPJxI5VTNa1Xbty/QYz3FSrIm20cmWjYp2Nbc80tWhzIUSdGZ4zy0+uyd6xA+5ltRC7Q3J3XUXA==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr3456257wmk.148.1599557183364;
        Tue, 08 Sep 2020 02:26:23 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id g8sm31966189wmd.12.2020.09.08.02.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 02:26:22 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:26:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RESEND PATCH V5 0/3] Intel Platform Monitoring Technology
Message-ID: <20200908092620.GL4400@dell>
References: <20200819180255.11770-1-david.e.box@linux.intel.com>
 <20200828105655.GU1826686@dell>
 <CAHp75VcKrkxuAJvXnLGnHJTkVfac6N0RTH-3OEA5ksV2psWBew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcKrkxuAJvXnLGnHJTkVfac6N0RTH-3OEA5ksV2psWBew@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 28 Aug 2020, Andy Shevchenko wrote:

> On Fri, Aug 28, 2020 at 1:57 PM Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 19 Aug 2020, David E. Box wrote:
> >
> > [...]
> >
> > > David E. Box (3):
> > >   PCI: Add defines for Designated Vendor-Specific Extended Capability
> > >   mfd: Intel Platform Monitoring Technology support
> > >   platform/x86: Intel PMT Telemetry capability driver
> > >
> > >  .../ABI/testing/sysfs-class-pmt_telemetry     |  46 ++
> > >  MAINTAINERS                                   |   6 +
> > >  drivers/mfd/Kconfig                           |  10 +
> > >  drivers/mfd/Makefile                          |   1 +
> > >  drivers/mfd/intel_pmt.c                       | 220 +++++++++
> > >  drivers/platform/x86/Kconfig                  |  10 +
> > >  drivers/platform/x86/Makefile                 |   1 +
> > >  drivers/platform/x86/intel_pmt_telemetry.c    | 448 ++++++++++++++++++
> > >  include/uapi/linux/pci_regs.h                 |   5 +
> > >  9 files changed, 747 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-pmt_telemetry
> > >  create mode 100644 drivers/mfd/intel_pmt.c
> > >  create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c
> >
> > What's the plan for this set?
> >
> > I'm happy to pick it up and take it through MFD if required.
> 
> I guess that was already agreed like this and you were in Cc list of
> that discussion.

I have many submissions on the go at the moment.

Keeping full status for each of them in my head would be impossible.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
