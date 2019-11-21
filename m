Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433971055F4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 16:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUPq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 10:46:58 -0500
Received: from foss.arm.com ([217.140.110.172]:58334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUPq6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 10:46:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94516DA7;
        Thu, 21 Nov 2019 07:46:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C9CF3F52E;
        Thu, 21 Nov 2019 07:46:56 -0800 (PST)
Date:   Thu, 21 Nov 2019 15:46:55 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, mbrugger@suse.com,
        maz@kernel.org, phil@raspberrypi.org, linux-kernel@vger.kernel.org,
        jeremy.linton@arm.com, Eric Anholt <eric@anholt.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <wahrenst@gmx.net>, james.quinlan@broadcom.com,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/6] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
Message-ID: <20191121154655.GB43905@e119886-lin.cambridge.arm.com>
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-5-nsaenzjulienne@suse.de>
 <20191119162502.GS43905@e119886-lin.cambridge.arm.com>
 <7e1be0bdcf303224a3fe225654a3c2391207f9eb.camel@suse.de>
 <20191121120319.GW43905@e119886-lin.cambridge.arm.com>
 <18109ee4f8d8c5ce0dc714217eef53ee42d5305f.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18109ee4f8d8c5ce0dc714217eef53ee42d5305f.camel@suse.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 02:26:15PM +0100, Nicolas Saenz Julienne wrote:
> On Thu, 2019-11-21 at 12:03 +0000, Andrew Murray wrote:
> > On Wed, Nov 20, 2019 at 08:53:30PM +0100, Nicolas Saenz Julienne wrote:
> > One purpose of this function is to validate that the information given in the
> > device tree is valid - I've seen other feedback on these lists where the view
> > is taken that 'it's not the job of the kernel to validate the DT'. Subscribing
> > to this view would be a justification for removing this validation -
> > especially
> > given that the bindings you include have only one dma-range (in any case if
> > there are constraints you ought to include them in the binding document).
> > 
> > Though the problem with this point of view is that if the DT is wrong, it may
> > be possible for the driver to work well enough to do some function but with
> > some horrible side effects that are difficult to track down to a bad DT.
> 
> As for the validation, I think in this specific case it's still worthwhile. As
> you might know, there is a bug on the first revision of RPI4's PCIe integration
> which blocks any access higher than 3GB. Further revisions fix this and allow
> full memory addressing.
> 
> I've been working with Phil Elwell (from the RPi foundation) to solve this in a
> way that plays well with upstream and this driver (I'll be able to test the new
> revision before this gets in). The solution is, unsurprisingly, for the
> firmware to edit the DTB passed to the kernel based on the board revision.
> Given that there is some live manipulation of the dma-ranges I'd rather leave
> the validation check.
> 
> If you don't disagree with the above I'll add an extra code comment explaining
> why we feel the need to verify the device-tree contents.

I'll be interested in seeing it.

Thanks,

Andrew Murray

> 
> Regards,
> Nicolas
> 


