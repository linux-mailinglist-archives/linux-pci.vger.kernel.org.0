Return-Path: <linux-pci+bounces-37799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DA7BCC5BD
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3945F4F285E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 09:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3226B75B;
	Fri, 10 Oct 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lFoIQnvb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EEC22156B
	for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760088769; cv=none; b=cHr37nzvUFwPTTm56BY0JRNtBCjmb3kDKl6PendrETHwGtBRCZz5bj4EXdHyA7l2rGmDXIPsF6Skn80lDWh+MZCwtDfIA03eyXrtrN0iMhvfr4dILvypQkPKsfyIvjYxf1LibUHCIxXG8O3xKqOcJmM+L9pM1HfolquZINIMVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760088769; c=relaxed/simple;
	bh=8jR7JCx6mX9Zjdm10k9TjKk7p7TSQ/2gxTGENPOyPzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k1x/cK1aJCZi1U/JpuzQ2kAnkrW+XP3NhhFCFOYqCoj0RY6AGXpiZ4FoXW2tElxKx/OZPjymnxGyRKjnKKZW9gRE9glWRijaEPaBM6f+p6VDwC8S2CCAhW8JtvB9WPV+qAwYoKs11mak8mkCE0RldmzwCN7KP42YRWBvr/yp4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lFoIQnvb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-794f11334adso1670940b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2025 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760088766; x=1760693566; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e1j4JQEBprrAt8CIDcRJp5F0vEJV3rg2M42iK6PPNrQ=;
        b=lFoIQnvbzSz4sIbeEoGUrG35qqN3TGY0x3e78cgliwjD5buWtIvkJWchjDUgjhQEOe
         AZnzMb8m4W+a++0efs09hx+QEn5gOWi6wreVraJKlK5nk4J9qFlPKwMxwwtt/jqHIcWq
         WlyIU9zCrK+P1+dmq0/5lqhV+Nei3alHefEaFOuNAsRPv7pybR76qGA/PtzhfDcdrsND
         8+fWARd/L9bVv1pha1w5Zc8HgfhCMpDmjW0QqH3Ld2l06Es3d+5VtF8XUkv0IgPirQyf
         IkiBSpzFauVFTLdHszAQ2/u9hWoj5ccu7o2eRDhgVBFVo3eUBQDMAr12UBAgGnUHBpz1
         Xz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760088766; x=1760693566;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1j4JQEBprrAt8CIDcRJp5F0vEJV3rg2M42iK6PPNrQ=;
        b=F4Qs6Fxm8vMeBUWmmrO3poaV0IHMKRnvzYaCkwSPHSO1Giic6n2OzachaHoMYPsVBF
         doprezt4VTl7u6Y2sRqorzlPEpNEY1e+51pSj0qIC9IrDQEe+CnnNxX+tMTWIXcbJAlm
         wwByuAAA3qFQKBZDReUGxR6Hcjvmp95JNUppwXmelwVEdPmJqjTK3N28EJQTVpoN3WhD
         Y1NTh6ZlO6TVgVX3Qw/aKolt9wrJqM8e+MmA9RYMBeG0spLts7O776aloNgoeB77cDoZ
         DUKiNz+DtcU/1lw1Fjv5glsu/Yqfou5vXYyIQmSi4wF0BlBhn1IFS/8o+nbopRf9d5l1
         /yrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMYunp8bD4lv7gpJD3PBiaJMwIrvNcKuaJ66hu5XtWInzqw3ZvKqnaWEqykHlbJaVO973ajda0OoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4vxca7rZtlSChPtgA1qn2vsN+m9Am9Z8SE9NySX5oTi0uaDC5
	iMlqlhR0Y/TvAzzkjZsDnz21ZtXXk3vMZMWAMNAuHBZlVp/PpU6Ewb5nWA+9w+61kGP5mXPSBZu
	fwL4m
X-Gm-Gg: ASbGncsl7in66htQ94k5g3qk5mrhQ2j09jbm1u2UoaLT6fKtUlLmF33UT5t1mnboEui
	HPHl/TbfAqEbnklkb9JYdLCxvG6LCYPlQGjeaZz5hmX7z/XF8wo91vJEJEL4xU+F+fi+VwAzl6w
	rEknnG7VZmMPZhIOGrnLOvXp7cqvw9ImEYHxMo7vmfkvckVwjP5hSqV7hvDgFTosxD5Bfe6/TX0
	4ZjmmC3lYtH+ejicf9pNjnENsX/wKLuTVDRzFZ74xCPjIFxWxWX8CxOB1C/lJ5sr2n49FvHX9AM
	5s4oTlWnaMD9Y2UVz9n5k+8afCPzV/f17s+s4E04BpZjNa5SD/TmXnajVXgD5OVxrMyhSHxSKoD
	yOd7eNVI3I8GgVyeLD5kyY4sUdTHhuF7MA0+WrQfICsWVh7qlJt1wpjMQ/SueaaJnVjtq6XOeny
	3fU4TqOlBz5l1kwqimTw==
X-Google-Smtp-Source: AGHT+IEHvg8I+2J3GlYDkq/cIvoLiQvtAkgOU8NxYFWlvB/PSTBrQS6eSFQh8W9oHia17FqxPc8AoQ==
X-Received: by 2002:a05:6a00:399d:b0:781:2656:1d6b with SMTP id d2e1a72fcca58-7938763251bmr13394405b3a.24.1760088766109;
        Fri, 10 Oct 2025 02:32:46 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2d51sm2308775b3a.65.2025.10.10.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 02:32:45 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: bhelgaas@google.com
Cc: guojinhui.liam@bytedance.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI/sysfs: Fix potential double-free in pci_remove_resource_files()
Date: Fri, 10 Oct 2025 17:30:22 +0800
Message-Id: <20251010093023.2569-2-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
References: <20251010093023.2569-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Avoid a double-free in pci_remove_resource_files() by clearing
pdev->res_attr[i] and pdev->res_attr_wc[i] to NULL after kfree().
If pci_create_resource_files() fails it immediately calls
pci_remove_resource_files() to clean up, and the same function is
invoked again when the device is later removed from the PCI tree.
Without zeroing the pointers the second free would operate on stale
addresses, causing use-after-free or a double-free panic.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9d6f74bd95f8..a8a27d6c62bb 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1222,12 +1222,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr[i] = NULL;
 		}
 
 		res_attr = pdev->res_attr_wc[i];
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr_wc[i] = NULL;
 		}
 	}
 }
-- 
2.20.1


