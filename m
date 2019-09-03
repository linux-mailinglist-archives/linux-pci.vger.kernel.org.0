Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE09A718D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfICRUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 13:20:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33154 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICRUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 13:20:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so18368221wrr.0;
        Tue, 03 Sep 2019 10:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rar4+uC5q12KPtiyVYMv+PjJypYyOCyJrBGvZDXzi2k=;
        b=GGmG9O3WqKE+O+cfhWFrCy4Zl9a1IwKnoMIcs4y4V6L/lpE7DKS9n4H85/cEHsqoM1
         250VEhWOgfJO1QTyt4aFScWXLX4f0SEQ5bsBksj5FQ9UVAcxJgpsGgafXCBD+EA+Js9L
         k6/zVpINrtxu9OkzNm80vdY2JVjLgyYGIc9XYIi4Jt1/gm3ugkTNz7KN4VxIpjFR/aHF
         pgxJ3lGrQFeA7GSw1CQrl7LZ6ADUAVAW8oReDxGjSXdDkFHmFsy4eK5rwxBhbTYgO/Yx
         Yh5oDTboYPV3zS0TGzgUGc3Z6z4VkRSuFB6IXYy8vb71YdUF6S+n1Cs7XzgP8oDbLW9e
         O4OA==
X-Gm-Message-State: APjAAAXkHB+Ae391EBWINSyF/v6ugdhqrRFPEMXes/o38oHFdgObkDcC
        tD3YhqzpZjlelFWllKo9bA==
X-Google-Smtp-Source: APXvYqyjkukxdrT5Es1J9haZ+DcUHsFn8ngRxdUl3OZDcQKy38QGzV98Fy3y/684yQ4P6QtkGLVBdA==
X-Received: by 2002:adf:c613:: with SMTP id n19mr24481531wrg.109.1567531212863;
        Tue, 03 Sep 2019 10:20:12 -0700 (PDT)
Received: from localhost ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id f10sm14511981wrm.31.2019.09.03.10.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:20:12 -0700 (PDT)
Date:   Tue, 3 Sep 2019 18:20:10 +0100
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Remove unused includes and superfluous struct
 declaration
Message-ID: <20190903172010.GA26505@bogus>
References: <20190901112506.8469-1-kw@linux.com>
 <20190903113059.2901-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903113059.2901-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 03, 2019 at 01:30:59PM +0200, Krzysztof Wilczynski wrote:
> Remove <linux/pci.h> and <linux/msi.h> from being included
> directly as part of the include/linux/of_pci.h, and remove
> superfluous declaration of struct of_phandle_args.
> 
> Move users of include <linux/of_pci.h> to include <linux/pci.h>
> and <linux/msi.h> directly rather than rely on both being
> included transitively through <linux/of_pci.h>.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  drivers/iommu/of_iommu.c                          | 2 ++
>  drivers/irqchip/irq-gic-v2m.c                     | 1 +
>  drivers/irqchip/irq-gic-v3-its-pci-msi.c          | 1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  drivers/pci/controller/pci-aardvark.c             | 1 +
>  drivers/pci/controller/pci-thunder-pem.c          | 1 +
>  drivers/pci/pci.c                                 | 1 +
>  drivers/pci/probe.c                               | 1 +
>  include/linux/of_pci.h                            | 5 ++---
>  9 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
