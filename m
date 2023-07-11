Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A86B74E63D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 07:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGKFMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 01:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGKFL5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 01:11:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1126893;
        Mon, 10 Jul 2023 22:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=zsYBwGu2f/Iib7AX0FTXomrMvP
        e2btr86zCRmEdGGfoJ4gahcVlYQATiE7DlZQQt2hi43xQJoS4kwoqsPSUr25E0FQbZjGnvU5ICcyV
        zov1SGLyE2avvmK8EnWYzKbAF97JZBh3S3Prt5OGbO4/MYqIXZiNVlV0/Zi3KRlZsqHpNgCvnbAC8
        6q1gw7O7ZzEsDJOp/jy9VHXgVX3nPYITDFK42Y5heFy0sBfrbkBBlkeaOkmewdWupXileiAhpZ/ni
        Z5Xsij60T1AVSRakkPRmvoqmtzBHTQaEU3Wauec1D9/Q23UZZoQN8PHdUwXQxX/J7bLHdzl+1plI+
        K5k5uwyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ5fI-00DivK-32;
        Tue, 11 Jul 2023 05:11:56 +0000
Date:   Mon, 10 Jul 2023 22:11:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI/AER: Unexport pci_enable_pcie_error_reporting()
Message-ID: <ZKzknJc3jMunm/w1@infradead.org>
References: <20230710232136.233034-1-helgaas@kernel.org>
 <20230710232136.233034-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710232136.233034-3-helgaas@kernel.org>
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
