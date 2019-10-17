Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 785F3DA665
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 09:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408131AbfJQH03 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 03:26:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408072AbfJQH03 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 03:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fp2pe+U09WC9ApIxlN/mw2GqVq/iMxQH66A96e+1BJ8=; b=nuNvxTuyhrO35jbCtHSKHVNol
        LHfGNVLFywXJJpz9t6EzULst88E6vhm+qgmOV5/hzgo3z58kyCn7fD2hWp+/LCSQ44aO8nMQoXRJQ
        hmU4izk8la8LO/JbWcuelPPpKEVgDn5PBq6VOVlX1Oo16XfHE/Nukp6qk6/sy460wPbA32DN1ietS
        5Lpn8Rl+w8pqOQIH8JN65MYVvkpuTbZrTyijsyScXQhCyKAP2b5uKFr2fUwgnTkqBYkoQwM4FkN8p
        7+Z4yCgdnL4a7/ip4/rkRrKfWc5qp2AZ+6Tt/TVoRVDRqvllpMvf1csMP6Olrtuz0sRgcfCDjSFE6
        YlB7+4aWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL0Az-00081E-Rg; Thu, 17 Oct 2019 07:26:25 +0000
Date:   Thu, 17 Oct 2019 00:26:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v2 11/25] PCI: rockchip: Drop storing driver private
 outbound resource data
Message-ID: <20191017072625.GB19517@infradead.org>
References: <20191016200647.32050-1-robh@kernel.org>
 <20191016200647.32050-12-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016200647.32050-12-robh@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 03:06:33PM -0500, Rob Herring wrote:
> +	entry = resource_list_get_entry_of_type(&bridge->windows, IORESOURCE_MEM);

This add another too long line.  Please audit the whole series for that.
