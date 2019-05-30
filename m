Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780023012F
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 19:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfE3Rpi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 13:45:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46674 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Rpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2019 13:45:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id z19so7961866qtz.13
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2019 10:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UgEoJIEOWgKSmNpnwJapd7xKMVBGEnMvpNqFuwdcHSY=;
        b=c14cNQY7a7g0KXxtQrpzFvgD33XZOwjo02Sgk8gXEjAhOUM5uAegj2VxSwtgIdexuF
         TavwAF8sGn2/r1Vl7GZfleqKaL4FhUv6Quz6PxhFQDP1X33Ht7n0y3zBOdiXBmIM5rJf
         qv6zFooaCSIVIB8Gt9vMO6lWjuX2C51L1N2stLILuaNRHiK6ejERPJ/dqF7L8tu1c8GA
         whCEgtz/oBC1ehtNUh5pM2xXMr9VmxMM8wgs4PBL56Gp7eY3a5h191wdwZ7fqi2CBbKf
         4ohBJRXkfoMzCVSgsgUB2UhgvRWRBtqORTQ42cIw09wkKaRc8Yqj5SEIN1pMjUDjYNe3
         qCgg==
X-Gm-Message-State: APjAAAWLZ2ZeDWW1jYm4JXLEqQgXKB7SH1miWXQT1FqbJus7g0iNKewl
        LHHNO9WxgXNpu0B8sd75OE/eEQ==
X-Google-Smtp-Source: APXvYqy9DfCkbHWFwnoJIZhnJEIk9jBDmoJOESod/F/vQr9Iv7gjOGLceZ55BmbRJubgQEOI/tivJw==
X-Received: by 2002:aed:3b5a:: with SMTP id q26mr4641355qte.158.1559238337003;
        Thu, 30 May 2019 10:45:37 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net. [100.0.197.103])
        by smtp.gmail.com with ESMTPSA id r186sm691141qkb.9.2019.05.30.10.45.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 10:45:35 -0700 (PDT)
Date:   Thu, 30 May 2019 13:45:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com,
        bhelgaas@google.com, frowand.list@gmail.com,
        kvmarm@lists.cs.columbia.edu, eric.auger@redhat.com,
        tnowicki@caviumnetworks.com, kevin.tian@intel.com,
        bauerman@linux.ibm.com
Subject: Re: [PATCH v8 2/7] dt-bindings: virtio: Add virtio-pci-iommu node
Message-ID: <20190530133523-mutt-send-email-mst@kernel.org>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
 <20190530170929.19366-3-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530170929.19366-3-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 30, 2019 at 06:09:24PM +0100, Jean-Philippe Brucker wrote:
> Some systems implement virtio-iommu as a PCI endpoint. The operating
> system needs to discover the relationship between IOMMU and masters long
> before the PCI endpoint gets probed. Add a PCI child node to describe the
> virtio-iommu device.
> 
> The virtio-pci-iommu is conceptually split between a PCI programming
> interface and a translation component on the parent bus. The latter
> doesn't have a node in the device tree. The virtio-pci-iommu node
> describes both, by linking the PCI endpoint to "iommus" property of DMA
> master nodes and to "iommu-map" properties of bus nodes.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

So this is just an example right?
We are not defining any new properties or anything like that.

I think down the road for non dt platforms we want to put this
info in the config space of the device. I do not think ACPI
is the best option for this since not all systems have it.
But that can wait.

> ---
>  .../devicetree/bindings/virtio/iommu.txt      | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
> 
> diff --git a/Documentation/devicetree/bindings/virtio/iommu.txt b/Documentation/devicetree/bindings/virtio/iommu.txt
> new file mode 100644
> index 000000000000..2407fea0651c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/iommu.txt
> @@ -0,0 +1,66 @@
> +* virtio IOMMU PCI device
> +
> +When virtio-iommu uses the PCI transport, its programming interface is
> +discovered dynamically by the PCI probing infrastructure. However the
> +device tree statically describes the relation between IOMMU and DMA
> +masters. Therefore, the PCI root complex that hosts the virtio-iommu
> +contains a child node representing the IOMMU device explicitly.
> +
> +Required properties:
> +
> +- compatible:	Should be "virtio,pci-iommu"
> +- reg:		PCI address of the IOMMU. As defined in the PCI Bus
> +		Binding reference [1], the reg property is a five-cell
> +		address encoded as (phys.hi phys.mid phys.lo size.hi
> +		size.lo). phys.hi should contain the device's BDF as
> +		0b00000000 bbbbbbbb dddddfff 00000000. The other cells
> +		should be zero.
> +- #iommu-cells:	Each platform DMA master managed by the IOMMU is assigned
> +		an endpoint ID, described by the "iommus" property [2].
> +		For virtio-iommu, #iommu-cells must be 1.
> +
> +Notes:
> +
> +- DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
> +  virtio-iommu node doesn't have an "iommus" property, and is omitted from
> +  the iommu-map property of the root complex.
> +
> +Example:
> +
> +pcie@10000000 {
> +	compatible = "pci-host-ecam-generic";
> +	...
> +
> +	/* The IOMMU programming interface uses slot 00:01.0 */
> +	iommu0: iommu@0008 {
> +		compatible = "virtio,pci-iommu";
> +		reg = <0x00000800 0 0 0 0>;
> +		#iommu-cells = <1>;
> +	};
> +
> +	/*
> +	 * The IOMMU manages all functions in this PCI domain except
> +	 * itself. Omit BDF 00:01.0.
> +	 */
> +	iommu-map = <0x0 &iommu0 0x0 0x8>
> +		    <0x9 &iommu0 0x9 0xfff7>;
> +};
> +
> +pcie@20000000 {
> +	compatible = "pci-host-ecam-generic";
> +	...
> +	/*
> +	 * The IOMMU also manages all functions from this domain,
> +	 * with endpoint IDs 0x10000 - 0x1ffff
> +	 */
> +	iommu-map = <0x0 &iommu0 0x10000 0x10000>;
> +};
> +
> +ethernet@fe001000 {
> +	...
> +	/* The IOMMU manages this platform device with endpoint ID 0x20000 */
> +	iommus = <&iommu0 0x20000>;
> +};
> +
> +[1] Documentation/devicetree/bindings/pci/pci.txt
> +[2] Documentation/devicetree/bindings/iommu/iommu.txt
> -- 
> 2.21.0
