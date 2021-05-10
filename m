Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C46379394
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhEJQTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 12:19:53 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:36529 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhEJQTw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 12:19:52 -0400
Received: by mail-oi1-f182.google.com with SMTP id w16so8108776oiv.3;
        Mon, 10 May 2021 09:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjgUKuG+YlSVTFg9T2gQ4kFFZjfdjSbPmFmHMX4O3uE=;
        b=QkQTIPZsnxiJbMNnFFunOdnSDKeGRxy+ZAycdVSxO9uNFwp/ry31d83doJMouJWx4o
         xSW1EE5TTphhbyuGwY0NNVTsxxMDp1J+/86tiYHN3baoUspe51lbxyfmCjM8SM38Gt5x
         5JPIqnSkAqGwgQp/pbtJIsRtwGnth+R+XiIcbjorxQbAKuEhRjEK7mPMX28lNmGGfBHC
         u73/zW+VT2qY+tuC2cjcrZ3zVPvz/foIukaoqFrUJSAQX8w6Eefd3tlzj8EiaV+MO75q
         Oohl3TxHoUuXaPflH0mSgCF+HjnI/him12iT1FKZfU2cNCoAz5hQ4vX6MDrCy2Ycms+o
         h5Lw==
X-Gm-Message-State: AOAM531tgNu0754SEcaJm5BqH4aVLn/Ip0l7eyUCiNVJZihT2Fwjoxyi
        vEYslLfParjKdRaDkrS9bw==
X-Google-Smtp-Source: ABdhPJxteZF9VrOoMPyekriMcR/pdiIErnDw3W2RUlI8UyhDBiR0//H0CPV1giVPDqCjkjST2vckLA==
X-Received: by 2002:aca:47ca:: with SMTP id u193mr26060937oia.69.1620663526817;
        Mon, 10 May 2021 09:18:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 16sm3200858otu.79.2021.05.10.09.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:18:46 -0700 (PDT)
Received: (nullmailer pid 225492 invoked by uid 1000);
        Mon, 10 May 2021 16:18:44 -0000
Date:   Mon, 10 May 2021 11:18:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, devicetree@vger.kernel.org,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        Krzysztof Halasa <khalasa@piap.pl>
Subject: Re: [PATCH 3/4 v3] PCI: ixp4xx: Add device tree bindings for IXP4xx
Message-ID: <20210510161844.GA225439@robh.at.kernel.org>
References: <20210509222055.341945-1-linus.walleij@linaro.org>
 <20210509222055.341945-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509222055.341945-4-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 May 2021 00:20:54 +0200, Linus Walleij wrote:
> This adds device tree bindings for the Intel IXP4xx
> PCI controller which can be used as both host and
> option.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khalasa@piap.pl>
> Cc: Zoltan HERPAI <wigyori@uid0.hu>
> Cc: Raylynn Knight <rayknight@me.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Drop ranges, these are part of pci-bus.yaml
> - Drop status = "disabled" on the node
> ChangeLog v1->v2:
> - Add the three controller interrupts to the binding.
> 
> PCI maintainers: mainly looking for a review and ACK (if
> you care about DT bindings) the patch will be merged
> through ARM SoC.
> ---
>  .../bindings/pci/intel,ixp4xx-pci.yaml        | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,ixp4xx-pci.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
