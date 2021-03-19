Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED803413E3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 04:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhCSD4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 23:56:21 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:43669 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhCSD4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 23:56:21 -0400
Received: by mail-ed1-f54.google.com with SMTP id e7so9152748edu.10;
        Thu, 18 Mar 2021 20:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zuozRhYHLPEHI/9P6pE8GrRW/dv3ARhH5puPoNBpR8w=;
        b=X8LpldBaZCwPIF8e1/wERzh8zca2ibQ544uAncH9QvIty9vPDNc09HLU0VGySVdECs
         4wA0BdqWxl6wvuY7QXJYUxyGtzLMvF5wYppAaCJeQukFi3piKUedKIc+JcAUytUIrUV3
         U3sLgcAv7uD+02Rb0fzqKE//Nz6NiZ8av1v5jknn2wsEinqtbPR7GZC5hMXeU+0wg/up
         XHdg0vAofWC2k7mhB8zeB5jmziwHmLmLfEnPxl4jIQ2BuScn8Dsyy4Ijqzxf2qWH2dkt
         LIXWNRcb+Jx0/DcYkMWL/ZmXXbeK9pIIHtOR9Kjg5A+VEfhdV/ge8D1wdur3cBNLNxoK
         uetQ==
X-Gm-Message-State: AOAM531Yn6Sa8oCQMHO46ApvQoV0InTTOLdHkrUCec1HTQC7kl61higg
        wWSXcWYkmOqwTmfb8f85L/Y=
X-Google-Smtp-Source: ABdhPJxyssy9zDn2RmoeOErpQKJpYn48Kh+W0/J9I6FyH4ME5wlgtBlBjPohUOIs4WWNjivrfwKoqw==
X-Received: by 2002:a05:6402:10c9:: with SMTP id p9mr7377600edu.268.1616126179855;
        Thu, 18 Mar 2021 20:56:19 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l1sm3287589edt.59.2021.03.18.20.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 20:56:19 -0700 (PDT)
Date:   Fri, 19 Mar 2021 04:56:17 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, robh+dt@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mturquette@baylibre.com,
        sboyd@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, alex.dewar90@gmail.com,
        khilman@baylibre.com, hayashi.kunihiko@socionext.com,
        vidyas@nvidia.com, jh80.chung@samsung.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, helgaas@kernel.org
Subject: Re: [PATCH v2 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host
 controller
Message-ID: <YFQg4RdOWUABOlPN@rocinante>
References: <cover.1615954045.git.greentime.hu@sifive.com>
 <8008af6d86737b74020d7d8f9c3fbc9b500e9993.1615954046.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8008af6d86737b74020d7d8f9c3fbc9b500e9993.1615954046.git.greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for sending the patches over!

A few nitpicks.

> +title: SiFive fu740 PCIe host controller
> +
> +description:
> +  SiFive fu740 PCIe host controller is based on the Synopsys DesignWare
> +  PCI core. It shares common features with the PCIe DesignWare core and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/designware-pcie.txt.
[...]

In the above title and description it would be "FU740" to keep this
consistent with everything else.

Also, as this is a YAML file, a multi-line description might be better
expressed as "description: |" or "description: |+", of course it depends
on whether you would like or not to preserve line endings.

[...]
> +  dma-coherent:
> +    description: Indicates that the PCIe IP block can ensure the coherency
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.
[...]
> +  resets:
> +    description: A phandle to the PCIe power up reset line
> +
> +  pwren-gpios:
> +    description: Should specify the GPIO for controlling the PCI bus device power on
> +
> +  perstn-gpios:
> +    description: Should specify the GPIO for controlling the PCI bus device reset
[...]

All the above descriptions should end with a period, so that we keep
things consistent throughout.

Krzysztof
