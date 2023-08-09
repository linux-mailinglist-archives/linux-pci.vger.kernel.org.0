Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655237754EC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjHIITH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjHIITH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 04:19:07 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A5810FE
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 01:19:06 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1bba254a7d4so5159029fac.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Aug 2023 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691569145; x=1692173945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dO0fGXVkB6dDvOJvamtXS5ttOLi34wClCgZVQXXSJ8=;
        b=fhmLGYJO7+qqXrUKU3dLw1C9KNcWX6EA1ZpYrt5wE7dPOIBYnglTiQWrNkQ4Oz94Ot
         euX8EGdzFWJm6WHuiu6XZljYwJtJ2An9tufSo/uEaJkaMAHnYSBg/TxyfpDm3BEiZOjd
         ObVHVuLKLJaSPka3Nlvs8BD0ep8WVv8OLiF9y9PVfA9Bp6pkhGSfodX9KbwGbs+qut7w
         /CTDwdGzTcUI4Z83FQXJcs3GthwIRRkG26BZVHXPmWA8m4K0rKdvEEqJcwx+VKrURLKZ
         shHdAnHS6q/aPkAz80+zLEYUoxgahnaL03HxmOTk3CDNLnD/08kRwxZWeGqMs2GAnHa5
         aV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691569145; x=1692173945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dO0fGXVkB6dDvOJvamtXS5ttOLi34wClCgZVQXXSJ8=;
        b=Fdw5UXu115ifSwpEyWwZD2oyC823tXHooUEs7/HLJM3QQJZBOFYwd9L8SrbKFYlTkq
         faHk/Yu+fEhHAQ4iUP9cX2KMSqr1zPb0714UW5bfefdjFMhpSrmPS10Byg1rSP9zWYVz
         jClWyZYYwXwecUBtj4zZmPGCknqky7kXV4Lj+N3b8BvELi72oSe410HNtyWoTvFvBGN9
         KNvjy/1kDDoRNKBf9G6QPFQZ4qcctwXEYEPQJ6+CJYLmGwuwCFa4e+8HRo02oIOwmu3b
         rVkhwCXtVNWY+ETjrsc6uOQ0xBKSBI8rnmg825ThgCP/feUxjTEnBYHWC7RI+Q4IiFVp
         zCdg==
X-Gm-Message-State: AOJu0YxgZ+Nv5+24V11FbQLbABXvTd91HmZIpbfWz7bd4JznQOjkB32v
        Z9hm21k4h7w0VZb8RkvFkFZn
X-Google-Smtp-Source: AGHT+IHLhiTa1iK8j77LftG5ziiKVv7wb75Pz56OZcxKlLru9eds2r4O/GVW8Znek2Ua6SUJaRVTDQ==
X-Received: by 2002:a05:6870:610a:b0:1be:dbd2:2bfe with SMTP id s10-20020a056870610a00b001bedbd22bfemr1810603oae.57.1691569145636;
        Wed, 09 Aug 2023 01:19:05 -0700 (PDT)
Received: from localhost.localdomain ([117.207.25.122])
        by smtp.gmail.com with ESMTPSA id v13-20020a62a50d000000b00686ee7ba3easm9331881pfm.216.2023.08.09.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:19:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     robh@kernel.org, gustavo.pimentel@synopsys.com,
        jingoohan1@gmail.com, andersson@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] PCI: qcom: Enable ASPM on host bridge and devices
Date:   Wed,  9 Aug 2023 13:48:38 +0530
Message-Id: <20230809081840.16034-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

This series enables ASPM by default on the host bridge and devices of selected
Qcom platforms.

The motivation behind enabling ASPM in the controller driver is provided in the
commit message of patch 2/2.

This series has been tested on SC8280-CRD and Lenovo Thinkpad X13s laptop
and it helped save ~0.6W of power during runtime.

- Mani

Manivannan Sadhasivam (2):
  PCI: dwc: Add host_post_init() callback
  PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops

 .../pci/controller/dwc/pcie-designware-host.c |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c        | 28 +++++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.25.1

