Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B301522FD9
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 11:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiEKJuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 05:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiEKJuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 05:50:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38ED33E5C5;
        Wed, 11 May 2022 02:50:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D38A1FB;
        Wed, 11 May 2022 02:50:09 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB5B03F73D;
        Wed, 11 May 2022 02:50:06 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     robh@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, bhelgaas@google.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: qcom-ep: Move enable/disable resources code to common functions
Date:   Wed, 11 May 2022 10:49:59 +0100
Message-Id: <165226257528.11266.14229685455968440299.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220502104938.97033-1-manivannan.sadhasivam@linaro.org>
References: <20220502104938.97033-1-manivannan.sadhasivam@linaro.org>
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

On Mon, 2 May 2022 16:19:38 +0530, Manivannan Sadhasivam wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Remove code duplication by moving the code related to enabling/disabling
> the resources (PHY, CLK, Reset) to common functions so that they can be
> called from multiple places.
> 
> 
> [...]

Applied to pci/dwc, thanks!

[1/1] PCI: qcom-ep: Move enable/disable resources code to common functions
      https://git.kernel.org/lpieralisi/pci/c/bc49681c96

Thanks,
Lorenzo
