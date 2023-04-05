Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9700F6D7339
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 06:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbjDEEI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 00:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbjDEEHa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 00:07:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A954558E;
        Tue,  4 Apr 2023 21:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 760A463AF7;
        Wed,  5 Apr 2023 04:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19089C43324;
        Wed,  5 Apr 2023 04:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667602;
        bh=F35Yo8CMdTUZ+xGUntt/U4RBF4z2aepfzc1/ck9Ojxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JdCshkzEhkUcabh3ygObV5AxGeiLE0Okvfc91ka2CufTi/UjCM8Y4k6kI/R+Hd0Tq
         M8y+4ujE0Af8VrxBK6upf7RGU+hgRXQRIb2AEyLYdRAZP3uCGWjv/mXOAEcl39rNXK
         dP2RX6PzQ25bdLHZOnppJ3huYrVZeIY3R4aGIrDdIct76sBXW1FAtnFmPzE7/FTFp4
         LWUfohWz3JMhkCk2He0rDqoELE8EzADxOogt7uTIeWOBg+5sqIj7eIijLa4LA4xgz3
         MH37HL3rvP/Qx8+2sZfW80KC0Pwdo5gjrAyb3WHfTspMGO7XmWEVDvt9DeIANL5uuO
         3eDKFIBUGPTgQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Avri Altman <avri.altman@wdc.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-phy@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: Re: (subset) [PATCH v2 00/12] Introduce the SC8180x devices
Date:   Tue,  4 Apr 2023 21:09:11 -0700
Message-Id: <168066774419.443656.6508694636390869164.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

Applied, thanks!

[01/12] dt-bindings: firmware: document Qualcomm SC8180X SCM
        commit: c78ad8597ed961e822bf86ce7f1916dbfba255ef

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
