Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC3E6DC47C
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 14:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407939AbfJRMOv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 08:14:51 -0400
Received: from [217.140.110.172] ([217.140.110.172]:37214 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2404240AbfJRMOv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 08:14:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67A0FCA3;
        Fri, 18 Oct 2019 05:14:26 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE2E53F6C4;
        Fri, 18 Oct 2019 05:14:25 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:14:24 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 01/25] resource: Add a resource_list_get_entry_of_type
 helper
Message-ID: <20191018121424.GF47056@e119886-lin.cambridge.arm.com>
References: <20191016200647.32050-1-robh@kernel.org>
 <20191016200647.32050-2-robh@kernel.org>
 <20191017072519.GA19517@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017072519.GA19517@infradead.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 12:25:19AM -0700, Christoph Hellwig wrote:
> On Wed, Oct 16, 2019 at 03:06:23PM -0500, Rob Herring wrote:
> > +static inline struct resource_entry *resource_list_get_entry_of_type(struct list_head *list,
> > +							      unsigned long type)
> 
> This adds a way too long line.
> 
> Part of that is that the name just seems way too long as well, any
> good shorter name?  resourse_list_first_type?

I think it's really helpful to use the word 'first' in there somewhere,
it makes it a little clearer on what happens if there are multiple of
the same type of resource.

Thanks,

Andrew Murray
