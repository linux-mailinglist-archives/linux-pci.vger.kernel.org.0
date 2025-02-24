Return-Path: <linux-pci+bounces-22211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29AA422FC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82553B8A81
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D21664C6;
	Mon, 24 Feb 2025 14:19:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589A13A244
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406742; cv=none; b=odmTJa9LoVDTn3wa7o7TIdDW0DuVN2BBWUraCuuWX4Xn+V5oXCsJJf27L1mgzKGtoPG6FoQPncxjdj6iD82pg0Qv/L4TuYc0IojlW6jEH8k/pqnIdR2pJfMhLBh7jhFGka4XrAnXx8UxwRa73NuQe4TVC7FCST+xw1JW4z41aGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406742; c=relaxed/simple;
	bh=c4nVqMhhVoz1igDNdFeQ4SYsLRXrG1UYgzQn+YCP5iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgVln7HQPlkbPgb/D0+1soLjPyopdl7pNmWlzvKl2cOI9X4xP+4Us2lYZGJldrlkVOU9qd+5p3id6H+Mm0z1hMZMwHw3uAVpDW4WetiEZF2MKe1kl2tJEh5N8qqHYsbh8aNQUvCb0JYuuJZ+r1wjD+VY1ewwvTuA0aN9EqXdsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-222e8d07dc6so16620655ad.1
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 06:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740406740; x=1741011540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQq55i9sPiHAagM17ICTCVjXUcSmU6FsFp44CyEwhoY=;
        b=UxPxM4DPQv4ckw0nWgXaYJgoVNFfug26735PRrtMz8fXMJenWfNRzqsO/xeszhuDR3
         /lXW58X4YtA4Hg/GiKJkr9subd15wTnkAEaGwEdyBtsBdDhoiEUZ83JZUCj8rZb866iM
         ZYv52PC1+Hh2eL/gyTNRCcsOsIbG1cDrspnKSD1hL4XqbPEamhQ36hOBXkE9FA2mAv4B
         D+ORMz3y3J2bWcrmMxd7A7/PDZCK9VItakgUzko45pBcGGnICYvluM6B6mImMYq6j7GS
         BdKb8/ROA95j3271vAzRD1goCelNqifhB8urBH9+MZ3EDAdbsmaihzu5mNZ4X9NcoIXY
         8Ulw==
X-Forwarded-Encrypted: i=1; AJvYcCWH7SeklW+gqzk49A+gV4g53TBCisHJVp8s2vEPuZDGfRA1YRkMcr+8CUG/rEdkDNL2Ay9BFXx7VGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuok6Q4wIV7f9CwlF5rLadJZsKJ/GJPniw4XjC36gqF2coEtiD
	b4QG6UytIy+IB9X0YD2tDKw8Q9OnttJ4Q/YCCHJPBafvnGgQJyhfrORjtvtXd+0=
X-Gm-Gg: ASbGnctWi78qp7K40W6jcU9S34AIsDgUc3K8LW/sz4yw2wd7FDdX6zC6wF1YfiVer4W
	4yAc+kAwIE5HPAFcS38WXkcNq92dGe51MGWFjRjq5dU5tgxr8/GBBMBD/5juDYRr5FsYwEDUfsl
	hC4O88c5++qU89UMI+UTeguulHyf7u/7ka2no2ibedlB9oR4aLXKO49hGNNPQ8eXxdzqlDCdOWG
	t2itusg+eFSN8BXLD0fiJVqWupoSWA13bF67ZzTPVFgkau6cM2PTa9vnZFZrfkD12Q+YaFnbg02
	sxEgwehQXlYE7/M8MHRkUWEmUsAhP1Hb17p2aU3Z2wYTLBA6KQ/6Nxfarq+F
X-Google-Smtp-Source: AGHT+IEArhAzVGpSC5/pwMA8672aG8JuHulEEM/yIdtoSC6FajaFQZpNsOz5Nyb51qV69zSmstlAhA==
X-Received: by 2002:a17:902:d4cf:b0:21f:6546:9adc with SMTP id d9443c01a7336-2218c3f4333mr288752845ad.13.1740406740281;
        Mon, 24 Feb 2025 06:19:00 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5586075sm178543045ad.228.2025.02.24.06.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:18:59 -0800 (PST)
Date: Mon, 24 Feb 2025 23:18:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Wenrui Li <wenrui.li@rock-chips.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: dw-rockchip: hide broken ATS capability
Message-ID: <20250224141858.GB76745@rocinante>
References: <20250221202646.395252-4-cassel@kernel.org>
 <20250222000029.GA373377@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222000029.GA373377@bhelgaas>

Hello,

[...]
> Can you include something here about what the issue is?  Based on the
> subject line and the patch, I assume something is wrong with the ATS
> Capability?  I guess this is some kind of rk3588 defect, right?
> 
> > Usually, to handle these issues, we add a quirk for the PCI vendor and
> > device ID in drivers/pci/quirks.c with quirk_no_ats(). That is because
> > we cannot usually modify the capabilities on the EP side.
> > 
> > In this case, we can modify the capabilties on the EP side. Thus, hide the
> > broken ATS capability on rk3588 when running in EP mode. That way,
> > we don't need any quirk on the host side, and we see no errors on the host
> > side, and we can run pci_endpoint_test successfully, with the IOMMU
> > enabled on the host side.

Rockchip folks, anything to add about this issue?  Perhaps there is an
erratum about this?  Any code reviews?  Anything?

Western Digital folks are doing you a lot of favour with all the upstream
work they do maintaining drivers for your platforms.  But it would be nice
if Rockchip took some ownership.  I have seen none recently.  No reviews,
not even an Acked-by, nothing.  A bit of a letdown, if you ask me.

Thank you!

	Krzysztof

