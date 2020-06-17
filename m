Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279451FD31F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFQRHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 13:07:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33651 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQRHl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 13:07:41 -0400
Received: by mail-io1-f68.google.com with SMTP id i25so3702407iog.0;
        Wed, 17 Jun 2020 10:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aa7D83B/ClCWcQNqJL006J66fB/5CW+TLd1mIIzTwg4=;
        b=GTXaIPm+n4GA66IZS6ZHj5dRnFBfOXIlDgaYcZilUzQ9juSJRclwvzJYmSbIC1n3Su
         gMRDulsKLd4MNRvt/h9E2XXhjJ6TPnyxCND67VsA6v2cGVUEvXs6rxeMOkcbRUnzf1rd
         cC2mi0n1/IjBVQQMDHdFQb+aOD+xMBHtxC4vUKj+l1k50FsX2US6fNRyo9d6c97yN26y
         cSQwk+wcPfZxcvwzvtNg8NEYOphTfJ3ZDWgE8joWtxfK0iU0OKFse8je/yk9LFLojB+K
         qI/Xaq/YdtcjxQE6kV5c6lq1ASl2PeUw+2wqeo0BJ8AJOI+SyoGVhxc9wYDgqKj6sSPa
         egWA==
X-Gm-Message-State: AOAM5308cy67gwQjD/ink0qq2JZaRJRJXDfCPvQ2MtBuqRfBgPsysHu5
        PMcMX3E1o2FJ1hmbjDac5P8lFi03kA==
X-Google-Smtp-Source: ABdhPJzk1bhDyxnqHb8lYcC/GMKocSvjEgnDTMrCBJR4RW71d1k8lcFxEZvVowy7fZRj+n4S8Jk/ZA==
X-Received: by 2002:a05:6602:22d6:: with SMTP id e22mr389380ioe.128.1592413660462;
        Wed, 17 Jun 2020 10:07:40 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l12sm120363ilj.8.2020.06.17.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:07:39 -0700 (PDT)
Received: (nullmailer pid 2315363 invoked by uid 1000);
        Wed, 17 Jun 2020 17:07:38 -0000
Date:   Wed, 17 Jun 2020 11:07:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     paulburton@kernel.org, tsbogend@alpha.franken.de,
        devicetree@vger.kernel.org, kstewart@linuxfoundation.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, jonas.gorski@gmail.com,
        linux-kernel@vger.kernel.org, info@metux.net, tglx@linutronix.de,
        allison@lohutok.net, linux-pci@vger.kernel.org,
        jiaxun.yang@flygoat.com, bhelgaas@google.com,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Document BCM6328 PCIe Host Controller
Message-ID: <20200617170738.GA2315041@bogus>
References: <20200617102556.3792821-1-noltari@gmail.com>
 <20200617102556.3792821-3-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617102556.3792821-3-noltari@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Jun 2020 12:25:55 +0200, Álvaro Fernández Rojas wrote:
> BCM6328 PCIe host controller is found on BCM6328, BCM6362 and BCM63268 SoCs.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  .../bindings/pci/brcm,bcm6328-pcie.yaml       | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.example.dts:38.49-50 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/pci/brcm,bcm6328-pcie.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1311090

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

