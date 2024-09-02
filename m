Return-Path: <linux-pci+bounces-12621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4496898E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 16:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CF0283F72
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F2D19F107;
	Mon,  2 Sep 2024 14:12:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B719F100;
	Mon,  2 Sep 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286358; cv=none; b=MBbdC3dinSqkS9xoBY4iRTJjA0pTj8qB/f9BO4CHEVTwuFZFvMg7sXBoC557X8lQGUhuU/1NIW+9O+gIIJ7+Lm3uAdfajdHgl5D0LzSqe/HSaosjUitCgzLNgFGAA3oyD8RmTexQixC3wfCLd33eygWhSyrJAEu+ZTgC7h2bBws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286358; c=relaxed/simple;
	bh=Kk8CHL+kR6atoREqYqkSYJwr9BSSnxuF4pNB/FP5hzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THLZ69zNxhgrVDQ+zbjfJ7fVF1AusotxB1wvHDxNoNFRtxzBwg5PMBNtD8liz2cyMzdp3tQfQFYcucuC6owBKfDDWjj6pE2rmOoW+eYXGMLhtrlVOXfU86QdauwMhwzYZC1BYD/ugfM10GPIT10Tl87rTfy6PHI8ghyyiqXzj8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d877dab61fso1694747a91.3;
        Mon, 02 Sep 2024 07:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286356; x=1725891156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F64bS6DRw3UKsmpMpP0QQPIepPXU+WPPJPaEDVUhgo8=;
        b=OQfeC8zhJGvNsY05V5pz9b/V8D3eBcKwRtmY68Cb4ZsOEu2qpxFvEs/jBWrujcmthJ
         QVNKNGqlEvsn31w4jfAUqY7xGPs9VhqIZ816yrfLmDDa6YCZFEras9klCxO5tkvrx4Br
         2Pe3q+ZPYmkXraBNYLzMARrGh0gf2evXMwGbAsjJRFqNDotqUwhFUiT9gas7k02cuX/m
         dnGsrqTSXYid2ugu/zjdOHcfEfIWZMgSNjjwB6bu0KWoWwL5cVGrz/9KmJSRR0KfMvJW
         2/q6oqNj5ZkcDZAbOt8hKg4yPSbuylJ8t0U4joBqiSUHstlA9vVDgta5AEbMTciYOSXg
         9smA==
X-Forwarded-Encrypted: i=1; AJvYcCV5WI+QlPKzfc+r5dfaZS+Pfu3OD28bNYaGEfpjWbCcjWsEiD2cWvDVaMAlVvsTUUnMmAcC8BPzJnyL@vger.kernel.org, AJvYcCWMVGLVo5dh7G5s8Ml2HkVrUi5/XFlbc/HZAFmeo0D5CcilNOoeK22w0VKpi6GXI0MZF+VpCw7Asf4K/Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1mAGPIqGlNBZu169t+xK2s8XjqffxEfElxTrnpimhCW/0UGN
	0ZE10YP00iZt9am/MGNJX7f3xzM6cBgzDJ/aWT+s04zrwHQY19hh
X-Google-Smtp-Source: AGHT+IGsWW78e/zRV1dWhn7tH0/rGhlf3HuFQMz2+LGZYfUGsIT8PRfJ25tgS4V1WDe6lJrUL0V4hw==
X-Received: by 2002:a17:90a:4481:b0:2d3:db91:ee82 with SMTP id 98e67ed59e1d1-2d856503a10mr11179272a91.40.1725286356015;
        Mon, 02 Sep 2024 07:12:36 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8b8fe1f68sm3237345a91.31.2024.09.02.07.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:12:35 -0700 (PDT)
Date: Mon, 2 Sep 2024 23:12:33 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: pci: rm .*.cmd when make clean
Message-ID: <20240902141233.GA261040@rocinante>
References: <20240902041240.5475-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902041240.5475-1-zhangjiao2@cmss.chinamobile.com>

Hello,

> rm .*.cmd when make clean

Applied to misc, thank you!

[1/1] tools: PCI: Remove .*.cmd files with make clean
      https://git.kernel.org/pci/pci/c/f5383c543de0

	Krzysztof

