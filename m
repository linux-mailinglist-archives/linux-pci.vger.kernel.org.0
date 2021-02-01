Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D2130B2E8
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 23:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBAWpr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 17:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBAWpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 17:45:42 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52F4C061756
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 14:45:02 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g3so10921784plp.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 14:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=h/+HtgkOHaN53M4LuNqNMv860b//jMIWAHV66x1z8DM=;
        b=GCYQ0iKIZ9oD9vYcGpW5ZOQ/O5nsYJSqzH5AGdGh8eOBnUbO6bzHxqCPwFibUMOW5J
         i/w7oZoci7HhotmzTmg6VKuWbBghTXOATU21p4KFsx3EI2N3eD4xRD0Jaj64e7I5CGgG
         HZKTkMSvUMXMQt6go7kszGvPeXEy6wyy37gpj80BORjuITag5J5qdaFP9Fwc9O16AcMY
         axE/+WMqnylWtL9wbd6HcYk8H7xDqgyvn176ixZnqnox96WzBVqZ1ttTU8b3K0KAKTIw
         a7Uuop8cPXJbIrsFx1taMhJglMPxhVjp7GqGA3mdcEnJCf2euWI3cnmdOAcZDfTLMW/X
         Wc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=h/+HtgkOHaN53M4LuNqNMv860b//jMIWAHV66x1z8DM=;
        b=C+zknAyhz4Vy6OsI/Xm52PYWkllcf7YqI5yVJUyEhRT6Lovt332tVbFnjr9s+dsKfL
         JXP0I/GS9GwhoLzGv/spl+GT1QXovDB5yP+qRl99qRECXTKp+osgKA9ndMUwORAHbhwL
         BiEm96paMRynMrEw3e4xZGuWcu+n0r3bxxtcdrIDO0dIVGNBQfKji/0CFm+T4vyCkZ4b
         L65liMZzBm34T094WYbLUufuusEc5EoWb1ELpPFRgpPuJG+P9uyDmh5L+MJ+QF1UHJjK
         ohIxSZnuS0Ct0RRaKNS60J2WWLuFzNq7YJM7Qw/V1lsxOiVHF80KOkoVxHqOl9DffFLL
         d6pg==
X-Gm-Message-State: AOAM531CYk60Zkf2L06+CnZJZPwpqLg/48QlQib2ZCbV45xqsC8PzgYw
        nbNY0rqbN9iVWlQ4sviUOP+zPg==
X-Google-Smtp-Source: ABdhPJyJ47lr3Kq80ShKHqSYCwGpldSX1NZjSC/Cxor1NIJVsIbwCZeAm8rz7/bdlWk2Ic/PD+uHrw==
X-Received: by 2002:a17:90a:bf06:: with SMTP id c6mr1053237pjs.220.1612219502048;
        Mon, 01 Feb 2021 14:45:02 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id b17sm19787823pfp.167.2021.02.01.14.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:45:01 -0800 (PST)
Date:   Mon, 1 Feb 2021 14:45:00 -0800 (PST)
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
In-Reply-To: <20210201223314.qh24uxd7ajdppgfl@intel.com>
Message-ID: <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com> <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com> <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com> <20210201222859.lzw3gvxuqebukvr6@intel.com> <20210201223314.qh24uxd7ajdppgfl@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> > > > > > > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > > > > > > +{
> > > > > > > > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > > > > > > +
> > > > > > > > +	cxlm->mbox.payload_size =
> > > > > > > > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > > > > > > +
> > > > > > > > +	/* 8.2.8.4.3 */
> > > > > > > > +	if (cxlm->mbox.payload_size < 256) {
> > > > > > > > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > > > > > > +			cxlm->mbox.payload_size);
> > > > > > > > +		return -ENXIO;
> > > > > > > > +	}
> > > > > > > 
> > > > > > > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
> > > > > > > return ENXIO if true?
> > > > > > 
> > > > > > If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> > > > > > driver not allow it?
> > > > > > 
> > > > > 
> > > > > Because the spec disallows it :)
> > > > 
> > > > I don't see it being the driver's responsibility to enforce spec correctness
> > > > though. In certain cases, I need to use the spec, like I have to pick /some/
> > > > mailbox timeout. For other cases... 
> > > > 
> > > > I'm not too familiar with what other similar drivers may or may not do in
> > > > situations like this. The current 256 limit is mostly a reflection of that being
> > > > too small to even support advertised mandatory commands. So things can't work in
> > > > that scenario, but things can work if they have a larger register size (so long
> > > > as the BAR advertises enough space).
> > > > 
> > > 
> > > I don't think things can work above 1MB, either, though.  Section 
> > > 8.2.8.4.5 specifies 20 bits to define the payload length, if this is 
> > > larger than cxlm->mbox.payload_size it would venture into the reserved 
> > > bits of the command register.
> > > 
> > > So is the idea to allow cxl_mem_setup_mailbox() to succeed with a payload 
> > > size > 1MB and then only check 20 bits for the command register?
> > 
> > So it's probably a spec bug, but actually the payload size is 21 bits... I'll
> > check if that was a mistake.
> 
> Well I guess they wanted to be able to specify 1M exactly... Spec should
> probably say you can't go over 1M
> 

I think that's what 8.2.8.4.3 says, no?  And then 8.2.8.4.5 says you 
can use up to Payload Size.  That's why my recommendation was to enforce 
this in cxl_mem_setup_mailbox() up front.
