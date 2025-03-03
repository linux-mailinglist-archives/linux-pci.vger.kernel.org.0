Return-Path: <linux-pci+bounces-22779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE74A4CB8D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BAA16977F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D13215079;
	Mon,  3 Mar 2025 19:06:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D01DE2BF;
	Mon,  3 Mar 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028768; cv=none; b=kUYw1tXuLq7DorW6niS2gQbMMWWOhJhp+U9nnK3CQEoGiF010Ln5pE5MDMPQtvWfgSIChphkPAUQ6ZvQlySrIaCh4An67RkJmdMV0L8/bHhjdprn9MMdxhZXnzm4B4oB9LRwxruo0pKG1p8vZq20u3QXWbHp2rf3DnUfxofwUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028768; c=relaxed/simple;
	bh=iOmw85wftgLbV8Q3XwDBHYU0f3saYkHNnTMo1GVclI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMpvQ2LicJULH0JfG/svipL2Z5y/w8Hdp3piIdtvJ92E7hGZggedDMaQ4JdNWYC+CEZoraDVj0AmPnVdZhuQ3Ef1o9EQINo74isHJOdDz0kZaplcRY8D6DAaHO7v2ihV6lH1kxkZiLArsEZtk2cc58of1JcnQQ2srhUqioKK4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fe96dd93b4so8789571a91.0;
        Mon, 03 Mar 2025 11:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028765; x=1741633565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OO+oKqq1i3+H6YrIBJhtiAMh8a9VnXmjBwa2/6eO574=;
        b=UqqeBseaj24pwONYh6/nSQzREjaTV/7gK/CcWfXoUkNmRtAM1hH+Ke/rtDBH3D39y4
         yktpWHWWQrJnzGzVjHQPgsz2E2jSEaDtUrZPeVJJkhdm2fHX3IArxZx9NLWHEoXzgcKo
         AEfxH2HnSyo+cN6R0wtIq4VWt5voBESjy+/LhOzalRUW6m/abUJABDDD9b0f86swiJdB
         gOq3qOL9YyDC5IT9Rkrv84hLd0ooZCQ83apXvuTo22n7t3CU349SGZx76ea+VZMweTfs
         ZnfxzOeVB2Vj+CjxSLEdaG0/AFIX4FyZsZNVWNu+DfOJk7xX2yXwBUq7b+wOGnLDdFEd
         ZeEg==
X-Forwarded-Encrypted: i=1; AJvYcCX02iU+Eja+UnhTfga/r7IIZ3FU9du/DgE993xMdVE6U9wx189INzKZumI3lkUewYSIftw4IV0b//Hy@vger.kernel.org, AJvYcCXIbswARU4WA4rhui2ZCd8MVWSJ7FP9owIh5h5zXwkKYpa8SBvu2+b4Y45bjxiKSYZ609vhN7p5Qp5CI1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIJPreERNvlsulqTIsweYdBDyxJXINHn0lWFSqz69HupwGA5Oo
	TujJBCIU/eg6L1Q93K9CvVNKrBQmP2eIY+AKbo4nrBFVW6IW0goH+/xqGTU1mWU=
X-Gm-Gg: ASbGncua4KaEL45dwG8l5I2+44PYzAg4yORTDPO+NGK9myPYt8gmLzl+pnl5wLUxu28
	r8crY1N5auzYv/3keqFexNcpZf1Ee06XOJM9036QxJzZSu4q7ElJ1Vhdj529atY88wdfZwAYaJ6
	go2pWSgDvC2ZKtDf6g+1t+0bIlauSJrLVxH97/ohCDAl4TTDUylNQmePHHBDVbtq0nQmbgQ2USo
	FjPj6tPCph2x7q6LyHoNM2jqb/yjyUNpSFquFCC7yeKGLMqutypeaaitOSvbSyqiB8NVYSG7RC9
	/qsIdNUKCsrVzrzgu0vW7OlOHn4gSbbTuQH4DHUrlQ8JO6eQvH+JymZf3Z+M1YGqRJUTnblaaP5
	e804=
X-Google-Smtp-Source: AGHT+IG1UTEiOK6wjf6OEfo+zkP6hlH60ekgttUhhGBO+YWRUHEkXCedVjCkeBPaOtiTz6r96SgfOw==
X-Received: by 2002:a17:90a:f94d:b0:2ee:9661:eafb with SMTP id 98e67ed59e1d1-2ff33bbc468mr567792a91.12.1741028764963;
        Mon, 03 Mar 2025 11:06:04 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fe82840b64sm12686671a91.38.2025.03.03.11.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:06:04 -0800 (PST)
Date: Tue, 4 Mar 2025 04:06:02 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v4] PCI: cadence-ep: Fix the driver to send MSG TLP for INTx
 without data payload
Message-ID: <20250303190602.GB1466882@rocinante>
References: <20250214165724.184599-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214165724.184599-1-18255117159@163.com>

Hello,

> Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
> 9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
> axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
> set, MSG without data.

Would it be possible to get the full name of the reference manual mentioned
about?  I want to properly reference the full name, version, revision, etc.,
like we do for other documentation of this type where possible.

Thank you!

	Krzysztof

