Return-Path: <linux-pci+bounces-43531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 977DECD699C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 16:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28862301C930
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84874149C6F;
	Mon, 22 Dec 2025 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAFnN98f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B79156C6A
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766418318; cv=none; b=RLrV/Lzl1lWZjP/hUsQSnqyafDDneWpbN9NFQvcbAq0k+Ddh5cluep2isW6Rm2YyvsfJg36Vg08G5HQpI9dOHUXhxwDLei6wPig0bcbWSLKZmiK20TPzNGHzA3fEmXVpiqT435n7RzyXYzTskl66kFTn7vGPyoT+nFdF0bd3+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766418318; c=relaxed/simple;
	bh=B5tr4c+A3t7MW44YTpL9XRKWVl0YJlXuVZFNo1w/JCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMObgE25NjIrmIm3so4zdOjRIR9xAo2iVGL5+6ZqAyqwshTudwYAVaNhSKBTWE2WOlZOfEh14fTpumGIqE3eBiC0mFpSG3agM1u1/+HGHH/sSAxvDR+h7twBKQQ8Url4fIJLtPjiP4agjy514DRy5z1C0GyXd6ibjWRtKy81EfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAFnN98f; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b96cbd875so34181161fa.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 07:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766418315; x=1767023115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5tr4c+A3t7MW44YTpL9XRKWVl0YJlXuVZFNo1w/JCg=;
        b=RAFnN98fodroLJzsEMfVagS7At3pguftZlB5bXCWZIFU2Nfo5bnmJl2kQeopInql9j
         x5T7+uGx/bxGKIc3x4xIj5ChC6chEj+nKldozPXPLOpEJ5ukpHRHS3ko9IYVZq3ANncc
         v8/Pbk5J/Ff2qPfzZuCdmYWEFraRlczYFcuADymoIpxzoPF9uZRtB9j5SuEEYYqPEVna
         6U01ebONpbEdtAnoxPDH+w6xQK8uWTUP0NwBdX/Shb78Y2B9Jsw/tAAm8NHPHiGiva5e
         dXN3B+cdV4tYgQsqy1EXegnJxdLNiv0gwTjB9EnNYgqMqC6TJE+iAup09AWa7pKyOfty
         lM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766418315; x=1767023115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5tr4c+A3t7MW44YTpL9XRKWVl0YJlXuVZFNo1w/JCg=;
        b=W1xoOTbMjNjHXJCkPsWEHSSACpAeg3cIWr8t8gWRBpTkOzxx+Sr2eljmteBx+MK36I
         8jAOGiv5h7D5rACVgY4hy+2cg0qZfas5AFpOHUAfwGS9dfIuQ47q5ywQynWTr7UZSJjV
         POxWPHcYY8h90Pt3fTkrRjAGzxNS7Wvp5uXy+BBiIuSM4DnaWpagGrAFFCzOJ8SHHh13
         u3v+rMmfyqQN8aaU5pyhpTGX/AWqUjj6E7jRZuurti6Pk3W8Mki2ioHa24GVfCRHZ2X8
         SfhTvQIfWyXw87pz+s0/qxaPMV/ppT39JNyCcw0BLy60X9kTGlvT6JLvLbCfRiJZzSTR
         5uog==
X-Forwarded-Encrypted: i=1; AJvYcCWI9AUoEZaOrpyXA9JI2hoLaYNxXarhTxbk8UQSIZov1nhVVtFtL4eQJqaUWCy7mctXY5beokPkCms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX36Hp9CeX+6XrA1cSvQ8DH4hfMQqAQtDJpVBBQmWGzgXeguS4
	wHUT+8iNjFgd3AE+kTN5gzI86wxsULlcc/0ndGyjuNL5Ya7J+SOaAgOg
X-Gm-Gg: AY/fxX6i5iJLLd6ivup0ylRgKrRmmwgH+/INCqNLPz7p/IOnn2FPOA1vtW+IZiFQWh+
	qUxyDUF2QOvO6Lbs7t4TcjklsxmfgV/daDL0d+wpk79BiJH8BwiBHqgVQVcpQMHQ30Y9EwZvW7F
	yS2ZVMurL2GdwgChdTDvBSA8sL1sTog10+WYkcTKkp5+6ddON2Mj208vudzMvewQMFmh5XSPN/6
	43FhWOpwB6YKSziz+szpd1/87KrXGR+4u+IjeCEPwbewaDF/KUva7aNNpH71PbBDk0WIjv569x5
	M6GBNQPzTevKbAPABV5uX1x0mWxA16IIz+IMLJLQCB0B+LPNUMJWEWpGVcg2IdezfbVneklXc1e
	8Uj7JhsRKgPI0XmiZzroGo3+UzGr+uGF3avKXmxG/t52Qgy5uzSQ4fCeWmgwlCJ1Y/Q2uFIxCZI
	1vHMtYE+ff3dwXIUm3Yp0=
X-Google-Smtp-Source: AGHT+IHz/r1NcBgyLxzJRzke/s8B1R/YbOuFqJsT9HcEX0jf4C84uhz25xVn0SBQljw81BhkKsTNhA==
X-Received: by 2002:a05:651c:325b:b0:37f:c5ca:a10b with SMTP id 38308e7fff4ca-38121553178mr35264171fa.4.1766418314576;
        Mon, 22 Dec 2025 07:45:14 -0800 (PST)
Received: from localhost ([212.74.230.163])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-3812267964fsm27500491fa.42.2025.12.22.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:45:14 -0800 (PST)
From: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>
To: roman.shlyakhov.rs@gmail.com
Cc: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] pci: pci-stub fix kernel-doc warnings
Date: Mon, 22 Dec 2025 18:44:20 +0300
Message-ID: <20251222154424.117668-1-roman.shlyakhov.rs@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251222132854.112890-1-roman.shlyakhov.rs@gmail.com>
References: <20251222132854.112890-1-roman.shlyakhov.rs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry for the misdirected patch.

This kernel-doc fix was intended as part of the v2/v3 series for the
BUSID binding feature, but was accidentally sent as a standalone patch
outside the main thread.

Please disregard this patch — all kernel-doc and build fixes are included
in v3, which has been sent as a reply to the original submission:
https://lore.kernel.org/r/20251219131038.21052-1-roman.shlyakhov.rs@gmail.com

Best regards,
Roman Shlyakhov

