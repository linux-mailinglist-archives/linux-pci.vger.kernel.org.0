Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C56D4B6D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjDCPIU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjDCPIK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 11:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDA64C35;
        Mon,  3 Apr 2023 08:08:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF7561A55;
        Mon,  3 Apr 2023 15:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A37C4339B;
        Mon,  3 Apr 2023 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680534482;
        bh=Zvq9Hzpetq9+ZiBrci0/SnW1z0Ndhco9dW2OQzO42bc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LPSID/hW1iIiGUMdrfSA+O+e5b98RytK7Y34WEdMUQGE3B5wDApQjkEE5j5LWK8IX
         iuYzO1CRQem0UBb0MQ+yHt7bysq+oQ0HzTXXWSGs9R2uWVdIVfs9zs//X59D67fOTN
         kkR8fYsJ0VhLg6hSdwaJ5VI3mSZ2hcwWaB7MRGOqNVPFZmJO17v7EvZSXcaKhGrYJf
         YOsayAmvzQSvVZqafUNir2ALY1AiobPKEfd52C9PVugNvVLiTefUzF8qh3pqLB9yVC
         OJF12k5hKshsRfEzqU1EqfYrvbkZDZbVBqMlTzMVEA72PlpFMQICPWceC5MK6a/S41
         X+dDKoQeE4sJg==
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <djakov@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
Subject: Re: (subset) [PATCH v2 00/12] Introduce the SC8180x devices
Message-Id: <168053447680.47740.2062036242012042206.b4-ty@kernel.org>
Date:   Mon, 03 Apr 2023 16:07:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 25 Mar 2023 17:54:32 +0530, Vinod Koul wrote:
> This introduces Qualcomm SC8180x SoC which features in Lenovo Flex 5G
> laptop. This also adds support for Primus platform as well as Lenovo Flex 5G
> laptop.
> 
> I would be great if submaintainers can ack the binding patch so that
> everything can go thru qcom tree
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[08/12] regulator: dt-bindings: qcom,rpmh: Add compatible for PMC8180
        commit: fc4fef625decc80cf3a72e884a4e37288bfa0f9b

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

