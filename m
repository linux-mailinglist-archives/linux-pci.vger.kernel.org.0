Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9034F9350
	for <lists+linux-pci@lfdr.de>; Fri,  8 Apr 2022 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiDHKv6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Apr 2022 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiDHKv5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2022 06:51:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 576FD388C6D;
        Fri,  8 Apr 2022 03:49:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 070A711FB;
        Fri,  8 Apr 2022 03:49:54 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.11.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4136B3F73B;
        Fri,  8 Apr 2022 03:49:52 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, svarbanov@mm-sol.com, bhupesh.linux@gmail.com
Subject: Re: [PATCH v4 0/2] pci: Add PCIe support for SM8150 SoC
Date:   Fri,  8 Apr 2022 11:49:47 +0100
Message-Id: <164941495121.16608.8712808541023589489.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220326060810.1797516-1-bhupesh.sharma@linaro.org>
References: <20220326060810.1797516-1-bhupesh.sharma@linaro.org>
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

On Sat, 26 Mar 2022 11:38:08 +0530, Bhupesh Sharma wrote:
> Changes since v3:
> -----------------
> - v3 can be found here: https://lore.kernel.org/linux-arm-msm/20220302203045.184500-1-bhupesh.sharma@linaro.org/
> - Broke down the patchset into 3 separate patchsets for each tree,
>   so that the patch(es) can be easily reviewed and merged by respective
>   maintainers.
> - This patchset adds the driver / binding related PCIe support for
>   SM8150 SoC.
> 
> [...]

Applied to pci/qcom, thanks!

[1/2] dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
      https://git.kernel.org/lpieralisi/pci/c/f52d2a0f0d
[2/2] PCI: qcom: Add SM8150 SoC support
      https://git.kernel.org/lpieralisi/pci/c/3007ba831c

Thanks,
Lorenzo
