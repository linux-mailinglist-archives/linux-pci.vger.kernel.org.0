Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611E51A83C
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2019 17:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbfEKPaQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 May 2019 11:30:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38820 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfEKPaQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 May 2019 11:30:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so10778832wru.5
        for <linux-pci@vger.kernel.org>; Sat, 11 May 2019 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=enks1tVVdmp7oJBd4pEN4rlBetLBzWZ9bkhbVzlozQk=;
        b=dltZu5zIW6iDRqSPefQEviQsA0gvVbmpl+PqbIvxyKQu8iquTicJBtsZfOPnjOUwBb
         aZu56Wp9Lfsk0zorlTDrFW9UWPVnhmh7c5vLQhdaiZXIWYxRIrTl7pVZxyCM4Gdy/9SN
         Wwza1rf38IzP2XMLD1vCXxtn3yKFTNqHShzgp+yyQTUUR/k7vgUJSi0RJmlHY4PrWIx+
         Ojw+mCf4zB8WBdHALrXs24A9Wj3VvkgTCyqUABg0orltuTJ1/P+jeIjQMUfbA+7r2ecl
         YpxH/Kjugl6aoT/lgzE8BsH47xsGOcmtu5Qf/2xu/WWTNc4xFSUVgrPBLtPaoU6H6n3T
         cReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=enks1tVVdmp7oJBd4pEN4rlBetLBzWZ9bkhbVzlozQk=;
        b=Qa3FS3j80l9o2sdWVT+wEKiZcIDQzghGQKS46aj+nzXeAH9ifr4UipXnN9Mt8gmdrK
         /YoaSgwRjzcl/h4HOjkvBlroISFVUBgahR6oHQsCW1kt20r1SkUIBjocAUFo2txXfIWZ
         YelmAyRux3Qm0Am1SEvagAO7gb3AFB/n9V4vaH/OQww0HW6WM3D8yvI/WsscOr6b83vh
         VAYwd84SV9YUHsb21Pl9goAor6ks5e4s66CUlFoS+RrfUIr5vVf2SsCPA9kso5fApE+z
         5mIkzlO1E1apgM41jNz5P4Lhy8VE2xClf0kIcvfGXQBofoTlU9DhbaYd4Tcuxg/9i7PD
         hDXQ==
X-Gm-Message-State: APjAAAW+UEy2z+F9j4jxSs1gjRKxoHNxeAUPRdmrakAbSMjCyY9oCssr
        nL8p4D3qilqAqzQ0dbQ4K9N8UvleOCM=
X-Google-Smtp-Source: APXvYqzCOYWIcjIvmj5rC+Pik/HehLZ2HKSOWeB4bvD1lLaJr49tNw7RWpRohSnqpUe81Qg/6XmjSQ==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr11219160wru.176.1557588613832;
        Sat, 11 May 2019 08:30:13 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:5700:152f:e071:7960:90b9? (p200300EA8BD45700152FE071796090B9.dip0.t-ipconnect.de. [2003:ea:8bd4:5700:152f:e071:7960:90b9])
        by smtp.googlemail.com with ESMTPSA id t6sm8076794wmt.8.2019.05.11.08.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 08:30:12 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC v2 0/3] PCI/ASPM: add sysfs attribute for controlling ASPM
To:     Frederick Lawler <fred@fredlawl.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <e041842a-55ed-91e3-75c2-c1a0267b74e5@gmail.com>
Date:   Sat, 11 May 2019 17:30:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Background of this extension is a problem with the r8169 network driver.
Several combinations of board chipsets and network chip versions have
problems if ASPM is enabled, therefore we have to disable ASPM per
default. However especially on notebooks ASPM can provide significant
power-saving, therefore we want to give users the option to enable
ASPM. With the new sysfs attribute users can control which ASPM
link-states are disabled.

This is a RFC version, therefore documentation of attribute is
still missing. The attribute handling was inspired by the protocol
attribute handling in drivers/media/rc/rc-main.c.
Attribute syntax in a few words:
none: allow all supported ASPM states
all: disable all ASPM states
+<state>: add state to list of disabled ASPM states
-<state>: re-enable ASPM state if supported

v2:
- bind attribute to the endpoint

Heiner Kallweit (3):
  PCI/ASPM: add L1 sub-state support to pci_disable_link_state
  PCI/ASPM: allow to re-enable Clock PM
  PCI/ASPM: add sysfs attribute for controlling ASPM

 drivers/pci/pci.h        |   8 +-
 drivers/pci/pcie/aspm.c  | 204 ++++++++++++++++++++++++++++++++++++---
 include/linux/pci-aspm.h |   8 +-
 3 files changed, 199 insertions(+), 21 deletions(-)

-- 
2.21.0

