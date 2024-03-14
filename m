Return-Path: <linux-pci+bounces-4803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC787B7DB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 07:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3C1C20DD7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 06:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84020C8F3;
	Thu, 14 Mar 2024 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y26P+v7T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A418F7A
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397217; cv=none; b=dTapjOwn1crWysEZxK5IxBY+OfVknGdJjk1iCsnZKm5p9axF5C5d5QO5eV/PpkMZKCrdcold+NmueqG9mg0c/96keO1QI6/2BAkacFwlJQ3cf0hONeOmVI2Eo4tKKEUJcu+VIojDLbzfXx6aDkp8ttaz4y3N/0DXhWYz+Y+9V9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397217; c=relaxed/simple;
	bh=RVY9LtaldN4dK7ChsDM1tl73FIirQrA5EHVKgpn0iYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOKC7OU1OL//KjnX4B5oXwn0ZEOBF45uXi7hn+umf9C7denhjzAfUZkmzmtf2//ZTOaegKfOPev5GihbFyH/vD9mcj9Tn7TR3k4VVfX2ITsw4A/I9vhCU8ZqpTIq+h4Dwaf/mRlui2xL6LrAfvsfPO0gykXATnvMMS+ExUP52IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y26P+v7T; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6913cf5b853so5545506d6.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 23:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710397215; x=1711002015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQSl4F/tRekRYe+yQvA50I+RIwzF0X04mOK3C3CiZio=;
        b=Y26P+v7TgDP6puTbgVwUyfG606nTzKiI2tVqvdQ70KCcN5ozoI6orfeFcoi2Udaa85
         443rF0S5qTVHgYwSvlHmaXYj9gatk88Zo0A7I4gTm/CNPONokj0Gwy32A4PBBHR2BU5d
         vjRFUwGaMsAFplm/uubJ/yXFA0Che7TDrYi82DPpLTLSkKJUT3tkncfTkaPud0VLBLoq
         2tvB1EYDonsgP3KsSt8z6Ga2C/OJkHdnitugHWxrS9ZgAnPGDFKehF1KdwkskOisPLaj
         SSW0QILFTmPpDXuqzo6zWVkk+WFPPTm3xL0HPs3bRnyNxQlV9aAiz0mZAMxKheE0E6EV
         7Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710397215; x=1711002015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQSl4F/tRekRYe+yQvA50I+RIwzF0X04mOK3C3CiZio=;
        b=iJfPv3uecE/8biQz5RH4+GEc6tCTYeWByjkCJEbRlNU7EhKfkp7sW0SSm05I8A5Uhg
         vhSU5N9OaexexcWlB2C0H2V+pfEwggNzmpMAkhxgZcH2BPur7oXhKtBUsqPXpADOoCCZ
         ygOuWr+E7TfYHf0n4qfT3yJLpxB+3qmUFEgF6sQlIoPdotq1BIp+ThUthKLkIs2BtXsf
         BOAmXomY4evn6mmVj77COY4KXv9JaXxP/g4rS/uVTWwAiDQk/j1KdrhuTav65KAxYOpQ
         Si6bJ6WhAWH4renw0IZw0KCW4Kx+/1ffQaE/DvRzdpT3Un8sq0aSZpQTyjTWXBpR+ptl
         YC3g==
X-Gm-Message-State: AOJu0YwzE9WFzNQEwzTpCA8fjh14ah/MMzE7MBwsIi18hNEMpGwL1XX3
	OyIdi7gBz3tWBZ935S0FiNEX4rLY+8K4Z5QTMu1Je0cgaGZgsfMA
X-Google-Smtp-Source: AGHT+IH0watcl/HOniLAutdFAL9zxJmz3r7p8aCUbqO+ylVZryJmVh5YD7S+k6MQWX3GSAjdum2uxw==
X-Received: by 2002:a0c:f0ce:0:b0:690:3ca2:1858 with SMTP id d14-20020a0cf0ce000000b006903ca21858mr921857qvl.4.1710397214684;
        Wed, 13 Mar 2024 23:20:14 -0700 (PDT)
Received: from zijie-lab.. ([2620:0:e00:550a:e7a1:321b:1b99:1b12])
        by smtp.gmail.com with ESMTPSA id 5-20020a0562140d6500b00690c59d4e8esm545379qvs.77.2024.03.13.23.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 23:20:14 -0700 (PDT)
From: Zijie Zhao <zzjas98@gmail.com>
To: bhelgaas@google.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	chenyuan0y@gmail.com,
	Zijie Zhao <zzjas98@gmail.com>
Subject: [PATCH] fix memory leak in pci_bus_set_aer_ops
Date: Thu, 14 Mar 2024 01:19:46 -0500
Message-Id: <20240314061945.1324128-1-zzjas98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <518813f8-294f-461c-b0dc-e980893a9ebf@linux.intel.com>
References: <518813f8-294f-461c-b0dc-e980893a9ebf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary bus_ops = NULL assignment in pci_bus_set_aer_ops to
prevent a memory leak when ops are equal to &aer_inj_pci_ops. This change
ensures allocated bus_ops memory is properly freed.

Signed-off-by: Zijie Zhao <zzjas98@gmail.com>
---
 drivers/pci/pcie/aer_inject.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 2dab275d252f..0c84fadbfd2e 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -309,7 +309,6 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 		goto out;
 	pci_bus_ops_init(bus_ops, bus, ops);
 	list_add(&bus_ops->list, &pci_bus_ops_list);
-	bus_ops = NULL;
 out:
 	spin_unlock_irqrestore(&inject_lock, flags);
 	kfree(bus_ops);
-- 
2.34.1


