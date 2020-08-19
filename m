Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3A224A4E3
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHSRYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 13:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSRYZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2020 13:24:25 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9EAC061757
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2020 10:24:24 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 185so26220416ljj.7
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2020 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojSwV7SvqjKQoGPMxqvv0gsrf/RgVZcGIvS7BBup7+g=;
        b=VqmL0RedfzzSImBcYBoGClC2Z6UAihg/BXc1CnhHqoj0eUre8BVYOlCvNPxklLBSgP
         nLwLIR++4Kv0RE3BiZIjFu22n6R2TU8ldYKmSwwnJVI5fpKvaO5Bk8kN2QeVTaDGBaIB
         JecUwHCUkkhy3+ouO37q6Lbgs6Q0YKuzlgzOGSHh8P2qEyQ2n4X8ifsghKJEfdSUpDV2
         II4EPmn9sjsOTLN2W1jvcNyey4oQaTVB5YdxMCK5BE9RakLnb425R7BvQcuqBbQFcvbv
         Fb+Z4pAjirOJ8+ypaGxN3by36PWwpqSyDvhx52C75yHNWJLb1H1DtEBru0XXh4lYXi4r
         pUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojSwV7SvqjKQoGPMxqvv0gsrf/RgVZcGIvS7BBup7+g=;
        b=sR7AQjPKdYuKqdVVAwW7ZnkEk2vzectkb+feH/NN811TkefmrrIfYmwlubCckqN7TX
         rnFfjczaA/cfDLLJog9DLwCU8SwlkI+6lA+z19rSpGZNCi1wd0hj/mjYtnsyaGDFM1m3
         NsdqQ0mVacNRlOyhhp5BTOj58x6HLGa0dlmnEqSXlLdwH5cg4b46IG2IUIlAm6ADw1Jn
         jIdp54Z5W7k7v6X612rVV1QFXhx1mqc05D4AY62iWKcOvnIAEslK0YK3i7y3kh41I0uN
         A2dGeO9rNnp6p7ayW77XMwAf+tXarD6PWCH/1XCjQ34oJeLpIhkVCpRiE5XulgZYPqJ5
         6lZw==
X-Gm-Message-State: AOAM5318GFf0ecGnxp/0NAvvrVyCEei8azQDADNF39rPQePhNt0kzfmZ
        T1cyAKWF/KKR7HJlacgPyPnMqXZDc2cDhuc2/y0UV/Nz
X-Google-Smtp-Source: ABdhPJwjmNsnMo5isiZXimlZyKlSIpiYa8wlISdAoXklEf5GhXE97QZWwcR2YV+uN3jTPIX0sexyhbE3XCYyFg/tNhQ=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr13443758ljg.125.1597857862328;
 Wed, 19 Aug 2020 10:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200819171326.35931-1-andriy.shevchenko@linux.intel.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Aug 2020 14:24:10 -0300
Message-ID: <CAOMZO5B9FGqSsnQcw1hhyOQnvkgxXK_xAkvNbjdtNuH+5V8kBA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] swiotlb: Use %pa to print phys_addr_t variables
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy,

On Wed, Aug 19, 2020 at 2:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> -       unsigned long bytes = io_tlb_nslabs << IO_TLB_SHIFT;
> +       unsigned long mb = (io_tlb_nslabs << IO_TLB_SHIFT) >> 20;

Looks like an unrelated change.
