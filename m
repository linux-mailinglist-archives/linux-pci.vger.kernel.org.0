Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 959021344E6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 15:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgAHOWp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 09:22:45 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42144 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgAHOWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 09:22:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id 18so2711195oin.9
        for <linux-pci@vger.kernel.org>; Wed, 08 Jan 2020 06:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M8y8BO0K5anvHEqPlUm8ymjBDQnclkOVB7xmvdmunFM=;
        b=IyrHba1tlCwkRxHzGt87l24qJbdR15qG5TKUohg1GmfAKBwIeVCA+2DUWSb26QK5yG
         7fviz1BQG85clo//PrZll3MeA9Hv+BKphkkWqRD/q6rGVqsyrwStSTYXHh6cJnXo0iZl
         vrwHpgcnVMMno9e/oCwTGFhQ85Yc0vJ0QlutQa9qc5Gbrm72gScZ7SDdf2PlSV+ay+dK
         fHGJm3TAp8R1/Ce0VTK6K8FJQcAeSfVAykmjq4aoANF7GmSSsW0m2KQAByR2k23zP6y1
         fffjTjxuPS0MSjJ9vJ6pGva+iH5oGOlwu+6ZM6DnTanjvJlRl3yjr74QCJeF4nbjdypl
         sx4g==
X-Gm-Message-State: APjAAAUnEY7AIUP6wcAVvCCFodu+M4TsNrOpvdtj9TMHlAlkgOZO8MXt
        JxKY0L9m6o92H4DDr4UWkAOjVu0=
X-Google-Smtp-Source: APXvYqxysHNvM3ahBeOZXsz6Ytf5Bmj4beauYV066OgS/YSboAdX+6yRDfFdnUcXHMiBtHDhItvmxA==
X-Received: by 2002:a05:6808:143:: with SMTP id h3mr3279929oie.61.1578493363925;
        Wed, 08 Jan 2020 06:22:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q25sm1144927otf.45.2020.01.08.06.22.42
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 06:22:43 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22001a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 08:22:42 -0600
Date:   Wed, 8 Jan 2020 08:22:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, andrew.murray@arm.com,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: Re: [PATCH 1/1] dt-bindings: PCI: intel: Fix dt_binding_check
 compilation failure
Message-ID: <20200108142242.GA8585@bogus>
References: <3319036bb29e0b25fc3b85293301e32aee0540dc.1576833842.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3319036bb29e0b25fc3b85293301e32aee0540dc.1576833842.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 20 Dec 2019 17:53:24 +0800, Dilip Kota wrote:
> Remove <dt-bindings/clock/intel,lgm-clk.h> dependency as
> it is not present in the mainline tree. Use numeric value
> instead of LGM_GCLK_PCIE10 macro.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
