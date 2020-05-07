Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721F51C9A08
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgEGSzN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 14:55:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39924 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgEGSzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 14:55:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id m13so5432214otf.6;
        Thu, 07 May 2020 11:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwYYGNzYe2kxY79h+ETMMs0ZcfM9ltMxZYor/BkhBJM=;
        b=HHNFYMoJRUNuz+qO82vyrKkniaBPG+6eH70E2goza2R84STXVjCTrPW6xUrpa6BP3Z
         s1CjI4kyAqvca2L0facjLgaKMVnStgPAE3iYruHnhiqBeHMBPWNIJ0CBw7NO1APKZWhr
         xE2EeAWCsV7Kgdt/p3Bpie26jy7QlwcFasJ/ALHfBQH55iAFpBCE6QGjEwVLQYBm/dqm
         cKOHoIttSHcFrbI2Pd7Q4ur7kfloXX1N7bMdfQaSNdKJqfgvdt3Fdn1Mnt8snFrjqfZs
         jfmktg35zhWVJyfArE1Jn9I1U+Orrzf7XC5G08ppk/JnpECOf/kP38Yf/LmprRwP2wZc
         TWsg==
X-Gm-Message-State: AGi0PuaV3QZABY4h7G8BObqhUUSU0UWekFg6yoSyQexto/+sdrnSJoC6
        w+TTa/W4G5F8j5NGpTPZPg==
X-Google-Smtp-Source: APiQypKjijNorzsZ2dMMQG79xGnq6uhyLhE113wETl7HLQYF6IWQzqVm7SjGi2gTa9qDY0cJ7JepHg==
X-Received: by 2002:a05:6830:1316:: with SMTP id p22mr10842049otq.223.1588877711170;
        Thu, 07 May 2020 11:55:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y17sm1675843oou.13.2020.05.07.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:55:10 -0700 (PDT)
Received: (nullmailer pid 1054 invoked by uid 1000);
        Thu, 07 May 2020 18:55:09 -0000
Date:   Thu, 7 May 2020 13:55:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [PATCH v2 2/2] PCI: brcmstb: Drop clk_put when probe fails and
 remove
Message-ID: <20200507185509.GA913@bogus>
References: <20200221033640.55163-1-jaedon.shin@gmail.com>
 <20200221033640.55163-3-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221033640.55163-3-jaedon.shin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 21 Feb 2020 12:36:40 +0900, Jaedon Shin wrote:
> devm_clk_get* APIs are device managed and get freed automatically when
> the device detaches. so there is no reason to explicitly call clk_put()
> in probe or remove functions.
> 
> Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host
> controller driver")
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
