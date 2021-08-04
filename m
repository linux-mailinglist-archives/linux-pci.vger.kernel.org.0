Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE303E05EF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 18:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhHDQ3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 12:29:15 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:37731 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbhHDQ3K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 12:29:10 -0400
Received: by mail-io1-f43.google.com with SMTP id l20so908482iom.4;
        Wed, 04 Aug 2021 09:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VKjRz072HGEgP1rwlJIh26JWC9tcVy1uWT48FAiuTh0=;
        b=m4E2wfH91B5GM7A0QgkhuCeAtSnNHY/dJ8SW0/UBiK1AdQsiVysV0f6GUXYhzcnSaq
         LZOnpc32XR71YT63yOwst/WOm/yhJAxuTJtI/S8FTJgVwXn4YrjrKbU0Teh/X2QzHxda
         ACdmLHNyk70Rz0+bR+BYp0Ct/nd2bhDvFHgAvszd8rUDpO7Zo1WsFWHnoSKa0Mz/FDBV
         ynkno4QwGIELfAT0tV2Aw2sEpmL8oSK7shHfZ3gf5ZvXoLlUOjRUqCG+If45wJTJ3ouV
         USfmzodoUq8U9hTTVKyrKqOTrHZsRVBsI5QoIeDyWnGGryb/JxpKqINUNwOtcqAvwSCl
         Ig+A==
X-Gm-Message-State: AOAM530qNy6ZZmnAdiuypeO8uM42ZYiXitysLCp2S9uu3PVBwr6AXDkG
        UGnT9SwM2sanYI1CEGPpwQ==
X-Google-Smtp-Source: ABdhPJzM54EOzxkXV7o01ZjhBshqyv3YcG0rFRh3qFfZory8ZzZ/FUEYNWqi9A9W3x8CZlLwLtvqcQ==
X-Received: by 2002:a02:7348:: with SMTP id a8mr302327jae.116.1628094536294;
        Wed, 04 Aug 2021 09:28:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u16sm1764975iob.41.2021.08.04.09.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 09:28:55 -0700 (PDT)
Received: (nullmailer pid 1331554 invoked by uid 1000);
        Wed, 04 Aug 2021 16:28:53 -0000
Date:   Wed, 4 Aug 2021 10:28:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to
 work
Message-ID: <YQrARd7wgYS1nywt@robh.at.kernel.org>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
 <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
 <20210804085045.3dddbb9c@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804085045.3dddbb9c@coco.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 04, 2021 at 08:50:45AM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 3 Aug 2021 16:11:42 -0600
> Rob Herring <robh+dt@kernel.org> escreveu:
> 
> > On Mon, Aug 2, 2021 at 10:39 PM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Hi Rob,
> > >
> > > That's the third version of the DT bindings for Kirin 970 PCIE and its
> > > corresponding PHY.
> > >
> > > It is identical to v2, except by:
> > >         -          pcie@7,0 { // Lane 7: Ethernet
> > >         +          pcie@7,0 { // Lane 6: Ethernet  
> > 
> > Can you check whether you have DT node links in sysfs for the PCI
> > devices? If you don't, then something is wrong still in the topology
> > or the PCI core is failing to set the DT node pointer in struct
> > device. Though you don't rely on that currently, we want the topology
> > to match. It's possible this never worked on arm/arm64 as mainly
> > powerpc relied on this.
> >
> > I'd like some way to validate the DT matches the PCI topology. We
> > could have a tool that generates the DT structure based on the PCI
> > topology.
> 
> The of_node node link is on those places:
> 
> 	$ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
> 	/sys/devices/platform/soc/f4000000.pcie/of_node
> 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
> 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
> 	/sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node

Looks like we're missing some... 

It's not immediately obvious to me what's wrong here. Only the root 
bus is getting it's DT node set. The relevant code is pci_scan_device(), 
pci_set_of_node() and pci_set_bus_of_node(). Give me a few days to try 
to reproduce and debug it.

In the mean time, I applied the series but haven't pushed it out.

Rob
