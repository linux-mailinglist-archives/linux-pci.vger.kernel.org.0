Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8EA21E40D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 01:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGMX5z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 19:57:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38744 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMX5y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 19:57:54 -0400
Received: by mail-io1-f67.google.com with SMTP id l1so15454848ioh.5;
        Mon, 13 Jul 2020 16:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7c5zEhAAZe4ARtWE37/DC1WUrD4G1u+Olxon0OQTcTY=;
        b=FrkBCxvdggVsVNG6H4Jnm6V7x9uOSI5XlXEDbTbC3jEVi2Y6noEdWM302mvv6m5aHr
         xxEbMG4DffO0LSQ2vPfUHYOagQa+z3/KmsKJgsAyh08kMGPZKvZWNz9XkUxwe0VtcWyh
         lcKa+2AunMWwZnXde0IjsXvuyaJVXvbJP6q03k5XTlSgIDimvkWIiBkA2MiFDD3HpIG0
         Di4hwK4cQ6qrALCH16plN0c79fTM9mz+3sQUlPvQEUUI5PC0L4ohSCByqSej3XypERsc
         kdRxl8qK1AlQ2fpEyv1I7M/d5jM2lbN/2A21Y2JAsqoMckfuWCj+O8lQP2Cp4UL38We3
         BvgA==
X-Gm-Message-State: AOAM532WMpNhQsb9fCOqxC/26kpPJ9QaBD6cjY0z+jvjXRTs3+sfNWUG
        Q9aMb9xuEiNnnfd1qlplMw==
X-Google-Smtp-Source: ABdhPJzk0xad7Wqvui02rA9XsQsYeJbjiQrhI195AJtDwQfLcpp3zuMxhjsKkSZEBtUKqrliJBcwUQ==
X-Received: by 2002:a6b:8d4d:: with SMTP id p74mr2302931iod.173.1594684674059;
        Mon, 13 Jul 2020 16:57:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k1sm9003186ilr.35.2020.07.13.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:57:53 -0700 (PDT)
Received: (nullmailer pid 959222 invoked by uid 1000);
        Mon, 13 Jul 2020 23:57:51 -0000
Date:   Mon, 13 Jul 2020 17:57:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joerg Roedel <joro@8bytes.org>, linux-acpi@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>
Subject: Re: [PATCH v2 06/12] of/iommu: Make of_map_rid() PCI agnostic
Message-ID: <20200713235751.GA959175@bogus>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-7-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619082013.13661-7-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Jun 2020 09:20:07 +0100, Lorenzo Pieralisi wrote:
> There is nothing PCI specific (other than the RID - requester ID)
> in the of_map_rid() implementation, so the same function can be
> reused for input/output IDs mapping for other busses just as well.
> 
> Rename the RID instances/names to a generic "id" tag.
> 
> No functionality change intended.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/iommu/of_iommu.c |  4 ++--
>  drivers/of/base.c        | 42 ++++++++++++++++++++--------------------
>  drivers/of/irq.c         |  2 +-
>  include/linux/of.h       |  4 ++--
>  4 files changed, 26 insertions(+), 26 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
