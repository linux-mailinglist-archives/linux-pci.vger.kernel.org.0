Return-Path: <linux-pci+bounces-40379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C483C37502
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 19:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23371A210A3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E2283FEA;
	Wed,  5 Nov 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZStljLmF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1F61FFE
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367489; cv=none; b=pWyIJQKPZS5DnXtGkzdsfkan1zLpWb5d43O65S6/kUUdUHh2pUvIeOAE5Fha4SIMjv8hinSi7FDVGx1wpPZoRwuR2+CnTF5jRvw69HGhmKsw4hFbBKOG2YzuVB9AJps5BgJMZ9sStP/49xURNCNpCe3deEnP2gnzRjKEppkGRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367489; c=relaxed/simple;
	bh=/YBNU2Zs9bQwCzypQZCl7czbp0g43BJMAns5HeydPQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7NB+mk1VkahUbSKjZ3KgcfR0KK0f8u7i1lWSufrT3SzOPefKyihkyvIRKp3Y3xSCmkYQBl9H3sDBuYa4klRRvI1uCNY45H2RCYrNoy9KR3ta6iz3PKbNSBObwW2JoX69xJhtpgc3p4NWqUCHzxUWlMhgVzjMHity15EXT5k16o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZStljLmF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso125750a12.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762367484; x=1762972284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1nR0mbklQG2hJieOjc7M8VFk9hHWwwuGzNsGBq/ERk=;
        b=ZStljLmFf7/UrBHvXoWrCx+H7T8ehMJz11n+sIxWgTD5owoBb+YWtqr1JFU3jpqh/d
         7v5v88Cdh+PE9rJeI1eacn8YfeeEZcutCH9FSlXk/NWAEV6LAAJpeUw1H0crNw5pXJ5O
         Kx47o6XqWYYzMuLWo45Qae8fmHBj16MZ6tfVyB5SUcwiaMmgPK8qmMv/qWXbocTJVW14
         cOPMrsxBs4WkHbiLGAg3XuU+uJQQxYJxbURd6rdn4pgsjoPHr9OA5zmJiWSH8CrLrok2
         giojrz8OEca+er4aSAFr6Xz7LKb83hCHLNs5eFFdq3dwhdRiTNLA9cTzxe322yWp/ORa
         jQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367484; x=1762972284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1nR0mbklQG2hJieOjc7M8VFk9hHWwwuGzNsGBq/ERk=;
        b=eeLEqYilkrKCTbC4GUVZewgSUrGXrhyCw6ax0GzTrjXKZx+tsQCYJR2bJQVt90KOGh
         wIcmElPWhxYzOj7yb/1B2YozcTQmr6Kz5MennnGmsgswH+j7oZpDv2ODb4rSbTEEOqHn
         knSTus63VjIoIk2s/Ade6zZUTNs20+vwcz27qtaFm/Z0LzpPmUEhT2XqmfjYCisPaAWm
         sBeP10WDY3JpyL77UwHwB3UXnfRT9lvTmdTvq/HkbUOu/nCs1rX4T+jeVp8QXOnerOu6
         NKMArtwrTSf9YyWBdOboWP3euk3gX/sQaNqVbQXPNyr0YVmzIyWLuWrf7hnTjDQO9T59
         BtjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVujSBumf8uZZEur6Km8a0f1iBBcfhtKcjRydtEqKDgC4CbWNKyKx29tG+PL509jO0zvqmyB6Sonbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bzI+umHr83dSaedrrvtUrrOvPQuqFja5GDrH3T+xyGUSxR4C
	1KialNQjwSvXTQG6+5U+uMQRUGMyVCqfFnujl8xP+AGeDtWEOMaQKjWxabQUA5QAemRAI/480Wr
	ImzK3
X-Gm-Gg: ASbGncvP4R/bbiFR5VtYg1gEgN0MjpmhAf6GBjHutGSvOx3smRTpyLR9vLs6GeDDoWT
	W+3n1nxx+JHvOh9w6v4bBWogrbwyIqWhHf7tOKcIufw5soDuNVc/Wvgk7zlizW/jNqiO6ZFG+lt
	0o5CaCo40RpTA8qmHSm8IRd4g6bHMGWwhwQj1DAKWOtLOaI9EU20W6Yt78fhiLYq9rx09l6iySX
	s/YSgC/5X/bh6it4DFyH+uPHWpKSOycErI3uycaI393/x3Yx9whywGnKwdvze6ACJzzbdwZj0kC
	7rHJhqVwNwA2AnnPGzpHjbRn4zPVUJ83eBP7cO9jpMZRAKao5Y49wKaLQj4A29ZEwLrhVsqINSY
	BdNMhhCBCNdqTQ1bjEz7ualqJlwHfQdJTozy0N/pky87/QiDHp5g+68Zk6Y41nP6pmpm4J8L2UL
	NBWmQFOzsFTqvZkIguLIP6mpjRliiVgvPm3Q5RoNwo
X-Google-Smtp-Source: AGHT+IE1NNcGqm+HRLEzkP77SOA+h1IB2k5I4Zb1LrX/nDwePxv7lray2sPF/mzmLS27Do1651fjKQ==
X-Received: by 2002:a05:6402:34cf:b0:636:a789:beb9 with SMTP id 4fb4d7f45d1cf-64105b88fe3mr3769353a12.37.1762367483984;
        Wed, 05 Nov 2025 10:31:23 -0800 (PST)
Received: from localhost (host-79-51-28-73.retail.telecomitalia.it. [79.51.28.73])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6806d82sm5224368a12.16.2025.11.05.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:31:23 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mbrugger@suse.com,
	guillaume.gardet@arm.com,
	tiwai@suse.com
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2] PCI: of: Downgrade error message on missing of_root node
Date: Wed,  5 Nov 2025 19:33:40 +0100
Message-ID: <955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error message
is generated if no 'of_root' node is defined.

On DT-based systems, this cannot happen as a root DT node is
always present. On ACPI-based systems, this is not a true error
because a DT is not used.

Downgrade the pr_err() to pr_info() and reword the message text
to be less context specific.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
CHANGES in V2:

* message text reworded to be less context specific (Bjorn)
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..872c36b195e3 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 
 	/* Check if there is a DT root node to attach the created node */
 	if (!of_root) {
-		pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
+		pr_info("Missing DeviceTree, cannot create PCI host bridge node\n");
 		return;
 	}
 
-- 
2.35.3


