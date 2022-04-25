Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67650E100
	for <lists+linux-pci@lfdr.de>; Mon, 25 Apr 2022 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239535AbiDYNF4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Apr 2022 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiDYNFz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2022 09:05:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 064DB13D76
        for <linux-pci@vger.kernel.org>; Mon, 25 Apr 2022 06:02:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72491FB;
        Mon, 25 Apr 2022 06:02:51 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A095F3F774;
        Mon, 25 Apr 2022 06:02:49 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Cowan <ian@linux.cowan.aero>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, kernel@pengutronix.de
Subject: Re: [PATCH] PCI: microchip: Add a missing semicolon
Date:   Mon, 25 Apr 2022 14:02:44 +0100
Message-Id: <165089168857.6741.3890068275128497733.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220420065832.14173-1-u.kleine-koenig@pengutronix.de>
References: <20220420065832.14173-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Apr 2022 08:58:32 +0200, Uwe Kleine-König wrote:
> If the driver is configured as a module (after allowing this by changing
> PCIE_MICROCHIP_HOST from bool to tristate) the missing semicolon makes the
> compiler very unhappy. While there isn't a real problem as
> MODULE_DEVICE_TABLE always evaluates to nothing for a built-in driver,
> do it right for consistency with other drivers.
> 
> 
> [...]

Applied to pci/microchip, thanks!

[1/1] PCI: microchip: Add a missing semicolon
      https://git.kernel.org/lpieralisi/pci/c/c049b4b376

Thanks,
Lorenzo
