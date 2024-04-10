Return-Path: <linux-pci+bounces-6000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A0289EBDC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3430282312
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 07:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4775913CAB4;
	Wed, 10 Apr 2024 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pFOFv+Yl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDC54BE0
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734008; cv=none; b=Z31iNSpygZB8WEK7MrdJmWENgT/6EDRWptcTU1YEwi9z/HW7ZjML87gL2VMJX2d3hqymhnSfx3o59xPThbrjuTI8GQgObH9Q4y4zqXSi/KeGs+eU+JRrVaQ/4nbaLZGAAYmDd2oYHDSY5QUwgF/TSpHW7xEj6I6DCPEFYToQQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734008; c=relaxed/simple;
	bh=e+AG6V8H2fl37BdYmx2ZT0nlt0YzNk8468xEWI+ainw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR6vXyjSEVhVJgPTKTbYoekpKlkyvP8hozQpYHEIFmOeWYzlq8gwSWLb5wQdO5V1Wc5cOvJAmWCjkHnw3IfL+Hqlomv3lg6RQdjDirLUAZXEmbbbx8wKK7dO3hy+RjU6KtJIR0LmBgkSFCsGDfNSPp6Y46Anzm2s5Ebr3O3xjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pFOFv+Yl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a450bedffdfso895152866b.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712734004; x=1713338804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdIZZrzqz4wA4YPQi7Rwfe/E1DAX6qVZQwZpQlcq71k=;
        b=pFOFv+Yl7UbrOKHeYeziR/g0T1IMG4f8HfFDZMVh+bchvwpTAREVqHiI2XzdxLu5XE
         bVTmfxSxvhQT8+cVh4GGUAtkvpd6xXVFA9l0FGOXl+PIG90lfASODAlJfkwOStvL67I1
         QGYVOwX5+0V+E9k7+pCuqZOKyAlycLByQS2tbv7va3MNI3NWGkNI4KKpsG6rrjEaZeTV
         vJLN94JJe8yOFcIgNA071LXbPNJb/1mQMP9xDdFh3z7JaLNi2hjA4TGJQ6LUlOeIZnM+
         DZ0yf9rMc+x4bc/GcvcKouqXdqcG3vTsb3DgRXKd179XUEa0/qn2jOIbHN1sTy+ytpSW
         Badg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712734004; x=1713338804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdIZZrzqz4wA4YPQi7Rwfe/E1DAX6qVZQwZpQlcq71k=;
        b=KuTNIsFBNZK+K6kScmoVT4AiGw1BU8iRrXUr4vI8lu9F6HjPbSxlEqj1a102SX3w8D
         GjOxXUP/JfZSnqLZMeLNpMsd2BTatzFncp7B7UVfv4z6TM5he3GyUEGUrtbn+eObbDaY
         CjrEaV5Xid3uiW4zKs85JZB/s+HDjj4hKiKM9kQm/alHOkwRJ5n3mCLofevrEwAeVIc3
         OT2IoGqdcUz0eUKL2itt2lbAv9/elzmBQs1AklGggPyjZ/0tLfZfTluU+FdA4q2THDAy
         vREkYXU4cdEibBCR7Kxz1d+URqBp1F+No3GDDrddpmdQuzfnVpE65kL95FjcZk1C+uDd
         jKbg==
X-Forwarded-Encrypted: i=1; AJvYcCUKuMfy0C210aUU1328RbN0vvWN6qxt+fupqIecKzOZOtMtWiwZVvAPEaDhAo54RzbtPZNMpN7007GNlJLTJB5RA9FyY5NEXlN9
X-Gm-Message-State: AOJu0YxxCz/d931SmcnBrkTF/IaM2HStDL8HeSTdNJ+bNggXYX1HMesO
	urHgxSCRYQUR9i8B8HMCpZKoQUE4oqKc4cRL8MdonhZx5k5atje1fPcF0JAbTYQ=
X-Google-Smtp-Source: AGHT+IH+W/F1+BSpIHz7mLcAWnXTu1H33OQo8F2Q1DXesJ7VREDNOAHOswXumxvf0957EQQLCH3DJw==
X-Received: by 2002:a17:906:b2d8:b0:a4e:a7a:84e0 with SMTP id cf24-20020a170906b2d800b00a4e0a7a84e0mr995649ejb.34.1712734003817;
        Wed, 10 Apr 2024 00:26:43 -0700 (PDT)
Received: from localhost (78-80-106-99.customers.tmcz.cz. [78.80.106.99])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906b01100b00a46aba003eesm6633313ejy.215.2024.04.10.00.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:26:43 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:26:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhY_MVfBMMlGAuK5@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <6615adbde1430_249cf52944@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6615adbde1430_249cf52944@willemb.c.googlers.com.notmuch>

Tue, Apr 09, 2024 at 11:06:05PM CEST, willemdebruijn.kernel@gmail.com wrote:
>Jakub Kicinski wrote:
>> On Wed, 03 Apr 2024 13:08:24 -0700 Alexander Duyck wrote:

[...]

>
>2. whether new device features can be supported without at least
>   two available devices supporting it.
>

[...]

>
>2 is out of scope for this series. But I would always want to hear
>about potential new features that an organization finds valuable
>enough to implement. Rather than a blanket rule against them.

This appears out of the nowhere. In the past, I would say wast majority
of the features was merged with single device implementation. Often, it
is the only device out there at a time that supports the feature.
This limitation would put break for feature additions. I can put a long
list of features that would not be here ever (like 50% of mlxsw driver).

>
>

