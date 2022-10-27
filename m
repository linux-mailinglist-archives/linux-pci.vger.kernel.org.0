Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48D460F857
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiJ0NEP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiJ0NEF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 09:04:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13C0176BB4;
        Thu, 27 Oct 2022 06:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EC93B82639;
        Thu, 27 Oct 2022 13:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9330DC433C1;
        Thu, 27 Oct 2022 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666875842;
        bh=OAxDKBFnJC3maqHQlQTnDwTTUNOHtUtm62TtbtaDNPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxbNcG/Ttc7tLVRsBb1zUFM2tgQBeCHv8Uol2cHgeMyeAO3/+m6wNxIEGA5J+NJJY
         idHFV3HCtYhZQhDK2h+3GVLMAasonJ57EzJS/9hcJG1DC4A5eVkykk8BeZcgh8E3s9
         0N4BXx5dtQK1H9u5szQwpUBEDkWmYRgumKgXMziUOnrecqa0Gwf5PJnbv0MUHTEfKC
         lHfMdmxJ0lT+yQpHNPV0QZV3Q5Wn7TbEuvbFYFAZVp0ZGwLWKPz7/qDV0J4sQoPWeP
         zUEaaLV1cdpaFbHvQMoxWMI1kCzdsCBxlVPylDgYw9+tvfobObOIorEbIW5ok73lbP
         VtDDm6N3UxB0A==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     bhelgaas@google.com,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        kw@linux.com, kishon@ti.com
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v3] PCI: endpoint: Fix WARN() when an endpoint driver is removed
Date:   Thu, 27 Oct 2022 15:03:55 +0200
Message-Id: <166687580188.843137.5076771530958034530.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220623003817.298173-1-yoshihiro.shimoda.uh@renesas.com>
References: <20220623003817.298173-1-yoshihiro.shimoda.uh@renesas.com>
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

On Thu, 23 Jun 2022 09:38:17 +0900, Yoshihiro Shimoda wrote:
> Since there is no release callback defined for the PCI EPC device,
> the below warning is thrown by driver core when a PCI endpoint driver is
> removed:
> 
>   Device 'e65d0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
>   WARNING: CPU: 0 PID: 139 at drivers/base/core.c:2232 device_release+0x78/0x8c
> 
> [...]

Applied to pci/endpoint, thanks!

[1/1] PCI: endpoint: Fix WARN() when an endpoint driver is removed
      https://git.kernel.org/lpieralisi/pci/c/7711cbb4862a

Thanks,
Lorenzo
