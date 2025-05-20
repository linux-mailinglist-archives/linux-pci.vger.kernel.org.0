Return-Path: <linux-pci+bounces-28127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20C1ABE10C
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 18:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0124C5574
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE1C6BB5B;
	Tue, 20 May 2025 16:47:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D92211497;
	Tue, 20 May 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759639; cv=none; b=dobYqFVdIMBJIkmo311hXbOLqqxox3+GhYEZ0LmsB55jQ0yIqDzgWkzQ20JrI2Jkb6wEYTtl4iEkLziVyjA0Y/8sCz4l1RRK4HyMOIuQ/RKTfvHFAPvn57K3xzbgzvMkcTpsCofD+gL4DIPRXLbbrsIZKoZoQbowk5S2j36KypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759639; c=relaxed/simple;
	bh=2NGTDWs3Hq6NMR5n/ts2uMt2qyRP4UKlR/SwMOFxg3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcNvSa7nal1AQ9fgWcSVzXDb8k9NfPzGgO5ZqoxdbUR2aZz7XG8zlRZEIPTNNgeLfAh015f17jDYhi+12UwFK99ovHnZI24OPHMvQpg+L/DeC6LoP/6Osoav7TEJJYr5PIYMcoGB4L0FJlrlPn5UvOiJvTzf2O9qBGD8sg56ZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231e21d3b63so54463015ad.3;
        Tue, 20 May 2025 09:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759637; x=1748364437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7UE7WXC8qw9v7aifxKYFbDyIfGVZWMNuD82B1Mnd4g=;
        b=PfMUJf/WAEKki+jNXZGLDiq/vEr/PqhwZFJj7MrHrFnfDdK0IUl8hwT04MZuT9GjJW
         u7vSmSPMEQYYZidPJoLJzX6sd6MmsgloP9ImxKxPdVk0p0F3k8Lgj8i/WxGKR0PIcxrZ
         QBxLS+4AtWRXxf+IXFQPHK43ieG6COK5mmV/SzVeNR1N1zptj1aLILod866r/mwrz/84
         4H40nG6SzvLaeG5wuJ+yS8v8j1rlJQHS4MX8TpK8QQX5bQDOLwuDo3o1arGM8DKiR6iK
         yz7Fw+xeb9niwihhoXgEz8ggU0Q6Nw2hU88au5ibP5lMD7nEEugecBJIt4rJypx8J/y5
         1EaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKL7DZndfA591sKUgJsUl/7iNBjaAHfAyv5i196C/vjZEtBkW5WxPBWb3PTMZIjKbno3jbAN3lZYsn@vger.kernel.org, AJvYcCX6J0hB83Po+lrk3G75GApFqWJRgh5Ftjh5FYOGQpws0QcLCFLmlCWNt5bwev9kLwwPhDFKTrqdamxxTR/tMPva/O0=@vger.kernel.org, AJvYcCXH/D7YEf3IVtjrOQZokbNculsL8iWzsyXx0lePV/breomNoiAU1zz40oURk6zR2090wR1/pPu+hxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRh9RJjYUemhV9CYp505fg+XxA9nlMG2eOeTvrWep28pSrJpM
	XC9GTBReGEh0/JiIIZI05XN+hZZYF++WRGHixPLzDRuBltw3zYR52/s7
X-Gm-Gg: ASbGncuYAWBsjhbXa8mlBz5oybCQl0WEHowfzGcUGjVsUSDKHKRIt57XYhMUNvgaRHi
	KXLbB6Jvg5wSocHQtmhbU5sj8uc6Y6b6D6cMjw2RMF0AK5l7SPxFU/Pz3P2VTbw5lFRZxHcYKCa
	SnxDVqhXnPktctW0KD2HEgGwcIZ6SZuE/3G5nmjohn5w/2Er91xg1n5E9Cc17NfQHjPB0ToOCKp
	U6LwH5ntKRg4QiMFuXcOcOor5dW7NWzwk9FYaq81NHjv24La6Sp917QfiAWbYHhFgeXfdyJ08br
	92vBlpTalAMvp7gpAHC0xGIavSx/r316S+5EkQkLd8XvMwfXRTPbjM5bK6Q1Q4ibgA8RV6pJPKM
	CI/w2xNp+vOvj7n4amtsC
X-Google-Smtp-Source: AGHT+IHQ3oPrmboPC2ZZK2eQwFDCsPYpNsIBS8VEm7t6ia6CuKf6ymSSTrLyZKRhNmSsDFjRZWOGbQ==
X-Received: by 2002:a17:903:46d0:b0:21f:f3d:d533 with SMTP id d9443c01a7336-231de351537mr209933165ad.2.1747759636603;
        Tue, 20 May 2025 09:47:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ebae24sm78905725ad.197.2025.05.20.09.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:47:15 -0700 (PDT)
Date: Wed, 21 May 2025 01:47:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	bhelgaas@google.com, corbet@lwn.net, marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4] PCI: rcar-gen4: Add a document about the firmware
Message-ID: <20250520164713.GA1052522@rocinante>
References: <20250507100947.608875-1-yoshihiro.shimoda.uh@renesas.com>
 <bo2hxi32znmikg3z6j3rreqqksoijfn3ugb5ahyn4qirixc2b6@k7bs2lvipfz2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bo2hxi32znmikg3z6j3rreqqksoijfn3ugb5ahyn4qirixc2b6@k7bs2lvipfz2>

Hello,

> > +Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires specific
> > +firmware downloading. The firmware file "104_PCIe_fw_addr_data_ver1.05.txt"
> > +is available in the datasheet as a text file. But, Renesas is not able to
> > +distribute the firmware freely. So, it is required to convert the text file
> > +to a binary, and the binary should be placed in /lib/firmware before
> > +the driver runs by using the following script:
> 
> nit: the above wording sounds like the script places the firmware under
> /lib/firmware, but it is not.

I took the liberty and refactored the entire document which is being added,
changing the wording and formatting it a little bit.  Have a look at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rcar-gen4&id=2bdf6ffe9f66d74a6baed3012d78f580c66c0583

Let me know if anything needs to be changed.

Thank you!

	Krzysztof

