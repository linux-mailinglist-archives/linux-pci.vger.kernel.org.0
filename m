Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2209F42F928
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 18:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbhJOQ6O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 12:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241828AbhJOQ6N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 12:58:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603BC061570
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 09:56:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa4so7617550pjb.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AaNCt4OmVhLvoFGzEVj4sViAisbx0ICeCpQAIecvxqI=;
        b=hPtUn5xDRLIFQwIqC+vCxBy4ne14xnuKSSFL/3XuvrTqwY+L33IRim9F2QSX1FS3GD
         eClTIOjeUdFZVfeE+zB1ywC5h1IGnSmSp2ez0scC7FNzaRz4FeN0jr63F3Zj/8YTtXCi
         nSxnRATEQS8yMwDArMMsqHk2WXiSvivnMRsv8kE0IcV3BRU07VcwAWWY3cqDGTIvNBfF
         Saxncu/BJD3qtFZs2xGayUjxYicDKj2djElyb2NEL4WpJYZsI/lB9X0RYGWfBeGRplzJ
         cbowtfklm7xgb2l08imWEz0EaRUVsPxHl2s2rxsglcMGRcaCV6XZ1QDNL6R4A397ZYWQ
         f0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AaNCt4OmVhLvoFGzEVj4sViAisbx0ICeCpQAIecvxqI=;
        b=Y31CsqyKba0v/g5X6AQgJlsrZrODotXl1fuJyGXXc8DlglOMaOWRz3lJIo5ZlK3QbY
         WdRmg8+Lw8NZAXIRuve0Wgf9VgEBhKNgqWjEHt9S7Z6aT4klFDJ2ogQQ4sDZ7JrMMr67
         onQZd0GDL1L/gIFdE5EpQq52PaBEv0OFrU7DXgW3YjuqZlUHvB7W7hJjElWjP5T9IhCk
         8p0tZOkUduc0XcdJTGbCYAISzmgoArLYBSKUYw2W772foO5pqALt1HJ1aKHu/H6gAFz4
         WGpVTRYCfp6ESiVrZsHYZApqTehZbbDO7Cn1ThPsOCdTNLNIMSABkYnie5WWeKAb4Q+/
         FzEQ==
X-Gm-Message-State: AOAM530xLYr4wAVHuiex+KIIAEfH3cIccRbhiPxdzDUfJswvx+WIm9hd
        pTEtCCpcO6ibO3Jqm1ZO+Oj2FZxjyveJGkCwkzjR3g==
X-Google-Smtp-Source: ABdhPJyOtIyBzAL4O7WPCBfNYHHReQtLzXKDwE0ySONpN92H2FI0Q4u1sLjT3ZL/ZjCgpIvxqAwijeO87SXsPlIQUqc=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr11958655plb.89.1634316966039; Fri, 15
 Oct 2021 09:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211015172732.000012fc@Huawei.com>
In-Reply-To: <20211015172732.000012fc@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Oct 2021 09:55:57 -0700
Message-ID: <CAPcyv4j9W4NJFTPk8c5_nG_fAUpecnY886jKmhYzZONW4RCf5Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] cxl/pci: Add @base to cxl_register_map
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 9:27 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 9 Oct 2021 09:44:29 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In addition to carrying @barno, @block_offset, and @reg_type, add @base
> > to keep all map/unmap parameters in one object. The helpers
> > cxl_{map,unmap}_regblock() handle adjusting @base to the @block_offset
> > at map and unmap time.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I don't really mind them, but why the renames
> from cxl_pci_* to cxl_* ?

Primarily because we had a mix of some functions including the _pci
and some not, and I steered towards just dropping it. I think the
"PCI" aspect of the function is clear by its function signature, and
that was being muddied by passing @cxlm unnecessarily. So instead of:

cxl_pci_$foo(struct cxl_mem *cxlm...)

...I went with:

cxl_$foo(struct pci_dev *pdev...)

...concerns?
