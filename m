Return-Path: <linux-pci+bounces-9238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A9916A8F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F02428649D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191C016C44C;
	Tue, 25 Jun 2024 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgLE3HEV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B816B72D;
	Tue, 25 Jun 2024 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326144; cv=none; b=il1f1UBClHZlyfcmBU2hYNjSVC2kOqTZNQdmIrsG8lvnVQf7FjtBdokaCwWX92QnqWl6/r19q9Cn/VniQ7ZZNeP0UrOjwEF3MS7DHov7lalXaFvtqo0zAiDXNRE3CLWlemXP+olDICe2KwMw4fHd8p4MEbzZrLunmhUiUBZ5Ocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326144; c=relaxed/simple;
	bh=zt3w+G0CYyuqAlF5khozUaXMpSTPP5gLidUQ5V170ho=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sP5Tz3GDmHESQQ1voh9t/6i7NKJaC2cL8ExWH04EeB8YhOzYK5EnsKcVYmpFn09Wg2+2MTz0RriMmWgqnWfqlzSqxliK+1ORlKgf25lXdiHyvkMJWHT+FjtePDl+i1f2QFh6h3RIOx96waqkaXirxkKSDCy5sB0Pcfd3soz9vAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgLE3HEV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70685ab8fb1so1800542b3a.2;
        Tue, 25 Jun 2024 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326142; x=1719930942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IwZWi6rg3PLTjLnozUbf0ADV0Q/X7i+JAeD+rBcfMAQ=;
        b=LgLE3HEVQpm8rCaRPas3/GTvgTm0cfOtoQWxpif1gL5squHD4IMtkEvr70FpEL/w3y
         l/Y1O5IRMF30kuWv8D3d7C1VCmwlSkyrK83XdHpQHigHIfuNF6BhEQum5uGzhXaQnsNI
         V7WXBWfVyGWNId/HVj4Z5UncAHK+jAzT9TQelClEpejipnVPyDXHSMbuSJ6jZRSDeKRn
         lcgB+3jsKTSnPbwh5zh+qFonsf9fQVyM4eOZE3f4dX53hn/ibRdqNeEYCRMQ3huk38gw
         op55V8oj1wwkgj4FAR2Mb46XoUFMHraCqVZQMmsqFUD74dJUuj3Qqso1LX6tX1iLmOHs
         It+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326142; x=1719930942;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwZWi6rg3PLTjLnozUbf0ADV0Q/X7i+JAeD+rBcfMAQ=;
        b=ZUim1Ik4XqaH8XwuPJ4p2WyGTJoMHE/sgruJmnw5hbjiYn0PkPH62mJRB0DV3G4SrT
         0ZtVwGiDwXHDJFl1wg6uWzrHfz+nGApqGxlYzDS/rB1ztFXTy4MPNPLFOhUcymPlwNho
         yBobXxvJNk0PiycNoU5zx68/MYOAmE9y0YsFykkeoAipam9naN44RmSoSG8W3lmqHQix
         Cofs0SgSrqoNAimhwht1jU+e+qXa4uBO5oNEtuMJFKRS/W/2gizpgwRsV3+nC40Xy1wG
         41tegRZzh7B9Orc4dS0KAlUrABjSG9oNakHgY9+WWiRMh4vzH4WSFVpKskPhBejwmBxo
         G+Bg==
X-Gm-Message-State: AOJu0YznB41tHAUOdUr+6QbWAZadJvbeCGRPgF49tFvX49c07xRQd/rr
	ZPCdBcPIb0/DSESgZqAQlrXLjgGAtMPKc5MpqAHWQNmpx16YlwwK
X-Google-Smtp-Source: AGHT+IHmCeiSwLITdhYl/KmwoNrFvnwL6i9wipSp0CQoOlzYKOjgAEA4JQq6ZgZnNd87V32u2/QDHw==
X-Received: by 2002:a05:6a20:92a2:b0:1af:96e8:7b9c with SMTP id adf61e73a8af0-1bcf7fd11famr7598436637.47.1719326141825;
        Tue, 25 Jun 2024 07:35:41 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066fcbd3ecsm5681463b3a.207.2024.06.25.07.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:35:41 -0700 (PDT)
Subject: [net-next PATCH v2 01/15] PCI: Add Meta Platforms vendor ID
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:35:40 -0700
Message-ID: 
 <171932614033.3072535.4862353720600183888.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Add Meta as a vendor ID for PCI devices so we can use the macro for future
drivers.

CC: linux-pci@vger.kernel.org
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 942a587bb97e..aa57b7fba341 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2599,6 +2599,8 @@
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
+#define PCI_VENDOR_ID_META		0x1d9b
+
 #define PCI_VENDOR_ID_FUNGIBLE		0x1dad
 
 #define PCI_VENDOR_ID_HXT		0x1dbf



