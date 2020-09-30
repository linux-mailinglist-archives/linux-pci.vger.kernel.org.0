Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351827F537
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 00:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbgI3WhJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 18:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbgI3WhJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 18:37:09 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7462075F;
        Wed, 30 Sep 2020 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601505428;
        bh=ZeMJQjTXrRfqdpsAaR1wF5DYmxnyMoT0CFv6wTurics=;
        h=Date:From:To:Cc:Subject:From;
        b=kk/3LdGl+ltK8TsRkwNt8DDX1gtAWyqcgeT1phQhImam0LIhbSGerQKXyuGGE0OUN
         Pr7klkinZ3WnqhnHZDPSch8pD+wprixvMrsJe8TejmbZJNjzIirPklfcII1KJb3XWA
         rKu9hw3W+NhGioA07nKvAfOTe8lagbq+Imw4/xU4=
Date:   Wed, 30 Sep 2020 17:37:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pratyush Anand <pratyush.anand@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: of_match[] warnings
Message-ID: <20200930223707.GA2640592@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These warnings are sort of annoying.  I guess most of the other
drivers avoid this by depending on OF as well as COMPILE_TEST.

  $ grep -E "CONFIG_(OF|PCIE_(SPEAR13XX|ARMADA_8K))" .config
  CONFIG_PCIE_SPEAR13XX=y
  CONFIG_PCIE_ARMADA_8K=y
  # CONFIG_OF is not set

  $ make W=1 drivers/pci/
  ...
    CC      drivers/pci/controller/dwc/pcie-spear13xx.o
  drivers/pci/controller/dwc/pcie-spear13xx.c:270:34: warning: ‘spear13xx_pcie_of_match’ defined but not used [-Wunused-const-variable=]
    270 | static const struct of_device_id spear13xx_pcie_of_match[] = {
	|                                  ^~~~~~~~~~~~~~~~~~~~~~~
  ...
    CC      drivers/pci/controller/dwc/pcie-armada8k.o
  drivers/pci/controller/dwc/pcie-armada8k.c:344:34: warning: ‘armada8k_pcie_of_match’ defined but not used [-Wunused-const-variable=]
    344 | static const struct of_device_id armada8k_pcie_of_match[] = {
	|                                  ^~~~~~~~~~~~~~~~~~~~~~

