Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283BE269B2B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 03:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgIOBat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 21:30:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46825 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgIOBam (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 21:30:42 -0400
Received: by mail-io1-f66.google.com with SMTP id g7so2238021iov.13;
        Mon, 14 Sep 2020 18:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gGtIeTvjHgPVPfsY7k4EBBGGvQf18sxqXWoEfYMB4Xs=;
        b=ZSsAg+cNTv2PZ2TwgsyPc8uFhM03ZwBp3GQNigbn9kslTscD4nh3x+sSemAJcNV6rL
         rHkMpQkLOf6N7mjuH5wEhd5e2NUZQJuSNtDCA7R5hOFgI8f5fIsbd6rXCA22TGiAjiYt
         Ks+Yg1zLp7ycvycQcBy79KiNJBKdwZETGqXPJE9Y8UpSM9efHTXkggyTzgaKfpV+ya+S
         xnZeig1GvCbtRAltPXgCdmOChduIHpwz+/g/hnf4/n8JNvD/Eq6eLypX7vhFwZrWRXXK
         YTNXUk7cDiDdDCEGpL0iAcrXQNAJwrAVK1Fxtwx8FIXVI+EBoqZ6Tvvx3LUDXj0VVjeu
         G8pg==
X-Gm-Message-State: AOAM5337zciyg1nEbENQMV895GYvMLaTVcs4qqMkZAxcddROh3Ay36bd
        E/J0WUdvcglDbcOiVhW1SA==
X-Google-Smtp-Source: ABdhPJxBMDnkjL5HkqIlO6SmtSKs4y40I9+TdfRi3F0jD/5EEDPTbQP6ndoiyRC5AZmYgdS4vAROJg==
X-Received: by 2002:a5e:c00f:: with SMTP id u15mr13337623iol.6.1600133441216;
        Mon, 14 Sep 2020 18:30:41 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m12sm7949611ilg.55.2020.09.14.18.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 18:30:40 -0700 (PDT)
Received: (nullmailer pid 667535 invoked by uid 1000);
        Tue, 15 Sep 2020 01:30:39 -0000
Date:   Mon, 14 Sep 2020 19:30:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, linux-pci@vger.kernel.org,
        minghuan.Lian@nxp.com, robh+dt@kernel.org,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        roy.zang@nxp.com, mingkai.hu@nxp.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: pci: layerscape-pci: Add a optional
 property big-endian
Message-ID: <20200915013039.GA667506@bogus>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-4-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907053801.22149-4-Zhiqiang.Hou@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 07 Sep 2020 13:37:57 +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This property is to indicate the endianness when accessing the
> PEX_LUT and PF register block, so if these registers are
> implemented in big-endian, specify this property.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
