Return-Path: <linux-pci+bounces-40081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBCEC2A2EC
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 07:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50E43AA005
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 06:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE52296BAA;
	Mon,  3 Nov 2025 06:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQQADloH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF82949E0
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762151255; cv=none; b=hMusZD5YJIpYWagqGPOWfkp4VT95OcEMbs7Ofei9bMWwiyDyyszZADEEELUKEj3CQRiAJFr8gBTlJaxifg/Vi3cgiaBNJWRgZOuffSVMdcL2qjIaDIJz508HM9rdyOFymHAB6aJn4sFkyrHf5mmt0yr/NvIGSO8cTyxPvX7aSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762151255; c=relaxed/simple;
	bh=9CT03J84ZWljzRjqGZlThYttEkMrtc79ah/qp0eHENA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHQo8JvqqYR2moRkCWRwIOt7NP8vbpPKPzRZ8IRCw9T6gmXe3hlrNelfwxfAXxStaw+/MGMTHMsq6be5d7dhufDP7nHxj6ji5hwCpVB4YIHFauonAw+eqVvzuLVKp2/VAHrepn8zuaKflKucSCWDtrg0WDSJQzbOUBUgI6d4Q4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQQADloH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2953ad5517dso23560475ad.0
        for <linux-pci@vger.kernel.org>; Sun, 02 Nov 2025 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762151252; x=1762756052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fGQSi9N7yhCq+36qhzFLEOuP4uo/epjBJB4vjqFx0/0=;
        b=BQQADloH0VgR+Sp6h6d0IoHkZRYJnHtu8dM2LIn4h3AbGemeUEs+WK4B9+Q6dyxbst
         AsiIeIF+KkxrfWD7qCUXxQQjn67ojLrmL5rY9sZkLWggIfXnjV6iYZVU9G4IsW+FADXS
         Mo0tVXYW7uv+VW26GSc9o286dy55NS0E1WNk3SVcPYUn2VjoQrm3ygf7MYjlkXeHEp1D
         DxLJMWLPX/JrV4og6/YQ7nla0slDzp5qxmViXskAyjshLvEJoWekQwLRBSy0as+7l3il
         BK2iT8mPVKgpJ0N3j3yBAVsJcsNhuf6pu6fpJKX4cWPjRHSpEoNw/tjta8hrcD8Ec44N
         X7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762151252; x=1762756052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGQSi9N7yhCq+36qhzFLEOuP4uo/epjBJB4vjqFx0/0=;
        b=MYI5sHOt+DYWTGH9FgsNDXsbN+Oervbx0zR+WoUZCCcHr8qlSFlqNXYMRITpUzzo/V
         tBCFEQAf+jL70EyerscanTlGDOAm/gNBGQaBlTfw0A7dLqKhx7xbfOK+QeC9/n8j++kL
         1Yilv6GSnU2hdIj0HkHI7PYbMkKKIH6j6uEYr7UDu9Z/8y956jXhGpMZYE+U2IKf0fmQ
         GGUG+2uNjr+frWao49pEmTfvvkkVv+xYEBCVX4NGZHHd/gUrnUX2/2SBWedgHHQsXQy2
         xXQRXyf4GC2s1EQCYFcC6OIZba2XmcgYtaLhsMKfHWFGm3EJn/Cnp7p4DtMQUx0F45do
         7mUg==
X-Forwarded-Encrypted: i=1; AJvYcCUkGzgpUcuN1b/r/Q3EM8DG7hG9NjYpAzXAzLpFZ5uRIoLDwqk6UA/A3fd35Zt0uyawkFOnEfmUuk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvqMwGrWRsRGblr6SHyFZIx+Z7XrwUUjoDka1JeARTjnBm0Ns
	yAl+NmdHvOuBgbRb1FpHOY2/xV5dkm7ZelF9IHAhgyFTThl2RoPh8sdr
X-Gm-Gg: ASbGncvlh5e+Z+NZjSTN6/4x09YSHspDRE5OHvWQ/dHTCFmPWARZRU0k2RWtstQaYIz
	LO89Wdwl2qHVTFXTy/ogS2Phk/wSuFv27pLz/umyplKsJu8MlpxIgGJFHBcKRtrFZ41d2PqgI6z
	X7+r8Txv8YbCl48v58EOOUbCrrcNU0PaZ342BgExp5twkTkVpns3fwAXijv64u28CyTkLSMaj0F
	O67sI2TBkNY5ifgfQQccYoFf0SyqQGLnx+BPWw2YtFCxlIAD7ZjUXBJgCPLZkkNqZLtbSyqpwLk
	YbRagyP0IbkiOlxBy6OpmMn5A1zHkbf/qNDvRV6dQ1gGfxsr2Ssuuae2ZteTcYz8HaiW3LuWWJd
	WwwEWPyXZMlKdy+y4jxgYhRZN5TwwJDA6aws0w71zbIB/cYoV/VzEIVRk+BHe/uFfqy9VVcWvQc
	1k6tLAenTs
X-Google-Smtp-Source: AGHT+IHygtYx3odpw3ozCs9WNVhh+vHH36qWHi9VL4Po+sTq1elwFX207ryIat6ht5qVwQ7NnSvjZw==
X-Received: by 2002:a17:902:f709:b0:290:29ba:340f with SMTP id d9443c01a7336-2951a47798amr138513945ad.42.1762151251610;
        Sun, 02 Nov 2025 22:27:31 -0800 (PST)
Received: from geday ([2804:7f2:800b:fff9::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29564fb5214sm63355205ad.11.2025.11.02.22.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 22:27:31 -0800 (PST)
Date: Mon, 3 Nov 2025 03:27:25 -0300
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
	Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: [RFC PATCH 2/2] PCI: rockchip-host: drop wait on PERST# toggle
Message-ID: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>
References: <cover.1762150971.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762150971.git.geraldogabriel@gmail.com>

With this change PCIe will complete link-training with a known quirky
device - Samsung OEM PM981a SSD. This is completely against the PCIe
spec and yet it works as long as the power regulator for 3v3 PCIe
power is not defined as always-on or boot-on.

Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
---
 drivers/pci/controller/pcie-rockchip-host.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..6add0faf6dc9 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -314,7 +314,6 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
-- 
2.49.0


