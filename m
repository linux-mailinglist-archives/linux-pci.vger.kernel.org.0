Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85AC1BE677
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 20:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgD2Sna (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 14:43:30 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:34104 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2Sna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 14:43:30 -0400
Received: by mail-oo1-f67.google.com with SMTP id q204so671008ooq.1;
        Wed, 29 Apr 2020 11:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yGhK3HaqbTPZiDc01w13tznQrtyKagfsL0YGpSLp9V4=;
        b=qQS1TnGkPBE0qnsrbWzX8vMQYMpRZs8ciWUughlZSecsMBmbmT2sVt3zQAmDh/fZS6
         uAcDCnYk1cHgJU+RLvGaeUfi5sZnDMsQQNLIsqSB7dq7tNTjeN49k9SbRABYRt53tDXk
         AmRaURe5czs4aTuyH9TIbHiSsNYiQiOSApLeqk1D2CnJLkXjRn48+dinKnhjIbHy6lzJ
         K5XYAx+r0iDI3bYCSm5Q/ZEYNk2bNGPmP0IH9H7RdhWI/L1nggz7XXCG7uh+aoGvSjOt
         0MySE+2S0CgIDVZyDDml577qToO0VnvfuQFTS6w9wsoJFX9OSkdHdW+a9G6X/w27Cjlm
         3M4g==
X-Gm-Message-State: AGi0PuYtn+/CJHfgBKYBLIxuTOk4EfY62HTw/pFcFgSHA6cnYLL3qt6+
        Sxid5U7/D/TMArIHgyJA7w==
X-Google-Smtp-Source: APiQypKdzbHafmOU5qNFDG4p8xvLwoSybYIgvKvM6RuUy3zuV5g1H8Ui3VJ5dMoccojZ7oRFV1ueAQ==
X-Received: by 2002:a4a:d0d6:: with SMTP id u22mr26838776oor.63.1588185807787;
        Wed, 29 Apr 2020 11:43:27 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c13sm627194oos.14.2020.04.29.11.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:43:27 -0700 (PDT)
Received: (nullmailer pid 14812 invoked by uid 1000);
        Wed, 29 Apr 2020 18:43:25 -0000
Date:   Wed, 29 Apr 2020 13:43:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] PCI: Add Loongson PCI Controller support
Message-ID: <20200429184325.64eyiubr3badd7uc@bogus>
References: <20200428011429.1852081-1-jiaxun.yang@flygoat.com>
 <20200428011429.1852081-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428011429.1852081-3-jiaxun.yang@flygoat.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 28, 2020 at 09:14:17AM +0800, Jiaxun Yang wrote:
> This controller can be found on Loongson-2K SoC, Loongson-3
> systems with RS780E/LS7A PCH.
> 
> The RS780E part of code was previously located at
> arch/mips/pci/ops-loongson3.c and now it can use generic PCI
> driver implementation.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> --
> v2:
> 	- Clean up according to rob's suggestions
> 	- Claim that it can't work as a module
> v3:
> 	- Fix a typo
> v4:
> 	- More clean-ups: Drop flag check, use devfn
> v7:
> 	- Fix ordering according to huacai's suggestion
> ---
>  drivers/pci/controller/Kconfig        |  10 +
>  drivers/pci/controller/Makefile       |   1 +
>  drivers/pci/controller/pci-loongson.c | 251 ++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-loongson.c

Reviewed-by: Rob Herring <robh@kernel.org>
