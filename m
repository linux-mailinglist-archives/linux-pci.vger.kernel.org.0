Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6225034B006
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 21:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCZURg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 16:17:36 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:35584 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhCZURT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 16:17:19 -0400
Received: by mail-io1-f50.google.com with SMTP id x17so6682617iog.2;
        Fri, 26 Mar 2021 13:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lXhVUd2LXA0slLO6f28KGEaXuw2/vWQ0zjQm9zItTk4=;
        b=cFEOmxQdXwitcdGjuzk6H+EU2omgpvqsaky+Qbau+wwbS/h5E3R1MCq89/jcBvHyxV
         Z9jx8VmyXToAeL0x7hi+FAHA2w8gkYZs2L/cbaHn07HN9EKWTDsYdtZ6muuVSJpjVfQV
         xrwBqj9z15OKA+qT9uUA60C/iJL5lfvUOrzR9Hipq0UcnEpiCy5dKc8rboGmHDF5m4y1
         M1csuF+y8uYGFlRbbRKWI4v/hpzsjTXc6k2NOT8RUeLfF9DYt3YjGYq+1kgfYcZPhCOE
         brJEEl4o9Bzmz9NgG9yd+1inLbXDhnQ+Kk0tRawzfRvuAUSEPpE15W/LXDe1r4HbLEBQ
         Rpwg==
X-Gm-Message-State: AOAM532aHT6nqL8w2D1VPGAkGdhu+oLpF9/mfMEjvGkk1sHZbX8IvMSx
        djelKYVNzBnZg8GBG0JaNw==
X-Google-Smtp-Source: ABdhPJwl6o5+wnj+LjKE0x7DY49tPHfMI2G37msHGO/RrejzHtTxVwpHGu0KtobnVONYYJROIZMCJA==
X-Received: by 2002:a02:cd33:: with SMTP id h19mr13406054jaq.88.1616789839353;
        Fri, 26 Mar 2021 13:17:19 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q12sm4923274ilm.63.2021.03.26.13.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 13:17:18 -0700 (PDT)
Received: (nullmailer pid 3797035 invoked by uid 1000);
        Fri, 26 Mar 2021 20:17:15 -0000
Date:   Fri, 26 Mar 2021 14:17:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        ryder.lee@mediatek.com, lorenzo.pieralisi@arm.com,
        jianjun.wang@mediatek.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com,
        frank-w@public-files.de
Subject: Re: [PATCH v8 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
Message-ID: <20210326201715.GA3787794@robh.at.kernel.org>
References: <20210323033833.14954-1-chuanjia.liu@mediatek.com>
 <20210323033833.14954-3-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323033833.14954-3-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 23, 2021 at 11:38:31AM +0800, Chuanjia Liu wrote:
> For the new dts format, add a new method to get
> shared pcie-cfg base address and parse node.
> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 50 +++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 12 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
