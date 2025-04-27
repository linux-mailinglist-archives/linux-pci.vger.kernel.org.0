Return-Path: <linux-pci+bounces-26874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A4A9E3B6
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4501E174BD9
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6381B6CE9;
	Sun, 27 Apr 2025 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCMYo52a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD504A35
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745767074; cv=none; b=uWVw/fJZ4j9biIuimfCaKdyLX2V6Qc0MmxU+jeuOSewNoZcU0oyizksXvguEybnCe2YLecM7aGO0X1eUMw5OzJXncAL0JXRDeX5vFpy4ciWXU3DDEvm3hxYuFJ2B/oqnkCynTA4HyLu6v03M9NIRpFBer+HAvmHuumlb1jhTBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745767074; c=relaxed/simple;
	bh=r0WkzLf/8cJ2lxWhyde4yxwtG526dOcPnRXqGl1lX3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyZcUcq0WTohp0lblba55Iws82Q+4Pziv8/qDqzBoW+l8iM2+QFCEyZNyUyA8XOeg8l+oieeP5bFmXIB6CYjBKPV4eQgTCsu2OUDxXO9mLA13WzsWlSZlO7O5AkUtcnF91ssO74LC1A63CI00nc9fPRfKKd9yVZLxpYQX/0Ff+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DCMYo52a; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff64550991so3177738a91.0
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745767072; x=1746371872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6wXrjzsVf3DH1Jrc73Ekpfc7PLUWri8Lq7HSEYSNfM=;
        b=DCMYo52aCSEwbPFxNsXdhbuESRqSfVms3lmwvTFqyBN5eGOnXiZwVAV0Hr9qTm3lBF
         Nl/zLlr1kRT+9nhivtsMbdV1DvuUoAuGky1/kMILG29HqilIq6ntUuSM4+OQpTaot3k3
         xo4S6Kr7Xsl1y3tXoCSyNagumV14Q7j/cy9G7eD01LTev+t5UVLaTcarHcS97n9GHGuB
         zj4ha4DxF+MzqCR5u7G0vXxmg4ocHuaTPC0t4QilHRDi92z3esvdrDCN8aBPRRfickoA
         A2Y/pDAyLDwm4uwFiMzDQvmVxF8HuYdq7zXO3ALD4gQinc9vbyzBE9wCZCYkjKkk5rTV
         22Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745767072; x=1746371872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6wXrjzsVf3DH1Jrc73Ekpfc7PLUWri8Lq7HSEYSNfM=;
        b=SfAn3lEhuh13nfZlezRLXJvd4o0Ct/1+ywmyZYqfB5eQKxWhVpsk/9iUvh5Fz3W7S7
         wqaeIuVJd5bUG11G+oqHr0dz+j3wGT4CFL2dIXj7TTzAur34C8Q1WIkqhQ8xARNmDjk5
         ucqaWgMh8sS7wxD6M4sCX7fOotJcZdTAp+mCehAsaxIFk0e3JzMxkJ50DNVGvrxYkSVz
         T4i7llk3ULlJ7LJEEWSx4bPiOTdcozRxVx6LTv7Hf84aVUNE/bt5Utoo2kBXp0E2tCTs
         AE9TQhCCXr6PPflXV0bI/VoQEGxZahBV5GBLDIiiyZNR1iqpbBX/btJdo99c0yjqGH5j
         tVVg==
X-Forwarded-Encrypted: i=1; AJvYcCV/kk61wiot+YEVaJCQoGve0Bxf8arrkXmpVc/oMXK235jcAi7j+j6egb8buqivNRpG9i06XWfn69c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhE7h+p5Rje40WcAQ9/qt7PP1jFxUNUzzUk+aj2n188cFd2zy0
	rg53Zhli1YGXOKOhRWnwA2eXxtkWe0nuQEVAM8yLYW2qlnB43DDtjdykVZj70w==
X-Gm-Gg: ASbGnctxtFB9LRZEpKsdQRYnQsqT5Tn6S4Yd2OfyhoWVEpbXN5AklIDphmejzMdC7nZ
	ZvH94hh618pjuUWZVJqglihXwQDSGeval+gIR0cATVI/MtXyX7LZu57dRTHgGCoWSgzQzw65+ch
	ufICiav4vErOHjrpkscEixeJupQGCyhzYT4b9l4u2vf4cdyXr54sqzLXB22o0kjxZa6+dSQLOow
	PzmErc04G7CE2RZYOor4ik6eTXudam5bGO1CLkfRrUImADN8xQvvaaV/GIZHtCNAfZQW7NlXwMS
	Q8oEeqWFjBv33qHFd1f/tkyIPM1ddHWdcb888QikWy2+Mlv2SBM0
X-Google-Smtp-Source: AGHT+IHsKSGV7qVUDINwXMp3Zeljydm0ITfFLTON/CQSAoFjpJ4D36vJUKUIXlOMdJUWWo9Rrih6uw==
X-Received: by 2002:a17:90b:2810:b0:2ff:502e:62d4 with SMTP id 98e67ed59e1d1-309f7e8ec70mr11258975a91.32.1745767072425;
        Sun, 27 Apr 2025 08:17:52 -0700 (PDT)
Received: from thinkpad.. ([120.60.52.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef124cffsm7834594a91.32.2025.04.27.08.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 08:17:51 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	robh@kernel.org,
	jingoohan1@gmail.com,
	shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Sun, 27 Apr 2025 20:47:39 +0530
Message-ID: <174576703760.21368.17997982524874077646.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250427125316.99627-1-18255117159@163.com>
References: <20250427125316.99627-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 27 Apr 2025 20:53:13 +0800, Hans Zhang wrote:
> 1. PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
> 2. PCI: dw-rockchip: Reorganize register and bitfield definitions
> 3. PCI: dw-rockchip: Unify link status checks with FIELD_GET
> 

Applied, thanks!

[1/3] PCI: dw-rockchip: Remove unused PCIE_CLIENT_GENERAL_DEBUG
      commit: c2f61b8479b2abcd9e20f8bd4c46e54bb7f5286f
[2/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
      commit: ae8ed2b091ee8bd92da365d3332eebf159de8e0f
[3/3] PCI: dw-rockchip: Unify link status checks with FIELD_GET
      commit: 5e5a3bf48eed8d90bc5c5b710466f24663231f0a

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

