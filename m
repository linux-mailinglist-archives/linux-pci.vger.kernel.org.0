Return-Path: <linux-pci+bounces-15956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D802A9BB5E6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8477B1F21F56
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996DFB644;
	Mon,  4 Nov 2024 13:25:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960342A91;
	Mon,  4 Nov 2024 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726716; cv=none; b=ee+ktT3myF+WFr3C2DI5eMBYNyvwwsYlVgyZMZ4p3Lthd/5chsxQfBrG6S4tiA/Xx2KI6wnBjmUXgstNfntRaFe3ooj78vT7nyC6iIiiySSIZUs2FJ9zaOEmQ+8lkHhLkZbWHqxBioZuPlUzZ8yd80VlTjeHNC6HU0c6nETkTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726716; c=relaxed/simple;
	bh=knMCDx/yzXtOgURCBEpaUlIYJ4+xSLkmDKxAPvCkc3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOgUvXRpFsXDRcqb8jNdti3F32LVpQXSlhuh3OB9ZiwSROhPQbm9lyOPPYKYCjvdowymSxzjG86tE2yVKQIkFo3xFkpHMco77uqAutUNhYGl+ta7hs7+Qm01af2cYpyRtjL9k6ZpcMG1mNDrkXPZ4iKUQ1DoKT6gkRa6AvmUMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ede6803585so3716703a12.0;
        Mon, 04 Nov 2024 05:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730726714; x=1731331514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogMhvqORaTIS8b73g96qmwe2RrdnQeAUHycFc2Jb3Ok=;
        b=lFmUJYm8iBP/PtpcxIg9eUBnt49X2/FlJZUwAHbaKApAP6UPg462a4EWTHvKfNPNEr
         RMtAgPI+I7SD5FnAkKBwbGhJUjMsJVUH8PDIJrFLBQUI8FuOINUl/fXoU6qUHHbUH8pZ
         85AHszzjpscMzCcNM/6MQEPWRNeRSBUh/Qi05DcO30hEeeeGdQkMfDyUpXeFYuZpiPQs
         8iebwfyCvwFej7wZ/9QdcZ5vFQxCwNyXiFylFJC0tZ9UJJT7dZPyhsbpFm7uh9FEa0Bh
         AoDbesvmzKeP/hkcSZZKf5XmqvJU2gp4wgSin5/aaJTVahbWbjIOCtK0OI+alfVyMb1f
         rLkg==
X-Forwarded-Encrypted: i=1; AJvYcCUl9s6Y8cjtMQq08Sd6mSf9np+VZ8TPbHcI5epNpWnkLuVj3/HHYHHoFmSe2i2RCpEsxf1Q/Eo2fx/R5BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRihLhybfOnmXL0oyFkKAf4VhgNhHPmfwbD9Ly6bHkM4ScMAZ
	XC0MAbAdjY2ys5wIY6LE+azY0BtPXEf1Nuj1wHTMgViY3nTukdj1
X-Google-Smtp-Source: AGHT+IEqHvQAsYUPGy9siYTWfU1O6jle+f0vsrJdgHDRINQIgi6G1CiPymMKxPiB4GdjdkvcxWZqCQ==
X-Received: by 2002:a17:90b:278c:b0:2e3:bc3e:feef with SMTP id 98e67ed59e1d1-2e93e0589dcmr22435187a91.3.1730726714356;
        Mon, 04 Nov 2024 05:25:14 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa2576dsm9473273a91.16.2024.11.04.05.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 05:25:14 -0800 (PST)
Date: Mon, 4 Nov 2024 22:25:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	fshao@chromium.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
Message-ID: <20241104132512.GC2504924@rocinante>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
 <20241104114935.172908-2-angelogioacchino.delregno@collabora.com>
 <D5DF0QIO2UZQ.29U999LYCC05M@rocinante>
 <f8ca0f82-2851-40d9-983b-2a143b44263a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ca0f82-2851-40d9-983b-2a143b44263a@collabora.com>

Hello,

> > I wonder if this debug message would be better served as a warning to let
> > the user know that the speed has been overridden due to the platform
> > limitation.  Thoughts?
> > 
> > Also, there is no need to sent a new series if you fine with the
> > suggestions.  I will mend the code on the branch when applying.
> > 
> 
> A warning seems to be a bit too much and would appear like something to worry
> about (or something unintended)...
> 
> Perhaps a dev_info() would work better here?

Sounds good!  Thank you!

Will handle the necessary changes while applying the series.

	Krzysztof

