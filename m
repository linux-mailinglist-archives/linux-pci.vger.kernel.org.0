Return-Path: <linux-pci+bounces-21425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A631FA357B1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 08:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6928C16CADF
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 07:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48743185B48;
	Fri, 14 Feb 2025 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbMGqLFw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B5513A3EC
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517361; cv=none; b=ofbVhQJTdVvaDEmvUjEyjhBX/gomnFys0TKdzQyY/GB7MztWkxFaGUmH97LVzAP3MzsfRfnFJqodHGvHEdilnbJnh9frvH0xzwMJU4xeoiH1Is03DLIL+02jdLJkcYvKYHHb3tmgzB2eGlIlHdO39pLzrEknf5LABtDjDJMsl9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517361; c=relaxed/simple;
	bh=d85vQEKXzobX9r5qZo9mtj6Cou/uCva0qLJ6RmcWFcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/NyEw+QSUW25pxYbEGH59NCNWv9Nb3K/p5ELbLGGMd4h3tZjn+zaMblfdxh+6g0fUQv0cFDDDgSUsN3X6mppUqn6lmLHoXOBAQUUCmjAYHK+cvDESpfW1XRZfH0oR3294dG5q8+FuoG+8gZkVMB7J4Uh39HXXyHuD6InC9MDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KbMGqLFw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so2786705a91.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 23:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739517359; x=1740122159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i8tciIHtrTxfE7xK87cnn1lbhRKqUoH9Dla36dWV9Zg=;
        b=KbMGqLFwdzi+gTP8GCXcwJ6iRoCGa8o+QnzSVAwcJq9Fh5Gxi70F+GulDOtcGWrToD
         mj0ughrGzB6kKwh+5kC9OSQgmCkWfoR+JRHsOCuw6xmktpl0ZsSNJjMG0RrfKJNwDVO2
         Gikz1zGjnPbKXqT+MRYluqz/8VwLbmb+H/zPyK2drEjMCtYyrzB+xASktSHTLV2ANhJ3
         wrpx1icPS++HRzASlxJri7BzQQrM/YZy+8lBBIq/mhPDabCafdhs57UlHo0WS5vvPuV3
         wZuIWUEAd5DGuu+k1ixM9aGUMTGtq1oMoog1NZ5Uq9vtd+iKyiP1z9e7NRXOxnJnOgMN
         IeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517359; x=1740122159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8tciIHtrTxfE7xK87cnn1lbhRKqUoH9Dla36dWV9Zg=;
        b=bPhi0YAGMuqJ6nF73B1nsJ3HX/UCcdWz54RWGEekjtnyHxyp4HCNODdBdMi4lIHWcY
         iHfl4EEt9U2E48JoZNjW9+rqMhqf/jpBcX7ZZgWe2oReYYUv5GqhPW45rl4r6QgU+Vvb
         zV9nJj+bzJiUG21/yYQBQb0X9udz6nIlGb9UqNMX2f13zgPa1epVYwTmVLZuZgf/5RCR
         9EQfvsg3MHgQZfjUhjfmyMjrRtLDkqJP7nxPzW9ZY3Y6KzLQOodVLD4YQ/HVCsaiGjoc
         SsZmHbYzbAHxE5MQisBonj1LJSCCfoYJHIQuzLwNn98gW9kSplo1srmygcvtlwGJd97g
         WrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3zCmrkBZK1ZTwaz8UF9lIDfXkkImhZ4ScORohJo0zaxSDA4NC3xiMyHakgaeHXNlhyP0Ssn01df4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHFDMVeLtQqhubsGXwgXlwEd8dhFhkdmwYVNUzFcKO1ZvcK12
	YB6PjxmnAjezyn/pM/WPXr63O04AdqqleQIJXoLl8Gv0J2fuLJJ1KzU+bn2a9Q==
X-Gm-Gg: ASbGncsTSaHOm+wwn3x0qzcN+3O+zDp63uQbmbbbELTw3VroYLLVzE6mZtyO9UW4nwO
	GSPAFYrPU888Yx0USZe+AS11ddSPq1nnPJk3DHUm+6hwUgbkFdCA5l/kFvCeryCwwXbl4qpiOot
	GUmdLIs7BRPefNeXNm60rMMIEhl4spr2kl4E1wl86B+YOwiowv7hRub6gDxkFW5RC7zH/UQR/Dn
	tNiT146Lsw6YVW7q33RmVA1KIbr2v8IH8JgXp0mvAQLkBz7Dz/r+fyRhQBxyZuBCPAXtp/Xnb0/
	P+JwEC7lZv3Z8JgDsQOZ0wbm30hXO4A=
X-Google-Smtp-Source: AGHT+IFWwENUebCr4voLH+7s7sJwk7o6ApVHXiQcusFpsycULm7vbHAgg//4YnMm7TLwfmgr806IKQ==
X-Received: by 2002:a17:90b:180a:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2fc0dfc7a5emr8983543a91.5.1739517358814;
        Thu, 13 Feb 2025 23:15:58 -0800 (PST)
Received: from thinkpad ([2409:40f4:304f:ad8a:8cb7:72db:3a5e:1287])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53643ddsm23043555ad.70.2025.02.13.23.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 23:15:58 -0800 (PST)
Date: Fri, 14 Feb 2025 12:45:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Tsai Sung-Fu <danielsftsai@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	Andrew Chant <achant@google.com>, Sajid Dalvi <sdalvi@google.com>
Subject: Re: [PATCH] PCI: dwc: Separate MSI out to different controller
Message-ID: <20250214071552.l4fufap6q5latcit@thinkpad>
References: <20250115083215.2781310-1-danielsftsai@google.com>
 <20250127100740.fqvg2bflu4fpqbr5@thinkpad>
 <CAK7fddC6eivmD0-CbK5bbwCUGUKv2m9a75=iL3db=CRZy+A5sg@mail.gmail.com>
 <20250211075654.zxjownqe5guwzdlf@thinkpad>
 <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7fddDkQX1aj5ZyTjh1_Pk+XME3AY=m5ouEFRgmLuJjBJytbA@mail.gmail.com>

On Tue, Feb 11, 2025 at 04:23:53PM +0800, Tsai Sung-Fu wrote:
> >Because you cannot set affinity for chained MSIs as these MSIs are muxed to
> >another parent interrupt. Since the IRQ affinity is all about changing which CPU
> >gets the IRQ, affinity setting is only possible for the MSI parent.
> 
> So if we can find the MSI parent by making use of chained
> relationships (32 MSI vectors muxed to 1 parent),
> is it possible that we can add that implementation back ?
> We have another patch that would like to add the
> dw_pci_msi_set_affinity feature.
> Would it be a possible try from your perspective ?
> 

This question was brought up plenty of times and the concern from the irqchip
maintainer Marc was that if you change the affinity of the parent when the child
MSI affinity changes, it tends to break the userspace ABI of the parent.

See below links:

https://lore.kernel.org/all/87mtg0i8m8.wl-maz@kernel.org/
https://lore.kernel.org/all/874k0bf7f7.wl-maz@kernel.org/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

