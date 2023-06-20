Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4745C7368ED
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 12:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjFTKOA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 06:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFTKN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 06:13:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60941A2;
        Tue, 20 Jun 2023 03:13:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7F8611AE;
        Tue, 20 Jun 2023 10:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A044C433C8;
        Tue, 20 Jun 2023 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687256037;
        bh=L0yfnyhjpRQ5SEJS36jb8fm0ymm+Olhfyv7cV9XbFhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulOzXDduo7oT4hI6IJ3Y95X/9fWIGU5Wq/hGJGvIa6+wh7iIw8yz08eUMz3dOwd40
         jQmtOOt1hSdTO1dLYgKG1sOlu+AOvNUf+Ef/gDgCboGDbKYyxNGA1I6T0nh62gRgvI
         /l2IZuqIOAtZb05ad2uWcRPcHkbPoYFou0dynZ98oajBv/VaFE0vP1i/Yaevi4qbAS
         JK6QL1SLNPiAkYfzLxnG9URuj5Dqy+3eK7C6/bfzr7e4zKjpLfe3+O77rOYGzrStFX
         PjxEAZDU4fLnbhkicld2Nla+pyhUXY0m8TNRoMKFYyk0dOBlaExPd2vuU4gwXbDOpg
         2TO2haWI7FB+g==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     kw@linux.com, bhelgaas@google.com,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH v4 0/9] PCI: qcom: Do not advertise hotplug capability
Date:   Tue, 20 Jun 2023 12:13:50 +0200
Message-Id: <168725600736.54372.7257062051885655719.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
References: <20230619150408.8468-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 19 Jun 2023 20:33:59 +0530, Manivannan Sadhasivam wrote:
> The SoCs making use of Qualcomm PCIe controllers do not support the PCIe hotplug
> functionality. But the hotplug capability bit is set by default in the hardware.
> This causes the kernel PCI core to register hotplug service for the controller
> and send hotplug commands to it. But those commands will timeout generating
> messages as below during boot and suspend/resume.
> 
> [    5.782159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2020 msec ago)
> [    5.810161] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x03c0 (issued 2048 msec ago)
> [    7.838162] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2020 msec ago)
> [    7.870159] pcieport 0001:00:00.0: pciehp: Timeout on hotplug command 0x07c0 (issued 2052 msec ago)
> 
> [...]

Applied to controller/qcom, thanks!

[1/9] PCI: qcom: Disable write access to read only registers for IP v2.3.3
      https://git.kernel.org/pci/pci/c/a33d700e8eea
[2/9] PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
      https://git.kernel.org/pci/pci/c/60f0072d7fb7
[3/9] PCI: qcom: Disable write access to read only registers for IP v2.9.0
      https://git.kernel.org/pci/pci/c/200b8f85f202
[4/9] PCI: qcom: Do not advertise hotplug capability for IPs v2.7.0 and v1.9.0
      https://git.kernel.org/pci/pci/c/a54db86ddc15
[5/9] PCI: qcom: Do not advertise hotplug capability for IPs v2.3.3 and v2.9.0
      https://git.kernel.org/pci/pci/c/11bce06b21a0
[6/9] PCI: qcom: Do not advertise hotplug capability for IP v2.3.2
      https://git.kernel.org/pci/pci/c/25966e78d303
[7/9] PCI: qcom: Use post init sequence of IP v2.3.2 for v2.4.0
      https://git.kernel.org/pci/pci/c/e35d13a5ff37
[8/9] PCI: qcom: Do not advertise hotplug capability for IP v1.0.0
      https://git.kernel.org/pci/pci/c/fa2dc2528684
[9/9] PCI: qcom: Do not advertise hotplug capability for IP v2.1.0
      https://git.kernel.org/pci/pci/c/1fdecc5bc8e8

Thanks,
Lorenzo
