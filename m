Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3D65DD9A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 21:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjADUWn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 15:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbjADUWa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 15:22:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B06833D4A;
        Wed,  4 Jan 2023 12:22:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF7EB818C9;
        Wed,  4 Jan 2023 20:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD253C433EF;
        Wed,  4 Jan 2023 20:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672863747;
        bh=jrqpeCMbBW5TX8ax2vei9eWcJYtFJPH3uo1LpgNboVE=;
        h=From:To:Cc:Subject:Date:From;
        b=Bd55Q9m8esh07DNVY1aQ7z+SieobAQ+YX6v5UfoammB09z8TNIFWTHlQWLfWpzccX
         s2zRQYbcu/LSJAc2rZ34XuYmhrLd9HUcu1a+p/0GQ/UPIUj2lnrbvIQmsk/Gw49Xbw
         4zUv5C0Ubo0NCoYfhU3UCDVAz24ySTxIKxwuyqqp7etGdDFCdyxKxqrBikZe2U56PT
         WBxsl7XT8ii4iSrmOZy56lYtYyYFUx7h2wwL/Y6zPP6iRijCPJE/x5d6gtQoEcdSKG
         w6pYoEm6wmfi8n6auUyF74YcAnaNmM4O2W2QVEwOqAgsiRchwgK/ahVxFzr8wNeaA4
         kT0rxRaNriJxg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 0/2] PCI: switchtec: Trivial cleanups
Date:   Wed,  4 Jan 2023 14:22:21 -0600
Message-Id: <20230104202223.1091085-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Simplify switchtec_dma_mrpc_isr() slightly and return the right
copy_to_user() error code from switchtec_dev_read().

Bjorn Helgaas (2):
  PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
  PCI: switchtec: Return -EFAULT for copy_to_user() errors

 drivers/pci/switch/switchtec.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

Changes between v2 and v3:
- Remove unused label "out".
Changes between v1 and v2:
- Return -EFAULT for copy_to_user() errors.
-- 
2.25.1

