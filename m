Return-Path: <linux-pci+bounces-22778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9DA4CB81
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBB81683F8
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB631FAC4D;
	Mon,  3 Mar 2025 19:02:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66E185E4A;
	Mon,  3 Mar 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028538; cv=none; b=bKbM2rjzE+qppbjvCdlxIref0nrCwju/cvDWRL6EYUsG4ZoD7Gzbea17AkejV6FOWwwqG0ohwPuzGloDqyGnEFKlAVmpE+sH8dUpQ1bPDjPAnJkzXvuP6U7V7z/EYW43qaXbpc1paNmrER15wZnFrmMRzkc7NqsFZELwa8jL89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028538; c=relaxed/simple;
	bh=hG49xpDm5DKsH1DhbrfWXrOy9i+OQbq/ivQJkdbbleM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baN1C+v8g3yDdfhihVWYtFycK3hR8dO6BUoW4DT6dE3mQ1buTaupSioALIWvBC2HK1/Ahi1vTdFabkz9QFcohPUqNIROXfjG6jV9rqbtmRvhdxKve/twLUSMLwqo3M1e31ogrEBu8rq22jf2TJoGX9VvV1mJXLrHJzO2huqymuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2238d965199so34747895ad.2;
        Mon, 03 Mar 2025 11:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028536; x=1741633336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhAeJk7hkWztNQroHuk4yIX68/s7z+kAA+dtn39a0Rs=;
        b=BP5UnemhzZUzsgdSs99HGAcWrDs/B9FEKh4UhFwCxo6Ktm/FpK0oyDaU23X8+BEL21
         meMV5mZxBkFrhauGD/zELgLKIPw//KG8+dJxDZtyKOEtgtoN4hGSEe6xm8oNNAHDi6s/
         3TnbXjw7k9bcPid5jqBYa58MJansFW39ZDLrREKOu20mOZGDSLHIo+QWGpJXyN8qys2H
         JFx5JO5nZ++6K4gC49JVFzkMiFClsQLvzndhyfIdjO554phIdqqYXEry8dR5UjeEJyxm
         czKOFmAmPVioxnP8dYcdlvVW5ZXd5s60F51CaGzyJCLUG83c3kVWCwvl0qqbRQcmMD08
         qOig==
X-Forwarded-Encrypted: i=1; AJvYcCUI+9KLNlZBwFvy5dyUpejBuVOo9pT3zc6qq1o484zg4YEnZMXrMcHwb03kDK2r26DKzLxFM93IcAAis6M=@vger.kernel.org, AJvYcCUuPYRfdzlvTI7QnI6G+uuO29pPNkkgN56P71CQ/otB1/jKBumqD9Dj4TZ1Lc7fmxahDBcw679yjkZu@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHhGmEasJ+PH1SaneN+zqqBBuaxz7h7sa7KptzlhvIw1MCqYy
	rVwV31IrZAj0B7AzOkvcK/2x+s7/5nWOTGZv5cx2i9hfPoggFIoj
X-Gm-Gg: ASbGncuJbguQY/8VfJZ6gfx5oas+mqTuJJYF7Pj5jc/v3VEwHO8DKaNMCT7hJteaffq
	S+1fKsUjw2UVEjoZFA63A1CxCKmbHg/M4AA278lyMGMVRFkXyDU0WEAafhCM2l7cgH4aTk2p/pl
	bZWK+7bz2wF1pqWg4q7AU5n2BRRyUywVwIcFQchTwSA11ShppXn9bZz34XE4K7+gDFQqZj/sHLo
	UeTEP2rGDoiyjHRJpIvOazSLPJDcLUz+7IarUWWmKfPOZkzPfYcGBh7YDv88nf4n88L5bGPB/Ig
	fTVHxkiVOQfvnhbla/kyKyXi+xRSBvrZPy0cnl9Ec41blNxs9VnCKYqZEk5IubRqfeh1xSzqmk1
	d14g=
X-Google-Smtp-Source: AGHT+IFQe3RRTxnpBBj62quSlfTwdDOTgk22zXvG/+iVJYbUfTjMLi9Wlz9J1z2qtrhuEgsW+XeRdg==
X-Received: by 2002:a17:902:f60a:b0:220:e9f5:4b7c with SMTP id d9443c01a7336-22368fc0c0amr198532705ad.17.1741028536383;
        Mon, 03 Mar 2025 11:02:16 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22350543479sm80982685ad.257.2025.03.03.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:02:15 -0800 (PST)
Date: Tue, 4 Mar 2025 04:02:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v4] PCI: cadence-ep: Fix the driver to send MSG TLP for INTx
 without data payload
Message-ID: <20250303190213.GA1466882@rocinante>
References: <20250214165724.184599-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214165724.184599-1-18255117159@163.com>

Hello,

> Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
> 9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
> axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
> set, MSG without data.
> 
> But the driver is doing the opposite and due to this, INTx is never
> received on the host. So fix the driver to reflect the documentation and
> also make INTx work.

Applied to controller/cadence, thank you!

	Krzysztof

