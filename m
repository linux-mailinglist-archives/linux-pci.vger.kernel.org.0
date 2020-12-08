Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A92D1F3C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 01:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgLHArB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 19:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgLHArB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 19:47:01 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C0EC061793
        for <linux-pci@vger.kernel.org>; Mon,  7 Dec 2020 16:46:20 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id j10so17124972lja.5
        for <linux-pci@vger.kernel.org>; Mon, 07 Dec 2020 16:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/chCCx/QCRIeSZVNkK9P4bsa27cCZYikDD5dkEr/kg=;
        b=DxfZ/ehhgJU22NgnI701GHxNB5YFKGSdffgP6x03q5tZY2twztLo3+Wj9oheVSVgOY
         fK9gkgAXC69meL6BwDzLxugPge8XQiNPSEi9o+LVeoyTQlRkLc0Ay1R3xEQYluLEU6Xd
         +UDChTgzhTTSREQW0T0sy+qvX+FQyGniBhAM4XAaIzahDDpQzbaulUeKn6ZOwTPngKJY
         vElxMhoY5KovMiCvgMem7+WkYm38imgCj5+H5imCy9EwA6KVOff/MzEi9g+80UQvtAIo
         BBjLViqmURpRJSifUD2yfVK3Kir9yuSrotdoR9QdIzYBN0VAduuL9ldSYIcpUmFwDiTD
         e/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/chCCx/QCRIeSZVNkK9P4bsa27cCZYikDD5dkEr/kg=;
        b=LdZN1TfY2eJzAENrB0jevzLTru6486riTb8skMRFFrZ1/j8pEACbetHB+zEfhT27Nr
         qyupflM/ABFturDR8SE1n6JrB4z/QZqLRsLWvasovBeQzJIzRyjExt6ABv9SjhFG2S77
         /hc9I+atBKagrAGluC/0UTCQm80N3f9FmaJGuUjYLvHfb2xJckp/ZZe7LBuMjbSwZ2Pz
         /d3rbXL5lf1YalNRkhm2UAbkwhIAHjtamyUfX7EJBdLxHGS1kt7ULgYkjAGNt4XAB6h8
         f5wBdA1Nbv/Oul7b9EyFjRJIhNE8FOUIPWQqF6KxjyEQEZ4pb7r4OQCrmVf2BejLVgCZ
         nfGQ==
X-Gm-Message-State: AOAM5329bFYX3fTIeToTnohVPjbi9as6vwzehS46rBQbj3qjYtSVMXcT
        os9cj+A997v3vAN6cgKEKErJtg==
X-Google-Smtp-Source: ABdhPJwr1b67FN+fK2qCEjQko+dR5Zu8b3oT6v4qt+L/qDzdBIKMpGsq4/jzLkAD1Tl435Oj3JiKGg==
X-Received: by 2002:a2e:9898:: with SMTP id b24mr4887796ljj.248.1607388379225;
        Mon, 07 Dec 2020 16:46:19 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.229.141])
        by smtp.gmail.com with ESMTPSA id d3sm3028229lfj.206.2020.12.07.16.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 16:46:18 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/3] Fixup PCIe support on sm8250
Date:   Tue,  8 Dec 2020 03:46:10 +0300
Message-Id: <20201208004613.1472278-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch serie goes on top of
https://lore.kernel.org/linux-arm-msm/20201027170033.8475-1-manivannan.sadhasivam@linaro.org/

It fixes SMMU issues observed on the RB5 platform when accessing onboard WiFi module.
Unfortunately there are no 'Fixes' tags, since original patch series was
(partially) accepted but did not hit linux-next (yet).


