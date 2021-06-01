Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32C4397B49
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhFAUfA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 16:35:00 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:34427 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbhFAUfA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 16:35:00 -0400
Received: by mail-oi1-f174.google.com with SMTP id u11so648383oiv.1;
        Tue, 01 Jun 2021 13:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QrEdnEwQRqeosY6gkgi2Hdn7Yt87QUVcHOSzMSN62Lc=;
        b=UXZZ7yM5rb5UF4dAKI+gyk1nmHOyM5gNapMHOSLvwDsUzatNc/eLQKpxILuV0YjEfT
         RbAz66LsO+0GSLCeSKZhw21wBR5H8WsWKgeVgV0CI2jkxdyKfJUR0uFxebn+IWAePo+n
         SVMCtoDU4VEVtwlXCddnKoWk8XqtsVyub1c9E2HIXtDkqRO/LJ16bJ+ffi8geXZcAEQ8
         SKe6q9U1UYYNV0J8Zy+36Bf25g0PjY8Rn7mzbHPT+Rlv+TcCgyFafEYPJSKQ9qdBWDDH
         6o8/DUtgDK5tVCtUi78DZoeXqfUfYIVrTAeYz2VqFPLC1IrHO5HXVOklxNo2ecms2xQU
         PPtQ==
X-Gm-Message-State: AOAM533y/TQaZGOho4YmGjUbSLXNMeMP886FwHnPM8mmHaO2XinIgRL7
        9pfBCp26LgRkG7aHkm0qdf1yGYB+gA==
X-Google-Smtp-Source: ABdhPJwC3oC7hefJFsHAhMPWQ6kmcmL5EL4tOd4wqe3rJZvXBFChtRBITnFPHbbFFjAGtpaQ8LQBdw==
X-Received: by 2002:a05:6808:1394:: with SMTP id c20mr18806663oiw.90.1622579596906;
        Tue, 01 Jun 2021 13:33:16 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 7sm3907126oti.30.2021.06.01.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:33:16 -0700 (PDT)
Received: (nullmailer pid 984921 invoked by uid 1000);
        Tue, 01 Jun 2021 20:33:14 -0000
Date:   Tue, 1 Jun 2021 15:33:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     linux-pci@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        robin.murphy@arm.com, devicetree@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>, maz@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
Message-ID: <20210601203314.GA977583@robh.at.kernel.org>
References: <20210530224404.95917-1-mark.kettenis@xs4all.nl>
 <20210530224404.95917-2-mark.kettenis@xs4all.nl>
 <1622554330.029938.242360.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622554330.029938.242360.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 01, 2021 at 08:32:10AM -0500, Rob Herring wrote:
> On Mon, 31 May 2021 00:44:00 +0200, Mark Kettenis wrote:
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > The Apple PCIe host controller is a PCIe host controller with
> > multiple root ports present in Apple ARM SoC platforms, including
> > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  .../devicetree/bindings/pci/apple,pcie.yaml   | 167 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 168 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pci/apple,pcie.example.dts:20:18: fatal error: dt-bindings/pinctrl/apple.h: No such file or directory
>    20 |         #include <dt-bindings/pinctrl/apple.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Looking at the example, I don't think you need this header. Looks like 
irq.h is needed though.

Otherwise, LGTM.

Rob

