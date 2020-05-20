Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151C31DC1E9
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 00:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgETWMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 18:12:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35012 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETWMv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 18:12:51 -0400
Received: by mail-io1-f67.google.com with SMTP id 79so5142840iou.2;
        Wed, 20 May 2020 15:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/XCwGl3CcxYLRdci/jrQqyQhX1vNzc/WTIXwP/3z2ks=;
        b=hvXHwZdrSBa/aXBhLEtwhk/g2Ci8KIgJ/X+E/AFBaToE4PSOFhfqBzFoCcHRFcgg3V
         BW/tCOnM9FuKvcOwJrLgk/IstCMxCIcCwI13mxReAsynzTqN8WosbvHQb4dpXctvW64u
         ormnh05KqQljL6NeDSFdksXuxfe0mk7pGoy1X5KmCLF9EaBuPY5l2+wAikbkYv4aD7Nt
         CzgZUv+TXfubX9sZR2zG3BqIWqgqZvSLe0OK71Kb7AQHzdgMr1x26rAWywA/AAt3++vW
         08vYrBIi6o5Y3xWbbITLHRgaFAxMytHDtlWzoaMjLHtM523/nV4YMwoZGQ69RkAFtABD
         fAhA==
X-Gm-Message-State: AOAM530NB/hm2qlNN1/bBgOyJi5xejmVRJR1E6KTqEp+n+OSycBRycpd
        Cf+6ohjs/McAxBGPDFwChQ==
X-Google-Smtp-Source: ABdhPJwGQuSwEVeMo+S0Yp+avSAC0hl08uGB13i+IbavwQBYqhKPmzBjVCg7+0XKmioQ+tYLET3S3w==
X-Received: by 2002:a6b:3708:: with SMTP id e8mr4834928ioa.99.1590012771097;
        Wed, 20 May 2020 15:12:51 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e13sm1891621ils.27.2020.05.20.15.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:12:50 -0700 (PDT)
Received: (nullmailer pid 692806 invoked by uid 1000);
        Wed, 20 May 2020 22:12:49 -0000
Date:   Wed, 20 May 2020 16:12:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 14/14] MAINTAINERS: Add Kishon Vijay Abraham I for TI
 J721E SoC PCIe
Message-ID: <20200520221249.GA692726@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-15-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-15-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 May 2020 20:44:29 +0530, Kishon Vijay Abraham I wrote:
> Add Kishon Vijay Abraham I as MAINTAINER for TI J721E SoC PCIe.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
