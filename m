Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F65727657
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 06:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjFHEvT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 00:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbjFHEvS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 00:51:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC31BF8;
        Wed,  7 Jun 2023 21:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=p2gzrKI8pycdTfw3rHRPH/Xfrj
        aJxbAAyPxjYtZqIZYe+Car5Pp7pLQR3OcF58pdnKHfvDqGJaWzkIrhpQI89ygEWGZbXplszt6cMaj
        HEkAmAgy4sTuZgfjyBlzBA9qW93w3FDfeIaRri2QD/w6w8hTLLhvUdkJBsyBgPLWx1v1HeZJCmnyb
        wFu22TBb2MDoNPaqGTco4crqMNr9Hn615wDEa8tLGgD7t/+KwNt/iVRgOJyDjiurdZjr+C2FCXn4R
        LBteE5zFWl4EKZky0SHBsYw721qNsxPVO18prPA4aPxEcwrzvqZ5ITmHxH4U5PdHEABfoUkI3eetf
        rJ7vHA6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q77cB-0084zq-06;
        Thu, 08 Jun 2023 04:51:15 +0000
Date:   Wed, 7 Jun 2023 21:51:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        hch@infradead.org, stable@vger.kernel.org,
        Jason Adriaanse <jason_a69@yahoo.co.uk>
Subject: Re: [PATCH RESEND] PCI: Add function 1 DMA alias quirk for Marvell
 88SE9235
Message-ID: <ZIFeQyiYuQUhbKFS@infradead.org>
References: <731507e05d70239aec96fcbfab6e65d8ce00edd2.1686157165.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731507e05d70239aec96fcbfab6e65d8ce00edd2.1686157165.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
