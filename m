Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571166C81CB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Mar 2023 16:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjCXPvL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Mar 2023 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjCXPvK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Mar 2023 11:51:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C05FD9;
        Fri, 24 Mar 2023 08:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C004B82553;
        Fri, 24 Mar 2023 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4BAC433EF;
        Fri, 24 Mar 2023 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679673066;
        bh=lhcDyi/bq5F2D3+gJB35TEq1CTn4RqDl8qlj1e/rGqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2zJ31ZUU2Y0w114f6bv609XDamMaJcVMahr3BfbjqKTWt5x/4GqmdAguU5EJszgv
         N9HMoGugde827OQzzP7i6oHV6fmfTP0HdzSsBIQRG7y2gjufZwwbfHnhszo5tF+tbu
         4bB3IcZxPVe1yEshr0IQxMfU74gu0MhVRj9cciPmigwqAQyrBHp+z6E0IbavsfPzgg
         sUb1TG/rEVjSRwbRQhF3aIfch6MKp3mP2Tw9vlf2OYCPINV8UEC2uxRzCZmmMgfiT3
         4tr1qEW7DVYOyUlIKBqeENAWSFAeuao+8/WQqHi3w1H7ErB4CSPovVp+GpFTY9Chik
         xhpe3hjjIq9Zw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
Date:   Fri, 24 Mar 2023 16:51:00 +0100
Message-Id: <167967304742.24075.2564602429339147407.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20220928122539.15116-1-pali@kernel.org>
References: <20220928122539.15116-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 28 Sep 2022 14:25:39 +0200, Pali Rohár wrote:
> Simplify pci-ixp4xx.c driver code and use new PCI_CONF1_ADDRESS() macro for
> accessing PCI config space.
> 
> 

Applied to controller/ixp4xx, thanks!

[1/1] PCI: ixp4xx: Use PCI_CONF1_ADDRESS() macro
      https://git.kernel.org/pci/pci/c/6c6fa1f3f771

Thanks,
Lorenzo
