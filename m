Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3799415CC8B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 21:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgBMUrM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 15:47:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42662 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgBMUrL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2020 15:47:11 -0500
Received: by mail-oi1-f193.google.com with SMTP id j132so7205250oih.9;
        Thu, 13 Feb 2020 12:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXUb9OkK0jyVXlwIZacZ5ml8iLKHL5sOLBosp9LkOuw=;
        b=iinFK52+BB//9nZLeChcdoJlu+7l8518EnWmayEfdLjRFznz2HfDhDPVLlOEKcgYAC
         NCM1Os5q2PNRBwrOshGjEIACF9Pq5HXARAGuaeDQQIRz9RLPzuEzuGhbv+SAxPth5eMG
         0hVt/LNwfvQFrXr7u4jgWQHhb8LvIMeh8RR0AnhSmWGE6IbBjUMhFm9DthT8LxiSilRu
         szL/mxkVbr+I5g4v6C1iloIxcszvgqHvpK7RlTFYc0nWn0rXjS9viCFbf0C2SOGa9pWA
         DrQCF03SAKj+iUIlZctRevbBItBDbJ4UqSd3ANtchsqPQ3ZUpxFl7WGFZ43Pt+tfm4HK
         AYhw==
X-Gm-Message-State: APjAAAVJUoNqog4VniFXg/KVOf8vvZydFQ4lQpYbFSFyZNYgQ79oc1Wv
        z+F7zqjhoP3f3XzLQl0A3g==
X-Google-Smtp-Source: APXvYqwG789BSM2bdMrY7tCbnbzbFJAtUdPIv2m1lllFDCiiHnH1f41Be9ptAltKdWOERzAIjQvefQ==
X-Received: by 2002:aca:f1c6:: with SMTP id p189mr4342232oih.159.1581626829428;
        Thu, 13 Feb 2020 12:47:09 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d131sm1168918oia.36.2020.02.13.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 12:47:08 -0800 (PST)
Received: (nullmailer pid 2814 invoked by uid 1000);
        Thu, 13 Feb 2020 20:47:08 -0000
Date:   Thu, 13 Feb 2020 14:47:08 -0600
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
Subject: Re: [PATCH v2 4/6] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <20200213204708.GA2363@bogus>
References: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
 <1581574091-240890-5-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581574091-240890-5-git-send-email-shawn.lin@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 13 Feb 2020 14:08:09 +0800, Shawn Lin wrote:
> From: Simon Xue <xxm@rock-chips.com>
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - fix yaml format
> 
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  | 148 +++++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dts:24.26-27 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1237300
Please check and re-submit.
