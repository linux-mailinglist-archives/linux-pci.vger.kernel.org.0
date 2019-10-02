Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B73C4654
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 06:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfJBENS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Oct 2019 00:13:18 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:53793 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfJBENS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Oct 2019 00:13:18 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3C793100E201F;
        Wed,  2 Oct 2019 06:13:16 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E9EDF43227; Wed,  2 Oct 2019 06:13:15 +0200 (CEST)
Date:   Wed, 2 Oct 2019 06:13:15 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: pciehp: Do not turn off slot if presence comes
 up after link
Message-ID: <20191002041315.6dpqpis5zikosyyc@wunner.de>
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 01, 2019 at 05:14:16PM -0400, Stuart Hayes wrote:
> This patch set is based on a patch set [1] submitted many months ago by
> Alexandru Gagniuc, who is no longer working on it.
> 
> [1] https://patchwork.kernel.org/cover/10909167/
>     [v3,0/4] PCI: pciehp: Do not turn off slot if presence comes up after link

If I'm not mistaken, these two are identical to Alex' patches, right?

  PCI: pciehp: Add support for disabling in-band presence
  PCI: pciehp: Wait for PDS when in-band presence is disabled

I'm not sure if it's appropriate to change the author and
omit Alex' Signed-off-by.

Otherwise I have no objections against this series.

Thanks,

Lukas
