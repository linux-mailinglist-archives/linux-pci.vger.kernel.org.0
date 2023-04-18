Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2751B6E5643
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 03:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjDRBR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 21:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjDRBR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 21:17:27 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03E340E6;
        Mon, 17 Apr 2023 18:17:26 -0700 (PDT)
From:   Patrick McLean <chutzpah@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Apply ATI NCQ horkage to ASPEED as well
Date:   Mon, 17 Apr 2023 18:17:18 -0700
Message-Id: <20230418011720.3900090-1-chutzpah@gentoo.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We have some machines with ASPEED SATA controllers, and are seeing the same NCQ
issues that ATI controllers (I am not sure if it's a rebranded ATI controller,
or they both have some faulty implementation). This NCQ breakage is consistent
across a few different types of drives.

Instead of maintaining a list of drives that are broken with ASPEED controllers
as well as AIT, let's just treat ASPEED controllers like ATI ones, and disable
NCQ on drives that have ATA_HORKAGE_NO_NCQ_ON_ATI set on them.

To do this first, we have to make move the definition of the ASPEED vendor from
the ast drm driver to the PCI subsystem.


