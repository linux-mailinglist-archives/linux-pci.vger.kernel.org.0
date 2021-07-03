Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464663BAA49
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 23:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhGCVEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 17:04:30 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:35828 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhGCVE3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 17:04:29 -0400
Received: by mail-lj1-f171.google.com with SMTP id k21so18742285ljh.2;
        Sat, 03 Jul 2021 14:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbDKxOxjW473fz/TQk+uYZPKCxCeEq+esKthNBKQpx4=;
        b=tZA6s7M7dZskMepMsVhdO3KXSiMDepkmzarmkoaS/L8HMRkSc4HVv+TljVTrCnzh7j
         +THJP2ToDVHzG+jGr/IHuj+BySClNr2LJKbEPp9kxNxG/2q+2TdL4K1hqRUB/BqNAvc0
         OLk6S93QxTMPiMkTve8C/LPfM1WyxBN8/mnPHsaGHwcUYN5UmwuSlyMpwGRG0HMLUGFO
         esFR1Rqc7teRH3zrFHic2h0mSYjupFZxLb873kKWw/p34hTMftdpT/FWFJibTfMJF9e6
         RUlHd27ux9ZLEb83tcSgUyXQkVHDWyJMx6mDKPiPlnNe3Gstx86QnXFcPiFI+Am4UnwM
         eovQ==
X-Gm-Message-State: AOAM531/qNVXQotIZcut6c6Mor098y7VtxOx1956o7V3uiUylkSJBi7x
        0jIgAsOfbX+Jvz6fjWg42IcUwNREbRhmAIwR
X-Google-Smtp-Source: ABdhPJz/WuNJnnzypH1DBlSHj8WMFRe4Eq99ply3VqnPZ+HEKzO7oJyC3XfICjvrP3F2uQqL9OTFWg==
X-Received: by 2002:a2e:9611:: with SMTP id v17mr3331497ljh.212.1625346114347;
        Sat, 03 Jul 2021 14:01:54 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id r127sm63521lff.172.2021.07.03.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 14:01:53 -0700 (PDT)
Date:   Sat, 3 Jul 2021 23:01:52 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Gustavo.Pimentel@synopsys.com, Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 08/40] PCI: keystone: Cleanup MSI/legacy interrupt
 configuration and handling
Message-ID: <20210703210152.GA16176@rocinante>
References: <20180921102155.22839-1-kishon@ti.com>
 <20180921102155.22839-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180921102155.22839-9-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

> Now that all PCI keystone functionality has been moved to pci-keystone.c,
> cleanup MSI/legacy interrupt configuration and handling.
>  *) Cleanup macros
>  *) Remove unnecessary structure variables (required when 2 files are
>     used)
>  *) Remove ks_dw_pcie_legacy_irq_chip and use dummy_irq_chip
>  *) Move request_irq of error irq from ks_add_pcie_port to ks_pcie_probe
>     as error_irq is common to both host mode and device mode
[...]

While looking at some small clean-ups for Bjorn, I stumbled upon this
series, and it seems a lot of your work here cover what Bjorn wanted to
do, thus I need to ask - do you recall, and I appreciate it's been
a while (three years actually), what happened and/or if you ever had the
time to work on this series?

Would it be possible to resurrect this?  Do you need any help?

Thank you in advance!

	Krzysztof
