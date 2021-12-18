Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B954479B1F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Dec 2021 15:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhLROCb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Dec 2021 09:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhLROCb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Dec 2021 09:02:31 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DFC06173E
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:02:31 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u22so7862984lju.7
        for <linux-pci@vger.kernel.org>; Sat, 18 Dec 2021 06:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GW5fi1Un90+NDMfTxM4mvt7gDBM3gpuhmg2AojrHRg=;
        b=iTom4gfqZ9cYHcwwNsSR7pv4yiDBhc/mBshDP3uKy3z/uhvZ4zi/UFa2iLRGXqHjWS
         fz98wGDY9cYKKwjUVCqCo+xy9edpHEld95aWEafTU9o84HAoxXMc/rvTjgVojmdg6uJc
         vYW5AvsJ3QFSUZB2ipUvwLFoMR7hzUPkTi0R5zrJpYWUKp6iHmYnx4g56DSsDYp7Helv
         j8VwvtrU7smJdFs922unzD5FRn77s4p8hqQN1WXDUSlswP1eyb95ar0OfJlrYXLTwz3S
         pG26VGGvHFauDCm65tgxmjNthdaUw31AAigSmReX+yf2YVHBFd4xCxOdxdJkQg4B+DvN
         kEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/GW5fi1Un90+NDMfTxM4mvt7gDBM3gpuhmg2AojrHRg=;
        b=Z43mDFkgq6rX19E9xpK8E0KJLzxzskFWRH/VEPPcROp68FsIZNmqyRGZUkpieMsKJd
         3BrN9KM+QXpeagAgXp+tG7yDz1PBqx4QUGfPsIMwGJfUsD0oTJ1RpDOqO9T1Qpxr3jkA
         aDha9nD7uBiTUXugQkR3aDJKzjkG7NJ9W3xciVBhdgOdMFfBTJHGuLkEf3CrM+SAA5V5
         1erRGzj+PQqVtiSSJrvSIXRGc/HzhzdANuxGJhSpfgo78KCDxYeHvd+EYmwFdUZGb/4u
         0d+1IVFJuLtSvazdoLGa1XWk3FxZ0r7NkR54KP7PEvs/KTCIcU502k5KhC0DjsjlqIJ/
         3FEQ==
X-Gm-Message-State: AOAM5335/bwxrdJGMO+yPgLLDuSaDzPHfGfUXMH+oUlEDRTRWoNNB+2u
        2HJfQsSyDMzGRhWiuH+Ndgp+Eg==
X-Google-Smtp-Source: ABdhPJyo3yyaxf3mwnET04Pww/DR8zL8VyNdnQnp1PNawRA+5fhPR6+1yai7/WHppXlPiZ1Wz/IisQ==
X-Received: by 2002:a05:651c:19a2:: with SMTP id bx34mr6806511ljb.379.1639836149224;
        Sat, 18 Dec 2021 06:02:29 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id s15sm2023979ljj.14.2021.12.18.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:02:28 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 0/3] PCI: qcom: pipe_clk_src fixes for pcie-qcom driver
Date:   Sat, 18 Dec 2021 17:02:20 +0300
Message-Id: <20211218140223.500390-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After comparing upstream and downstream Qualcomm PCIe drivers, change
the way the driver works with the pipe_clk_src multiplexing.

The clock should be switched to using ref_clk (TCXO) as a parent before
turning the PCIE_x_GDSC power domain off and can be switched to using
PHY's pipe_clk after this power domain is turned on.

Downstream driver uses regulators for the GDSC, so current approach also
(incorrectly) uses them. However upstream driver uses power-domain and
so GDSC is maintained using pm_runtime_foo() calls. Change order of
operations to implement these requirements.

----------------------------------------------------------------
Dmitry Baryshkov (3):
      PCI: qcom: Balance pm_runtime_foo() calls
      PCI: qcom: Fix pipe_clk_src reparenting
      PCI: qcom: Remove unnecessary pipe_clk handling

 drivers/pci/controller/dwc/pcie-qcom.c | 122 +++++++--------------------------
 1 file changed, 25 insertions(+), 97 deletions(-)

