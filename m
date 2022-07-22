Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5F57E3ED
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiGVPt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 11:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVPt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 11:49:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD54B357D8;
        Fri, 22 Jul 2022 08:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7990A621B0;
        Fri, 22 Jul 2022 15:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902C0C341C6;
        Fri, 22 Jul 2022 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658504964;
        bh=cuODYJh44lLbd1c34eLFLdFyS9xBzs5bHnbIrJwRIuk=;
        h=From:To:Cc:Subject:Date:From;
        b=pmDwlLFX0r1hx+oGuPpQYYXJKbstTEmC42f1joF4WUEm75GlOdU41AbIF01CcaDQX
         xoL9EZdt+VthjRSk+0huZ1dn8fUiupLboIZC7cK7Nm6eS6DyJ6LkzbIgHdUzlmJ4XV
         a0D/vUngN0enyy82R27LNJ1c62kSQu4A3Xff53T+zpctaicfxvMzDl+a+Phr485fba
         p9EpHLHtrIpZZ0m0gSobwdlCG/RjaLUvjStTtVyVi2RVQM3h1glnHG902s5lQ1faa3
         zVjp98d0qHpEiQZOj40NY53x9lIzAfha2KhKhPZQgM0w1uwg+iyBZywLok8J34Zhcx
         Q+VmLX9m7J6mA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Baruch Siach <baruch.siach@siklu.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: qcom: Minor cleanup
Date:   Fri, 22 Jul 2022 10:49:17 -0500
Message-Id: <20220722154919.1826027-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

As far as I can tell, qcom doesn't need <linux/interrupt.h>.

The qcom driver supports many variants (1_0_0, 2_1_0, 2_3_2, 2_3_3, 2_4_0,
etc), and the related code was not in an obvious order, which makes it hard
to navigate.

Bjorn Helgaas (2):
  PCI: qcom: Drop unnecessary <linux/interrupt.h> include
  PCI: qcom: Sort variants by Qcom IP rev

 drivers/pci/controller/dwc/pcie-qcom.c | 733 ++++++++++++-------------
 1 file changed, 366 insertions(+), 367 deletions(-)

-- 
2.25.1

