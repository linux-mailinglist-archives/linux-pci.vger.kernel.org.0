Return-Path: <linux-pci+bounces-15426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D801C9B2034
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 21:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835571F21445
	for <lists+linux-pci@lfdr.de>; Sun, 27 Oct 2024 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC12D44384;
	Sun, 27 Oct 2024 20:07:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B93339AC
	for <linux-pci@vger.kernel.org>; Sun, 27 Oct 2024 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059650; cv=none; b=j0Wcr7uCLyQnO7Q/od4YCcQ6QXyNUzdgRXwleLDfiypCucpWEHW/7TcY5axM44M2IjmnAG+mCfjENWkSMm1FwDEnSCit5dHqCi2XL/yZkItqQHcKVa2LML7jK+vVFswfrrHl6Kfq1vqMcL/o5OUu+lbG+Xthu5pTnEJzwTmOpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059650; c=relaxed/simple;
	bh=l+fIaVDDwm2C/sZOC6yKW+a4CeoO81zifNhzPvea+N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+NRdsN/yM+xCa+Vs0QyOET1HDG8VdycV+lhEI8GfjDCWpT8Y8yKDxQO4WGLwcfOHI7IT3R9m0c+1w5IcTExPvZpYYqOg2s7/lPIz3kDdWeZy/ei+TGiJkH7bk43psH6jv8727+9lPZ/nDXs3OjaI7LvUalahGC5W8OEJdKcbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e5a62031aso2593155b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Oct 2024 13:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059646; x=1730664446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnX4vH8zOjpuy3PvX7cLlQgTpeQMIWmh6/bvq48turc=;
        b=UR9wUydocng5RHOsSi0vX70xG/Go4cZJ8P0CZNSZua8EMbNrCKo81BzBlcPf307874
         8egJVGJnbqMAYYXUMu85nYNm5RPlx2wo9vHhlT44V22Azko3QBrZ59fcKFt0+QCWtFFT
         2OVv/UWqbPrHerX6ytoR7BmFZQZCdX7J2JMnhaNkymhyhgXk28k+8nwCXcGfv1xV7meX
         B/w3FTd3O0ULMJUi8PxZ0qSyawucL8OGyyvswjqaa2nPWq7BH0NUZnLTqDLi2vkEIhsn
         xCUDdlBD/wUE228T4zWvBQnV2D84wYVF/WnYUE2oncGha2LxD5O4N2HnuDvJOdOFQPLH
         yZAg==
X-Forwarded-Encrypted: i=1; AJvYcCWjcodW/QLXd9KW5RrBm1yXRwjmUp9QdyjHqbUcHVj0MlzNctobEDOyfz2uleb3KB1TmY6vEbqQXiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhtZiGZ3Mr+s9Kou2oDMjTwK5y7iRr9ru57Epq2FFoHwKBX8zZ
	/Ezu2ZMLAbJqbsO3Vp39SeXnMozm/UyYfuxo6Z0iRSXqRWknFJv2
X-Google-Smtp-Source: AGHT+IH/EVnNCaiXh9VeE4gvgxt8yEK8wmgDym3iJIbP4V4WUURDYPsOOyMmFbAfr1hm7XUGlKvHzQ==
X-Received: by 2002:a05:6a00:22d4:b0:71e:3b51:e850 with SMTP id d2e1a72fcca58-72062f4bd77mr8622957b3a.2.1730059645908;
        Sun, 27 Oct 2024 13:07:25 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b649sm4393459b3a.138.2024.10.27.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:07:24 -0700 (PDT)
Date: Mon, 28 Oct 2024 05:07:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH] PCI: dwc: endpoint: Clear outbound address on unmap
Message-ID: <20241027200723.GA706056@rocinante>
References: <20241004141000.5080-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004141000.5080-1-dlemoal@kernel.org>

Hello,

> In addition to clearing the atu index bit in ob_window_map, also clear
> the address mapped (outbound_addr array) in dw_pcie_ep_unmap_addr(), to
> make sure that dw_pcie_find_index() does not endup matching again an ATU
> index that was already unmapped.

Applied to controller/dwc, thank you!

[1/1] PCI: dwc: endpoint: Clear outbound address on unmap
      https://git.kernel.org/pci/pci/c/12dd12821f1e

	Krzysztof

