Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150C22F4F2B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbhAMPuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbhAMPuV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 10:50:21 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15FC061786
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 07:49:40 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id v67so3479383lfa.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2021 07:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDTL5TzhGClCytQgAVu79B4jFSXGtM5TTt8tFLgLuvo=;
        b=KsJaPTsHB4u1lpF3B+jyYr+aaVzWmWhC+SL2SiOtpIg+/yPXKkQZKM5wvwUiG791bK
         RAVeCq8Gv0qeaTO7pw6ZNoTszl+kmLdTJza9H/HpyPC5LXjixtCOaVzM6acY81lUqS3t
         o6FdAp99JbiGBBabDEyIj7HYuXDlF94+R8zu+b/+AJDdwPlm5IUw4Yzkk2lq5ahZ/Agc
         lIQwHvyP//Aey+cGb62EMuj3U5pYz7pD/vHks5iUlDenl/jPEmHvwvTRr6s6lQVdkrAR
         ogIURMrxu5SsyYQoxqNkO4YJWHrbQM2WdDgRa9hs1Z87ewfTbZHAvu/eFKzhoW0T+jk/
         M8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zDTL5TzhGClCytQgAVu79B4jFSXGtM5TTt8tFLgLuvo=;
        b=gvxsuX7ckndhXvpnPBmBbwAX6XLVUG/trxA8T3lYxe9hmfnrp1pZASUapFj3IVWFTY
         5Pco6Q5g3OWIwzNM5YblMP1uHUYmpPMJQ8XojCzUBb1SUzK8/TcNVbFKPMgYipdc2Jss
         4Bkx1ZJ+L7MUXBMLGrqoneODKvLjsGMA+jGUJ15nTo9havuHStUgR8uIQg6DEewvrXV0
         SlunB/tX7zVL07Lig3SdWm5Jkz989tZ6EV0ttNWSrX5/9InU4wZvnRwz3aDeEDSYNkSm
         muSY1deV/aTy0q1DwaqhjkpVA7b/Zos4+45FsdyYfIH6zGvta+5ujM52EfZB1cr9Voqd
         Dy6w==
X-Gm-Message-State: AOAM530pcvX0fJHa1izzp927u16iDR/kINmqXxhWqH+Usqf/StKDhUdt
        ZD4aMx3rxX7DerxBwpxlqigWXQ==
X-Google-Smtp-Source: ABdhPJz8d1TohZuhCehF3ORyrlJkEX7V2ZRf/hZ/I/6CNbj5JC8ddotDDKWkcAzkJUxlwkwDlgPbKw==
X-Received: by 2002:a05:6512:324a:: with SMTP id c10mr1067029lfr.452.1610552978993;
        Wed, 13 Jan 2021 07:49:38 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.189])
        by smtp.gmail.com with ESMTPSA id g13sm246828lfb.43.2021.01.13.07.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:49:38 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: qcom: fix PCIe support on sm8250
Date:   Wed, 13 Jan 2021 18:49:33 +0300
Message-Id: <20210113154935.3972869-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SM8250 platform requires additional clock to be enabled for PCIe to
function. In case it is disabled, PCIe access will result in IOMMU
timeouts. Add device tree binding and driver support for this clock.

Changes since v3:
 - Merge clock handling back into qcom_pcie_get_resources_2_7_0().
   Define res->num_clks to the amount of clocks used for this particular
   platform.

Changes since v2:
 - Split this clock handling from qcom_pcie_get_resources_2_7_0()
 - Change comment to point that the clock is required rather than
   optional

Changes since v1:
 - Added Fixes: tags, as respective patches have hit the upstream Linux
   tree.



