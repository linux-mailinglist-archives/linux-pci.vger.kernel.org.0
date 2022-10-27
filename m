Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A1E60F1EB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 10:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbiJ0ILJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 04:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ0ILJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 04:11:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC36B495CE
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 01:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DB9EB824DF
        for <linux-pci@vger.kernel.org>; Thu, 27 Oct 2022 08:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7A2C433D6;
        Thu, 27 Oct 2022 08:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666858257;
        bh=cmDlpm0hia6Fji9wa+XgWMxlbLQ+ZcxtxoudgxDc0K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WrmD5J9xf1gWk811H+4H2N9abW3ei3l3dg5zRCY34XJxPdMSlSqkWQigeywOFeV/g
         ZcCnrzFeG0myQQuckhFkM82WWku51S4hTZbDiuZCxqKxn1fFNkrDPDVkpfzGhwMWpm
         MWShb1eHaYecF2wMNN9hNy4DskvwxzTc5iy/m7p3NWcuyswzt3Plp9tLjX2miVe4jL
         Or+XL0bDnjv6zH8w/Tk+SwVAUWMMPAhTEZ1/qnssQrGoiFtoeAa1hyBIFgViFBjPsF
         ho9p7OGx1V5H2VfQeKkrf59tVBPWVr1yWdQSAFKz9WarEQI4Ziwc/cvimGzjCNhffX
         r1BTYV9g5IfiQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        Matt Ranostay <mranostay@ti.com>, robh+dt@kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v2 0/2] dt-bindings: PCI: ti,j721e-pci-*: resolve unexpected property warnings
Date:   Thu, 27 Oct 2022 10:10:50 +0200
Message-Id: <166685823379.815192.10092225520185863919.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025081909.404107-1-mranostay@ti.com>
References: <20221025081909.404107-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Oct 2022 01:19:07 -0700, Matt Ranostay wrote:
> Resolve unexpected property warnings related to interrupts in both J721E PCI EP and host
> yaml files.
> 
> Changes from v1:
> * Fix typo in commit message
> * Add missing Cc to maintainers
> 
> [...]

Applied to pci/dt, thanks!

[1/2] dt-bindings: PCI: ti,j721e-pci-host: add interrupt controller definition
      https://git.kernel.org/lpieralisi/pci/c/ba4ff1cb6cac
[2/2] dt-bindings: PCI: ti,j721e-pci-*: Add missing interrupt properties
      https://git.kernel.org/lpieralisi/pci/c/598418e60356

Thanks,
Lorenzo
