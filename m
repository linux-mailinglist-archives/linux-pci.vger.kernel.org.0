Return-Path: <linux-pci+bounces-10039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8892C984
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 06:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8792A1C22E5A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 04:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0161123776;
	Wed, 10 Jul 2024 04:08:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7B15D1;
	Wed, 10 Jul 2024 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720584533; cv=none; b=n7EsAxbYSUwU3LB9ErdAZE/sUPuZ9249/2DPRr8O8mtfHv935Am2esf4ANyp2vd7q+QbGCBrGw5ps4kwzijYRNJUtyMhTjfWwf62k+4OYdBE/WTEv3Y3i75Yi+gz5bEah1uWGL/IUpx4ng6EG7buNdBaTl/l9oBJZX1W9PY0G0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720584533; c=relaxed/simple;
	bh=lW0v2nhKcMGt/jrtsJNLRJop6ETqi7Sa/oaFtGZQlFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnwhVAbsvEaqhUleuFG2Puon/S4Cf8hNT3n371/OMpML9USs8OhqmH216MSdaL2xjr5xT4pyWOPTMDBkZPlaG08VUKc5nZNoeoAKXRP8dOldCMZwrQYrLsN0ESUxNr8IanB5CBgQkK1m8h4mQEPRIE6fhsMjuSD8Qzzug7PV5Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b5117ae06so370393b3a.2;
        Tue, 09 Jul 2024 21:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720584532; x=1721189332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTrvYsLDk9v5IzbDuWsLNN1KAHqZ8dYz0D0OzWAGnT0=;
        b=aSWvnO3BQS247ISDAtrvKjFbLjhzABg9xLSYvN8ZzSetZtDtYu0w5sTlrE+bJ8kOjD
         3kO3+Cbf5uSI9brmLOy6q7RLX3Km9ULVR7auMeHAD5AkOAiVNVTIH9rs9ffyMVBjvOtz
         932GG62nk8Vxw8JCuMU8L7gVcC72fzFcTXio9EEqf10pS7NxPBBGE4IpTmYmfBo/vhbf
         zo15bVEAYQu6xC5ArC3yAQGVWsapg5GEO3XaP0qLDejwtW3a9++TKVafwA8C2BoV9S6m
         zIrZegSTtFyNAwfU2SiB+odC1ir4CgyS8v1cngol7lU9SJP0/fZAiImbmzzvcUTPs4Gb
         s1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcHXP6mrdtpvgmSC0s7HkvBkjNiY6CPXPKRN5pCM+z5CJWzT3dRzoYn+OgWNm+LU/yTALYKeWg2lRWnEg47vxriUqpFrb0Et602tf5oqO9rBcRTbrCOaOUn9p9j+RHAZk5WdxO6DEp
X-Gm-Message-State: AOJu0YwXjuwamnOaObnQazGVP53xa254z9ey2crwvI8qZFH7+AFPOK+d
	pSn+uxgnKPQVRse1VCMkIgFT62LFo7PhrWTMrB4EtWEFVJaV6X2v
X-Google-Smtp-Source: AGHT+IEIALYwl8BZTk+7LRVdCMC7liY8odUXaxzuBtNBTCvGDH+Iy0eQzYzSZAU88Vt8TRGuYJF7ow==
X-Received: by 2002:a05:6a00:1748:b0:705:b81b:6ee2 with SMTP id d2e1a72fcca58-70b4356a698mr5917442b3a.19.1720584531799;
        Tue, 09 Jul 2024 21:08:51 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397ed2esm2741866b3a.149.2024.07.09.21.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 21:08:51 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:08:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Philipp Stanner <pstanner@redhat.com>, airlied@gmail.com,
	bhelgaas@google.com, dakr@redhat.com, daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org, hdegoede@redhat.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	sam@ravnborg.org, tzimmermann@suse.de, thomas.lendacky@amd.com,
	mario.limonciello@amd.com
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
Message-ID: <20240710040849.GA3748595@rocinante>
References: <20240613115032.29098-11-pstanner@redhat.com>
 <20240708214656.4721-1-Ashish.Kalra@amd.com>
 <426645d40776198e0fcc942f4a6cac4433c7a9aa.camel@redhat.com>
 <8c4634e9-4f02-4c54-9c89-d75e2f4bf026@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4634e9-4f02-4c54-9c89-d75e2f4bf026@amd.com>

Hello Ashish and Philipp,

> I have reviewed and tested this patch, looks to be working fine and fixes the issue.

Great news!

Ashish, thank you for taking the time to report the problem and then also
testing the fix.  Much appreciated.

Philipp, I will take this patch and squash into the series you have sent
earlier, since the changes are not yet part of the mainline.

	Krzysztof

