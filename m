Return-Path: <linux-pci+bounces-27626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB11AB4FEA
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 11:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2684F169B50
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 09:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B426D221FAB;
	Tue, 13 May 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ielAvCyD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52021D3F6
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128849; cv=none; b=K2K+yRFT62GBbh2SU9BuXzX6fA1bBAQJAO9qX5k4EnhH85n6/zORE+QvyxHSxhNTB6tPKf+8Qji80MBvzJgBTRE78Oa3PArfrDtMhD2vl7VtMwd6Bwbbx0kEujtUqyPaUr92HJUoK/CcKaUS3CXlSYYe1QkGE7/Vhbg+6yIq2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128849; c=relaxed/simple;
	bh=tUgWNobTErAVo6QgwR8zeq6EqfrQmZtSn01zmDBaNVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncDrqloNgClMauo/K2j4/NkfaWNZlYVAGx+1y19dFWDQBJNmb8jIMNhtO94P2D33Hl4AKsdxSzzaEq14iYF2YvUYrgZGVu5S1ZQE6sGzGOsZyoaiORZkic90JWXi5VTzFat/THC54DkLyNqTg5VrdB/LI8Wghsp/icPNYb0oVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ielAvCyD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441c99459e9so36238535e9.3
        for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 02:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747128846; x=1747733646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKLjJkkOmyMYol3wkL9rwm97Nlx9Que+3BhS5/1Vn8M=;
        b=ielAvCyDCeE7UEzvzXNWQfQ+m4JkLr5Uag16tvAVKJktlIVslHwrCnkd7fjjKtxlUh
         qWojPE8Po8/lWYFSQXslL2q++Svrl3m8BDoaLId3sAqaKD/puJqbqif87jwrM3RcXEzW
         x7IxUMrxNhaJeIWnxrkwGaWtUY3uIND2ADQSgX5Je4mAxSXwworqaxQvtSAmaPHpCK6E
         dQRwKBoqT6s6Z8fdap9EhDbxJtrgkMEnXie8tuQ4BJEW8kJTTTJSWWGd/+LH6xoPs5dF
         Opz4cPvVjpNd+o6kmkOonggXb0KZ2vm4FcVD807YeezzzA04YwmxbW6pN0Ru77+OS6Zr
         lMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747128846; x=1747733646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKLjJkkOmyMYol3wkL9rwm97Nlx9Que+3BhS5/1Vn8M=;
        b=SY3xSAmCAPO5uV5YHNziq1yBOYketv0+XzEBkl8lw38AMSZHbP4bQi0TLgDNONj2Gx
         xB2hDy1dOcDmC9ar0xRWUOJ86F/hSkSh0wg10qnoRSiaq0IFwDCXmk5DRM5A5ZtzPiue
         BDyqNaH2B9sxFJ0HEMcqzKQ5KmN2GYBSj+X26aapP6r3b0u26kLvs+GB2FIFV+JL80nf
         lip9Irfc/08BT8O/tGCRPdKmVsrSwUZshpwkloqGc0w7/dWbiSJW8P+kmq4ZkcaqqW5B
         WCKEjjpysil0N44OQGc97HiH1pL3ZSJZns9W6MvCBsMF8PETVIiZpGadZ72ZHUxxcuZg
         TN5g==
X-Forwarded-Encrypted: i=1; AJvYcCXUBvw/iCr0ON9yuChMEjql2MqRarmV4j+cfC0dkvtfIae/3usZVbU/CrVNUDaZazUxfN7Mra9xne8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXFu9Rs6cqAYvQgh6W8D81a6DEDGQ5GSoAn+KWO6bC4FA9DSi
	bOT9ckDOmZ+XFmC8r5MM4xe9AbO/6wtnp/WVF4ldNtVVpJsV/0s19kNEYrhFZA==
X-Gm-Gg: ASbGncuvnlbxgdEGNuawV068lHr1dvh7oxiTF5Q41nACSuWEA6rxwMOucLP8cqmfAqO
	3zWcmdlH+xXHJ2Aw4ML8TJwG8MC9VaHeN6A65ZjKNxQjplLsVhrKoPrKi/121v3yvRn6dlxKKcC
	wWiDxugvJgaPJhOHc76Bgnm3+lqB1wFp4y2GHAoXsMUKQvXVpJVXwtPO6I3VPiLASmXpzhTXd7I
	pXo5TtS+1O2o2Lcvcw3I5DaQAx9e5NIuL9fdvTKuOfqrcuGgS8u5yMFufmX6xWLZqPhUnm0TdBt
	xohcfohddwS0CvyrFNZj+APfsTMiwsESDBeSsOQby0Hdd2Dq91Ull/obObhd8CnXRJQ2PrUpLNb
	Z/yThiD2grNwx5PYJ/embGUssR05zARyyn6xZ7QeSXT1w
X-Google-Smtp-Source: AGHT+IFcpAPpjaQ7VrhkL7JIJO04SMSGcJ+6baco8/3c5mXgfHi1+GY2RUNB/Q5DM6k/88scdTeyeg==
X-Received: by 2002:a05:6000:2481:b0:3a0:ad5a:58f5 with SMTP id ffacd0b85a97d-3a1f6429677mr11857079f8f.8.1747128846006;
        Tue, 13 May 2025 02:34:06 -0700 (PDT)
Received: from thinkpad.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2c8sm15609738f8f.61.2025.05.13.02.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:34:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	cassel@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return bool
Date: Tue, 13 May 2025 10:33:59 +0100
Message-ID: <174712882946.9059.1080501209546808704.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510160710.392122-1-18255117159@163.com>
References: <20250510160710.392122-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 11 May 2025 00:07:07 +0800, Hans Zhang wrote:
> 1. PCI: dwc: Standardize link status check to return bool.
> 2. PCI: mobiveil: Refactor link status check.
> 3. PCI: cadence: Simplify j721e link status check.
> 

Applied, thanks!

[1/3] PCI: dwc: Standardize link status check to return bool
      commit: f46bfb1d3c6a601caad90eb3c11a1e1e17cccb1a
[2/3] PCI: mobiveil: Refactor link status check
      commit: 0a9d6a3d0fd1650b9ee00bc8150828e19cadaf23
[3/3] PCI: cadence: Simplify j721e link status check
      commit: 1a176b25f5d6f00c6c44729c006379b9a6dbc703

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

