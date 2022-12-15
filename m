Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7564E091
	for <lists+linux-pci@lfdr.de>; Thu, 15 Dec 2022 19:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiLOSVs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Dec 2022 13:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiLOSVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2022 13:21:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119714664C;
        Thu, 15 Dec 2022 10:21:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C54F61EAC;
        Thu, 15 Dec 2022 18:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C615FC433D2;
        Thu, 15 Dec 2022 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128505;
        bh=vbeN8sZGNtAwPTy+oEVWXy95GJ/bslF/ppCbMLAUkxg=;
        h=From:To:Cc:Subject:Date:From;
        b=d1Y3L/pUlMFo8wvKzX/cokeihdiyLOHfoACm5KoEM15bk8Ifb8nxIrTNc5QGBb0Ph
         BjpDsRZhw1u2KX6Nqk/ChsUZKXSyarxdat6r9RGshO+u21oO4MML1K5jAVYgbo1otg
         YqIa75DoOItkpm00gQOmCNpxLg3URnyUMew7u+yUAJWQAiWWmpxmwDpz/tJuz6pFKP
         Q2bvTITyy1Kk/8bemsfPJV50rDQu4hRftX0gtsl2jwm21bDTSdUqiqoUzYIm2tkDIn
         C4Iw5VuladXi4zS4RKHgZ5ib8dxI4uQYlYmGBLTIFsvN+RISZzf3ZXHsP0zNptrmuC
         DN2Q3LJ57URWA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: switchtec: Trivial cleanups
Date:   Thu, 15 Dec 2022 12:21:38 -0600
Message-Id: <20221215182140.129559-1-helgaas@kernel.org>
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

Simplify switchtec_dma_mrpc_isr() slightly and remove some unused
assignments in switchtec_dev_read().

It's possible you want a different fix for the latter, e.g., actually
returning the error values that are currently assigned but then ignored.

Bjorn Helgaas (2):
  PCI: switchtec: Simplify switchtec_dma_mrpc_isr()
  PCI: switchtec: Remove useless assignments in switchtec_dev_read()

 drivers/pci/switch/switchtec.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

-- 
2.25.1

