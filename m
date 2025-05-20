Return-Path: <linux-pci+bounces-28075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89ABABD294
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053007B38B2
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26902264602;
	Tue, 20 May 2025 08:59:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAC265CAF;
	Tue, 20 May 2025 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731561; cv=none; b=k81mjSZGY+Bg7GEdsqChiXHUkLV3MAQnE5jPjdWCoGmOapx8mKlwLwde0Xw6O0sQLloXa21PFfYqwS+nDqbrxlsqZvNHU/LCN8XwP0PJCbHDN6F5cxdytA60+hi8Uxmf3lEac7rN/CEzENugyB7otziyhy2kAhDWlmrzqfquNyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731561; c=relaxed/simple;
	bh=pJgvq03F/PNjCzOpz6kmnL+s2JDlh5bFHWOi7k7XqZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGe9ucn2JN+b+2ZibgVMcM7bIhJTCq7qnyBnGpWTjlPAXLyRAbc32EqxtJkCzZHkzqRkO8wVcCXXZE5jgD9hWg1Yc9tngh8iamJmEoEQLJLu/Dt6FYquYRj/zuK69IJA15XSbDR/rkaYMXhfiKEDlsJzdzxqHq36H1QIbbFJuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so4131126a12.2;
        Tue, 20 May 2025 01:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747731557; x=1748336357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJAiGRBiRybZY/ursx22qPnSHr33EgoY19pmHciVYbE=;
        b=qykBdeVlWPD1IR0RMatMUvsCFemWjnZfR1e5uraLpuw2byvSHrQFTwgJc3NGT3wqDb
         N67AYj2+mUgEc0hOVIhKxZ1QpdVFRYoODUOX06oaJldya/pi7yiqTYblVkray8HjMAUZ
         1I6eZTQZrBU4DOW77qJVKwkZ+KDKZkFQj00zmWbQrqiS85f0/dEVrq9UciclFctBHjve
         G2Q/BSYgUT6W8NbeT2qN1jGT7hPAW9MTFus/yLG8Ms4CFOLJ8WSEtvt9ADLaYBW7QzI/
         3gv9OoWFgtIfG2hZ/vGvoG7py4PZ7IEdNClpbGL2JkWLnq/Y+uQGLprcoZ/wyq5ZcrYm
         kruw==
X-Forwarded-Encrypted: i=1; AJvYcCVbd1O9ygJDLpgB68jry2WlXcwZABZ9BpV62usS0DXBPOXlkCCG9cussILrarDPGZp8NaiwrENVo9ntSCc7@vger.kernel.org, AJvYcCVsej5dwx57wLUTsrTnTb0AdwX9njzigK4DPp/bfPD9hehtj10bDBLfvqsQ3+HTZoSJW2dPDUEgtfQT@vger.kernel.org, AJvYcCVzpH9rJPGBeJZkSE/OPKFVFJNTSAeWGTP53XCwNoquaXbmz6R2c0pcUbABtSiGw1ee/mUNVliRYsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8SQ/6Aws3jd2SiPPaleq+94cZQGALXbTXBtLbR9NpfLR7hJW
	XOdDGc0ayIwU5fTa2wjf3tZUqi3Y8k2CQD4sy6OHkh5U3C1/YJztDpuE
X-Gm-Gg: ASbGncvqKpFUCdtnTnUFTCVGwZWCG/RN+aOtU35qVBzsSarPB/pHQZvkxhwHrGCKJQ5
	iM28QzZRrHptOV4omg5wokyFd2NU972/wwrwddB16sa3krhJn2aUJfynydhvtjj7jJbEBO96flf
	RhL1KeIfoI7N61tKnCq5DL7F1YO3QZ6pLW1mdva19vq6YmNRFV8dC0fNKuFzD+mhJaJ0m/aSElu
	ekpgjmypPbg6VO8rZFS0hgqn1cnG6QlQ9QUmrW+fAkxuM/zY8aJvCj4Gr+ViRg354UNwCAmVsnZ
	xtuzvWpNSJJc8jqyzy8DGBpi15NjcrQ3vT5AXuN4kqYBgaV5cn3h8gKu0+CI8H79D0CnHrB9U0P
	8r9LotMmB59Z76CgDTjm2
X-Google-Smtp-Source: AGHT+IES72pp8z14XSo1QwTMiAWKil1PNTEeMMzrM824bVZkZih6CGacQzDifxLWU6gSx+HPkmcpTg==
X-Received: by 2002:a17:902:f791:b0:223:501c:7576 with SMTP id d9443c01a7336-231d439b01dmr251945285ad.12.1747731557265;
        Tue, 20 May 2025 01:59:17 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ebae66sm72644745ad.177.2025.05.20.01.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:59:16 -0700 (PDT)
Date: Tue, 20 May 2025 17:59:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: Remove request_flags relict from devres
Message-ID: <20250520085915.GA261485@rocinante>
References: <20250519112959.25487-6-phasta@kernel.org>
 <20250519221147.GA1259487@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519221147.GA1259487@bhelgaas>

Hello,

> s/relict/relic/ ? (in subject)
> 
> Would be nice to have a hint in the subject that this is related to
> exclusive region requests, since "request_flags" doesn't include much
> context.

Fixed when applying.  Thank you!

	Krzysztof

