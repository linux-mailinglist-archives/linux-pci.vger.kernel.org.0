Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D84FBCA7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiDKNCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 09:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237127AbiDKNCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 09:02:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2240E1A059;
        Mon, 11 Apr 2022 06:00:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF6F61570;
        Mon, 11 Apr 2022 06:00:02 -0700 (PDT)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E632B3F5A1;
        Mon, 11 Apr 2022 06:00:00 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Remove unnecessary MSI enable reg save and restore
Date:   Mon, 11 Apr 2022 14:00:01 +0100
Message-Id: <164968161357.31358.16962108269049555956.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211226074910.2722-1-jszhang@kernel.org>
References: <20211226074910.2722-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 26 Dec 2021 15:49:10 +0800, Jisheng Zhang wrote:
> The integrated MSI Receiver enable register is always initialized in
> dw_pcie_setup_rc() which is also called in resume code path, so we
> don't need to save/restore the enable register during suspend/resume.
> 
> 

Applied to pci/dwc, thanks!

[1/1] PCI: tegra194: Remove unnecessary MSI enable reg save and restore
      https://git.kernel.org/lpieralisi/pci/c/571dda6ca5

Thanks,
Lorenzo
