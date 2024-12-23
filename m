Return-Path: <linux-pci+bounces-18949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE79FA9C8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 04:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB53016626D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 03:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3025A6A33F;
	Mon, 23 Dec 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dDGNJio9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E790179BC
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 03:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734925184; cv=none; b=HJU4eDJUvQ1rxsx9KAAnXIk/EnWnsMM8oj4CVFEerTjoPaCuVIhknZ+qOEGT3HReWEFdbYyNtjmfGwdGf8CGoIg7EccwISHlpDZdWmzYt0ePJocengLlmA8rrJjfQC6GBH3MhZ6WeCvwIeoazN8lE05Q8qk2wjfUX5eEndmCj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734925184; c=relaxed/simple;
	bh=F6FagezIzM534u7a2qjMgNMs3JDMcWn+kUD3hGxO1mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAekCdF+PRCvw+nGkSs//yuE4KwmE2AblXAkCqYgGmQcHPGi2F7bctO1DXywnFmJtloqu0NljBM6iUPoQz9FRXX9pRntBpY18dkueAAf2ih96GQODcqdvY8XG8BIG/YWZvfd4Osg3gqa5mp7q+l5EOheyge81hVTWWmwAiCVqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=dDGNJio9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-218c8aca5f1so39879405ad.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 19:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1734925181; x=1735529981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0MYK3UMxsfG2FkHCYo9Ux1OBZct8CyOWydRM60cM8c=;
        b=dDGNJio9YMCIlzg0kMLivh03RCyTb/PRiB9dt9EU8UUJQQMCo1oj/tHOSXLGLAf6Ed
         uQEo51J3Jw92eMqsWIbxtUSAQr7pUqul+iZk7Rn9xSxL4I3s/0evW3oPY0LdzlWcwStz
         pSQPB3d0yVLa/5CaJOK6KhV+l/RYPZDB7t9O7J/TLlj3eYM5xMInSNpoqskput1BVMf+
         QYNkIeze01NQLMBrElTLjfG/ScIDjTYcxhlgtwcM2jiGRyIeBTxAZZ4TZ2ik2TUjs/Ru
         Cxzu02/NaNvIgGg1RSm6N0e44PFXBpPsj8WkoF+/APjCrc3axdKDTeDz51sZHW8IzD2j
         5Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734925181; x=1735529981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0MYK3UMxsfG2FkHCYo9Ux1OBZct8CyOWydRM60cM8c=;
        b=AuwO7sx/RJDzXS6VMVEhhtSjpbwha7lCNVie7AozUGXnetAMM7LPkoDh9gAUfOuWNX
         ZP653AF0gpq7a3+50OcarV/ZAWA8vJav9lpf2YKkbhMAZD8T8N5DuUNExHSQPLZR84wA
         Hckj2jPYEjemQfoW2WEgPCMFbOtI/sLvLdppEJlstQBbiG5J0H8nbE89pVPHCr8rgG70
         HrLodupbno3xXLcEy9wmm1B7sW4qGy88ym5RUl0DvH5q1jeo/9Yi/Ot8zt2xfQt0oelX
         fAPbS4FTd+aE5BwA5qGxx3k1066YgplsHuupN2HSRUrZGqtGfCnpQjtMTV859kszTw4B
         w1oA==
X-Forwarded-Encrypted: i=1; AJvYcCXFJ5jpCfQhUw5isPNDR/dT4J+tdTEFbYbxK3WMsj5lYJ5wAWhnsO3AdFCOy1+qQAtNqGMrqQWbBw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzIclp0/DsuyAbNZRpeTSXuebIbBOyehon2f02XSh+hc0mmlcg
	U6kbnb9iffhdaatSOQA0cmcE7PVotHEgmyF08LggAm1rnPhkybCnHig2XHtfoQ==
X-Gm-Gg: ASbGncsXO+F++aRjYU/G7oWATCEqLvdTBMozDa/D3omdn0CBrm4VyUmoMSJcic/6kMp
	0RYAhkBvXk+TBdrJ+Rhqoh6Dfd+bF51/HbFV1UVE3Rrmv6V+Y/IwTrLHPGtJyBN4izhs9Soq6hu
	s//CWKicD2edX92ffNLibazeH4x6GO3cpo/5dIGRhgcuUuUqfRF4RAksaYq8gL6D8Rq5FkjioE1
	EDr374F5vTrA+gDM3/+mT0RnwewUi4e4gagx/2ECsN7KE1YvjUPLfB1HSv7DJNUMrzI2rRfmTJk
	tir00BGa
X-Google-Smtp-Source: AGHT+IFVJ0IX85GgDYXyQfuHz4tm5Q3yLxp5P3/rqwsgCsMNgsRWvU7vYuG8JYXzCNCvisA1Zr6YTA==
X-Received: by 2002:a17:902:ebcb:b0:216:59ed:1a9c with SMTP id d9443c01a7336-219e6f317c7mr145817305ad.55.1734925181660;
        Sun, 22 Dec 2024 19:39:41 -0800 (PST)
Received: from dns-eos-trunk-123.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02e91sm63616025ad.274.2024.12.22.19.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 19:39:41 -0800 (PST)
From: Daniel Stodden <dns@arista.com>
To: dinghui@sangfor.com.cn
Cc: Daniel Stodden <daniel.stodden@gmail.com>,
	bhelgaas@google.com,
	david.e.box@linux.intel.com,
	kai.heng.feng@canonical.com,
	linux-pci@vger.kernel.org,
	michael.a.bottini@linux.intel.com,
	qinzongquan@sangfor.com.cn,
	rajatja@google.com,
	refactormyself@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	vidyas@nvidia.com,
	Daniel Stodden <dns@arista.com>
Subject: [PATCH 1/1] PCI/ASPM: fix link state exit during switch upstream function removal.
Date: Sun, 22 Dec 2024 19:39:08 -0800
Message-ID: <e12898835f25234561c9d7de4435590d957b85d9.1734924854.git.dns@arista.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734924854.git.dns@arista.com>
References: <20230507034057.20970-1-dinghui@sangfor.com.cn> <cover.1734924854.git.dns@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Stodden <daniel.stodden@gmail.com>

Before change 456d8aa37d0f "Disable ASPM on MFD function removal to
avoid use-after-free", we would free the ASPM link only after the last
function on the bus pertaining to the given link was removed.

That was too late. If function 0 is removed before sibling function,
link->downstream would point to free'd memory after.

After above change, we freed the ASPM parent link state upon any
function removal on the bus pertaining to a given link.

That is too early. If the link is to a PCIe switch with MFD on the
upstream port, then removing functions other than 0 first would free a
link which still remains parent_link to the remaining downstream
ports.

The resulting GPFs are especially frequent during hot-unplug, because
pciehp removes devices on the link bus in reverse order.

On that switch, function 0 is the virtual P2P bridge to the internal
bus. Free exactly when function 0 is removed -- before the parent link
is obsolete, but after all subordinate links are gone.

Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free")
Signed-off-by: Daniel Stodden <dns@arista.com>
---
 drivers/pci/pcie/aspm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index e0bc90597dca..8ae7c75b408c 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1273,16 +1273,16 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	parent_link = link->parent;
 
 	/*
-	 * link->downstream is a pointer to the pci_dev of function 0.  If
-	 * we remove that function, the pci_dev is about to be deallocated,
-	 * so we can't use link->downstream again.  Free the link state to
-	 * avoid this.
+	 * Free the parent link state, no later than function 0 (i.e.
+	 * link->downstream) being removed.
 	 *
-	 * If we're removing a non-0 function, it's possible we could
-	 * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
-	 * programming the same ASPM Control value for all functions of
-	 * multi-function devices, so disable ASPM for all of them.
+	 * Do not free free the link state any earlier. If function 0
+	 * is a switch upstream port, this link state is parent_link
+	 * to all subordinate ones.
 	 */
+	if (pdev != link->downstream)
+		goto out;
+
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
 	free_link_state(link);
@@ -1293,6 +1293,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_config_aspm_path(parent_link);
 	}
 
+ out:
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
-- 
2.47.0


