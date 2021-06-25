Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18DC3B4B61
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 01:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFYXzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 19:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhFYXzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 19:55:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D829C061574
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 16:53:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a127so8681233pfa.10
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 16:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B3kmBVK4hmEcO9Vrc14ZH+X77ezATv4UHRmAcjtROjA=;
        b=jbaCAE6XAVd+/5OJyfxauN6L5jT22syUfDB5Uv8D1nVMDu7JfsBOuOyS34unBt8UQW
         le9e6ZLBPG5rWMXsuBV6EVlYM+kx/rPVwYFe76xPcXFpsc/HzCxfuQ5tYS4I7bxv4VaZ
         nV5MJUbFL79/y92oSV9tXcv3OEgLyInXGC96wq1vZNMTRCWeofL+kyTiX9o5rSVybFMX
         SydWyRkT9AAV/KovTfwTVhVU6oEnOWyUr7mXM0F6v3InsFa09zPNkW/rBdmwQA7UmYHH
         5gel16Zbs9EBa0hBWhN9LDG7A9dV0t9oBvRSuM+ce95egsr9haAPDAJ8nVk4R+n3eaz0
         xhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B3kmBVK4hmEcO9Vrc14ZH+X77ezATv4UHRmAcjtROjA=;
        b=Zj+Rr/aT+4RqEEcfeRCGCtvlenCi3vjSGTZedKwZyscTuG4HhYe24IKKzc51N1UcNI
         MozhTiFX6soMKWBMg2bz2giOCuWX44GSD+pBXh5CQY8AFLWhnTl+qDVHNhxp3HhwjrrM
         RqDHqMlxplyAGwkgfp7qWcwpUNJryaJ4EuU6bMV3R3RN+FCO1Ar9uj5vhJAYnsqTcHVs
         ypX0mJu8R8jC85h7Z9JOFO8nj8c+qS5iqza8cwU0C+AB0LjvNLwbztpjRymeH4nHLgEq
         6y0xGHzWCwwTo2Ifgt9FBLIRH3ObpHuQLvoWV/mAo7MzKdv4zKZHoHOmHbcoBGlMkkD3
         2tbQ==
X-Gm-Message-State: AOAM533mwFFWCdkq6mZHpD1HFOZukOWWsjX1EJWV+smp7wzU98d5i/cb
        Thx0+SjE0DNJjtg95t14Za2Juq2G9Ux6B6GbNcVnyQ==
X-Google-Smtp-Source: ABdhPJyY8gc5R6ztqPzE2PwuxCweSsGSpfL8CkLFAk62tuvCYCvC+XasZdec/PQSRG4Mq/zwiNGZhQB70uDcj2cE7lc=
X-Received: by 2002:a65:5204:: with SMTP id o4mr9497858pgp.279.1624665194608;
 Fri, 25 Jun 2021 16:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210625233118.2814915-1-kw@linux.com> <20210625233118.2814915-2-kw@linux.com>
In-Reply-To: <20210625233118.2814915-2-kw@linux.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Jun 2021 16:53:03 -0700
Message-ID: <CAPcyv4iUcuVsSVcBVwZeHpV=XG1Vss-dWjCdQRJgNiUef0VHxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sysfs: Invoke iomem_get_mapping() from the sysfs open callback
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 4:31 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> wr=
ote:
>
> Defer invocation of the iomem_get_mapping() to the sysfs open callback
> so that it can be executed as needed when the binary sysfs object has
> been accessed.
>
> To do that, convert the "mapping" member of the struct bin_attribute
> from a pointer to the struct address_space into a function pointer with
> a signature that requires the same return type, and then updates the
> sysfs_kf_bin_open() to invoke provided function should the function
> pointer be valid.
>
> Thus, this change removes the need for the fs_initcalls to complete
> before any other sub-system that uses the iomem_get_mapping() would be
> able to invoke it safely without leading to a failure and an Oops
> related to an invalid iomem_get_mapping() access.
>
> Co-authored-by: Dan Williams <dan.j.williams@intel.com>

Go ahead and replace this with:

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
