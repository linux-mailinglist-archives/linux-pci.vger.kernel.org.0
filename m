Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D842FCE4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 22:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbhJOUSy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbhJOUSx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 16:18:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE1C061767
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s1so5252386plg.12
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLrCUjMS6PpGbtB+8mhXMW1Ydnsrl8bMCJvRUQizels=;
        b=WVmWXqed83hwr0BldYX/afwa2GbpIGZwQjPSy/t/0JCMx9AA3HwxPAEoNSxpJnB0Yx
         fik28dWjsco5sZcynW6vCxEOGuDCcJkT3iUqTzko4G0XSQOOqA+QSRlWvgPkUzZ8V9vT
         4xwMKveUV/iuXskzwET7y/xGFKIkQhDlpaDHWOyGcvlA1O1xIIHo8ciWtrekXQ8bvaal
         alYpuUsz7ne8h38wf9qOthjsznOmfoClqe3jgW9ABNzMY2OCsxJTyAIrylM7Fevvghsz
         UpnlHNCPaziwRwsJVKVa9CXVQb/qVr+HtLg3/tKYpQyECxNGKlOz4xssnXiOuRWJeOcA
         R8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLrCUjMS6PpGbtB+8mhXMW1Ydnsrl8bMCJvRUQizels=;
        b=19x0dO/VM3hJuuHWVz0yEsYcg8vbkRSrjoeh2i6r46Tot+xdWxbKmQ1kGNsPmWSYks
         ot28ahaTvBClveqCs0NRN1hqIT0Sk8P0XexHPDRVKqaraBX6NbCZUlXqaj+VxMXCL88B
         Z0Q0/mw4D4OGf+GiD+D95+JrxzqCMDs3Bc1rMRLwSIbzCPFRh6qnBzV5knhkTCzXLMNL
         5cU82gBrs1OxXiXkpSU1ccfkbcV6cLDHLqipMJ2kznYyEwB+cWvmGL3xbPhIelXdF1ND
         2caiMMoyqQYsueOi3HR/XKwcvm31UI1hNS86wbQwl8WNXF7hewcfFVmBxW0bMlPcPiAW
         EJdQ==
X-Gm-Message-State: AOAM531EyCUSMC5J9ryaySnK9bAE4X9sFK03R5lYCqphRGDj2hOvo5Uz
        s40ac72p5TArp9yszKCZj8GYQ3Q/3u1sEw3NKHm5iw==
X-Google-Smtp-Source: ABdhPJyqO7cyxR1HWTwbNFXiy3gHcuBypDcdwk0AxuecjBTkJfqydJHqiG8cOEwJT7yATjZpuEurgvMIvodG41/Bexc=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr29951880pjp.8.1634329003303;
 Fri, 15 Oct 2021 13:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379785305.692348.7804260538462033304.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211015171507.000010dd@Huawei.com>
In-Reply-To: <20211015171507.000010dd@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Oct 2021 13:16:34 -0700
Message-ID: <CAPcyv4hOyXdoDcVUu8+x=xQCTfQQbafWZwA_wqmHq57K5DpEBw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] cxl/pci: Fix NULL vs ERR_PTR confusion
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, stable <stable@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 15, 2021 at 9:16 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 9 Oct 2021 09:44:13 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > cxl_pci_map_regblock() may return an ERR_PTR(), but cxl_pci_setup_regs()
> > is only prepared for NULL as the error case.
> >
>
> What's the logic behind doing this rather than adjusting the call site to
> check for an error pointer?

Minimize the fix for the stable backport. In the later patches the
cxl_pci_map_regblock() => cxl_map_regblock() conversion goes from
returning a pointer to an error code.

> Either approach is fine as far as I'm concerned though so this is really
> just a request for a bit more info in this patch description.

I can include that note above to clarify.

>
> FWIW
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks.
