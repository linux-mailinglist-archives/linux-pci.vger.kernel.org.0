Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5453632F64F
	for <lists+linux-pci@lfdr.de>; Sat,  6 Mar 2021 00:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhCEXFU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 18:05:20 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33782 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhCEXEw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 18:04:52 -0500
Received: by mail-wr1-f50.google.com with SMTP id 7so3851731wrz.0;
        Fri, 05 Mar 2021 15:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zsac3OfuacFeKsDDec9qaJduSsHGfEgG+Of192XZXHA=;
        b=cWnyO32nlktN29n8cUeM5xk/fah25iU/SRTQiA+VQEM5XFc3HiEhlmkfk6EIIkSrzJ
         0PxOXZeyGwlGr6qlj+VvIjD4H3OIbxfMzn4iPaUj5gz+LDekzTUFK/RZ6bn7jd6/HO3d
         FIvI6UvT+PO/T5PiR7xJ3dVJ0uwuiC2DaDm2J+oFfefae9G7aRo51m45/1J3ZkTGDYFG
         4u8GkCXXVDlp2t/EK+t3XRspUSsrNLnqgxkD3dTzzz9qvz20iSyBLBE15j8TbibxCFPu
         8TNMVw7dzsfJlshZ1JL6a37naswrRbLXRHvT1hhlGy7tWTyf8bE5jnzwwSQ256wZ8E9C
         ingw==
X-Gm-Message-State: AOAM530IupPqX8p4t0kKRPkakl/lda9ZX7tezfpugnntnoOdnon35Knx
        gO2+5DAZ2/8MgbpPXDZ+7Gk=
X-Google-Smtp-Source: ABdhPJxPgVj0KTQYUwGa8xOR0eHCwLBAgG6szzjRo4J2qTlgQIsccbNp6sC25/dsBWlPU+C1HejTxw==
X-Received: by 2002:adf:ec0b:: with SMTP id x11mr11126930wrn.175.1614985491458;
        Fri, 05 Mar 2021 15:04:51 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y205sm6600026wmc.18.2021.03.05.15.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:04:50 -0800 (PST)
Date:   Sat, 6 Mar 2021 00:04:49 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        andrew.murray@arm.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3 2/2] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <YEK5EW1ZBDOKZE5E@rocinante>
References: <20200110191500.9538-3-vidyas@nvidia.com>
 <20210305215749.GA1117765@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210305215749.GA1117765@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn and Vidya,

[...]
> > +}
> > +
> > +struct pci_ecam_ops tegra194_pcie_ops = {
> > +	.bus_shift	= 20,
> 
> I think e7708f5b10e2 ("PCI: Unify ECAM constants in native PCI Express
> drivers") means you don't need this .bus_shift.
[...]

Correct.  If this platform implements ECAM as per the specification,
then the .bus_shift initializer is no longer needed.

Krzysztof
