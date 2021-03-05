Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E336A32F696
	for <lists+linux-pci@lfdr.de>; Sat,  6 Mar 2021 00:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCEX0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 18:26:14 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37338 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhCEXZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 18:25:49 -0500
Received: by mail-ot1-f47.google.com with SMTP id 75so186223otn.4;
        Fri, 05 Mar 2021 15:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mb/bHLHRlD1QhUjsA/kL7M011uwxJwJbkWKDR1d1xxQ=;
        b=o10KzD98iNHDGoweh8YqxI4lEUs0ofOiw+xfVwakjf6A5qrv/JspAG8thXzZNKWT/Q
         eglTL4a5AbyYMQzvSo90Y50PU8GnkN67wlYCodVXb+IYL/vjm1Maf95CGxT8wgCvA2se
         co1OfhDWGuTV/rOzFuZaIzIFlimxRzzIcb/c7MSaaZapi//qawmQXwosg+5bW4GPWX6K
         UCP0OYH3I37q2XllWncvUwrmR5Z9g+Tf8FqFVqZVCq27GbRRPVYkj7sIFymZhwkfIczE
         RFyUS0ZNyEvFUaNv1D6LMja0qRq1CnlWzyHR3fv7irtQ4aWVACw69qHIUgrvt0F5Ue2L
         wgpw==
X-Gm-Message-State: AOAM530qtN5FVkISycYHAYjkwE4gKKtbsx3ORY0Og3tEFKrR7pIWFZ8v
        FckhmzPhZ58EUHZ7GCVi3V/up/a21g==
X-Google-Smtp-Source: ABdhPJx1AqrTrxCgGfAxgOvLtnbl3D/Y4pWyJcFyQrRf1ZvWbsAjlcom7dlm1cSekmmuXhE1nwRhXQ==
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr9345356oti.95.1614986749320;
        Fri, 05 Mar 2021 15:25:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q65sm881483oia.0.2021.03.05.15.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:25:48 -0800 (PST)
Received: (nullmailer pid 834554 invoked by uid 1000);
        Fri, 05 Mar 2021 23:25:46 -0000
Date:   Fri, 5 Mar 2021 17:25:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     robh+dt@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <20210305232546.GA834502@robh.at.kernel.org>
References: <20210222071721.30062-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222071721.30062-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Feb 2021 15:17:21 +0800, Simon Xue wrote:
> Document DT bindings for PCIe controller found on Rockchip SoC.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
