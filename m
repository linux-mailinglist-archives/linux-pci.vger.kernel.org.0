Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974681109F
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfEBAUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 20:20:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33936 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfEBAT7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 20:19:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so233824pfd.1
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M72UrqeRuyBcXD8fVbPV6qhuJNerzMcfy2w0Aus0l5Q=;
        b=dc8l3OQySRYWLVNn/lNNOOqt83xbVy2XhNg7RGbydOcYn7Om65TwQj0KBdKZMDrL0N
         QqLJN/xHpF1BlRPF2e/fy4TVOYZBVG11d9Ab/42A5XK13rpLDsIC3zjvo1ffygZ/C5Yg
         XWyrSHlchanQGOSqzmw4lBXzj8FfHQEV456idxvVHcL8ijw6OxX9bSIr+zwj51m2UMXJ
         mG+Y8DbpZ2DrqV7pDIFDRXwChZ25J68IQGDf6qJCwMWd24vxvAxyWEvCwMlo8q3KXjAe
         aaB1Q2K/fug4A2EyfYbJ+BBpFhIcXTz8oeszUfHkaE6a7heBF57cRX+ILLqRe15Swt7A
         pd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M72UrqeRuyBcXD8fVbPV6qhuJNerzMcfy2w0Aus0l5Q=;
        b=q0u4EX/7RbTIqmvGPalnwM8OcBbF65B6ntrttiot81HhB4EbLmWCJM/b74Pd6jMAZV
         rXl5w9hgVNisJZl//MMm+QSLrleBPL6bIldQYHnTGCkEqK2P+Fu5JoG3se6W8mhJINIq
         T77u2ihj5nXU5IRSiy+NjFXmlK8KWnh89s9jLjTn5PGBiFpBEugY6WqMYV6wctyZK5K7
         EHrG80az1433pQx0yWISzZbLJI6oJH0mSVSTmnst6PjLT00o5nRkPWi7Fg3KY6VZctTx
         zeS6i+fELlej+eidM8nbd5leshKeT8MGvuLUFZkIWBhZESBtowxES4sNXe6BLfj2Wh4L
         L3ZA==
X-Gm-Message-State: APjAAAUEpUekjDS3r/JAAf1YtHNgt/PvuovyR0G6QXqjLJkBeVHlyScL
        wvhg0GiZAjOQE6E9poT3kXdKkQ==
X-Google-Smtp-Source: APXvYqwEsMTw7jtqbIuD2dAeIQqOvPTqQfWtFxK+h2Zk/KCJ6frEkbIqUzDedlB2IbgR1ONZECfytA==
X-Received: by 2002:a63:e042:: with SMTP id n2mr828742pgj.45.1556756399042;
        Wed, 01 May 2019 17:19:59 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s198sm36927534pfs.34.2019.05.01.17.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 17:19:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Qualcomm QCS404 PCIe support
Date:   Wed,  1 May 2019 17:19:52 -0700
Message-Id: <20190502001955.10575-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the PCIe controller in the Qualcomm QCS404
platform.

Bjorn Andersson (3):
  PCI: qcom: Use clk_bulk API for 2.4.0 controllers
  dt-bindings: PCI: qcom: Add QCS404 to the binding
  PCI: qcom: Add QCS404 PCIe controller support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  25 +++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 109 ++++++++----------
 2 files changed, 73 insertions(+), 61 deletions(-)

-- 
2.18.0

