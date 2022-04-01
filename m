Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FEC4EECED
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 14:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbiDAMNw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiDAMNv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 08:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B0276FBE;
        Fri,  1 Apr 2022 05:12:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 095626198B;
        Fri,  1 Apr 2022 12:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA68C340EC;
        Fri,  1 Apr 2022 12:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648815120;
        bh=ugyRpjVvFtsb9Lptd72Y8GktT3VA1vlwt10U2VBPLeg=;
        h=From:To:Cc:Subject:Date:From;
        b=UoNDq8UDAFBarP/1cBT5nCVFPca8BJ6rhCWMg2nqiNKM/EQEj6IfmTfPuFWbWPfdo
         8/N9Tqo1LdXviA1i5r0NclIQg9jXnojw4th0pTuBEJWO+MJHh1WshrokpOkaS6P/QU
         /5kpX+NonS6QergWbaRV4DuLHfAA1McVRD4AFJCW+/kh1rQv2bH4L4aZTinqaHh6Os
         OX8GLm+zrAHUW4ldVh++tRdJRyCc6VDbmeXrm2mgUToQEgcU5a9RjcJq5n8OL4ZlYC
         uK8cpEcubgP64W5tu/Wc0T4MUC+v82iOTGg+5E2ctDBwrhPhMmREt8ud2MF83zEbiV
         YZfPCxZU4QauA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1naG8F-0001dK-Gv; Fri, 01 Apr 2022 14:12:00 +0200
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
Subject: [PATCH 0/2] PCI: qcom: fix probe error paths
Date:   Fri,  1 Apr 2022 14:10:52 +0200
Message-Id: <20220401121054.6205-1-johan+linaro@kernel.org>
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


Johan Hovold (2):
  PCI: qcom: fix runtime PM imbalance on probe errors
  PCI: qcom: fix unbalanced phy init on probe errors

 drivers/pci/controller/dwc/pcie-qcom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.35.1

