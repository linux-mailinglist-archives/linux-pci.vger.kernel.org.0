Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F292D18D6
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 19:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgLGS4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 13:56:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43667 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgLGS4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 13:56:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id q25so1692643otn.10;
        Mon, 07 Dec 2020 10:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jYKdPSvZjpIiPbVZhXmqc2j76RFh4wXSWnm0PlBYAnE=;
        b=Z39OpqLW8DFiyjS998uYGx7yV9CaoJ6CB3vqIhUR7AoKj4b94CowyDILTxij5oy+FD
         dtUjSBjWIrNiqQUrBAmTd+uFYhm67Ukb3yRymUn/x8+8/wVA0LQusZzmA9HDixnR0Xyi
         3Piapd4vLNiSNtKQofK9rJ3vHdOv/+Hct0dJYLn9rnTGaRNL+dlunk2d4XQWeBMqmB7D
         LiIdUPhqxnsw1HkGcbEsAV973nFhqA3CO0zYnBDKjl0eTlSn6MPo6S/Px43lVUm2ewE6
         o17v6elkCNWIm/vl/iE25do+AyvSob1yEOR1OZPSyeHAPcvv2lG4Bhhc3Rxi4RGCE11o
         4lcQ==
X-Gm-Message-State: AOAM533otl+9OCHicf0q08pMd/6D0HRkJ0tHop0CMUjqoPLHEwpQQglg
        q5N8COSX8iZo+pHVpnge4XW7CsWb+g==
X-Google-Smtp-Source: ABdhPJz/ljYtKFGmvSgmn4Lys4Ug3P+P2nQy5R4djRcCMl2NVsn0vyrFdDgT0CIZTb6Yp59q9uNiOw==
X-Received: by 2002:a9d:7a97:: with SMTP id l23mr13992794otn.232.1607367363221;
        Mon, 07 Dec 2020 10:56:03 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i4sm2780609oos.31.2020.12.07.10.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 10:56:01 -0800 (PST)
Received: (nullmailer pid 617149 invoked by uid 1000);
        Mon, 07 Dec 2020 18:56:00 -0000
Date:   Mon, 7 Dec 2020 12:56:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: pci-ep: Add binding to specify
 virtual function
Message-ID: <20201207185600.GA609331@robh.at.kernel.org>
References: <20201112175358.2653-1-kishon@ti.com>
 <20201112175358.2653-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112175358.2653-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 12, 2020 at 11:23:53PM +0530, Kishon Vijay Abraham I wrote:
> Add binding to specify virtual function (associated with each physical
> function) in endpoint mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> index 7847bbcd4a03..90c85a0c44a1 100644
> --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> @@ -23,6 +23,15 @@ properties:
>      default: 1
>      maximum: 255
>  
> +  max-virtual-functions:
> +    description: Maximum number of virtual functions that can be configured

Need to say what each element of the array corresponds to.

> +    allOf:

Can drop 'allOf' here.

> +      - $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 0

minItems should never be 0. That's no property present.

> +    maxItems: 255
> +    items:
> +      maximum: 255
> +
>    max-link-speed:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [ 1, 2, 3, 4 ]
> -- 
> 2.17.1
> 
