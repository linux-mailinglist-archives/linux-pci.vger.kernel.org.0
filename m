Return-Path: <linux-pci+bounces-30274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07694AE2251
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 20:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D0F4A3BD4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C650528A71D;
	Fri, 20 Jun 2025 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOmYPssx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D5621FF51;
	Fri, 20 Jun 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750444569; cv=none; b=CfHr14T3LS5Gj2C6YCdAJ7beyDtx/MTwLOuO3Oq91gktqHdjZFEgbwc/k++F+JbVbAt9S/M1pYYS54PjZA4NyiG9cQQbFJKfWCaeOh5xywxUBq8/9/L962C41VEyur/1VEUdI7QJM2kujA8UoxaMl/+T3lllKYBGgL/RY+KUB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750444569; c=relaxed/simple;
	bh=VxYYZ+5XRHo4d4bvFkZwjgzgU+HxsHrnwxX5D8o2J7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXtXKwRI3u8T14ZBP+KjSupmeDr8kxXmxvmH4XufgcD6Yp7jgH30xhqKmYagKgp8XWoqBY/gbQydDfiFNr+W1lR+MwtEk7/E4dxBge6rRGlv0oh2lmA7bM+kNCx2mErhcMhy82s3U0LeixCfx3MbmhaCvSIJNTXb1LlyQ7iLW0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOmYPssx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237311f5a54so22814345ad.2;
        Fri, 20 Jun 2025 11:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750444568; x=1751049368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iB8K7naU/3cWPMjhndPtrJKbfq4r5Bnu9UIH3k9QIY0=;
        b=MOmYPssxlcwbS4ZYjkXEXfkTvUUBwwVaHlypz9Ui/k/JvHYVZ7NsJjYmoGhrXtFlYo
         4gzNa/ShoOQvumSQuopHPerrqrOlrEEU7cmNBoGrTreSzc4GjzWcsN37QDjCHIDok/55
         lkXF5jy/oSTGKvRr8duIZuAeryLHnUvTUwGP7VVPfijDINZIJMrN4lBq0Qb31jVL5XaU
         uorMEHPc6fE6LDV/g7dmk7IyzbRRdcFkeAkMNqNLvy3nAg3kSJcexwH+veBI7dyB7Osy
         uv62j2CncVkhNvdbNkbzFdsiQFPKxs0V5Jv+OZlFpiiGWMfPGr+D9/Wq3RdX04ELDWFF
         cbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750444568; x=1751049368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB8K7naU/3cWPMjhndPtrJKbfq4r5Bnu9UIH3k9QIY0=;
        b=fMPbZIiJwW+Xit87nP+K4/JgF+lXzyCZw+9W4aL/aumHMl7QoWItgCXnhgbXE6bTi4
         0RzqUAtRBK2KTmSlHjjWWDJkUbhLywBffbjjCnMPqM9RUDyMRZgy0G8/XtK3SnQ00GuA
         kQ5xesHl0ePah09HhJ8yhkJN+YW9jDTvCRjt9xQVCZphXBJ2qYJbjGIXvxxTDDZ3uVcZ
         7f4422sITeKV98HBA8ThBg+iSu1HWkRJ4O2EkkPQ6Yy8dk7W+fV9lI+pQhf5R+RdNJaw
         ebw+e7/97K071PLuSfsefiffJd+7/Xm4dWYH2dSxtAtLyAZ/zcUgR0BJsvV/uPqOQp9i
         T+6g==
X-Forwarded-Encrypted: i=1; AJvYcCVnYOa9T7mq16//QO2mM2xW8eKIxZdsfVUTehdpnuwisS4DJ3hvb0uzxbByMyiFhummd+C8hwEC+w3D@vger.kernel.org, AJvYcCWyw2QWPOzx8aGn6/D28rYO8TI1TEBalWY5xooS0dAewaFGmhKR1oVWcqFKyk/tnvtOY8JNCJ42jBCGgeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDAzJprsLW0SvkIE5oVqg4vyFY3d5hbB7IeEwAfJvVXZwbkkaq
	xrRRPD94ksph1uTsibm2A/UeNGywwq/85Ekbk5ln3svRFOK/JIo5LpmI
X-Gm-Gg: ASbGncv6UbiR7AVj1o5ZWtwdhpUxwO7doHEOXWLmvjBUQpaXQ2GdHEQPaDUtjUu2iOg
	3C6T+DQ0heOsYlP9CDGorqwk1PlGBS6IugATl69HY8V2V7zUrs2OVClS2qbfnLD60nKEPttYmIy
	Nm6u7sJREXG1A0LTqprUINwCPrBjv/obh18aqPO7A21mZiyShqfiTaJGVyMrJGKPIsvrtHlh/yo
	OjNxPZCCrsST0NZMZPe/yKB6iaA+Nl4EMDXegnxePORtMKy8TRfSrj8GzO769TRS6TU4TpTD55L
	kvN61WJrEVOVmZRw73DKjmXyTLazrn9zky6rvrjNFHhtjst1ww==
X-Google-Smtp-Source: AGHT+IEpd/aQfcdw5uYZ1ZK+nV3R3Zab/R2Ed0lgYGKgBLEMJrWyEefDcKKfz+3OCjw8DJ0q07uFQA==
X-Received: by 2002:a17:903:1b66:b0:234:c5c1:9b5f with SMTP id d9443c01a7336-237d99064ccmr64870585ad.16.1750444567570;
        Fri, 20 Jun 2025 11:36:07 -0700 (PDT)
Received: from geday ([2804:7f2:800b:cf24::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d872a3d4sm23398895ad.239.2025.06.20.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:36:07 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:35:51 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 4/4] phy: rockchip-pcie: Adjust read mask and write
Message-ID: <aFWqB8YRtYlC0vGG@geday>
References: <cover.1749833986.git.geraldogabriel@gmail.com>
 <7068a941037eca8ef37cc65e8e08a136c7aac924.1749833987.git.geraldogabriel@gmail.com>
 <d52fce68-d01e-4b92-825f-f7408df2ca18@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52fce68-d01e-4b92-825f-f7408df2ca18@arm.com>

On Fri, Jun 20, 2025 at 03:19:06PM +0100, Robin Murphy wrote:
> Which write mask? Certainly not PHY_CFG_WR_MASK... However as this 
> definition is unused since 64cdc0360811 ("phy: rockchip-pcie: remove 
> unused phy_rd_cfg function"), I don't see much point in touching it 
> other than to remove it entirely. If it is the case that only the 
> address field is significant for whatever a "read" operation actually 
> means, well then that's just another job for ADDR_MASK (which I guess is 
> what the open-coded business with PHY_CFG_PLL_LOCK is actually doing...)

Just for the sake of posterity, Robin is right here, PHY_CFG_WR_MASK is
just hardcoded to 1, and PHY_CFG_RD_MASK should have been the same
as PHY_CFG_ADDR_MASK as Robin correctly pointed out.

Moot point since I already agreed with Bjorn and Robin to drop the read
define, and Robin was kind enough to track the exact commit where the
corresponding read function was removed. I re-injected that function
from BSP into mainline for my own debugging though, that's why I caught
the typo.

Thanks,
Geraldo Nascimento

> 
> Thanks,
> Robin.

