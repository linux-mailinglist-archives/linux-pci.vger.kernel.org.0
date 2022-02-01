Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C434A68D4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 00:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiBAX5S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 18:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbiBAX5R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 18:57:17 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E9C061714
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 15:57:17 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a19so11327890pfx.4
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKWvBgsOWpej0zYClHdQnP9nVX7Q9Dikupwbl14Wx7I=;
        b=MOoQ0FssHYYaokVx7KujgLCYFAMMv4AP+5WY84+i8FJMuddPxI2kbY09cbGy662b92
         1UcLQ4UbCwhcvtCHiYqwFu9RAY0dsciqkMB9HMis2+AMwvxFc5wfqJov5Htcu8YMKcNL
         3CdiT9d4mGYmYZFCU8IfP/uToM4KxfzE6xWhhByOWuQ8CN4085oPdGq3xRZNHX2XjIqE
         kfu5mtlI/CfWi/tFdNjlWdl6Ubgl0/BZp9G+l3skv2Z3gkzbAGTOyr1gXOsdlts8vr7P
         2eQl/ayhVPtEDAVfRBc/1rjHqlGbz+PKjy9keBaQE5hQ1dc8Xux9ZF+wPHKIb6UzGaBE
         p9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKWvBgsOWpej0zYClHdQnP9nVX7Q9Dikupwbl14Wx7I=;
        b=Y0msuLV9n55EwpKX1E9/2zw/oA9mfRIcHY/Jz6nByQSESe7RCfxzo/cu81MKjh43p3
         qZRhupVoSr3Rx+fyYAweFo9YMo6M4YOYi7yVVi15DnWcl1ixljgtPfdD//Cv1GJqMD98
         pvOcX98Csj/iJL/D7BFSPqujK0RU57HUto05kzKRyuQ9BPr1JczKs2O4u1DlolYSR2QJ
         EcLB+Af0+1m8thMJrVwtX+cyiwneCofn930YHkZHLnSs0Fxej5ShsK/tm0pyeevSg8Sr
         +LwL8uW4RPCEgCttFb7kVeo72chdtBNakW3LUPYrJYLJI3sZ5WBEl8/Oud+6fSEqfMah
         4+jw==
X-Gm-Message-State: AOAM530gFM2vjXkt1VVWanKkL287q/BqBDRW6maux+LHKfxvMeU10v5A
        2TVVOc8j1kC+tbpXC7BFIKnFBUS5UsEHIAn0UwKYkOazZwo=
X-Google-Smtp-Source: ABdhPJwDHic741AiY62VdhZ8IkHnFn3u4W6ArULjeKlwuXnvNJecPT/0JxNtWKYkU0aKk/Zl0E/LRlEuiy0r1ikCKtk=
X-Received: by 2002:a62:784b:: with SMTP id t72mr27614119pfc.86.1643759837270;
 Tue, 01 Feb 2022 15:57:17 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131184126.00002a47@Huawei.com>
In-Reply-To: <20220131184126.00002a47@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 15:57:10 -0800
Message-ID: <CAPcyv4iYpj7MH4kKMP57ouHb85GffEmhXPupq5i1mwJwzFXr0w@mail.gmail.com>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 10:41 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 23 Jan 2022 16:31:24 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > While CXL memory targets will have their own memory target node,
> > individual memory devices may be affinitized like other PCI devices.
> > Emit that attribute for memdevs.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hmm. Is this just duplicating what we can get from
> the PCI device?  It feels a bit like overkill to have it here
> as well.

Not all cxl_memdevs are associated with PCI devices.
