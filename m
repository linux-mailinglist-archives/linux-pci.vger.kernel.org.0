Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61EDCA9AB4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 08:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfIEGdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 02:33:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45050 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEGdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 02:33:51 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so2125909iog.11;
        Wed, 04 Sep 2019 23:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8srOGTlB3IlFb1fG9Cy7TABLNTUxoNkjl+Xdp+XplQ=;
        b=sjSsUGPEHpHy6b2bNKEIBqBa9fuBj1iAKUe72R4QABNK7+sUdUIhna8m1KGIrBj3//
         W766SvdZMZJeMgZXhXAaEI0yD5U50Xs0Ge25Rq4N/cdU8+NxrQOc2+CoW9jfzwlgWW51
         6GKuL0LhPoPs69wCveziIc7PBTFfDlxmZH2q5X3s/LKEhQBNMNKKOtABGsDiKP4GkqwG
         i8WDJSmLK4/Lt+MS/H/ZfKvphGCfTphRitYtqInS/uyAnb61+PkmrghmpiXDYWTn+Ht2
         ZPF59GL/tLaKcZ0ptX4saOAlaBVD08Id1cU4S4PuLnG/3VxkX60+d6Dcsejq3+fSjkFD
         zoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8srOGTlB3IlFb1fG9Cy7TABLNTUxoNkjl+Xdp+XplQ=;
        b=b2/sxQnQ8MRmW0PKnSbI1itruexr4hE2B99V0eRudY3MYLfc/FYV2z7dbsutxvcj74
         sx0q1OnrgE+Uzh2w2Ru8X5APe2fCeUVkNjIS8jTwnSLME4gBE6Zs9BIVpSaRNTsgVmoI
         wV6l+x/KJBODfRCWkBZWbqbHOI8EGFvSltGAOT0qDEh3CMoYSzBakXfLvVWwx9kAmllM
         1hmt4KEggtuOAmZzcIIuWm2pxRNjCchDlELjqWXiWK1W+wkv7U5s0dvArFwO4ZIdkYSu
         jFvxVIRyEKovanzfRdu6pyJq6urW0S3UWPfzpkAVtWqsE/79CXCk/fetEd8KXWW5BonG
         vauQ==
X-Gm-Message-State: APjAAAXU7DijUCAu1TLJeccEMo4cooDL2CAu9Y41DR90g2TVqrHRHmLW
        yxWLgAKyfnAXDmvyZpSmxKE=
X-Google-Smtp-Source: APXvYqzLL0pKn+dBfARGTTk5lBNR17qGT8mNHbYwaXFjNx1JfxGBXYYsLdCfYl3Tkjl2GPfpFrYNxg==
X-Received: by 2002:a05:6638:155:: with SMTP id y21mr2384307jao.112.1567665230445;
        Wed, 04 Sep 2019 23:33:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id n12sm965553ioc.19.2019.09.04.23.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 23:33:49 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bodong@mellanox.com, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ddutile@redhat.com, berrange@redhat.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>
Subject: [PATCH] PCI/IOV: Make SR-IOV attributes with mode 0664 use 0644
Date:   Thu,  5 Sep 2019 00:32:26 -0600
Message-Id: <20190905063226.43269-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sriov_numvfs and sriov_drivers_autoprobe have "unusual" permissions (0664)
with no reported or found reason for allowing group write permissions.
libvirt runs as root when dealing with PCI, and chowns files for qemu
needs. There is not a need for the "0664" permissions.

sriov_numvfs was introduced in:
	commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs")

sriov_drivers_autoprobe was introduced in:
	commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to
			      control VF driver binding")

Change sriov_numvfs and sriov_drivers_autoprobe from "0664" permissions to
"0644" permissions.

Exchange DEVICE_ATTR() with DEVICE_ATTR_RW() which sets the mode to "0644".
DEVICE_ATTR() should only be used for "unusual" permissions.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/iov.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index b335db21c85e..b3f972e8cfed 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -375,12 +375,11 @@ static ssize_t sriov_drivers_autoprobe_store(struct device *dev,
 }
 
 static DEVICE_ATTR_RO(sriov_totalvfs);
-static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show, sriov_numvfs_store);
+static DEVICE_ATTR_RW(sriov_numvfs);
 static DEVICE_ATTR_RO(sriov_offset);
 static DEVICE_ATTR_RO(sriov_stride);
 static DEVICE_ATTR_RO(sriov_vf_device);
-static DEVICE_ATTR(sriov_drivers_autoprobe, 0664, sriov_drivers_autoprobe_show,
-		   sriov_drivers_autoprobe_store);
+static DEVICE_ATTR_RW(sriov_drivers_autoprobe);
 
 static struct attribute *sriov_dev_attrs[] = {
 	&dev_attr_sriov_totalvfs.attr,
-- 
2.20.1

