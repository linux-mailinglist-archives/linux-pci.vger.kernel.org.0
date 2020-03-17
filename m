Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DAF18877F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgCQO2i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 10:28:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgCQO2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2020 10:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QWkBVq6F22sOftkJaM+T/BE5V49T+3WQgdRW7zJx9Ms=; b=P0BDRTxf8KOX4lPiB7yA8iuC7S
        dahvW1h3BAcJ8DOXN2Y7fPABl4P0qnkxWEhxcJTaoGfpOsvTQKuHWh8H8vZVVgMlsDOpyDoQQ4X20
        riVC6huDzLd4vWASc+JeNbddpyi7F97AfkvqC9y/dEBohnYz87iF1LK/l4RVaRIpfCB2rpAbroVDW
        a5HaMfCiCYaG1bCgXcDA1MCmIBAUGXyhXAXwoId2o0EsC+rk3H5cskvgqx3Pqsbd0WwqcD74DJqQ3
        FVGdPgI2bE8YsS9qJGWPXD9cwDmd/QZs0PWWX6Nv9uZk3Bjamy3/42N0Cso8UEdyQ6Raj8xhYUpUZ
        Nej28Tig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDCt-00007V-V7; Tue, 17 Mar 2020 14:28:35 +0000
Date:   Tue, 17 Mar 2020 07:28:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikel Rychliski <mikel@mikelr.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH 2/4] PCI: Use ioremap, not phys_to_virt for platform rom
Message-ID: <20200317142835.GA23471@infradead.org>
References: <20200303033457.12180-1-mikel@mikelr.com>
 <20200303033457.12180-3-mikel@mikelr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200303033457.12180-3-mikel@mikelr.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Any reason drivers can't just use pci_map_rom insteadἅ which already
does the right thing?
