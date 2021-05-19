Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D498C389602
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhESTBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 15:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhESTBb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 15:01:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C537C06175F;
        Wed, 19 May 2021 12:00:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v13so7576777ple.9;
        Wed, 19 May 2021 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bliAyPcCTKuHaZYRIw5XXZxaaB4NHvg1JF88TNVLe3Q=;
        b=TKwRdnu4+Sp1YkQdeC//ZaZe5gFK1OBbc6fiWqiSSxtaemxo8tsS6cyyKonvkggi45
         AkmXBkDwPjivTxMkW/6u87n74jtYP0vz5yoiKDWAMEYfh+QJdqbXNMoLboJ95qsaB+Sz
         evhXDQC1zkb888kY45tuzx3cOkf8aRLE0tysepxM3+bqwCkk54R2Q027+/7CcS0ORj65
         6mx2ltgEPNZ+I2TPARzQB2NU/eRypDG4kJedWyyBabBiqBkk+XEYxHjO+wV8NZqkj5Xb
         Wiz3FWUYSWAt8nsw3SelNmNlkX4sXNF7RuifyB1BY+CyHdw4EnNC9bgPveVhRQQuluiO
         dhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bliAyPcCTKuHaZYRIw5XXZxaaB4NHvg1JF88TNVLe3Q=;
        b=KYCvyZNoCJ/eGKTLfOfohe+IoAHSG95SQahDMdskrAdRmSd9Pgs/THED6oO1cUm6ZC
         SkJfyLNICnbaMHAH/GaICtuZjLGAbix6PzzHXoJdZMcg8l9BBGd63xCnZPEjT+47pQN+
         c7fXtXcberO+KPHRmkmAOhS0TsHOQ1T/GMnmpNOXCykvFeX1Aj2BtDWAWB6z9j28u+N0
         Qu36Nor/OskkWFc6Y4BOKjCCMofAhLAoY2LRfwDEglEgrHGhC0/43muhCDv/eYTzBThf
         C/sflR43Um1ZodZsj3mGRij+eUNvqw3ObaEVEgo2t19toFdPBZvwQoWpEig1XdRxKXV5
         k8MQ==
X-Gm-Message-State: AOAM533Wf9OAleiEY1Pa6ZakDcCfmR1nWZXn86wjK5obEkuZRXNipQ5b
        KO7Tyo4XWKk2QTeP7j7mVvg=
X-Google-Smtp-Source: ABdhPJzSFi5vywroBZ7tSNHRQs1V9GPTz+dOSZzWMkXvwkz7CoWyRh73gQHWXYp/m+DT8rff9721jw==
X-Received: by 2002:a17:903:10a:b029:f4:109c:dc08 with SMTP id y10-20020a170903010ab02900f4109cdc08mr1027246plc.10.1621450810600;
        Wed, 19 May 2021 12:00:10 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y26sm89076pge.94.2021.05.19.12.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 12:00:09 -0700 (PDT)
Subject: Re: [PATCH v7 03/15] swiotlb: Add DMA_RESTRICTED_POOL
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
 <20210518064215.2856977-4-tientzu@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d9975ce8-7ae9-2ece-a1c5-a16d0aed8143@gmail.com>
Date:   Wed, 19 May 2021 12:00:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-4-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Add a new kconfig symbol, DMA_RESTRICTED_POOL, for restricted DMA pool.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
