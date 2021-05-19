Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F04389679
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 21:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhESTV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 15:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhESTV1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 15:21:27 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F61C06175F;
        Wed, 19 May 2021 12:20:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so10595345pfn.6;
        Wed, 19 May 2021 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uMIDYXiQCge+lCPg7jWJZVlhfPYt5aTIXixKF3xFdtw=;
        b=Yg91ASxZAaNzg/r8+0Ydre6wM45Ae3A1iPokHrBnYytUGLfpFnHdf3IFz8HESX0/2+
         g821YtdozGCEBqe5IWPqRoORjgSuvSUsnUJvkFHQmi1Z8EyDysdL0ajJwNlL5xiTuXsv
         wFEKThjSNrz9xGLrgbp/gM/UJUw8aKgxniG4Yn3LJ2CAh4MiM/s09DXVGVwgC1M7Lc1O
         mqFqDRB1Z5q6tLXZhXMkex5oVmrXUvI0/xcrkwhwr72xMCAoZJcgyVejktim5H+sPgp9
         TLPqhl56m5cKFfFNduokObt8ZVxO6KXBoFBtUzi8i8SumVh20RnjYnxygdSMJ5gi3qzx
         uvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uMIDYXiQCge+lCPg7jWJZVlhfPYt5aTIXixKF3xFdtw=;
        b=Dc3geLcgqBcQfWkwlO1vYuYn3/4o9akM2C0EzLHeC5tMz0mxGNk3uAntlFh/O3s4+o
         HOTfsh9GKXRBX6Jt3hm95tC/igb2Hrv/nzK6kdkjOvpXQcz21smeaBc7XONbWmAyNxYc
         HQM6dhqR16hLxw8+5n5DaTg4V2rQlx6uZnHI6J3l1SfxfC3rK9vvOSU0gRwawWTZ2Irk
         f7DZAC77y/PC4SWxj5OwgbReHYK74sTitv66gxcK2MhB5ZFcEO6ECJXX+8+WdNexKO/d
         C6pLyVZMCPW9q+hunoAHVRSupKB7sJtnp4mDIlIkEJVYMLNYV/NqIOfEQz6tI2EPIVVF
         IgNg==
X-Gm-Message-State: AOAM5300hlkX+sMiuvhTYB2ZdO4JL4q5RIBDr66w6RxGKvRgtYAnpEeM
        YyF0SI69CfVx6ef0JLGtlRs=
X-Google-Smtp-Source: ABdhPJylNyq7yX8wc3qiI92uMNP4dk54r6bNs8/LZR+DzeCwuyO2pJ1p5Agdk04xE/qvY5oPdEYXRQ==
X-Received: by 2002:aa7:90d4:0:b029:28e:b912:acf with SMTP id k20-20020aa790d40000b029028eb9120acfmr661343pfk.43.1621452007052;
        Wed, 19 May 2021 12:20:07 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m5sm109361pgl.75.2021.05.19.12.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 12:20:06 -0700 (PDT)
Subject: Re: [PATCH v7 07/15] swiotlb: Update is_swiotlb_active to add a
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
 <20210518064215.2856977-8-tientzu@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6cae5ffa-f31b-ba08-c2cf-4a3dd76afb3b@gmail.com>
Date:   Wed, 19 May 2021 12:20:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-8-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Update is_swiotlb_active to add a struct device argument. This will be
> useful later to allow for restricted DMA pool.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
