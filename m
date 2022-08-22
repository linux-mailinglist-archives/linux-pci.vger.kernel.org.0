Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9918C59B88D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 06:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiHVEtW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 00:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiHVEtV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 00:49:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6CE1EEC9
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 21:49:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y141so9235225pfb.7
        for <linux-pci@vger.kernel.org>; Sun, 21 Aug 2022 21:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=dz0eDoI9Fm2huCzymSoFjXyBRequkEKf77GU02TCpJg=;
        b=RsIfUWsSxHJb4qyOMDo7RSBNTBGsCvAIuCsedLI9rb8AYt+57z/oEh5/+DYmyGeZWI
         W+8gKvSiD4RQV+KftMAmCPAoqzc3HfD6qnT4EGbr7MaSauh/cEpQsHf3+y9m/iBhReLh
         hfjYadiAVocBHeck75BFwS38YukmKokJgEW6ah3V+fzlfr62gkldHInq1VH6e2meyUUo
         b+vy6+DSi+pr90hcoYHKfk/XHGMZO7Hb3gfilTebse2Dhu2b9S078/0bapWSprhkFzhc
         VESpdNvwX76tBVMUxjzx5YfKEQS3HOVn3G+D7mtZEQtO4cuquhOAschWIscA4UlYwyiU
         gVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=dz0eDoI9Fm2huCzymSoFjXyBRequkEKf77GU02TCpJg=;
        b=ychIK+2HkPS14tMoCUi7p9mXGFPg2AMxpu9vbJhTS42+zRRS/gGTlAjUrX3QL4xlDy
         5zRtUmZADVlf6yVAo+IUTqrXsNHb6JHuvwlTfKetZv74DEX21efydS/gqYDFhz3wh29X
         S6pQgwHoAzZLA+oGVohuARuSA/p3FYz06Hz9QcINJoNDwmLl9d/ryh/6fhhUxCEosFBp
         9jXk6xA6qEYk5atAZdhmD/8sQUZc/mmTXBn/I/N1VUnUv4tjdxEy0LBme4t58OwRz2Pf
         jC9vA41Ey1NSBHB8zSrb0gGEPdjNvAx9kf4SPo/j7kHdPJyCurby/xxv5RGRlwHEiltG
         +dng==
X-Gm-Message-State: ACgBeo37CHyRu3TQeX3KUE72/kwrPjB3X9a9fJptH7BGH9/4KfHSKHUI
        FrUd5YRIOYOoSznItfsP5urGsQ==
X-Google-Smtp-Source: AA6agR5Pto6O2hn+/T8fBSD4xUC2PEFnt4pycOkWtUdbLvcxAEKqIzPx+I5jR5lX3nfb3zKy7kV0KQ==
X-Received: by 2002:a63:2bcc:0:b0:40c:95b5:46a4 with SMTP id r195-20020a632bcc000000b0040c95b546a4mr15468612pgr.535.1661143759926;
        Sun, 21 Aug 2022 21:49:19 -0700 (PDT)
Received: from [10.191.0.6] ([199.101.192.185])
        by smtp.gmail.com with ESMTPSA id il10-20020a17090b164a00b001f21646d1a4sm14254198pjb.1.2022.08.21.21.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 21:49:19 -0700 (PDT)
Subject: Re: [PATCH v11 00/13] iommu: SVA and IOPF refactoring
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <890a99fe-1e9b-85bd-e4bc-b746ae17b827@linaro.org>
Date:   Mon, 22 Aug 2022 12:49:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022/8/17 上午9:20, Lu Baolu wrote:
> Hi folks,
>
> The former part of this series introduces the IOMMU interfaces to attach
> or detach an iommu domain to/from a pasid of a device, and refactors the
> exsiting IOMMU SVA implementation by assigning an SVA type of iommu
> domain to a shared virtual address and replacing sva_bind/unbind iommu
> ops with a set_dev_pasid domain ops.
>
> The latter part changes the existing I/O page fault handling framework
> from only serving SVA to a generic one. Any driver or component could
> handle the I/O page faults for its domain in its own way by installing
> an I/O page fault handler.
>
> This series has been functionally tested on an x86 machine and compile
> tested for all architectures.
>
> This series is also available on github:
> [2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v11
>
> Please review and suggest.
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
On arm64 (Kunpeng920) with uacce.

Thanks
