Return-Path: <linux-pci+bounces-22347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B21CA442D5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 15:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F268608F4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6B926B2DB;
	Tue, 25 Feb 2025 14:30:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF37268C48;
	Tue, 25 Feb 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493807; cv=none; b=aoNpMq4wjO+Cw2t1MyqO1qOln7FoScGCNL8ZBFZqWtDURgtSeoE4HbCtXKJ0gwvpygGrfWaswLXop8hkHkRZKn9NwEW5Ea38Psvk/nkuAKHSK9x0Kq5mVcOTpW2otrSG+nhz75I6hgm6+E2nqifn7y8jhSqeHhPY3FHv4c6jcsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493807; c=relaxed/simple;
	bh=eGc3wu2FWrg3YdBJdGL+LGOwL6146dZ8BpFENFejErA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3I5M+inWscXquOyZ/U3zx+xIz1i2N5p5VexApjz0joxdI+hegm8et4bth9noB2mvqX820fvYlEl7aMak7OoY28kzj0f7o5wl7dFY3W4OsqL94LKYdCuMqAAby2Ok+f9/wjsLU6XY69iu860q8kBsCAscgIFbndenyQi/1/y3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-221057b6ac4so109299965ad.2;
        Tue, 25 Feb 2025 06:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493805; x=1741098605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG3YidYogPh0t3kYDq7/qV85q51q4l91jIf6MGtnfZg=;
        b=ONM7ypGLZU+yp8x8jvlz9VixMPNhIUleD4vyjxpMIoHsVSAnmbKbSM3HDr4fsiZ0zb
         kEPxha/IKz3ecXyvcR4+rjF6++kFupUSw7VjPGl3SSiMy8LBIoA7oZ0wydBkxdEqhW1Z
         D2lN4uTOXbNKmJsv6RUyJHeUNQlmjCfSKGUBosMoSxYsJ91EV0buABIUscsD5OwrnYw1
         TOwHhkeghOtbGVjUwqBA2mFvHewxWQnaRSOT3oRs+Tw4PckXqhf71Zjs3hNgwOThQyQ/
         6bn3ZwI9qNEJDDug5daV77qsyxlGz8jILWLFWFwtwQTjGFTUJuLqTErmPlICVfZBQIrM
         3OhA==
X-Forwarded-Encrypted: i=1; AJvYcCVSyXjRHq67sWXzA7WCllEomtcm8JNUwQMHFu0h8Y8yu68Go8TT0p//qRPW7T3ytUKVGfZ+gMqEbLYuEf0NJKw9qg==@vger.kernel.org, AJvYcCWVdMyfaHcHRoc1HGu8ad+GE3t42GPq/AojJcSJpBD5NqtaaFdWfn+FjN40+iteiia/MF+ZNfKFjBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgeraB3A9AuITjZ43WVE6ae97QATo7XK+cuJMLMPEqE4owf5xT
	OAIvbt+HeG/Evw7cOgMedLWZZ/Pi/xj/DosDTU3TVwYVt20loksw
X-Gm-Gg: ASbGncvjtk7R0IHNd//VHmHF34ccEFkLt4Z8Z0rFxJG6cCnXHRZbkEHJmJVNWb4hqzF
	iVcSbjd4jJYyNgrRBQk3qxeLHnnPw0abv+6d2/UQIMwC/CGezwR5iyQ6yogs1qXrNoPGtGVcJ3H
	tmOnri4pdfqqiRskgwHGFnH0H8DcF/bv+Fhn+ykr7MzntNFGJISSsuxDi4dtYT26Gxl/O3FVErM
	gKOUbYzK+TpBLosBJuHuGjylTlIhqSq4LtVGVV2TerWbJTuqup/VwmLx0+0nS9d3xU3k0IUE4W1
	apQW0HRQjI3nf+s/b8OHvM7OcrBOVuWR+b4UA+HRTy5YRzm5RrVLYuFlYLo7
X-Google-Smtp-Source: AGHT+IHy6OrD/YH6k+g/XZQG11rxQoJ71aizZlrzOaFRpQvw8/aJiJt0N98sszSOwWUy7SbLW5HkyQ==
X-Received: by 2002:a05:6a20:a11d:b0:1ee:d384:7553 with SMTP id adf61e73a8af0-1eef5558ec8mr34863278637.30.1740493804970;
        Tue, 25 Feb 2025 06:30:04 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a81eb02sm1607319b3a.131.2025.02.25.06.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:30:04 -0800 (PST)
Date: Tue, 25 Feb 2025 23:30:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Message-ID: <20250225143001.GA1556729@rocinante>
References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>
 <20250221131548.59616-1-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131548.59616-1-shradha.t@samsung.com>

Hello,

> DesignWare controller provides a vendor specific extended capability
> called RASDES as an IP feature. This extended capability  provides
> hardware information like:
>  - Debug registers to know the state of the link or controller. 
>  - Error injection mechanisms to inject various PCIe errors including
>    sequence number, CRC
>  - Statistical counters to know how many times a particular event
>    occurred
> 
> However, in Linux we do not have any generic or custom support to be
> able to use this feature in an efficient manner. This is the reason we
> are proposing this framework. Debug and bring up time of high-speed IPs
> are highly dependent on costlier hardware analyzers and this solution
> will in some ways help to reduce the HW analyzer usage.
> 
> The debugfs entries can be used to get information about underlying
> hardware and can be shared with user space. Separate debugfs entries has
> been created to cater to all the DES hooks provided by the controller.
> The debugfs entries interacts with the RASDES registers in the required
> sequence and provides the meaningful data to the user. This eases the
> effort to understand and use the register information for debugging.
> 
> This series creates a generic debugfs framework for DesignWare PCIe
> controllers where other debug features apart from RASDES can also be
> added as and when required.

Applied to controller/dwc, thank you!

	Krzysztof

