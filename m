Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1896DE105
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDKQdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 12:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDKQdH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 12:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA8219B1;
        Tue, 11 Apr 2023 09:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A02B62889;
        Tue, 11 Apr 2023 16:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBDDC433EF;
        Tue, 11 Apr 2023 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681230785;
        bh=Yhm0jSy25hzbLlsjyMkTLyaBoDYl2CKiWSEuqnXbAxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzK3LEG7Mn+72gDPn//4cGd8T6mGh/dk4N+WOGd34xk/aOBZ11ZaM9YKM7djY23Bt
         tOFKSgrfw2V0azFPKo9+PcwYyuxDoGDcgMY5K1mab3YJsEMD0uMdxFXrkRr9RvcZ5L
         n15uxvkmjr3xBdB1atd0ti/Pp11KC1DRZji6fbj+CfiosIVawHXKy+M+X1XSZqD1gU
         NtIuIjedR+BfaK5iNBQ31+EIa0+EwCcasKhqPjPYWvpxsRDlVt2kAFW4eyx+LN2aQ/
         1JXopPf2UsbJbl/+KpfqCfn8C61Ia+kEOl9UeEIv0jM/B14xJLjMbBWnPLv1sLLii1
         bX6MTnnXOoLFQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_devipriy@quicinc.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: PCI: qcom: Document msi-map and msi-map-mask properties
Date:   Tue, 11 Apr 2023 18:32:56 +0200
Message-Id: <168123076253.29288.1724754238175551938.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411121442.22227-1-manivannan.sadhasivam@linaro.org>
References: <20230411121442.22227-1-manivannan.sadhasivam@linaro.org>
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

On Tue, 11 Apr 2023 17:44:42 +0530, Manivannan Sadhasivam wrote:
> The Qcom PCIe controller is capable of using either internal MSI controller
> or the external GIC-ITS for signaling MSIs sent by endpoint devices.
> Currently, the binding only documents the internal MSI implementation.
> 
> Let's document the GIC-ITS imeplementation by making use of msi-map and
> msi-map-mask properties. Only one of the implementation should be used
> at a time and the drivers can choose the preferred one.
> 
> [...]

Applied to controller/qcom, thanks!

[1/1] dt-bindings: PCI: qcom: Document msi-map and msi-map-mask properties
      https://git.kernel.org/pci/pci/c/9d20b46def04

Thanks,
Lorenzo
