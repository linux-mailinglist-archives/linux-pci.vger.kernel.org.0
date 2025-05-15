Return-Path: <linux-pci+bounces-27813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE69AB8D2C
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 19:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A2F175523
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65699254878;
	Thu, 15 May 2025 17:03:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A76253F27;
	Thu, 15 May 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328604; cv=none; b=WXhQ4tcdlUQ/o/uVExJX1xQ3PqkbrCONe450KxbVqcE/AflcwJ92tZXjzWOeVjyAPhYrcg1Gih6eOWZCihx1PeUau2WeeQUuKO2Hmy9JNS4tYncp82rt2MxUBCZyKBmZ8S8k9Vp8e+6Q9ZI/z64fhLCpNmjSQRCXBe/BgJg4DJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328604; c=relaxed/simple;
	bh=uh6R1dlAdgddMGFM6sx3prRUWfMsHYi3x6hGeKjbjow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJcg4iWl/TfSffgk/3CzffTXoLT+9QUEAVPtouQnQ/d3MOebk5TidPGXGA/9dh6uZBYdNXW1S9SShS6xQRqgxih56Go6YNdMNyEr4wQX/peVdQAopaaz8S8WLguVx1hjlAVMRf7/pvt1z2qI2K/OxbaEGySGASrDCRLhuJwp5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b170c99aa49so770262a12.1;
        Thu, 15 May 2025 10:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747328602; x=1747933402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLxjOod6c7GNxEN7gJsSw7rjhlgITYM+2+XBe1rwdQw=;
        b=DN+kLqIKw9U6aOzG2DjSi/RX4ZAJC30+0MF/Qh9+4TwB/M1LeAH7ccLpnf+LFBEali
         qmCLdOhmkZ3g+CkSr9Br/dbbvJSvqpKN7CnZaB4vvGw7gH5EVvG0nsAnwkXd1v2GaCgP
         j8nPZLg18tQIwUe/rh4z99y37Bd2sGDS2xIhza4vWNcA9hZwBMsm079UtLErE3nSPYQL
         iJjEYJ2MFUdRBF5irrxB+VTrt4rH5RKk0hi8q4QIcQW6lUngzKarSWn5J45e9bCQMnLB
         NmAu8Q4HUksq38JlFzUrbXlcwvp/OXsGKDoybMd0H5z4aUGs1Jl+A7JjPKGjXlDQnISi
         xo3w==
X-Forwarded-Encrypted: i=1; AJvYcCUsB5bDWSwCVEB6rPfdNG+5Q5uIMQsufCWy/O/dCaIEmEZmx6wX+ZzJY+a0KrSdC8/E22C36V91xO4c@vger.kernel.org, AJvYcCUvMkY/v8CbfoUfWhJtrWJYG21aiPKQEnVeEjLGNyv0WKtV3l1ASA5gGFiDItCq29Xn3AHL0Imp+b1AmAA=@vger.kernel.org, AJvYcCVIs7m8jPM5k6CuibL+9ZVUK9ESZJrLk/sRTHh7+z27y5ULzS3fNhg+qkWKIHcU9FvBzwaJgxclJF3nv38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpRwjIB6yK6kjGaja+k1cDKcJUc/QyNxdXdwpqEnpTFz3bHVB
	V+eh8wO9Evxpbli1rbbnt4zQgs1uCcU2ztUt7Z1Fv5dptR7eQeGs2o8i
X-Gm-Gg: ASbGncuOXkuwlJVZ8D9Gq3gicZi1WHMf04CbKGTlBBdc0FG1z2WAwL6xdcNTZlr5MW7
	COrbIWtKDPkAetjLuKry8QV1HwSCJfrV76TVVE8dUl8remTRCc3kTRzRcn8FFKEB2ZSaF6o4k68
	pacsinCdxMgoS/eMdplZMqyq26GBFcu+G0PSbQKjPeYdTv1x2X+ieA5mQ/Bxf/FvMFNmiIHKd1q
	1pz1fejxEQU4utLh2nGA4oyqabXYb0tUtCeYe4Di3M56xs5FMjiBc/AjmyAUBgDrSDQW7YnWjEZ
	j3LqMnPhOl+yYKP5QgsJPV/lKBntoWk+yLroqNm8alCk8A2gvXLDaM9HYq+ucv0JDR1DvacxlQY
	r+IDCYhKEkg==
X-Google-Smtp-Source: AGHT+IE/Bk6IVs4+hjnuWx3gbqJ9TRm55qbJlImLDRHPOVTczTocRgjyowMb8zfGrZ83cdlpimPwjQ==
X-Received: by 2002:a17:902:f790:b0:223:325c:89f6 with SMTP id d9443c01a7336-231d43d9ba7mr3660055ad.10.1747328601715;
        Thu, 15 May 2025 10:03:21 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ebaf5esm128895ad.194.2025.05.15.10.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 10:03:21 -0700 (PDT)
Date: Fri, 16 May 2025 02:03:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	guennadi.liakhovetski@linux.intel.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: pci_ids: add INTEL_HDA_WCL
Message-ID: <20250515170318.GA1507459@rocinante>
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
 <20250508180240.11282-2-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508180240.11282-2-peter.ujfalusi@linux.intel.com>

Hello,

Just a few small nitpicks.

Consider an update to the subject to match the history, e.g.,

  PCI: Add Intel Wildcat Lake audio Device ID

> Add PCI id for Wildcat Lake audio.

Also, for consistency with other such commits:

  Add Wildcat Lake (WCL) audio Device ID.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Acked-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof

