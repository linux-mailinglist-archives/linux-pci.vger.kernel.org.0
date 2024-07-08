Return-Path: <linux-pci+bounces-9900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE147929A61
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 02:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7A0B20C2A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EF264C;
	Mon,  8 Jul 2024 00:42:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277319B;
	Mon,  8 Jul 2024 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720399336; cv=none; b=XrDBKNUnBMe1aP4ityAm1/I8v4Jys81cDbRJgi7o/+zVpsq45wBdV9pAkLisHmKYGWfQd85AhRW0tzHPls/u795BEf24tYfX8HINTQIbMWGDL6nMxKKBd8Q3GafIM++4oi0qDp1L2s50wmaOy8MSu4kx7GSZf880/u0Vrr1cNIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720399336; c=relaxed/simple;
	bh=rLdbjPZH7envpFkLGjYM5DmpCb945hzkWuyJAqsLxdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ71TVwsU9/zeHjDPlnKIG2jbw7ZTlzKq2vTLxirGZsWMjs5ZfabQKBVEPFv1UOnPO54dAeUDg10tHliwi9wAsl7497ouoSXiYu+lYgUPZPc1oZ2Iz6CiirMHVJdvAUzmkysHORT/aWYad8+nrwIfyMTDcB+OK7XRLuPbdklNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-383dfcd8cdfso16022345ab.1;
        Sun, 07 Jul 2024 17:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720399334; x=1721004134;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pF6KlgvxsG/QtM1VQrjR4t0OsgL33TCaqBMlwvoc/Tc=;
        b=pKGmb6Zi9p7Rf7d2eXcV5OK+naVSOY8DF1W8nopcrarPIlnznAJoK5o0eQn9iDdiLO
         n6YzEjl6cQsNfayBH324nzFva8iGFwOIC7UHJ071Afgvjc4JdsHmVwVJUOZDgDKIRaZI
         xvilRYZZESv1UVtHUn3UnQbgDW8RpQlAYcaPmoV56Dg20Pm3HCeRZ4Gbq9w2/YXkA7Mb
         n0Eu5vVQ8u99opEnscr30cg/Mua70DNi5p61ZtV0lNPutv1i7+L+CUR9V0EyHwfF3ubW
         DHf9CmF+p+wQJFWq3ttbjTCBoV0LpLgDoQhoSIqmLYMQF5Xu5Bn+F8fGGyRbidlEq46Q
         FbZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXHpiWYgE4gQ/EMqY1my5Qp3FxSUoM/CznGw8+T65g+Cf3ahYFRIMYZl6+9P7qc4Ab6Q1BSjIOaiVVwkSS7uLvMZ6jjrjZ9O4nDl2SKxqm20IGn6eWtIxiNtCTH5VgXr/pHlFKWP4L
X-Gm-Message-State: AOJu0YyFFZfi3gscFo8HrJ8QfDsxU90SEnWdoPmgODLkchwetrP/DUlv
	YS4snf4YKHeassU0VpSvr0vaneNhroP4q+01dOPssLXdj4gVDdBZ
X-Google-Smtp-Source: AGHT+IGJmbb4qyMOfzbC7JloUZcrlgmZAZsjLKdGgF2dvgOJ2w/T8ITwK+O0BDWwP5ZwbcjgsKxMRg==
X-Received: by 2002:a05:6e02:20c2:b0:375:8a71:4cc1 with SMTP id e9e14a558f8ab-3839b285940mr136401645ab.32.1720399333725;
        Sun, 07 Jul 2024 17:42:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b20fb9215sm2792788b3a.5.2024.07.07.17.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 17:42:13 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:42:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: kirin: cleanup (dev_err_probe() and scoped
 loop)
Message-ID: <20240708004211.GB586698@rocinante>
References: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240707-pcie-kirin-dev_err_probe-v2-0-2fa94951d84d@gmail.com>

Hello,

> This series removes some patterns that require multiple steps to achieve
> what single calls can achieve.

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

... for botch patches.

	Krzysztof

