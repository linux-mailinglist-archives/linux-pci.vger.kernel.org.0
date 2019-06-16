Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE9473B5
	for <lists+linux-pci@lfdr.de>; Sun, 16 Jun 2019 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfFPIAY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jun 2019 04:00:24 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:47785 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfFPIAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jun 2019 04:00:23 -0400
X-Originating-IP: 213.174.99.131
Received: from windsurf (smb-adpcdg1-03.hotspot.hub-one.net [213.174.99.131])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 783771C0006;
        Sun, 16 Jun 2019 08:00:19 +0000 (UTC)
Date:   Sun, 16 Jun 2019 10:00:17 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: armada8k: Add PHYs support
Message-ID: <20190616100017.607e4848@windsurf>
In-Reply-To: <20190401131239.17008-1-miquel.raynal@bootlin.com>
References: <20190401131239.17008-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon,  1 Apr 2019 15:12:39 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Bring PHY support for the Armada8k driver.
> 
> The Armada8k IP only supports x1, x2 or x4 link widths. Iterate over
> the DT 'phys' entries and configure them one by one. Use
> phy_set_mode_ext() to make use of the submode parameter (initially
> introduced for Ethernet modes). For PCI configuration, let the submode
> be the width (1, 2, 4, etc) so that the PHY driver knows how many
> lanes are bundled. Do not error out in case of error for compatibility
> reasons.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
