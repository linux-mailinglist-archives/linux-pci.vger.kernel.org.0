Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92AF64EEE5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 17:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiLPQWE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 11:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiLPQVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 11:21:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF3711150;
        Fri, 16 Dec 2022 08:21:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74200B81D12;
        Fri, 16 Dec 2022 16:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC311C433D2;
        Fri, 16 Dec 2022 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671207692;
        bh=PcFvDWvuGm/hNaofCgIJSIFQ8fcKSkyPREIHB70eKYg=;
        h=From:To:Cc:Subject:Date:From;
        b=TQFRbvjRnIVZy9EUABEqSELdr21+SdA0pbhQrpV83rfmVVZXdmcy0pscNkLBC6DR5
         WXTEarDX0f5gyiXLkNq1jSg9fcnYREMrJkh5GJbSARGf9zcclRLNuAeKAm6c/Mnj09
         OQughPVzkT9/wA5nxMClC1Ezp7uMztaud86JAXMTE78u4EbHRG+hPMzFiXndun2MJL
         vGJd9iMVYVEoaoG7cgLWqhJjPOgPZth9uYzEg8C41QNqM/PYx1t/GzxInatR4WJTmo
         dk3PH3VZUCx1zt6W2z8F+XrVUyERHTld1+d0MnChdVImwcNFISbMipr8k2xsnSiF75
         E7u+xDp8MFV/A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] PCI: switchtec: Trivial cleanups
Date:   Fri, 16 Dec 2022 10:21:24 -0600
Message-Id: <20221216162126.207863-1-helgaas@kernel.org>
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

 drivers/pci/switch/switchtec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

Changes between v1 and v2:
- Return -EFAULT for copy_to_user() errors.
-- 
2.25.1

