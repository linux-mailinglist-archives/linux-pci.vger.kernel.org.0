Return-Path: <linux-pci+bounces-32654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D6B0C6EA
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 16:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A4C3B1A3C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32F28D8FF;
	Mon, 21 Jul 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUbar5Zd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44942264B0;
	Mon, 21 Jul 2025 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109542; cv=none; b=cvptulHkSG+PdA5nbuFlIiyhRXzeeTKO0pUDdMo4xsQjsnUk1yzdD4m63agUh+GAoLkLoD7jqzxZRfMi/Zidg9hgOOfsHyKrcg2RdJCxetF2qBTCXLRhPKdfzlrM0FHWI5fqkD9sonLINarBAI3y0BI8dKKaTcZtsituw+mrGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109542; c=relaxed/simple;
	bh=+1x4bUUNqm2DLZmUUysYfMkN1kT0q7KQQkUsguB/m2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0T8kL+fICjO2P0T6F6N2zPrrC6ZCwgNush4q79fNGjqjjMMSN3RoPq0fV6IKbuiYbhGEL3CQg+JzLDSB1RQHxQqRP8zScVV5DdLOhN32an9aDGnuOfPRQXgSVdTbymOWsD0GbhdtREdu/+OXc4f3mvtyZAWgDFTWScgXCAGv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUbar5Zd; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-884f7d29b85so2492357241.1;
        Mon, 21 Jul 2025 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753109539; x=1753714339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9pKFUGnES5BOvIgz7OhSqjKvwg3RjLuuOEjVJ2EOIQ=;
        b=JUbar5Zd1m+/c8Pts9i+dtuiwdq98FgfW5SbMRxugSyHQ/WOE4GDeHMqjC3ajDlNf4
         GTm6X6UFA1R314g0uoDOG/Gq2lYqu2UYWLKLPGpooDgQ6hzRKdAIEtu8Q+Jl5n6Kuu5B
         unSg3QOkqQbCE7Bj0XjZ+x8hqLXfQi0/VUJ1T7YnRZLL4KSROonZLzJ1r4ALKpHByRgk
         NOgfFhXcpLV6HKVthJQmoNMjzG0zVBeWn9qZHnOy9Dio17sSicYE2zji+jhkvFrk6/CO
         zMM6oeegaO6QMdfI5uEcCCrjEc4smFKDZnJ1WGXdibmIczwb1iI97fqaIda9Q07dXe2o
         VE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109539; x=1753714339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9pKFUGnES5BOvIgz7OhSqjKvwg3RjLuuOEjVJ2EOIQ=;
        b=fz2OSwKmdo/KjO5v2Oee6tVkuD+KKTOqNuPL1Uso+MXlTM23psNZwgJEV8dpAkTBYH
         366SAQOsMfa8cj5McKwBhiw8ehPcnRh9egyuRT4lFA5Kl8apjzv8VPh4iH1HHoLOpcqK
         HtJdpTyW8X0Bhny2CDexQN5+7u5kbJpBqST7aKIi7hNwKDqvN4y6IiP7/ptsRZxojzEx
         yjk5wxbtn+PgAtWpKj9cn2R6vIjSrhea9T/nDM4p4WxCTfMMD9T0K107lvtYkJcBADd4
         OsW5eQr8Bu7gFriqrlObNMgqV60H60jjVsHXVekrqE3MovkY0/R+hCfe0V/YPtH+AWhq
         731A==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0mInG0VkVUyETmTpuuCcCoJT517yzCowUDa1xH4Gl7sBJWiEM1BL9rHoO6UXhRpFRPl7kZtKpaZkHB4=@vger.kernel.org, AJvYcCXo10fcPsbwRSDiYsbTLoUVY2vSQ5bM77x5bOwRZ//smfPUBXtJAZuZFiwtJWFdkd/llKRaKQNycRZz@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFDqIGjdrZJaaW74N8JytQuhYE5r2aORZRJk8nym2YsqJ0Bkx
	fLAG1XNn3dpoWVI+ZZwHi4KN7jMPXPM+4vYVf3NGQbvWyoxHQaMSkAKD
X-Gm-Gg: ASbGncv9sIckrzIrvxBrOj+2Fzkh2rsIwjlEu0lz46+M4Lthbi26UfOE0tA2Ftgm4pH
	zrgUvgUjxR09u12cEHwP1uNKgTenliIiqNI2R+qfvPbdBpMfyomXlUjN7qFaWWKdbeH8Aa69/8r
	DqYBBE5+ec/+359RL3LTbxHAhXsAnWsIjRjix7tVFIX0QVNfgvWkM34H/Hio0HrAGoDyApPRMb7
	g0wYYTE9aCiKljBRJA6U+cK5pHOxDfnh4qJqPBQLd9hJKuXp2Vf06Csy9M3lUu8rIpGaF4j/3tP
	+AF8VUmtWOA51Zoy7D0TXHcHJtGoc7s1wepjDURV380iLGQd4ReMIBR5FrN+Wn1be2wJxJ/5TgP
	LW5DTg8Fccg==
X-Google-Smtp-Source: AGHT+IGmd9k2a2Hbn8hJD4fenPYbM7kP6VlkdwpccXej9YWy59eUsaAV2qcil8B3QUVuuNtyCfMeoA==
X-Received: by 2002:a05:6122:1d56:b0:529:f50:7904 with SMTP id 71dfb90a1353d-5374f6b4ddemr7449549e0c.9.1753109539382;
        Mon, 21 Jul 2025 07:52:19 -0700 (PDT)
Received: from geday ([2804:7f2:800b:6584::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53764f2bd69sm2823702e0c.14.2025.07.21.07.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:52:18 -0700 (PDT)
Date: Mon, 21 Jul 2025 11:52:12 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-rockchip@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
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
Subject: Re: [PATCH v7 3/4] phy: rockchip-pcie: Enable all four lanes if
 required
Message-ID: <aH5UHPAtAVb2snSK@geday>
References: <cover.1751200382.git.geraldogabriel@gmail.com>
 <b203b067e369411b029039f96cfeae300874b4c7.1751200382.git.geraldogabriel@gmail.com>
 <2affed16-f3c4-47d3-9ca6-e4f48e875367@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2affed16-f3c4-47d3-9ca6-e4f48e875367@arm.com>

On Mon, Jun 30, 2025 at 02:48:25PM +0100, Robin Murphy wrote:
> On 29/06/2025 9:58 pm, Geraldo Nascimento wrote:
> > Current code enables only Lane 0 because pwr_cnt will be incremented on
> > first call to the function. Let's reorder the enablement code to enable
> > all 4 lanes through GRF.
> 
> As usual the TRM isn't very clear, but the way it describes the 
> GRF_SOC_CON_5_PCIE bits does suggest they're driving external input 
> signals of the phy block, so it seems reasonable that it could be OK to 
> update the register itself without worrying about releasing the phy from 
> reset first. In that case I'd agree this seems the cleanest fix, and if 
> it works empirically then I think I'm now sufficiently convinced too;
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Hi everyone,

Patches 1 and 2 of this series were merged thhrough pci git but patches
3 and 4 of present series got R-b's but were completely ignored by phy
maintainers.

Do you think it's fair if I resend these ones with a new, phy only, cover
letter but keep the R-b tags?

Thank you,
Geraldo Nascimento

