Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255334EEE50
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 15:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbiDANl3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiDANl2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 09:41:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8427F377FE;
        Fri,  1 Apr 2022 06:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B07B61B71;
        Fri,  1 Apr 2022 13:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF93C340F2;
        Fri,  1 Apr 2022 13:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648820377;
        bh=JDcYVcySpRVUl/AV2fOCAyPCgwgjqicV/Gx5uhTLnNo=;
        h=From:To:Cc:Subject:Date:From;
        b=LLwuMm5SIlIZ2OZWW7uitQ2S/ZqWPKshNbh+r80cldUEaKo+Nizu7PQzSVmfq60+Q
         UAwEdV6YBgf9HTdtXVi5rcjac3kHxcnY+Q/vJYzeDSrBAPq1BtvbmBOh23oyk+c/ZF
         wGi6HubXc9leSaM7s7hMo+gomdl4OQ4TIo4Uq9dasqsTMQU1+uWutMRfzM4x0+9rZE
         pXP2QEAhuJ+nINjLYnN2XnP5IEc17bHUlIBoid8lHuwxT7oxtRXej28/e8qECkSSVU
         IwrAqEjZvwn1AMunck+0Xa0IZKiDD0u8Fge/7XBsLefYv5OQJOE5t52v6JzK2KyAPH
         tCzaiLYYkKTzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1naHV3-0002kB-Kc; Fri, 01 Apr 2022 15:39:37 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/2] PCI: qcom: Fix probe error paths
Date:   Fri,  1 Apr 2022 15:38:52 +0200
Message-Id: <20220401133854.10421-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

This series fixes a few problems in the probe error handling which could
cause trouble, for example, on probe deferral.

Johan


Changes in v2
 - Capitalise subject lines according to PCI subsystem conventions


Johan Hovold (2):
  PCI: qcom: Fix runtime PM imbalance on probe errors
  PCI: qcom: Fix unbalanced PHY init on probe errors

 drivers/pci/controller/dwc/pcie-qcom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.35.1

