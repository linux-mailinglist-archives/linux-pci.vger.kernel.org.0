Return-Path: <linux-pci+bounces-44339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4BD07BD9
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 09:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77F95300D413
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 08:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57142FBE0A;
	Fri,  9 Jan 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irYKnfvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6492F83D8
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946470; cv=none; b=ApiJOsU9zBWmawzrgcr88V4vfdNdIsfVmCbu3qkNc1fzjwphBWOI4HN/jAC/Mn9lhBUhmE5MCgqcKsG4Ru/9FcHftV5KV5TQCHdJjrW0N45lCk0/gQz2Vq9YnB9Wd7aVlL4S9xbdl1+tb534WpkUnSoYG5sQkFzkviioW2A32fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946470; c=relaxed/simple;
	bh=qpySyFm/k0yHRyxc4TzhQRxSTNDzUkPIS2roYizOlEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUmHxj6A5/HFNZViSU34O6ZgsUcct4alxXVf58YYMtBOqXICy+NSzRiK2o7Boe7yYd0UpF71/7IToCFoj8F1r62/UCKA2iwr5dkpsUHKk9YOhu8/oSUZKRHZ2AuLjF3wcUt/oiAd1PfQeJKHsqYZQWz7zmibBRgwoLlGHAHUNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irYKnfvh; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9387df58cso4294866b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 09 Jan 2026 00:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767946469; x=1768551269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpySyFm/k0yHRyxc4TzhQRxSTNDzUkPIS2roYizOlEA=;
        b=irYKnfvhwjUcOBo3+HdcIIFkQABMpVWaJ+sja4XrqkA3C2aA1FpT+ugUS8NZrDM6Kt
         qj+2ENqE+6bq90mLEELeXhfjoG0FGi8Tiw6XKkEv0UkcTuiGmuf/CyAHKjin6XPO8DOD
         e2ZVoRBaz5AxbapL/20jUfy+jfBRfnYT9Izi8VdPMH1TrJW/RxoBINC8E3h/nQK2DY+w
         ZqXMApez40pYi1iSB+AYZZ70yuiG42J6y4Txu/R72+a/Gp1JbumZcwOyTdQBd3rLbBiR
         vekdTBhTLUxfErMUGrQjSE+lubCzbXN0Spn7OMb61hbBfdMPsngLEO+EkVGuqGuPQzU4
         mBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767946469; x=1768551269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qpySyFm/k0yHRyxc4TzhQRxSTNDzUkPIS2roYizOlEA=;
        b=Wp/oVtPqEfJAf87Y/mRyL8y4t8vno4uaM5w1oWA80xxkfIm1w70q7XWhKQJUiNwpmE
         ylh7iRZ/bfdQbIOtRooie0MLjZvfV0QoAi8hpIgWBRx6bk9t04+L/Me8c5ptOfduVeHg
         uCew6rRnPPJFy4BRuhTb4FXGEsYB0Ss7w2nrKx1j1C7YRsu8ikTEkpV00fsmraeVywy7
         HJdWIZA7VeAax9D0kEORKNtCsL0RLaf0qGxDajRIyTz/Qnmoi7cKKzyLbunYT1pCj+xh
         k/5Kfos3u1PqjdRHdttfp93i4H7csNuyo7yC4KGNMfyVZD2I0TkUWpn5vfyX6HlKyFBF
         vhtg==
X-Forwarded-Encrypted: i=1; AJvYcCV6qRMjA6/jOw4gIVA0gTSJJ5dCa7gu3YJvFXgx/AN2ib0N+DROXA5UxXWoQ6eci8Ay+PceinNWKa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4K6rqhwCTO2mIo5AJRlSaGs3lNX35GiNwptvuLeDfCbwT32x5
	LqhqZeAbWIzoBlE9TlxeAOD3SwYWut31YtiLYoFlqDDN4f3GAOSWCgc=
X-Gm-Gg: AY/fxX5zZqid4loRg8TAN//fe/3/pAxQZGT5T3f7DbYSPYA31ibo06kwUyH3RozY6/E
	I933PuNJtOk2hlhMPfGEGvmrmLbbDn3gFqB/bUb+qQUvCFUtrkOQmhyWlDeBd9seHFPaVnaCsmg
	BxFYakn2xxpQC+lUZHuTpQJiXTLoDvWC3NndveAK0D75ieV5Tv1hHCAHcz3L4gDdsFX9Z6BW0Gh
	kSA6huWs7PwWLAEwNeAG4Zp8uktoTQnqzuimumwJKgSqUFJoOYeLGHdG5097NgZ8ywhpP+2vBss
	g/YsYdTPXBFJbMoeraehBLBsR5lSEZvvBmpv3twHzWaBBa/vtuHnO5qb3c57PviYJaOTRoHkwPi
	h5PBJYlValwN2vPxZW6dZnBd+c0dVMeNxDYAMCPaBoFxTfXn0t17TtsraL6qPfVIGagubsaKNQe
	CmzFA6YE7UJ2R8oYY=
X-Google-Smtp-Source: AGHT+IHp8AMqv9c4azrHD6Y6JJV04ILq12NFVTRqxBqD6sCbbov2HXVi14txeZNz5RHLy3TSD5xafA==
X-Received: by 2002:a05:6a00:ab09:b0:7e8:450c:61a7 with SMTP id d2e1a72fcca58-81b7ffd1519mr7639426b3a.62.1767946468726;
        Fri, 09 Jan 2026 00:14:28 -0800 (PST)
Received: from at.. ([171.61.163.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f8ff7sm9695717b3a.37.2026.01.09.00.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:14:28 -0800 (PST)
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
Date: Fri,  9 Jan 2026 08:14:19 +0000
Message-ID: <20260109081419.2746-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109065746.GT2275908@black.igk.intel.com>
References: <20260109065746.GT2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unfourtunatly the GRUB problem isint fixed, and the solution i see, is to
wipe the drive which i cant do currently, because of my data

