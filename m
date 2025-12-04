Return-Path: <linux-pci+bounces-42644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A65CA4F53
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 19:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FD733058624
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3728223DE9;
	Thu,  4 Dec 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WJ3ouWGk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2282FC02D
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873060; cv=none; b=LsI+q2sOhLeERNph9krPFxohVLk9apbU4dS7r8IABUU4nX5+78HBpGXCpnFoHFadZ7tYqCg7+Yf4K2dqxBW8Wdizqzso6uniKBQcOp1Ez0sS8/Y9LugO9EjGLBdAvoZRkAbkSvni3te8e5DBZghSctc7wSzmrmyjm6ueehE0GiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873060; c=relaxed/simple;
	bh=qbeHBtjxXy8eLM1DgcOZoTdF0dhvdO5cHFOGpCEjesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdTFYD8eJoZnJq+n04ro84xvXNHq8B7CbT9yNxv7UwKkbNOcQdXbPB0zS5Jf85lGvBda9iA+MQQQPUiVltbX1qPqtldVSCC70hsvyR0xacvpvAPmB1ColNMkfPJ0s0L8f05gwPAOnuzqdHsABLCzKn8HTuIxJ9X21LiUkqVxTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WJ3ouWGk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1104810b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 10:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764873058; x=1765477858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbeHBtjxXy8eLM1DgcOZoTdF0dhvdO5cHFOGpCEjesQ=;
        b=WJ3ouWGkxsP0XPXBFLoMoimTi8B6FCcADnBXlBVKgAp0F23BVfSXIqQ2LlT8crIfE4
         owV8WE5vsUDyp51fTWRwCx9vY/ZTjBfjmMRrmPv0DFA+Vttx9NyAW9S/2up6o49oVlLf
         5+Z6ePNE9zcIumIdRps33Y4nNeRURlHatOw9eenUhXbWwa8XOzjdYu6yFqrdOJCvHW5e
         6HGJzIiRdrv2XZcIyGQ9wgRQJ5yPsM/WYY2c7zy6xC1DHdO0secM3O4gq9r4h8ec0nba
         OcXIZEznQUh3FFpEXc4vho+sK30zy5r/UGl3mnyGux/5Cgt64jUmiJO7EaJcGHhm3ITG
         R9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873058; x=1765477858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qbeHBtjxXy8eLM1DgcOZoTdF0dhvdO5cHFOGpCEjesQ=;
        b=ChkkPOjA0t2+EQmvPW2OanEtAq7tx8UE52Skac0/hc6OE1+O9lhYOr5irqh2VUbL7l
         xciYoSelcVT23sKLxQiUIMFWVrzEDb9tdoeez08FTPu+FvYVp7Zb3Lqc1FrPzHCVwJDd
         t4/lmBEVSKCUweybRFJRvTWJP7EUr1gzzQllMoOrYP+Y8TXeoRg+URVIKNk2QiTaiuQv
         QsDn0WvOEzTva4VWm+WvjUGEfsvB8FCIPi6iCoCR/FG51J3xhHxuL+xPELP3kmLjJZqp
         avdde/hUS0bGwV7Z1MDLlajgBdF+rho/wIZplbr8wF+ELfJUxGsoZGi0Xre22mzo1ACV
         f0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9i9PIRMVdszKmB3lfdxyKUVCiV2SGaiGeeYK3KKZYLyJOOQmhXimdz5RigOy0qrfJH7PpVcZxy+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOIvviaI885e3C/y0diVDh1CLDlLDX2TWIfMQduKkEqqbEBjJ7
	m5dJ1jnVmJP+G75PVtTmIz80oAP3rWR0cZd5vGV4sKND0zCRFopccN4z01K8rZ6lREU=
X-Gm-Gg: ASbGnctHOqdN7qT0G6PPXs391mozHBUsTorBQRYJ4xBBOK56woM12r7s7YR0J7U05/s
	BM0f0BVZ7Tq40maQ4/atIqJtzoGj1f3b/KYJYuISv0sIaRZvYFVB3+iElynnOB+1kIHZlwT8/uJ
	yAZyZTMWuTe65Pf+zC8oG5/tK0SvZ6VagOZgbdYATb0Y5/rOfLl6Vg6H8/XGyGbZKL9Sd2NOtpK
	Cf3Bx3jniZ40VU/6Wj22qMiCbR9vSW0BhRfeX4/ZSW7R5fEszOqBG/3mjXVfr8AbGvKW+F9a6Lv
	l7tGc6b4WdKX8XxNAwncG/eIgyRn/FwPGWSg6M9LzWAF1HDpOVaN4mUkOxpT3CYv7ww8W6uZM5y
	l1xU3z7H6jH0np4NzuYYeUUkIfIwBUEkn7xZeRg/7IVsXD0XwIO2GbhwAhj/gIbIaHJ6dd2Zb83
	lCGjq3DfiNTnItkG5MswT3nDq0By8ScgLdF3jO
X-Google-Smtp-Source: AGHT+IFwVXzqHlJ0b4a7IsYu/N+qJ0damC8e7pkQB+EFe/L1qquBX9lzyqPHf41lejTunc+PvN4P4g==
X-Received: by 2002:a05:7022:f207:b0:11b:998d:bded with SMTP id a92af1059eb24-11df649c373mr2334070c88.28.1764873057950;
        Thu, 04 Dec 2025 10:30:57 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm9108883c88.5.2025.12.04.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:30:57 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: ahuang12@lenovo.com,
	alok.a.tiwari@oracle.com,
	ashishk@purestorage.com,
	bamstadt@purestorage.com,
	bhelgaas@google.com,
	guojinhui.liam@bytedance.com,
	ilpo.jarvinen@linux.intel.com,
	jiwei.sun.bj@qq.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	sunjw10@lenovo.com
Subject: Re: [PATCH] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Thu,  4 Dec 2025 11:30:36 -0700
Message-ID: <20251204183036.39649-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm sorry my last response kind of messed up the threading in this chain...

I don't understand why we still think its a good idea to have this action
in the kernel for any device type since it seems to only help Maciej W. Rozycki's
specific situation which is very likely to be the only one of its kind. In
addition the Delock adapter isn't what I would consider a particularly
"solid" device.

For what its worth I have a particular Gen5 device in my lab here that gets stuck
in an infinite link up-down loop when you force the speed to Gen2 when also combined
with a specific downstream port... I'm sure there is another device somewhere else
in the world that has the same issue when you force it to Gen1.

The kernel should assume a PCIe link will automatically train to the best
speed that the devices can achieve & if the link fails to train then it should
be up to the user space to decide what to do with it in my opinion.

