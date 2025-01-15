Return-Path: <linux-pci+bounces-19873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB95A12278
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953B916C72D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027F1E98F7;
	Wed, 15 Jan 2025 11:22:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59C248BA4
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940161; cv=none; b=b7ZUvB6OkBf+gmiJ/pzzgysCrQU7aOnqMxkcrhx5X16YchcjsILQ2TfNX07DJTw4jCjUMzepild6+4cXgcFt0OftwrCkRV4HnRsAFo4nkCiixgriCM6wsYUAdVaZghO5B/+QnobQ0bfvIvpRah4vK7VNMJjIrgJvNzMZfjmhm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940161; c=relaxed/simple;
	bh=XBUiGcKFqny9EbMEYfSc684qteY275fpnHUTn8zJzV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHngKSE6L9L586+eXPJHEEzZsM4K70aLvJKWs9pKTvRatfZVSJE73+ELFpZI32mFtfwBTkFlaNomS+hNo4zapEg3b1OnSSD7kgfGz7zbqIWc9nUjM8AfbQmwMlwW58NmmusBLrvNl1OgipxhHSw+GXvcc4HnIm0zp/xBaAn7pJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21628b3fe7dso112079265ad.3
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 03:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940160; x=1737544960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdHRAWZU5RvyobFuV6RTA7jKM1EALie4R5bJcqyxVa0=;
        b=UrQ3Tz0nHCInvaGEDLOenWvTeQPjc9KzpwRDFhC/0/ohQNzlbrz9wNuUSAD8YYkGon
         tSL1UJcXQ90LCAcp2SZ9MUUBYCsJQ2n4BpDDdrh6FrJkzuIdXFV5RpvdnktokOJMFFW1
         E76RfehZB4uJJxktKi9EHGv8n4qBkGPIF6q4WfDGDmcj6ygj1q3tXR0EPJIK5IiDFlki
         lvpCdVtM/FbpjAl0kH+snSFDS+JED5vBprV9o8kxAoMvyUzalG1vZVDO8LSjL28ZtP/q
         Vd0HkYtg440lGBTsnSwxQU17UrquiFi8n49JjfrUEln8niU5S2bxMe2/AMylHoTn7az3
         zs4g==
X-Forwarded-Encrypted: i=1; AJvYcCWUQJJrxB3MkNiNX1Uu3JE4TW07MnRQhU2DhH/Gzo0jf5wHpDToUngddWGdTpPC1FZaboylwbCuauw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BMqpyNj33IYyHJj3dSXGzIRUFgHIvddRzEz9wETCLV9NV3tq
	ho/BCuQy4T6f/QLZrfCSW/S5Qi7hmMGxCR7sxmjZvbCS+KBzvxzL
X-Gm-Gg: ASbGncuN7SZCaygYn+9AfgzIujnYLN2Dwhxhb3xluPy7gL1h1j7dtIOvCEbqrbdrxgs
	46gWF9pySk+9Q823M8fIwjP/401DAGjCXJGVwrDMa0JoD4LJuKy8IaTMJWX4RARwVs0QM02HPnI
	0xJc0MXg/EI+o65DRhYSqpQEhPZ7hud4XPhsQG8QsH30t3BJAD3+AeH/VzOBccSeG+2NQb1Dhl4
	aTTBzak+l8PrBWJHnORYr+IY9Lkxboz3YiL/AJJnM/ERx0Tn+ZC4ktmPXUz6pRt9onSthTGeXEp
	d6CbnfmoS1Vdr/I=
X-Google-Smtp-Source: AGHT+IFRI2XP02LwQUmY3pnma0SuabUzBgf9C62h7vyS9cRaTSJWkLia1YuVRcGizJq6nHLphMfk9g==
X-Received: by 2002:a17:903:41c3:b0:215:9a73:6c45 with SMTP id d9443c01a7336-21a83f4cc87mr532263225ad.22.1736940159859;
        Wed, 15 Jan 2025 03:22:39 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f137eccsm81322735ad.95.2025.01.15.03.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:22:39 -0800 (PST)
Date: Wed, 15 Jan 2025 20:22:37 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Replace magic values with defines
Message-ID: <20250115112237.GG4176564@rocinante>
References: <20250103095812.2408364-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103095812.2408364-2-cassel@kernel.org>

Hello,

> Replace magic values with existing defines.

Applied to controller/dwc for v6.14, thank you!

	Krzysztof

