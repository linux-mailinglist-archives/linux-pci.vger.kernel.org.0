Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C74129A5E8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508462AbgJ0Hzz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:55:55 -0400
Received: from verein.lst.de ([213.95.11.211]:37668 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508459AbgJ0Hzy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 03:55:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6268B67373; Tue, 27 Oct 2020 08:55:51 +0100 (CET)
Date:   Tue, 27 Oct 2020 08:55:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Fix 32-bit overflow with CONFIG_ARM_LPAE=n
Message-ID: <20201027075551.GB22487@lst.de>
References: <20201026152755.3738293-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026152755.3738293-1-geert+renesas@glider.be>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Rob and Frank: do you want to take this through the OF tree, or should
I queue it up in the dma-mapping tree that caused the problem?
