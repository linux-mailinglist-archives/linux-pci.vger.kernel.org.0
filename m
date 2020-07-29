Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530A9232595
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG2TsU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 15:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2TsU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 15:48:20 -0400
Received: from localhost (mobile-166-175-62-240.mycingular.net [166.175.62.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0685C20809;
        Wed, 29 Jul 2020 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596052099;
        bh=3GxIiR5QIEQBeQ+dtOrcBus4Bd7Lh0RVTWTSRDBCrdc=;
        h=Date:From:To:Cc:Subject:From;
        b=H9kf3kRawzSGZUm4eHo4P7fjG/0EESE4MWscqMvp/2h93dl9ybAyrvd+mIdEvgjCe
         xSUndsGB3h5LH1MNCafdgY0Y7iP2InXkT4TnIzu2cZNdnrNeL61aPT/8kxy7AxkiHP
         wwvkvGgQAEIXndvzsFme1MZOPtyrAJcy55s6iV+A=
Date:   Wed, 29 Jul 2020 14:48:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org
Subject: sparse warnings
Message-ID: <20200729194815.GA1961117@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just FYI, I see the following sparse warnings (among others):

  $ make C=2 drivers/pci/

  drivers/pci/endpoint/functions/pci-epf-test.c:288:24: warning: incorrect type in argument 1 (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    expected void *to
  drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    got void [noderef] <asn:2> *[assigned] dst_addr
  drivers/pci/endpoint/functions/pci-epf-test.c:288:34: warning: incorrect type in argument 2 (different address spaces)
  drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    expected void const *from
  drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    got void [noderef] <asn:2> *[assigned] src_addr

  drivers/pci/controller/dwc/pcie-designware.c:447:52: warning: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)

It'd be nice to fix these if it's practical.

There are a bunch more sparse warnings about pci_power_t in the
generic code.  Not sure what those would involve, so they're a problem
for another day.

Bjorn
