Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A81342828
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 22:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhCSVtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 17:49:49 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:34622 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhCSVtX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Mar 2021 17:49:23 -0400
Received: by mail-il1-f182.google.com with SMTP id h1so9351983ilr.1;
        Fri, 19 Mar 2021 14:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TSxYsh/4QZo74CdzAGCwJNDM12S7BjJC925sJJZcFS4=;
        b=W1ZEPSBe59GA6KhO+MofCUE6zvL7b4kE7l1uXPNVZxhu0BGGXe+laXEMcuQFGv2v4q
         8eGbFMNpO3DqsNn4zLiqQcwH/y0xYF6TV483qzn+V2DkVMfbxl6EE6Ts1TJEOWqwgvjQ
         R72sQQgpaevknL12lQOgQm+aB2DlD42J9j1TCfuMng4ybXJs66T69bvbHYBWMw1DXKln
         BAHYyphSqlYTtt8DWk2NUpXXCCusCTetcwQpFu3PsIqFi2mmOnSpW46LnS736smleYPB
         Kvh/Vy9fc8WU7flt8mTdlzUAc29mBxbB4tWzS16JXhpgWKsgO0vFDOS2RLT9RbPaoLea
         PsVg==
X-Gm-Message-State: AOAM532a3DtiFpweEYSyqqaBNyPRSb5XqEpQ5AmY/Z9dZlamAoWT6m68
        18YTB57PtyhBzD6avXmxXg==
X-Google-Smtp-Source: ABdhPJxZEwHBaki7JZj8S9Wfx9Q661XX+EpH7c18EJM7O2uuvyzAg5xLz15/qRWghrDG07cN0A7Ovg==
X-Received: by 2002:a05:6e02:174b:: with SMTP id y11mr4340361ill.152.1616190562286;
        Fri, 19 Mar 2021 14:49:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j14sm3031599ilu.3.2021.03.19.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:49:21 -0700 (PDT)
Received: (nullmailer pid 1647634 invoked by uid 1000);
        Fri, 19 Mar 2021 21:49:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv@lists.infradead.org, zong.li@sifive.com,
        robh+dt@kernel.org, linux-clk@vger.kernel.org, hes@sifive.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        jh80.chung@samsung.com, vidyas@nvidia.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        lorenzo.pieralisi@arm.com, sboyd@kernel.org, bhelgaas@google.com,
        alex.dewar90@gmail.com, erik.danie@sifive.com, helgaas@kernel.org,
        palmer@dabbelt.com, khilman@baylibre.com, paul.walmsley@sifive.com,
        hayashi.kunihiko@socionext.com
In-Reply-To: <8008af6d86737b74020d7d8f9c3fbc9b500e9993.1615954046.git.greentime.hu@sifive.com>
References: <cover.1615954045.git.greentime.hu@sifive.com> <8008af6d86737b74020d7d8f9c3fbc9b500e9993.1615954046.git.greentime.hu@sifive.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host controller
Date:   Fri, 19 Mar 2021 15:49:12 -0600
Message-Id: <1616190552.561606.1647633.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 18 Mar 2021 14:08:11 +0800, Greentime Hu wrote:
> Add PCIe host controller DT bindings of SiFive FU740.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  .../bindings/pci/sifive,fu740-pcie.yaml       | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dts:45.29-30 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/pci/sifive,fu740-pcie.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1455121

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

