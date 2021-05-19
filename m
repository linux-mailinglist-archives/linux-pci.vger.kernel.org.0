Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E35389674
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 21:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhESTVK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhESTVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 15:21:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41172C06175F;
        Wed, 19 May 2021 12:19:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x18so6295529pfi.9;
        Wed, 19 May 2021 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ghVDOoMvorTJdaMzHQG/RIv5BmHhyL6sw4dTSHsJEnU=;
        b=rcLYOAKu9u/Pk2N2pIINoWg7Qql5CHIaTXPW1rmbbrFNRBJ17e6P88xZ/Yr3+K40Vg
         KFK9I+oMG/IgtitN6mi8iqL0UX94lczwdh7i0nBMb8jue1bBvD+G4ynJruy5PLRKgM8v
         188V9tFxrPE9B0B1aPKzXgftN+LtzT071WIlfZD+1U+hRwMChhgRPMvMzKYVh5Q7yJyY
         X233KhJbv3QXKhh18IR7fU0ZBHQkRzKr/brYbrWfvUGYpz9WfdE1CfhVQ0XA+pTrnR5x
         VWSQyHCExyqYP4xFwbo2E8+nGlIJeknoGezPntMeUW6YyiidoBVXS6cxaKILk/O3+EJK
         3+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ghVDOoMvorTJdaMzHQG/RIv5BmHhyL6sw4dTSHsJEnU=;
        b=nICtDM04omddAtCJdvUelUJoNbXsPI60cfBddDsnd5i2T4sB+H2PTDQGh8BtSUxJ67
         9He2t8F0Ex7N67Lcg4ldaeoHfGSn+5GgPEw1JanTL2u8fMcIOBCUgk+7+ujxtdbJtcXm
         m5E2+iqxp64LVbQ1Km2N772wJ2fum8EHymwtC65jN1nnYddOWcFtnDUC/frQOmkdBrqI
         kYzwcZGvWP4EYTRzFjF7haxqv/6euqxtiVSuarAG11q81rhzrBmscyKxtCtJrqzgx43h
         WmLLwggm6xwJ5ZJhVYPnjQjorSSRNTRe+GyCm216HpdIrn7k7PqgJDXBWOqjBWaHFSai
         o8tw==
X-Gm-Message-State: AOAM532nNCk7UYLpcoNMje1m3qi2LcqNo9ONFVAEKymVq5sWGokPW+No
        7lsc9P+8CulKQ/nJMewcgyk=
X-Google-Smtp-Source: ABdhPJwjgDsBVD45dTtfq/CuwPFV8Nn9xvyX5u2jGlIQAuONAFWU5ZnSLNw+gRQXo9RnVxq5dGzq7g==
X-Received: by 2002:a63:4e01:: with SMTP id c1mr645397pgb.265.1621451987803;
        Wed, 19 May 2021 12:19:47 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y66sm128104pgb.14.2021.05.19.12.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 12:19:47 -0700 (PDT)
Subject: Re: [PATCH v7 06/15] swiotlb: Update is_swiotlb_buffer to add a
 struct device argument
To:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-7-tientzu@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e825f332-eabe-4a82-1528-8bc9d1e60625@gmail.com>
Date:   Wed, 19 May 2021 12:19:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-7-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Update is_swiotlb_buffer to add a struct device argument. This will be
> useful later to allow for restricted DMA pool.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
