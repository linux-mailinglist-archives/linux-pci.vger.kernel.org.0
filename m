Return-Path: <linux-pci+bounces-43023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A458FCBBA97
	for <lists+linux-pci@lfdr.de>; Sun, 14 Dec 2025 13:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456B630056D1
	for <lists+linux-pci@lfdr.de>; Sun, 14 Dec 2025 12:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A675E1624DF;
	Sun, 14 Dec 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iruBOQtX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107431DDF3
	for <linux-pci@vger.kernel.org>; Sun, 14 Dec 2025 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765714145; cv=none; b=trcFnBJt3Xw5ZKWSFjPtXYTwnXBHxCWPU/th2oj+eSSHLk1Z/zznNp1l6vb/AqtWXF0S/OFcEYRqLLxpNAIiMdfnz9TRkVnNr0vb/qteRV3M4492tKhg/DziprgvAiY2QodLfoCE+kiZJGz2Ih99TENZcmmAYGjj4L0wX1r8Xeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765714145; c=relaxed/simple;
	bh=24r3RT0blTlP4vVDhTGVzpP6593uCi9J5WSfFBxiCSM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=p5wxU5B92FGaT4XMOZYI2McV9e9Jp6LhJUIlrl7cos6JxfLhI3Wo8obg533+2iRaturEZSDbtnS4EoYTUmaG1BbHtOsi1q2ZB8Q+u9t8+3TplzNcodOh5oG4aqI1f+5b1Tc6uH90L3LGFc2ZebRKKy2jFhweMpvCyH4bWh2ebm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iruBOQtX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so2812029e87.2
        for <linux-pci@vger.kernel.org>; Sun, 14 Dec 2025 04:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714142; x=1766318942; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=24r3RT0blTlP4vVDhTGVzpP6593uCi9J5WSfFBxiCSM=;
        b=iruBOQtXW/Obqca4bieXPEM75QI5TIJcvE79QuGiHpRo1KCmh5djwdKKLKjRraONFd
         f0ZA3cgJD3IY/WscIASl0O5G473Iew5nofmphTZMK9Yx63Ld9sT3Hcbr69dqAgECLYZ8
         ek2FeyFJmwnpDZx394wtiq/W1TbFkwqT7FcFlXQGu6lOpUPZQorg1WidXpbfqQEwhHRx
         iv5TtoxG9iVWsm0jfmKm5AJDaq+bCEqSIz2ufpP4bJJNbYkrehRNry6jiN7+EqziWsLv
         waII5lQNycPBJ3Egzxi3B9FXnhA6E0QuGmWLJEwl7uWqOCy1nv06FcQ58dxXw/wlq6wa
         lLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714142; x=1766318942;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24r3RT0blTlP4vVDhTGVzpP6593uCi9J5WSfFBxiCSM=;
        b=ftJRg9ib3OPTIIK2NjHuJ8oS8P7V1jc6a7YeVim7IrZ6daGRJrndphCMpWqZPm4Mka
         KAGIVbNxCP1QMf0zhRyP2Ou688oFi7wq2pdH1xi3lwxXh1aK021J5IbiDK96jZ0RvNU3
         VbiEgdJRPUwiCco8leMnvIZoYwrfxXF7dsKm9EOXg9nlYsF5WDFNPuXPDqj8j17ZoWUq
         s6d5eRvCr+SrOG3sTZdMsEpR4BMcLDpROdmwmaRBipjuxRb/4bpNoIyBrSK/+R+q10qh
         8ljUBkaKltnE5Z87RQQAg78OD6ViYYiU6iUn71DMqCp61Tq6JRIAiHljkVihTVmIPusj
         aoYA==
X-Forwarded-Encrypted: i=1; AJvYcCVs88DVtMOeMw0Nnlrgu1TSi3ozZ3mh+aP0VDck1DebDLODUfWuuliBCK2zuQvkHCEzHV4vgnR74XE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya4WezI1WEAres4ovaaiU8TEsBRxkIG9A+gKJNWFvUmm6Wq17c
	yu4Ff5nIhz4F8IsETMJy2hJwUoo5O7CEDBhK7jvO1fMTvBplEwDuW39UWtwHtW+hIq2aNmBZGN2
	91itY1YsNTQ8UzYl+1wRnD4tISKINt2gV4w==
X-Gm-Gg: AY/fxX6U8pb+ZzwJmYYN/4PLFyEpbFvnpebLfBaxfqzJh76JwrNrHhWXYKqEGlmaM8B
	jpEOtY5s+9Bo0DYcbAJ0HWFRwlh1rYQA/6xh6xa/LAjo4QfLn7flvVs7DCG2Pic7LFkBygKIX3q
	pS8nvNrnyBTLoroAouqbRdEZHPHPffaWiM4YB452mNpvQ7+iErXwYZzCTjQ3eLL9ocrgvsZbLQK
	OczHD92AEQaXFsUzaa7lW67IwxJUtvSpwyI3Gam6bZKIgbXZGsxTnyorqsyjI+wM43rreC9
X-Google-Smtp-Source: AGHT+IGQeGS23jf2/IRjYkwEmTG3hjsgPGVTkngw0l1GZMfZs8lGFW9i4SlZHHY27DzxN2mfYwV9wOYudRBdrR7QKHk=
X-Received: by 2002:a05:6512:e9c:b0:598:8f91:b71d with SMTP id
 2adb3069b0e04-598faa332e6mr2377600e87.22.1765714141973; Sun, 14 Dec 2025
 04:09:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Sun, 14 Dec 2025 17:38:50 +0530
X-Gm-Features: AQt7F2qtF2HhY3dXg-6TqjYWOUaBnnVAOa499V6C3Uf4nKYfKkyibdNAiRAKYv8
Message-ID: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
Subject: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi everyone.

Let's assume x86_64-linux host and guest, with full-virtualization and
iommu hardware capabilities.

Before launching vm, qemu with the help vfio "installs" "dev1" on the
virtual-pci-root-complex of guest.
After bootup, the guest does the usual enumeration, finds "dev1" on
the pci-bus, and programs the BARs in its domain.

However, there is no guarantee that guest-pci-mmio-physical-ranges
would be identical to "what would have been"
host-pci-mmio-physical-ranges.
Then how does the EPT/SLAT tables get set up for correct mapping from
GPA => HPA for dev1's-BARs-MMIO-regions ?

Will be grateful for pointers.

Thanks and Regards,
Ajay

