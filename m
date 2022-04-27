Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A451147D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiD0JlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 05:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiD0Jk7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 05:40:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 957FCE7F;
        Wed, 27 Apr 2022 02:37:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C4DED1;
        Wed, 27 Apr 2022 02:10:02 -0700 (PDT)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E0003F5A1;
        Wed, 27 Apr 2022 02:10:00 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Gross <agross@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: qcom: Fix probe error paths
Date:   Wed, 27 Apr 2022 10:09:50 +0100
Message-Id: <165105057429.27309.6448107267848897699.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220401133854.10421-1-johan+linaro@kernel.org>
References: <20220401133854.10421-1-johan+linaro@kernel.org>
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

On Fri, 1 Apr 2022 15:38:52 +0200, Johan Hovold wrote:
> This series fixes a few problems in the probe error handling which could
> cause trouble, for example, on probe deferral.
> 
> Johan
> 
> 
> Changes in v2
>  - Capitalise subject lines according to PCI subsystem conventions
> 
> [...]

Applied to pci/qcom, thanks!

[1/2] PCI: qcom: Fix runtime PM imbalance on probe errors
      https://git.kernel.org/lpieralisi/pci/c/b986db29ed
[2/2] PCI: qcom: Fix unbalanced PHY init on probe errors
      https://git.kernel.org/lpieralisi/pci/c/3ae93c5a97

Thanks,
Lorenzo
