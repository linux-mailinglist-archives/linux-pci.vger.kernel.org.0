Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703B82C87FE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgK3PbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 10:31:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34887 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3PbS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 10:31:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id r3so16766684wrt.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Nov 2020 07:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aYHHxJmw979e+wSJRiDQN73bZ6bHCfBL6+c7qQzjNRM=;
        b=XMW1RX90Xa4IkFRzU9z83ff0EKnOA+7Ib/E8gsCQtHc74JLFBh0mlCXLrUGxKeKgTQ
         shMpJ4eOtXVDzlTi7RIBQnGxVX8q1Hg548x8xPjSxIQ+Dp7fuachS+cORT4oAZv9lpxB
         oEeNX8Cz42lX9V5x8SJctdAn2XsbSPLCJ5brdx5+xYahtWnPy8EHAmkJHClrE90yDO2h
         nFyjzFBCnd4Qq6GhzP3Ke7/nRBZnRswddxYet6hbGE8iMtcTkRRMKD/El5Ei+RBI7Pzm
         XFjKurMK6esbpD8Ab2HIUyXhYiLh0bwIEGDVJWXldCVf5KjJRZeM8+l+RIZbRqtIv2JD
         Ubjg==
X-Gm-Message-State: AOAM531JgRESXDQJm5YGYJDMn7Nx4wj22/iLAe1D/oFphJVl8roYS0hc
        cVqwzfdm+Zy/vWkl0u0ONmo=
X-Google-Smtp-Source: ABdhPJxDgu0JUhfBnd1JT0sM9EnLMunvMJmxP1ptyZLeuiHRBoyRMeT9fOud0TpT6HDh8Aw84e0fEg==
X-Received: by 2002:adf:9d49:: with SMTP id o9mr29398963wre.413.1606750230899;
        Mon, 30 Nov 2020 07:30:30 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k11sm27836582wrv.88.2020.11.30.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:30:30 -0800 (PST)
Date:   Mon, 30 Nov 2020 16:30:28 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v6 1/5] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <X8UQFER3uccborBf@rocinante>
References: <20201129230743.3006978-1-kw@linux.com>
 <20201129230743.3006978-2-kw@linux.com>
 <20201130110858.GB16758@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201130110858.GB16758@e121166-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo!

On 20-11-30 11:08:58, Lorenzo Pieralisi wrote:
[...]
> > Refactor pci_ecam_map_bus() function to use newly added constants so
> > that limits to the bus, device function and offset (now limited to 4K as
> > per the specification) are in place to prevent the defective or
> > malicious caller from supplying incorrect configuration offset and thus
> > targeting the wrong device when accessing extended configuration space.
> > This refactor also allows for the ".bus_shit" initialisers to be dropped
>                                           ^^^^
> 
> Nice typo, I'd fix it while applying it though if you don't mind ;-),
> no need to resend it.

Oh doh!  Apologies. :)

> Jokes aside, nice piece of work, thanks for that.
> 
> > when the user is not using a custom value as a default value will be
> > used as per the PCI Express Specification.
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> 
> I think Bjorn's reviewed-by still stands so I will apply it.
[...]

Thank you!

Krzysztof
