Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 628B3F08C2
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 22:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfKEVxg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 16:53:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35965 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfKEVxf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 16:53:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id f10so328995oto.3;
        Tue, 05 Nov 2019 13:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PF4FeC1B4z1EiaRv3Y35zGiHOndPSUjKYmW93QdFA+M=;
        b=W3aNdqLajxEyB8I4UPgKLYzuoyY3Q+poRVYkGbKrkyI4gSQkx1Pwf3ris3o2d0anqH
         AccteWr7cFVgPg3AY0oEhzH51UwMCe3RJU7/g6i4evCXjU3M00ivJ4c+dBZVFWG7djiq
         yIDZzF7MS2iLd3KwXH7zaD7kLFU1lBa0m/p7Mm8Fnakjl3fAh/S3jzBZA3JIMTCvd7Ua
         W2A7D5EYTsSFxo1PFW7/ORwhZk0IiwzAj8znJQH6EEtWzlg1FCiREkWtd6+xx7x8SJqv
         DvOF3DfgpyYbPHdSHQBharofokpYEZ73Z2rCCaxdokd7tMX2AvwMI+5kLEB6HnhpxR64
         H6DQ==
X-Gm-Message-State: APjAAAWxEr4zarx6fssTl5lQQ1/j3P+FE7HBJunH5lXDUBVguZ8wuEHs
        a9eFbAWWmNDr/Se4xA6BHaWeErI=
X-Google-Smtp-Source: APXvYqxAH3UBa4/0bcwAn6bLPBmEdgRBtQ7i/IwCz6UAPAR2oM/wv9oufNgH2AZpJHzNTbjp3PGc6w==
X-Received: by 2002:a05:6830:4cf:: with SMTP id s15mr8462573otd.261.1572990813789;
        Tue, 05 Nov 2019 13:53:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l17sm5861342oic.24.2019.11.05.13.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:53:33 -0800 (PST)
Date:   Tue, 5 Nov 2019 15:53:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anvesh Salveru <anvesh.s@samsung.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        pankaj.dubey@samsung.com, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: designware: Add binding for
 ZRX-DC PHY property
Message-ID: <20191105215332.GA19296@bogus>
References: <1572264988-17455-1-git-send-email-anvesh.s@samsung.com>
 <CGME20191028121748epcas5p3054c9583c14a2edde9f725d005895a04@epcas5p3.samsung.com>
 <1572264988-17455-2-git-send-email-anvesh.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572264988-17455-2-git-send-email-anvesh.s@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 28, 2019 at 05:46:27PM +0530, Anvesh Salveru wrote:
> Add support for ZRX-DC compliant PHYs. If PHY is not compliant to ZRX-DC
> specification, then after every 100ms link should transition to recovery
> state during the low power states which increases power consumption.
> 
> Platforms with ZRX-DC compliant PHY can use "snps,phy-zrxdc-compliant"
> property in DesignWare controller DT node.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Change in v2: None
> 
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 78494c4050f7..9507ac38ac89 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -38,6 +38,8 @@ Optional properties:
>     for data corruption. CDM registers include standard PCIe configuration
>     space registers, Port Logic registers, DMA and iATU (internal Address
>     Translation Unit) registers.
> +- snps,phy-zrxdc-compliant: This property is needed if phy complies with the
> +  ZRX-DC specification.

If this is a property of the phy, then it belongs in the phy node or 
should just be implied by the phy's compatible. IOW, you should be able 
to support this or not without changing DTs.

Is this spec Synopys specific? (About the only thing Google turns up are 
your patches.) If not, then probably shouldn't have a 'snps' prefix.

>  RC mode:
>  - num-viewport: number of view ports configured in hardware. If a platform
>    does not specify it, the driver assumes 2.
> -- 
> 2.17.1
> 
