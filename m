Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471794FF54D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 12:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiDMK7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 06:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiDMK7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 06:59:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86D1C5A163;
        Wed, 13 Apr 2022 03:57:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 527B51595;
        Wed, 13 Apr 2022 03:57:04 -0700 (PDT)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11093F73B;
        Wed, 13 Apr 2022 03:57:02 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: qcom: Fix pipe clock imbalance
Date:   Wed, 13 Apr 2022 11:57:01 +0100
Message-Id: <164984714583.9020.940270907096326400.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220401133351.10113-1-johan+linaro@kernel.org>
References: <20220401133351.10113-1-johan+linaro@kernel.org>
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

On Fri, 1 Apr 2022 15:33:51 +0200, Johan Hovold wrote:
> Commit ed8cc3b1fc84 ("PCI: qcom: Add support for SDM845 PCIe
> controller") introduced a clock imbalance by enabling the pipe clock
> both in init() and in post_init() but only disabling in post_deinit().
> 
> Note that the pipe clock was also never disabled in the init() error
> paths and that enabling the clock before powering up the PHY looks
> questionable.
> 
> [...]

Applied to pci/qcom, thanks!

[1/1] PCI: qcom: Fix pipe clock imbalance
      https://git.kernel.org/lpieralisi/pci/c/dcd9011f59

Thanks,
Lorenzo
