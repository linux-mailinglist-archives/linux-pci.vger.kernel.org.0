Return-Path: <linux-pci+bounces-44275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11836D02531
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 12:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0626319411D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F9E40B6C3;
	Thu,  8 Jan 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKgpf5LT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4983DA7DD
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868674; cv=none; b=uh9iDRe9u+nah9qJXRr64s/r/YOG3hc4ox7J64ZqlXyZ9btnh5n5u/LMvtCAPtiiL12VJBg2XOmMGqaKIrpforHWRtjvDUsF3FtjfNnclAJ++GxOs+tMuDIYHKhFOMgzraBqJNnm+oSiVuBSV+uzR9BuqfzL/N0I0uoX+ehNYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868674; c=relaxed/simple;
	bh=8XgrIXfTIHEeqcAXLdtftIJs4zNxs/4EHKGLYJ7O0pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJUfY1Jze8m3oTVdDTxTykv3A8NT+4LnkIt/rAea9t0UaRIA2vWCgRdXKsZ0meJXMAllydOiZVoM4w/BdmdMHpJIXYTu0CSlMQMEHsMUCxP+P0OKe+chdFhkOZB760Flcs7i4tV8kaOZV1Ty8rYLeLDuSaoSZ44ZXi466mU5H3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKgpf5LT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29f0f875bc5so28596115ad.3
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767868665; x=1768473465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XgrIXfTIHEeqcAXLdtftIJs4zNxs/4EHKGLYJ7O0pY=;
        b=fKgpf5LTgRChkCQD+bmtAWGtBS0B1WidIjV25cgiZ8Lyu70BPvc5RC4QYllUh+/uiZ
         zziMq1O8lmHuYHpKbBWk0o2flZ7R1IaERGVTzj1+aZxSk5dG5wCEA6x/tlon7ocVuO6b
         wCimaYQdICxPcSVpBeNdwQRB9s67jbboLFiNDRvvIznmLIqSDHGmWeb97d9X6MbNiSv6
         h39Nzx/s1bq0A6egxLx/no63AC1NzagzOZn2qP0o0FIf9sez5RoUJcCXwXRXjwMDWjq+
         zCb3xOYwa5i8PT1TG8zQmZ3oVxeanoV5Uw5/jM3M9t3rgbRnkjWZgoSxyHgeWXQB3Q9+
         psQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868665; x=1768473465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8XgrIXfTIHEeqcAXLdtftIJs4zNxs/4EHKGLYJ7O0pY=;
        b=rT5saTA5HdEO9w6VrTX51ltKFjWSgaSiqCQj+4Lt06auu6DNhCB08YWMf2bIo7pIIw
         MNJhQwM5xSEzuKrfbTM8Wd1QJBBSQd1B/WvbI4VXYe6d2CwzbAt/OjOOSz68G3jFEqZ4
         fpcuvMzYjhkZIYYUoHKZcbXXYtFbDiPz75VhKaXu+TJm3trF7OzXTzEij5L96/bwuXm5
         ZZAmW4lghgUTNP97nqStvJbIT/4Rfujcdz6taGnWxuGdI9UPcM69S0WJ611MMi/at5EY
         TC+au8mYlCmYLtiPJqZAxkfnG0HgYfqNhs7t2x4AyTjDrSpIt5UtbFk3FEL3VoyTRE3I
         VsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvTMmj0vgtsGySdK/fQwQTqAi0dX0DVB1LBfCV+LdLfRda5Zy7oDSt6Wmm/6v0vR7cUMvFW3aTu9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaB+MZOPhYbBnxANhWOAimOE9cm/pr4Fs1PZKG3w+iReXtpkN
	3y+46z92zkOKcXPMuBfhqvrdVdxwHnDbc7L5Dnia8UHhDP6tbqWMq8NU4N9A
X-Gm-Gg: AY/fxX7GyD3cVPn1iuQAdYCq7jBhIwR7ORX7kwZ8aeTrWaLSkmBX1fPyjCReH/fHy1Z
	pzXgXg+Li6M0IREAY5Ow9qWmejSGHI04YxCweGhiAPhYkWRg44dNFlTDwaLbjYOMvm83BoTbxy+
	FTM/ZVEWEVRRCrVPxnh2EBtzIXkwmqc8L8Wqyv2o4c1zvJGVwfazjVqrvWuwqKeLmshwoEkNHF4
	vbLnUbEN2uwDNyUapSG7WJ2fB6Bsy6l7nvdx35v+Rj6JQdYDQ8K/q8ZpDPqRTEDIoAZtTA0sl+o
	bB92as8N1Q++tP+SrmMbCS6LmDay4PteSm6PPIwQs9MyLxp2YuBTP9epVc1KjKldlKkK0N1bRh/
	F23kCY4ZGphXjUW25TbRu5WdmRq8LnKqRit8+ZDgIO6HIJ59su0JFhyTYi+XN3pEQMPCIkIMxae
	blE+t7TPUqqirnUNG6RcvQ3Hm9NQ==
X-Google-Smtp-Source: AGHT+IGBiNiGrFGtYU8HT43NWGc2t0TFwfrtWF8Wa/A1LiAqZWj9WgccZwKFE3lQHdocchAraz0Tow==
X-Received: by 2002:a17:903:3806:b0:2a1:3dae:8f22 with SMTP id d9443c01a7336-2a3ee5211demr49620495ad.61.1767868665505;
        Thu, 08 Jan 2026 02:37:45 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492esm76742965ad.98.2026.01.08.02.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:37:45 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: YehezkelShB@gmail.com,
	andreas.noever@gmail.com,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	feng.tang@linux.alibaba.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de,
	mahesh@linux.ibm.com,
	mingo@redhat.com,
	oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	tglx@linutronix.de,
	westeri@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Thu,  8 Jan 2026 10:37:36 +0000
Message-ID: <20260108103736.3433-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108095303.GQ2275908@black.igk.intel.com>
References: <20260108095303.GQ2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I Cloned and compiled the kernel yesterday
(which unfourtunatly did not fix anything),
and after testing i did the macOS update which bricked the linux install

