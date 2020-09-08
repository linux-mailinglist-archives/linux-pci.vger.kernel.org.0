Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5CA261E7A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 21:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgIHTwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 15:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730939AbgIHTwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 15:52:00 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F1920658;
        Tue,  8 Sep 2020 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599594720;
        bh=mULXzfnS3APhi3N2dq0E+DMdisvzv4rccw8WftfDozc=;
        h=Date:From:To:Cc:Subject:From;
        b=hxURh5O0P4g+eHQp8b16ufLINfkIVcrcQUFePC3Ih4y9mTLErRy86vq2Y3v1qTJv1
         54ZYMeKGJ7zEMlbeWGA3ekdK62dhkpShdS9+YsN8sn6ImdGNJiRZ+pWljyHvzxajlf
         um371hDpe8iS2DkUxVKGUfnwNEz3FoNIfh08eG88=
Date:   Tue, 8 Sep 2020 14:51:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org
Subject: pci-epf-test.c sparse warnings
Message-ID: <20200908195158.GA627339@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI, got these warnings with "make C=2 drivers/pci/":

  CHECK   drivers/pci/endpoint/functions/pci-epf-test.c
drivers/pci/endpoint/functions/pci-epf-test.c:288:24: warning: incorrect type in argument 1 (different address spaces)
drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    expected void *to
drivers/pci/endpoint/functions/pci-epf-test.c:288:24:    got void [noderef] __iomem *[assigned] dst_addr
drivers/pci/endpoint/functions/pci-epf-test.c:288:34: warning: incorrect type in argument 2 (different address spaces)
drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    expected void const *from
drivers/pci/endpoint/functions/pci-epf-test.c:288:34:    got void [noderef] __iomem *[assigned] src_addr

This is on my "next" branch, but I don't think this file has changed
since v5.9-rc1.

Bjorn
