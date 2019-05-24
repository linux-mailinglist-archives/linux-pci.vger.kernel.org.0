Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8984129FC7
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbfEXUXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 16:23:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40502 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403762AbfEXUXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 May 2019 16:23:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id u11so9821760otq.7;
        Fri, 24 May 2019 13:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yoB0L3qe36S2IhBoaOpwEJu+NSznEiRoc0Yquw1YBGY=;
        b=P3eXJvDoJn+fgNCnmKj6jTepCycuoFfWmIcg8dodiBorpp7EaMwbgawn8VJdvkHMAN
         i1JBNExBsqttLHiyhSLfsme8onhFnCLKoV7BsxtTDg6cDbR62M4cRGkXQxHpZYj+TQlj
         8IFWAHr5ug73oCSQnfQdhTwlw75tWwhLTabYzA0oCxdj+V+5QZkxn8bRT53yyCyLHCan
         MUjAANQ1PkkACrTdeK/YblZGBJsHK2yln8+llU4rxjwv2yKRAivvfBEncgOdPJvk2CDS
         v6zz64O6IBigNAs/6kYpC6JrVJFl/Gbd1HOy98HC/KaOhUjEBPXUhACfbUKfn+/V7kME
         XFgg==
X-Gm-Message-State: APjAAAWWDOh+xU/rhaBv+5kipoO6P25otz2MDamXou0jdAGFhyO7maqG
        A/TRY4r5Njjpc615sTnTVw==
X-Google-Smtp-Source: APXvYqx0cRVBGu29WLtO7LQL9zHXwDoo3Y1496B2qClf9uMx1CjkdOw+AKOuxaRyoDl6F19tKtn2HA==
X-Received: by 2002:a9d:6a10:: with SMTP id g16mr64874698otn.203.1558729426956;
        Fri, 24 May 2019 13:23:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r205sm1371259oig.0.2019.05.24.13.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 13:23:46 -0700 (PDT)
Date:   Fri, 24 May 2019 15:23:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, vidyas@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 06/15] dt-bindings: PCI: designware: Add binding for
 CDM register check
Message-ID: <20190524202345.GA24243@bogus>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-7-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-7-vidyas@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 May 2019 18:08:37 +0530, Vidya Sagar wrote:
> Add support to enable CDM (Configuration Dependent Module) registers check
> for any data corruption. CDM registers include standard PCIe configuration
> space registers, Port Logic registers and iATU and DMA registers.
> Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
> Version 4.90a
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v6]:
> * Changed "enable-cdm-check" to "snps,enable-cdm-check"
> 
> Changes since [v5]:
> * None
> 
> Changes since [v4]:
> * None
> 
> Changes since [v3]:
> * None
> 
> Changes since [v2]:
> * Changed flag name from 'cdm-check' to 'enable-cdm-check'
> * Added info about Port Logic and DMA registers being part of CDM
> 
> Changes since [v1]:
> * This is a new patch in v2 series
> 
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
