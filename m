Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40EA1DC02E
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 22:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgETUcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 16:32:43 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43315 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgETUcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 16:32:42 -0400
Received: by mail-il1-f193.google.com with SMTP id l20so4668213ilj.10;
        Wed, 20 May 2020 13:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYhFWnym18cK56HOIXrwGvpqXxigL2vp9VHbqJW4HIM=;
        b=htOs/8YHKrrPhdjiPxNVXL8GzY1/Wp9B/ieEyf+PE37mm4etEgT0k5Z0mSerek1FBK
         3JpgBwM7YT1/00XWNgqRrAfvX7N1b9G/LWpEY/5WFSGFDt9QBvEtFcUhpp9ct9wYr4iC
         7B7YuUIls7E+x8+lFllTqZi4mq3dFFCyaF2xyyKzBtClpzzKiclMfFYI3fcn+0LcrbuX
         LSRdb42bqP+1pSOaIYVnf83yL8BMt4jKs3bxzHS8XzJZ2epLbLRyV2+iUGaASD5hKxFN
         2glmHm60gWGyOHYqxLCgYdI5vmSjwHM2qvVxaEc5T+UqGV/+kaUR6CybU75WzGC6EpHe
         u2rw==
X-Gm-Message-State: AOAM531v45gnk4Sdl9kP3fRneTrDMK57P+jPRLXI1On35oylT5+Lg6Hv
        Z+B1liG60wVyowZPqd8VWA==
X-Google-Smtp-Source: ABdhPJy5QvUn+VTDpkuNaZg6Rlk1g9vHBNfouawM73Pe8LYk585UL8czp90286VGTKxtQBwZeP8+kg==
X-Received: by 2002:a92:c7a2:: with SMTP id f2mr5670636ilk.71.1590006761646;
        Wed, 20 May 2020 13:32:41 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d12sm1884632ill.80.2020.05.20.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 13:32:40 -0700 (PDT)
Received: (nullmailer pid 503923 invoked by uid 1000);
        Wed, 20 May 2020 20:32:39 -0000
Date:   Wed, 20 May 2020 14:32:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     roy.zang@nxp.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Zhiqiang.Hou@nxp.com, jingoohan1@gmail.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        Minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        linux-arm-kernel@lists.infradead.org, leoyang.li@nxp.com,
        shawnguo@kernel.org, andrew.murray@arm.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, kishon@ti.com,
        linuxppc-dev@lists.ozlabs.org, amurray@thegoodpenguin.co.uk
Subject: Re: [PATCH v6 01/11] PCI: designware-ep: Add multiple PFs support
 for DWC
Message-ID: <20200520203239.GA503864@bogus>
References: <20200314033038.24844-1-xiaowei.bao@nxp.com>
 <20200314033038.24844-2-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314033038.24844-2-xiaowei.bao@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 14 Mar 2020 11:30:28 +0800, Xiaowei Bao wrote:
> Add multiple PFs support for DWC, due to different PF have different
> config space, we use func_conf_select callback function to access
> the different PF's config space, the different chip company need to
> implement this callback function when use the DWC IP core and intend
> to support multiple PFs feature.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> v2:
>  - Remove duplicate redundant code.
>  - Reimplement the PF config space access way.
> v3:
>  - Integrate duplicate code for func_select.
>  - Move PCIE_ATU_FUNC_NUM(pf) (pf << 20) to ((pf) << 20).
>  - Add the comments for func_conf_select function.
> v4:
>  - Correct the commit message.
> v5:
>  - No change.
> v6:
>  - No change.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 123 ++++++++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.c    |  59 ++++++++----
>  drivers/pci/controller/dwc/pcie-designware.h    |  18 +++-
>  3 files changed, 142 insertions(+), 58 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
