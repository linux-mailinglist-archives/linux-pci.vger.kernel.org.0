Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450366059ED
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiJTIeV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 04:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiJTIeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 04:34:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545B18C97C;
        Thu, 20 Oct 2022 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q3QaaMs+Z8dwUqg3kPpGU3RQrxF6E7PAKWpAFqdlr4g=; b=mEa+vbPVomEcRC/P6PqS1bBpiC
        l6if9VjYPi3SHfCAIJ5fH/J+1f4p2U1Rqfk4LW2NochXsbSa90tE9hALq3nL9jMZ0zuMXP0xaVi6G
        24XhwwKW1gaRaZG0OXJX/fFlm4K0xlbp0zbtU3BbXWOxv+EgEIQQ3Ywy5IAQBnTP14yzBPdObX0Ov
        wniBOX17lc6UW+lnbvgdvFCfjL6gj0XDzEq4yOhz8LNox5dd2Twe3Mzc0Rn1E9QU28kgOnIiNEnQ0
        eTQwQkdXvJEpzEXjxTGimanLozk803W5pgciLIVzEa/SbRiIZbbUT8JKqBfo9qbQhGDPV3OEUCxCq
        PABPEUNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olR0F-00CGKn-IT; Thu, 20 Oct 2022 08:34:11 +0000
Date:   Thu, 20 Oct 2022 01:34:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/3] PCI/portdrv: Unexport pcie_port_service_register(),
 pcie_port_service_unregister()
Message-ID: <Y1EIA4kEmgywjcfq@infradead.org>
References: <20221019204127.44463-1-helgaas@kernel.org>
 <20221019204127.44463-4-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019204127.44463-4-helgaas@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 03:41:27PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pcie_port_service_register() and pcie_port_service_unregister() are used
> only by the pciehp, aer, dpc, and pme PCIe port service drivers, none of
> which can be modules.  Unexport pcie_port_service_register() and
> pcie_port_service_unregister().  No functional change intended.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
