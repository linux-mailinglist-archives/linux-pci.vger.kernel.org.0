Return-Path: <linux-pci+bounces-9899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC43929A5B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 02:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BF6281158
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 00:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227F36D;
	Mon,  8 Jul 2024 00:37:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFC80B;
	Mon,  8 Jul 2024 00:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720399054; cv=none; b=rSOIqPl1gBqjX70Nbia3jRq9Zp+I0/3wvzBVXm0ABVW27jrxAFkbaGL877uZnVcoIbFZeJefGX+BEt/xRc85cSVpynZcC0qmWaf7Lid48yepG1mQ5oaP+c0OaSoOan6OlKL0gyaZvk9JzOMulGbYkKOZviGs6gRo1agoE+D3krA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720399054; c=relaxed/simple;
	bh=MiMJG63NASlvt7qJxASie1GoZRUC/mr0UtW13M84QPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR8USX5+3Y8KS5LPPLBTsqMZTz35MdDvzTKwk3v8IS5Gl6vS+T70zWtJkF5i3Zx+fkvzmOeDWB3/z+rWRU9Sy4MF6Z2qngGGjqB16Z+DhyUx0iZpCLoOdAZ0J2eBx2//T44YhSFE1ikwz0DUYA0o/3+NtdSMmnlhlFTaKtU7BXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb3cf78fbdso14952295ad.1;
        Sun, 07 Jul 2024 17:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720399052; x=1721003852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTvNLM66nwd68RQoTUd8FCCFjj11nByhXLQEJt7gNuk=;
        b=cq8nrhdE9Phd0E1DzxAqpMq4pIREszRYpFhCjInDiZkYHJA+eli/r3lI7XzeZJNJKL
         9JKOHXh9DbLofdamNb0axonAfTHa9vz7k3oVCA5LDENViKvQezkOlC5z9gVQfW4sm+C+
         9q0wiErDKaCMugM8qFc7/bbyOq5vt7r4/Q9w2n+KkfXQMH1jZpIbk47pi/TAEKtsLvdM
         3EmmIJZM3InuXufnq6ZgT5nwDtCrLggHt3YMtTwHAFNfVoKxp1cqf9PIt5DOJ51BvF4I
         ClxhBQFvg+/C9/zwLFX2j2Yo5P6IU4JX+CTMSa/FtmE44L+Pvuza7A2OTqgj9CQLi9R9
         tC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQtOvSOhf3jsAnvBJwzNXzAn1M4sPwwS13tEwCy0ra3Z63nL6FT5G4tWNxujbxzzOQDoeqEZ1uJGjsZCCp++VDiier8oepXWU4yfUdBr9jNjHc0JrbdNufVsstzpwlP333V/83lBc+
X-Gm-Message-State: AOJu0YxIw8MMZBRQFsOyOiJZpM+a+MM3yoeQf9aXiZG5aFyz5yNon3bA
	vYcgidPYnIJxQIFEZcvRCaORHaxSeyqpAAfqz+CEdkyIcVRYoWrT
X-Google-Smtp-Source: AGHT+IEQ0YSIsZQiYlWjdmirmhz8CjJ0C3r8wFYZao/qN8Azt4ufSCus+IcSGA8zg3S0laH5vg5sqA==
X-Received: by 2002:a17:902:e995:b0:1fb:183e:7be8 with SMTP id d9443c01a7336-1fb33f35ab5mr47156325ad.68.1720399052280;
        Sun, 07 Jul 2024 17:37:32 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1e4f12b1sm81396135ad.146.2024.07.07.17.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 17:37:31 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:37:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
Message-ID: <20240708003730.GA586698@rocinante>
References: <20240707183829.41519-1-spasswolf@web.de>
 <Zoriz1XDMiGX_Gr5@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoriz1XDMiGX_Gr5@wunner.de>

Hello,

> > If of_platform_populate() is called when CONFIG_OF is not defined this
> > leads to spurious error messages of the following type:
> >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> > 
> > Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> > 
> > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> 
> Reported-by: Praveenkumar Patil <PraveenKumar.Patil@amd.com>
> Closes: https://lore.kernel.org/all/20240702173255.39932-1-superm1@kernel.org/
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Cc: Mario Limonciello <mario.limonciello@amd.com>

If there aren't any objections, I will take this via the PCI tree, and add
the missing tags.  So, no need to send a new version of this patch.

Thank you for the work here!  Appreciated.

	Krzysztof

