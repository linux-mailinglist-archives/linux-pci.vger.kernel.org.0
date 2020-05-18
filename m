Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3949D1D7EA9
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgERQgs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgERQgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2020 12:36:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97639C061A0C
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2020 09:36:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so12720757wru.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2020 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2gB71GDbYw4drdErrFCHDJu6OIFxLC1rGMVvbvndxDM=;
        b=PDn/PxtMfkLDgv/KDv9kB0no5kBMLuhS+qeMDcod8WbYLbhEgkIlgH2u0QFRzcPVOl
         q+awlo77fgxtG8/InLzpp4GGLQGpLlEiXok6uGcW/2hPLhtNyzDv65j8LEsb7LKb91FL
         /05873qUSxmeP3aP/CeuSoF2CSKGIasPqXcq6bkBNvEHYE6U+4ebU86gavemPyFrd8aX
         NIluOhSZEwzye8Yc+0X8snjsraF4P+pCEmcRIx5w7cws889GEJdb55p143NKDwnbn6Ye
         gpxe8iA+sJuxkM1jHcgB2EVidW60koXndSh/pSNwb8s8/rC/w5S5nOIRf80ahCi8J4/m
         AArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2gB71GDbYw4drdErrFCHDJu6OIFxLC1rGMVvbvndxDM=;
        b=ck6/kuAbEEinUax2HIumYOsjW7EiJKwFyyxQu78SWeVQ5JXRjt88iiBaQ+fG6FYvHL
         +R3uHLa+FB7+qKhfWzYCPt3QleITL0np4Q7UszlmwLza7DWapKH8A4Go3okfEM/IqTYm
         RqWESXHttEclTwCg4zAkHqaljZSZ6OxY3/nlmEgWo6tBEZZVZz1KZyQ5M5wUBg0bts6e
         esEIpWOaiC4zbHpEuIwCH/5SgiaOY9Jf2fa1z7S5t4muJjCqDo3EcgCj7hYmp+wBTcC1
         J/XTv2jCKVyMmx4Yq7hy885SL/pXw7pf6rUJfFWteZLo+XxmuOfSqaMV6a8erkpA0J//
         Re5g==
X-Gm-Message-State: AOAM530PErJ25iHOAN9XOVFC3D5chj64p3uYrLAfyOKFwghVw2XTLNO3
        aX/oNWKNX3eEh/0gCIa4SoHZIw==
X-Google-Smtp-Source: ABdhPJyoblToVYDpynfOZzcoPNIcIPzA/+uGv6r9gM7IsrGshV+QeruKxRwI6mlqXy28BRkRGgWhgA==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr20827860wrp.300.1589819806321;
        Mon, 18 May 2020 09:36:46 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 5sm143931wmz.16.2020.05.18.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:36:45 -0700 (PDT)
Date:   Mon, 18 May 2020 18:36:36 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com, ashok.raj@intel.com, will@kernel.org,
        alex.williamson@redhat.com, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200518163636.GA1515149@myrica>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
 <20200515154351.GA6546@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515154351.GA6546@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 08:43:51AM -0700, Christoph Hellwig wrote:
> Can you please lift the untrusted flag into struct device?  It really
> isn't a PCI specific concept, and we should not have code poking into
> pci_dev all over the iommu code.

I suppose that could go in a separate series once other buses need it?
The only methods for setting this bit at the moment apply to PCI ports.
(ACPI ExternalFacingPort and dt external-facing properties declared by
firmware).

Thanks,
Jean
