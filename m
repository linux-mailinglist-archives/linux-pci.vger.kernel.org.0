Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C4D3A3020
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhFJQIT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 12:08:19 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60182 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhFJQIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 12:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=uTuIg5mKeN6pJVVu/O7o+wA1lV0rKGuorgSswjSfG3E=; b=B2UPU8PGdl4qQMrZIsQmEW9Coq
        AtisDEAON2S5Igmn3dg0JPEn00jxtyda1xznM7k2ha8j2LZD+UxeEgmCjIt9GT0hFZ20LLNozgRYd
        zL8rN6HJtuAxzckW9Er1mSKMQDQHYFzAQPVBaBX7T13TI4dzK9xB3+wmJ6eeW/yC3YjVHtNE85uRf
        VoZTQnDteQgvbEe/taVw77O96UaqOj6wS/ABR3tTrk2J2VZDkYZz1WeDZTn6vd94yR14hqaxE7kod
        E+mErARPmMKXMQQD6uYQaGd7sLCTSVUiHUNaugFlrqkhKkBUx12ZsmHHhSu+cIo6qu0sEWTZWf4Bg
        XSJ5vrYw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lrNCA-0000Jg-Kn; Thu, 10 Jun 2021 10:06:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lrNC8-0007Pe-9x; Thu, 10 Jun 2021 10:06:12 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 10 Jun 2021 10:06:03 -0600
Message-Id: <20210610160609.28447-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, helgaas@kernel.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH v1 0/6] P2PDMA Cleanup
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

This patch series consists of the P2PDMA cleanup and prep patches based
on feedback from  my P2PDMA mapping operations series (most recently
posted at [1]). I've reduced the recipient list of this series to those
that I thought would be interested or have provided the feedback that
inspired these patches.

Please consider taking these patches in the near term ahead of my mapping
ops series. These patches are largely cleanup and other minor fixes. The only
functional change is Patch 4 which adds a new warning that was suggested by
Don.

Patch 6 arguably isn't necessary yet as we don't care about sleeping
yet -- but it'd be a nice to have to reduce the number of prep patches for my
other series. However, if you don't want to take this patch now, I can
carry it in my other series.

I'm happy to make further fixes and update this series if anyone finds any
additional issues on review.

Thanks,

Logan

[1] https://lore.kernel.org/linux-block/20210513223203.5542-1-logang@deltatee.com/

--

Logan Gunthorpe (6):
  PCI/P2PDMA: Rename upstream_bridge_distance() and rework documentation
  PCI/P2PDMA: Use a buffer on the stack for collecting the acs list
  PCI/P2PDMA: Cleanup type for return value of calc_map_type_and_dist()
  PCI/P2PDMA: Print a warning if the host bridge is not in the whitelist
  PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take pagemap and device
  PCI/P2PDMA: Avoid pci_get_slot() which sleeps

 drivers/pci/p2pdma.c | 157 +++++++++++++++++++++++++------------------
 1 file changed, 92 insertions(+), 65 deletions(-)


base-commit: 614124bea77e452aa6df7a8714e8bc820b489922
--
2.20.1
