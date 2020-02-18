Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0014616348F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 22:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgBRVNv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Feb 2020 16:13:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39649 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRVNv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2020 16:13:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id z2so21610187oih.6;
        Tue, 18 Feb 2020 13:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wsp21LIcG4NslijziS7uyMDJScAYzOtQaO+9/p80IQ4=;
        b=Gn4kmXJu9n+uXGhlbfM9KPlbi5ycH4xKUSLbngI4euPIE/5WlodKz25tj2XHe1BQO8
         xNzavCIzz50qIB4nBht9+qyPoznu+UM5iZJpOPhWXkcCefa11U9uAvyp9KX4x7RHosXu
         ShT7FMEoKFxuF6MvwgiDECAgw0JFNbMTsZLKuTFWydWxE2kxBscJDniJI1iEWC7KZNbz
         FvwBxrIX/2PTtvmP1PgWhGZaBZ0OXkhhn7NxL+Us5Ynp9mw5uBTRK98RjrHd9HiKj7NN
         /+5SDiP3j1Y6qdoO9BWRQqw7Ss4OaWpcXRfVBSTBiUWAQHExlu6cGNtvL4SUmm8mWgOz
         QBKA==
X-Gm-Message-State: APjAAAWWY1wTEeRHNyBSUA2BVamo+lEiKfdwaABl5FjrZE7d5F4kIiIr
        RJ330liDWIbi5LpjPN7Ciw==
X-Google-Smtp-Source: APXvYqzV9oocyBJZGvkp1bADAbLS2xQl21KF+EyRyietsBdKoEM/3HRmoC9kQcpKj2d8Pz3raOUtlA==
X-Received: by 2002:aca:3542:: with SMTP id c63mr2575156oia.135.1582060430256;
        Tue, 18 Feb 2020 13:13:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m185sm13530oia.26.2020.02.18.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:13:49 -0800 (PST)
Received: (nullmailer pid 15304 invoked by uid 1000);
        Tue, 18 Feb 2020 21:13:48 -0000
Date:   Tue, 18 Feb 2020 15:13:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Andrew Murray <andrew.murray@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car
 PCIe  endpoint controller
Message-ID: <20200218211348.GA15246@bogus>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200208183641.6674-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208183641.6674-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat,  8 Feb 2020 18:36:39 +0000, Lad Prabhakar wrote:
> This patch adds the bindings for the R-Car PCIe endpoint driver.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/pci/rcar-pci-ep.yaml       | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
