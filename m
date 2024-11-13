Return-Path: <linux-pci+bounces-16691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED38D9C7D18
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 21:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C221EB2388E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F520696F;
	Wed, 13 Nov 2024 20:44:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB22064E9;
	Wed, 13 Nov 2024 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530641; cv=none; b=dyoQTWY9uuYlkGCfgid3PAK9ToF5TtjyaWELWp/GPoUYTzz9jf08YtWNjE4eM1hTsGyJkkLbxbiCJ8bStL2Q9bpOIqhhQQZgFE6uNwk3G6jO8NRXcX+OiqTRqd0t9Ipli6ikc7T0P2Uf7kvqVapU4IC7gDOmT8zs0ZXls1MtQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530641; c=relaxed/simple;
	bh=1MVx1bU+yRj34J4oymMYRw7hpiratCvLpEAWAXsf/gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyuEWO/I+1uOgtB80iJvMT+wPncHe/tUR49vEIg0jTHYEMC27PYrLbG9We2oa4Jo0w9jM6LDvvys9JmrN8uJi6E/yYfLArSFtLcBfQK/cxysYDOrYU7ZR3b8QZV3RrsmfzLEu/7k7DN28j199tcHmDSyH4Pr80dmsC6CpxxjxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cf3e36a76so77234735ad.0;
        Wed, 13 Nov 2024 12:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731530639; x=1732135439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRq7HA8R4Yc87ct77Btl5P4p5LIi/AWOC0DPJEG4kLo=;
        b=d0J5CJOQHDol0Y4JkedZ1VCrBVY9iR2gLBNDFecy8JxgFzpj5NMdmH+mszcbaQ0nNf
         8OgNMHiOyEFif374IZQkZPI2HqGNrG0wzWXq0ArKBRRayovtYYck7QQozgfP+UODD+s/
         JoAmsTDh22v4tvlQZhLjA3u6CE5zwytqKtPqbO/wEO3meLiPLeFe5AIiqLXFhxMY1hG7
         R0G4bNEWwadtC6Py2pSU0z53TsdNtBl75+gw8TylaVXqzpLiZF1ySuB9IXxjH1CS0FyN
         OBz1ecAv6aJ7tocYryM3Cc0Krq37IfrsbTaSnVC0kFdHT8vp5g6qpGYRaQeN8f7Lwz2x
         hc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZrLe0foKIdRu54ELuSubtosCVUeg2lgPeEmN8AwDh2evHtINk6aYJmjZz8KHcz7ZoaCTKxqUcDJxu@vger.kernel.org, AJvYcCXEgN+6uy6yRjerTRMP/Vch8K4x8L54+EOwdM7dunajpBUFTVPR/dhInabRcbQ2K4xcpPSgiADpHyUpXUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJH0drHJ9WxC6rcv8mTEGz6S9RJirNLzAvC7OmEapTuVYyxLY
	QHL2RKtbDsuJPqZAQGdwjQ4Mx3vikn/bELZTF+B1iaSUQUpblK4k
X-Google-Smtp-Source: AGHT+IH+xt1qFBsd7q/DjytVDX9H9GNmPTwlfxa+JwVbYPjFdSHb/h1Jyme2qmdbuoS6hPSgEY5tfA==
X-Received: by 2002:a17:902:ccc9:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-211b5ccdc57mr67452805ad.32.1731530638800;
        Wed, 13 Nov 2024 12:43:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dca30dsm114474555ad.35.2024.11.13.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:43:57 -0800 (PST)
Date: Thu, 14 Nov 2024 05:43:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] PCI: mediatek-gen3: Remove unneeded semicolon
Message-ID: <20241113204355.GA1138879@rocinante>
References: <20241111010935.20208-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111010935.20208-1-yang.lee@linux.alibaba.com>

Hello,

> This patch removes an redundant semicolon.
> 
> ./drivers/pci/controller/pcie-mediatek-gen3.c:414:2-3: Unneeded
> semicolon

Applied to controller/mediatek, thank you!

[01/01] PCI: mediatek-gen3: Remove unneeded semicolon
        https://git.kernel.org/pci/pci/c/d19ea320d302

	Krzysztof

