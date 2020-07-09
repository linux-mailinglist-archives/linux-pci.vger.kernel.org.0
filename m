Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ABC21A55C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgGIRAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 13:00:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38565 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGIRAl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 13:00:41 -0400
Received: by mail-io1-f66.google.com with SMTP id l1so3084655ioh.5;
        Thu, 09 Jul 2020 10:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J57B4SYSeZSds0MiAw/eWQKxFfmLvKjSluZG4Rx7dM0=;
        b=m4YRvSMUURKSZ5R7Js7iwtbdrlp9PDTmPRbU/+sRmokivsT+Rd7i9aUKXS6iyHb5nf
         BilinT6rXc6++EgqnZRyaTMbehJB0tCngqzQr9Ut3MUqCfrOn9E1KFrIwaLY3fcoLIR+
         Ef1inw062uVbLNMdTuDacU3p5qAW1L/4HIbyzS6Vz6ThR8Bm3GF032q0OGl/PybAcydt
         rfPbUUk3ImtGujVLLsX9s8cX4ltWxM5qM+qTwQfelt+gJB2cKPQ7gqn4fXyZmr8zvXF1
         X/CTXSS2nSDFOzFsHOKLJgODU1cqY6kPgeEDvQDFA7wtfZKfyetlaDgWErixwq4NPPB7
         WIkw==
X-Gm-Message-State: AOAM532kQx2wp3eDbY3yLCO8vOfGs6ZxlA+M7RMFNsXQICgdl9chkkd5
        MvyYYhuYtJMREWLpgQHplL6xHdJJjg==
X-Google-Smtp-Source: ABdhPJym5BpBPRGl0IaG+oewAoSKHMUJvqWWhGsC8UTGI1GS5iPctaV9bpzLjDfYKxDsWZrvRq4bOQ==
X-Received: by 2002:a05:6638:2649:: with SMTP id n9mr37825758jat.126.1594314040162;
        Thu, 09 Jul 2020 10:00:40 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id c25sm2438583ioi.13.2020.07.09.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:00:39 -0700 (PDT)
Received: (nullmailer pid 518350 invoked by uid 1000);
        Thu, 09 Jul 2020 17:00:35 -0000
Date:   Thu, 9 Jul 2020 11:00:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 11/14] dt-bindings: PCI: Add EP mode dt-bindings for
 TI's J721E SoC
Message-ID: <20200709170035.GA518075@bogus>
References: <20200708093018.28474-1-kishon@ti.com>
 <20200708093018.28474-12-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708093018.28474-12-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 08 Jul 2020 15:00:15 +0530, Kishon Vijay Abraham I wrote:
> Add PCIe EP mode dt-bindings for TI's J721E SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.example.dt.yaml: example-0: pcie-ep@d000000:reg:0: [0, 42991616, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.example.dt.yaml: example-0: pcie-ep@d000000:reg:1: [0, 43020288, 0, 1024] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.example.dt.yaml: example-0: pcie-ep@d000000:reg:2: [0, 218103808, 0, 8388608] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.example.dt.yaml: example-0: pcie-ep@d000000:reg:3: [0, 268435456, 0, 134217728] is too long


See https://patchwork.ozlabs.org/patch/1325133

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

