Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C4F73AC78
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 00:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjFVW0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jun 2023 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFVW0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jun 2023 18:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F5C1BE7;
        Thu, 22 Jun 2023 15:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44AAC61919;
        Thu, 22 Jun 2023 22:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9ABC433C0;
        Thu, 22 Jun 2023 22:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687472794;
        bh=CnMbBfSDmVCIPkwGJPJlf3TZ1ONVeMjLcCPUmg4sOHg=;
        h=Date:From:To:Cc:Subject:From;
        b=S/8+WYeA1BNaTUW//JRTZ9XT0NZnsM7fO9yOWDJdYPhe2JS2P/HY5ZvftWfmD/9Tc
         M8drau2cRUa+3wykEMc1v4/WbQMnllaIB6xKf+bSCyOGM31FLbKrv0M+rvGudMS5hR
         +XXDVuEbVHzu7OE4B1AWj8U2krWGrXKJoXvCCO83AWh+9BbAT+gequpbS4wz9DjJR9
         IzNc4hAdM9W2YvOa8OFTZ43BGrl/oRhuwf04omWppL44g8lPa9Pav8zgKIhrmXPQJF
         w1St0CQPU8qzL2CY+DM2QVN0AgylqQXAEsi21jyb0omJPt0dyvOclhDe/ChcMBglWA
         /dlNwzUlgQesg==
Date:   Thu, 22 Jun 2023 17:26:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Zhu YiXin <yzhu@maxlinear.com>,
        Lei Chuanhua <lchuanhua@maxlinear.com>,
        Rahul Tanwar <rahul_tanwar@yahoo.com>
Subject: [GIT PULL] PCI fixes for v6.4
Message-ID: <20230622222631.GA153948@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-fixes-2

for you to fetch changes up to 40994ce0ea010b1843e620bacc26d29ddebfc08d:

  MAINTAINERS: Add Chuanhua Lei as Intel LGM GW PCIe maintainer (2023-05-31 12:20:24 -0500)

----------------------------------------------------------------
- Transfer Intel LGM GW PCIe maintenance from Rahul Tanwar to Chuanhua
  Lei (Zhu YiXin)

----------------------------------------------------------------
Zhu YiXin (1):
      MAINTAINERS: Add Chuanhua Lei as Intel LGM GW PCIe maintainer

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
