Return-Path: <linux-pci+bounces-9886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE49296E6
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 08:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7121F20F5F
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176C979CD;
	Sun,  7 Jul 2024 06:54:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF58125B2;
	Sun,  7 Jul 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335243; cv=none; b=a/VfzrpoT9DnfaUt5WycwU+CRmqicuyY6JorBq/xuRBILyubndOOmp6+L7M0b/zdmFbECeanTvPvGpAtlVEcfiTTcAWJvK8OPQ2ygXHFLfidzeZMj7X/pPuodI74dD7jsDB85RLJL51RCCpoiTrvtOobNP7IMm/4ytZaxt7Gw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335243; c=relaxed/simple;
	bh=0W2OvKgWkCMl1uTMluMqC8LesqCmJbfOCaU1FmjtyLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNWl5Di5vxHt7PbxQPmiF/rgRmgIe17f4sM/jO7DQXbLt+3h8cUn8VpQmf4AGNWsgs+GXayGSI2r/KPkoSI3AIJNu72jrK9K+CwBYnmdiVndkuIQJVqPt4o/UkaE5uLCTal3nTOBGWL3EKx0lVVYijC4GzTXG9Mf5NnOm/gTMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb05b0be01so17094655ad.2;
        Sat, 06 Jul 2024 23:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335241; x=1720940041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JYBMADKU5e43KLTkm4N5GBLxm7MyujvJUYfrOxGV6o=;
        b=HrmpOYrj84goPDx9YkK01Qka4l5m9irwVZCBWh00/kfGHI4cHllAn9A1g0+97TrohE
         YwN2bg3U/QW5VLaUN4hk6LLKcyKt+5PCOOX53vBbjznTuKy6eB7lJ2x/BSMbcIfOHYgy
         8+TbAetCcC75D178BKZEssuedUxUF3ORGgFhQ6S5BCNhs6Qr9xMASceYBIRNbLoZMNUz
         eLKOOLl/Ekbt6JRJy+JAFzqlm1Vmwckcr+4hCFF1sa2M93TA/Y1KPE3vgFEFd7qPdzpw
         H3A1fmACZaSYj7haZxlXCH61+eobkouykgRDYVkKBiPZKcaYyaJ4FpiFW1s6prkYr6GG
         BzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHWP5xLdHFveonie0EW6auSu5dJPVf3kyXu9t1te8qa46OQOTWPEZkQHGBoZqSgDlgQdhBjuqVIav7iDfsB3/+1MfBGdfN/QKgBBzH9HTafVfmn20U7Qd5/9xrZP2S1jhsOAi3dlg8
X-Gm-Message-State: AOJu0YzeLUZ7ZPzJep5K5nsg4WGroLwu9SbaNxvhRgBgb+95sMDUuMpb
	8W3ftx8A6NbPGrdCHAS4d2n4Pu6eI7jkA4bCjPv+gIskd9iCrlwB
X-Google-Smtp-Source: AGHT+IEQ+FaOtzEXvU/iRRCzYUPGAkAvN7iYcrCrlRo+z+uOsIDeaKNAYLV1qz1NKphWv1sY69O5gA==
X-Received: by 2002:a17:902:e546:b0:1fb:6ddf:654b with SMTP id d9443c01a7336-1fb6ddf666fmr27777895ad.65.1720335240768;
        Sat, 06 Jul 2024 23:54:00 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb3dbd7dcdsm50783255ad.157.2024.07.06.23.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:53:59 -0700 (PDT)
Date: Sun, 7 Jul 2024 15:53:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: kirin: use dev_err_probe() in probe error paths
Message-ID: <20240707065358.GA3809216@rocinante>
References: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
 <20240706-pcie-kirin-dev_err_probe-v1-1-56df797fb8ee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706-pcie-kirin-dev_err_probe-v1-1-56df797fb8ee@gmail.com>

Hello,

[...]
> Use dev_err_probe() in all error paths with that construction.

Thank you for this nice refactoring!  Much appreciated.

[...]
> -	if (ret > MAX_PCI_SLOTS) {
> -		dev_err(dev, "Too many GPIO clock requests!\n");
> -		return -EINVAL;
> -	}
> +	if (ret > MAX_PCI_SLOTS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Too many GPIO clock requests!\n");

Something that would be nice to get consistent: adjust all the errors
capitalisation to make everything consistent, as appropriate, so that it's
either all lower-case or title case.  A mix of both often looks a bit
sloppy.

Do you think this would be something you would be willing to clean up in
this series too?  Especially since we are touching this code now.

> -	if (!dev->of_node) {
> -		dev_err(dev, "NULL node\n");
> -		return -EINVAL;
> -	}
> +	if (!dev->of_node)
> +		return dev_err_probe(dev, -EINVAL, "NULL node\n");

Perhaps -ENODEV would be more appropriate here?  Also, the error message is
not the best, as such, I wonder if we could make it better while we are at
it, so to speak.

	Krzysztof

