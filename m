Return-Path: <linux-pci+bounces-31113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A75AEE988
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 23:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D33176385
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDF223BD02;
	Mon, 30 Jun 2025 21:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnEIE3Bo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787C8C0B;
	Mon, 30 Jun 2025 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751319792; cv=none; b=lpqnREjv+5cSD1WT+YEqAtkVDE1M3e5eCNWGNW9NTlJF6AmqUQ9Nh6EM1t56kI+d8vHcPsRoHarGoRcKkIMFm+3Tg1SibDhYb4ztjwWgmAjEEGYk8Jte/k6zBE2BVfolAXe7e6y7fEN7wYVvBgDL2w/YyOr1LNtZxG/Wp2Ih8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751319792; c=relaxed/simple;
	bh=VO2ZcU2HLvz9dvPE95F4wfp1ew+6bx6yzwi2MOIs4dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6TQ0Ebt3CFaUEfPnmtDNGnrjbPsniPVY81EAopm1dtjtXdgGFUsXnqrkQxDxVynxz5kUyCJKFylbJMGbEO/ColeuqK+8bJfSGnC56owI8c4hXWAZ8LHCL1MAeXZUtLwfN95FXOgV5GHWCa/CINKZUvddLcPo3QzXUvZty1/LhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnEIE3Bo; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a77ffcb795so50150421cf.0;
        Mon, 30 Jun 2025 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751319790; x=1751924590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/n8VfpILnh3xTd/ry0xCdOmAPegbbmqua23xjp6yCbU=;
        b=EnEIE3Bo3wPfmlO9OE2Y6kWWD338zfZ92ZIxdzfvO1xdnGuBE0iizrac5PhVOvo6JW
         AMFv3SVFM/oRazSHIwRUWSjgm+qLY/j2dzjOec1OaHSfUm6058+5Cjs+jdiwSRe5aT57
         HCccBD+cqPpWyFGSlnJjhN9O0+ge2SJH3VN24Q/0Qae5ki4ZD9O9wPLxfarvGy6Wa58d
         DgHe0B7lSqCdiEGrwmRf6KwGbejsC9xw4CVgb5MCBYgbYqsM3UjtBUtuoIPpqKW6GLyl
         4j6tpHGvrrJq3YhYn5JXbVQEFTdrj6e7v0mGaJdASGJS+L8310SoKKqUC6U2yEvL8zn8
         JPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751319790; x=1751924590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/n8VfpILnh3xTd/ry0xCdOmAPegbbmqua23xjp6yCbU=;
        b=bLiGuIplHIYVFldIkzGCDgc0bWvdII4iBBvroJRm/MIrYXanUHfd+Cryg+Pt/B7HuL
         zmFSlIkAaFPc0BvgiVtOF+rEirLEpI21LdTGFNVAzMVTUd/YXHnqXvwDXbqbEdahWQJg
         UMrtlxxlhs8gZz+wyz6zkntNear2s/LjLYR2wUgLhCKJcu2v4QrvYh+nR+pMY4vcbXVw
         i4li2xak2maB6CIElCf3KHGcn5nPFBjBS5gYxd08KIkd3MPC4en8VZt4YnytZ9a93DAF
         SM3MUxytpj4tiRUhiHIXFTNvbe3tzXTQWN+45YklKye0gY2o/TF4oO76DwvayhzbAT+S
         g0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWC1mhmnvI4Uxz3yCEvi8foYrNu1S0W9JkBmTrvYn6eetPRlxlm7ICWIjGWFwyXou7ptxA4QnM2xO3G@vger.kernel.org, AJvYcCXPDkXWlx9b/P0wAPcGytSZ7x6XvVBrOYSjeTOIkWoIBpwzEsI6DyH7Dx3HMGZ8Sjmrm5CkorVSfGB7gmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fu0E8HX1S/W5KB0pLHvB2Cp1NHOir75H1lZ1mRENKfxuf+MU
	H7niZdEbpJ87eUYJZX/btKJWwq2CHCs2aDAKocFXjOzyUueStpPInusneccT+aai
X-Gm-Gg: ASbGnctDspeY7Iqb7udE4X5bp2N9LKh4f6m4jKgjCZLq67FbzOhnCGKlruFNz/9b/6v
	BUOJ7ADotwa8KekrE5t83mDCIE/AH098lEgZHRhFs2g2iS/N1F0AxS8r5ve5+CoQu+6vwoOikb9
	AWTtpmCYInPB302LQPhCt1+gKU4+bRg62Hyr0Xx1m3auJZ8Jx1KoydATFRxfyzwwaTzZ0BZdoPv
	Q017uQu5+PR2/WKvFp7aPhdQacNRw0fxm2vfxXPkTPz7CsSwbt9gxHZATIy5pW9RQh1qn3+WmOT
	itm0yqdUqvkjNWsMG8/ZhRN0yS/hX9X7bW93K+4HKD9OjtWp3A==
X-Google-Smtp-Source: AGHT+IGgiesFUWV/yzbfRLw9KUgtdZVfuq32iKhJIw8iUWSflMfyK58IUhuPCz10MrQuAnv+l4ThFw==
X-Received: by 2002:a05:622a:578d:b0:4a4:40b7:9cc with SMTP id d75a77b69052e-4a7fc9f8ee0mr225437281cf.12.1751319789601;
        Mon, 30 Jun 2025 14:43:09 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc138d7esm66590201cf.21.2025.06.30.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:43:08 -0700 (PDT)
Date: Mon, 30 Jun 2025 18:43:02 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/4] phy: rockchip-pcie: Enable all four lanes if
 required
Message-ID: <aGME5sh1fLJlmVCD@geday>
References: <cover.1751307390.git.geraldogabriel@gmail.com>
 <d3e7dc38bd287aa93a5d6bba87bf3c428ae92ca4.1751307390.git.geraldogabriel@gmail.com>
 <4006908.X513TT2pbd@diego>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4006908.X513TT2pbd@diego>

On Mon, Jun 30, 2025 at 11:33:19PM +0200, Heiko Stübner wrote:
> Am Montag, 30. Juni 2025, 20:22:01 Mitteleuropäische Sommerzeit schrieb Geraldo Nascimento:
> > Current code enables only Lane 0 because pwr_cnt will be incremented on
> > first call to the function. Let's reorder the enablement code to enable
> > all 4 lanes through GRF.
> > 
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > 
> > Signed-off-by: Valmantas Paliksa <walmis@gmail.com>
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> 
> hmm, if Valmantas is the original author you should probably keep that authorship
>   git commit --amend --author="Valmantas Paliksa <walmis@gmail.com>"
> should do the trick.
> 
> The first signed-off should be from the patch author, then your signed-off
> indicates you handling the patch later as part of this series.
> 
> [or, if you modified the code of the patch heavily, Co-developed-by could
>  also be appropriate]
> 

Hi Heiko,

thanks for the pointer on doing things right. I'd hate to appropriate
someone's else work. I already emailed Valmantas and he's fine with
the inclusion of his signed-off, so let's give him due credit.

Geraldo Nascimento

> Heiko

