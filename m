Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB41D54F4
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgEOPnx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 11:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbgEOPnw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 11:43:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85B8C061A0C
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2020 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BjsvnKmgLtuX+mwy7iZ0Hc2xoPJhHClDJ9oKI8T01Ec=; b=Yrd6nYC8k4cK9PpxgDftcC4dfg
        9Px+9LjhYk7LVdANR2rgAUg0/IuV/QWlGTx+cqQPC88JXWay2HP3TMaIqyhMiHf0Qo1wU3DmJnw6J
        67Kk1vLGt0YJINJ+22gk/YXFI9w8bbxr4gv1KqQQsoV/9hF8oQWsRaXU6k47Y6AJvmdw6w15W45w2
        4PeeDRN+Fx9XhZyilPxwtPApQzlzsBUddUZfvmIpcspEZcm+WqTHHRVu4VzkwgiEC66ljw5AFhRy5
        dXojjXf721u5sEkGW7sS3iHdvWv0r0esq13SFz0BYIrQFRVS+MEV6T/PiUVK0vPjtd1hf/x4NtSFl
        sdlzzfEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZcV5-0002Ks-2e; Fri, 15 May 2020 15:43:51 +0000
Date:   Fri, 15 May 2020 08:43:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        bhelgaas@google.com, ashok.raj@intel.com, will@kernel.org,
        alex.williamson@redhat.com, robin.murphy@arm.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200515154351.GA6546@infradead.org>
References: <20200515104359.1178606-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515104359.1178606-1-jean-philippe@linaro.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Can you please lift the untrusted flag into struct device?  It really
isn't a PCI specific concept, and we should not have code poking into
pci_dev all over the iommu code.
