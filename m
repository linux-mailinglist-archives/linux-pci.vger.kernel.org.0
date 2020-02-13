Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7803A15CC87
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 21:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBMUqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 15:46:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36679 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgBMUqs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 15:46:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so6982490otq.3;
        Thu, 13 Feb 2020 12:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=psOJlEetPRDRoxsa3f+Z8M0f2xosSTP4cPy/vWR0Ruw=;
        b=frGAp2w+3vPCQYLYraGhrJl0AZQoez+wt0ZQD78OlBsY6pxoYW+ZhrJPLDVhEuQzYF
         nsQp3dX3XU9YnXoEHUGF6t3r4YAx3vXq2ZIQ9WtC8QVB6GEZkzmSyChl7SsHUOXL6n/v
         8/byM8WTBAUR2dX6hZQ1+Qhx+gFyhFagQQClusnjf4cFWZd+ppHm69+7Us41mclQVTFD
         fPiVa4dFZiD358LKM7m6F47nGHat91vyb1VS4ak+z0pSB/1nPsfV0nnfHNFOuUmKvL9/
         tnyx2Tg8RbN22u6ILofvMqhPMgRJOvglRnYl5qVuv3c2jXEVjHmwPTgdD9PYaJXit8ld
         tYkg==
X-Gm-Message-State: APjAAAWu4egd80So3Rw0Ln3rTlUZXYnbgcCA/LpCRlfTlEyyquDqYeIa
        hupxquIBOkk3X8/2J+RU+g==
X-Google-Smtp-Source: APXvYqy3sULmd5uqt/It774SbZe5Ly/Pz/6iKyGVw2itxbD64l7g6iG5gYX82BL71oueLveaCZg7wQ==
X-Received: by 2002:a9d:784b:: with SMTP id c11mr14104655otm.246.1581626807462;
        Thu, 13 Feb 2020 12:46:47 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p83sm1038787oia.51.2020.02.13.12.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:46:46 -0800 (PST)
Received: (nullmailer pid 2194 invoked by uid 1000);
        Thu, 13 Feb 2020 20:46:46 -0000
Date:   Thu, 13 Feb 2020 14:46:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: add binding for Rockchip combo phy
 using an Innosilicon IP
Message-ID: <20200213204646.GA316@bogus>
References: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
 <1581574091-240890-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581574091-240890-2-git-send-email-shawn.lin@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 13 Feb 2020 14:08:06 +0800, Shawn Lin wrote:
> This IP could supports USB3.0 and PCIe.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - fix yaml format
> 
>  .../bindings/phy/rockchip,inno-combophy.yaml       | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/phy/rockchip,inno-combophy.example.dts:21.28-29 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/phy/rockchip,inno-combophy.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/phy/rockchip,inno-combophy.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1237296
Please check and re-submit.
