Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10FB276EBF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 12:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgIXKaO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 06:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgIXKaO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Sep 2020 06:30:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2934C0613CE
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 03:30:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so3177608wrw.11
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2020 03:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=znzUeIRH1ne+QRXgI3ldPbArevzy1R8C3LyhHivzoF4=;
        b=qk0VM2b6qYCdVzwHNTA9pKcSI+q16THf//P5w/CjrxapWjynBG3uVUmYe+J1sMZrD/
         LNFbCu9JUK3q3nJyk/a+Q/nNFSrtAf+aOAdGDrjB/f/tlUzHyZk/e6HukMxXwPLS7wPd
         5TC0ccHevIrMKtFwr/rlDrNFYEC/WVtzjHiflol+lbiYXA9RqRnLc9PIx+e5xCj2sBcU
         tsXixF8PPr0KylfAkv7YzHuF/9fK0i3DmlIfoOrVqPNPtKaWQo89vT4NiDUmWPXW4pZJ
         d3TdFMZmu9s5ySjxM2xo0mvbDN7TtxQwB6/sbF/JPVKo30rQtdBO+LMDkQmSJJOcrkTM
         Nucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znzUeIRH1ne+QRXgI3ldPbArevzy1R8C3LyhHivzoF4=;
        b=kkvqSmf1M5pr9Rdt2PIQijPA71IpETjnxGQiUV5TJ80MKKRZz766uiIorjJLh70+1m
         atfS2Xva1Otrl7dnLMstM1dEFhLqhE8d9wygAZgcVi/9j+CRhGbGJPNrIlRfleroJ84N
         EoznfgGLrn31v40KjW8Ic20Yue3hEv3VRUYwZ24B6UysZyUBV6ffoy8uf2zDX5yR/Kas
         zfcdXUlAMXE2vw310NdiezdGG3mm4jnzbD4bt2I5GfGsn/LUR2q67a+HJAEKbLw04+5z
         VlsghCfPtaBSa9Q7nDxRhiFfH8SY9mZC1kMTFpal5xkFALtwfrfpKfd8gE+EtjQxMTgr
         otzA==
X-Gm-Message-State: AOAM5334OgaWGkKc+PBNC4yaLAvMscXXeBnc8Y7u9QFmMtiXFpwFaDQo
        BJBGVu23gjtjDed7uSMW6nn11w==
X-Google-Smtp-Source: ABdhPJxtACZr7VVPwp22Cf6DNucqOWM3y2OALl52UMDzWmOMP+EbGgfCzGceL1CMmGKZg4tjOTJEFQ==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr4274207wrr.414.1600943412498;
        Thu, 24 Sep 2020 03:30:12 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u126sm3619614wmu.9.2020.09.24.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 03:30:11 -0700 (PDT)
Date:   Thu, 24 Sep 2020 12:29:53 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200924102953.GD170808@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <20200924100255.GM27174@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924100255.GM27174@8bytes.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 12:02:55PM +0200, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:38:13AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> > > > OK so this looks good. Can you pls repost with the minor tweak
> > > > suggested and all acks included, and I will queue this?
> > > 
> > > My NACK still stands, as long as a few questions are open:
> > > 
> > > 	1) The format used here will be the same as in the ACPI table? I
> > > 	   think the answer to this questions must be Yes, so this leads
> > > 	   to the real question:
> > 
> > I am not sure it's a must.
> 
> It is, having only one parser for the ACPI and MMIO descriptions was one
> of the selling points for MMIO in past discussions and I think it makes
> sense to keep them in sync.

It's not possible to use exactly the same code for parsing. The access
methods are different (need to deal with port-IO for built-in description
on PCI, for example) and more importantly, the structure is different as
well. The ACPI table needs nodes for virtio-iommu while the built-in
description is contained in the virtio-iommu itself. So the endpoint nodes
point to virtio-iommu node on ACPI, while they don't need a pointer on the
built-in desc. I kept as much as possible common in structures and
implementation, but in the end we still need about 200 unique lines on
each side.

Thanks,
Jean

> 
> > We can always tweak the parser if there are slight differences
> > between ACPI and virtio formats.
> 
> There is no guarantee that there only need to be "tweaks" until the
> ACPI table format is stablized.
> 
> Regards,
> 
> 	Joerg
> 
