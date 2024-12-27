Return-Path: <linux-pci+bounces-19070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2529FD0F4
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 08:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF43163A7A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 07:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5067C12CD8B;
	Fri, 27 Dec 2024 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pc2OwAJH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB773596E;
	Fri, 27 Dec 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735283961; cv=none; b=BYhESBz40jByD8d3RNkEqk0XFLCFC1AFS9ZlOqT1WVvBeQLO0V73urjMnOR+vXvXpuMGYfPJGMSLiqcE/50cw+lBvocWEf/1yLOWgFmeld1yMTo2pXIqlXV4i7WMehFekynL80YewKUldhRwqVpwdlOgJbLaf9AwNSuo1eRw3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735283961; c=relaxed/simple;
	bh=eCnHkf5RYGu61gOb+4MCbKrF5lSToHoK6hGKeh2JC7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFGXurCCaK8olhQoJruj29/DxoBJ8m1XW8EMlOE1YX3WrtGbr+CNVxScu7wENa6VA8csUarnkYhBUz8d3K9Mag3J2qQwwQWjXHq6pXpSDAKH0dUwSYpn6xyKjJIpmap8wDZZOhs2oRN7rgRv/AdfpGDGtc3VXqYpOIkvRupgupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pc2OwAJH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so8518160a91.1;
        Thu, 26 Dec 2024 23:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735283959; x=1735888759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnuLkUZSsf9O56DvJZoknEy7hBumP3/+WgCLz39mvuk=;
        b=Pc2OwAJHDCqymYTNwd9qepSbsnpvzWeLB9Gw5XOrz8wCKgqXPMSVBAF0c7YFq8wWio
         KH5AmYmbcENBl2Zm00fVmLWsmhmFzLrtFUIMKDJa72W/YPTLuRCrmyjWFpNPYAgjEU2Q
         rylDEcP5lW8K9DEPaWjqDlEkY5FI8SH6tccJ1FbIrBvCqnqD5xBEWWlzn1LKFKbMk/xH
         TuJiiRIiQFkukKi/UmnpHrFalpAwBS+eOEDyedlF2Fitnmg9Fsx7C6H2l/WZ5wC2WGTJ
         zbJLetCp3bDW1Sk/tZGR/2NaUkQTuzGHAHxXIFNuyoiHkKQQtre6dvkyd+xG++07PZEB
         tMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735283959; x=1735888759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnuLkUZSsf9O56DvJZoknEy7hBumP3/+WgCLz39mvuk=;
        b=OLiwyKXmRLjsk92/nSsAJo5T0eLaL1FLk2LeNxWYQ81nhelChZIyCoMk20lbme40i3
         R7qVLLT6iPoHiRIrTvfwhSwGWngxCVMZPZ8fSbwYdIIMKBRKSwGYWaBMdmXkWHv9DUvS
         ygEhFa8Iofgali9Ree+A7AjP8BIGC/zR61uqRN4df03Wf7xhjPkZ/HF/bI+SE7vrghrn
         zB5JrRhapVNrzSnqEPzWSQzusE5w8hw6gIrj7ausi8sbCzNa3Ba6dqahDwQ/hXI9DRc7
         zd0bYuXBoWI0+DsG8o2FgCZKHdAaYEyTWFce0tQH6KGmBvoIGFb3V2LGWeOM9ODZF1GV
         FeOA==
X-Forwarded-Encrypted: i=1; AJvYcCU7wZ5xa3jR7tr0CK7jIMgIZmg2r4N5AAeLu6VIOy/ETm8tmmmxjQ6NO1GsdgONJlRewkH04elEqArm@vger.kernel.org, AJvYcCX4of4BfwYMdTR2tajVxR1+l3tdLSDDaLo0IEwk/byyr92CZDoh92fNlrRcocYPo9oAJhlPL5j2JnfISBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDjzyhUqSkoaJCtJHC2qHPLCLRuVqsPT05pwHZXjdAGet5sDw
	GsLlCJryLzzYnLSVcI1E1eBpZisNbGGmBO1p1rcdeQH2Q2O+FTV3
X-Gm-Gg: ASbGncuchz/vXTHholFybIVmJouwLiKpHJLq4y5kUrPR2EdwQViCRQGkQXMxmd/NEQn
	+mqY8wIPDVJTN6w8nvSfJ6lSbDcdIcHZTna/8tWubFzxKPM/qwQWLcN5EA35uFwScv5mRnI+323
	MUWPb1TivgoP3Ih0UNxh+vM3sOTNa335rZaqHIzHI5Z2inCF9qWdVdaU9pGYQj9qykrGrGDAHGi
	C5W8OFi7z5tOGdHoha70Z/g+wYoneVDJmOSQaP68nGQLFo6egd2qKvEujquiXXedh74WGDiljE=
X-Google-Smtp-Source: AGHT+IE4gAS771EocxnX0fNLgBOnvBM1JMpmjqOEkQXBE1ofvVqYAzSgusfEUdwpY5nhbywfqhyo0w==
X-Received: by 2002:a17:90b:2e4a:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-2f452e38d0emr40078681a91.20.1735283959098;
        Thu, 26 Dec 2024 23:19:19 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:45c8:7d73:b364:3050:fc3a:14f7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477c84d0sm15195994a91.14.2024.12.26.23.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 23:19:18 -0800 (PST)
From: Atharva Tiwari <evepolonium@gmail.com>
To: 
Cc: evepolonium@gmail.com,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/AER:Add error message when unable to handle additional devices
Date: Fri, 27 Dec 2024 12:49:10 +0530
Message-Id: <20241227071910.1719-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Log an error message in `find_device_iter'
when the system cannot handle more error devices.

Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
---
 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 34ce9f834d0c..04743617202e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -886,7 +886,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
 		/* List this device */
 		if (add_error_device(e_info, dev)) {
 			/* We cannot handle more... Stop iteration */
-			/* TODO: Should print error message here? */
+			pr_err("PCI: Unable to handle additional error devices\n");
 			return 1;
 		}
 
-- 
2.39.5


