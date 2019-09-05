Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C376DAA148
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 13:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfIEL0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 07:26:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388377AbfIEL0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 07:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FF586Gx7pagckCQE7fW4rjr03JygAyA2r24BMBu1wCA=; b=cEPuUO3D/lnvG/7YuYlV5fgc2
        ZxKkpjfOI/M9KXFwqzuDoX4Np91tRGmNAlWTKmaOD9egadePV9Ct5zkXBk3c90dqZQ6jG0qGPJ7im
        s84I4mjGeKpvQFByHFZlCUB/FmZnj7EkiG+jVHtXDC2pt2xOw6OEMqVypd9TFCAJb0EZdVi8+V2ru
        MpEIdhdjA9+afAh2c/0tuGoO1q3BpMmB1CuALpwQq3h+UClgy5pfVhEXdedz2xzy2qwn08M9xQWZ6
        t9Y4dvKyv95VZLaV5hv938Ex6fIrpRkyfPr02P3P63hlE50Zy4s92Bdc/ysMdcQal55wD+xlU38fi
        IE9KFIIXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5pty-0005Cr-9h; Thu, 05 Sep 2019 11:26:10 +0000
Date:   Thu, 5 Sep 2019 04:26:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v3 2/2] dwc: PCI: intel: Intel PCIe RC controller driver
Message-ID: <20190905112610.GB10199@infradead.org>
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <35316bac59d3bc681e76d33e0345f4ef950c4414.1567585181.git.eswara.kota@linux.intel.com>
 <20190905104517.GX9720@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905104517.GX9720@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 11:45:18AM +0100, Andrew Murray wrote:
> > +        depends on OF
> > +        select PCIE_DW_HOST
> > +        help
> > +          Say 'Y' here to enable support for Intel AHB/AXI PCIe Host
> > +	  controller driver.
> > +	  The Intel PCIe controller is based on the Synopsys Designware
> > +	  pcie core and therefore uses the Designware core functions to
> > +	  implement the driver.
> 
> I can see this description is similar to others in the same Kconfig,
> however I'm not sure what value a user gains by knowing implementation
> details - it's helpful to know that PCIE_INTEL_AXI is based on the
> Designware core, but is it helpful to know that the Designware core
> functions are used?

Not really.  What would be extremely useful for a user is what Intel
SOC contains this IP block, or the fact that most of those were
actually produced by Lantiq, a company bought by Intel.
