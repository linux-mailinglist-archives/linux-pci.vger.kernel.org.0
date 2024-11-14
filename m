Return-Path: <linux-pci+bounces-16795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE949C90E1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9A91F23BD3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6EF18BB9F;
	Thu, 14 Nov 2024 17:36:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0B17557C;
	Thu, 14 Nov 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605781; cv=none; b=HIOjHLwjN15Y9L9cyNK8BGuaVqaYMkv63DwS/b7Xemdr305nsC9XXX8oOT8UWgM4zY0378IvnJFFWsyd/uKYSI2Ry8VRiM6DOEVIl7JWTMpD+KIxW311vI5wAYqs37r7U1MRlNvQN8Jfgmj/mhluNdazQJI/4GB4elQSFOwLZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605781; c=relaxed/simple;
	bh=lmsX52l/1IXL6pVGf4OXq5b7cQpR1LL56F3YaTmwRUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX2oqUQn3O/TZcRzSxCieA9h8lrUnZTPYdrKAFpfUCav8Ttq337gOLI65fmnhjASDIsm2VFOJubpC0kZOjtwzaA1gXECBrC5TmByetyPCQKkcFB5WoddyUkfRxEOYhTilGuAWaPCyuUNMEPCirJP5WvrWgDSMayjrNpvY1zpcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c9978a221so10667245ad.1;
        Thu, 14 Nov 2024 09:36:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731605779; x=1732210579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kROUsWvWvV36Fo4a1GNoVZXpL3CbrLmIcvXu4sqcNw=;
        b=f6Iy0GbWUcZsSv8uxxU/Iov/VYAbSulK5eRvEMme4bj4pI+BBLnM/TXr2sM4FL+dqT
         ky9Ow7YVSpaDMMNa40qqXmeRmPooMGB9upCBfQxFXx6tsb+Z49xWe3NMs3xbu2N9cuxG
         yAB7uwujmGwnXfFsQkafpM9imohJRPgi0ZXXypisW08ozErfDqHoCWg0vbQk7ALx6lBh
         pncHQ32J7ZUUeJRezUT7gtc2SFz0BU/Q9YAjBbiQyE6sYpsqZrjbjOCya77FF9BPcy/G
         nnAr94V8ZFte+1WuDqJxhiozuik90NHRLdghRpSFsn92ghvHfs+27+ie5rxY/oaO46PP
         z6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjQL/QmekrwMb9oS2VQPHsaItsw5H97xIODd54AII60IgXWSwXSJ1ECNPsk8T2bU4lGX8CXxebzfg=@vger.kernel.org, AJvYcCXZ0uAVZ4LJwVKl2VOImsIH3d6OjgB8f5iP+0zyoj93/d8/UVh1RRQmXViQKEvuhrrn3OfMDyDyW5p5@vger.kernel.org, AJvYcCXoT69FnSQ9hSeDTqGW2XGCCt8d8k7vqSly6ifQiGjOcDgurWw9ccSgAsI8oaNcClpgxm4iHqivlrqT3wI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiw5qVfKRgo4YtLPyCcFyGpoZ6MBNswuwXQHBJQDh3ETrQrtBi
	nnS7n8XJGQI/Ro2Hwfq6c6LPEkQODpUIr/9brSs0cLDzNcpLClTW
X-Google-Smtp-Source: AGHT+IGjSKX8cn5jJR3CqDGzczAzuH5z+anCuroYAbhOAQpGkEuGTNFls7mnC61Ygcn+ZFL/FmnIvw==
X-Received: by 2002:a17:902:f541:b0:20c:d072:c899 with SMTP id d9443c01a7336-21183cea4b2mr341784765ad.24.1731605779115;
        Thu, 14 Nov 2024 09:36:19 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d1ac30sm13218615ad.213.2024.11.14.09.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:36:18 -0800 (PST)
Date: Fri, 15 Nov 2024 02:36:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lukas Wunner <lukas@wunner.de>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v9 0/9] PCI: Add PCIe bandwidth controller
Message-ID: <20241114173617.GC1489806@rocinante>
References: <20241023221904.GA941054@bhelgaas>
 <20241113214850.GA1912974@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113214850.GA1912974@bhelgaas>

Hello,

[...]
> How attached are we to "bwctrl" and "pwrctl" as the names?
> 
> I just noticed that we have "ctrl" for bandwidth control but "ctl" for
> power control, which is slightly annoying to keep straight.
> 
> "ctrl" is more common in the tree:
> 
>   $ find -name \*ctrl\*[ch] | wc -l
>   691
>   $ find -name \*ctl\*[ch] | wc -l
>   291
> 
> so I would prefer that, although "pwrctl" is already in the tree (as
> of v6.11), so it would be more disruptive to change it than to rename
> "bwctrl".

If I may, I would also lean towards the "pwrctrl" name.  The "ctl" suffix
makes me think of a command-line utility, a CLI, so to speak, where such
suffix is commonly used e.g., sysctl, etcdctl, kubectl; also, all the
systemd binaries, etc.

	Krzysztof

