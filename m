Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075F17F1FF3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Nov 2023 23:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjKTWHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Nov 2023 17:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWHS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Nov 2023 17:07:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2C1C3
        for <linux-pci@vger.kernel.org>; Mon, 20 Nov 2023 14:07:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4C6C433C7;
        Mon, 20 Nov 2023 22:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700518034;
        bh=pRfngoTn/pdZvbsfo9mWloDhdaSb2Q6x+sHbTJ55rNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvzL5MLNpEIN3tQ0N6BcoU9Mj9SfFdXhLBOhd2TNTS34OUXGaTq3TiT1TWrC5c+LU
         tXZ5N7Y1isGMSYJc/mG9CA6ar7+ne+x+AzdTvlBZu90w85AWP9fRF/RuQYOn59lENs
         1zAfnysjVWiCf/zgF0QaOjN5XlHwn9CyX2Csg3c1GqmWSO00YnOgYN3s7osciD2uqt
         hcrzT6BSE+JHFN+jfAry+y38+mOdtx9qV1aV2MNI8eSgiPm2f2m0zpHYCAsvgSHtrU
         P6BteFJPFRy+/am830pAdLJmr0w54OYj7qDCZFwyD/pjOKTfCq/6VnStNr5+HibpKv
         y/oNLgucTcY4g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, stable@kernel.org,
        Tadeusz Struk <tstruk@gigaio.com>
Subject: Re: [PATCH v2] Documentation: PCI/P2PDMA: Remove reference to pci_p2pdma_map_sg()
Date:   Mon, 20 Nov 2023 16:07:13 -0600
Message-Id: <170051800635.218334.12191403128072786783.b4-ty@google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113180325.444692-1-tstruk@gmail.com>
References: <6eb84bc5-dd58-4745-8e99-ccc97c10fb63@deltatee.com> <20231113180325.444692-1-tstruk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>


On Mon, 13 Nov 2023 19:03:25 +0100, Tadeusz Struk wrote:
> Update Documentation/driver-api/pci/p2pdma.rst doc and
> remove references to obsolete p2pdma mapping functions.
> 
> Fixes: 0d06132fc84b ("PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Tadeusz Struk <tstruk@gigaio.com>
> ----
> 
> [...]

Applied to "p2pdma" for v6.8, thanks!

[1/1] Documentation: PCI/P2PDMA: Remove reference to pci_p2pdma_map_sg()
      commit: 9a000a72af75886e5de13f4edef7f0d788622e7d

Best regards,
-- 
Bjorn Helgaas <bhelgaas@google.com>
