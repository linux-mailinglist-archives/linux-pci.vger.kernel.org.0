Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B87794A7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjHKQbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Aug 2023 12:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjHKQbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Aug 2023 12:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852612D66;
        Fri, 11 Aug 2023 09:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 113376689D;
        Fri, 11 Aug 2023 16:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2918DC433C8;
        Fri, 11 Aug 2023 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691771506;
        bh=4jBRje17YszK5trMhh7GZtZTzlLmAgDuuSaJR0mgWoc=;
        h=Date:From:To:Cc:Subject:From;
        b=OZqb0upgzeo7SkQHjb0KLme73aXd2vDW/dg64paTqamVHvMwrgHKfUWEQum+tUqsZ
         4VzR+EP6iUzXP331t1aRuy5WXz8m8p0mo/PQqwXjGdDanxEt/Ivoob7lm8Q2btCWKT
         +wyruExtBpClVYLtaK20jxw3ANkIAAc9MlCqvHR5JaVTTo6DB2qqWyWFA7B3SQZoEM
         5BGfAOLfP6SsIZyDSlntNQDujKrbicEkDsiaX+a7k5h5WP6v6jWOqLRcZ4Ic025Ofg
         Hq0xXEodbawBF/eYvd0E/RCEYcSOt/ud4w9MsaF2abYCqU0a2PYP4Oq+L6a8z6+Z/u
         1tfJhgNdGXF5Q==
Date:   Fri, 11 Aug 2023 11:31:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Fabio Estevam <festevam@gmail.com>,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Woody Suwalski <terraluna977@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Sajid Dalvi <sdalvi@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>
Subject: [GIT PULL] PCI fixes for v6.5
Message-ID: <20230811163144.GA75144@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.5-fixes-1

for you to fetch changes up to cc22522fd55e257c86d340ae9aedc122e705a435:

  PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus (2023-08-08 14:30:00 -0500)

----------------------------------------------------------------
- Add Manivannan Sadhasivam as DesignWare PCIe driver co-maintainer
  (Krzysztof Wilczyński)

- Revert "PCI: dwc: Wait for link up only if link is started" to fix a
  regression on Qualcomm platforms that don't reach interconnect sync state
  if the slot is empty (Johan Hovold)

- Revert "PCI: mvebu: Mark driver as BROKEN" so people can use pci-mvebu
  even though some others report problems (Bjorn Helgaas)

- Avoid a NULL pointer dereference when using acpiphp for root bus hotplug
  to fix a regression added in v6.5-rc1 (Igor Mammedov)

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI: mvebu: Mark driver as BROKEN"

Igor Mammedov (1):
      PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus

Johan Hovold (1):
      Revert "PCI: dwc: Wait for link up only if link is started"

Krzysztof Wilczyński (1):
      MAINTAINERS: Add Manivannan Sadhasivam as DesignWare PCIe driver maintainer

 MAINTAINERS                                       |  1 +
 drivers/pci/controller/Kconfig                    |  1 -
 drivers/pci/controller/dwc/pcie-designware-host.c | 13 ++++---------
 drivers/pci/controller/dwc/pcie-designware.c      | 20 +++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 -
 drivers/pci/hotplug/acpiphp_glue.c                |  8 +++++++-
 6 files changed, 19 insertions(+), 25 deletions(-)
