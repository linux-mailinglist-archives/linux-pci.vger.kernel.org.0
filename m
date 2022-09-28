Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1A5EE0F4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiI1PzO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 11:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbiI1PzJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 11:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B777EFCC;
        Wed, 28 Sep 2022 08:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C69F261F0E;
        Wed, 28 Sep 2022 15:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2949CC433D6;
        Wed, 28 Sep 2022 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380506;
        bh=hz7buZETgB+MH/jgJl89cmN6D+RYIk5iKsv8v2DxjEc=;
        h=From:To:Cc:Subject:Date:From;
        b=EwhA4L9jFQesimIVWXLTqy0g4TeNp8b4tObhZpmuzsR9Y1Feznh02o+SJ2QWBGYG2
         JwVkPArhxptBMdMKGowZGot5Hob0OnxS28gI9oiACiDqn7zrgMMRQ3DjFJBujyMT5Z
         /fMBlttkyOnlehva6+zAiCMbIYX3qGpqODuFxfvK/fJuEXln1/yI6mPuq1jYTSJV0L
         uz/G0ekfa87zSjEMmldgdTZU+gfZ4IjB2rNujSc8+fGrKaM0BR5W13jHUNGRbGXuyS
         8KzIi6pxi1O5L4YNQb0Tfkhux0uy3cgh1GdiC+BCDN6UBAbPFvjYgXZoi4yp3dG9AA
         EQoqrD07v+g8w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odZOx-0005e6-W3; Wed, 28 Sep 2022 17:55:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 0/2] PCI: qcom: Drop unused post_deinit callback
Date:   Wed, 28 Sep 2022 17:54:19 +0200
Message-Id: <20220928155421.21660-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series drops the badly named post_deinit callback which is unused
after merging the PIPE clock series. Included is also a related
error-label cleanup.

Since the modular driver patch is held off for a while still, I've
rebased these cleanups so that they might make it into 6.1.

Johan


Changes in v3
 - drop dependency on patch making the driver modular

Changes in v2
 - keep the post_init() callback which is being repurposed for DBI
   accesses


Johan Hovold (2):
  PCI: qcom: Drop unused post_deinit callback
  PCI: qcom: Rename host-init error label

 drivers/pci/controller/dwc/pcie-qcom.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.35.1

