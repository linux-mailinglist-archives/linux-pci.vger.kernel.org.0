Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781B21D4D7B
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 14:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgEOMLh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 08:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgEOMLh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 08:11:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F0C061A0C
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 05:11:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so3283847wrr.4
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=agk/UV20FKJb1a9Ae3ltu4rCzUn8RKE17XB/I2juUP4=;
        b=JAA3HOUQkZNQ5tgh0mBb8QhPLgNWLKouFcUBPxDtnimi/m5pBrCEkujCkn9WxFBeqo
         ErHwhzIj4ddXEo7xzOPe8Rc57zZOcaT94w0056MbMo41lOLkETzul319Ley474NnQh+F
         8bdvV49MZN6vQczqFvGdH1QS2jXgL+rTLszQRyjTnKs6V31vhKqdKkuosC0DpM/KeXbD
         TYl2/1AuayujwtiK321gyz6laoHA/yv7w8eYv40EaVs+H7ItH1G+InjvaGmhzUyWtZLW
         ZKd33niBQ6nWQiyCZ7sjsEnWFWlKgmv37OKJCdNGO2o16ayD0NbkG9SzJzxIXBUPVD5z
         uEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agk/UV20FKJb1a9Ae3ltu4rCzUn8RKE17XB/I2juUP4=;
        b=EIHEIql8z4E/ZLEi3+DOzqrs596LlQHOVBodl1awskP7b2lXIyFDvRuqj+G0x8fMnF
         rkD/88QcwtKhd3zK8gZZrwcDyYJDF1S2jyTnHLcVeGnbu2oFvu5gAqeOajBEXYOXTa17
         Nu6gKIeFX97ZraCdVXN/WFK93FvlR6JxizV8/8OHa9Mc/s4jxBTz6t7Y1/xJnyhnRKk1
         zyp+iUchNAv0prFOIsZhsXLatttnwe/H15BA9wWytbJ3VQDfi21CdAhBXusfNG+YvxGf
         BM9QyaDzpk3OAIn04Byv/zlV6wruIF1jnRcEzScUSXxY/+4dv9+fMt5bv5976BfAbxq4
         X4Uw==
X-Gm-Message-State: AOAM533rUoW1zs+IVWUJdO0CeN4Ez//9cIvF6IHGVCxCwWYI5IXxUueq
        SqQami/pQbtHVGfj2IfsLnka7g==
X-Google-Smtp-Source: ABdhPJySrffUnSNQVxZ4+5EcEPpnx2BcRy+rX17KVduf39fOlhtS3S6VeNRSKTYDyFwHQHp61SI0Pg==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr3883139wrw.319.1589544695178;
        Fri, 15 May 2020 05:11:35 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id y3sm3305545wrt.87.2020.05.15.05.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 05:11:34 -0700 (PDT)
Date:   Fri, 15 May 2020 14:11:24 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhelgaas@google.com,
        will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        alex.williamson@redhat.com
Subject: Re: [PATCH 2/4] iommu/amd: Use pci_ats_supported()
Message-ID: <20200515121124.GA784024@myrica>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515104359.1178606-3-jean-philippe@linaro.org>
 <20200515120150.GU18353@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515120150.GU18353@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 02:01:50PM +0200, Joerg Roedel wrote:
> On Fri, May 15, 2020 at 12:44:00PM +0200, Jean-Philippe Brucker wrote:
> > The pci_ats_supported() function checks if a device supports ATS and is
> > allowed to use it. In addition to checking that the device has an ATS
> > capability and that the global pci=noats is not set
> > (pci_ats_disabled()), it also checks if a device is untrusted.
> 
> Hmm, but per patch 1, pci_ats_supported() does not check
> pci_ats_disabled(), or do I miss something?

The commit message isn't clear. pci_ats_init() sets dev->ats_cap only if
!pci_ats_disabled(), so checking dev->ats_cap in pci_ats_supported()
takes pci_ats_disabled() into account.

Thanks,
Jean
