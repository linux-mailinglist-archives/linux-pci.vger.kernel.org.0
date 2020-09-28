Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D390627A859
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 09:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1HQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 03:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1HQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 03:16:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69418C0613CE
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2020 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PdTqHbxAzorkhof556wSIvFLOcjCvmNmWJ37riwkv0k=; b=iZy1G5KlOsR8Kg98/IUQqY0qbk
        MoOrq/XCdEtnJZn36cCANdP+W34PeKyjOP3qqSyyzcNmYeoqQp0w3z7HFcGBKHr02xc4bb8JHA4EY
        bOgIrZ7Ts70A6RatbQatSoZu6UcSfADnlai9R9VVlF+apAXd8d7TeiB8NC0FAnarZZiOMI/zSi0of
        VidjxugchMnEtcjXUfOfHRMx7DVmb/m2VNU5PQV3yoipdqlR3YI7GZ/unx+KGF2AO71mf4i9eJzXI
        Sco1zVbsi8PJxaSdnO9xzUUqBCbGYavFBXFOHdSEMdSsw/tDYIBYyrVRDqqmiXCcBAGrrQP6r4kRK
        HtRzID7g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMnOn-0006Vg-S3; Mon, 28 Sep 2020 07:16:37 +0000
Date:   Mon, 28 Sep 2020 08:16:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>
Subject: Re: [PATCH 0/3] PCI: Minimizing resource assignment algorithm
Message-ID: <20200928071637.GA24862@infradead.org>
References: <20200928010609.5375-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928010609.5375-1-jonathan.derrick@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

<broken record>
Intel, please just allow us to opt-out of using VMD as VMD just makes
life miserable.  Thanks!
</broken record>
