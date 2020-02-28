Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9556173B9C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgB1Pil (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:38:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38102 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgB1Pil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:38:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id 2so3237817oiz.5;
        Fri, 28 Feb 2020 07:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kzp8PYWkgcEJuLkvHiddGePNM790Izf5gnCAE/DVflQ=;
        b=uDqUwyGTBDpvp+WTDp6c1tmoU5zGbVgN8n0fQ59l9zPph+WKBgqcozNkK8yxrWbmhH
         R7JKcVtzyK6Ogl8hnUrA50OA3sbfE+nR9ZC02c+h378oIf++Y0Nog7vMgYZd/rkMJgqL
         JLEsu1e92ilvAUqlTtqT0tz7iR34MdHwPwJKKY1STsvy4s5SxsF8wneJW7qReaw/wccM
         y35wTBYYBshcHgpEHoHC9acKlrOfgx8lcOV61mBtD03Q/RWokOvEkqojwXfYAQPIL8h5
         BW4L7tBEjs+g24J64hJlOGZPatliJuiia01BBhWwa+58/PCQrYjEHo08xBn3R+zM1nix
         tigA==
X-Gm-Message-State: APjAAAUthaNfwT6bitlyGTGCqdk/ofeyI7lEexnGlPkU7Urf1fqt43Zh
        J/o6Jj4AiFmtzG4IxU8WDw==
X-Google-Smtp-Source: APXvYqyFCbbaWxASGjgkqt8CGTYQw2r42ByREAdAYeAbwJV5wm5PWr4vDTIgmOlKhTkJfMbEiPNjcg==
X-Received: by 2002:aca:cd46:: with SMTP id d67mr3640911oig.156.1582904320355;
        Fri, 28 Feb 2020 07:38:40 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a26sm1571820oid.17.2020.02.28.07.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:38:39 -0800 (PST)
Received: (nullmailer pid 7232 invoked by uid 1000);
        Fri, 28 Feb 2020 15:38:39 -0000
Date:   Fri, 28 Feb 2020 09:38:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: PCI: cadence: Deprecate
 inbound/outbound specific bindings
Message-ID: <20200228153839.GA7180@bogus>
References: <20200224130905.952-1-kishon@ti.com>
 <20200224130905.952-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224130905.952-5-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Feb 2020 18:39:05 +0530, Kishon Vijay Abraham I wrote:
> Deprecate cdns,max-outbound-regions and cdns,no-bar-match-nbits as both
> these could be derived from "ranges" and "dma-ranges" property.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 3 +--
>  Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml      | 1 +
>  Documentation/devicetree/bindings/pci/cdns-pcie.yaml           | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
