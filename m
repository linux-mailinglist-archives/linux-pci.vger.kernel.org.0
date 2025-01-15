Return-Path: <linux-pci+bounces-19877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBF0A12293
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA97167941
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B716B1E9910;
	Wed, 15 Jan 2025 11:31:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D27248BDD;
	Wed, 15 Jan 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940707; cv=none; b=A+aZh/9kMjsgsQUjfdN9YQ+dpNpW7jt1JQNzKUIjsZpMfvpFrQhkNCDDdxX6oM9CasKIFrxdo3YGD+MGPxYJGKH/d18Nl4mOyECu7Yw9t82m2XZXbdliU5t3PSihO3aXb92a90sPBUnvo15+9IL3RSEMBORBs9yv3GpfGRHBMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940707; c=relaxed/simple;
	bh=TGM3MfL6uTLHlCgh4E5WI4Tp0xSJ1kLZcIBG6Hvvypo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbZH7b9hOCdCE+yBcy/u3k/dfbgiWMlfSGXAuWnO/ETXLIam7KnQvFnj5Qrh38JaBWYXqIEFGZ/dyqVEjAvi1Q4R+iaPkPTJ6k2Qu+ZhtoTaQb3teNa/CvbXRd/kDU0E7kj8ppj8GtcApAMc6CaRAtIQsFno7wpAUwgN6gnhvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21628b3fe7dso112217365ad.3;
        Wed, 15 Jan 2025 03:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940706; x=1737545506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMf/gjH9CaGlznAM7Zrfe8YwB74BkxcaBNpx5Jp341k=;
        b=KOkhzofNb4PLtiMeIOHM2tXHLpYJMKJ7a1ReTsHOMexwXuq85PWbGho0iu60yO16kA
         1lDE0EOLNivKGYeqOV22t9lki/XfMtBr4kAEu/42cZ5M6pDzlZKhuNcwGjO8oe2iot2Z
         DySVI4A9JSFXYCXC73ZDAOgCc5V4XdyV/erzYcoTangWFfEy7803IYxRDCO45vVP6zwF
         BPYcaqWmqf1p0THo4h5HgzfYL5D0RG3tAh9veBkkljYw5s4uLkKjRwGoT8SH5WnZGlAD
         v5t1FOWC5+zLei9c19VT7la/XnnS3KTCs/K1zQW6fdT4NZ3UwsPyBn8NCZLqrpob2zPi
         HYoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUXuqdoobjnumeSb8N7IwM8WC5eSpjrNmj3PavjS9o9PnLk5/zkfkfjZ7x0QrOqZ/L9eRlzxbpK/9WN2CNLHw=@vger.kernel.org, AJvYcCWpWC6Flz4ruu/OpkBuiLAL2I9r9KOh62UNDoZ88IW1Wl8WRjD/PFneOWUVd2RTNUd243tUHyvHjaLNFa5J@vger.kernel.org, AJvYcCXgQAvpUzgF3uBb5phtByUXLofn+XLaXlKJxjp8vmq/hsAkxf/THt6TnDgpzAqA8RTs2ozpjuPTSnJI@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUjDQV0g5wODW2Z5z6hHgXuz3qd1pEmJMaExN7F93P+Wl2gWI
	w63vSTi22gZ1V0PE55Am7yB8R1MzOGlE3VGjlR2j3F8IBmfgSdPG
X-Gm-Gg: ASbGncvPmLt/p/2aMuQ0UibyOoMXdIhitYWWir67B3OGFXQTaEU9OU9G/awNYaKY1GW
	kIImr61TaYglO44HAXy46Us5dqaux+L0hqHEQ0E2F78FZ2JF+al+KZXawFBEqeb9zanU38s/ryW
	x1hjWslBzVAAeoIVLvDmqyeCY+YIm6g2qyPWd61MrfpkU/LcHhPfewLXSwiMpQ99qYuFaf22Vpm
	LKm5vcgHeIrPivnADAMs1CsE7IzGYnWFhbWjOKFzr2jjyE3xuoRG6fe3uHRYLvNcUVSRee5BAfe
	hD5dAw7DDlwa3kk=
X-Google-Smtp-Source: AGHT+IHH3vdl0SoO7I29qFqmrTAjmo+4RApDGp3zpjzEyS9KqQP4GKUQ7H0LW2xUTEH4LU28i+G6ew==
X-Received: by 2002:a05:6a00:2c86:b0:726:41e:b313 with SMTP id d2e1a72fcca58-72d21fc659dmr36762604b3a.16.1736940705705;
        Wed, 15 Jan 2025 03:31:45 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658db6sm9275820b3a.104.2025.01.15.03.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:31:45 -0800 (PST)
Date: Wed, 15 Jan 2025 20:31:43 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip-ep: Fix error code in
 rockchip_pcie_ep_init_ob_mem()
Message-ID: <20250115113143.GK4176564@rocinante>
References: <Z014ylYz_xrrgI4W@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z014ylYz_xrrgI4W@stanley.mountain>

Hello,

> Return -ENOMEM if pci_epc_mem_alloc_addr() fails.  Don't return success.

Applied to controller/rockchip for v6.14, thank you!

Krzysztof

