Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C1716AA7
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjE3RTJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjE3RTI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 13:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6391BD9;
        Tue, 30 May 2023 10:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE7B7630C8;
        Tue, 30 May 2023 17:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA22EC433D2;
        Tue, 30 May 2023 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467146;
        bh=PIBi+WICffiBvaB2Kw9KN3H9bNAFCDH01ZgbVaQGbpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2Xa4JrAvvdRGyRf3zxeWBvkc5cuOtjqlw0qF7dZxyI06ngCrCEr+2VfwVIRMVVdd
         V5zTylUXQRCf1KW4HPXzMIdv+9vrMt1yP+n7FUDa+t2FjNJ4LF5+BlKFZwjSqNBqRe
         ZHB1IFdqYD9OcZl9/+Ecs/JcoSOvUOC9V09t4ZzWib5Tw6UHYj9RtfWvo7heP6Av47
         dD3CVQoa6UM26DNqLEt2ojddXXiZcVQpH+lX3kslYjvfSLtg1sWzEWznuptvI921Y/
         KH17pTxqsO/dGyBabW1mpfH4P2fEriexl3TKpaNOhSUcu+Vgyc5AIWsf3E+ZScPJZ6
         l+0N0Pn0M1pBQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-scsi@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: (subset) [PATCH v3 00/15] Introduce the SC8180x devices
Date:   Tue, 30 May 2023 10:22:49 -0700
Message-Id: <168546732606.2227271.7267063763992454803.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530162454.51708-1-vkoul@kernel.org>
References: <20230530162454.51708-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 May 2023 21:54:39 +0530, Vinod Koul wrote:
> This introduces Qualcomm SC8180x SoC which features in Lenovo Flex 5G
> laptop. This also adds support for Primus platform as well as Lenovo Flex 5G
> laptop.
> 
> Changes in v3:
>  - Split DTS patch into smaller check
>  - checkpatch and dtbs check error fixes
>  - fix comments from Konrad/Krzysztof
> 
> [...]

Quite a few DT validation warnings left, but let's get it merged so that we can
work on those together.

Applied, thanks!

[06/15] arm64: dts: qcom: Introduce the SC8180x platform
        commit: 8575f197b077001591ef3ff709cdee48785daf0d
[07/15] arm64: dts: qcom: sc8180x: Add interconnects and lmh
        commit: f3be8a111d7eaf4e291b6c2d51dd0adb39934b32
[08/15] arm64: dts: qcom: sc8180x: Add thermal zones
        commit: d1d3ca03554e51be44546638f83169bb05b20ef8
[09/15] arm64: dts: qcom: sc8180x: Add QUPs
        commit: 0018761d1564f64d567e119fd9156c473b4592d7
[10/15] arm64: dts: qcom: sc8180x: Add PCIe instances
        commit: d20b6c84f56ae3a9823cc0fa5cfad330536ba0d1
[11/15] arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes
        commit: b080f53a8f44eeaa9db9628d8d339ab5a2afb5bd
[12/15] arm64: dts: qcom: sc8180x: Add display and gpu nodes
        commit: 494dec9b6f541451b2e82905b0eebd9a4ac9848b
[13/15] arm64: dts: qcom: sc8180x: Add pmics
        commit: d3302290f59e8533a56a8fa2455357f843d8dcf6
[14/15] arm64: dts: qcom: sc8180x: Introduce Primus
        commit: 2ce38cc1e8fea4e251e4563e436104369bf3b322
[15/15] arm64: dts: qcom: sc8180x: Introduce Lenovo Flex 5G
        commit: 20dea72a393c6d5572088b8ad01dbb9e9aca64ce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
