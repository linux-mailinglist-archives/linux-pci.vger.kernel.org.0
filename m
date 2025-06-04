Return-Path: <linux-pci+bounces-28961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA3CACDD81
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5633E17838E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3A28E5EF;
	Wed,  4 Jun 2025 12:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2RlP4WX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CBF1E501C
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038927; cv=none; b=lpEkBe/Wn+zVv8LrGCWReZzvHSfs77GVLFSDYm4IGVuwG74YBVDh000CVyTpPUS/nv2XPJu3CyREW/KaSK0EpZBVKw1RCxmOGWsluQLT9t1K9F8vETY5COb9Lc6jUV0ZvHac2Uny6/GDEP+1VwrXfA160W1TfJLZHjBN4NmDs58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038927; c=relaxed/simple;
	bh=tB3Ex4WI5fJpbmaniueAkEOhEZ2gbuotRgFgHTCZSVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rCr1KFCx0qwn0iNC+U2LAgDwbPf+huVS0RNBpDrVWcpPmdBgkzOfjR6gd1v9qBJckaaFaVoBSoJu4lxvqya0Xi4S/whIcdYBBKXtjgq4OdPZGVQ8YJ+Ln2iYmltRLb8QWaGhtbtvAsJpvUf0Pt/l03ZNiTz7zsk4vdrMSInDJ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2RlP4WX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5099860b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749038925; x=1749643725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nkln9+TL3dVzqnRHny1SDfLruPjSMpepjUfV+2UY4FY=;
        b=G2RlP4WX/N/oRzrmNLh5wE0Ab5/oiYAK2vnVQFciTHMBJXaXHBQVdAJ8HSZ+BbSEhJ
         WA77AfIFiWGzHQKlYeNtz7N5PIOyRbP5rASR7wo518lUNoq23RwbcvqIKWgNW75o22Q4
         cJws1sflBnyBBvoYJ0/+rRSVaIWJlRyXS92PXyPIAH5mJkRmmsgCrH+mG2+TIqYvrMJY
         YprRTV6H+pcWiLM2pi/oacKoiJDxxzr1vMiw/pjRFl6j+lYnV/3mNm2tcx1Z99oAV63n
         SkmtKGce7W/DKLC80DAlSqrdnUITDUao5NpblojeMWQSdxjzRtdhT1VwQSryw+CEaxHn
         vHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749038925; x=1749643725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nkln9+TL3dVzqnRHny1SDfLruPjSMpepjUfV+2UY4FY=;
        b=p/tXw2veIZqTjXk8EIdmI7PdEpN/O0Sb8WLgaD5oh0rFgzNx8khTXGorMJifG7QWtO
         U+b2wcoq5nTUQ555I8XjEwHh7aYU1tJ2ekVbxhHaUTauJqxyjYCQ6HUDPzQ4Fclfc0/y
         Z6CPEmKg6NWSgmPiHvNxSYTZwTGkF3FMzWbHQZE392u/UIqeczRpJa5k98vvHPi2CpUs
         KvR9jjgzcB38LYxeR36lbU4jfi86RwlAMnJQY4NkxyDa3nanpyswtwyTSFa7TUf4u9W6
         XS8pvuQhIyiCEBXMuTtEJD2ZcTKT9fmQzoOOYaOopw8gKOpDIxH656Al99EY6Tjfwm8L
         hupg==
X-Gm-Message-State: AOJu0Yw5uivs+IK+QdrnQM5g1HdrosXvojBfT6CxIwMhI4KBaZAZzn+Y
	3HZnIFpDisotk2ajjU/dolvp932DefzY3POc51vmH8Kxpg6EPqEvbv00V7QZxo7Tqw==
X-Gm-Gg: ASbGncsM51NULc6dHYTF4bppcggOj4rNeAAfA57e5I2+FARTfDKXKZa7fSUNYUajKXb
	NYsWVzV44KtERs8A/zWW48GYvLSy/wVMixw97yKr4RN8RrV3c1t8yFMIfXc9o6TqNWTP0rz99jG
	FFOW5HmqEYNGE2hmHCSJMxD2Q5kNOVuKBuPRzBbxIt6347iLtfW86RFpC0u7GOjlNd9HtCNsdU8
	+KlXxoV1uFyfWYTO6xxSdgIe2tBel6/noskmdpycv+stVWVBUXbsOBC1Svw4qCoQzOpI6wWOqYC
	JyyqCMwGf69Yluf/Tjk5lXmZdZ9TbqfvfSGaUKFZrM43O/2vVT/L1+1sULiHQB0u
X-Google-Smtp-Source: AGHT+IEklUjzZitqK/mgd1QYNqhN2rQnnl8mC2rRk3Ch1E2YSkU7gd9atQTFVTrlEn5riosDI1nryQ==
X-Received: by 2002:a05:6a00:238d:b0:746:2ad2:f38d with SMTP id d2e1a72fcca58-7480b401442mr3535067b3a.13.1749038924694;
        Wed, 04 Jun 2025 05:08:44 -0700 (PDT)
Received: from thinkpad.. ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafaebsm11034942b3a.87.2025.06.04.05.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:08:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Update my e-mail address
Date: Wed,  4 Jun 2025 17:38:29 +0530
Message-ID: <20250604120833.32791-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

My Linaro e-mail is going to bounce soon. So update the MAINTAINERS file to use
my kernel.org alias and also add a mailmap entry to map the Linaro email to the
same.

@Bjorn H: Could you please merge this series via PCI tree?

- Mani

Manivannan Sadhasivam (2):
  MAINTAINERS: Update the e-mail address of Manivannan Sadhasivam
  mailmap: Add a new entry for Manivannan Sadhasivam

 .mailmap    |  1 +
 MAINTAINERS | 38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

-- 
2.43.0


