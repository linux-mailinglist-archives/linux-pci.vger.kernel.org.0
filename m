Return-Path: <linux-pci+bounces-9864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54A929040
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3CF1F21F75
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1489EC8E1;
	Sat,  6 Jul 2024 03:16:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69717E9;
	Sat,  6 Jul 2024 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235762; cv=none; b=H5KR0zQZWm9OATPveUvytgX4T0fe3gNaWjI8rPN/SQ7yRsYgtJAABjmrN8VutJhaDwTHUsSbQfzoMZbjUMPqOrn0+q82vgNDrBoSr4faKTzW3+FdFpztR0PE2CgGm89cZrimD1vlMKhr4zQ4UUJ9BJ7WCMeCCAnw9UgI94Xag04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235762; c=relaxed/simple;
	bh=Z654Bv5SvRAUBxZ0VtYpr7EumGzamufk2NOky/YpD1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH3jrIMMv+u3CsmS9fjTrq+iAGnA5gUw+scfJZghrZ/5pNSDDynpzT0sLDLsdyM99hoPVDo9ndEHlzEVFfbmxh7bvxxdS/qfiU4d8Bw/80r05odYrRtZRVMQ511qlms1ZxNm1nWMpztibzD/VcDNHrRQtcmCexXCCL32dbaWuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c652d56313so749854eaf.0;
        Fri, 05 Jul 2024 20:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720235759; x=1720840559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwIAdc0vCWEi9NSlfU8r78P2SqIxzPyJHTKpgdC7XTU=;
        b=IBR4pPY+Zldqc4Gv1EQiiCPUEZrNsAGwm+TN+YsUAQ8PG6+mZaPlZam3cLMhFLJmwY
         4vEaTfEuq1ZgDp3jHID7cgl+GnpYgS4ZKTlap2tv0oeIZtRfNb+SuSBrlV4JgDCNmrAQ
         T5FHV3rf1W0OIgGyqaj3rYYmCGxYXRIKUosQ0YhwKSCy1svJPfAY4/akOE9iAif4jOCQ
         5kGe2HPu38V2FjzUktWfM/SJ7tto6F74O5oK9/oOehIzS2aCQ6zckysdm5FijFjE1S4n
         UZ8ROw4arZox+EvzspSBMmfFOvHPoHsXuCIna/VbCTd+Qpi+o034Ivve4xVRYqCkxLTt
         vz0g==
X-Forwarded-Encrypted: i=1; AJvYcCWLYgV/hTM+Af3/Z965882hqkceutO/tQ/amdJkYPqmsJzBKjyRnBAteiRQPgx3S+v8dzv+p/XoXlh4frMV624BmRA354JPYx0wkPxDByCkrbvUu1AaozyRtDIc2ot1apjiTWqZbMHU
X-Gm-Message-State: AOJu0YxRBXbC6Fy8xJoROojz/O9j7wdDRMkF14h7xtoeNYRefEYovhqk
	0agfB0kYHhbjMBcCYlKRem7sgdfXc4lT7d2dwNpb5Xd3xrx3D5UN
X-Google-Smtp-Source: AGHT+IEcJWUfM/NUfIxf5oYhyS7hdxBsq9CeeF9dtKazpBwcWG+OIUDnU3rmp2Z8uhCAh8+1wnimEg==
X-Received: by 2002:a05:6870:3913:b0:254:e89e:fc1d with SMTP id 586e51a60fabf-25e2bf54825mr5254910fac.51.1720235759538;
        Fri, 05 Jul 2024 20:15:59 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b1fdc33aasm22345b3a.73.2024.07.05.20.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:15:58 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:15:57 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
Message-ID: <20240706031557.GD1195499@rocinante>
References: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
 <20240705111805.00002010@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705111805.00002010@Huawei.com>

Hello,

[...]
> Looks like it's queued now already, but if not.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

No worries.  Updated the commit to add your review.

Thank you!

	Krzysztof

