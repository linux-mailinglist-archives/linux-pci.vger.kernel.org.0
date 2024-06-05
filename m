Return-Path: <linux-pci+bounces-8376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9008FDA30
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F261C22449
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4B16191A;
	Wed,  5 Jun 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrPfNOta"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D597136E1F;
	Wed,  5 Jun 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629126; cv=none; b=WmUeS32QqIvPJLSPsgXNTPtEEb0xpf/bRd+0g4ab1+XEzTIbOLLCBJnYi1s6Yb7E4MvL3UIuFtcTNFcn/k1nnp0bCa7qgPYDoVBIyu+9PDpjAvt5S83dm4qUd5U6+Sdz+zbakYgYVFBjXDCY2s/nwsVUgwvv/vj/LLCI+sbOn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629126; c=relaxed/simple;
	bh=5EjGg/juo1GvXCCHmg1qyVmZN2+jZIww5rTD/8bLWiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A8CeHaQ+ubgnwm1IunIlMsDFGo2RkGu1QL0pCVJfBG5StOMlSL07P2bTq+lKBGQ4u1pyvZE30HBIqo7tKhtzjt+qr/CsTH82iJUi2iCz1DAVtcucq2H3ojNWkCrTobXixOv1IntbaDiYOPpV4ejtlIdFwoI8WTcM8fBclimGNK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrPfNOta; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70249faa853so261357b3a.3;
        Wed, 05 Jun 2024 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717629124; x=1718233924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjDX2hX7Uso3teou4bJNTRXKSoRMvYQRMdknmfn7m5M=;
        b=nrPfNOtaByZcmZJeuQFLAXjrd6Pj4aROUGC0Wg5U5Ask0dRaboIsqBKBjyyz6oPaDB
         cUQMQy+u7sE7FIXbJjVnHuiDIk+20AotJjoPRrRdDNBcSmNBhvQhhQrL1R2wFD5B4YkO
         EgML+8dqNcyV2coNDCh89sf2K48MZBvVl3ph9/G0Ay+vJ1oUuB5kfpyO4rpMtpny9VFi
         WjhXNvmdPnpMaq/n+AeM/GmzbfsK4yRmnuLSTtBbf7v9vqmNlhGFcH0bXdY+0razpHwO
         TjratD18gGOucDC5sNQZj5jOBQm5tD//4skWVD/Y/qpaiETmUTtkEDiv2yaeukYR+TPt
         Nv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629124; x=1718233924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjDX2hX7Uso3teou4bJNTRXKSoRMvYQRMdknmfn7m5M=;
        b=b+v0d1n3o9KVKJqYk754AHfK5ec6oOMYynpc+TA2Pxmv0KpnqResDVNvertFj2fVKo
         d1r0VjHxjUUKXWn58o2n4MSbFL77GztS4geOfnFE45V97QAMQDANOh39VyMTOg4x38hq
         f9fbMX78t6cTcQVjBmy0d5nxiKaSqGoWoN7O0c6Qi8g8VIrEu8rS5S248hfYxVpVw4tO
         KfCMoPPFm125CSDacNma7eNoYXcV2YrfmKlhewLnIauwrRj/eMRsS6Knl0mc/KSbcMLX
         aszLOAp0kNdMLj5F4nCMRo7YiHs5mHhMrl7cgLupeLhhDv8XU+JgHDsCQzj0lBKEeDyH
         U6CA==
X-Forwarded-Encrypted: i=1; AJvYcCVgIDuSfmQncNwRpG19NHFWTdaQTfWyckzWawomyNLWBTbz5/eMRmHEX/qo6d4Z17Lb2ZWqVaJivSKpITa162WxJhD3ysMFcAeV4x09jcserguTyaT2tt+THYuHSwxiU3zn8iaYtyMB
X-Gm-Message-State: AOJu0YxjUXjgw0SSCBhdh+5Y0LF/LXjIhfqyJbq3GKQD391YeTcv0F44
	Dy4AYs5y/UzUdiAGkwlAY3LifGm9LINh5sD1lwZ0Ztw4dTSdpXvZ
X-Google-Smtp-Source: AGHT+IEvSJWjZvCAuOdJ7JHjs5or9ojfn+5TZtxB1V0IgRL3ajQOdVAeDO4abrTWzlbHzx6Ymhj/IQ==
X-Received: by 2002:a05:6a00:1caa:b0:6e6:946b:a983 with SMTP id d2e1a72fcca58-703e594a710mr4048104b3a.10.1717629124206;
        Wed, 05 Jun 2024 16:12:04 -0700 (PDT)
Received: from dev0.. ([49.43.162.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd50fd7fsm31068b3a.197.2024.06.05.16.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 16:12:03 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	jain.abhinav177@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] PCI/AER: Print error message as per the TODO
Date: Wed,  5 Jun 2024 23:11:56 +0000
Message-Id: <20240605231156.22934-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215848.GA782210@bhelgaas>
References: <20240605215848.GA782210@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Jun 2024 16:58:48 -0500, Bjorn Helgaas wrote:
> - It doesn't apply to -rc1 (the TODO message is missing).  In PCI,
>   we normally apply patches on topic branches based on -rc1.

Thank you for the detailed feedback. I was looking at mainline only.

> - The subject should be more specific so it makes sense all by
>   itself, e.g., "Log note if we find too many devices with errors"

> - Add period at end of sentence in commit log.
> - Move historical notes (v1 URL, changes since v1) below the "---"
>  line so they don't get included in the commit log.

I have included these changes to the v3. Please find it here: 
https://lore.kernel.org/all/20240605230954.22911-1-jain.abhinav177@gmail.com/

> - __func__ is not relevant here -- that's generally a debugging
>   thing.  We can find the function by searching for the message
>   text.  In cases like this, I'd rather have something that helps
>   identify a *device* that's related to the message, e.g., the
>   pci_dev in this case.  So I'd suggest pci_err(dev, "...") here.

> - I'd keep pci_err() instead of switching to pr_notice().  If we get
>   this message, we should re-think the way we collect this
>   information, so I want to hear about it.

I understand, this helped me get a clear picture of what needs to be 
done. I have accordingly added two pci_err for the same. Please review.

