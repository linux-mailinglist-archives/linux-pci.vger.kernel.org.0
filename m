Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECBF281CD6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBUUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 16:20:22 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34229 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBUUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 16:20:22 -0400
Received: by mail-lf1-f68.google.com with SMTP id u8so3386850lff.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2020 13:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJ6aNftWa1v7397jKEHYw9TXz4/8gDVk4MVnuv4fW5Q=;
        b=Pngzpz5tP05cuZ9Pb/k6s6A+gtghdWqXmEv8dwMnORjVd+1dwmUuiWOh/GqVehmJYd
         aMsKx+s2m0l/rxwuAF3NvLipBngExLH624Fla+HWfmj+28tKXLzwGxmRYMkYjzK8AZyS
         2SC995PSRRqIgNXyrEHiLS0d+jCyXl29p2VMxe0J3Qzl9zIoZcuvut4xIp0YmazQgeg8
         Ew52KLTpNj2Ry+yx4rtTVI1km/QtWc+XDnQ8eX0IP2+ixNS/muBP/32Lxu4URyIOJNhG
         D65lKoWGSVuUl2D4exiknGuBivOsSTkNovWSoXio0jedA0Q6nOUgdV1qjw777pKOykes
         U9QQ==
X-Gm-Message-State: AOAM532MXJhfVCey4xjmwSYC9mlgFEyxdFV1a7AzRmrnq5tH+nx6JqPZ
        IQu7ZJmy6KfHm9+VmasaDPM=
X-Google-Smtp-Source: ABdhPJwW9j/QlJs5CxMK7I1dTeETRw6pQtaqmgEwQ1+5+sjCc3o4QWsYU6O4Vcf+/p1sYu7rGQpcKQ==
X-Received: by 2002:ac2:5685:: with SMTP id 5mr1556729lfr.161.1601670020253;
        Fri, 02 Oct 2020 13:20:20 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m10sm506351ljg.138.2020.10.02.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 13:20:19 -0700 (PDT)
Date:   Fri, 2 Oct 2020 22:20:17 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201002202017.GA95575@rocinante>
References: <20201001220244.1271878-1-kw@linux.com>
 <CAL_JsqJn3uhHgnWeStyADCntJFbG4WpgFW1MAcYR9W3m4o2P=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqJn3uhHgnWeStyADCntJFbG4WpgFW1MAcYR9W3m4o2P=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

[...]
> What about vmd which I mentioned? I also found iproc and brcmstb are
> ECAM (well, same shifts, but indirect addressing).
[...]

I wanted to cover these (and some others I also found) in a separate
patch, especially since some of the drivers don't explicitly claim to
support ECAM - but I will include these changes in the v4. 
 
> > +/
> > + * Enhanced Configuration Access Mechanism (ECAM)
> > + *
> > + * N.B. This is a non-standard platform-specific ECAM bus shift value.  For
> > + * standard values defined in the PCI Express Base Specification see
> > + * include/linux/pci-ecam.h.
> > + */
> > +#define XGENE_PCIE_ECAM_BUS_SHIFT      16
> 
> Isn't this just CAM? Though perhaps CAM on PCIe is not standard...
> 
> For CAM, there's also tegra, ftpci100, mvebu, and versatile. I think
> I'd drop CAM from this patch and do all of those in a separate patch.

Will do.

Bjorn was also not convinced about referring to things as "CAM" since
the specification (the one I quoted in the patch) does not name it as
such, and rather refers to it as Type 1 access of the PCI bus
configuration space.

Krzysztof
