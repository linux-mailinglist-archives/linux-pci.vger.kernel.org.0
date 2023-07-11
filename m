Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C486474E63B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 07:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjGKFMJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 01:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGKFL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 01:11:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DA10C0;
        Mon, 10 Jul 2023 22:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=c3mrxNa3zrvHue0F+BmTZmxx66
        qFzfXdCfr6G+Cvk/bKYLrQvCZydr0uhDjbuWjVKCy8KvoTV09A0DZs6TiHMseHXJmX8oTLkOm/YA3
        M5QGS1Hq0su1wy2A3yO/TDN4TorRyIZVADNRM46J1aNfcu62BHbYT7nLD3dihM1vRrfrlcLVCvtRq
        aLPIXSPP2mx91hYKfj/WayIeaEn2Ur4XNP+yvvVvGEX4QfYiu5MBI44pHK1+RGIkg/qlq48eXp+eG
        UeV5aUOh4ojSThB97XlBZ6x6hfO/NKAKPI30fWcgDizwn2t4qA+7YGzFJAs9exMietepNscYssPGx
        +uDP+jyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ5f6-00Ditw-1e;
        Tue, 11 Jul 2023 05:11:44 +0000
Date:   Mon, 10 Jul 2023 22:11:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI/AER: Drop unused
 pci_disable_pcie_error_reporting()
Message-ID: <ZKzkkD1HN0gq60d2@infradead.org>
References: <20230710232136.233034-1-helgaas@kernel.org>
 <20230710232136.233034-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710232136.233034-2-helgaas@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
