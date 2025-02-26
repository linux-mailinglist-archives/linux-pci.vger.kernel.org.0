Return-Path: <linux-pci+bounces-22446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FBEA46326
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 15:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4231B3B4A67
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F9022157A;
	Wed, 26 Feb 2025 14:38:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98B21D3DA
	for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580695; cv=none; b=aP8X+zlKLOWB/CwAmOedFBFZg4kgxDLwKkDNXSGdk32ZOdx6zs7BOb78QYHrzy87yTa4EE5cntMYTX8h1iMJKb7E7SRylD578RVYjHOGaWJzrykslmbI2r3jVg1fwemLAoe6BOa0BYxhW68KAjlRgjYN86Sxko5wa4W3NuGN3R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580695; c=relaxed/simple;
	bh=N7Ol210Sbch4pxmyeaNswvosyfErCldP9On3gJUokE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sg48fZHqckWY3TXLuWWzWzlCcmsBJeJSgt6vb+1owcq7FweB4jephdcyoCbFo3s2dSMiDK5XD5UJSbJsmeXe2qmsimBL9fScTgruwwjPlr/ezuyh5WXv51helad8thXpiuIGq0yiqjKHKVSOO6nwE8b3sAi5Hyk6iKp0z9vCcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c8f38febso145195675ad.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Feb 2025 06:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580693; x=1741185493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP5XsYkjBATp/MflxZ9Tkpm5N2IqpXbz5quKiUtkI0c=;
        b=ErmHbp9MY1YUGPapUlMobFIFlTHqQExph0ekkkZiLZJP+qr3yZr8JELBm1kqbXx3k8
         dDvqDgpmmmbac3AITdH7l/UiO39wQIre6eiaiDSNfzKyo6MJE65B7kdKQRIGaRhVArm0
         jlpsfiBeArWiG8r2URKxiz1G4e3Q6Jg5CjwXd6vokLCHm/LGRq0jzpk7xkDdfWlY8xOO
         6SBdPvWnXaZkgipQdQf2wJeiRmBwPFQN/fLZBjucW8TuWrov/azG9gVDRBbLGD6jXlxv
         flkBVgdm92Q7hdqLGh+tphzJpU+71/jWz4tZMeviTTCZThKMVn4NBNDDw462AQVtM78k
         CT/A==
X-Forwarded-Encrypted: i=1; AJvYcCWflYsqCx/qANZpyViAfp/g74pSBZ8RS6UeIoUNIOXn1UnboW9mbrIgzV3QMgmbOxvQRKxtKXcBslQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR9YK8fSSMQ4KKef18hEWwFYG5++J23or7avz3xwF0mhRdea/i
	RtvgFvk/JLpOV7Ikdrj/BhxzUUxb/hdhc1ayKXVBimmvhLoBdpT5
X-Gm-Gg: ASbGncuGIqBHhljMbEuzVLp0XnvXqv5VLnIQh5u/53cCbpzuo+WLHUnRqbqXO8xFjdr
	0NfTcusEFr0KYK/AISsmuGThxG0drgtnDZa0qkRvNsWcFy6LF0huF4LbF4kOJCj01w0L61p5U9n
	fANQQfm7YDdPy03xX76VLH+dngzD7fnhDD5GoXYDMr/tR5YJ09G70TP2IUt4s0Xsoe5WxpOz8BQ
	S3sDp3Jhu6/PdtQek2uQMZddxIpXRSXXjqgukK8K8TEqp98uVrAqjU4QVXBh/b3lmTX2EFU7Cnz
	c/tvA6YAZJXO7mVC+8dru1lcUocN2I4cOZVV1F0VwuZiG/z/xx+e2ftDQ8s/
X-Google-Smtp-Source: AGHT+IGnXzD26/xqRmQTb2lsShO2tuqLHzjt2G/8QC2NoOh3UENI/h5w23EAO1KJwYLlCLAu2jv+TQ==
X-Received: by 2002:a17:902:e54e:b0:220:d256:d133 with SMTP id d9443c01a7336-2219ff9e7f3mr391065875ad.14.1740580693169;
        Wed, 26 Feb 2025 06:38:13 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a01fcacsm32916285ad.95.2025.02.26.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:38:12 -0800 (PST)
Date: Wed, 26 Feb 2025 23:38:10 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: ep: Remove superfluous function
 dw_pcie_ep_find_ext_capability()
Message-ID: <20250226143810.GB3546651@rocinante>
References: <20250221202646.395252-3-cassel@kernel.org>
 <20250222155002.lnig57ku6treeznz@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222155002.lnig57ku6treeznz@thinkpad>

Hello,

> > Remove the superfluous function dw_pcie_ep_find_ext_capability(), as it is
> > virtually identical to dw_pcie_find_ext_capability().

Applied to endpoint, thank you!

	Krzysztof

