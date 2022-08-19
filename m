Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293085997CD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 10:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347269AbiHSIlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbiHSIlC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 04:41:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF453015;
        Fri, 19 Aug 2022 01:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BFCFB8265F;
        Fri, 19 Aug 2022 08:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2807CC433D6;
        Fri, 19 Aug 2022 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660898458;
        bh=ZO9Yt5h1s9hT57VwDqwNry2UW8mH5yxqDyvTp4FAdAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mV9R/RDiU0pcWufabeFiXc56gxrmdleuuYH7yMW+MZX/F0oGnnMeS5X2nbg/Es4BE
         E9PfoxQRPODvJnyicgHjUWWdGxoZT3gMx3YKIc6u5iUg+yceIeHTZX5+1KbisEQSfe
         7FDO8tHxDhuKzLpSR2s/+V3NaLqvqrJ4duWq31OBgDLth08g9QrdNl3JoCA6hjuejo
         2lROo6CGMx4RRagliYCONjwxqUlsrWn6LFYR9HWkeg9ZJlB1Yzfwdk/1iTLkcnlvXh
         V69EjeTTaagSquajZzPkJlyUh+thKJl0yY0gVUP+e/Sk8mGkdp4rDH8vMhVVgVbONC
         u5Ay/osfyWN0Q==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2 0/8] PCI: qcom: Add support for SC8280XP and SA8540P
Date:   Fri, 19 Aug 2022 10:40:49 +0200
Message-Id: <166089832025.262926.4406465315336249603.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220714071348.6792-1-johan+linaro@kernel.org>
References: <20220714071348.6792-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 09:13:40 +0200, Johan Hovold wrote:
> This series adds support for the PCIe controllers found on SC8280XP and
> SA8540P.
> 
> Included are also three patches that clean up the way the driver handles
> different IP revisions (e.g. by modelling optional clocks as being truly
> optional).
> 
> [...]

I tweaked commits as-per thread discussion (please check them, I had
to fix minor rebase conflicts) and applied to pci/qcom, thanks!

[1/8] dt-bindings: PCI: qcom: Enumerate platforms with single msi interrupt
      https://git.kernel.org/lpieralisi/pci/c/a871c90977a4
[2/8] dt-bindings: PCI: qcom: Add SC8280XP to binding
      https://git.kernel.org/lpieralisi/pci/c/0122ab0115a9
[3/8] dt-bindings: PCI: qcom: Add SA8540P to binding
      https://git.kernel.org/lpieralisi/pci/c/fe9681a74d04
[4/8] PCI: qcom: Add support for SC8280XP
      https://git.kernel.org/lpieralisi/pci/c/e37d881f9f3a
[5/8] PCI: qcom: Add support for SA8540P
      https://git.kernel.org/lpieralisi/pci/c/b325dc5f9d39
[6/8] PCI: qcom: Make all optional clocks optional
      https://git.kernel.org/lpieralisi/pci/c/4c4ef240b58a
[7/8] PCI: qcom: Clean up IP configurations
      https://git.kernel.org/lpieralisi/pci/c/4daa5e24813e
[8/8] PCI: qcom: Sort device-id table
      https://git.kernel.org/lpieralisi/pci/c/46bafd187104

Thanks,
Lorenzo
