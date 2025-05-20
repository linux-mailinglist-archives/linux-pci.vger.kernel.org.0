Return-Path: <linux-pci+bounces-28129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7AABE172
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 19:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4503ADCA6
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F5426C3AD;
	Tue, 20 May 2025 17:02:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F526B97E;
	Tue, 20 May 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760557; cv=none; b=nC5s3eRBhNaAE4yXnIKuEWDt9aSal5uITU2AeWXO43dGs4t/aG4LfxX5o8GMro97YGbCSH8VLYgp8UPsOmXGuWd2ciYm/7XDQNonBz2TG75rSpEHrfaX/pQx2jimzr8DTlyflr3CRSU9AU2FUWmNdwt+6FtOJq0P73sL9SSMdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760557; c=relaxed/simple;
	bh=g8A5zCbjZuhxigR/xz8pKAs8Gc/GyBF6sQ/fa3RFroM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzIAY9pBdgXtC2ztNTgj4tF1x2e/ohz2OFIePpvzBIDywmzYKWuLX15YCSM9on5CezOtOzVoLpgz4p53ZGXdcjxZoK2BSePRbgjrjpIA0YFChrIIhG02UYF+ZXPsIMWWCPXVIliNWW4Py9fVDRII9MJzV8pglInKA1VnoupnBpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74264d1832eso7538937b3a.0;
        Tue, 20 May 2025 10:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760554; x=1748365354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S+a2h/CzkxZTseGiaH1FJLiOpG9+0lAP93n/wBV1XI=;
        b=cQDEM7QVGAX9bXuxcIee/TKZFsvuMxl1MhnV/TKi/EHMhd6EQ5bcz1C+5P6Cw0sJnL
         p5APgDmxuBDkmG9enCn1rlxZLW9/7Ve706NhZX710lqFBDESkcWErmn5ceOAC7dsmaEa
         zS/Tq9lA8MPYGT3YLU7MoNO/TLpAm/b+8kQmu/MLf6XjnbESDyblc8pPB29LfQsXDZui
         yubeqqtQdAmWmFzluRgLL94IjzrYkPFvW4O2ws+kYvwa7zVoCJZn/VWRqrfqO6nP8kTD
         ddfoMq/EDboMt430f6lo9Qyf6J4/dYgSOQm7GzZsTCenFPL3RUp45dbMUG3RJqtooEsr
         MeEA==
X-Forwarded-Encrypted: i=1; AJvYcCU8h+GKbBG3MOxFzi+bGGOGmRSp131soyWcSEZCOp66xRI4ykd6GIeTU9es6M2COa0CsMXqsnzpxVxScEoN@vger.kernel.org, AJvYcCUZu7mttZg1MhFiYlCwp0tOTeyz9HvaCYKqRxh9ECBmfarAOpXARRKBnDjF56kI0lK9NFBndM0s1iU=@vger.kernel.org, AJvYcCVeaYgFvPNahfW120HfTfLD2CEl9Rp5Hn/i1UZJZ7Q6Og0Ad9+iJ62/gM5g8AQNKQ0AWjoOm6OU8cGN@vger.kernel.org
X-Gm-Message-State: AOJu0YyNyYN0RyD0WCiwcDIuBYddcjGpxH128ns7k6OsiSn9LHORofVJ
	VUd8hCWjCZbMjLX/KByIV1sxdVpyjO4ttFDSaNpkx8bzh7bzVEX+rDmu
X-Gm-Gg: ASbGncv2JvwpsEkGMzEMReC9V8QfO9eqbNf4Ma3jQKl2SBVHaJAz6eXGcTabO5qxx0+
	V7x8Icts7GfCh/OEh6MIMpl+MNonL9GNn0bPNigo6rTbnO5FGr1AxULuC64j4ByU+o0bkYhEm+6
	KRSVaH9EOewfAbEkkwR8QeUKRi/XlWLRLtyM7olOzb16A7dgQftM1z0cQBb2ZmE1ej0UDv4Yf/M
	6CcIKhIdfVrSE2EkWhZb81k6MHJJAx2RMH9Uuz+kM4sBI3BkqgvQciPj9yGxirwr4WiSTG5n/Kb
	0VjL8PK6/5qm5dcnh5VEazoczHNK0JaKtyktwxOZbIM0BA8bWR8z0glz/fKSjr2UOm9JJuW+9H5
	0KO3DcRgsFw==
X-Google-Smtp-Source: AGHT+IFYtmAxpAJyCJdJh77irdlIdb9jAeb6Khn8bWcpyG2JL1R3yfPaZHoaLGAF0GW32sgkBqiY2Q==
X-Received: by 2002:a05:6a00:4606:b0:73e:5aa:4f64 with SMTP id d2e1a72fcca58-742a98004abmr22827579b3a.10.1747760552980;
        Tue, 20 May 2025 10:02:32 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a96defc3sm8189751b3a.21.2025.05.20.10.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:02:32 -0700 (PDT)
Date: Wed, 21 May 2025 02:02:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6]
Message-ID: <20250520170230.GA1542130@rocinante>
References: <20250519112959.25487-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519112959.25487-2-phasta@kernel.org>

Hello,

> Howdy,
> 
> the great day has finally arrived, I managed to get rid of one of the
> big three remaining problems in the PCI devres API (the other two being
> MSI having hybrid-devres, too, and the good old pcim_iomap_tablle)!
> 
> It turned out that there aren't even that many users of the hybrid API,
> where pcim_enable_device() switches certain functions in pci.c into
> managed devres mode, which we want to remove.

Applied to devres, thank you!

[1/6] PCI: Remove hybrid devres nature from request functions
      https://git.kernel.org/pci/pci/c/51f6aec99cb0
[2/6] Documentation/driver-api: Update pcim_enable_device()
      https://git.kernel.org/pci/pci/c/b4fb90fb9301
[3/6] PCI: Remove pcim_request_region_exclusive()
      https://git.kernel.org/pci/pci/c/8e9987485d9a
[4/6] PCI: Remove exclusive requests flags from _pcim_request_region()
      https://git.kernel.org/pci/pci/c/85826c11e77b
[5/6] PCI: Remove redundant set of request functions
      https://git.kernel.org/pci/pci/c/bcfc67157e41
[6/6] PCI: Remove hybrid-devres usage warnings from kernel-doc 
      https://git.kernel.org/pci/pci/c/90ffe1f093e8

	Krzysztof

