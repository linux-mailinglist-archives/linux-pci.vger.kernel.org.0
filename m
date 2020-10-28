Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE57A29D8B4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbgJ1Wf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:35:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39403 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbgJ1WeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 18:34:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id u127so1247633oib.6;
        Wed, 28 Oct 2020 15:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KK4JHKpclhDqWo+zj70zoLFW0u9q4vhE3OiG/X4mqyw=;
        b=FA1hUj/a6P7xQ1g0T60Dw+BDaIw5Ogrrl1ywmQCoSTYHVapFqPIT4mOfysx+/KqXII
         5aIImtaub6CHceES64QgRT11XedmY4Wynr3Eh9uIyfo32085ceI4FMUkWPopReClzHpV
         fUm37XEcfKQkmTIt+Dx1CRoSyZB8dgz1Dvwlwp6yTKFECPeMVuzc0IoRtEYXjtcp3FPA
         54wngS5pCcqGDOBbV4CFS4PbzkmKVW6QLxZSYjYb+GLbkvW7K/a8SX3CQufg19gDXmf/
         dfu3Vs/EnhB775F2ZIoflzO3R1Mpu2N0XF3kP5KyLu5DD97YQikzzQOomes6tZh3C6MP
         oVqA==
X-Gm-Message-State: AOAM530dbrksL1FJS6MLb3csYzwHZ8vqZAW/ov/vrobRMdeViI5C59K/
        HAlWyICs9BKxPB07l+OwHgfwtJr5jA==
X-Google-Smtp-Source: ABdhPJz3w1G6jnu8D3fmDgi9f1FaYU2/JqUmSa9HRXvIFMUox0/a7KLQiyto+W4ckcjbTmjHzRDwAA==
X-Received: by 2002:aca:ec92:: with SMTP id k140mr5466546oih.173.1603893443946;
        Wed, 28 Oct 2020 06:57:23 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm2174179oti.69.2020.10.28.06.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 06:57:23 -0700 (PDT)
Received: (nullmailer pid 3932870 invoked by uid 1000);
        Wed, 28 Oct 2020 13:57:22 -0000
Date:   Wed, 28 Oct 2020 08:57:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     robh+dt@kernel.org, bhelgaas@google.com,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Message-ID: <20201028135722.GB3932108@bogus>
References: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201027060011.25893-2-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027060011.25893-2-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 27 Oct 2020 14:00:10 +0800, Wan Ahmad Zainie wrote:
> Document DT bindings for PCIe controller found on Intel Keem Bay SoC.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/pci/intel,keembay-pcie-ep.yaml   |  86 +++++++++++++
>  .../bindings/pci/intel,keembay-pcie.yaml      | 120 ++++++++++++++++++
>  2 files changed, 206 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml:14:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
./Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml:17:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1388284

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

