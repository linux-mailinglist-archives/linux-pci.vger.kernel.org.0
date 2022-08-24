Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5807759F9FC
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbiHXMa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Aug 2022 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbiHXMaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Aug 2022 08:30:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C143DF21
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 05:30:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m15so8835581pjj.3
        for <linux-pci@vger.kernel.org>; Wed, 24 Aug 2022 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lTq05bQ1OKgNVfwpDwHO25M6SddSlDeTyGdeeuSYq38=;
        b=WyIluVrrWEn0m/dxKECPZMN1MjW96MEQ6xtJw5kNo8GII3mlN9wXxjQtk3PdhhaxQW
         xKyi7HsXS36xIqfZ/mmgjKAxY3MTOUvntjjxHwrTjd9kgvbAVWhyRZwGfbYtObWsUD2r
         r2SXCYIELN7Jc/YgtBLEWKp/LQjAxZJaxFSgFozwOsR5Y+YSN9gn4bs8EYXOjaPjkGcg
         PxCamYjPckL5Akc36wPkha+b7Zv3GLrgUXLtdlOPO11Kwngn+OGr95XilNwnsfUAYsZb
         juAXjm0Of3/QiuLd33Ou9EZl5tx9w+uOrS/HEidBDdDSYe2e98U8uuN5Yq+7XI05ifCc
         Htog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lTq05bQ1OKgNVfwpDwHO25M6SddSlDeTyGdeeuSYq38=;
        b=aCOfw8Vw9woYm5Fij01pNt8KbTbKDnV5LwpG5+Onv3gKudljYzymVuVEspLOBOEElM
         bX+/3VCO38iaaEnkbEz93T0o5mt7zX2kaglks4V+2Q55M+hgUIdDB5DrrOcwyQj1XeHX
         uFfRiw11bfKcYNPle06INdfo72DSjLoph6ZWh+gk8XJ38kB+pxJhrOqwo1ce5KKS4aZJ
         DLD+6RLIIR3Ck2b2QUVQGAtTKB8SLLxldfvrEFP6Z9op0F37T4bvJ133sEt0gPH9DTO6
         r4or0eJPWUfyeCjFhwHvMqrlhoGkCbBMWBY3fe49Lf45XveRbnmz8agSpplmz/xjyULZ
         bPTw==
X-Gm-Message-State: ACgBeo2CFhiVvxlWB60IIEXwvA5gNZYkJ77ZovWQ6oK7L8wBA0Q3Fr/H
        czkWMezHD790YRVWWpsnVYjv
X-Google-Smtp-Source: AA6agR77/hmpgiMkWbIPOaXWY41ErdUJYXUbD6I5NF8OpqnxJZASur5kkaI6mV2CcfVbJ/+u4ItHuA==
X-Received: by 2002:a17:902:6542:b0:172:95d8:a777 with SMTP id d2-20020a170902654200b0017295d8a777mr28453985pln.61.1661344219362;
        Wed, 24 Aug 2022 05:30:19 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b00173031308fdsm3539220plm.158.2022.08.24.05.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:30:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/5] pci_endpoint_test: Fix the return value of IOCTLs
Date:   Wed, 24 Aug 2022 18:00:05 +0530
Message-Id: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During the review of a patch for pci_endpoint_test driver [1], Greg spotted
the wrong usage of the return value of IOCTLs in the driver. This series
fixes that by returning 0 for success and negative error code for failure.
Relevant change is also made to the userspace tool and the Documentation.

Along with those, there are couple more patches fixing other small issues
I noted.

NOTE: I have just compile tested this series. So it'd be good if someone
can test it on the PCI endpoint setup.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220816100617.90720-1-mie@igel.co.jp/

Changes in v2:

* Fixed the error numbers in pci_endpoint_test
* Added Fixes tag and CCed stable list for relevant patches. The patches
  should get backported until 5.10 kernel only. Since for the LTS kernels
  before that, the pci_endpoint_test driver was not supporting all commands.

Manivannan Sadhasivam (5):
  misc: pci_endpoint_test: Fix the return value of IOCTL
  tools: PCI: Fix parsing the return value of IOCTLs
  Documentation: PCI: endpoint: Use the correct return value of
    pcitest.sh
  misc: pci_endpoint_test: Remove unnecessary WARN_ON
  tools: PCI: Fix memory leak

 Documentation/PCI/endpoint/pci-test-howto.rst | 152 ++++++++--------
 drivers/misc/pci_endpoint_test.c              | 167 ++++++++----------
 tools/pci/pcitest.c                           |  48 ++---
 3 files changed, 179 insertions(+), 188 deletions(-)

-- 
2.25.1

