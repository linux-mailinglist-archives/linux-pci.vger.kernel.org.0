Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95BA0480
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 16:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfH1OO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 10:14:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1OO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 10:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6rDsAjXtgHuoENe2BDRKRs4vEoPiD7Zi5fpWyf81iqE=; b=suUi86WsP4Cg2rN2Vo+u+2OHE
        J8vy9p1eaA1Oew6VTAjT8CCrTFxU5g8fq37tY9DskhJKF/nlZA3q9vxu87LaV3kVlbCk9HRD6Ti+q
        0QdJbvBwNZ8sV59cGXt4XML08AHjMkuBuC3xO7IUE33Qppl1w9qLFRy0iveSAHvqL2ccwi04MqU/W
        S4q4Hud6bgCQmn4yYEhI+gSisfnAUsgS4ruvRMgX3/7nq78ZT0dR6oTXwHWNiRbFBkSlhDeCgZMv4
        lztj5I3kT2eWZ2D0ULjCPCnH5KJw4B6XkWB6LWScmQ2GhdT8E69jn4v8Hp2b1Q+EoO/SkTZU5+stE
        BollTDDAA==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2yij-0000T4-P7; Wed, 28 Aug 2019 14:14:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     x86@kernel.org, joro@8bytes.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, dwmw2@infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: stop overriding dma_ops in vmd v2
Date:   Wed, 28 Aug 2019 16:14:38 +0200
Message-Id: <20190828141443.5253-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

this is a new version of the vmd dma_map_ops removal, which does not
require vmd to be built in.  Instead we slightly expand the vmd-specific
field in the x86 pci_sysdata to cover that information.

Note that I do not have a vmd-enable system, so some testing by the
maintainers would be welcome.
