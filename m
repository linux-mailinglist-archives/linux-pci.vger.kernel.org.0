Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BEC624536
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 16:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiKJPKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 10:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiKJPKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 10:10:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6143F2717C;
        Thu, 10 Nov 2022 07:10:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06444B821FB;
        Thu, 10 Nov 2022 15:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3D2C433D6;
        Thu, 10 Nov 2022 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668093004;
        bh=AujrZuiZFbSEohYd8bfXHsNpILj3znFX233QjbyReEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXXMSViqmZAEi4zuSiUdSq7wVA9hX0k5e5JI5jzTr/Te0YSPg0IpE0KYGMCaz+15Y
         n178IZ4e6iauMJKAWG7d7fs2yrwaalFa96WIT/HTL24gZpY2KDRxXOAaacOi/un43q
         f8ZPoXLnVoComDLlJv1n9+GOMNZpFNXcJi7KQosSds/4Cir51tKUciYkbnj3bDZCq0
         dFTSXL1QiQFR7w5cnVFJKgo/OueZ14pRXm+Ed0V/RfTUsbzMZ8M7wuPnzv0sKxerpx
         Di5m2py2A6rIJsUTYffbiNdH+BpIGz2Dq1w6Uq8y5fnnTpghkYppS5mHrZ26EFCjSc
         TxGePKL2BstjA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, andersson@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix error message for reset_control_assert()
Date:   Thu, 10 Nov 2022 16:09:55 +0100
Message-Id: <166809298014.141188.2697758587497219.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109094039.25753-1-manivannan.sadhasivam@linaro.org>
References: <20221109094039.25753-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 9 Nov 2022 15:10:39 +0530, Manivannan Sadhasivam wrote:
> Fix the error message to mention "assert" instead of "deassert".
> 
> 

Applied to pci/dwc, thanks!

[1/1] PCI: qcom: Fix error message for reset_control_assert()
      https://git.kernel.org/lpieralisi/pci/c/fba31beab357

Thanks,
Lorenzo
