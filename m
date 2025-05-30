Return-Path: <linux-pci+bounces-28735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE5AC97C9
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 00:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113FA503507
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51E2882A2;
	Fri, 30 May 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L2F9PIFq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE5280339
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748644844; cv=none; b=Bj/k4INjDzh2IqM1imlbViM8dMQ4caDq0HYezP90fLWmXyhNsI40QHp5PRcq2tNwQniXdNPKkx+fVOoVvMQTPHyuwsdx5XhMdH0FJvHWNgqaLxQdigUsXZJsWOoBPbVwVw0Jqfc8Zdha+RDAo7ItiLeWruX+Tp2LmdiIc2z+Kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748644844; c=relaxed/simple;
	bh=v9IOZt9qHGKgp78Ef+68zRxwUDTcYE0bI2uCER1pMZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXT4uBtyQoC1OT4ePq+yEcNAOywzeOYpZmXgwNs+c8/JJkvMiXhfGTQs14Rc8ghBfl40cEbsGwqtR8yELbXPieQ8gccEEeSnfjseZRKRQACXTptgyGTXAJGyN8FHQK1LWko3x/4Np929JOoy3eXaMXCjQP2MoR+vWHevflSBGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L2F9PIFq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2351ffb669cso18604345ad.2
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748644841; x=1749249641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1drmllmtmwtWNasJJpvTqgcFCz1TJ/ySV8IFsfDlfk=;
        b=L2F9PIFqDmX7zjxhYLVjMP3i0DnXLzT/sNR7sg3aftg1OFCL2VBrAVAwqwOgv+D1TE
         k243xCvis+Bs8c8Ne2dWEeg8oU3Rj9lbNGfd4EVDGnsWtYjzHhVgnG+IBfX33TUfeUBu
         arbGrGmi2cZV/gv2uLK/JzU8WRc0GyEEWqZlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748644841; x=1749249641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1drmllmtmwtWNasJJpvTqgcFCz1TJ/ySV8IFsfDlfk=;
        b=JSO3UJ6qvAHdlj9szqpim/yhVKe0ZgsIVQkHD4wBc26RJUlWnggMtgkLClqve7Lpfk
         3FV4yYAteU7bxUJaU5/FmQ8+ExW4LyhY0zcU7/BoL3tkYeKiT7Ntf9Wrqc190XldYS8S
         BKr0eNncfPl1m54sWSzUi+b3PMBC3zM7VLrBMEfF97zV6BKhuJirBirOwOWhDcDQ9EP8
         IAu5A0DCnE4zCh6XO7ld2E40lrjDn2DkH9Q6EFbns4hH3c09wuxfbDh66pYZPKeDU806
         VswOchAURFTYjWj7+sbAU2G/mOuhxGEwyAXAA2yUoY7XFUslncspk6SOTruYtqahCNWW
         roOw==
X-Gm-Message-State: AOJu0Yw5nPz58qtWJnxl4kMOzyYV9jK4qq9qqXNHQYORe0kZKjz+Vfzr
	khlMXN10o05HwEHkcGzDYmaD6z2R2RZJCgrGDfZ0p4jgPrkpQjmcMoK54n7eIV5KmuR1I3n3awS
	F+z51F3aM1yepVjUa/yZdhi3ts5a2melebn9rgKC8BAkL4cQe90V+CcxC8JjWAxLl/Nu9xn6czS
	hGaruU8PGTpBvm/xgKyF+Lyay2GQ7jv+Zd9RT/VjiXJu8+dpgKqDF+
X-Gm-Gg: ASbGncvjWHeHYdocGxryDnZ3tfUFtMQXSfZselAI75+7TrvyIlAz8zMiU4FsGppHjVG
	OhbEHfgSN/FfngAL0rpOaCBiAFu2uR/L1ErDZQMbIQIoQQ0M+OS6wuCPNxtmjTWwJvrDb7TKPmK
	8LnqvdwcO7oFXLurBywVTzc1KeA0Oac5Fm5kdgl3hjjip7rU6Cqq5aE0CH4+14LfikK/jhwcxXu
	bXeh2lykLotUwQCjtY6fWptFhuWpK184NdffqUe77Jwe6ZZrqyvqaMiWjUmGHcoym6iBzBoc7hg
	j/5Bj3UlnCUbK2MSrlo3l8lPHyN/Cx9OAwU1hEABYAk4GV/g7HFK33CGrA8hAvIlZtZr2qB5Cdm
	MTtmwlOi7WW7yOE/4YLFztzaQBPx2am4=
X-Google-Smtp-Source: AGHT+IEjX5DIunGuGQempttaCvqzE5hKj7Lhn61f4N914bLVvv2ywe+jCdSk6DPyHm6F+JX3bD1s6A==
X-Received: by 2002:a17:903:b0e:b0:234:eadc:c0b4 with SMTP id d9443c01a7336-2352a08997fmr77984725ad.44.1748644841428;
        Fri, 30 May 2025 15:40:41 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf523esm33109385ad.170.2025.05.30.15.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 15:40:40 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 0/2] PCI: brcmstb: Use "num-lanes" DT property if present
Date: Fri, 30 May 2025 18:40:31 -0400
Message-ID: <20250530224035.41886-1-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
  -- DT bindings: Add default, maximum values for 'num-lanes' (Rob)
  -- Add 'if' clause to clamp maximum requested num-lanes


v1: original

Jim Quinlan (2):
  dt-bindings: PCI: brcm,stb-pcie: Add num-lanes property
  PCI: brcmstb: Use "num-lanes" DT property if present

 .../bindings/pci/brcm,stb-pcie.yaml           |  4 +++
 drivers/pci/controller/pcie-brcmstb.c         | 26 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)


base-commit: 01f95500a162fca88cefab9ed64ceded5afabc12
-- 
2.43.0


