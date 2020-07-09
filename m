Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4821A874
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgGIUBy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 16:01:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42804 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgGIUBx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 16:01:53 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so3631819ioi.9;
        Thu, 09 Jul 2020 13:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xeNIzCxecgmXImhaJRqvLh/KGwYG57ukd7yr//dknS0=;
        b=h5waMCer0qdhoM15Hq84gXnUk3t1XktCUSAsuht2POUl/y2wgqY6Kk72k3MObB0loS
         mkIaL/9DHHAq+csSr3FF3nG+OdTEMgBEIHLtyErtaB7qt/xpx30S/U8Kv0yrJ5/gCWgC
         eo1do5SluhXjIuXhFL/lGX2WLSfIJfUP4sOobmBqMyrfzD/sJaKANhw7a6LC19KulTOc
         yyE8SoSnw80MV2KJWICYEu3qbs0LPoFgBowjuqnYho8FXCy18a1CbbqbUe8XZfJuQ3px
         sNfBxvQKUXJfAPh0NkD4KBk9CjMu3kskQs7/FcOs3jRCMC8vv5br0NAdwq6+Ncb+i5dz
         v9gQ==
X-Gm-Message-State: AOAM533Xq/d6YxlGELXpsmAH3tDyePneg/WKUyQJATe/1NbLkU2fRmt4
        Y1SQpqfYYiXZdHlRvYRkLg==
X-Google-Smtp-Source: ABdhPJwl/rtDoU9qekYtssM+1MFvQTDBJOuByIVOO84pDJxlZ6+xotQF5w5V++TMgcCWgVWVB+UOmg==
X-Received: by 2002:a02:9109:: with SMTP id a9mr38571889jag.130.1594324912994;
        Thu, 09 Jul 2020 13:01:52 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id x71sm2478937ilk.43.2020.07.09.13.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:01:52 -0700 (PDT)
Received: (nullmailer pid 797627 invoked by uid 1000);
        Thu, 09 Jul 2020 20:01:51 -0000
Date:   Thu, 9 Jul 2020 14:01:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com, bhelgaas@google.com,
        robh+dt@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 1/2] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Message-ID: <20200709200151.GA797573@bogus>
References: <56d2a9855f93455c6150b92682178c93fe70ed72.camel@microchip.com>
 <c769cbe749bc815922d5da3ece0f378bc01f532a.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c769cbe749bc815922d5da3ece0f378bc01f532a.camel@microchip.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 08 Jul 2020 14:59:22 +0000, Daire.McNamara@microchip.com wrote:
> Add device tree bindings for the Microchip PolarFire PCIe controller
> when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
