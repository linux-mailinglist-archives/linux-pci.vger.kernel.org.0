Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4FA30B477
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 02:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBBBKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 20:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBBBJ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 20:09:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01C9C061756
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 17:09:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lw17so795658pjb.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 17:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=pNCTQ+GJhIhHpTNwwogRL6Yi/0jouh3mFkQQjXxphC8=;
        b=KnvUvAZHPhu3r6Yh7bIMIXCYLeRudcUaDGZlu1gyzOjzIwWPZXs8tIgfnVHSZYL4R6
         ZaY41xp4cjstE99q+drLELvzoA1XGHVs4Ci11M7UyrGpT8Nu2TajXHUBW3ajbAm05IVL
         Uc1sqaK0T8c9Vj7ws6Awhl9unwhQJaY1aj5/TAuTWPLRT5b+rqpXJ+3+H0h7kiXg3dpr
         7/7EBCmXMa8/T30kzfk8G/z/nlCocltuHltX+HW4agnpVtcRw4MIeEW66iCxkgKOpnDM
         eXXiMSm/x+Kakf/k1msvZiFbMreUy3rP9qvrpiaqgnTcDX44PtQMQHTIynkX39EYorin
         sdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pNCTQ+GJhIhHpTNwwogRL6Yi/0jouh3mFkQQjXxphC8=;
        b=Geoy+LGRcRc2owL8HsQWWmd0iMRZWBKeAV2tlGmyzrKrJxKiIfaPdPF1ORmJ120eQA
         LpdbQkcqIbJgIYvH9XCBz0vsfhBcnZBMb1F5tRGCZd44g/F++uIXdbc+lpNMdC4sHODQ
         Aw+Ys5BFKsT24o4KkEjTooIXeM/8ylRCleP9yRnpbspKKHSXYovouL4d2YY/lVU89Ng3
         14VHwNwKQ8+LcdTmY6WSQDJVXo1BweorPWH89ao4BNxcM6vU7sYYmmBSBVihHK1qUQQ9
         toaJ4bqCp+pcmCx1s5uyfvnnZBTaTzq0dKhju0NDmumL5e5qZJJ1XuNFXxaF1sCpIhGg
         t8kw==
X-Gm-Message-State: AOAM533SzgWpaxNaE/rLvjZuIBqj+2pWNH6juaUSbuo8o85gcUmCBPIc
        4Cw92+dNBZTgTSjsf3b89YMiPw==
X-Google-Smtp-Source: ABdhPJyMh8u3GTa8m7YFZfJbDC7xX65+VnYP+upZQGZBqpSgFHhwIl7QJrf8YVKXSX+s6Zeew7AAiA==
X-Received: by 2002:a17:90a:7e94:: with SMTP id j20mr1621007pjl.218.1612228159179;
        Mon, 01 Feb 2021 17:09:19 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id r21sm20536846pgg.34.2021.02.01.17.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 17:09:18 -0800 (PST)
Date:   Mon, 1 Feb 2021 17:09:17 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
In-Reply-To: <CAPcyv4jRVDdZyqH_eL4jjRvbCOEpO_UMUZdXbtevsY6PpcRq4Q@mail.gmail.com>
Message-ID: <26a3b4dc-8872-3547-33f7-20cbd6cd981d@google.com>
References: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com> <20210201215857.ud5cpg7hbxj2j5bx@intel.com> <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com> <20210201222859.lzw3gvxuqebukvr6@intel.com> <20210201223314.qh24uxd7ajdppgfl@intel.com>
 <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com> <20210201225052.vrrvuxrsgmddjzbb@intel.com> <79b98f60-151b-6c80-65c3-91a37699d121@google.com> <20210201231718.2hwaqgn2f7kc7usw@intel.com> <a789317e-2ac2-10a1-dedd-1851972e3d6b@google.com>
 <20210202001120.vr6mos7ylnbqytxh@intel.com> <CAPcyv4jRVDdZyqH_eL4jjRvbCOEpO_UMUZdXbtevsY6PpcRq4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Feb 2021, Dan Williams wrote:

> > > I don't have an objection to binding, but doesn't this require that the
> > > check in cxl_validate_cmd_from_user() guarantees send_cmd->size_in cannot
> > > be greater than 1MB?
> >
> > You're correct. I'd need to add:
> > cxlm->mbox.payload_size =
> >     min_t(size_t, 1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE), 1<<20)
> 
> nit, use the existing SZ_1M define.
> 

Sounds good, thanks both!  I'll assume you'll follow-up on this in the 
next revision for patch 7 ("cxl/mem: Add send command") and we can 
consider this resolved :)
