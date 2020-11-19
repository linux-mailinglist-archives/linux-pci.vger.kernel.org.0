Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432882B93C4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 14:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKSNlE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 08:41:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46270 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgKSNlE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 08:41:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id g19so5244713otp.13;
        Thu, 19 Nov 2020 05:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pWdGWfb4zpjGFZh1QfFXdieL2Mv6UxsoCvWj7emmjHU=;
        b=pp+D3NH74vAZEOdu7M8Kboz0FZqhhGO9ZPa96X2zvwh+2cAjbIOvO8i4uHvMTKiVE8
         XENrBXwG82dTCE5hcbvj7WqFdrgNkGVIzv1dENZ8grJDurpZtJomoCBfuJE4zYmXzlya
         xqVjT0kc30JqBYkYoWQfvThK9P13Tvsc+Pl7gr24OIgxc9gfvw6kxyY8SwRQYkcBtaXV
         ynJnO0bO/iPdzux75P+5fgzX+sw9iB7RSTYs+YurEwv+QM7OvcH/petpSH56xkovsF6i
         PYCT0N8X0w9a1s1Pl3+fUybwvCCJBoJ9fLOPxL135jvt5YWK3mDOLoYA/9PwKfWYN4/B
         erEw==
X-Gm-Message-State: AOAM531asHOeaRXHTwqyIG+h3lSgSqI2P3oJaaNWUG82SB6l5jEfYZeg
        Mqi6cD34b1A6gS5fvAJTqg==
X-Google-Smtp-Source: ABdhPJwY0cOrzBmWr+JQmUb/kibZ8NUexFRKYvq1K3uR9TZzGyI5uyHE1FlS5y39c5cQ+p+HjUB+IQ==
X-Received: by 2002:a9d:3ef7:: with SMTP id b110mr9685285otc.333.1605793263242;
        Thu, 19 Nov 2020 05:41:03 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r3sm8531611otn.67.2020.11.19.05.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 05:41:02 -0800 (PST)
Received: (nullmailer pid 3148367 invoked by uid 1000);
        Thu, 19 Nov 2020 13:41:01 -0000
Date:   Thu, 19 Nov 2020 07:41:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: ti, j721e: Fix "ti,
 syscon-pcie-ctrl" to take argument
Message-ID: <20201119134101.GA3148079@bogus>
References: <20201116173141.31873-1-kishon@ti.com>
 <20201116173141.31873-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116173141.31873-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 Nov 2020 23:01:39 +0530, Kishon Vijay Abraham I wrote:
> Fix binding documentation of "ti,syscon-pcie-ctrl" to take phandle with
> argument. The argument is the register offset within "syscon" used to
> configure PCIe controller.
> 
> Link: Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml     | 12 ++++++++----
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 ++++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml:36:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml:36:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1401067

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

