Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9AA8C267
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 22:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfHMU5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 16:57:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45320 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHMU5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 16:57:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id m24so24339560otp.12;
        Tue, 13 Aug 2019 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sZ/hWlDeEr31hV45AP4cLUTgr2xCQPFlUeit0Vpzfc=;
        b=XSp7U9v6O2RaTJaeqm4ZDpoPVV4rWPuldeHU40O/1P9XOkNo83/AnutIAg1vrMOT/r
         2sgq0wH78MQecRogPrvMzy54Zd1U374aXlC3IBb4sJVkWAsKV0whjFToesL8Rfj2nU9H
         5GIP4RAlurjghLnesLm83VfdBBciLU+FH86Hvb1boAYH/A1H9Fh1Hd4aYskRjGjFAkt4
         sTA5CBRpHPQeE0+AlrbYjL/LuYhVOXaaDzT+f27xT7ECPtez9aFKq6Ve1mABErJAlKNh
         olI49TYFiW2+Xhj5F6dUUW6toU0c7phoS9yiVjmrhRRmT7xnoMn13vAZN39vpZL9mM3e
         CxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sZ/hWlDeEr31hV45AP4cLUTgr2xCQPFlUeit0Vpzfc=;
        b=su3AfnaKE4qloXkW5fOw2+SRel2R4q8XGrvuLDcKTTDQhm/zyXjogDSEgVsIjPB0Bl
         lVvLYEYKSEzXfO8B5yWEPpjUAUEEveqpx8prLi6B33OJrCZzoCW7n9Kw8t3ECqe7WFId
         x8m1pW/sgwzdWiVyDwxMjj3+1eFidUugN7Dhqze+Fsq7h58D4Dl/aSq1sVuat/J+LOIr
         pxCzlv9UW/cX9/z/oRzA2NUElHKGWJu25uB58y+4u027xzepRdDnjuHXoPIgB1EFdX1f
         X+3fVmNtpvXjzFlSrdbZnPW19t2zHol9eyQVIFvh3lSIAb9PELOLmX6+/nlHjK+nupks
         Ysjw==
X-Gm-Message-State: APjAAAWAWL8X0tnvR/AOTckDeZRo6HFLmspCItgXd9gvR5I/A3nbivRN
        ZGvyrkQIeoubZUG6DHb9MP4=
X-Google-Smtp-Source: APXvYqwehOn7jV6aPdr6lJPcigvHXY980bnDGQKJJN8qtV8jg5dWBlAEl5Ft7o+nDMsmPiBvA58OLw==
X-Received: by 2002:a5d:8f02:: with SMTP id f2mr22096767iof.192.1565729867212;
        Tue, 13 Aug 2019 13:57:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id y25sm12874419iol.59.2019.08.13.13.57.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 13:57:46 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH v2 0/3] PCI: pci-sysfs.c cleanup
Date:   Tue, 13 Aug 2019 14:45:10 -0600
Message-Id: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
References: <20190809195721.34237-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series is designed to clean up device attributes and permissions in
pci-sysfs.c. Then move the sysfs SR-IOV functions from pci-sysfs.c to
iov.c for better organization. Patches build off of each other.

Patch 1: Define device attributes with DEVICE_ATTR*() instead of __ATTR*().

Patch 2: Change permissions from symbolic to the preferred octal.

Patch 3: Move sysfs SR-IOV functions to iov.c to keep the feature's code
together.

Changes since v1:
        Add patch 1 and 2 to fix the way device attributes are defined
        and change permissions from symbolic to octal. Patch 3 which moves
        sysfs SR-IOV functions to iov.c will then apply cleaner.


Kelsey Skunberg (3):
  PCI: sysfs: Define device attributes with DEVICE_ATTR*()
  PCI: sysfs: Change permissions from symbolic to octal
  PCI/IOV: Move sysfs SR-IOV functions to iov.c

 drivers/pci/iov.c       | 168 +++++++++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c | 217 ++++------------------------------------
 drivers/pci/pci.h       |   2 +-
 3 files changed, 188 insertions(+), 199 deletions(-)

-- 
2.20.1

