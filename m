Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9467D7F3B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 20:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbfJOSmr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 14:42:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33399 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfJOSmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 14:42:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id a15so17765334oic.0;
        Tue, 15 Oct 2019 11:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAHrLiAFlazwlF31Anvci8d6QY+LhAJg86S630nwFns=;
        b=hL/tauRjah5rVImtp8vS/9VeejEN8woHZBR1hPjhrKQ7TwzXztTrmmEVVKlknoNf/i
         kvPVPD3gaHqG1flXSvriGWutrhu/ERuOVLohVtHNgrev3J3/kc34Tr6t2/c+sotV6ere
         bEVpCowUoHcNZxd6mtgaVRMb1D/c3kpNt7P4CbtoG2qsF8XvJMR6Z77W45oQ/C8rO4ex
         DeIUnrb7WxbiPSvUVOlHWn/QI0wmUka4S6i6ueKFzxRPD5RDWqinZ18ecct/NuWeWoUD
         LxUKqMK6c6410By2aO4zQm4t2BGahgf6xgEPc90jWqlrSUcVXR66LxHiG158FV/3S6VP
         eM4w==
X-Gm-Message-State: APjAAAXcIsazgYCnw4QNhQ/Nfy6uYfvpCX746PmGfDnzFN2LJ2bvbitR
        Hwi9bSQQgEhVzPpSBt4k4Q==
X-Google-Smtp-Source: APXvYqwfHoEV7ttuKqHdAbUE09Jpc6mRk4X+QQqULjfnpK4q+69BAnmHmrAl97D3fg6fznbpbVrX0Q==
X-Received: by 2002:aca:d19:: with SMTP id 25mr15150oin.64.1571164964933;
        Tue, 15 Oct 2019 11:42:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l19sm6293550oie.22.2019.10.15.11.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 11:42:44 -0700 (PDT)
Date:   Tue, 15 Oct 2019 13:42:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-ntb@googlegroups.com
Subject: Re: [RFC PATCH 02/21] dt-bindings: PCI: Endpoint: Add DT bindings
 for PCI EPF Device
Message-ID: <20191015184243.GA10228@bogus>
References: <20190926112933.8922-1-kishon@ti.com>
 <20190926112933.8922-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926112933.8922-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 04:59:14PM +0530, Kishon Vijay Abraham I wrote:
> Add device tree bindings for PCI endpoint function device. The
> nodes for PCI endpoint function device should be attached to
> PCI endpoint function bus.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/endpoint/pci-epf.txt         | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt

This and the previous patch for the bus should be combined and please 
convert to a schema.

> 
> diff --git a/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt b/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
> new file mode 100644
> index 000000000000..f006395fd526
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
> @@ -0,0 +1,28 @@
> +PCI Endpoint Function Device
> +
> +This describes the generic bindings to be used when a device has to be
> +exposed to the remote host over PCIe. The device could be an actual
> +peripheral in the platform or a virtual device created by the software.
> +
> +epcs : phandle to the endpoint controller device
> +epc-names : the names of the endpoint controller device corresponding
> +	    to the EPCs present in the *epcs* phandle

Other than the NTB case, I'd expect the parent device to be the 
controller. Let's make NTB the exception...


> +vendor-id: used to identify device manufacturer
> +device-id: used to identify a particular device
> +baseclass-code: used to classify the type of function the device performs
> +subclass-code: used to identify more specifically the function of the device

Are these codes standard?

Powerpc has "class-code" already...

> +subsys-vendor-id: used to identify vendor of the add-in card or subsystem

Powerpc has "subsystem-vendor-id" already...

> +subsys-id: used to specify an id that is specific to a vendor
> +
> +Example:
> +Following is an example of NTB device exposed to the remote host.
> +
> +ntb {

This is going to need some sort of addressing (which implies 'reg')? If 
not, I don't understand why you have 2 levels.

> +	compatible = "pci-epf-ntb";
> +	epcs = <&pcie0_ep>, <&pcie1_ep>;
> +	epc-names = "primary", "secondary";
> +	vendor-id = /bits/ 16 <0x104c>;
> +	device-id = /bits/ 16 <0xb00d>;

These have a long history in OF and should be 32-bits (yes, we've let 
some cases of 16-bit creep in).

> +	num-mws = <4>;

Doesn't this apply to more than NTB?

Can't you just get the length of 'mws-size'?

> +	mws-size = <0x100000>, <0x100000>, <0x100000>, <0x100000>;

Need to support 64-bit sizes?

> +};
> -- 
> 2.17.1
> 
