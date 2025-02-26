Return-Path: <linux-pci+bounces-22412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48285A456DF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 08:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490A2176F29
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B65A217F31;
	Wed, 26 Feb 2025 07:44:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44F149C6F;
	Wed, 26 Feb 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555874; cv=none; b=HkxuRxMrtyiyO5qGAuZy0up1ln9e5D2W17irq9xR88efV6uCI1oUvpn8PSG9UnFumJRW5W8U5Fn6Mxi8W96aPNDxa204WOVDtAnhrEZ+yIHjdfDENtlQoXsPZvK/kjB3g3Y9RMewfoAJkhIyacZ/PUFdr0GRvFVc+u/Q7KjjD1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555874; c=relaxed/simple;
	bh=sVTr9P08wLEoZNATz96q1PTTYceN12xYE4kv7FxL9QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi8dfJ7IAjuLqyVbpe1VHtNEQrSmtdphn/TfenawzfbxPlqpFwsvtn20qzmnNHpiOxUPaFpRTN/64/peP+4rXLYG2TzXu9oaFiKeSVgr1mufM8Bek5b5DiY1D02wkw3VMac2lwDgNLe4X95guCtZI7KSuQaC8EWyDcpR8tfyz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220bfdfb3f4so30936515ad.2;
        Tue, 25 Feb 2025 23:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740555872; x=1741160672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQOCEjoccYRv48sIbAeIdqJWevhdKtzIw5YdKtxmEXE=;
        b=qL4TPra3B0/Tq+TinpDUMKfH7MiBgdCWR5FJDadineEjbGq4aa97JAlvD37JtTT2H3
         BZIJdtdhcfM0EMvz0Uz6UunYu6IcNcs4GcNCxWJY1mMY7zLcfQOqP/gwdOWU3lQHC+jh
         uVRVxrxUCKrCYedrBPcxXKw/uURNAhLotV0mxUUV+O5EDUCzN9hvabRtI8v6+r+fXD5R
         xw1ByKEv7nFQMqB+6S9eqroVtkiutHw127KCECjMPitmHza5ElWt8JEpK5hkr+FcPUwn
         zOJV0hHN324t6N9rIG8qhuuoQrwMsnQfCy++pIoPtNX3QrEPOVQjMJ0JGpcxKsGREsIV
         odNg==
X-Forwarded-Encrypted: i=1; AJvYcCW47vvAML3YKC0O2nyRQ27qk3r+P3OTcCX4jPJNtzzhDrDb2pS7VomBqmZa2Nw7/IAvv+7uvM9Sonrz@vger.kernel.org, AJvYcCXzVFDVQew7xzm8OcWUaQnSVTQWDG0wzDXzzhWuJcoe8SwkeP6iRP3TScBwwIpEqdIUc9jxoQWZVz83Vlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLd7lzVorR9ao8LXRJpnfhaUGFd1WKihCsUTZ/bKq/9OSoAhq
	M3gSBkTp7Hx6DmdgQNuu43HArnIX6e3S6Kf2LIxkm9VXoyp9NsI2
X-Gm-Gg: ASbGncvDfNP/WTRnMEyH3ieNpGxPlbcqLH2UQXSHsVD2oL9Yzt7omFlEzWmNNnBUJrj
	UhhcBmO+I0T5NlqgKL3gmr1mbZ5ILmtmF+K5BlAVs0RNDrrAL2At4RFrquIelXOtaXSOnCArutu
	0tX7b2hoEzDTPNIEQpFuf/a15JYoSk8wBgEnRCEcX9nptwOAy8Q2L0KxCI0BMTl9UgcLztetOIu
	v7/NF93fEgLNytYyW0l/B7eFbPNCtEp30GmgT+5ORH+2owiioH3PZnNXaOXoZ6SMVNsNGiiPTKD
	/QymDQG+pENR9U64sT7AKmRF42xDfTRG02VLj0PdNUK3gRSctYFslWhs4QQ8
X-Google-Smtp-Source: AGHT+IHRZRmiTH6c9ab75sTRBstxNyTvsl49ihEj5SrJcAYx5j6VbliD/Y3naIO/rnimqZvuLaHzDg==
X-Received: by 2002:a17:903:1aee:b0:223:28a8:6101 with SMTP id d9443c01a7336-22328a8662dmr22567125ad.29.1740555870941;
        Tue, 25 Feb 2025 23:44:30 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a0944d4sm26060085ad.140.2025.02.25.23.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 23:44:30 -0800 (PST)
Date: Wed, 26 Feb 2025 16:44:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: jingoohan1@gmail.com, shradha.t@samsung.com,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com, Niklas Cassel <cassel@kernel.org>
Subject: Re: [v5] PCI: dwc: Add the debugfs property to provide the LTSSM
 status of the PCIe link
Message-ID: <20250226074428.GF951736@rocinante>
References: <20250223141848.231232-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223141848.231232-1-18255117159@163.com>

Hello,

> Add the debugfs property to provide a view of the current link's LTSSM
> status from the root port device.
> 
>   /sys/kernel/debug/dwc_pcie_<dev>/ltssm_status

Applied to controller/dwc, thank you!

	Krzysztof

