Return-Path: <linux-pci+bounces-23252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD58A58641
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 18:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31271888F6D
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793BE2A8C1;
	Sun,  9 Mar 2025 17:30:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB151DF244;
	Sun,  9 Mar 2025 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541437; cv=none; b=CrEtwLZA/lVENOR33AjM2BRj9U2Wps/MF8K53ATjY/0hYMFteh4xbxfaXaC3XmPTDsffH8GF1a7fnz+Bj+6A3LqQ0qHkplp/IeT+ZO/6oN0x+rZ78jx2jDESVothbWsCEzEHIrsCX+fbtqVIZloZubIMJhEi49NTwCdsjwo3VLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541437; c=relaxed/simple;
	bh=obtrS+d8UAUERpS0/OTSNClgbsftnRfpO5KNU2vfjD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qs8xdY/qfpYS9FAUy0o+p6gW3yhPwtpcVgHZn/WIfA+KMD/hqqRWici+p7Apkr2vUySNZpm0Do7Q51dk9HGK9Ek8f2+Ia4UV+5e17V5eOni071X0k0I+BEpiPbO2iFnqggDSbwtAZkOYtjCyAbf2/YJPvZAwkpjaFFD2eNHaOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff4a4f901fso5000427a91.2;
        Sun, 09 Mar 2025 10:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541435; x=1742146235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLc8HkRgJEtGD/xcqKDdNwiIpd6+ivyRsBlqxhytBJM=;
        b=nkYT6pQheHb9Ah4R1vNUpxBTt0ndAansLceNXI9FHhWyJ/usSAzt0EZrzKW8jpU0EZ
         fXv2KW6h3I8+8OFVlI7k1t8ge2nKG5wF+iZhtIZ4oglE8AJIGEc9tPTfACHKLej2DMIH
         WiUjRj7ZZtDsp0r4DIImCCvj0JorkgHFdzkvtOcDULL8EAiwZaOn3U4o/NUotyEA91Qd
         Et6pYytc3tihYh3PM65LHMo5IH6QIcvb3TXfnwP58XvFaRpUe3O6L0QvfIjl7Y/1crvX
         fgIrWyBJPsqf0UZNaEeKFykhVagcqYL+mOa8XCBTR1MtL3WGBQTcZPKClKmYx2Cuizkc
         RH3w==
X-Forwarded-Encrypted: i=1; AJvYcCV61O3T3dxW6GtpT3d/Ui8aD0+VAx3hPzhXsjtWX9cC5v1NsnAqKshkU6driv1CHxF93eyQ6ENIrJIB@vger.kernel.org, AJvYcCWzN899QClMalfexgnry3N3PMmwLIQMVu4+hsZkZ2Cci5m2PjpG8lYpNjf/U+DcBHFBRgdgJLMD2c6tMoXb@vger.kernel.org, AJvYcCXAPvEERnTRMQw1N2YFWZhljqfVln7rvq0x+K9Qgm3JH6gpu/49dSsGsE98GY6dRebHWbOpWsr6YGC8@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUO3rZxMgFTOkrqp92infd2oy71hG38Sk+VhqtCiLlqorBb6c
	Y7mYyUJ8+KVn1ymoY7fny+0p27RRxaxdA2ETX5gqBU20oMfbPwis
X-Gm-Gg: ASbGncvQAcmBE4yrmlkrKplj0rDZsvuJMfcy/D4XkHjTVvI1Q2M+Zsni9CAwIhA5MnC
	Yv/RB+07DieptbPIWqaLBBrY6c9qpE5gyY/UVwypEaaVJuVvPRiWTKHMfUSBuvmYQ+2KoRnYU/C
	Fs2zKynZE4KEmEBNmzoe5QlBL/0fheJN35E6yVDerwrKRPUiSa6KVc488xUHnEEmoQkp3ZvvwHb
	23ordm24qmlgKub+hC0WDOojSe8cWTTH52xoOeqWe6L2sXgGRoQehV0P5NQTEM10QEg1t0CtYWu
	L5viUFU1anApwlv9KIoUXJRUBdxBOBhqkITLjx2zco0IhMYOVCRHZJneSxGV0gQbzEpuuTJsiDw
	1Qqk=
X-Google-Smtp-Source: AGHT+IELOVc3WS4SI8h7Ae0Bns9EpCBz3SlqLqlHoKFpe0zAs1WqEuSMT9JP/GFYJnKot+7d4D7VGQ==
X-Received: by 2002:a17:90b:390c:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-2ff7ce63257mr16329321a91.5.1741541435081;
        Sun, 09 Mar 2025 10:30:35 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff6933a9cesm6391731a91.7.2025.03.09.10.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:30:34 -0700 (PDT)
Date: Mon, 10 Mar 2025 02:30:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v5 0/3] Add support for Versal Net CPM5N Root Port
 controller
Message-ID: <20250309173032.GA2564088@rocinante>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224155025.782179-1-thippeswamy.havalige@amd.com>

Hello,

> Add support for Versal Net CPM5NC Root Port controller 0.
> 
> The Versal-Net ACAP devices include CCIX-PCIe Module (CPM). The integrated
> block for CPM5NC along with the integrated bridge can function as PCIe Root
> Port.
> 
> Bridge error in Versal-Net CPM5NC are handled using Versal-Net CPM5N
> specific interrupt line & there is no support for legacy interrupts.

Applied to controller/xilinx-cpm, thank you!

	Krzysztof

