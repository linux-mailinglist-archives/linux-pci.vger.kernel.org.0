Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F31DC245
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 00:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgETWkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 18:40:01 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38089 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgETWkB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 18:40:01 -0400
Received: by mail-il1-f193.google.com with SMTP id j2so5033336ilr.5
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 15:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dfhTH1YL8YF/PNrumPf3vbnHKoXW5sggdbxCoCRxEpg=;
        b=Dh+/Jdn8XqOxWJRCvz1WbHRd4pU3ZmFz7I1VKN9u9sMilzglEHInd1/amqJhLHb4E8
         XsY/wW3jl+vgyaA7q01Miq52ahzZxLNNCi1J/YHUADQfpJDsfSF3dNk4lzeE1SjOLKpj
         Lrut6uFCjto79Hyq8CXPblHBwZO8HE/DihVaNzLJotj6YMj3IQCkQnZpJvih9sU8pZIv
         2DrxlGz4DUrW46eTeeAptMliY2a//3+8GirxyK5pUvWF4hsSlphQPjtSjCxNkGVJVpjP
         MIRMCuMJsU+wDFhU0ALXkiIBXcj96g0MqQMLKJ9/BOJIvRzoI9le7hYFwOPmcVr9RLCQ
         Gmrw==
X-Gm-Message-State: AOAM531fRePFsmreup67LgsOLxevUicMUsCIwAzMkGERuZeIKDe6YNd9
        k7NtEARntcWVAvf+LKXOzg==
X-Google-Smtp-Source: ABdhPJwllSaDp4xvqTAcNsLs+pTy1/qvkdiubgVcrauyP6dHntcpP42Op9gf/PVAGpeQSds7qZSUag==
X-Received: by 2002:a05:6e02:1292:: with SMTP id y18mr5879215ilq.143.1590014400711;
        Wed, 20 May 2020 15:40:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 137sm1643437iob.32.2020.05.20.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:40:00 -0700 (PDT)
Received: (nullmailer pid 734959 invoked by uid 1000);
        Wed, 20 May 2020 22:39:59 -0000
Date:   Wed, 20 May 2020 16:39:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/4] PCI: pci-bridge-emul: Update for PCIe 5.0 r1.0
Message-ID: <20200520223959.GA734903@bogus>
References: <20200511162117.6674-1-jonathan.derrick@intel.com>
 <20200511162117.6674-4-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511162117.6674-4-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 May 2020 12:21:16 -0400, Jon Derrick wrote:
> Add missing bits from PCIe 4.0 and updates for PCIe 5.0 r1.0.
> 
> PCIe 4.0:
> Device Status bit 6 - W1C - Emergency Power Reduction Detected
> Link Control bits 15:14 - RW - DRS Signaling Control
> Slot Control bit 13 - RW - Auto Slow Power Limit Disable
> 
> PCIe 5.0:
> Slot Control bit 14 - RW - In-Band PD Disable
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
