Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE827F4B5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbgI3V7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:59:15 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43255 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731489AbgI3V6w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:52 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F39C6FB5;
        Wed, 30 Sep 2020 17:58:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=ERnpPU+gIC6hydkrdvGearFQ2eli18omiMWIHaoJwrQ=; b=jak1o
        tPPEZcX5KQaEmGn769aCBi2pcsoW9RUlDVzTD5faTpByCcGLdHR0SrELsonU7y9/
        WJK/Kl0kjpk6muynrg3WtbbwJ0RmfIQDU6lKbMj0RqwcQYXjcB/GlqLpS3Z/g4cd
        kVGxl5tF2tmff5N7B3qqI7iRVRwy4LmEoxhVKGU/+mt4BMdtNVwKw9wugNIokMSc
        N2ThANnUI+J+hq77Wz0oPUFwGikyZtD3NtC9jXws6MoKfKZrwR4diUv4u2wxqBai
        vK44jcO7kA8DX6t6Ecygg3uuCrrFS5b+9m1SpqlSZ1Zpci5HHVI8VYiNWh9G1gDG
        1l+cjIDS010AAQcEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ERnpPU+gIC6hydkrdvGearFQ2eli18omiMWIHaoJwrQ=; b=nU7ZUdoW
        M/jkPOSsbg61FhOFV+8Y7eVFEDXbGw+0C3jFQRDtbuSpkh3yzAb50cJOK6c37RYJ
        2WIgAS/IgI5sT/CVLoMEus4rnZOygrrKXgkTrV5CQBnrgJjIWId7uPN1NG2Gjfl9
        27Z9Oq7Zv9Iw2SblTLqCzoB6f5xgrHWScl8aP8oVtyH8c5k43h4w0bnW3ZU0iC4W
        K5wZ1pK78W6fRrblcMCm5homdMsCV+144hUqXr9YpwJA/vK0Y8fPuKY1qXpaqCT+
        pPGomnCgmlgwuIYEOijqz3YaXBZeeTylIGmEKt8REmefc9CLBSOpF7q1Estp5POS
        1tO6jmWGvF41WA==
X-ME-Sender: <xms:mv90X3xQYZcZoOcAX0rtYVsQ79Q-abprsfSDLeib4zmMTRpxhCG2Zw>
    <xme:mv90X_TIBOXlDz6yKQ-Bn8hS1DMi2R8vLqAEp6DvUxv3QZX8CSJ4ShHR2SC0R4dvD
    UcPFoqfKI3cna-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedutdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:mv90XxUg5Z8hJvhv-tY3UrE9wTDExdvi0zHAJ2N6kB3beqpvHJs7Kg>
    <xmx:mv90XxjzoP1oOQQqWp3jlPj2CZDHK1ceN4pgntFTTsDY0bTE5ul5nQ>
    <xmx:mv90X5DVUr6LHemN54_E21yYj8bc6O0ji-j6fisbal1-wRWRXhsvsQ>
    <xmx:mv90XzB4wrB7cg9VVUGJJGjlkiXSLeaHuFfgNF6ZgEYycVCxVwgY_A>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18A6D328005E;
        Wed, 30 Sep 2020 17:58:48 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 13/13] PCI/AER: Add RCEC AER error injection support
Date:   Wed, 30 Sep 2020 14:58:20 -0700
Message-Id: <20200930215820.1113353-14-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
and also have the AER capability. So add RCEC support to the current AER
error injection driver.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index c2cbf425afc5..011a6c54b4e3 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!dev)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
+	/* If Root port not found, try to find an RCEC */
+	if (!rpdev)
+		rpdev = dev->rcec;
 	if (!rpdev) {
-		pci_err(dev, "Root port not found\n");
+		pci_err(dev, "Neither root port nor RCEC found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
-- 
2.28.0

