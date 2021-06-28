Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC63B5C73
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhF1K1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 06:27:21 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:46703 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1K1V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jun 2021 06:27:21 -0400
Received: by mail-wr1-f44.google.com with SMTP id l8so11824383wry.13
        for <linux-pci@vger.kernel.org>; Mon, 28 Jun 2021 03:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SmBdfLKCfZV12LyrFkBLlq8jZjuWu9ba7nywBlXie/k=;
        b=Tyil3g+w8i+pWDOmLHU1vYXm5Tz6ZTkrsbk1E87HTOaz68XPgD7WuLM/U6U+m1lW7A
         HksBhjaSlUbJbtUrehHig/QTGsEOUpQcEznudTxu1vMCsnJeEkBqtKiTCtphJU8JF9Hx
         yrA2aJydYbHUdvChv+gLPmO2CJdRUAsz638k9dc1gLLUXMQJJgSnvkDlSiDrA/0Dszp8
         ccWIHUPHpoIl0EI1gFD/s69cwB8zc0FOar5rpT9ydsLEgQT1USKVVt/QcPSeyx4ccODw
         0FYkzraNSwR1NUM/eLKV27DyAZzjtIEjbjvhqWNChsMXhk7o09eBzRBgnoU9t2QH1Z0Y
         yl6w==
X-Gm-Message-State: AOAM530BkfRwomTDWJ/J8c5mTXFobQO4tuUNX09WdFCDAmnW6A+LyQoU
        zi37alWtaj6mMVMewgp9yYI=
X-Google-Smtp-Source: ABdhPJzJZ9Z6DMR1QTcxZbubPEfZdm64zcb7Ql8dW/NwJeR3yO6ifFNv9uiqUJPG057rfdzxUG0LrQ==
X-Received: by 2002:a5d:47ca:: with SMTP id o10mr25067560wrc.339.1624875895227;
        Mon, 28 Jun 2021 03:24:55 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u15sm18346223wmq.48.2021.06.28.03.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:24:54 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:24:53 +0200
From:   Krzysztof Wilczy??ski <kw@linux.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali Roh??r <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/sysfs: Pass iomem_get_mapping() as a function
 pointer
Message-ID: <20210628102453.GA139153@rocinante>
References: <20210625233118.2814915-1-kw@linux.com>
 <20210625233118.2814915-3-kw@linux.com>
 <YNmhVQzj4fdgVPf0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNmhVQzj4fdgVPf0@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

> Doesn't this need to be merged into the previous patch to prevent
> a compile failure after just the previous patch is applied?

Yes, it does.  I kept it separate for the sake of review, since we have
sysfs and PCI involved.  I wasn't sure if Bjorn would prefer to have
this done as separate patches or not, to be honest.

Bjorn said that he can squash this when applying, thus I left it as-is
for now - which means that the entire series has to be applied for
everything to build cleanly.

I will send v3 that merges first two patches.  Sorry for troubles!

	Krzysztof
