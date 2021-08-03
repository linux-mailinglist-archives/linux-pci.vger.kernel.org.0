Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D03DE5B6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 06:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhHCEtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 00:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbhHCEtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 00:49:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C0FC06175F;
        Mon,  2 Aug 2021 21:49:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e5so22221357pld.6;
        Mon, 02 Aug 2021 21:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cZX9G51vdpyRQg2WBsftKD5FHWyuhYxr1YfFIpc6hfg=;
        b=OQVKezk7+gecMuyjVA2/K1ZfeBWgpmSrBmZkXKyjQzRSJV74c8jcr0CiC4idTKpVte
         1VcrFZ1x+5btyNnLVITbwSQoMdioo3MEwcR48zZwkvFwHMSizWbv6QWLZ7xX2nf7jdQc
         DTGIGSCUeCZt8ZKxaIesH5XtIPxwEVfaHVO0qqBdJaYzUbw4Makn38bWJ06tERTOSBbE
         ib3L3R35XLyl51+dWqHG8swuNYDAtUxF4WdtXRk2QmqfEnjJIe42aWrRBVB6ITT7vtJo
         GNARzC7b8QdyXWrYJ1+dOfFOPosSlCCCE7KFmmyIdaIOtTXuDxtHGxUmEhQ944ZZ5LWP
         nUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cZX9G51vdpyRQg2WBsftKD5FHWyuhYxr1YfFIpc6hfg=;
        b=PdSbmYsWVJpXyxZbx5Fndcxxcr5bNJ402R+QB7GDVcYdu+lr5e+eSemmXPCUwPxFGw
         CDK9Njfn8Ci3vrpfXuNfUCbwksq0Bllr5kXYXMQTNCqISuuEj3eb2vj+Y8MiXmn+hKlU
         1Ck+2HEH5eoMcyv85PbnS+KUH1nxsPV4oc3/UDByOBjgawXM+hweqY+rocMDg91Xcbft
         JxWgLRVdykTi6Aujl/fpG73TNNp1z/J1P4QclsE579LazgUJ2k5RyotROIYX9iAkCdn5
         o4/ICGLNNqmfzgPopG5Hn90yE3fJVfxJXOw30HnwrgI/HvVeilysSxwrJpnNeXhzqyem
         sK2A==
X-Gm-Message-State: AOAM530BCJ8lzEAOxGh4z1KThUg6Gc9SF1fhRrKF4MpOQA2OG5yTT4LT
        p6gue0Df3f+2XkP5ODhPUjU=
X-Google-Smtp-Source: ABdhPJy2SLmG0hmG4OvdmYhj0f88pWIXR/e+YKjvKcS714u8GHliAheSrMmyTq/vGH7W3N/AffKTZA==
X-Received: by 2002:a17:90a:ead3:: with SMTP id ev19mr4377999pjb.229.1627966173354;
        Mon, 02 Aug 2021 21:49:33 -0700 (PDT)
Received: from localhost ([139.5.31.186])
        by smtp.gmail.com with ESMTPSA id y139sm13306607pfb.107.2021.08.02.21.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 21:49:32 -0700 (PDT)
Date:   Tue, 3 Aug 2021 10:19:29 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v13 2/9] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210803044929.p22ren6wwl3jff3f@archlinux>
References: <20210801142518.1224-3-ameynarkhede03@gmail.com>
 <20210802224420.GA1472058@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802224420.GA1472058@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/08/02 05:44PM, Bjorn Helgaas wrote:
> On Sun, Aug 01, 2021 at 07:55:11PM +0530, Amey Narkhede wrote:
> > Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> > is supported by the device which does not match the calling convention
> > followed by reset methods which use second function argument to decide
> > whether to probe or not. Add new function pcie_reset_flr() that follows
> > the calling convention of reset methods.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +--
> >  drivers/pci/pci.c                          | 40 +++++++++++++++-------
> >  drivers/pci/pcie/aer.c                     | 12 +++----
> >  drivers/pci/quirks.c                       |  9 ++---
> >  include/linux/pci.h                        |  2 +-
> >  5 files changed, 38 insertions(+), 29 deletions(-)
>
> >  int pcie_flr(struct pci_dev *dev)
> >  {
> > @@ -4655,7 +4653,26 @@ int pcie_flr(struct pci_dev *dev)
> >
> >  	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
> >  }
> > -EXPORT_SYMBOL_GPL(pcie_flr);
> > +EXPORT_SYMBOL(pcie_flr);
>
> Why this change?  If it's unintentional and there's no other reason to
> repost, I can fix it up locally.
Yeah my bad it was unintentional.
