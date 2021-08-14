Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6663EC253
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 13:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhHNLQx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 07:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhHNLQv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 07:16:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C96C061764;
        Sat, 14 Aug 2021 04:16:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a5so15302495plh.5;
        Sat, 14 Aug 2021 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bcd1tVUeLasuXBpBdQYWjgZ2ryyumZppgp2fnNj+U/4=;
        b=hMoR/uPwhadn4YCgmIoNbqq4p9XnWzRfYPg8buTiAiKPLXYF13XBs2ZYVPQlBvUO5D
         UZELbWLKcrm2l8zqqMx1l9obEqgTp0gMfSpODZbk00fnEAV8r+nWE4HxMl2nLM4wNCl8
         LsE0AIT+rWCAKz5pjc6j5G3hyi/XDy/alpz0vbRpOG6xEA8KDqQvlyVAdsrLpDGu16H4
         /tZQs+RXexsHcR/4qZZcYNzHQjivNtNpvTSpfqw1ImEUZ4+pEPYF2YdXnzlZxsm6JRAh
         Lxx61PoZRo3kh2TSJHxgo9DWJxyLyrWMw5ouKa226AR5FUjU+zQDMQBS4PRckk7cZ/gZ
         XXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bcd1tVUeLasuXBpBdQYWjgZ2ryyumZppgp2fnNj+U/4=;
        b=c5HhV6wBumR4DNUGH54qWvPFFDCwmyqQT7odnoJWV4TlDTK3EQ9rtiRQAQRo46UJrl
         uxAKUXaffDDzP09GmSPcAQ/8y6J+CEN5hm+mZQHaflVN2YIoP1QNmQRumHt5VE36S8hI
         PTU8j+ev0FZGt51YcFgbkn8pD+9ZylcBrNPiZpi0lKp918sk72h6IKRxt8PmKx/BJuic
         42haes4OT7ETYQqorecP9ctVlBZ1z6uw4aDjeUVTyAdfJcLzXHMHCX8LZ+h5Dz3tCcpQ
         v5+tueI6k2kSrjLNIqXDPdhl+Of0HmmzdfLSFI8XPGs8ExoSLA3JlaTgE36qaXArJ/k+
         BD6w==
X-Gm-Message-State: AOAM533o6Eeza2OFg+b/k+FHWUGo+RXv8NcTFxPG7XbDhesl2NQrzGHw
        tPqhOe9CApEVY6aUB0AUzZk=
X-Google-Smtp-Source: ABdhPJyz313Rg+dCN0G0ai5PmG/7G8W0/K0TfluTIjeTL/kryGIZfY1NNL0Uw+HaaqMheil5mg6/0w==
X-Received: by 2002:a05:6a00:1a55:b029:3c3:2231:4d16 with SMTP id h21-20020a056a001a55b02903c322314d16mr6692340pfv.18.1628939783260;
        Sat, 14 Aug 2021 04:16:23 -0700 (PDT)
Received: from localhost ([139.5.31.161])
        by smtp.gmail.com with ESMTPSA id p29sm5518833pfw.141.2021.08.14.04.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 04:16:22 -0700 (PDT)
Date:   Sat, 14 Aug 2021 16:46:20 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vikram Sethi <vsethi@nvidia.com>,
        Chris Browy <cbrowy@avery-design.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: CXL Hot and Warm Reset Testing
Message-ID: <20210814111620.wn6422g3dbed52ex@archlinux>
References: <DM5PR12MB2534D383B0226498DD7F2005BDFA9@DM5PR12MB2534.namprd12.prod.outlook.com>
 <20210813171421.GA2593219@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813171421.GA2593219@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/08/13 12:14PM, Bjorn Helgaas wrote:
> [+cc Amey (working on PCI resets), linux-pci]
>
> On Fri, Aug 13, 2021 at 05:01:32PM +0000, Vikram Sethi wrote:
> > Hi Dan,
> >
> > > -----Original Message-----
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > On Wed, Aug 11, 2021 at 9:42 AM Chris Browy <cbrowy@avery-design.com>
> > > wrote:
> > >
> > > /sys/bus/pci/devices/$device/reset is a method to trigger PCI
> > > device reset, but I do not expect that will ever gain CXL specific
> > > knowledge.
> > >
> > CXL reset may need some thought, specially for devices that don't
> > expose FLR but do expose CXL reset (while former does not affect
> > CXL.cache/mem, the latter wipes out CXL.cache/mem state in the
> > device and there is discoverability as to whether or not memory
> > contents can be cleared as part of CXL reset). We may need a way of
> > triggering CXL reset from userspace, and if the existing
> > /sys/bus/pci/devices/$device/reset won't have knowledge of CXL
> > reset, there still should be a prioritized order in the kernel in
> > which CXL reset is attempted before more drastic resets like SBR.
> > IIRC CXL reset can also impact all functions that use CXL.cache/mem,
> > but not legacy PCIe functions on the device which do not use
> > CXL.cache/mem (there is discoverability as to which functions are
> > not impacted by CXL reset).
> >
> > Thanks,
> > Vikram

We can add new reset method and expose it to userspace via new 'reset_method'
sysfs attribute introduced in this series
https://lore.kernel.org/linux-pci/20210805162917.3989-1-ameynarkhede03@gmail.com/

Thanks,
Amey
