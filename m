Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47EC30B251
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 22:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhBAVwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 16:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhBAVv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 16:51:59 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B5C0613D6
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 13:51:19 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id e19so12540919pfh.6
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=X0Q/ZUQ4hKoawWN2B+locX1+Bltm6iYAtS5TX76PGV0=;
        b=JcEV6HVaeDaOOL0h5jY3uy6ve5Oys0MQOJ9U4nasE04exuRtFZbJpOIHVfWoYfle1J
         beI2sJhpCMqlNBKLZqSCeIYmtH728isIhOBGfVtCVebDEkV58CsHbbdI/9BFXOpwyhgi
         sPhuhxrbexd8U7yQKn0cHEHOHWqmMJ6kjMVmVst139NVTTYL8tb2UsrBxT/gZPOJhQTR
         bK3XnLbP8oRFa2gAPWEvZAP1vvQ7NrTtztwvuzEw5LaDNbCmxSFGSwPCx7byOdJRUt9C
         YTDIaUOkG8VOT/SQRV6U7po3pLvDqhE6/hv92a8C2KiIxOr0CrEWaO67fDJMNiOEuu4f
         93zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=X0Q/ZUQ4hKoawWN2B+locX1+Bltm6iYAtS5TX76PGV0=;
        b=Jp5TvMBS3QWLt+0QY5oGyVD3kFVDmZsnx7y2cHXl/ab68AabcOCtrkg3ORup881frt
         Iv9/g62OYMxcEc5+SLqahirXQwm/YJzu6zaxvAzgQKvelH8P0euEL+WUvLps9wjj15ZF
         wAOs/tmbQsK++Q1CAVgJr8+58WvzZRhn23PHXO0ThWhR3Ecgx7AsVraPVC1IgADuTqWc
         2IpRm1vmPEh7YZtvYyFnFp/xTc5US3yjBTKML//ZtHnwh2a9DShUqulXFtVRcHhtEwAK
         Lqxq+tblqOix1xo7mxj75ig9GJbxE2lu4XY5xBBaGwNGFyhLMsvmOQUXhsnIXxLZ7mTK
         nVkA==
X-Gm-Message-State: AOAM533wrlC68mAguPObYwMQ6+UbK01dCZ7h8aa4ekEiFrhRuhbt4NaI
        jinjHeMfHEBj0CJL9uOHSFLAkA==
X-Google-Smtp-Source: ABdhPJy0F0JZ9njhCDrVgT94zzxXJpyJDDqlsbZrnmv0MJhPc/jsWvO86HbtsOo2O3onCME70FZzTQ==
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id v11-20020aa7808b0000b02901ce8a32f5e8mr3097800pff.34.1612216278371;
        Mon, 01 Feb 2021 13:51:18 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a72sm20075000pfa.126.2021.02.01.13.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:51:17 -0800 (PST)
Date:   Mon, 1 Feb 2021 13:51:16 -0800 (PST)
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
In-Reply-To: <20210201165352.wi7tzpnd4ymxlms4@intel.com>
Message-ID: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com> <20210201165352.wi7tzpnd4ymxlms4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> On 21-01-30 15:51:49, David Rientjes wrote:
> > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> > 
> > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > +{
> > > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > +
> > > +	cxlm->mbox.payload_size =
> > > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > +
> > > +	/* 8.2.8.4.3 */
> > > +	if (cxlm->mbox.payload_size < 256) {
> > > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > +			cxlm->mbox.payload_size);
> > > +		return -ENXIO;
> > > +	}
> > 
> > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
> > return ENXIO if true?
> 
> If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> driver not allow it?
> 

Because the spec disallows it :)
