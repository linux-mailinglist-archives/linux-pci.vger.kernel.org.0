Return-Path: <linux-pci+bounces-41286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF58CC60218
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C647E4E22EA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 09:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63586359;
	Sat, 15 Nov 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck9G3ZR9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938062571A5
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197812; cv=none; b=fik0k+3VXNVb/FWZfNVahocF9tT+IPHiCe9Rq3+aKld8cAihUToq5yklFU5oBBFYR8hP6LYSwb0l2a7t9sYJ7oH0IJm7mRn/oC2YLICBciyeI/FdDhmr+UWJvy1ZhPYQOKkpK8+JSROdq59M6TaeWpKf+peSemeRyMue3nXR6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197812; c=relaxed/simple;
	bh=VtFvxecspVpi9dEIC11pQpnw1JMK0hZN47qWWkm+wHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fB5pETWkjmudX2bWqyNUJOL9dHt2hxXxaIkG7hO6OnfgA/tTvKay3bJQcHCUcej0/nBgoZ0D28JGwbH4+8co35BhfnSx8cq3eYwNfJXSAGQP6/dEv0d7/Ofyl7ffCP9CLk6tDDlK3AOyKTwNF4AM/vOIhwS62Q0KBbJg21c/N7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck9G3ZR9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so2219328a12.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 01:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763197810; x=1763802610; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADQAnSwvVC1ImIoBeUuLW2dj0lHsSmlBEy4wGW0y87o=;
        b=ck9G3ZR9Urnpb9sXGpqP9koG7gDgQxfw+PK4RChL/M0OKNQbVFp+x4V38WZjAkiZAu
         +UNq2dav8Og0MHEHlRTsOAAEhWJ6ht9V1edVDBg08DPFMqNc/G8n6bzKwkF9BMDc0pXo
         Zd87QwwJK0BJZLJaNreAfynYoEZDN+8HB+um2og8XwebEEbldn1wVmJRw9NhWL5SFQ9q
         hpzRmvIJ2zU3InN4ib1Eo4NX3sG4VHpRG6dKw5UIQKdqY4fU/T30IvYZXkNnvrys9Al1
         zq946SfaDJr5U+C7XYuezCY1I0hBdPy+8pwjscUtTkb+kVUkj2wqIm2n1RrlFvX1j8H5
         E9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763197810; x=1763802610;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADQAnSwvVC1ImIoBeUuLW2dj0lHsSmlBEy4wGW0y87o=;
        b=FRSg2y4Tf7r40SPorpW+YjF3rh6Sm8NGIEDW13WX0yMHe3CruOgBxEbAokcvwV6kS6
         7WhHQWs7VTP/0S1cfUCyyoTnY2oLBy62M4sG7K3g0ko85HNbncZdxg8k8XPb5d1g6WED
         CSXKU5Au75WQfru9pX1sf89arCLRP3UlIQ4CukmrOkxST+n7AH2kVPHVueXdKpC23BBU
         l3LUtao9/0qfTBRKzCVjCNND5GwNTHMBGmDxXrP3+AqdSQhfO5br5AWLqdofses3qv4k
         KuhUBytQ+6O56QEiYFqL0XIx9bOchQg2WpH50EidOLDvCTsqTzvFcKOzzm3971X4/Ssc
         Y7sg==
X-Forwarded-Encrypted: i=1; AJvYcCUV4fk5At1cTqDTEjo3e/NcI9K0wv6Klp8TisHZ485ACi4ZFHBepos6gpKRIkTPaZqGRE9XG0PG9eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJe8Hg2WB4zBh3phi4vBW45uAApi55jBHJpcxSMB7CKOaEQI/
	wes2WOYNSaOMHNvQfaMtjpqbEzKooabMXas6Up9ANU0J95Bu3v4yTmv4
X-Gm-Gg: ASbGncuXsFS+Yc2KNdchKQ/hu0+sKThhj/pwzNTktiXTJ4HgQjhdGhdGdgERvd7VCGg
	ReoQhzymo2Nep4A+vgHpuVERbfhjfRa1HBSnKGHRq8RrK7e0/Kmj/e+I4R7gRJSufKcnNxuogZs
	ZSj+LNlgTaTVnd0khKwQ55PbhoW/2jGDtum5AmV0QShH6O5jv9L09xhp/vE/jcUvZQpNlNY7YCC
	bGn2GGGmJQr4ya2bwwhswwZyersE4ZqUyZFdjFdENLIrNTUragv9uIfQJn+EDhGVWsdQUtfgbJM
	9oQVDi+jEkqgLXuGkairlGm2z/R8xS4B6bbmL9dbJ9qeKOSRBQwT5tENe27OYcN1A5wmp0mIdC7
	J+UfwFT+U7ENQe1J0W1JiFag3th3XNW/vo0sAh1ZoVf7g0QjkidEgl/KNUdzEAHlfnwh+SYQklA
	==
X-Google-Smtp-Source: AGHT+IHdjP02d7ceK6K3dpKetL3hR+ZP5vYC0Jlsf4TI9ATvPdblwdLfXK7WX2I855lZDI3z3GpW8A==
X-Received: by 2002:a05:7022:7e0c:b0:11b:9386:7ed1 with SMTP id a92af1059eb24-11b93868306mr476264c88.46.1763197809720;
        Sat, 15 Nov 2025 01:10:09 -0800 (PST)
Received: from geday ([2804:7f2:800b:a07a::dead:c001])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088604sm20965645c88.7.2025.11.15.01.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 01:10:08 -0800 (PST)
Date: Sat, 15 Nov 2025 06:10:01 -0300
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
Subject: [PATCH 0/3] PCI: rockchip: 5.0 GT/s speed may be dangerous
Message-ID: <cover.1763197368.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In recent interactions with Shawn Lin from Rockchip it came to my
attention there's an unknown errata regarding 5.0 GT/s operational
speed of their PCIe core. According to Shawn there's grave danger
even if the odds are low. To contain any damage, let's cover the
remaining corner-cases where the default would lead to 5.0 GT/s
operation as well as add a comment to Root Complex driver core,
documenting this danger.

Geraldo Nascimento (3):
  PCI: rockchip: warn of danger of 5.0 GT/s speeds
  PCI: rockchip-host: comment danger of 5.0 GT/s speed
  arm64: dts: rockchip: drop max-link-speed = <2> in helios64 PCIe

 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts | 1 -
 drivers/pci/controller/pcie-rockchip-host.c            | 5 +++++
 drivers/pci/controller/pcie-rockchip.c                 | 8 ++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.49.0


