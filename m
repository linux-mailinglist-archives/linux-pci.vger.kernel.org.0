Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0330B324
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 00:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBAXK3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 18:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhBAXK1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 18:10:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22F4C0613D6
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 15:09:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id kx7so684815pjb.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 15:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=3HKABxm2JWW8yXh6Ffuihg4FZgaqjfZi+45jOX+PQQI=;
        b=CcU5cvGUtNpEhVt6Zcu4H5EeWpk+/H7fNLUyevjipbJe31ZbS4kC70stdBy+qRxQuX
         bQGTv/PsDN4g+kKCAXTRJfbaPcAtLtu2g2G7PO0ZEND64tDUuXyPxUHFrUWJ66sQXEKP
         y3nKIvO2CMT9m1Olk6z3pOtYMHnAFGKkus3f9QjH3SfZp3FRkqDGNKcVfBUjYt90JoV5
         PdCs3Zv1/l93Y4WGYJkTJfGuv2R5x64VDgt169TQMxHy81iven1IoQp9Pa1PwE/KPrFi
         owifCbIqzF5y9eiPUjgAXKU14kbZ4PlsribJAgzQV9UBoTMLxogxbFT1vqrRtcyn+Nxm
         BmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=3HKABxm2JWW8yXh6Ffuihg4FZgaqjfZi+45jOX+PQQI=;
        b=pWjXqCboWhrGCsUvxhn1VzGLFu8BZzJksOP83hQuOundoc9oGIaVwcZIq5VDCibyxx
         rPjG8wGOpo+DJg3uB2xV/GSuWQfV6aYdwcJv9faJ7MxPrVnlAMBML91+d8gmBwUIJRVh
         jP56c99vM2Z9qM8AN5WhAyb7uVOzrVTrAli/bRVkqHtuj26Ek6nqRcEaV+AiaVe5IEgF
         Cly68ivpule6+hg182B59wYIqLb/PJyhlwvT2FA5IGpT8/awAp0kitPGrW6DiSXLe7ls
         Aw5QOWCFKZhV6jYf/SmSAG7FqSrVwmcO1ZF1Y8S5UL+qE1xczKMRtEdjMi7+R9R/oF70
         9gVw==
X-Gm-Message-State: AOAM530zmbT070xHCXar/d0GFRIUzXC5+l95pg9Zqj0C1Ve/y7TQHLSW
        8/wPxHFnAaCOTcWTwAXIIVqlHw==
X-Google-Smtp-Source: ABdhPJyDaMvGR69SgB9QhG+gcyPBnwjWdXTx/YCd/XS+/X4S/yx5a3E3r1Y0cpZQ0HRKfgAXvzW+NQ==
X-Received: by 2002:a17:902:70c6:b029:df:d62a:8c69 with SMTP id l6-20020a17090270c6b02900dfd62a8c69mr19315852plt.20.1612220986962;
        Mon, 01 Feb 2021 15:09:46 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j4sm13872905pfa.131.2021.02.01.15.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:09:46 -0800 (PST)
Date:   Mon, 1 Feb 2021 15:09:45 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
In-Reply-To: <20210201225052.vrrvuxrsgmddjzbb@intel.com>
Message-ID: <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com> <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com> <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com> <20210201222859.lzw3gvxuqebukvr6@intel.com> <20210201223314.qh24uxd7ajdppgfl@intel.com> <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
 <20210201225052.vrrvuxrsgmddjzbb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> > I think that's what 8.2.8.4.3 says, no?  And then 8.2.8.4.5 says you 
> > can use up to Payload Size.  That's why my recommendation was to enforce 
> > this in cxl_mem_setup_mailbox() up front.
> 
> Yeah. I asked our spec people to update 8.2.8.4.5 to make it clearer. I'd argue
> the intent is how you describe it, but the implementation isn't.
> 
> My argument was silly anyway because if you specify greater than 1M as your
> payload, you will get EINVAL at the ioctl.
> 
> The value of how it works today is the driver will at least bind and allow you
> to interact with it.
> 
> How strongly do you feel about this?
> 

I haven't seen the update to 8.2.8.4.5 to know yet :)

You make a good point of at least being able to interact with the driver.  
I think you could argue that if the driver binds, then the payload size is 
accepted, in which case it would be strange to get an EINVAL when using 
the ioctl with anything >1MB.

Concern was that if we mask off the reserved bits from the command 
register that we could be masking part of the payload size that is being 
passed if the accepted max is >1MB.  Idea was to avoid any possibility of 
this inconsistency.  If this is being checked for ioctl, seems like it's 
checking reserved bits.

But maybe I should just wait for the spec update.
