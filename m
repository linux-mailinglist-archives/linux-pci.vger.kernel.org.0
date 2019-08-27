Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037DA9F0CB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 18:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfH0Qx7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 12:53:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46209 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0Qx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 12:53:59 -0400
Received: by mail-oi1-f194.google.com with SMTP id t24so15472099oij.13;
        Tue, 27 Aug 2019 09:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/cWnSwSnizJoPptrMCxgyU0EGIA7FE8H3qBw7ZxkmMM=;
        b=FhlNulBcTRdzxP+A9ueXa99BmB0nmJD5lSOK6EK+cncRmhFudE7AjO4Z3STk6vKnPX
         wxDodSPIu3UX3Y9It+fkP1m5eqcw4IFlCT1MqGZI5ttem7yoX9LzTFBNMKYsbBrLS2j2
         cPhG8AYCq+tpSLBCES05HakH02jU++uee3/KGFF3JoR27PR8plF2p+X4eETGfOOrces/
         9NhDQsz4FDqmFH7KCw/OO1rnzPWw/xSsCDhojVmWHIV+U8B5KrdJa53sqbDUzV3m1Tz8
         jo0z4DIAhY9tlb+FXYHAVD34XmYvgL4b6Yn5pJHFMofGy4lQMfVkWJHqhVrevZ0SFFcL
         /DdQ==
X-Gm-Message-State: APjAAAUCFnMXgiHIXZNt+qyFfL6QMInDN/TBtiNCLstiwSACDtB4DXfM
        Kvffv2V4OVETpuIP4oD+Ng==
X-Google-Smtp-Source: APXvYqy/YlUNjEPP5QW/TvNLxzezivmnRm+zWoT/6RxwryHO+9wlLtBLicefYrG9cQNpNDQFaShGug==
X-Received: by 2002:aca:5f46:: with SMTP id t67mr16825090oib.42.1566924838416;
        Tue, 27 Aug 2019 09:53:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 44sm5772961otf.30.2019.08.27.09.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:53:57 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:53:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix misspelled words.
Message-ID: <20190827165357.GA31146@bogus>
References: <20190819115306.27338-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819115306.27338-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Aug 2019 13:53:06 +0200, Krzysztof Wilczynski wrote:
> Fix misspelled words in include/linux/pci.h, drivers/pci/Kconfig,
> and in the documentation for Freescale i.MX6 and Marvell Armada 7K/8K
> PCIe interfaces.  No functional change intended.
> 
> Related commit 96291d565550 ("PCI: Fix typos and whitespace errors").
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 2 +-
>  Documentation/devicetree/bindings/pci/pci-armada8k.txt   | 2 +-
>  drivers/pci/Kconfig                                      | 2 +-
>  include/linux/pci.h                                      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
