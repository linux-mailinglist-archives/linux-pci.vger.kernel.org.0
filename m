Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738FC1887F7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 15:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgCQOp3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 10:45:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60888 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgCQOnp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 10:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S6NdTWibk79+YugWFTSLV3fGTXeAxQI8N46whgDUO3c=; b=Cni3IHCz/BEbBcs7bSSGQn3Guj
        3SLR4Fwdl6HMHn2vmXaKFOSKBvatq/MpRvt1QNhS9UXk5/ACO4wAxVd8QR9djzoiAZNT55VjXD6gR
        NfGS/AAR0rk1iHGWGiZH6hdWuDsZoeU56NdVzk1mH2lM24QqEL+K8nVLsLZKgnB2eUPVZPzK0mUHS
        qN05y0Zd6LZE8qZseYi6Nr66OBtIWPAQwiMl4nPu/THHbRhqhNoI2L3Sc/PBYQ2+nh1NO7rvkNgEE
        QJ15s8ln7aDj+EONSM30Y8rlTpUC/D+e88IyRMAIawn8sMMmOT/vESepCT8HjoxDzM38eEFPuv+Bk
        JubQnSwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDRY-0006FO-0X; Tue, 17 Mar 2020 14:43:44 +0000
Date:   Tue, 17 Mar 2020 07:43:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v17 10/12] PCI/DPC: Export DPC error recovery functions
Message-ID: <20200317144343.GF23471@infradead.org>
References: <cover.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <ac8816d4d41d0894720660f9b51dbeac0842869d.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8816d4d41d0894720660f9b51dbeac0842869d.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nothing is actually exported here (fortunately!).
