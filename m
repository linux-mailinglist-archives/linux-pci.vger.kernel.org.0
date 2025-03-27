Return-Path: <linux-pci+bounces-24843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB193A73154
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4901891755
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEE22139BF;
	Thu, 27 Mar 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KdUG0aH3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464D17A2F1
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076656; cv=none; b=eXW7ltgNkbL+nEwkObu1mMSiEYeGSbCYyMSfrsBWAlokSxAIKoHMR93mPb8gn+t/sulz0l0pxnriIjbdXuOgYFy6+K6YwLVfyPSVvQ0g8pHr700JJzNCZKWC5ulWZkO0qQeerOIeERt5rg6w8vejkR6AA8FpIDfxBnfahOcWvqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076656; c=relaxed/simple;
	bh=AL7gJ87a2UA6E+40BaZ+E4mdcf+6HZXsmDjrJ7tBF8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/K9kDa3mKkNEIY7iO6D5wBywIFdnlDzvV3c+0Oa4UE75uJ5VDScctioaQnO09b5OZT4drF6ZJFdy75vjIX5aqEthlWR9e1G+8XCEl9/xJmyatmrBiN4YTxf9cahktWG0PC6fOm7F/pYF6wpMTf+TTuaoJBTz3GaPw1aflYLqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KdUG0aH3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c08fc20194so198508685a.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743076652; x=1743681452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpSvo5VpDe+5C3l3q6WN5wiD27fFfcYVq0S4jyx0P6k=;
        b=KdUG0aH36qKf4ZKce21gUhCKT3ZUf2WNoOC0rZa2gRbutluZ0jCSFAmnnC+61A2sd0
         Njdrt1Nj2fXg43CLfCF44LW9ef95MhDEJWEEmBMehuOBXiRYdTiM30rWbtrMY/aWEGLd
         rYjBgTZlgpvZjm8HkNrGAcL/EbG9VgKscRinhah3bTwjaG8M50uvOVXNokIPSnt+2lkx
         mhlCuyeeTnoP/Xsk0vjebjmQA7seF6lSHIkFYpP3gnAknC14p/N9vvbD+gURC8OIj2bA
         LqbmNtn1g9Wn3vq/xXgwbUBfBwXSqyhktBciKekra4S/rYXgxaWVSGCpYbJtPZPWTipD
         /eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076652; x=1743681452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpSvo5VpDe+5C3l3q6WN5wiD27fFfcYVq0S4jyx0P6k=;
        b=ZayxGQo584Qr3YrRh4BzB5oG0vvQZg60heMhTOfaf9xxV19L5tIH9PbY1jX+YWAxri
         Tslc/vm0uOWOz7Zl3yvMol9+qwQBTQiCgrY3jkYYP8nZzYQEz2UVuEgxiimGXIOh28Es
         AC0uB9pqIvlL6Or3Ol2gkg4Smh86bq61i0d78G7cX4VG0icEzj0uoAN0rw94gTzGzm3W
         VD4SCm5mcFlM4NBcwRd9yzcNB2XlgCaqL5nBQSXWOUGrhFb7uJZ9HQgBu/yYzjLti+Dc
         9cE1LSBSHw7Zb9NHaoodrYueYlbHXDrUJ3YHvsdboPJksBzBEx5D0DBifVXUmZf98yjo
         Tjlg==
X-Forwarded-Encrypted: i=1; AJvYcCV5TBtmcN5rU6KhQfe3sFyICowIDQSRIhttBd/AqbRBb6TdnYcRrY5/1KN6R+VZw+l4WHK6q77adDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UHRB1RLbCDgKakEwGuLg1zoaePFowZilb5FuBh+X2RMCbo5/
	2IGcxvv6iF73Xcl49i9Nn9hNaKOHhzuiYrXjOJP+Kyapf6iu6goSlR4GJsdkEiE=
X-Gm-Gg: ASbGncsza7w3VNjCvCGAARwUZCYha7tkAPW6VyUdzBo1rAYvyd6YiOTRxtWSo8vEKmQ
	2KTmYi/lGddaMTKspCNEXVKhSrQVTJ/gKiaVpL0vOmSOvGewkCd1/PTgbE3xmYhYSiyysgNAK2X
	eMyURKO51R0E3/RCbR0HdfYe+an5RXbRd+NjQyX9aj8Xnyuu57xljyhd1QggvkaBHcMNttGIQlL
	8GjyalvitPF8i4Ar7FDSsaBLdx8ZMF/Kz6zBJyVWBUxj0ytiaiz1N93uPioBlpQWtF5zquXqtkA
	xW6ibD1ybOXYbS5ug9E2w0outBAC0RPBoScUG/k=
X-Google-Smtp-Source: AGHT+IHXYc+blwEc+1Jk6K0qq58ubOvP6uoSjfLzJ99a9D1oWzuzwHQ5UPYlNMHK61Rbx4L/GoX0BA==
X-Received: by 2002:a05:6214:19e1:b0:6e8:90eb:e591 with SMTP id 6a1803df08f44-6ed238b72cdmr40938446d6.24.1743076652436;
        Thu, 27 Mar 2025 04:57:32 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3f0003c6sm79108206d6.120.2025.03.27.04.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 04:57:31 -0700 (PDT)
Message-ID: <2853aff5-9056-4950-a796-d3e19a0f0c5d@kernel.dk>
Date: Thu, 27 Mar 2025 05:57:30 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtip32xx: Remove unnecessary PCI function calls
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Philipp Stanner
 <pstanner@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yang Yingliang <yangyingliang@huawei.com>, Zijun Hu
 <quic_zijuhu@quicinc.com>, Hannes Reinecke <hare@suse.de>,
 Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250327110707.20025-2-phasta@kernel.org>
 <20250327110707.20025-3-phasta@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250327110707.20025-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/25 5:07 AM, Philipp Stanner wrote:
> pcim_iounmap_regions() is deprecated. Moreover, it is not necessary to
> call it in the driver's remove() function or if probe() fails, since it
> does cleanup automatically on driver detach.
> 
> Remove all calls to pcim_iounmap_regions().

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


