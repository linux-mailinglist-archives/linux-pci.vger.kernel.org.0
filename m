Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D4317955B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 17:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgCDQcs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 11:32:48 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37020 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388183AbgCDQcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 11:32:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id q65so2698843oif.4;
        Wed, 04 Mar 2020 08:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlxdX6hsZi5AisgX3eMeK6SIAZgvH3rzbjBrMDN8z8Q=;
        b=FVWDmKrH2b4G2Emyj4S394/fiZJvpbRXj1aYnNTFZ4mYJrie8f7C+F6W8wn+jJLGNE
         uP2YTML3YwW1a7PEg8HhTW/yYniH3LPcZN48KXx+DDAbfjDtHjFAeqq2Ba+wyg86HDP5
         obVnEfyXqRpt4kPmJSEQaKw5Os8KATAYOitIyfyAUE8kqutEwOKoGYKj8Y+cqOCDHQrr
         sk4cmi2nv50znQKNVIy2ewtOtTL4Xmg/F8NE+gLJ4wF/Kudo5V6PcoUkwW6xBhUh1Eji
         9c4qvbXlexHUR8R4H7Pd56pCQi2yz7nCMoGGfetu3pg8PlDF2j2fEWZxamd5RlAEEEjq
         dWuw==
X-Gm-Message-State: ANhLgQ2kXUTq1UuzxW4rqAZuIyDuusAzYxo0tpFE7Fh9hq/tHWWPj6xl
        gn97YBlxGWYLTETeAPUGzD6Yq+A=
X-Google-Smtp-Source: ADFU+vub+PA222f6GWVzm6JQMWh/VO2HEcpSSCfHjVzyPf3SPX62E1A27v3rSUlcYF5xdTaxLmVB3A==
X-Received: by 2002:aca:ad55:: with SMTP id w82mr2257116oie.133.1583339566910;
        Wed, 04 Mar 2020 08:32:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w2sm3886434otq.10.2020.03.04.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:32:46 -0800 (PST)
Received: (nullmailer pid 18151 invoked by uid 1000);
        Wed, 04 Mar 2020 16:32:45 -0000
Date:   Wed, 4 Mar 2020 10:32:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: PCI: Add PCI Endpoint Controller
 Schema
Message-ID: <20200304163245.GA18094@bogus>
References: <20200303100327.3603-1-kishon@ti.com>
 <20200303100327.3603-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303100327.3603-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 3 Mar 2020 15:33:24 +0530, Kishon Vijay Abraham I wrote:
> Define a common schema for PCI Endpoint Controllers.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/pci-ep.yaml       | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-ep.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
