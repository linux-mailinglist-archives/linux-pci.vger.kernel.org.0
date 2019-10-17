Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB1DA65C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 09:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408133AbfJQHZZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 03:25:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405115AbfJQHZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 03:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xv9FkiQ+X0x5sxf1ddCsRfV44YrgjCL/XV/azq6v0YA=; b=rTyvD+1GcALIpqmWQUmuxp39m
        GpQehEnt92BBfx1lifeuZIPmisv6igd5+pHFadnPWQCdeJzkiupFH8yzVhuo6Fufgls4bRSjyUQQc
        0tld3oJep1wqm8O+mBfWRzb5GdNQMLwcCUbW/536t5hH+bkDv/1IqzAiRuYqCo8W6AAk1ff9aFAvH
        n7nIWjaObpvDDejcpoYAJ5YmpFY6S37Ig2WWM7etzZOsIyZAO9n1784eYcLiAV4sk67cwN9PGvH2G
        /6Bqb5pkOcmiPgRS2OQla08pW9vIooKx/RQ3WeKKe2eEXiUs1Iok55BXjmBLRATC1+6R3IcDd77yT
        Gx27RPOfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL09v-0007VB-O1; Thu, 17 Oct 2019 07:25:19 +0000
Date:   Thu, 17 Oct 2019 00:25:19 -0700
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
Subject: Re: [PATCH v2 01/25] resource: Add a resource_list_get_entry_of_type
 helper
Message-ID: <20191017072519.GA19517@infradead.org>
References: <20191016200647.32050-1-robh@kernel.org>
 <20191016200647.32050-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016200647.32050-2-robh@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 03:06:23PM -0500, Rob Herring wrote:
> +static inline struct resource_entry *resource_list_get_entry_of_type(struct list_head *list,
> +							      unsigned long type)

This adds a way too long line.

Part of that is that the name just seems way too long as well, any
good shorter name?  resourse_list_first_type?
