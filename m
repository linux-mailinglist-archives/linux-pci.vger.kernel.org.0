Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDABD70D3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfJOIQV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 04:16:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfJOIQV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 04:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z7zb8hwdUvM4gWBjniUrfCCpeZFbxnEJV1qTM/lkvII=; b=OHDKau5y8c7YAepQgJhwyx+OE
        1DX8y2NcUjlALU49vt3s8qRfvOIBXlOoJDHvviOemYJWZjHFpN6gd6wHraUIlTmxiUe9c+roa67fc
        /ADANaqg0mE3kerF5EQlvhA2WO+oU6UNW0kEoiCSJQ0ByKsskbr79cWZXsN5/TVUcJ4e1MymZO3FV
        1rnOfv4BLf5QfiirP5zYm+8gM3B8JftOBHIlj6l92646m4LpBJy2bqMHHo6cV+hYOyUPbUnT7p4UL
        YWYbRiVQaZwnjg9q1SP/5anlZ5lte5BkOF+bFoYR9p/SSD5U7psBI6K1Pa1gezOIzATHJOR2rxAoy
        J++tB0Pvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKI0C-0007wo-62; Tue, 15 Oct 2019 08:16:20 +0000
Date:   Tue, 15 Oct 2019 01:16:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Dubey <pankaj.dubey@samsung.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, andrew.murray@arm.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, vidyas@nvidia.com,
        Anvesh Salveru <anvesh.s@samsung.com>
Subject: Re: [PATCH v3] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Message-ID: <20191015081620.GA28204@infradead.org>
References: <CGME20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1@epcas5p1.samsung.com>
 <1571108362-25962-1-git-send-email-pankaj.dubey@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571108362-25962-1-git-send-email-pankaj.dubey@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 08:29:22AM +0530, Pankaj Dubey wrote:
> From: Anvesh Salveru <anvesh.s@samsung.com>
> 
> In some platforms, PCIe PHY may have issues which will prevent linkup
> to happen in GEN3 or higher speed. In case equalization fails, link will
> fallback to GEN1.
> 
> DesignWare controller gives flexibility to disable GEN3 equalization
> completely or only phase 2 and 3 of equalization.
> 
> This patch enables the DesignWare driver to disable the PCIe GEN3
> equalization by enabling one of the following quirks:
>  - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all phases
>  - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2 & 3
> 
> Platform drivers can set these quirks via "quirk" variable of "dw_pcie"
> struct.

Please submit this together with the changes to the dwc frontend driver
that actually wants to set these quirks.
