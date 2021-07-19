Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFA73CF264
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 05:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbhGTC1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 22:27:04 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:34548 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359637AbhGSVVr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 17:21:47 -0400
Received: by mail-il1-f176.google.com with SMTP id e13so17414846ilc.1;
        Mon, 19 Jul 2021 15:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yrNVD6owLaXgePWd4CismjZJlEUasygzpIYO3eYDGuQ=;
        b=kZrpC62p9A1khNOqegVZUWTp1kYuPyDwXtK3EUeNF3oBdOOL3yyb0wHbLKzk1AMP2a
         QJyDDnai7wf2LEZxNSEkfdHFdEI6nriuTJLne6R+lmhVNWaHwCCiDNEHwDFoUFs8YA49
         tF3pQlYMBcQq0/v40Vc/pI81iX8QMZfq8C20XD0dVVDTwubNP/nLEZcZVSE5i0jW8uSN
         3+/VpBlZii7neU/Ivdsk5xGkFdVkend0sNQRFKh9PbczCF4gYsAggzO5YhS9f6dfsv8o
         6RqO2/SAsmzjp3YHWW9QqwVkoevT0ZI4iJJdur/sxB0xgyHnNAhQN7fubOzTLgDwG2Wx
         GsFw==
X-Gm-Message-State: AOAM5319hBIIb7ebJhwU1lQO42/az7cOepa83wLo7qrJN907XLxedC49
        VBOO6WrODjIt9v9oKrAt0A==
X-Google-Smtp-Source: ABdhPJx9PzdfGU03OIEVW7jTxu0UaiqhSeyJNTt+ZIebHFWFGLejJX0wxg6uDOreC9dDNhc/Gv+dbA==
X-Received: by 2002:a92:cb0f:: with SMTP id s15mr19327369ilo.11.1626732144287;
        Mon, 19 Jul 2021 15:02:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d8sm10150955ilq.88.2021.07.19.15.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:02:23 -0700 (PDT)
Received: (nullmailer pid 2676858 invoked by uid 1000);
        Mon, 19 Jul 2021 22:02:20 -0000
Date:   Mon, 19 Jul 2021 16:02:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        mauro.chehab@huawei.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH v5 2/5] dt-bindings: PCI: add snps,dw-pcie-ep.yaml
Message-ID: <20210719220220.GA2676706@robh.at.kernel.org>
References: <cover.1626608375.git.mchehab+huawei@kernel.org>
 <26025b256232c2e4bd91954907b9d92db27199a3.1626608375.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26025b256232c2e4bd91954907b9d92db27199a3.1626608375.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 18 Jul 2021 13:40:49 +0200, Mauro Carvalho Chehab wrote:
> Currently, the designware schema is defined on a text file:
> 	designware-pcie.txt
> 
> It contains two separate schemas on it:
> 
> - snps,dw-pcie
>   This one uses the pci-bus.yaml schema;
> - snps,dw-pcie-ep
>   This one uses the pci-ep.yaml schema.
> 
> As the:
> 	AllOf:
> 	  - $ref: <foo>
> 
> for the endpoint part is different than the PCI one, place
> it on a separate yaml file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/snps,dw-pcie-ep.yaml         | 90 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> 

Applied, thanks!
