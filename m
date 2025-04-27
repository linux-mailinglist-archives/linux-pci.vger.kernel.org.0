Return-Path: <linux-pci+bounces-26861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F834A9E2AF
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 13:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32BE16D8D8
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90E21CA0E;
	Sun, 27 Apr 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ni4hIipA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7D1CAA85
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745753152; cv=none; b=IXYNLb0GD/hyVBf7sOLYac9PMPLBjtQT76Rc2fhM7ehL6dDZJMh4qYkKOt7tlVP6RK0uxPVhZn+0VJb2M2Jk95OYBpC2GOmtBYYVda6i7ecDw2egL7gOPoUv5BolVBE0OsP3F5FvFtXSHIhd5TDbPctO6JADQmBqWu8Xc1lQHbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745753152; c=relaxed/simple;
	bh=9jLdU0ShcH+zQ3/h9CltTTKZp/4AuetOqtbkB81To0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzqQbpWTuNjla3B3TQtTvWVRngIKvRW9Ef+VgJvW6f/C2P4V0oxwJ4Na/18BHoXlnJzSsCY5fNMf00B6/5fttfZRTqwCcOj8Y4WpcQPoRVsJSOAylnZJiPFyGSHbH2TP15bA1+pW31HWQzWTLggpbliySOkq74J5aOgP5TlVwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ni4hIipA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3688994b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 04:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745753150; x=1746357950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQYV3EIyVPg42bC23m1Mnam5opgSlxj9bzYC+y7WKkI=;
        b=Ni4hIipAIaMuEB7acZv0USgs/tCt2W32y+HZVQ05z5Zw4SaORTmGnUopBZZpaPsscM
         SMicLBPwtXImtt2G1iasyxi/XdsJxW3aFuy1yBkIWUFla172uPWBanxVTW7pjjDaS+op
         VknC6xeunISNJ3Y05ec6KOSIWE+xQcQ367cmj5nxRegV+dsUvCPKTTFGZ195btRvHPsy
         xLV1cq67R1zlN3225aovuaoilfvcyQCvgJja2fenYCZuDmG/L9Zt0/Xcb4abn2qip6XN
         lJAhoNk4kW2Af/W+GzZePXMQlyDL9YY0YrkZSfMD19y+J08J4uN8B88XR/t5ifYBzWVs
         /2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745753150; x=1746357950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQYV3EIyVPg42bC23m1Mnam5opgSlxj9bzYC+y7WKkI=;
        b=tpGDN/hWcdyX3SUzJMydr0WgPGGHGSHw1FE6HYScSmVpK4y/hrm+7ceBEMxIX4X+qf
         ptc+KlHobGa+WDNQEPD8ptQVERtLUjMbqX30yDjkNm4m67MSa/aTPg+c/pbWsecQnt+0
         00EgnSBUuRfq4F9Pex27IrDlepkfq6QTyVD84n1AmbL3kbCi0oq/neWKcrR6jiUUBPkL
         1jSc7F3nmu8nl/FsQbo6Stwud1ouaTgfBSaPkYhxzpzXA382olgn+EKanjtzKrMlGBA9
         AVMaEOa39Yy5anYQJ4L1TxuEEIi9HHBYiWgL8NopCbQPskgcdAqmvKBleKqyffg8/DbJ
         TsxA==
X-Forwarded-Encrypted: i=1; AJvYcCXPNCkGNS71f5Cf78MMxiHQHnX7qAk7qEmKMbruj9av667Sfz3ZdAyLwGvrEBOtrS1L4D3/gO1eV68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFjyt9Z95XzO4dg6GrKQprV7pJ0C0HbEFZTzyrquNn1lECdVX
	Enbbp3sju1UG/KhYW4cpdlJOCZ9t5n0TWxyodZyVvvu3TYdaaH51ls4Qf/ORew==
X-Gm-Gg: ASbGncttGzS14MNlTOFwlJKThJ8zBaCDEfF8U+Wrq/0iQdn6rYza/ht1VMQp9gJa547
	9QiHrLxP83gXNzWGmNZuLAuCnI2BabHURoQKZbB0fEQOOyjrz8ihQhSv1oMVHEzESGhXLEyTk19
	uwc7vNMInpZTdY3+vjHzU4fy+x7qZFu4UkmWqbjlchOYM4anlXLfjRCDG0GiJ8d/6bgq3r8VEEW
	IrCQDv0+5xPx1Pk1L4sUkrMlt8xod0qxI8ibuSgTNgQ4pmqv6xwWtXgqyoJ4b0nrJJbk37h594q
	bfKMpN1uxQuvCUvLlR4VR69wbPCU2N7VyQfWo2v1JbCIrJxrmuiRI98=
X-Google-Smtp-Source: AGHT+IEYa9OXl0m7WgdPrkpgTKQAuQKMq0hHKYg0gsShE27/zhcRjCle6lSAEHyMrupw4FZzLgFpLg==
X-Received: by 2002:a05:6a20:9c8c:b0:1f3:3690:bf32 with SMTP id adf61e73a8af0-2045b6fa2demr12192685637.18.1745753149900;
        Sun, 27 Apr 2025 04:25:49 -0700 (PDT)
Received: from thinkpad.. ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a99454sm6050067b3a.124.2025.04.27.04.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:25:49 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 1/3] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from rockchip_pcie_link_up()
Date: Sun, 27 Apr 2025 16:55:39 +0530
Message-ID: <174575041409.8328.13550522343316426453.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
References: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 17 Apr 2025 08:35:09 +0800, Shawn Lin wrote:
> Two mistakes here:
> 1. 0x11 is L0 not L0S, so the naming is wrong from the very beginning.
> 2. It's totally broken if enabling ASPM as rockchip_pcie_link_up() treat
> other states, for instance, L0S or L1 as link down which is obviously
> wrong.
> 
> Remove the check.
> 
> [...]

Applied, thanks!

[1/3] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from rockchip_pcie_link_up()
      commit: 7d9b5d6115532cf90a789ed6afd3f4c70ebbd827
[2/3] PCI: dw-rockchip: Enable L0S capability
      commit: 198e69cc4150aba1e7af740a2111ace6a267779e
[3/3] PCI: dw-rockchip: Move rockchip_pcie_ep_hide_broken_ats_cap_rk3588() to .init()
      (no commit info)

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

