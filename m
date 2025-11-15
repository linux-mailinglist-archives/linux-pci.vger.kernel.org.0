Return-Path: <linux-pci+bounces-41288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F136C60230
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A09A04E6793
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE226E6EB;
	Sat, 15 Nov 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqQ6DbKr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F825F98B
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197845; cv=none; b=jk+BpBW9u3h+Jd4Sq4xtooGGr2stSNTYiV+2jRpsbSQMcpc178J//Em5qeOl9xGEvBtlI281kys/gTyHH+KRDRJB3lfu1Yt+7J0SmwFiFUN8612yiiY70uIB+aB9DV+OMyhq5WjJ26fJym2QmYAoQRhyHWtJNDvtPrb74oHVaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197845; c=relaxed/simple;
	bh=aLENdR9BSNy1WQU19DJ52igohwKCfgQbrHgW6IuMOew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvrmHy7MuvxqP8Bd/Lgng/g1GjsM6LHT/55IpbQC3XoqSy62SedEy/I1luaZnUUDjz+oJwHZweIP1erkLg+TGXCHX9kQJQTW47OaUVLKl3jmUprDiRMqTOAF07MOmIlOvGhM59Lmb99yxnvBRX4uESQmjGg/XWkgHZADFmWJMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqQ6DbKr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso1629274a12.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 01:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763197843; x=1763802643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43JeYWuHKtURhUFg3KcuzTVi7n2XDdHqu+mEl6pMXsI=;
        b=nqQ6DbKr69gy188vRPsydq4jQPVQ7FD0QJyyvri9d0uE7IK2QFa9xlrWh0l1LJmh9m
         CiJqAsns83qyQVXS65tm0wC4UnhlCKi3C/Ac3QC5I47omB5fSx675k90H/Hvd3s9MOyh
         bUcBf0RNaVwJWZLrpALCFh6ZmSPgTJ2Ytfo1Hd5Jp+McvsVXMH5h8Itobi6mBMnb3/tp
         4QN7+djhcrECGamdVvmJKHuzFMKyVz4vq3SKV98hcIr6otRuqchM2X4anSYq7LNEIDzQ
         +KnoQYDOXEwOJIzDSIXFEIhapxDWQuS2ulg8bjqy908Jf2MahYf7YzZzloNqKTPg4ADQ
         iJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763197843; x=1763802643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43JeYWuHKtURhUFg3KcuzTVi7n2XDdHqu+mEl6pMXsI=;
        b=Pu+KRixEyTR3wLnHQz1t1cTe9mW4pb/ro2/JtAjzz5bj7KqAOwWHpTGrz+PvWO0xT2
         S1ULSM2eNlW0W2hg3ntU4KfWpZI/FFHsCs4lDJPi+HJzE7LVBerRqepMA55j1AR6wk4n
         h4dk9Mx26tQKhI2jgZxU3JUj2olNIsHef+LsZ+69/UFBy7er4m5xHcSlLt+W9WS8LRVW
         cQ7DbREv80izUctr1q3CAgZ4A6Tix3bulVNN2e+0T201UVxfjLvrf1ieP6poHP+IfImd
         vZxIi2pW+wL4t5E2xhx37MnUo+yQyvwaOFNAnmxw8sGipXXj8SftnwkYOxH4NyE69gJQ
         c/IA==
X-Forwarded-Encrypted: i=1; AJvYcCXxn9lMVM9lzg1PP4fqBtQi4g5F6pYG3KNZcN+hyXhT51esLx5z5UMqjB1wfTJarLkxMJmT8DP2Yh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzBqC1z8dx61C8tDvXEcafxKoOtCXxR5vRHNclB2Wi3H4ALqn
	Bppm9czq7+fbkLRawS4sACPI5+WcacaxYNQuBj4bOieV30fmi5gr9qVN
X-Gm-Gg: ASbGncurd/pGaDHADSmLYxhu44rEYXPIjigqZST/OEIiArxG83d27bfmyZHeQpVavmM
	DcDlkzp8Zs/ET/Ue3yUl0ayHwJVm/mn/ilCP5LmKSPqebMvOdi/vmWM+BE1BDbUZxggW2xpuALE
	CAwMlcY0DdL+ktBmdHMhoshdJzN73nh1oPoqZdqnY1Ls54HeojgTAfvzqR7PCDY0hxpaF+phm3b
	buFmBH8fHIkJlX9TnmHS/nfHwlDVaCSu0Ap2rQG3NncROw37c2DygHNhO862jlaDjJS+7NRK95S
	QFpQH5oYQr0jUZAp/GHX53ZVfqTRXZZZhWs0cyODG/yYvVLcA4pu6HIcvpIcwzyK/OPxLv45TP/
	7MWGcDB3PuDcBsXkw7Vp4w4uMQAnocC7dbzkzPiGy7HqS+ykK/rty0Dp0JCkVfEk8AsD/cb5+sw
	==
X-Google-Smtp-Source: AGHT+IElHt3OAfMQunNnxmg0BPEu4aQyjchDbhYGwGxKZcOlUa5P+fzvsHcgcZg533YgbRMtBY3msQ==
X-Received: by 2002:a05:7301:5787:b0:2a4:3593:ddd7 with SMTP id 5a478bee46e88-2a4abab9ccemr2414709eec.4.1763197842582;
        Sat, 15 Nov 2025 01:10:42 -0800 (PST)
Received: from geday ([2804:7f2:800b:a07a::dead:c001])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d695821sm22796380eec.0.2025.11.15.01.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 01:10:42 -0800 (PST)
Date: Sat, 15 Nov 2025 06:10:36 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH 2/3] PCI: rockchip-host: comment danger of 5.0 GT/s speed
Message-ID: <b04ed0deb42c914847dd28233010f9573d6b5902.1763197368.git.geraldogabriel@gmail.com>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763197368.git.geraldogabriel@gmail.com>

According to Rockchip sources, there is grave danger in enabling 5.0
GT/s speed for this core. Add a comment documenting that danger and
discouraging end-users from forcing higher speed through DT changes.

Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..7e6ff76466b7 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -332,6 +332,11 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		/*
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
+		 *
+		 * According to Rockchip this path is dangerous and may lead to
+		 * catastrophic failure. Even if the odds are small, users are
+		 * still discouraged to engage the corresponding DT option.
+		 *
 		 */
 		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
 		status &= ~PCI_EXP_LNKCTL2_TLS;
-- 
2.49.0


