Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9BA1DC089
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 22:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgETUuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 16:50:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44697 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgETUuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 16:50:20 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so4853344iov.11;
        Wed, 20 May 2020 13:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mRSMjgkGeWGBh2qwJHfwL3yydGjx13+/dKpUDO1iMb0=;
        b=Zl76HJdbkWkRZ63QdFKc59h3Mc2/0wYfUXAoRkX+7bdI+jMT03Eqd4e5qhllDLml9R
         YY+J9U4D2qtOWrYyTb7RKdybsex6u+PnoCxK1yH6YIC9XiKTt5BywWHKssTJtr2Kw22H
         sGDgDeogZucLPOzqX0xww6TORImgn4Vp9CgJ0GS9EJFlVqJ0qdC0qXpFCQ9IhKYAs6G0
         VywxnqnRq7Aeyv1rEyljVSQ3vbP8spyOX5TsiKO8D9i4cn77u4aBJLqmeA6x69JshBSI
         smb+2Qu4rJLpiCt9w7WBHh7f+M78oPXi2bORy+oapX7LK9LhONlCyDgo4ox0Re9sShh0
         VqYA==
X-Gm-Message-State: AOAM5322kJKeH2FAXi11op7cnsIlrib8SqWHZe2+12pE0Qo6yNTraAEQ
        qShi7n+WBD/o8zCV/gecJA==
X-Google-Smtp-Source: ABdhPJwnwe9ybgq0b3s7dUXq6qN9mChjHs0K0Gg3PfPIRRW3vwKfrh4ExYIFqiRNvifXUYk2fDGxXA==
X-Received: by 2002:a6b:b38a:: with SMTP id c132mr5082996iof.54.1590007819658;
        Wed, 20 May 2020 13:50:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n22sm748494ioh.46.2020.05.20.13.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 13:50:19 -0700 (PDT)
Received: (nullmailer pid 546373 invoked by uid 1000);
        Wed, 20 May 2020 20:50:17 -0000
Date:   Wed, 20 May 2020 14:50:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        Minghuan.Lian@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, Zhiqiang.Hou@nxp.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, mingkai.hu@nxp.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        andrew.murray@arm.com, bhelgaas@google.com, kishon@ti.com,
        roy.zang@nxp.com, amurray@thegoodpenguin.co.uk, leoyang.li@nxp.com
Subject: Re: [PATCH v6 09/11] PCI: layerscape: Add EP mode support for
 ls1088a and ls2088a
Message-ID: <20200520205017.GA546312@bogus>
References: <20200314033038.24844-1-xiaowei.bao@nxp.com>
 <20200314033038.24844-10-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314033038.24844-10-xiaowei.bao@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 14 Mar 2020 11:30:36 +0800, Xiaowei Bao wrote:
> Add PCIe EP mode support for ls1088a and ls2088a, there are some
> difference between LS1 and LS2 platform, so refactor the code of
> the EP driver.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - This is a new patch for supporting the ls1088a and ls2088a platform.
> v3:
>  - Adjust the some struct assignment order in probe function.
> v4:
>  - No change.
> v5:
>  - No change.
> v6:
>  - No change.
> 
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 72 +++++++++++++++++++-------
>  1 file changed, 53 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
