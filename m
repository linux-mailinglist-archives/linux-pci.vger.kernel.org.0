Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087B91C3CE4
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgEDOYm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgEDOYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 10:24:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED18C061A0E;
        Mon,  4 May 2020 07:24:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so21202866wrq.2;
        Mon, 04 May 2020 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDFjMogrrxgfBvAbW5sQ85zZf2koPdX/flvpXuarsJs=;
        b=C2+pDEOsEWMWEhK5jJihq+nZJsN3eyEZTYqrjm8F+NX2U4UWxWT4bq3TAe4s6ccpAF
         +4sas0ALldd+rEORJx5lpswwArDb/7j7znthws10FOtWqFllviOYtjS1sgR01+uhjhSg
         UTcE7cHgEzLdbISPHhOxFiqWLpJzCQ1DRIUt4NlbeOv0R8e703LNhYb26kTHr9YaAaOc
         proIbDywAmUaxtjcMFXJUCVdUFnCQGQjanr6hd0+FW3YkN2pevahT++dZrNrh8UlKt8/
         Zpd1vSYA8JKyL8SjQQTI8NGfT8GjDltQ3FbhARNC21VzGwv16zunILQ502YxBkFLEGBu
         UDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDFjMogrrxgfBvAbW5sQ85zZf2koPdX/flvpXuarsJs=;
        b=Nir0GMfrJIeiAyZORzcdT4w5naelchNhLE3ZP0kZ7S0wpdJi7qIfyctUepSUa9G2c9
         qAOQrWFGMQE8lqtzridN3V8D7QGgNwxccFDAD38ei3USh0bY8E00OtHvtsZu25MjHbIZ
         DG8JwRC4+FrCDOHL98fnvc7dQNvsaV86D9CzzSlwmTb2rM1Rj1Vim8CPM+66ONpcEpNQ
         X77lyEtcuH/zqt0o32PhdGypapvG1wWmXjsSNjEuN1jS8zax/LbD7XQ/XSyBE5WF2Ubu
         Ni4kz3AD3s+CZQkW/3bx77+Ulj68W6coAP9pTjQVsEW392I6tboC1J/EI6l9iozqyA+B
         CeLw==
X-Gm-Message-State: AGi0PuYyZStDWoyajiDshGDpuN+3TvHOXT1y+HDjQ9QJBY1fIEHSafSO
        d8GmtXfUBTcmWCZ0C9kldLTNMQAG83T5coQvce9rZ2BWepM=
X-Google-Smtp-Source: APiQypLGjILvGQo1LHKs+cUl/os48PmLVkMiBpNAewY+5+4GJJUXgPIlfOPn4hI9IzydhWXXgPlj9fp5HqE+FI7JLCY=
X-Received: by 2002:adf:ed82:: with SMTP id c2mr8123328wro.255.1588602280048;
 Mon, 04 May 2020 07:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200430143424.2787566-1-jean-philippe@linaro.org> <20200430143424.2787566-20-jean-philippe@linaro.org>
In-Reply-To: <20200430143424.2787566-20-jean-philippe@linaro.org>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Mon, 4 May 2020 19:54:03 +0530
Message-ID: <CAJ2QiJLUxiJRnxQmO3O_48ZcTtNwziCWT6i2SJdAruDi+KGEFw@mail.gmail.com>
Subject: Re: [PATCH v6 19/25] iommu/arm-smmu-v3: Add support for Hardware
 Translation Table Update
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-mm@kvack.org, joro@8bytes.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        tanmay@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Jean,

On Thu, Apr 30, 2020 at 8:11 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> If the SMMU supports it and the kernel was built with HTTU support, enable

is there any framework/config for HTTU which must be enabled to use this patch?


> We can enable HTTU even if CPUs don't support it, because the kernel
> always checks for HW dirty bit and updates the PTE flags atomically.
>
I believe, this statement is valid in context of this patch-set only.

One cannot use code snipped to test HTTU because exiting
io-pgtable-arm.c driver doesn't have framework to leverage HTTU
benfits. It by-default sets AF=1 and does not set DBM.

Thanks

--pk
