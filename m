Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD481BEE1C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 04:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgD3CL6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 22:11:58 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:38638 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgD3CL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 22:11:58 -0400
Received: by mail-oo1-f66.google.com with SMTP id i9so930241ool.5;
        Wed, 29 Apr 2020 19:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/EJ5d+UBctXWhyFbFCEO0ATpdzZgD9Qv7Btt9IFEoQI=;
        b=YSI+L+dKUDLVeFP2/QFms6VyrmWUtKGqoHvIBxiD6x32vj0nbVSE8Skk0CPKJEaQEo
         CDVI/raQgvGEXtazf7R5xLT5v48MPrWlpujRe0wa2dH7Idl3q6NFKhho/lI8aPS0XdOk
         kDFnNIFBDMaqI7PwmlSoApxUIBA/3fXKTROKJdvCeJlwUsDDreuREj5p5Uzhf6r26k9z
         rFcfUbU0EZB43y0bLOjGi3TV2j2VD1jnhZ6Yah0KDUyRo3fXbXjzKwsdH2RZ3LgR4iXV
         Q8Cj5Unzhdf0BahG1Z/ukZ7oZVs6oUj/jECs6+maLCNGpL8CnKMHaAxDKlLfDc83dVHw
         9K6A==
X-Gm-Message-State: AGi0PuYc/CtqQQMr5sUSPB51Dnyam0PdBoRCoAlf4uRgs2Arh0YVDvcc
        xizpnvjIh6OEnVFx/pVDrQ==
X-Google-Smtp-Source: APiQypLEY5fYl1gWxK7tqwSg9npgGMzAqQPB0vE1fYip4jxD6RwD17ikAwknsEBw6ERyEjrf5pYVfw==
X-Received: by 2002:a4a:d843:: with SMTP id g3mr908596oov.64.1588212717711;
        Wed, 29 Apr 2020 19:11:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i2sm989912oon.0.2020.04.29.19.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 19:11:57 -0700 (PDT)
Received: (nullmailer pid 18195 invoked by uid 1000);
        Thu, 30 Apr 2020 02:11:56 -0000
Date:   Wed, 29 Apr 2020 21:11:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/14] dt-bindings: PCI: Add host mode dt-bindings for
 TI's J721E SoC
Message-ID: <20200430021156.GA18023@bogus>
References: <20200417125753.13021-1-kishon@ti.com>
 <20200417125753.13021-11-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417125753.13021-11-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 Apr 2020 18:27:49 +0530, Kishon Vijay Abraham I wrote:
> Add host mode dt-bindings for TI's J721E SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
