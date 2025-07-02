Return-Path: <linux-pci+bounces-31216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B5AF0AB0
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 07:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA47F1C01F94
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 05:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB89910F9;
	Wed,  2 Jul 2025 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YG0/mU/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E521DE4C2
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 05:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433929; cv=none; b=RqTUR36XbBqwNjnFMGhLUzlM+oLGI8j30Ay6TuvWFtxnmOGBzMx5XXX+P4YdrjgETVQYsdRnLDKsXt4gwOmFSkV72JMKMoYhNh8XUjwK6QyqPFRVM1GGG9ufSPZNcpUzR+83EQd4wWEN9pkx2Hg1Vok5ofMJu7CISH1F8VbO/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433929; c=relaxed/simple;
	bh=mQmxSUYNnzKqN+hdbXUIdkLoL4M3z/Ob2/ebft57ThM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLJzEWgpILegDpjvsMwncXnlhnTNdYxOLbw3yuLNVXail2gMxFdV1lu99sPCngmBaEFlAJhtYDRJuvEiQw6N5cUVmgWsSbe8+xXBoI2y9PyAFBiGXwKOx4GgN6Ud1RsTjQin3C0XgONy4nQjKsOiFN1yhZ6AlNzHVTgP+d7K1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YG0/mU/w; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-747e41d5469so4512276b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 22:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751433927; x=1752038727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5UGmjgthx9onoq18n2MbYlAK0fxvMavZ/FX3QZ84xE=;
        b=YG0/mU/wNlutG4+COTiFtmB10LS6E4zeQ/jLq6qH8KDYwuuMEVyukuxd+CrwmnrEXT
         +6R+D8BT7NS7vUXq/UIW+6Xg7hHXrlqxI6qvUCp50xm3pIGrbVvVq0i5GShnBVCBkl3S
         rH3SlJ0r3H4Dg3xBmZKj8/jSh1alzDmh53iNsK6GkewzaoPXj22YVNh/h8CYE8caja6d
         Ug+Svlg3v/jUs/grqlu+XA3cCcWQnQY8Fg2yVHnsW/FwW4+3PacGHwdBX04z9wOfwFiP
         cLVB3UFh0aV0O6YcfLKRDJMaBP9OWJOsYNvtnDPwwvVGSiq7PyLxmcjxPaNhvbKHTnvd
         oMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433927; x=1752038727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5UGmjgthx9onoq18n2MbYlAK0fxvMavZ/FX3QZ84xE=;
        b=wNNLMBFvoWV1lc/5+4+0QTmtCb7KI56j3+LASG59s9LeMWS2pqV/n+WYB/bNKsr+mo
         3y6dX+S65S60NcEjO0v+pS8a2v4KAYFdPQpFAS61W2QBXl+fAQ4AVOm2iHGBr97MH/OR
         srbqisB19nsbTjcTnh4IuznnYGzM+B3FmHG2OmxMDFZnOZ82ibKYRSSfou8ytBjYV5G9
         eUEpBDfDqlmybTtys0eMhd3yYJAIh1NXa/3VTRBg7Ei/WF/u9ckqUrC52fLTehAlSNXP
         LsTXj5MIn20FMLfqXQOcap7DHUJwAAVCPnWAo3lwSafFogCc6N+fjlNPOVypw18C3RHn
         AZBw==
X-Gm-Message-State: AOJu0YxG3+yVs0/0I6veI0nQtndPO1WFKHGMtjgD309OkxdiKK6u4xhi
	USEYSQctIUcB7ni95gYPZHNl4o5OJBiUgqwzKvov1PT1JMzN08rsecz2c5Cz8JBm49TVW+mWEoY
	m6jTBu9/eK7k43ZMgTzWEVv1DgNfrh7hQCnHkhRuauKO1ih+DsPNz1V6IUWqZ8ATbHt6SlGDghI
	6o9D5clv85SesSV34aJNZfeQlYc9p9YyqlSKQBihPkMeJ/GQ==
X-Gm-Gg: ASbGncurZRpcqALRjlAIzdOgKysLs/e3buY2VQbOFwsAdWCxGo++arExIZbPC+4AOq1
	1mjtORJUxucmgrrXpJC5PeBuoYApEOP5Ma3Rv0MZaeMNno+1BKijkPTnWcgh6I3bnxmc0JFQKfM
	MoQXKBXY7HDVJ3iMmvdsgnUr9Enx3+hTHi7qi0MYl3ZFFeu48EcgFt65woZnUp5SUHaqU4KOtBj
	GoVa6WzWichmtq3E3SDs8eY6TtcWrcPHu10iK6rid1/OD3dMpJp+ZbBDsh8+gi8m6hrFC4u/keC
	mFjkbvLiy4uZ+KBhnoppHutrA7UgeY7BMVzCy/7C11F0uRxYw/KGBqCV9HFvewawE34XZcQT0O9
	B4KO/oVU0038g
X-Google-Smtp-Source: AGHT+IEw45sk/ysq7LHq5vslS/c8CJgCz9NsblhIJ3xgbR3XQscoOSPa3GYbB+YVIlITwKAFvOs85w==
X-Received: by 2002:a05:6a21:4a8c:b0:21f:62e7:cd2d with SMTP id adf61e73a8af0-222d7eee64emr3408247637.34.1751433927266;
        Tue, 01 Jul 2025 22:25:27 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b34e301f704sm11878325a12.18.2025.07.01.22.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:25:26 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	ashishk@purestorage.com,
	macro@orcam.me.uk,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Tue,  1 Jul 2025 23:24:28 -0600
Message-ID: <20250702052430.13716-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Second iteration fixes a typo with missing close parenthesis.
Restricting the pcie_failed_link_retrain quirk to ASM2824.

Matthew W Carlis (1):
  PCI: pcie_failed_link_retrain() return if dev is not ASM2824

 drivers/pci/quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.46.0


