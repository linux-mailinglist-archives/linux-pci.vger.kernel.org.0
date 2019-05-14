Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E65E1C2B3
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 08:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfENGCj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 02:02:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENGCj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 02:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ecFsjeXieV9h3Fjo2VPit06w6DAoGJHeCAQiJy8yh1I=; b=Febku/bv1m6bGePNQRiuuuwGC
        sCAh71ePAxt+5+rfCcN24Ub59rLk9XptZe4o/Wak5eyMwAXAcQd8vsp14Fnzi2C07Y5sr3aHO/F17
        ke0Y/HP6rS/HHI6uD+S0kkrbPtD+FlW/LoYPgCSgrt6bqIWaYv3MvJVGJ33ab1USgBljny9w80TUa
        Iy527WdGHlHIjjJdJoMSNPICTjyVG6hNOp2uPmV4lgzYEbQeIHpTXjfWQVM/1+JnIOk/tH59kReHf
        Dkqrg2M+K17AUwEX5Wt7uId6xbc70xBfVJOPlBQf7UvZwP7Z9k7tMyXhRPlNm3vOxYxUTaj+HsHBp
        bTIC8A7Sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQQWB-0003hG-L2; Tue, 14 May 2019 06:02:27 +0000
Date:   Mon, 13 May 2019 23:02:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 02/15] PCI/PME: Export pcie_pme_disable_msi() &
 pcie_pme_no_msi() APIs
Message-ID: <20190514060227.GA7625@infradead.org>
References: <20190513050626.14991-1-vidyas@nvidia.com>
 <20190513050626.14991-3-vidyas@nvidia.com>
 <20190513072539.GA27708@infradead.org>
 <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a8cea93-2aeb-e5e2-4d56-f0c6449073c3@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 14, 2019 at 09:00:19AM +0530, Vidya Sagar wrote:
> There is nothing broken in Tegra194 root port as such, rather,  this is more
> of software configuration choice and we are going with legacy interrupts than
> MSI interrupts (as Tegra194 doesn't support raising PME interrupts through MSI
> and please note that this doesn't mean root port is broken).

It seems odd at least and probably broken if it adverises MSI interrupts,
but than doesn't actually support them fully.

> Since Tegra194 has
> only Synopsys DesignWare core based host controllers and not any other hosts, I
> think it is fine to call this API in driver. Also, since this is a global setting,
> calling this APIs from anywhere (be it from quirk or from driver) would have the
> same effect, or did I miss anything here?

Maybe in your current particular case this is true, but in general
we see more and more systems with different kind of root ports, and
having a driver set a global variable due to its own hardwares quirk
defeats that.  So the right thing here is to replace the global
flag with a per-device one first before setting it for a driver.
