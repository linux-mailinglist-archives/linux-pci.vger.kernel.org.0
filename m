Return-Path: <linux-pci+bounces-3909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B299F860AF2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 07:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CC61C218C9
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 06:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC112B98;
	Fri, 23 Feb 2024 06:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYuc23ZA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4012B8F
	for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670836; cv=none; b=QlwM6feT9FiaLFk9U5JemvOJPuiC4moxuyYDTREoZxSZWjHbyabveGfVThz5cVXf5qJglVqfY/yrpzB2+aH2VzpS0cUI6n9qX5LPhBloy0crnqONfN6omao0Du4e1loKTvyV0N4mqkc5e6jGUmNMTpbJ/4QKo7woGMHUUyuE//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670836; c=relaxed/simple;
	bh=XaikJ0Vqxv5/owJt8g9Lm4uWIq8JbSQckm1iXMFhiCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRRUIumsSGIskvR8vTgpGDZ6mZ9npOITfL3XKqst9prCf56g1hmW9Gr5rOyEXl3/6LUypF7MNUK7dpK0dfds4kdJ1kQtR03HMrpmi6Qm9bk9Hh2X58+3ge2poNvFE0EVTDEFrPNvJAzeKkvDYhbv3hDJn847rRovL2nEQqiPB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IYuc23ZA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4129038a3deso3284245e9.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Feb 2024 22:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708670833; x=1709275633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyd09IvSF7omogU+h/zyCJafYe8OOZZRjtS0nOars3k=;
        b=IYuc23ZARILW5/tjz24Q7ZgV3ioxyVwmOk7nkZtO2lTIgxBC2dmmGkVswGM5iksCu4
         f/LEQh06dQTRUB3cgh/pCUJndVMSlcrgXQkumHUTiE/umpjgevsfb7z6Y+0USqSdUawe
         VIrbMH09DbT9HHS0qFXYuSjbZcegV0S9ONNoG4fQNK3sr7FrQiJkjtTFArmfbnL9etvG
         b8e3M5dyWhxZ7zywnUmQrf0Sjj3ywELZYzf7WW43wBbarwfpSrHRDSj4pIZ/6ZrW6xyl
         RkLA1WZK909brIfVav3dbkfDJr4YLtDkPjScFPreq2MnSipM3y6zKvoh43/2etauIjX9
         XMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708670833; x=1709275633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyd09IvSF7omogU+h/zyCJafYe8OOZZRjtS0nOars3k=;
        b=LDZIJULfca7spLs7gqsavk1ZAHu63FaIu3zGgcQVVDDR1qkzrTTohAWdNr/bD07qm8
         u1IqVXxZCa+P+ITYBFrNUl9a6xBeY8CHfkdnr0v2PqpdwDT9fALhyqpsc8bojd8H1ZZh
         B9rXBaFtuKswO8YWQnSmlWzTTLMvpq0N2Q2HQOOK+Q0CVO0oCEfi2VffQ6zz8bjnL5cY
         Aa7wc90pTpX1SHgL4zftZct8hoW2FQaN45W7677yVACI8aCkEybrUkskFZxijYfNRyZ9
         j2QnUDzcPfhV8Vbc0WHJBo3Uc3+/sEFQSHlSImfCZskvKzjyOf4Yn5M87yfFGtNrHOwy
         kAlg==
X-Forwarded-Encrypted: i=1; AJvYcCUlSLyRW0dSAlJpYwkMOWaUYnzmbybjA0hG6jIaTNK92Fjzyl3y1/3WNM5ODFCYbmtM4OjqND3JT2lz2SzWE89KwC5/Vs0GzLaw
X-Gm-Message-State: AOJu0YyfvocJAjMec4IRdgyUD2FL6NXRCtrZV5of4xth0kgnPx+72TS7
	/OGzkjfKfN4IkuREroG+btg72trCunMnf6LdX7JsFRwuyeu68oSjcN3o9c4Blwk=
X-Google-Smtp-Source: AGHT+IFa4F7JCo816qd08qJytnkaOEApdM3plMi+keu68PlvjipxHkYq76LVVneFPr/ZB9QKYJYcvQ==
X-Received: by 2002:a05:600c:1f10:b0:412:5a3a:7ff4 with SMTP id bd16-20020a05600c1f1000b004125a3a7ff4mr643537wmb.38.1708670833141;
        Thu, 22 Feb 2024 22:47:13 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b0040fdf5e6d40sm1162858wmo.20.2024.02.22.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:47:12 -0800 (PST)
Date: Fri, 23 Feb 2024 09:47:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
	robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com,
	dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
	yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper
 public for other drivers
Message-ID: <88915639-b6cc-43f7-9ac7-8e2dde982757@moroto.mountain>
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>
 <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>

I'm not a PCI maintainer, but first two patches seem good to me.  For
the third patch, my complaints were really minor.  Let's just add a
Fixes tag for sure, the rest is okay.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


