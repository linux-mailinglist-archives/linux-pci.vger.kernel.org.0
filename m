Return-Path: <linux-pci+bounces-27862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE5AB9D20
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 15:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AADE1BC3FEC
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6317171C9;
	Fri, 16 May 2025 13:20:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01610156CA;
	Fri, 16 May 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401621; cv=none; b=ScDXAPzdkcqi7rxA7RUkETNMzmIjggdakDWbfEOFJ/ULQqIuvqqcHVb28w1RUlttgoCypGPE2oJR0PZFOKYJsOqpq6DO8Gz8LzmqGiWa16z18fsLMRAfg2HRLuclxy7K0qPN0lZcmFX11YFZlJPQXQmT/wahMWkiJVPnjhG6Yxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401621; c=relaxed/simple;
	bh=15SWUdBOxhWrtUcvEWdD+U61nUCkcWm9XOdxxA+9ZQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM1ejF9ICp/+W4cFM16N4BEJhbDfh2jr7GQLOzCedCqMbyGAyebc34qKA+En3YonwamxU/Dd+TaRLK3V/yuXX6jsLKPL1DRIlLlohOMyf7e8H1kwfStKDGxccYteMqjdJO9uy6ahMUzScMjB/VUvjUtKTLuqziGWrxH6gknMyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74237a74f15so2910457b3a.0;
        Fri, 16 May 2025 06:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747401619; x=1748006419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuZyi8fQxeS6QeYoUCGwPtOp9OzM97EiYUTwERYEeJg=;
        b=ccnPG/cK3SUJj00im/r3anAGWrRFIAeIFrxkGZtfPCge4js1TuXR0coXjp5gANJomY
         hmX39EyjAKZItXdepk6WU9CwugYCLJ72MnL23d8+UhcORQOeN9FJCQxzUjW+1bjJVQ7R
         ZncJgks+8swuMcqefqYaZulj3N10CeiYy9/t5QG9fSe0uoPn1t7rxwMLh0GrmLeKBJC4
         rYyQwvN36cRchtgolMn8xbFUV45ZHf9wHSTb8uu3ffgUM34T9byV2ahu1oB0iht8LLsV
         0LZLSZcgZlp/ZE4siKdDzxgD6Y9azmtRWz/MSJf88kQw6Z6AldMLC3jxzGnqmfDE3uYh
         FqPg==
X-Forwarded-Encrypted: i=1; AJvYcCW2K9rattH5L4Hvrbd8GF3IDk5n920WjCxe76RD+Ad0Yi5j/cF+tIV9j9tPnyq2L5tmXKQxgGZpPEr6@vger.kernel.org, AJvYcCXInif2/o+xEJ7XnB8aLDm2DuW1NadY7ieT7Anv+1BVfKAsvK8Z9znvInIZLr6KxEprGOqetqcXUfm2Dlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhB2LAUplxqcAharu1BeJiIr2uZsYarPkRuCXtMVRG9bn69aqb
	My/59BDPbBzkS+alYQwD++WBwy/dQgeif56lOh2fv2zonWFbl+ElH6nb
X-Gm-Gg: ASbGncsXSO1EKzVnvghDs4//l7C273fYgTECVddcIOyIOzP4ZxjVKMmvzDX6jpqjWF1
	RPl7g47GiZK1lDoP0Pcp6AicU+4b05/debFKtq01DP7AIcvDlhsHSyMrSn18RdHkTXQdOPt4dS0
	ihPJhnv5RkgaEAJZymLRJVwJG3fSxfKd2BZJeii0XTwmwTHYINF2mZcXXGYPbOLZ0UGaRsgrMGZ
	+pxzBeKwS2gW6KygVHvn9d4B36u42gQ2TRdjBBXxS3a9f16u4+M2FvplUeVmN1bKin8odVmKTZn
	JIKM1SwC/QmWEZQzO8Rl+nJtch24ngqGyaqwP5/PtGfedhJ/DMX5vwhIJGYig2QUtcFSzio/fZy
	KPGji+/SP5Q==
X-Google-Smtp-Source: AGHT+IEuiZVA40gUNYP45OLiB+Qe3Tiyb27zlSVkJWKAl8AvH6AZBbPTjJF0H4mnm1dFA90bB5i7eg==
X-Received: by 2002:a05:6a00:4614:b0:736:5822:74b4 with SMTP id d2e1a72fcca58-742a98d4a75mr4729669b3a.21.1747401618989;
        Fri, 16 May 2025 06:20:18 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a970a8bbsm1461358b3a.47.2025.05.16.06.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 06:20:18 -0700 (PDT)
Date: Fri, 16 May 2025 22:20:16 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Unnecessary linesplit in __pci_setup_bridge()
Message-ID: <20250516132016.GA2390647@rocinante>
References: <20250404124547.51185-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404124547.51185-1-ilpo.jarvinen@linux.intel.com>

Hello,

[...]
> -	pci_info(bridge, "PCI bridge to %pR\n",
> -		 &bus->busn_res);
> +	pci_info(bridge, "PCI bridge to %pR\n", &bus->busn_res);

I don't know if there still exists such a thing as "trivial patches
maintainer" any more, so I will pull this.

I gather, it must have bothered you a bit. That said, Ilpo... your
expertise and time could have been spent differently. :)

Thank you!

	Krzysztof

