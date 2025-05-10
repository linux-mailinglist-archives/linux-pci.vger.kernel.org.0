Return-Path: <linux-pci+bounces-27538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5CAB2189
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 08:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0AB3B0FE3
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 06:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110291E1E12;
	Sat, 10 May 2025 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZ2geVB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4991DF72E
	for <linux-pci@vger.kernel.org>; Sat, 10 May 2025 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746858403; cv=none; b=oZ3AyR4N092JAgCbijGnzpZn4o2JVHM0yj7f4tuMaPinVBFTrmDjnoZ5avJZ7jqXJS/BPNNEd7aYth/ZnS9mncAUnVlSvQzDDs/On/B9GDuudY2hz9zgSGERuDuBi/+kJc+HPdZWAXB0tTTW6+fgmx/wg6HQYFuKkLrZMgNh1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746858403; c=relaxed/simple;
	bh=gNEeRP8mAhgrRFkzqhVHnS8wxj5hiHI7YASepNoiViA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luG29/RmJt4U6/1YPe4dvaGvGnQWdLZkMOAbIMWTntDX44C2hr3L8PZkinENJ31YDwCfm/WYlGvg6udWbzecC+ooi4ZavmjFMW2JkxfjkZeGkNMYL8qFU64ZGKXSeFz3uxBtL8VBNF1DyNWc9kS5XJpjY9OeKIoQYPOMuybg7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZ2geVB0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso27689735e9.2
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746858399; x=1747463199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TC7lxh+szJyHIF0miY38yzEj1EvzlHkiCZowZ1EXMgo=;
        b=fZ2geVB098lLkFXJ0iALI4oylox6jNsuSxEhWIhKs+PeZq+hXhXhO8yuaTC1f4xzTC
         JLFymLIsYw2XpyY/KbpWSqzjwaOUVKSi57fbdZYrJfuGcdiXNmI1VrSpV6bgJyhaD4Ow
         RZVX4LBN3tKowTc4tbviioq5kvEkHZTL2OAOFgrEXgOwHzyPid09AEBUAa+eipsBnFUc
         ubI+fYu2Rz+4rbXJtegbnZUoqneMaPU0n/imV7Un8CqZMtj5QrW9+SO3j/INxmg0WUZB
         YDAO1rEGDyvGClPP3zF9RO6MF5rHs8dY5JOyhgMNCg7Wr/B/7J3PxuSNqVLURnfRHwJl
         B76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746858399; x=1747463199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TC7lxh+szJyHIF0miY38yzEj1EvzlHkiCZowZ1EXMgo=;
        b=hS4WOREYMiZMhWkPsb8AgOu0mtrPfjvA52boLId7y1/f6mzgh0LDQ//N1w6sE+3mV9
         XEt/DxGJTXxcBysdXN2XxkCUCqWaiFX2tDH7GcMi/RfBlBuCX+NIBeSAOKP8cmVVDY+O
         4nP7Iijt9ZcKJ8Ht/KTVcARv8PAT6vl2LHjEqq/iFmvG8MNnvvqAAxqeanZPJSICFWbm
         ElZ0zhciba7m69CMj7Ec+I1mXbm3T+sAjiolsww09XZoG6qzYtyBWAG6f833/5WsU8ri
         kmjDvjdFaIZlcfgxEazYrkpQBRpuWzlJRXXWZPcJuO2V6zqrqX1tG5/MISr71ZAbug5d
         frWA==
X-Forwarded-Encrypted: i=1; AJvYcCXNwFr8OVUdMkZYMeAxScwiwLSP6xVO1J/1t9/UR50SFs/Zg78rUGJ/jz9WYTGPiIzVK6zZJjcWr40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xtO4OHOLortkDf0a0OdojpqDaMb2LiHauueiJos3iQdk2Gq6
	RriILpVLFzbpdkl9KEvEKaOzxr5tCBv8WTD6LAajfTkBM+Lt1JmxjV+ckKxpbQ==
X-Gm-Gg: ASbGncuKE4ipCh5iq879vW09XAQrSbixZzobRq+d0CWG/0aHh+Jxp3H0yCjL9oIZTMi
	lv7AOzBp/c6+U2sD267+HuwCmEGzhdBZtmmNxdW4wJ2xRc9CKwQ2GIhv1igsmH2tVV2KcW3VP+z
	CbC5zoJ9n9a2pHHCIhaIJc9KEnTaoSfw9WuLrjeCQJxjR/ZNrXYVDcJV4lqbcJBVN9r+Ysikr/E
	nn8mremsgARgERuIoxd908NtmZFO5LQsBET0HELVeir1knuSnY4FV9HkZVgnmL29NNZWaGEakRS
	PPoR7sfQA6sBwPmoOOO79EBh/UFCTEn1ryw2wVhFGS5pmaeDed7rJq7Db4LPGrz1rX4FIFQNvr1
	j+0RJZXw1tbO2ZrPXwcdfRIY6sVleAR+aumcM
X-Google-Smtp-Source: AGHT+IE+2HRAOqGjukyBpZGu9Jr1PqwNh0UZdkOulj66hKHxdz7J7jmR3KvyGEl2TsXr+I8lrINlaA==
X-Received: by 2002:a05:600c:c0c3:10b0:43c:f3e4:d6f7 with SMTP id 5b1f17b1804b1-442d6ddebbbmr39681085e9.31.1746858399483;
        Fri, 09 May 2025 23:26:39 -0700 (PDT)
Received: from thinkpad.. (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d146af31sm86116175e9.17.2025.05.09.23.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 23:26:38 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: Convert v3,v360epc-pci to DT schema
Date: Sat, 10 May 2025 11:56:35 +0530
Message-ID: <174685839013.11086.10599416175883507159.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505220139.2202164-1-robh@kernel.org>
References: <20250505220139.2202164-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 05 May 2025 17:01:37 -0500, Rob Herring (Arm) wrote:
> Convert the v3,v360epc-pci binding to DT schema format.
> 
> Add "clocks" which was not documented and is required. Drop "syscon"
> which was documented, but is not used.
> 
> Drop the "v3,v360epc-pci" compatible by itself as this device is only
> used on the Arm Integrator/AP and not likely going to be used anywhere
> else at this point.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: PCI: Convert v3,v360epc-pci to DT schema
      commit: 9a5f8c7a81cde01738d4fa25624669a3d6f859e3

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

