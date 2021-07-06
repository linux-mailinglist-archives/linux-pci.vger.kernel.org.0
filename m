Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E63BDE77
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 22:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhGFUhC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 16:37:02 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:45992 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFUhB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jul 2021 16:37:01 -0400
Received: by mail-ej1-f49.google.com with SMTP id hc16so36206247ejc.12;
        Tue, 06 Jul 2021 13:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ICSJlQlSgTNd605M++v+mHZyBgX5QCDOQLTCW/JboK8=;
        b=RbdwTONsbKLLWtK3IFGKix+k9A7v7MKeqjuCEYRRQ2QcEE4nlJVD/eyWME0smJb/+G
         i4vrMfVMrKjyeOkVhk8Fg1KyYiTa9EA56+91IBZhDfwKZtqp6+eaaeqGyPNbnC9umDTN
         mB6H4wb8EpfydJhgfvm74kHMipypuQzsfqwId+8cmS4CpsCX0dsWwUpYQ6UJ83zIQ740
         cLo3gSP7An0sKB8Ds8aP14033HqSsvImePV3/GqtN1I+DdKqDgBLoUGeBBkkjScVvkMx
         70mJOufC4Jmxx0ORwZvAM8OoqzAznooQYnZrhSlitPW+X7G4ScMvsUALAUSHnCLbeI0I
         IOMQ==
X-Gm-Message-State: AOAM533PGVB+ynXC2Q95KScdahL8AcLKVIdsxZHzLpaAJwfPFy2sEWCs
        I0Hw6wwVvHlc+PBfxH0+IvXOTV6yNK488n6m
X-Google-Smtp-Source: ABdhPJzk7Av2OZ6J6ktZL9FvReBxgzGh5O0TaVuvB2PM/lqy/MNt0nyKfPdOWfFinUNhQmGg4noc5g==
X-Received: by 2002:a17:907:c0f:: with SMTP id ga15mr19995713ejc.228.1625603661503;
        Tue, 06 Jul 2021 13:34:21 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id k25sm6343895eds.77.2021.07.06.13.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 13:34:21 -0700 (PDT)
Date:   Tue, 6 Jul 2021 22:34:19 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jingoo Han <jingoohan2@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo.Pimentel@synopsys.com, Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 08/40] PCI: keystone: Cleanup MSI/legacy interrupt
 configuration and handling
Message-ID: <20210706203419.GA213769@rocinante>
References: <20180921102155.22839-1-kishon@ti.com>
 <20180921102155.22839-9-kishon@ti.com>
 <20210703210152.GA16176@rocinante>
 <56160f1d-ec91-3b99-312c-aef66eb1a7c2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <56160f1d-ec91-3b99-312c-aef66eb1a7c2@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

[...]
> > Would it be possible to resurrect this?  Do you need any help?
> 
> A lot of patches in this series should already be merged (after
> splitting into smaller ones)
> http://patchwork.ozlabs.org/project/linux-pci/list/?series=71185
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20190321095927.7058-1-kishon@ti.com/

Ah!  Nice!

[...]
> Are there any other clean-ups you are looking into?

Bjorn was looking recently at struct keystone_pcie and suggested that
perhaps things such as for example the legacy_host_irqs member could be
refactored - in this particular case it seems to only store a single
item in the array, etc.

And this series of patches I found is refactoring a lot of the elements
of the driver and thus the struct keystone_pcie too in due process.

I suppose, it would be just better to wait for you to complete all the
work you have planned?  What do you think?

	Krzysztof
