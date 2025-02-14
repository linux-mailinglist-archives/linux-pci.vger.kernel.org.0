Return-Path: <linux-pci+bounces-21500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17FA364C6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF2B17116D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D740264A80;
	Fri, 14 Feb 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rpmpuhi/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA2267B15
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554794; cv=none; b=nFGKiFt+5VHQP7EqGmJxxoTIhnGgyyuupBt5Kg+UDAboB6XHD7NAPWEe3lar7oGl71LiecVtc7oBXI1LkRErBPCWJEtQvNDTAWFVHNGt08fpqdo6u5x767iP9CqqGK7Vccs82fGT4Ajm0f9edgqfhqMj4qU7WbsqBAS7gtOkTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554794; c=relaxed/simple;
	bh=xtjOZepvLWucE2YN/q7n9CFllGSrwG6Q7wsBi8+kBdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKCChVhjfDOWMeiwjFJMj4qlwmCtIRRPYuBhuTcFNO5v18kNHh9ycqltugZVdP2v4b2IvTth9zAK83tLjlHtVjE4Vcmwy65OvCDoXIxW+Z0hGx4NbeSyixXTAz5xDmRipIuKX9HyIX7dNrQRuT/rl8BnV1WLXm37XMwwLEOoC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rpmpuhi/; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5fcb2901eb3so916231eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554791; x=1740159591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsGKDfz7/jaPpiyMeSia4iIgjyJuYXTHPPt+s6+yzBM=;
        b=Rpmpuhi/MiLe+vKJ/i4KbdHvKkcpdUcwCWs7S/qRs0D8jm2rs1SQlPoOY7ewTKQPmJ
         IBPFrwm+vKJbNOskdyxCdZjEioA5ChGv2y4jNjIj07uEMbQ4QfFVgRaCO2BGjwJUcIce
         7J4C5l/49kW5hkZB7+pLbDKsz07UTwZYuZpCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554791; x=1740159591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsGKDfz7/jaPpiyMeSia4iIgjyJuYXTHPPt+s6+yzBM=;
        b=Ehh6eE9O6hRqaVd7gq0YaAL2XLce1AWI1zTcmlGa5qFeune1nLrkTDQLZ4G37H8uzf
         VMwfkIxVzX6FPi0DQ8Iq1bqpc8KBKlobFP6bLzUZdQgEoiWvF9hY75uvwVjZ67Yk8I72
         i2c1D+UGLUH7DfHGNYKeRYxzG8x+mL0GOYC5VyPrfviBU3miYRIGsClS0uYPtrphu9A3
         czYpUkvZEyFskmhi6KyZ9TtQ20T1YWEvV76wwOJYlDJkZzxQQWJY2wUXTuNH5CsFYqbl
         68lOzq4Va6q01kKk8rg3ILKzWI/fE2/WGuEGeNpbAjlTJFyRyxcwo4X/OE7ws6UKoHw5
         NpiQ==
X-Gm-Message-State: AOJu0YyNJh318xi1TpS0hpL0SbyrDTe4aU3R+cN1LNhkh9Cjm1SzQC/J
	JFoqWgoLO4i1Fw26Ua+1AzisBBJBcmgYhXnUz+fN3deTBX6GUPNftj8huxUWUdS+s18lcF1n8On
	a7G34HSdAgFc3Q0oIRd+5ZrxpoY5zB7YFGS02hLffGFOOOaUaRMpZ1f15Ztooi8wZSreepnV0LZ
	Lr78MUApSmEwd96YZR45TDrDglKowkVNnxlR/xK7vlNcD/pYfJ
X-Gm-Gg: ASbGnctb5uWsZNlEAA17LaIzb6HzXd4oflWAxsEpmQ1iyEUE1Cur9Pb19gRR9RKocDR
	rglmVJwLn2OpV9ej82G/oMY9pBKhlOeJMSSTnL38IYkbGqjgpRcW5Amgz6tgkdxcuMGZFVxNCxy
	gZQ7DX+Tb9niZzU2FcyRlpk74z09NWqZYq0ELpSWTqOunavMrCQDxqDxSjXc7WI/EeB+Sz53ZUI
	j2inggDJ5HSN8QTBG3us9XPnxYd0DgUiyZJQVTtYlcCDkvcN8PaGM5X+BqPQYSZa0oKrxopa8xi
	uGwnz56VbQ5KsFxMufMdARy+3xheZo1WIazvUEKtnG6terIaoH8pScFef8KYwL7if4whH8M=
X-Google-Smtp-Source: AGHT+IGDUd5DZupELTIH1ZNHElTcoWH0Jy+aI2jHUJxfXC+3Fwg31SHzk1pcdrf8sVKAQ1860xNHbQ==
X-Received: by 2002:a05:6820:229d:b0:5fc:89d9:a050 with SMTP id 006d021491bc7-5fcc55ce468mr11226eaf.1.1739554791273;
        Fri, 14 Feb 2025 09:39:51 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:39:49 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 0/8] PCI: brcmstb: Misc small tweaks and fixes
Date: Fri, 14 Feb 2025 12:39:28 -0500
Message-ID: <20250214173944.47506-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V2: Changes from V1

  o All Commits: Wrap all commit messages to 75 cols (Bjorn)
  o Commit: Refactor max speed limit functionality
    -- Split into three commits (Bjorn)
  o Commit: "Fix error path upon call of regulator_bulk_get()"
    -- Changed so regulator_bulk_xxx() funcs do not get called with
       num_regulators==0 (Bjorn)
  o Commit: "Fix potential premature regluator disabling"
    -- s/regluator/regulator/ (Bjorn)
  o Commit: "Cast an int variable to an irq_hw_number_t"
    -- Change commit subject line (Stephan)


V1:

  Six small fixes and improvements for the driver.  This may be applied
  before or after Stan's V5 [1] on pci-next (they should not conflict).

  [1] https://lore.kernel.org/linux-pci/20250127113251.b2tqacoalcjrtcap@localhost.localdomain/T/#rfe31466507e3e540ad681278924e0ae4e0b8a727


Jim Quinlan (8):
  PCI: brcmstb: Set gen limitation before link, not after
  PCI: brcmstb: Write to internal register to change link cap
  PCI: brcmstb: Do not assume that reg field starts at LSB
  PCI: brcmstb: Fix error path upon call of regulator_bulk_get()
  PCI: brcmstb: Fix potential premature regulator disabling
  PCI: brcmstb: Use same constant table for config space access
  PCI: brcmstb: Make two changes in MDIO register fields
  PCI: brcmstb: Clarify conversion of irq_domain_set_info() param

 drivers/pci/controller/pcie-brcmstb.c | 40 ++++++++++++++-------------
 1 file changed, 21 insertions(+), 19 deletions(-)


base-commit: 647d69605c70368d54fc012fce8a43e8e5955b04
prerequisite-patch-id: 17728ad3425bcbd72e06271f2537a5aeec9ec0f2
prerequisite-patch-id: fab98130bbf5ffc881704b02153e387aa4a08e87
prerequisite-patch-id: 0d2d8d02821ca742aed46f16e9ed60db2ead359d
prerequisite-patch-id: 8cddbbc69bd26c0284784d29f5abcc30db1c8327
prerequisite-patch-id: b5d9165e3627079a44c08faaa306c17ef735fc9f
prerequisite-patch-id: 95858e79f69b693a7955cf12549ff1ce8df27699
prerequisite-patch-id: cc66e7df1fc7acef4ce10f99033a39359b6d57ab
prerequisite-patch-id: af00ddbf164acf1742020616d8c0f05cbd5c1fa0
prerequisite-patch-id: e37b800216e856a32ec7e7231d5191f17026ebc9
prerequisite-patch-id: edeed902cf9a962e3431132dacbd95781b1cf970
prerequisite-patch-id: da4f731901ffc44f2f1a3e69c1c35213d531fcae
-- 
2.43.0


