Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CC137B618
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 08:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhELGaw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELGav (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 02:30:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ED1C06174A
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 23:29:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id c22so5165022ejd.12
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVKY/8OJFn/AVdYg/I2U6wFa/UltzqiJOYIbxas+wEU=;
        b=yYdoQ0XOKaW4HcjPMnq93wc7+gItMahnbROPanX3KqYLjQuDGmimm7lbH816+fbqhn
         kci5LkuqFtzFZI4hjsKtNQe73fB74qX8p43uQ5/mhHSj1HbkfzNbYcsdDXEWii6tJX3g
         jiMOqiQeX/XT7ldlFlcutczVHa/kStKJhOdk0RFSBvQeQyne0fkF/DPWR3N+mCF4felH
         pll/YYLAz87XWt/AE7w8oMIb6FC7rpeJDlTQtJ/qVfHkN5fHWdJuWYfP1GF5jTfL/OFl
         KTecmwaX5KB7rbu5U0i+nOEZeMBJ1F4gfTgcR9fvKLaDmhYrLK8b+0U3AerOFqEpBaur
         N16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVKY/8OJFn/AVdYg/I2U6wFa/UltzqiJOYIbxas+wEU=;
        b=fUyeD301YwESH5NRnsj7ftQbTvyhuKRSYnzVp1On1yiEu45Y58cCVAqvKA0Ft4m0wQ
         pE6vKL/1ZtlY8aT+oufPmehMvNyBLn54Sq0t9R3bT81ziHCSgCbeIjiJpwzoaO48zz8K
         uc3d//QNnkLEt32R/ap7HcySrjto8xj7HnI4t243ktfIqDeGA8HbjTb2B9T8MmD3z8hW
         H+Icd6RR0xVv+QxH7yp9gfof0g2UnkOjMdMCEXllKTyNOvkN1+7Pxtazn59c/kGmQM4K
         3SB+S6aOY3GA2/6pNYmBdC29GLAZnEbwdBDDFA0C3ORl4wk6XyHLQHZDWPi8nC+7FJIl
         atyg==
X-Gm-Message-State: AOAM53317jn3VnU60JHf5+kybRtdXJpwW/281+UjN40vRoFd7Rk+AocG
        6TAFCA+FsxjzCmJgndxDOoeUMuB3xuxqJbjNA1Sg7Q==
X-Google-Smtp-Source: ABdhPJzYbY/R0qqrV0pXjUABpIJ7ACdERRMeCz+5DyaWf4VP+kWWFYuoNa0frLSCJSlRglFL14LyI/CnlB0EiIs4wI4=
X-Received: by 2002:a17:906:bc8e:: with SMTP id lv14mr35714177ejb.418.1620800982974;
 Tue, 11 May 2021 23:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162042790793.1202325.13507889482183963289.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210510155615.000001fc@Huawei.com>
In-Reply-To: <20210510155615.000001fc@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 May 2021 23:29:32 -0700
Message-ID: <CAPcyv4hhYJsTaRbCXKQaHWw8KwfOFxa-pG4x2r8HCYqVTshZCA@mail.gmail.com>
Subject: Re: [PATCH 5/8] cxl/acpi: Introduce ACPI0017 driver and cxl_root
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 7:58 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 7 May 2021 15:51:47 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > While CXL builds upon the PCI software model for dynamic enumeration and
> > control, a static platform component is required to bootstrap the CXL
> > memory layout. In addition to identifying the host bridges ACPI is
> > responsible for enumerating the CXL memory space that can be addressed
> > by decoders. This is similar to the requirement for ACPI to publish
> > resources reported by _CRS for PCI host bridges.
> >
> > Introduce the cxl_root object as an abstract "port" into the CXL.mem
> > address space described by HDM decoders identified by the ACPI
> > CEDT.CHBS.
> >
> > For now just establish the initial boilerplate and sysfs attributes, to
> > be followed by enumeration of the ports within the host bridge.
> >
> > Note the allocation of CXL core device objects is split into separate
> > alloc and add steps in order to separate the alloc error path (kfree())
> > from the device add error path (put_device()).
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hi Dan
>
> Just one bit in here that confused me (assuming I'm reading the code correctly).
> You have is_visible for the dev_attr_supports_pmem etc to only show them if
> the particular space supports that memory type. That's fine. You also have
> the actual sysfs function checking the same flag to decide to return "1" or "0"
> which would also be fine, but in combination it's rather odd as the sysfs
> read function can never return "0" (sysfs attribute isn't visible in that
> condition). Probably deserves at least a comment.

Ok.

That was deliberate since it's trivial to code and allows the
visibility policy to change without needing to go audit the attributes
that assumed invisibility. However, yes, it deserves a comment to save
brain cycles with that "hmm, that's odd" in the future.

> This also needs some documentation for the new sysfs ABI
> (Documentation/ABI/...) but that can be in a separate patch.

True.

>
> Otherwise looks good to me.

Thanks.
