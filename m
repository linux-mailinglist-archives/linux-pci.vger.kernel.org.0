Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F14F9282
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 12:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiDHKGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiDHKGQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 06:06:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A86A7C6F3E;
        Fri,  8 Apr 2022 03:03:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B46ED11FB;
        Fri,  8 Apr 2022 03:03:42 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AA383F73B;
        Fri,  8 Apr 2022 03:03:40 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bhelgaas@google.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, svarbanov@mm-sol.com
Subject: Re: [PATCH] PCI: qcom: Add support for handling MSIs from 8 endpoints
Date:   Fri,  8 Apr 2022 11:03:39 +0100
Message-Id: <164941220567.21822.2763856506631523192.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
References: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
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

On Tue, 14 Dec 2021 15:43:19 +0530, Manivannan Sadhasivam wrote:
> The DWC controller used in the Qcom Platforms are capable of addressing the
> MSIs generated from 8 different endpoints each with 32 vectors (256 in
> total). Currently the driver is using the default value of addressing the
> MSIs from 1 endpoint only. Extend it by passing the MAX_MSI_IRQS to the
> num_vectors field of pcie_port structure.
> 
> 
> [...]

Applied to pci/qcom, thanks!

[1/1] PCI: qcom: Add support for handling MSIs from 8 endpoints
      https://git.kernel.org/lpieralisi/pci/c/20f1bfb8dd

Thanks,
Lorenzo
