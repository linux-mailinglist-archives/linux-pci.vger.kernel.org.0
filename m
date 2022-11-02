Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA08A615F0C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 10:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKBJJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 05:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiKBJI7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 05:08:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B627FD7;
        Wed,  2 Nov 2022 02:08:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B682B8216B;
        Wed,  2 Nov 2022 09:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8E4C4347C;
        Wed,  2 Nov 2022 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667380135;
        bh=yCSCxjzajthdmPJ8tWpzFvpFs/HfIn7P3OIoIHFX8Yc=;
        h=From:To:Cc:Subject:Date:From;
        b=cdiIyNAnbpgYuvziORkO0gsy0wiP2sZxWEIKQ6YIUMtFojihOiCAWGlxFgCZBudl7
         vyeCnhujvK1a67Fl9R/KX5vGa/TDYgDY4O355gfidC7ueak9GWdCGOpEtUD56KVvCp
         mjcUyMHhXvdSybUXQlMB42Cy0AltdoXzvevclHDwrHDPDhjIKkWil5GUZ3RFNPWTR+
         VMB8MXxw+okc90mSi83nhHA7grTU6l+P51lO1dAoESX4LW/BrzNUJbzGxeRJRvSzqB
         h1yVY24ArbFGRipMSg/zPO/i0UPZ1JCl49LaJEMWkaIvSS6sDZweI/llJCTOOxpTbO
         AvQFI3J28VfNA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oq9ji-0006B3-S2; Wed, 02 Nov 2022 10:08:39 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        stanimir.k.varbanov@gmail.com
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Brian Masney <bmasney@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 0/2] PCI: qcom: Add basic interconnect support
Date:   Wed,  2 Nov 2022 10:07:03 +0100
Message-Id: <20221102090705.23634-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Qualcomm platforms like SC8280XP and SA8540P interconnect bandwidth
must be requested before enabling interconnect clocks.

Add basic support for managing an optional "pcie-mem" interconnect path
by setting a low constraint before enabling clocks and updating it after
the link is up.

This is specifically needed to prevent a crash on SC8280XP/SA8540P when
the interconnect constraints are enforced during boot.

As support for these platforms was added in 6.1-rc1 it would be nice to
have this merged as a fix for 6.1, but deferring for 6.2 works as well.

Johan


Changes in v3
 - remove intermediate assignment in error path (Mani)
 - add WARN_ON_ONCE() as a reminder to anyone ever extending the
   driver with support for higher speeds to update the bandwidth table

Changes in v2
 - update the bindings so that the interconnect-names constraints apply
   to all platforms (Krzysztof)


Johan Hovold (2):
  dt-bindings: PCI: qcom: Add SC8280XP/SA8540P interconnects
  PCI: qcom: Add basic interconnect support

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 20 +++++
 drivers/pci/controller/dwc/pcie-qcom.c        | 76 +++++++++++++++++++
 2 files changed, 96 insertions(+)

-- 
2.37.3

