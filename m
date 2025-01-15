Return-Path: <linux-pci+bounces-19826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7168A11A23
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1FB18898C4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 06:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F922F837;
	Wed, 15 Jan 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLOf31fG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A322F3B0
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924004; cv=none; b=ZYpIcJ5oMlTR82eUCxBGo2KK8+/TY997mwMIZ0dBxiY52W+5nwAr7m8gsUL756Hmi4/CsxGLGIcTkaBOPAgoFlOjESvsrSjVeml4O4MfeyvZfGilZ8CEQ4HBjU33IgWJh1dRUEFi5gbgZyU8ETTlA3ZZlI42sFWYZCOVLXwX9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924004; c=relaxed/simple;
	bh=lZtdYvwm0/D+wrEsjVubJTTYAK+wxUZeR9nJ3jVsGl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PvNtqAXRYaTd68E2VnpTjNDonDb2XW/9UM2u47LVh3g4ws76D3lI3qS7eGJP/GPK+QXS8FH71Rld0sM66qywUmiW1OyQLPUwGc9dd2/ED6V6Gl7Er9Yo2ODQGPeoxmR+/5djtTz92qPvLjWtmiVTWz7dIrdnG8LrR2RC5KXs0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLOf31fG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so10743379a12.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2025 22:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736924000; x=1737528800; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jHKviSWbOJnThNL+BRNc29xaYnK5sB8qfkKjQ020pY=;
        b=XLOf31fGgX/FS5ncmoLi84Csb4BAl3+99Eu2RWNBz/HZZKXx7tFbk4vkvP6gQ+a6uU
         HGBEdEVqUzh1dIFzfAD6rppY6Ot2wIM/jZM55GbVqVJWPwu08/qXZhxgF5eLnzCZfVpN
         6VLp9XayHP5ZTaqV+04cguwo8YbI7qYbWkJU6J0hO5AguzDoIe4mDg4IXVdTnuB7Zuhp
         AyaX7oky33O/E1S2RyPEQCdVUlm7tvLSnNRioamXBUJ/QaIY5o3x5QQZTzI9ofNMBAde
         C9pGUyv3vePMsQDXb1cEBSzke43LeUpAOldPAURV1DDe2hi0JAPWgxKMhy+5cGgdC7Ot
         uAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924000; x=1737528800;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jHKviSWbOJnThNL+BRNc29xaYnK5sB8qfkKjQ020pY=;
        b=LcwYmhhf0eU23TkzJATauXtQzDaCNI+cn/kzXxaq6MvbG/818f6NiQJNDokLr+2SeW
         gZZYQ44nb9+IPDLZ8TQHVXKm6532KMs4rmWfqRozH8LZCn/IdEbFZgadLKa7ppzRafVF
         N02JpDE6ADIr97xs7gZrF5MG05g7PwequXOdGTTGk1MvKZ0wUI6sV6NyTGcabQfKLHr0
         ri8RARUrGTR6VxOWWZeX4AlnJhFaXo4povKlnIhL/ZfDf01YKz9PsxyEyUu8zqEjxuUG
         4MRa2VOfTqvp/KZcJVM8LXfX7sG60+BUgaGOCCRkllfp595ZQvaXudyw6srxJAk7WG+n
         dRvg==
X-Forwarded-Encrypted: i=1; AJvYcCWfWpj0PMqZ4EdpBXRelgRKGmpgl75voxSrRNPAZ8zEvbY8XqsVh3lPzhG76KFExWXF+OeKRWd5P8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLt3BJ9xYado8iADZQ5OmGdGahiMbaQR8g7J1GKWMGS0WUB0H
	SjdXExuuUX4HPs55Qrbpx0bNFKI4b32PN6oDWXjZm6ralue+Mj2/1FWYURJogQw=
X-Gm-Gg: ASbGncvkfIEkRe7b6QdAHCbxmms2+uBr7rpdenbVK9uNaWvRTdmfePQfbnwP/Xj9qM3
	icSQGQoS28L20khJjuXoP5fcwctR+cKTlwU/y0zLyka8ZkNKTa3MMzAoc30ejNw/nwpR3hsjym7
	ScWDzTBnIzL7R9qjugTLNiJ9QnUvvYC7XkWQjpqylkK5/GnnJoZB2UY2CRIgyxqjtVps+y5GDBI
	yncKezycIaniyi9SRBBTivsaZgSQ9cSV4lf+6HG2+IgNpTssmGVll/lS5ku9g==
X-Google-Smtp-Source: AGHT+IE9P5PDtBvyWPxhRNEsLiyx/nfhdVfXbwMkWhpN/F7zwvZlvMv1+220NOQBetuNrhffj43vww==
X-Received: by 2002:a05:6402:518b:b0:5d3:baa3:29f with SMTP id 4fb4d7f45d1cf-5d972e06740mr26199332a12.9.1736924000495;
        Tue, 14 Jan 2025 22:53:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c371sm7145838a12.11.2025.01.14.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 22:53:20 -0800 (PST)
Date: Wed, 15 Jan 2025 09:53:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] PCI: rockchip: Clean up on error in
 rockchip_pcie_init_port()
Message-ID: <7da6ac56-af55-4436-9597-6af24df8122c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call phy_exit() before returning on this error path.

Fixes: 853c711e2caf ("PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/pcie-rockchip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index fea867c24f75..35bfdf3e17a3 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -132,8 +132,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 
 	err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
 					rockchip->core_rsts);
-	if (err)
-		return dev_err_probe(dev, err, "Couldn't assert Core resets\n");
+	if (err) {
+		dev_err_probe(dev, err, "Couldn't assert Core resets\n");
+		goto err_exit_phy;
+	}
 
 	udelay(10);
 
-- 
2.45.2


