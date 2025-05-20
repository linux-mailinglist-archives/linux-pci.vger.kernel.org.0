Return-Path: <linux-pci+bounces-28076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1A4ABD290
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A011771C9
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1FF265CAA;
	Tue, 20 May 2025 08:59:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5A1A2C11;
	Tue, 20 May 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747731582; cv=none; b=pRhRIre5I2rft9l026CQgJeSMwa2m3khxJ3wSaVXPRnzshhxsMq93sfBBFOLqgRm0iA1EG7yRmj8DvGsLxDREDwI1ou4vyB1QuTWBw4gVT5tTpGllK2zsE0ZDIiyAeVDuxcHMn+L+KA/0HU4p4CgijxGden5vgzzjO6g/Rsppg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747731582; c=relaxed/simple;
	bh=gBMcQ5+mYsn8azD9XaTazQjNY/O+wHoKFYmZ2pxsaSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTKRRJym7PpvI5Amv4EfbJ+GZjALgk9T1+53Vr3yZfS7xg2EWYAwma4ydEC6c6nWd141Q7VGZKsiB1VNv0O4x8KWo1pwEWfamuJvWvg4nQAGOZfVQYifSBnLzSLEB5RwsX1NDzjTuHREkWaD8IuAMkl+olt16kde9KHKxNhT1GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26ef4791a5so3956041a12.1;
        Tue, 20 May 2025 01:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747731580; x=1748336380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLfi0pEuyTFD6XBuJkrVRho/DbcPi8jR4uJxAY4I5v8=;
        b=TlLosDtS9wIAgEU2dyHEz/XEI3r5zLOTBvTlvDvmirOmH8z6rEgjS8uiTXDGow+qIv
         sbjnw+d1+Wjgkx38EI+kWLvLbafSvzcbCOWWh5rBGI2vELT+9tF6hpeufJ3BmVG+K+3T
         1RI7eu0ZMMzgQnzgUB9cdiK0G1W/oJbqREy0fmGAyIJyqDNYfoGcZl0YQeAape5oKK83
         ROMLjJDChL/a2lafDviFda+VIVhOGjbQ+LwgMsETpzsdyisXxVphQ/2F1186768IZga+
         hsRtc5NERXfZEeEOYbCydxDycG99ZptGL0/ct8fS6WlSpWkhYsMFGp39Hhj1w+6+AvOe
         L1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8sYO27M72zYnMg7DpwNskoFQ6JfPuqY557g0vboyHJn7x0Kh/S2tlXyA9IcQ4VxmZ9PWqpETtEWIHL1wD@vger.kernel.org, AJvYcCWTWmhW2HfKy57rCgVdboMYPKOAQ09tqnoiboLiDbRSutt9xOl36KYG8tMjoNFGdVpd5Gmiz1FDA1c=@vger.kernel.org, AJvYcCWwBUkIbsiaxKSUGzFZ9QzaT/1mmyL27Rw0jFpxo356ro6/P3A5x6Ic4COTshfKfMmdeiaHnMt8Dub1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6A0XjLhCdaPcO/8nT+yQxF6ThB0Wpv7aHTTo47jnmEoDGV4IW
	7jXBbNiUUpL/0RyEB9NwWmZocSeE/F1ARmKwqO4W6XHgzUUfjR2VBW0u
X-Gm-Gg: ASbGncsy00KtwgwguEdikcaXs4OsANAjgyxDsvUeM8vO5nlTaLmHp4zws+TuMZOm3Fv
	vuUGCq6V3bOvlbXu7Ro0PdgJJHh3Vmm3Q7s7iHYnYFAtpmQYQyY+DrLO3lR3+rxYXv+q81+FuVw
	1zaW5Ri9ZSo2je4V+0MPoQWzvhANXearEa6NaCasVqjC4W6k27yJv4kJU9VWbk8t4h8PgYrfu/o
	2MOIWg/3XpTwHHmD/HGf0v7AJiI8S+Kad4z0btkJ060Nh5EaXt9EUqREC+RG9sOd6wTpI4JTmfm
	D2eHBeu9wSlBqsNonT7iQp7Xg/paryvaERShh8K2hV+X4BLl1EiNDflw3O4EUzf4ZFf/sv6e58C
	k2tjZlgioVQ==
X-Google-Smtp-Source: AGHT+IGSqf3MU+izPMKLlCrbGSWVC/G1d9UwwNEmDN5xjK+vRzDKQOMtuc5PXaA9+x0l/+g2MDqL5Q==
X-Received: by 2002:a17:903:1c9:b0:22e:b215:1b6 with SMTP id d9443c01a7336-231d4548442mr256968035ad.28.1747731580145;
        Tue, 20 May 2025 01:59:40 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ebac32sm72369455ad.170.2025.05.20.01.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:59:39 -0700 (PDT)
Date: Tue, 20 May 2025 17:59:38 +0900
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
Subject: Re: [PATCH v3 6/6] PCI: Remove hybrid-devres hazzard warnings from
 doc
Message-ID: <20250520085938.GB261485@rocinante>
References: <20250519112959.25487-8-phasta@kernel.org>
 <20250519220756.GA1259384@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519220756.GA1259384@bhelgaas>

Hello,

> s/hazzard/hazard/ (in subject)

Fixed when applying.  Thank you!

	Krzysztof

