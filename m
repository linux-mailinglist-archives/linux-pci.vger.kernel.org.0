Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116EA3D435E
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 01:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhGWWjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 18:39:11 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:34556 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhGWWjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 18:39:10 -0400
Received: by mail-io1-f54.google.com with SMTP id y200so4493418iof.1;
        Fri, 23 Jul 2021 16:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c4/ACHDXtngSw4kQW/DbjWjELEQhTFt5Ht1gEy4Ju/k=;
        b=rTaum1ce9Ehs4GSXBdx+3DMeoaEYStGxPBLQ1E2E8OzuWjDdWeOmW+PKTiOexeuhMi
         LEco8AenPglR24uHlSemJqMXpN8jp5gcxBlSTG6H0FBXPt7IpFV9dozTPvBH1LlZd78Q
         x2aorKEzR1KnBD5UuepGw/SIP9v4qdbwSQxEbTGFc9gFCfn05q6inX++mU8gwImofOnK
         1ht1llDcyrf2J5NszmLBXZXhQcJdctBxxEbtNjeNZvOSrb0nWTJP1AOcd/JkvfVmFfRi
         aG6KQaN/0qUiEJKVuaknUmRyjM7t8nxhbgCnwet/gtT1GXo+BDSDP6Sp094xkrnoq9xx
         PFkw==
X-Gm-Message-State: AOAM5302WnDcN/nYjUNHypba9Ob02qKyzn2yjHifB1YRepMCJS+woUtf
        KD3Xbm2bbx4epSsXDJ8Bsw==
X-Google-Smtp-Source: ABdhPJxAOp8sW2OIdSo5NWF1ZguzM/+zqSGVn9NwZ/Wyv0Y2nCTv6kBgDTJxHsrfMOgAkpJrRXkrMg==
X-Received: by 2002:a6b:e90b:: with SMTP id u11mr5677739iof.134.1627082382592;
        Fri, 23 Jul 2021 16:19:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m184sm18831016ioa.17.2021.07.23.16.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 16:19:41 -0700 (PDT)
Received: (nullmailer pid 2795169 invoked by uid 1000);
        Fri, 23 Jul 2021 23:19:40 -0000
Date:   Fri, 23 Jul 2021 17:19:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, yuji2.ishikawa@toshiba.co.jp,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: pci: Add DT binding for Toshiba
 Visconti PCIe controller
Message-ID: <20210723231940.GA2793466@robh.at.kernel.org>
References: <20210723221421.113575-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210723221421.113575-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723221421.113575-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 24 Jul 2021 07:14:19 +0900, Nobuhiro Iwamatsu wrote:
> This commit adds the Device Tree binding documentation that allows
> to describe the PCIe controller found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/pci/toshiba,visconti-pcie.yaml   | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> 

There's now a DW PCI schema in my tree, so I updated the $ref to it and 
applied. The rest of the series can go in PCI tree.

Rob
