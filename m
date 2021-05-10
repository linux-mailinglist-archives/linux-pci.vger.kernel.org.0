Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF6378097
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 11:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhEJJ4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 05:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhEJJzm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 05:55:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16218C06134D
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 02:54:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h7so8880106plt.1
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 02:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsG0kiz0NRABZofCxSQspiIrXqavy4umxXhfkY+/Sxk=;
        b=W+HYriAR9Do/fBW2QstFckigQIl1nRoVqh8kV8zVcpd71XHdedwgr9ODHG4afQkOIy
         ynwXu3yhnIcmMABVDj/QNeRt0F7V/f3la3pyVX+S+CEgEQdWOUMw7w57whXmk3tKqZQ+
         S7fuzxNEGgGmhiunD9+8473p2BUhLcDS4p74Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsG0kiz0NRABZofCxSQspiIrXqavy4umxXhfkY+/Sxk=;
        b=I4BxdCxWkHChAxzgvIV2Oou7L5qh2uSZx9KetaNrMDXjWGB1Yt8L8OfvdjJfY2pGCQ
         t/WNLGW9sunL/UJwpYZJ7c0fEIOXaiIhVraz+YGXtxTQFn/f7NbZuUxzK0x8aFJZ+AaQ
         Gk7Mw5Qsva+TK0jFBIRnzIV0LZqHZw+WDRPwFG7TFXpIiG3w4MGwM0gJCPWAiSbdM+cb
         zmz2nTChhaKK4U1335KYtb233c+nrA6YkimixHPpc5UMVeEuS+L4mO0xjGmzuoCYzhb4
         O2BtP+twaVNxVNnP3MqqAv0cpiytGyP4q+9e+YOFfsG/vKKBLejSWqDU3hHVDsBPeC5Q
         SHcA==
X-Gm-Message-State: AOAM53344V4tdsZt9NSShtYqj35J3EFINmhItM1PinOu2oYm1otehTM1
        YmVDod5OcB8oWixjFOgEfzn7I3kL1il/+g==
X-Google-Smtp-Source: ABdhPJyEI/4nl9JTFtL50qFt37ubvPa+M4AjqcNhgL2hP8bitIdZA2KZJe3HjNM5AAVj0ZtwL5b5pA==
X-Received: by 2002:a17:90a:690b:: with SMTP id r11mr26664180pjj.140.1620640459222;
        Mon, 10 May 2021 02:54:19 -0700 (PDT)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com. [209.85.210.174])
        by smtp.gmail.com with ESMTPSA id k21sm206693pgb.56.2021.05.10.02.54.18
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 02:54:18 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id b15so13264887pfl.4
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 02:54:18 -0700 (PDT)
X-Received: by 2002:a92:6804:: with SMTP id d4mr20856971ilc.5.1620640447894;
 Mon, 10 May 2021 02:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210422081508.3942748-1-tientzu@chromium.org>
In-Reply-To: <20210422081508.3942748-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 10 May 2021 17:53:57 +0800
X-Gmail-Original-Message-ID: <CALiNf2_h8r6jpd1JqTwNEmW22KK8aT9B4djLKkYP7Hhnju2EKw@mail.gmail.com>
Message-ID: <CALiNf2_h8r6jpd1JqTwNEmW22KK8aT9B4djLKkYP7Hhnju2EKw@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Restricted DMA
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v6: https://lore.kernel.org/patchwork/cover/1423201/
