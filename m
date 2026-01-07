Return-Path: <linux-pci+bounces-44178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA33CFD729
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 12:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D47BB300E459
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4A309F08;
	Wed,  7 Jan 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7DcinwH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BA12FD69E
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786222; cv=none; b=OVsM5ykkP5qoXtFvkXdjGT59NBaEO1ofeabnawt7w5E6MKkCLfDBOQpVz9FM1QkQR/lgzJTD3vefeywJ/VSLUHUrpGRKuFf2J4y2zgf3rGPSmcK3t8064v9YK9d2ofR6gWHkDmHC+eXPPsIkBNGznx3PteG5XTqHav0LYe68rJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786222; c=relaxed/simple;
	bh=hQY7gqRUD0m7DCREiZCNdJ7Q8sM0i3MxeoJ9KLvZ9Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGzSb65NLxipkiw7dhyCgeFarKephlNdM057XtrlpBJs0bCBlK3StDPzWKzMs8sudh8kg1h9xyBU55dzeIAM5R+7vOU0dVlPToiqwvMFVymEFu6Ex/yu0nsAU9aCxaev++bmS3mfyyBwCwfIpb7lTNck6PK0nkY30AxnterXFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7DcinwH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so1888330b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 03:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767786221; x=1768391021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQY7gqRUD0m7DCREiZCNdJ7Q8sM0i3MxeoJ9KLvZ9Fc=;
        b=K7DcinwHNyMc+1Tu4DZmhPGCpl91CFlWUxOolAdeZvELIkAqRGeS9W3ZHN0CbOSVfE
         V0VT2qvCzz13Brat6duT40+cRTK43yZtw8NOVmpOapECOkMR6Fwt22LbzH19mbSp37Ax
         KRxWiviXRgv7fNh8mj2450amP5qP+z+zgSpI84KADd1UqzmTdfi0ulDdjVcNUfB+xDam
         RkM3WMJz3MErWTksQL+Ry9/ZmosK25fchtpl9QneUo67jUHsTrwSXZEw4XcxuwwBU03g
         HuDuXFsJ6avA6htcNoBVYm0cr2lte+cX46HtZVA22vZEEZo3JkcXJe6EElsL0PVjYboB
         Nc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767786221; x=1768391021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hQY7gqRUD0m7DCREiZCNdJ7Q8sM0i3MxeoJ9KLvZ9Fc=;
        b=vth6LZuP+D77KQePWcuGQEuTK1zZX7lGtY1KeBeW6utcXZigOkGx6ll0HXPHQgLNxm
         83LC/ehhKJc2oMpezcnhsEyi7CbfsYTjqOxlN3oc76W6a/AoF5bkw2KxRh1VNbBr5PsO
         xlKxuwy2LEAxUEs3C//pkN5blC39oqOZEv6inPsp8nz/CZAyNMWKVY4YUqYZwNrVqoVt
         2uWUs5uYMGz4vz8yDZJDKBc4e/4MHAOAIne/UZjZUDrkYnThAoo32V0GWZxgy9HUndgI
         H4kMU8W24omtyO4ivraepYhd5IdQnr3Z00kzvcjnTByQzyRv2aoFVF8OPE/dbPWBOLu/
         Ey2g==
X-Forwarded-Encrypted: i=1; AJvYcCW+E+TKx49PsX/94pngaLuLcUmtIwT8QbCGErv8v3oGcvK/u9epm3AfNrtDPz+ZvfQiRMsroEz8Eyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8AV81agZb+x9W2uShxMGVwopKNRvZBG2xzydskO0wzAfHyehl
	Eq1GQoAF5dDPVQFyxCIWFB4hmuVVmj3jcYh9qRAVHt1T7Dh64h8yWPQ=
X-Gm-Gg: AY/fxX5EQo1AJd3GHmRpPYCd0aMvRTc+X7H+kgIP+xB/7Lbj07MboBMmADDuEMv+sQ7
	53yRJo8BAypZjxpJ1DTKcXRFGt5NHErV7YQhHgPNpB0ZM8GdGnszpIkq1DDBr1Tw4n5tcGWx4bx
	Rbeo+ChAXotrqyrL0SJn5SR5W9LKcpb1oLY6VkFkS7m1AePQGpMhMWV3MP7Gh6Voz/cR4Ayqwtc
	IKifVTJHfOZjQvxd4RotlKuCPxBAj4XVzUUP96ppqnmk+JxQjxsuWHkqig5ynljhC48pik8jDy7
	wSclVlKJVm/M5OMU041NDiHYcUmCYi+CRPydwZ+eQOOQh182jy3ij5reqfp+s+rTAQw0AUMFe6u
	jfl6mw1QQrqgSYAjBIiqgLQ3kMLtvV6uEYNZIV0cPUHmIB59VoSDmnK6yZop0WIi2T4KlaOJqdL
	zc45nGTw/1+NcsXZU=
X-Google-Smtp-Source: AGHT+IEL/irKUmHduAIb+7IQsrOJGizixcnab96aJqSCF1h8BB26P/sAiJWfDmIGBjPcpWtmLyIhZw==
X-Received: by 2002:a05:6a00:801b:b0:7f7:3225:e2da with SMTP id d2e1a72fcca58-81b7d853038mr2000426b3a.18.1767786220582;
        Wed, 07 Jan 2026 03:43:40 -0800 (PST)
Received: from at.. ([171.61.166.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81c4905ca83sm335530b3a.38.2026.01.07.03.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 03:43:40 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: lukas@wunner.de
Cc: atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	feng.tang@linux.alibaba.com,
	giovanni.cabiddu@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Date: Wed,  7 Jan 2026 11:43:33 +0000
Message-ID: <20260107114333.1536-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aV4tyKPGioCqXTRr@wunner.de>
References: <aV4tyKPGioCqXTRr@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you provide a link to the xnu source code
> so that we can double-check what they're doing and why?

The XNU is open-source but its drivers are closed source
(which includes the thunderbolt drivers), so unfourtunatly
i cant provide the source code of the thunderbolt drivers in macOS.

