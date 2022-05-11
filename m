Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB9523EC6
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 22:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbiEKUTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 16:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347767AbiEKUTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 16:19:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956782380D3
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 13:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD8261A7C
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 20:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C362AC34119;
        Wed, 11 May 2022 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652300344;
        bh=GWsiTFaSZ+rZaRHHt57euf0a+kuytir+brRbRglD+rs=;
        h=From:To:Cc:Subject:Date:From;
        b=G+gjEfvRf7KyT8vpPcUYdcMKWSiuWH4C11DwIDiOQ/zCwOKPnNdLO9xEXHUzo7Jd9
         y1HBGivgI0BrZvXSnT4k33HzZRk+zZQul7nuQGTb7AmjWT7dnOjfEdjGBZbHQr+AOS
         gqL63fIBTeab8etG7+IHgSsDt3eG7uuVJSDzISSqxQhhhEfyhmjP9PPxIYhy60GfQZ
         aQ7RWO3udWsJvRG3sG+W1hicrDJTfsg1q5QgSAfRMlwcJxujmky/0ptLXtZQ+LEurW
         7XE3FOjaMT16t0ECEstHk5k4XsyJv31A6XIj7vEK94FbjhWlDzQ0ex4q3Sh0hogYir
         aLfRNrXKEPTZg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Date:   Wed, 11 May 2022 15:18:52 -0500
Message-Id: <20220511201856.808690-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
into two funcs"), which appeared in v5.17-rc1, broke booting on the
Raspberry Pi Compute Module 4.  Revert 830aa6f29f07 and subsequent patches
for now.

Bjorn Helgaas (4):
  Revert "PCI: brcmstb: Do not turn off WOL regulators on suspend"
  Revert "PCI: brcmstb: Add control of subdevice voltage regulators"
  Revert "PCI: brcmstb: Add mechanism to turn on subdev regulators"
  Revert "PCI: brcmstb: Split brcm_pcie_setup() into two funcs"

 drivers/pci/controller/pcie-brcmstb.c | 257 +++-----------------------
 1 file changed, 30 insertions(+), 227 deletions(-)

-- 
2.25.1

