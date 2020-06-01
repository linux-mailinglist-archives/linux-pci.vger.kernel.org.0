Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F345E1EB19B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 00:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgFAWSh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 18:18:37 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39298 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgFAWSh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 18:18:37 -0400
Received: by mail-il1-f193.google.com with SMTP id p5so9893253ile.6;
        Mon, 01 Jun 2020 15:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YPlP1lsniW4f0qVBZx+2wfkX8Oo0MF6t2zfN4OzGwaI=;
        b=aRfttkVN5riXVSdYmsjYJTgdw5rm8fpmbJPcslz36fQpi6l2F2lN5hotFDi/f+godh
         vO9jTf7yqYduhnRgL3XpvA6fYIwvi3tuB8HaV21tlwhz8p9UEk+OsaZGj6QzebMbGgAt
         IEMoQKTtJziOp9EhNDEAyTdaFyam1R0g6yZW0w0lLSbwwd72n7ZeZpHvqOGT5PV96n/h
         +H0wUrPoXXZ33hlsH+/eRNSI7XG+14uXoyj1J9pRdgFQhmYxxdI1BVJjUT1NapmzyH9B
         lOjKp07qicHN4/gzymYDo4a2qzB9Wibq6AMZgSzo/bzC7tpLcs8HbZt/n2bELFKK56mg
         Yzug==
X-Gm-Message-State: AOAM530C3j1i86kN1JjZ/x3kZdTt1+anLGPEYRCS1waY8pwakcqfihuB
        ASOjWuaTp9Ylkfk0JJsjHQ==
X-Google-Smtp-Source: ABdhPJxIMhZUM1aPPpcGNe04ARDneVvKwb3NK7HhTtfx85yAqz9Y8uXduG0bk7Y6UyK5q2Aw43GUhQ==
X-Received: by 2002:a92:d34b:: with SMTP id a11mr23161714ilh.180.1591049916470;
        Mon, 01 Jun 2020 15:18:36 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y2sm413610ilg.69.2020.06.01.15.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 15:18:35 -0700 (PDT)
Received: (nullmailer pid 1611604 invoked by uid 1000);
        Mon, 01 Jun 2020 22:18:34 -0000
Date:   Mon, 1 Jun 2020 16:18:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, shawn.guo@linaro.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        gustavo.pimentel@synopsys.com
Subject: Re: [PATCH v1] PCI: dwc: convert to
 devm_platform_ioremap_resource_byname()
Message-ID: <20200601221834.GA1611544@bogus>
References: <20200528161510.31935-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528161510.31935-1-zhengdejin5@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 May 2020 00:15:10 +0800, Dejin Zheng wrote:
> Use devm_platform_ioremap_resource_byname() to simplify codes.
> it contains platform_get_resource_byname() and devm_ioremap_resource().
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c         | 11 ++++-------
>  drivers/pci/controller/dwc/pci-keystone.c       |  7 +++----
>  drivers/pci/controller/dwc/pcie-artpec6.c       | 12 ++++--------
>  .../pci/controller/dwc/pcie-designware-plat.c   |  3 +--
>  drivers/pci/controller/dwc/pcie-histb.c         |  7 ++-----
>  drivers/pci/controller/dwc/pcie-intel-gw.c      |  7 ++-----
>  drivers/pci/controller/dwc/pcie-kirin.c         | 17 ++++++-----------
>  drivers/pci/controller/dwc/pcie-qcom.c          |  6 ++----
>  drivers/pci/controller/dwc/pcie-uniphier.c      |  3 +--
>  9 files changed, 25 insertions(+), 48 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
