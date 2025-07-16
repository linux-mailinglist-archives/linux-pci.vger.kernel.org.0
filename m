Return-Path: <linux-pci+bounces-32320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6F5B07D90
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32697A6BFE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1CE29A333;
	Wed, 16 Jul 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MxYqXhFu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805E13D503
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693980; cv=none; b=knt69fzICRmRNlRySh11bBDQgrHxbqIIvBUhGGUZYkLVnpUIRLV+5aResB4Ryris3NyeH8EjfA5GFBZDVSaBZMz0fPNXV9G89cWm9uB3R8m/HfYW5Fl1tEVaDVmm559PmmExxQXrxGvPYMSqdNKNjzcLtsH5XwgDykijZBo1WlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693980; c=relaxed/simple;
	bh=YRhlB7nAMPPhyaxFpFq5aPkO8P8blZ8qlNUZiExltUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvoke33E+yVjBHHvS6uwce5Kfk64HKfDiUTSRzgWmTUsWpTt6XpoG/6HZD/jPl+le1drtNN5b2s/17XbReyJoXIsXVtLmJIa9bLi/4q/mq6g4Jlw/0SiMuW6SE1RicyqC2hQrH34iqzCGTASzPLat1lLt5ws5++H6WeP+rcYex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MxYqXhFu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-236192f8770so2360555ad.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752693977; x=1753298777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5oB3177mVfwzhd2s5e/zGR5kP2gqlyjHcpfAavJaXQ=;
        b=MxYqXhFupCOZOoGu9yUe49iW5yMF+DGAPr5ST9IyPuNLMa7goU1X1AdsXILPFmTV/P
         62KLLs2JtG3ee+55KMsssxfom5FWekMgF85wof9iIkwuVNaPs93k/wyt8XvNOwwN1UQ0
         gTCrS/C8io5jFf76x9zIvvC3xrRhNfFbfpXeFa1X8eLkzjb6ilfU8/WhqEiqj7QeldpE
         blEhWwMxKZ6y98+P9rRhwi6+yXs0I3CxGM0fpTM3Zf+FHBbSu9Du5IpUFehSpwv4pt+1
         Hf23yvQ3NO0dQ70JYEfta3ezLAyVq7usuPjbxRjFbJsm8eb4a5gzFk86KxhytrWgfBAt
         fxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752693977; x=1753298777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5oB3177mVfwzhd2s5e/zGR5kP2gqlyjHcpfAavJaXQ=;
        b=Gq/L0DSRN5F5pNDgyAX7MA8NREnrfUGrcPQAspVwFFJeiplw/f/kq0o5n9GjjEo4it
         MkYRBR9H9KfnmYo16ajsf0PN4A1OSjTybaY1A8PBzsIG5FfeD3SpoY2xtU62pz4JhwpS
         nwYHbBdeGAYaJLgEaan8ytSKXQHwCRKgz1iaBBX2ix6fi4ATOoGi8RefBcHYv3OhKUs6
         c5QfkjCa6uFq1JYrscj2qPZ1Kf3hkPDI9SnpHQH24LmphckB5mJ+9lRypn+dfTB8/n1/
         nDDSPPuma+WyOSY2mM052aucuO9a53aER32noQ5DlkynUjRpHvbkYuVjQGobMsTBgnQh
         iSQQ==
X-Gm-Message-State: AOJu0Yw7ctKdp7d+ORWlDEuwc+AcMOj/PJVXasNit3DfDvlTJ16YEqQB
	HHUa+auWH+YY3JBeinuMpJjSBC44Zd74tb9eF/UREBr2R4Ie2vvNLyFKSSPeoIzEHVN5+t8C5KD
	EmAjZVzr1o6HmAA35Xu+Sc+mVEb6Ovx1o0SJtkFQ+1jcBpzKIkUoxhJtFNKsrmkLCFVTvHWBhp9
	drUqm6/5zvA6kHDEDv3evWyUFc84TFi63AK1sy6CHELcaE7w==
X-Gm-Gg: ASbGncuzLDL9zjsy3t+1FtMy7KYKwYpJKODRrT4k6grO6wFPiUpHNuk8sYyyDNQBYra
	o0NYDbGCFUjsZMxYVy79PBlZIKukFB/Fhirm8b1wyhRVD7wFmvfylsrmkN1Qx0wm+BSdFIiarm1
	t27Ct1+LYw+bTfdGiUxYSq8UXN2OyD21YmP0Xrj7ke8JlkJZ66GZ78R+keSK52vNk9NoYCRoAge
	DVZ1+hIgzBZKZMqrZk3GilCY9b5Mo+WXvaE3oXnmlrUGTWG9LqEnAWM3OlylEF3XMhSADmEhKVT
	GcfodZ2+dln1u8DV9fUgjTjJLrBwNIAsjBJHDfgCXaWutwATvkp6a5v1d/7oqaSSSwDz8ijAsYt
	s7ApujdQ8k7XQOoT61rXTPQjz3ZJBqe1djhdxqUWBLqdRDRnp
X-Google-Smtp-Source: AGHT+IF6h/+vPxz8yapAnocrwuLe47fCPmeOuNmfj+F07Pfd7GHTDMCMheIxW1FnUP7Db5LIyTMZCQ==
X-Received: by 2002:a17:902:c94b:b0:235:278c:7d06 with SMTP id d9443c01a7336-23e2f6d2420mr7036365ad.8.1752693976961;
        Wed, 16 Jul 2025 12:26:16 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de42b28a6sm134716765ad.87.2025.07.16.12.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 12:26:16 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	ashishk@purestorage.com,
	macro@orcam.me.uk,
	bamstadt@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 0/1] PCI: Reset LBMS state before clearing DPC status.
Date: Wed, 16 Jul 2025 13:25:45 -0600
Message-ID: <20250716192546.16942-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have observed DPC setting LBMS and previous assertions of LBMS being
carried into wait for secondary bus. When this happens it is possible
for the link to be forced to 2.5GT/s if the EP is slow to enter link
training. Waiting for secondary bus after clearing DPC status should
give the link a "fresh start" from the perspective of LBMS tracking.
Therefore DPC should reset LBMS state before clearing DPC status.

Matthew W Carlis (1):
  PCI: Reset LBMS state before clearing DPC status.

 drivers/pci/pcie/dpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.46.0


