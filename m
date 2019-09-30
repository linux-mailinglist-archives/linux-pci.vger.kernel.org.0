Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3414C20DF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfI3MtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 08:49:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3MtM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 08:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HmbC6ie7K26GD6YOB+m1fIk1Ign99CoO6adOgQaWMC4=; b=SWIgx/WH1Nj9g+V8LhO4/pKj8
        JdZcrmy4Katr8H2/j9gGFSLscFU5Yk37YaJ+tFF3RysC2CRgRl/n31fw/R27v1/R/9kost9oZhhXq
        VdbqFSilq50lnMUxg8Ef/bAqJBBOkOObx9H9foiXCBsBP6h9MUiru+Wo8yCA4Rl3gqxPykOkTrZj7
        2bZ8HSLZbekIspRvxO60qpjZSws0RT+qmHqB2Bsty4LpEOoqlFhA5asws12YoBnExdipagwrqoyvD
        0yOWIiQcgaqORAiL7JmX38uwXOiMZGk1shD9wY+kVrOmnzYkzh4B5cOVcVjf4OJsbAoz/K2aejMPS
        gNOVP8hmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iEv70-0003OA-Jw; Mon, 30 Sep 2019 12:49:10 +0000
Date:   Mon, 30 Sep 2019 05:49:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 01/11] of: Remove unused
 of_find_matching_node_by_address()
Message-ID: <20190930124910.GA12051@infradead.org>
References: <20190927002455.13169-1-robh@kernel.org>
 <20190927002455.13169-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927002455.13169-2-robh@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 07:24:45PM -0500, Rob Herring wrote:
> of_find_matching_node_by_address() is unused, so remove it.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
