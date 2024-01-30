Return-Path: <linux-pci+bounces-2825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E35842BF2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 19:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC6428155A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D9078B50;
	Tue, 30 Jan 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjxBiw7h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80769D1E
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639978; cv=none; b=D2GmE2QBQJCWoSPUKbvM6ksHXcxI+Uki9IEmc11asKo6o/vcTqztTUTIS+jqNRFk6Axt/AkUI2VzvDrpa1p30NfS1qH9RSr4Ji/ZlBc/ftWx7weMjskfTAxemS7PW1ENRnDGymLCXzd1aGoWqjOr2jsqiRqWUA7KKic4rtRkeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639978; c=relaxed/simple;
	bh=MI0NDS6Iev4PjDUdrQb7Fd1NOLSljNC70XXvSCaQOzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FThIKqjp+lkqA1hl45OWebsvqo3PW2FEzeFJgfPlnjgQRg3t57e6nrmbyTkabbQNHtAqxodW1blTVW6cbn9NWbmMTe+T4ATe8w0WmKCP3F1paJgVTMuE17AtD6n8zGoKM4GZtBSgGjjfMnM5UxRIxG1xHBELZA8uOQGfLmoaDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XjxBiw7h; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3be48947186so1357972b6e.3
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706639975; x=1707244775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOjCTKxf4sFvuTCxIsDxH4OosQIHqdZ2rmZHkDuD9II=;
        b=XjxBiw7hNjXi97wqdnaZnr50iZg6Un6HCWlkP1K/7QQbCT1ZxHcRBeE+UcgXnKdb6h
         JO2JiBVA6wlXrucB1uiOuH9z3UxPSqOGuEnPipvw5hfO+eGrtQHa8FV1F0cl7GIP+OsU
         STuUwEwcQHkj3hBPw4ciud70s9Fm0iWEep1p0gLXY7QUyniSB2npKnlwSpdyKSzl3fcn
         7siI3wgPFmajLyQi2dZXNRzWuGrZF0LaO8kOnj0keSjW9a6YGwtw6jHRTjWHO5A0IS/A
         Ktw6qPi3LslO+LporoUnnF2hOpSP7tESbicSCKjphYvJHtY1jc8qgeESkSMR3VJ3AM2a
         6A4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639975; x=1707244775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOjCTKxf4sFvuTCxIsDxH4OosQIHqdZ2rmZHkDuD9II=;
        b=M4KsdlRHg/bWI7UkYhkVz0bI9594UqSrqQb5zikMiiYbvxTrXIsby0UNjTXVriGGcK
         Y2Oux0A/Z2TCItUJpVBmRHed7soGiAOB5MT1PdG8xeivwWJkhXbZ+FBKJD4Q4UKNV8uj
         LdnPk3Ac/1PnhxlRZVvaEgRGdL89zTS0VfUemGtLY5oltmIW4QluPijAZc118kjb2pMi
         89U7p3cutncyNFvsBCbXJWVlurOdcIadArmII5QdQ2CZK2qMXMm1ocvpCBFuqdQMK81N
         1M44vhtHEobaVpOci/UJxKy86rwObMWeyQvxw3og/gBMMYCmpq8eAm9D0o8XxVk38XMZ
         kqRw==
X-Gm-Message-State: AOJu0YwtxVjiUpFRjD+b8EMryv8MgaeuD8s1l8apnCJb04mQDuqhppiy
	DiobnEXuTBEyEtl4zu/n2UR9n4QQht5EjiY6VY3i4Sr7ZBIHtFcUiy4iBWcr6g==
X-Google-Smtp-Source: AGHT+IHKbwYWqn9d33FCtu9hgL0/2+JLAXUvS/DetlfUcPARSY8K+NddJ08iJ+7Sj53243anjwXCdg==
X-Received: by 2002:a05:6808:17a7:b0:3be:ac08:ea3e with SMTP id bg39-20020a05680817a700b003beac08ea3emr981434oib.40.1706639975619;
        Tue, 30 Jan 2024 10:39:35 -0800 (PST)
Received: from thinkpad ([103.28.246.123])
        by smtp.gmail.com with ESMTPSA id fb8-20020a056a002d8800b006dd8148efd8sm8081795pfb.103.2024.01.30.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:39:35 -0800 (PST)
Date: Wed, 31 Jan 2024 00:09:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] PCI: qcom: Add X1E80100 PCIe support
Message-ID: <20240130183930.GF4218@thinkpad>
References: <20240130065506.GE32821@thinkpad>
 <20240130180040.GA527428@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130180040.GA527428@bhelgaas>

On Tue, Jan 30, 2024 at 12:00:40PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 30, 2024 at 12:25:06PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 29, 2024 at 04:41:20PM +0200, Abel Vesa wrote:
> > > Add the compatible and the driver data for X1E80100.
> > 
> > If you happen to respin the series, please add info about the PCIe controller
> > found on this SoC. Like IP version, Gen speed, max. link width etc...
> 
> FWIW, I always prefer actual speeds, e.g., "8 GT/s", instead of things
> like "Gen3", for the reason mentioned in the spec:
> 
>   Terms like "PCIe Gen3" are ambiguous and should be avoided. For
>   example, "gen3" could mean (1) compliant with Base 3.0, (2)
>   compliant with Base 3.1 (last revision of 3.x), (3) compliant with
>   Base 3.0 and supporting 8.0 GT/s, (4) compliant with Base 3.0 or
>   later and supporting 8.0 GT/s, ....
> 

Makes sense. Will keep a note of it, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

