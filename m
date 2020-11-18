Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93372B8214
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 17:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKRQje (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 11:39:34 -0500
Received: from foss.arm.com ([217.140.110.172]:59220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgKRQje (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 11:39:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D14F1396;
        Wed, 18 Nov 2020 08:39:34 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A873A3F719;
        Wed, 18 Nov 2020 08:39:33 -0800 (PST)
Date:   Wed, 18 Nov 2020 16:39:31 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Daire.McNamara@microchip.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v17 3/3] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20201118163931.GB32004@e121166-lin.cambridge.arm.com>
References: <20201022132223.17789-4-daire.mcnamara@microchip.com>
 <587df2af-c59e-371a-230c-9c7a614824bd@codethink.co.uk>
 <MN2PR11MB426909C2B84E95AF301C404B96100@MN2PR11MB4269.namprd11.prod.outlook.com>
 <2eee84c9-aa24-2587-5ced-1c2fe30a1d50@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eee84c9-aa24-2587-5ced-1c2fe30a1d50@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02, 2020 at 11:15:25AM +0000, Ben Dooks wrote:
> On 02/11/2020 10:39, Daire.McNamara@microchip.com wrote:
> > Hi Ben,
> > 
> > Yes, we've become aware of an issue that's cropped up with latest design file on Icicle with PCIe.  We're working through it and we'll update once we have resolved it.
> 

Message above did not make it to linux-pci (list rejects anything that
is not plain text), this was a public discussion and must have stayed
so, thanks to Ben for posting back.

> Thanks for looking at this.
> 
> We could really do with this working as we need faster storage
> and graphics options for what we want to do with these boards.
> 
> I am happy to reinstall or rebuild images, i've got a v5.9 that
> works to an extent on the icicles.

Where's the fix for this ? It would be good to merge the driver with
no known regressions.

Thanks,
Lorenzo
