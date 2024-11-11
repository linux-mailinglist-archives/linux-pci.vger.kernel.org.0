Return-Path: <linux-pci+bounces-16479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB2D9C47D5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 22:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED06B23243
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 20:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82DE1591EA;
	Mon, 11 Nov 2024 20:47:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BD13698E;
	Mon, 11 Nov 2024 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358054; cv=none; b=fGapnzKgETeFqOUn0FVaI3/Ho43mIPFavfOi9iUhstdX1jWQgObEm/NfRxoc57rtEOnRg7jw5vROVwzW6Ns81FnhYBafcFXFEWjE5rrkRpQ9I1yHlCyWgMW0LiIZVBDd83W49NZBgRDm4IAkhh3+oMq5NruQZ++7tCXcRbgDoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358054; c=relaxed/simple;
	bh=jpWRdSD3w2487IWRKyT0ss5uQYKe+lnpZOydQN/c4+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxNHyetYb3cqMVTIV9T5vVn0BGtHCkkpRb566YbGxrOlWDMCs5iA1BAvTUHDxjrFXvp1pJQsOPdXoU8OaetUPjCOdGLPpGkcYagzl8YPmrVJsNhUv+2LUW+re5IRla1eCanw1HtDEg2f4RbCdEHvfXm+Hs8KQrrhzk0bG9EjNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4316cce103dso62319065e9.3;
        Mon, 11 Nov 2024 12:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358051; x=1731962851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FJxCy9nRJVtXfCTsU3KXy5JjuHCmavURmafpMWip8Y=;
        b=sQjUEoVE0GUxV+BNbHVqmuzqInZRjMz/YkrOq2BVbXdt+3eYx3Ux6Sif4EoaaeACmY
         UmOVKwRj8NHyQQNl4/6uRbUE/w2lWS4KKTcjI5kAMZ3qotIOQjj2RH/Xhw1uAPSqZriK
         sLGEq5hrdSBzuoosPB6Y9HaHJdmh3V6GScoHoN7rUokKwAIiJpShsDqzZc25nYcRUnxn
         fO5WCYgDNnfSyyufRXvVtNR+OdEOBa6/3vFAx94uLEyK8bKWOBu0oA6AqTEcGCnhWZ/4
         ED8zVu1tLQYJ4GsYm2IFNo3T7ZPTV9nANSby1jiEWrW1ZjOk8uyn+AWUvIxHQ5wj+3mi
         JBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUObsXlEG1LqTafjow4Xqb6gbtZAtbl4/mZQukAeEU9ShWksm8fG54iJWXraExAwDTfY4y3H6SR/MYT@vger.kernel.org, AJvYcCUjBOkFb5Cba9UiVZPt5RhkC2lKmRcCEdiHFCQVwzhyhEZRG53iRg2A/xfWAiZ7H3ThZW5aAV9UlHIY91Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSfMW73NyQ/Nl7PSbT6IFwXn+Ftw3U9BwazmehTyLKR3cutb3
	qzDAPZ3iC3O5TH/uIykzikkpTjtTub/zd0Nzed9bVfa1JgHdzIj0
X-Google-Smtp-Source: AGHT+IFI2E55Rc3mQG84xqyhIN5Toyfc2naC+drFE80OuMZoOLBtHsrsaeYFSq9y+fXhLMa9XRR2xg==
X-Received: by 2002:a5d:6c6b:0:b0:382:5af:e996 with SMTP id ffacd0b85a97d-38205afeae9mr2197479f8f.46.1731358051094;
        Mon, 11 Nov 2024 12:47:31 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed987d33sm13946207f8f.43.2024.11.11.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:47:30 -0800 (PST)
Date: Tue, 12 Nov 2024 05:47:26 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	"fshao@chromium.org" <fshao@chromium.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v4 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
Message-ID: <20241111204726.GA2193665@rocinante>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
 <20241104114935.172908-2-angelogioacchino.delregno@collabora.com>
 <D5DF0QIO2UZQ.29U999LYCC05M@rocinante>
 <f8ca0f82-2851-40d9-983b-2a143b44263a@collabora.com>
 <20241104132512.GC2504924@rocinante>
 <c5385db34878763ba7df3711a514e4332418cbbd.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5385db34878763ba7df3711a514e4332418cbbd.camel@mediatek.com>

Hello,

[...]
> This patch may need more discussion. I have replied in the previous
> version:
> 
> https://lore.kernel.org/linux-pci/7e220693f076c84cc1bc3d91e797580b320b4598.camel@mediatek.com/T/#m1b9f2d26a228712b6b9d02eba11d8063862772c1
> 
> Should we wait longer before applying this patch?

We can drop the series, and it's not yet too lat to do so, if you believe
this would break devices like the one you tested the changes on.

> Do you have any suggestions? I can provide more logs or test results if
> needed. Sorry for the inconvenience.

AngeloGioacchino, have you seen the reply (see the link above) from Jianjun?

	Krzysztof

