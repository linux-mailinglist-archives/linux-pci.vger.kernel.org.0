Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225C85A0D87
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbiHYKKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiHYKKF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 06:10:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD15DA9;
        Thu, 25 Aug 2022 03:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47EC6B8282D;
        Thu, 25 Aug 2022 10:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC73C433C1;
        Thu, 25 Aug 2022 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661422201;
        bh=pLCRAXfPiIRyhyrD58YN67FVazY1HzSautKpvNIgroc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azsa8nRZuRWsheTGZDoXgB6MDvAxTfbm3EnVhJFX4AKzKIZP1LY8j+bZBNSa0vl2N
         hOHzyGhtB04naOZJ5V/+tejgaKqMA7ek5y1Z+9BwnZevab9LPmPOljiC+vDxuiVR2j
         qiVWpwtkyCsC2lU2iP6MntrwOrRlcsFTx13Y5uo13T4ErFGmtvXUyD+0AxF3hmXNrw
         32PgH4rEqJBKcg0nrKPa0O4Vg+fIaPiBNC9XrSvG3I0CCNN511n1ie7TRudklDwROA
         p+sSv8i1gylXCC+sIJ3DB3GjR8b3+nfLhMyD4mpTJiOaRhAYytqQ7WOqRZMU9BexM9
         xA1N2tPxaFclA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: Re: [PATCH v3] PCI: pci-bridge-emul: Set position of PCI capabilities to real HW value
Date:   Thu, 25 Aug 2022 12:09:54 +0200
Message-Id: <166142217602.128276.10729379597803060542.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220824112124.21675-1-pali@kernel.org>
References: <20220703104627.27058-1-pali@kernel.org> <20220824112124.21675-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Aug 2022 13:21:24 +0200, Pali Rohár wrote:
> mvebu and aardvark HW have PCIe capabilities on different offset in PCI
> config space. Extend pci-bridge-emul.c code to allow setting custom driver
> custom value where PCIe capabilities starts.
> 
> With this change PCIe capabilities of both drivers are reported at the same
> location as where they are reported by U-Boot - in their real HW offset.
> 
> [...]

Applied to pci/bridge-emul, thanks!

[1/1] PCI: pci-bridge-emul: Set position of PCI capabilities to real HW value
      https://git.kernel.org/lpieralisi/pci/c/658aea35ab88

Thanks,
Lorenzo
