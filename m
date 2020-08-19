Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E9F24A964
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 00:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgHSWag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 18:30:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39611 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSWaf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2020 18:30:35 -0400
Received: by mail-io1-f68.google.com with SMTP id z6so375913iow.6;
        Wed, 19 Aug 2020 15:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TPAgoF6CS6LHb79mBEQMdU6QynqQNT4ADYnbP9+wi74=;
        b=Iy3eq/WA8d3tP56uIU8z31H/+gJFoshRuzJlQVlwM8uC7l+yminCpJO5C1lxhPdqJr
         HExhMNpxUSYz1AwLaICvNTZp8ixGXIVH6DEntjlHJnM9qgOUhW+yRTe7AK6xPEYo54YY
         CwhIJwr/cjaZS4wIJs0K0Hz3JB5YOG1gKo5pFgHBSKScx0OWwJuBWAfrXFcDEk8/oumR
         JaB1O8ryX0Q8L/TuSfv6P78a9J/1HS3XGLeMjM5Sl1Hb9iWDG24/z6D15E+Yc9/1IYwx
         IcTf2o2SnahMKS8tyg4UeqY4C9+fnRJVpBQAOcAeZhN4Wn3V9z2FkzVWMfYr9RuLqTeh
         RFVQ==
X-Gm-Message-State: AOAM531qUo+t6ZuP5PJ3Judh1M/u0Q35r0iGZUaiSS7h5YIEpajSKrWf
        PGNRrjZ9bZJx75dDHX/GPA==
X-Google-Smtp-Source: ABdhPJzOVbOE3td6fQsaX3GtZOf+rgr1VvqINzVc5EPIlkHCXVE0LtV3YFDHep9Apf5exI1W+VesoQ==
X-Received: by 2002:a02:8806:: with SMTP id r6mr533184jai.88.1597876234835;
        Wed, 19 Aug 2020 15:30:34 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id z26sm243083ilf.60.2020.08.19.15.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 15:30:34 -0700 (PDT)
Received: (nullmailer pid 2077672 invoked by uid 1000);
        Wed, 19 Aug 2020 22:30:32 -0000
Date:   Wed, 19 Aug 2020 16:30:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, kernel-team@android.com,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] of: address: Work around missing device_type property
 in pcie nodes
Message-ID: <20200819223031.GA2077542@bogus>
References: <20200819094255.474565-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819094255.474565-1-maz@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 19 Aug 2020 10:42:55 +0100, Marc Zyngier wrote:
> Recent changes to the DT PCI bus parsing made it mandatory for
> device tree nodes describing a PCI controller to have the
> 'device_type = "pci"' property for the node to be matched.
> 
> Although this follows the letter of the specification, it
> breaks existing device-trees that have been working fine
> for years.  Rockchip rk3399-based systems are a prime example
> of such collateral damage, and have stopped discovering their
> PCI bus.
> 
> In order to paper over it, let's add a workaround to the code
> matching the device type, and accept as PCI any node that is
> named "pcie",
> 
> A warning will hopefully nudge the user into updating their
> DT to a fixed version if they can, but the incentive is
> obviously pretty small.
> 
> Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/address.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Applied, thanks!
