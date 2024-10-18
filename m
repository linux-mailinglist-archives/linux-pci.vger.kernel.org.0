Return-Path: <linux-pci+bounces-14879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8687B9A45D2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 20:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472052821CD
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE6A20CCF3;
	Fri, 18 Oct 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OBafmOnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E12040B2
	for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275776; cv=none; b=MsNRloR+JB88/wVJJU7mWS3bkoU5zVftM8hP6dibzN217eA/L/5BoUvNLOJivhar5DoueAylOJS79ny5ZJfBCcz65FmOxEhMuJrurE7SIQDgeVmqNObiPOIuGz/lyb54+7MHMAOu2Hcl5jf1TUJa2ZogbWLd+vTspOlPq55L06U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275776; c=relaxed/simple;
	bh=YPE2wfgFUpfGjCt7I7YEVirC1JDFDUT1zUe9c6pGcAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDPC0tui4uKb+9BkR89hCZh07AOEaC2JLzySedm0n6cu7zLd0ZKfiKv92S8CMENCtWILB39omKB13Zt5s4u3HJoUqJXYIWK18ztaSxKww9eU81i9jsKa7xWtj771SlbDnCoBSKIpZMMqpVPERma6dGPwbSFtclOYm+322qJCvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OBafmOnS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbd00dd21cso13644356d6.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Oct 2024 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729275772; x=1729880572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QoeLr+Env9OxeJz6wgxQ3SDKr6mSRXZtgxBKlhvoc7U=;
        b=OBafmOnS/6vCZwnDJ7rIbRgB33qnP0gg081Mr/jH6SNDvwfvMY+DC4asd6nBk3HfEZ
         mJL/WGoJLn7ujKqgzzfJxlm1XDsF+w+kwIklN0XHERx1L+xpHGgJ56GRygbuZrFcIlUL
         7xEY/3sg+Q0fVYUjOu26CM2vZVL0nBXqoDTGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729275772; x=1729880572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoeLr+Env9OxeJz6wgxQ3SDKr6mSRXZtgxBKlhvoc7U=;
        b=B0ozcxAnDSbKOLLsx6USW7+UkekDWTdv0FOJveEhCyS/rwfa57dsu1YezoN+tB56lp
         NI/cm5ctYl8ShrOCUG7N/BRnUPDpSMFB70bku4LpkkkXXCWw/PoIxwJdc46zcIrVOFBE
         TzT+Zwj74kCYwfQ5MmEtJmOffZ2iz3jgs2ZDCsYlFL6nvdF262RbwKt88GoPaqR5rjmw
         w/a0x/eOEAnuONiylgLI2p7g4KQohuE/QjJFV04zk8JWbHFMWi5o4PTivL8llbPcOn2G
         Q5f3eT4J9+JcQFRGktuKMdNuvjsTIyrIJA+yIxbaLH73bU+6a+kn8Uzm6UPUtcrGnA4r
         AXAQ==
X-Gm-Message-State: AOJu0Yyc9hfKBXytvAF3fz+SYh8qcxksP0cN+WC3uU0UEr2ObbOZEks4
	rcSCBKXki1UmQ5GZzHfArkGhcm4Q9zw43M9NMUl8IgRRVUzD5rtflk80fPQaYeozrIHauuv1FGF
	BAWyjYZEYjQsGOxfS5uQ3noTJekYinvHflcAAdITXCTG5BXgG4w4SafLxFuOqmsRyV4Qg0yQBmL
	+hPmdofybXVMLWNEj8n0n0kg8RO54eNT0yg33JXgKWhVeoBusU
X-Google-Smtp-Source: AGHT+IHc/HKas0ASDn+E7LNSiE4UY9i52NAvrSum+6BgLJ0cc3r86rr1PHaN99ZIt0zPccg2V59prQ==
X-Received: by 2002:a05:6214:4984:b0:6cb:d583:3765 with SMTP id 6a1803df08f44-6cde14c2817mr34582426d6.1.1729275770517;
        Fri, 18 Oct 2024 11:22:50 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114d782sm9307616d6.46.2024.10.18.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 11:22:49 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 0/1] RFC: Need feedback on PCI dt binding property
Date: Fri, 18 Oct 2024 14:22:44 -0400
Message-ID: <20241018182247.41130-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'd like to get early feedback on a dt binding property.  We cannot
submit the code with it as there is a backlog of commits that must
be submitted first.  We are just looking for some initial comments.

Jim Quinlan (1):
  RFC: dt bindings: Add property "brcm,gen3-eq-presets"

 .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.43.0


