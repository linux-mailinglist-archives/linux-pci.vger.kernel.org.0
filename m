Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE063286F81
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgJHHcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 03:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgJHHcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 03:32:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F22C061755
        for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2020 00:32:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so5388752wrt.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2020 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6Q5cOldM6q5JrfqCs8qEdwrhCyVv/oMVbGGujp3ARP4=;
        b=D/9VgxnWJBnhCcPwvZUCvpvCPL0ACCOx02s1jjCFHNcO1bQpTc/6jAQ/1M14PLM4VK
         sPI0HOsTSm80tYxBfJ4riYN/1etxSuVl2C51EXSNtj6h/s+v06IiS2SPGWhdaQIYFT1e
         HG13yQC4Vc3hvBvPW4+/fmGfKMTvLSP7cPaU0Roda0PNrmFUEuX/899X9NPxyBgmOELK
         MOtP7NAadyRrh2lJBFRSGZ0bkrum2Lk1pRjvWJe0+KuQShTsWRbaliz0M84CN1q4i9Jc
         5HDeXGJW+zZuj1GLe4a5TppeuWXh2vvtHXSa722XxGMJQSGCh2r543oOcljRjmwNzxWi
         vp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6Q5cOldM6q5JrfqCs8qEdwrhCyVv/oMVbGGujp3ARP4=;
        b=nKqAsshOPr9uRIopRZz+JaSAj/iIIKEpWQNAIr1nP0deUnUXF2n8Tq/U909sOXEF9H
         UCDCaiiFSZXbH/zJYoIKz/2MUtu09DfdwyRu1DrPzdEYtIj4MgQGXPezr6owqQXnZioy
         xVlOpsMvTiMHE5UvsqkH5A159g9lCsU2JVjRp+oUEX7YUBD6Es6l81h8itCEfwXEHd7g
         5owB0FE5tHNFPBGip3FfztTbcD3qAGFsz6ckJde/uI6j7D3G6D/rDbH/z+vWtrkIEr44
         NNqLZhutpd1ancXDtXTzMlQCZ0fCcCxSN6C9R9G1iIiWLIuLlXCkDEAZn3NG9vf4byOY
         +W3w==
X-Gm-Message-State: AOAM530FkUQQpt8rwBn5+jcIwt8tU6uyWdg4utpdmkfMN46h361gkCPo
        hslmj7rq6UcVDDDtxQNRTG3R8w==
X-Google-Smtp-Source: ABdhPJxFjGV/yxOiFqpYLTyRD7i+NgV9Bw3QiP14XQdh13hJO+WlbWlBg3JHxI4WR5vxKchmzx73uw==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr7371061wrm.320.1602142337036;
        Thu, 08 Oct 2020 00:32:17 -0700 (PDT)
Received: from dell ([91.110.221.232])
        by smtp.gmail.com with ESMTPSA id n6sm6423368wrx.58.2020.10.08.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:32:16 -0700 (PDT)
Date:   Thu, 8 Oct 2020 08:32:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        hdegoede@redhat.com, alexey.budankov@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V8 2/5] mfd: Intel Platform Monitoring Technology support
Message-ID: <20201008073214.GF1763265@dell>
References: <20201003013123.20269-1-david.e.box@linux.intel.com>
 <20201003013123.20269-3-david.e.box@linux.intel.com>
 <20201007065751.GA1763265@dell>
 <09930d0783d6a5f17f9af872b4fc7a244c6dc5e1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09930d0783d6a5f17f9af872b4fc7a244c6dc5e1.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 07 Oct 2020, David E. Box wrote:

> On Wed, 2020-10-07 at 07:57 +0100, Lee Jones wrote:
> > On Fri, 02 Oct 2020, David E. Box wrote:
> > 
> > > Intel Platform Monitoring Technology (PMT) is an architecture for
> > > enumerating and accessing hardware monitoring facilities. PMT
> > > supports
> > > multiple types of monitoring capabilities. This driver creates
> > > platform
> > > devices for each type so that they may be managed by capability
> > > specific
> > > drivers (to be introduced). Capabilities are discovered using PCIe
> > > DVSEC
> > > ids. Support is included for the 3 current capability types,
> > > Telemetry,
> > > Watcher, and Crashlog. The features are available on new Intel
> > > platforms
> > > starting from Tiger Lake for which support is added. This patch
> > > adds
> > > support for Tiger Lake (TGL), Alder Lake (ADL), and Out-of-Band
> > > Management
> > > Services Module (OOBMSM).
> > > 
> > > Also add a quirk mechanism for several early hardware differences
> > > and bugs.
> > > For Tiger Lake and Alder Lake, do not support Watcher and Crashlog
> > > capabilities since they will not be compatible with future product.
> > > Also,
> > > fix use a quirk to fix the discovery table offset.
> > > 
> > > Co-developed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com
> > > >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > ---
> > >  MAINTAINERS             |   5 +
> > >  drivers/mfd/Kconfig     |  10 ++
> > >  drivers/mfd/Makefile    |   1 +
> > >  drivers/mfd/intel_pmt.c | 226
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 242 insertions(+)
> > >  create mode 100644 drivers/mfd/intel_pmt.c
> > 
> > I Acked this back in August.
> > 
> > Any reason why you didn't carry it forward?
> 
> So that you could review changes made after the Ack.
> Please let me know if this is not preferred. Thanks.

No, that is the correct way to do things (see below).

> You did and you requested fixups which were made.

Keeping the status of each and every patch-set currently in my inbox
would be a very difficult task.

This is why I recommend patch-level changelogs (just below the '---'
marker).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
