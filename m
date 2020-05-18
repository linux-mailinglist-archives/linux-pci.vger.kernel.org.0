Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880B11D7FF1
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgERRUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 13:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2020 13:20:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C789FC05BD09
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2020 10:20:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id bs4so9109285edb.6
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2020 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GgTcEd+caanrx1t1o1gL/Ypc50CeCw/F8i23bYyVrUw=;
        b=PuiVlzFghkrRKLS1pILHxv+676poFWDYeHwwBLU2TzTknD+dFYLk0xk+5TDy5pgW64
         qhuwEWP7J2W6vsJz9bxByoo2dcZ36iMpyHBw7XLV0g5MUF4S816ICg1DZOwDObAlCM3l
         jlS2qNoPNiw16Z9LbJPF9al5A655ElOJAWZCiLcMB/bVFyCP105iTKNVuysDuncWhyKd
         BhtMjOTMlylTNZO9ZnTXwTC3GcHLAoPHCQ+Rc0wCdFGDFSgZbzPR0IlAhtNd6yFRaXUC
         QFTeTJBaBJG91RBZss95qPo8+kfKyS7kah/YxohaMXsSe2dPgCxaCsSp+E0yeuj4kHg4
         cGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgTcEd+caanrx1t1o1gL/Ypc50CeCw/F8i23bYyVrUw=;
        b=c7vgl7mN/9pWS/gPyLOapz8giODcpYuGtAGUuiM2OxVV9mM/JBHFRopQiTItDHxzad
         VyGram14+K9xZUr/7xMNFqQRZXUC5ocMk89Uzu+tdkkk0hVDd8wuLjPnOdtgF5W7/Ybf
         2M/LlbUFosB5ENpfdO0DDt/cMur4W+kfqt/a2dFQzoPoQftWSwdOyKJaaSp/t52F0x68
         Uv8sd9qKoKUGIT+sjga9z8nAUP2s/aWxQIjEhCxil5SJh6x5edH7/AS96/OGMlJjgPbr
         eMSjg/2F5mQCMuPT04lZwerAxYlH4F9M1PGEwUKjJNKHP+nVzGKLXuC9ipdex4mf2tLp
         yzgA==
X-Gm-Message-State: AOAM531emIw3zdnD3jaB3z1vHrVWgXn/3DouA9MCeNEuqlcmyK2xtG1W
        tINKHgytsAVGFrl58hpmR5EVnNcFdNqiGZaOJ8iYtQ==
X-Google-Smtp-Source: ABdhPJz5bmBALzw+D9Jia6d4zvkIV02xWwFo/oM2e8pEt1WN25M6AUsNVPV+EY0iKhYAw1fQk4Bl1vsVwJ4nmUApjn8=
X-Received: by 2002:a05:6402:1c1e:: with SMTP id ck30mr14064996edb.154.1589822434411;
 Mon, 18 May 2020 10:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200428051312.GB17146@lst.de> <de052d30cc881ac67f9410b50b0760ee5bf9a623.camel@linux.intel.com>
 <20200428142247.GB5439@lst.de> <de2d78556fcb10f97364201256ac8f342a58eb75.camel@linux.intel.com>
 <296064bbcf702744bf603932c9d849307db2e5b7.camel@intel.com> <b0ca81f973ba55a2d6a8c84bc00f2324bad64f30.camel@infradead.org>
In-Reply-To: <b0ca81f973ba55a2d6a8c84bc00f2324bad64f30.camel@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 May 2020 10:20:23 -0700
Message-ID: <CAPcyv4hE6iW3MwW=qybN8aXN4wHJ7R2OCDCUEw9FdKu4NeZ6iw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add support for StorageD3Enable _DSD property
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "hch@lst.de" <hch@lst.de>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 18, 2020 at 6:52 AM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2020-04-29 at 05:20 +0000, Williams, Dan J wrote:
> > The *patch* is not trying to overrule NVME, and the best I can say is
> > that the Intel Linux team was not in the loop when this was being
> > decided between the platform BIOS implemenation and  whomever  thought
> > they could just publish random ACPI properties that impacted NVME
> > operation [1].
> >
> > So now David is trying to get these platform unbroken because they are
> > already shipping with this b0rkage.
>
> This is what we have WARN_TAINT() for though, right? It can suitably
> warn users when such breakage is detected in the platform.
>

I see WARN_TAINT() as "BIOS implemented its specification wrong". This
case is BIOS "implemented a mechanism in the wrong specification".
