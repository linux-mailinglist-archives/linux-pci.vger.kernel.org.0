Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E866B9F0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 10:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjAPJLw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 04:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjAPJLO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 04:11:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B613D72;
        Mon, 16 Jan 2023 01:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0095960E26;
        Mon, 16 Jan 2023 09:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6764C433EF;
        Mon, 16 Jan 2023 09:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673860243;
        bh=SP3Gv9ZKZ+68IMBMm04XGefGc1oCfUgde1seLUmBLWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VicEGCYcltCUtNeOX/9QpyAxjr0ObvSifGJr9fXaznAnzixmKLLbdog2rvDaWmXm6
         wBWwJVJgtA1mGubRuj9me7foCyBnRNWlij3LqxDrK3fZwl/CICdsWtfLMnFS4ZJ5B+
         pVwzDaxGylMC/+c5+OIZIEXgT0nrLokowT4hRmTOw/2Qk7upfCebmM3n32j8QKfwSk
         jhh71r+otAjQ+t2MuqpPmBczPyjGyhEmK2uDGLGRevJUD+9gM3Fmb8pTlrCJm6TtGl
         wpERUpv2UGM++nAw2LEf8ayRv+8QjsMMt5yY/m8NnSxht16rsXez0Q8L7KCpT1u/3H
         rDSK7VKhCJ8HA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/2] PCI: qcom: Add support for modular builds
Date:   Mon, 16 Jan 2023 10:10:30 +0100
Message-Id: <167386021054.7036.13346493378677218649.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017114705.8277-1-johan+linaro@kernel.org>
References: <20221017114705.8277-1-johan+linaro@kernel.org>
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

On Mon, 17 Oct 2022 13:47:03 +0200, Johan Hovold wrote:
> Allow the Qualcomm PCIe controller driver to be built as a module, which
> is useful for multi-platform kernels as well as during development.
> 
> There's no rush with this, but I figured I'd send an updated version
> that has been rebased on 6.1-rc1 (where post_deinit() has been removed).
> 
> I also broke out the qcom_pcie_host_deinit() handler in a separate patch
> as the host_deinit() callback has now been added to dwc core and can be
> used to fixes some late-probe error handling.
> 
> [...]

Applied to pci/qcom, thanks!

[1/2] PCI: qcom: Fix host-init error handling
      https://git.kernel.org/lpieralisi/pci/c/6996d631fa33

Thanks,
Lorenzo
