Return-Path: <linux-pci+bounces-9212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53040915B78
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 03:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C317B1F20F18
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 01:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AF6C2ED;
	Tue, 25 Jun 2024 01:07:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF2A1FA4;
	Tue, 25 Jun 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277674; cv=none; b=uLg3+ZMUtKObcEmuKwG39HEmFJ3F4P0PuZQtcWoXmb0LyRkl6qqMxam+D4MTCUUEoAqvUNYw3T8peNF5iltkoQvbCxyFIO0ILhCb0o1vYAtIxj9UxH8FPCV0PnhfTAvKz+Is6Yzxo77gliajrICmjXg2PXdCC7zqVLHLx3wx3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277674; c=relaxed/simple;
	bh=bvR7Gop4UhIMst1t0cOAIG9iXUKelRNiGsfVDj73ESM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9C94j11lxlxVV6sa8h0HSD9gs5jw+Whrzt0J6CZCEkJ/D9gdlLW/hTyzGZ8rcuqjglmHzj2yXhMPA4g4t/KUjjFyoqqm3XKG2F5boiLUfECwq1RA6sCguAXGZHdreLnPnQCmXczrFS2RkiaVxl2jtTSs9wvq2H7kfECMK0FM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3458069a12.2;
        Mon, 24 Jun 2024 18:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719277672; x=1719882472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZ2l4rvhLdb5zNKxoHNK6je0C77nF/TIfXLS8kYBYT8=;
        b=qrwi88MeqTsTVZQeTBPxMF1mTtaTy7eKhd3+dJuhWopTTIY2j6BhtQ/ZcpierHQnQw
         Vez/Og2EMGDkSrtpEl8eFWRZRhmyL3refkHnNp8dzm4Z2qmuETUV5TJTnO8CgzvpBptw
         8riW9lOL+ZGJQbPwoxdIlm/tuZ96sKW3aGcmPtLebF59WZETusCKixdxgcvSffxgQacQ
         7ky9NCq2Yz318Pu3H97iHlW7L5Fwdxq+edXh4ZTVvMgSoLC9+th/11+fxvk6TWUFp7su
         n+RQKw7wQPynLqkhEWJJtT38bYjUCnCPp2ZfwYpPa9bZ/1zGDzS1QHV5GuHC7gyInhYA
         Z7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHUZpBf9NH99dkSTFbxNE0pBq27t7fFpZyTPdBrkWgEjiOXzNHfSeLlLCCMrCvyaRdcpgViIxtpPBOrSa+NwjIcEvnZ3dpyGoWiNG4Tclp9nefiKuQCi6IPyPJ94YbjT+u2lmGPyt7+1qQHgcyfYQlXce+41xenyesxlPWAqlv23NtuF90Av0a
X-Gm-Message-State: AOJu0YxGxf6pLhVAj33WejaexDvIJX6TCb/Kiz5VOl7XJFkUKUkeMIIL
	ZvMXERzthfkOjRvt/mzO7/A/7pW/A/oRZIHSMHq2pq6VhRMSu1egiMb3AXHklSA=
X-Google-Smtp-Source: AGHT+IF/uXFrtb1A0Glhz/BEFQiR25mYJoiI5Hw7sgeRptJRnKb6S6bz/2Rqegm/kJ55jsZi0yWAMw==
X-Received: by 2002:a05:6a20:2d8a:b0:1b8:9b05:e7a5 with SMTP id adf61e73a8af0-1bcf800034fmr4834215637.61.1719277672522;
        Mon, 24 Jun 2024 18:07:52 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7066c2ebd85sm4823974b3a.93.2024.06.24.18.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 18:07:51 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:07:50 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: ls-gen4: Constify struct mobiveil_rp_ops
Message-ID: <20240625010750.GA430517@rocinante>
References: <189fd881cc8fd80220e74e91820e12cf3a5be114.1719260294.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189fd881cc8fd80220e74e91820e12cf3a5be114.1719260294.git.christophe.jaillet@wanadoo.fr>

Hello,

> 'struct mobiveil_rp_ops' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.

Applied to controller/layerscape, thank you!

[1/1] PCI: ls-gen4: Make struct mobiveil_rp_ops constant
      https://git.kernel.org/pci/pci/c/cd09a6ac85b9

	Krzysztof

