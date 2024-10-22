Return-Path: <linux-pci+bounces-15025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8473B9AB431
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A112813DD
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994C1BC07D;
	Tue, 22 Oct 2024 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lc8rF2h+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ABA1BBBEA
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615117; cv=none; b=IBqAT11TVYAdnfkFOPzYAHaRZ83PIKm3zgWNQCjkHEI5JlAKRrePCQyV2E8b5gx8fanw3znpmoiosoPseSGH1Em0Ug0CkqnE3Xg7bj7jFDewHbGT7xLi2dooCijIBBzy4Q1eiQgbmktWAeHDJblzPpQKlCdDRa46tTfUfVGTL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615117; c=relaxed/simple;
	bh=RXalQ9j7z43rQZHNvLqOPgbiB5PzAJTRu0Fa5uuonRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/ALVqORPnDNYmUcpy6w+1sCF7rfd08I75w51JbJDVh/pH7ewXn8YHYAgXbyUiIn6isvP+X8G/UH+DJ+2g1ZwWA65GHdaVtF1e63OEA31Ew4u7hAHKNSBJZ2BkVlmtadEHqhTGWqBloFHIB15StI/pR5N+Xlo8ax7k59SCDtYbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lc8rF2h+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c693b68f5so62729985ad.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729615115; x=1730219915; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qhSKd2J3l8RyLoipAAMrIXHuHA0SVPJOKCKGMnKgPYA=;
        b=Lc8rF2h+f+eZkT7U2PApGFbdFe0oRjsmLZHu1Lc5uW29uoxvdDDiwhIuMbn8iL940p
         hSFaomUWRltxNjROu5o4ROTjOAYsT5XCzlECmyA9JINPUJaUp5FK4AymxfrwMDEwHq6i
         kattMtWlEUJrZk9gRGnXOsHVOiJK0idwhwKUxCz/iffznJqKlQYoYZw77zRnK27jDjJs
         DptJ4Nf0zBcdpD9h2RhJR6/MNfuvOv1yZ5K0Sf9xXJaoMPw9Ki91I32Qlg3obN55G81Q
         1xbHRhm5lPOrqtI7QIVr1il6Bfz4uxpyhbSGL/EFp+YTsFKpy9qO/WxE038wrswEVX8S
         lC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729615115; x=1730219915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhSKd2J3l8RyLoipAAMrIXHuHA0SVPJOKCKGMnKgPYA=;
        b=WY1Bj0XII8CLqZnZgUPo679f4o6M45/miJOD0JzMGx5EgCE1ph72vb6J1VvcQc2Alo
         F9UNEa4EuPnGlo40W8QIdWyAcAPHQpg37+6TvF71WrRjb8Xrw3KHk1cS3g5oDXOmTtKI
         mJc10ucb6BL66tAz09N4o/0SP45IQV+EdoyR7BLlJZlr1ZRxagiE053j4OGdZ/v9kZ6l
         CamHWQkhVXK1zP+6WvyCk+cn5wVZzLPmr+iRzzV6/v/59TCnn4K3pmPiaqkqCUusc1GZ
         nByex6PvFakhAWny1ua/9Csv1tlbk9awjXaStAuEBgLbp+IX44aljO0YOSuGH/vtEAyM
         CZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCDlbrJstwPRcRGjkHgbVQJhnXKI89mT8+l2nSkPjVGV/QXag0TMoncf5frCaG0hbRLtJlZsqbgOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBKd5JZbCNSj/3abNr0GkivOwGKCtPVyn4K5A95dBNB2o+8dV
	WDod55VQw4tUuEJ7CSguhrnx72jxglLbLtUfx5osYsI9y0KVr1YIvVR5XACNhQ==
X-Google-Smtp-Source: AGHT+IENmUY9fziUvs63gVSy652sJwbamPCQ2VYyNU8dTskEqduYXYWzphnoXxB4WhyxD1leELQILw==
X-Received: by 2002:a17:90a:f518:b0:2e2:a3aa:6509 with SMTP id 98e67ed59e1d1-2e5ddb758c5mr3458449a91.14.1729615115179;
        Tue, 22 Oct 2024 09:38:35 -0700 (PDT)
Received: from thinkpad ([36.255.17.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad4ed825sm6422503a91.35.2024.10.22.09.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:38:34 -0700 (PDT)
Date: Tue, 22 Oct 2024 22:08:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, kw@linux.com, bhelgaas@google.com,
	lpieralisi@kernel.org, frank.li@nxp.com, l.stach@pengutronix.de,
	robh+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe RC
Message-ID: <20241022163826.6w3it42o7kbp6ydp@thinkpad>
References: <1728981213-8771-2-git-send-email-hongxing.zhu@nxp.com>
 <20241018231305.GA768070@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018231305.GA768070@bhelgaas>

On Fri, Oct 18, 2024 at 06:13:05PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 15, 2024 at 04:33:25PM +0800, Richard Zhu wrote:
> > Previous reference clock of i.MX95 PCIe RC is on when system boot to
> > kernel. But boot firmware change the behavor, it is off when boot. So it
> > needs be turn on when it is used. Also it needs be turn off/on when suspend
> > and resume.
> 
> I think this background would make more sense in patch 2.  IIUC,
> that's where the driver behavior changes to do something with the
> "ref" clock.
> 
> I'm not sure how to interpret "Previous reference clock of i.MX95 PCIe
> RC is on when system boot to kernel. But boot firmware change the
> behavor, it is off when boot."
> 
> Does that mean a previous version of the boot firmware left the ref
> clock on at handoff to the OS, and newer firmware turns it off?  If
> so, I think it would be useful to include information about the
> relevant firmware versions.
> 

Most likely that the bootloader *used to* turn on the reference clock and now it
decides not to do so (for whatever reason). But ideally, the clock should be
voted/enabled by the kernel irrespective of that. So the reference of 'boot
firmware' is not relevant here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

