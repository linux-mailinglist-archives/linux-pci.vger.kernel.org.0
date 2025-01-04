Return-Path: <linux-pci+bounces-19299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F02A013D5
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 11:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D4087A1F7C
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD223169397;
	Sat,  4 Jan 2025 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaveecPW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5694409
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735985371; cv=none; b=pSAZbCKbW1OM15ocTTAErsa2GLWwm5tVzzh9HbaHpolMfdT3E/lnyF7sRIxZUjKMJgh6IP5gSWQI1tHMw34YGT5z43ZyEFuW7T3Ebuex2y4NAK83OF1cL/jQaxRuDZtw2tpZGcX9Hy4j94+M8J7fN22I7B4JypAuNY3ENQS+MZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735985371; c=relaxed/simple;
	bh=MqSpK5fFd6N+R5mZZ92BhKCeBMY+lWUeeaTnSP4d/O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwFbG8ItyFTCpJzGWY7O4SKiRZDmp9+Pqo51rAwPwPLYgx3Xz61+ujwravvkvwIrTlWCl/FuNc1ZA8AR/2JYFz/wmpQhS3ljmUng3gWYtBaHpMfSo3L/wP2rwrG5jStOlP5GZSA2xUi1/yNR2DkwtWaiZ/VBcl1U7ZdgfFdHQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GaveecPW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21628b3fe7dso177150655ad.3
        for <linux-pci@vger.kernel.org>; Sat, 04 Jan 2025 02:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735985369; x=1736590169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tYkm1Xgk1B4FMxTw5DYysTX0sfirekp6Ox1vn7NLYbc=;
        b=GaveecPWMXGHamsG0Enec5X2oKeqJ5FeIYgVhKwC6lHE2QSZx0LyXVYCbv26AvnibQ
         m3+HnpFJj5kYO6YsYcZRLff3PGpDwB9sjAE/GZ5MercPCSYoOe2vdbCcekjBolBp4sWA
         4ZObaJVR2QQINg+p86DHw/9mx0unIa2kPQA4TlOqfA8Steu/u/Su9sSJ9DBsXIh+iwxQ
         sOyJa6oDjXiDAvS1xRT5i5i2jSrUhFXygy/B48LXbi7fO2tyGwcUDeoKyAePQUdaWrKC
         7N25tgWQQJE3nTsOFf2Qwp4b6OGeUmFDZfGxLHm6RUho+IHJlCS+dd9oAM9XS85E/3c3
         f77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735985369; x=1736590169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYkm1Xgk1B4FMxTw5DYysTX0sfirekp6Ox1vn7NLYbc=;
        b=ZhMOhRKeZ9fzOepDnGfcziC2lA3TiTF7PpjlRE/MzJQvssbY1lOv8WjMqzGL585yuv
         TLNdWi9IzDmQEXDZjH716/p8Y2w1u22s+99pCA+MxHcQ5Kv0SzIkzdBEGZR8bZa9AOqC
         LDxzAG4zTGdZay0/zb+2YZMdhS6rWIPVt9rCnZqn8K8TgvYRKaZGuwl5kX/VnWw9WlvN
         zWwHZVkkN4/stmlxM2Tep5bjUoAVr0Jwlxz5ABmDhjoA1VNPfqBBHcT47fwoSfJoCs9a
         Nfuep2T/9pRze4fmLNs7FTCkAA0CmeXqcJd0/vWGzvPDLDK4pGydzc2moqcGwbG9T0/f
         unmg==
X-Forwarded-Encrypted: i=1; AJvYcCWzKgqPsMX1dr/VqNYJV0kmHvEcOMWcy+AANpPqy6UfLt5D18skTkm2XPKqb/G8oo363SwPM/NK640=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvmMBj5eDTLzlOWhgQ+JMnaMOjRmtRhVBBfVYaCaMaHDBhTmtZ
	AdQOkYwLe6NHgkVx1FD6eMOgiRZMV1jhklDFI28Crciv3IiU4xAN6WjYX1vOsw==
X-Gm-Gg: ASbGnct7eMnkAvVLE8gy9leP9L8aqWRRZ/8Xe3CYHXfkhcVASYTCDKrxxsCIRboHcod
	ld2Yjwv9XWSEDw/QyMXK+NnC5jRBjuYMrKIrAcQGhEInGM7TK/doTAlokXN9SQw6llOWuG0HfnA
	dbIWDt+9QhQ+F7UJLWV6fpwBXe74Lx+uMFlHPgRyUp6jmRBRv6No58vtxpZx6GaMBvtwsqTydhl
	nUiXFH6GbYnt2KOdHhPqq/YOK2W4d7Z8170ZThaHf2Ziz5932i/tpZiRmpuxnqwnBQ=
X-Google-Smtp-Source: AGHT+IHtkoc+gwBG8JkQY2U036cUunWcFUlsLHte5uNHKR+ROX9udn+t+L8BjTgm8bqr/MnXqGsG6w==
X-Received: by 2002:a17:902:f542:b0:216:2426:7668 with SMTP id d9443c01a7336-219e6e9a26emr756868055ad.13.1735985369505;
        Sat, 04 Jan 2025 02:09:29 -0800 (PST)
Received: from thinkpad ([36.255.17.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02b4bsm257640505ad.270.2025.01.04.02.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 02:09:29 -0800 (PST)
Date: Sat, 4 Jan 2025 15:39:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: dwc: Use level-triggered handler for MSI IRQs
Message-ID: <20250104100923.67tmfgiuyu2h7zzd@thinkpad>
References: <20250103174955.GA4182381@bhelgaas>
 <20250103175839.GA4182486@bhelgaas>
 <Z3ho7eJMWvAy3HHC@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3ho7eJMWvAy3HHC@google.com>

On Fri, Jan 03, 2025 at 02:47:09PM -0800, Brian Norris wrote:

[...]

> > Oh, and it would be awesome if we can motivate this patch by mentioning
> > an actual problem it can avoid.
> > 
> > It sounds like there really *is* a problem at least in some
> > topologies, so I think we should describe that problem before
> > explaining why we haven't seen it yet.
> 
> Yeah, that's probably a good idea ... I'm still working out the nature
> of a problem I'm dealing with here, but it has to do with when (due to
> HW bugs) I have to configure the parent interrupt (GIC) as
> edge-triggered. It turns out this change alone doesn't resolve all my
> problems, but:
> 
> (a) I was hoping to get feedback on whether this change is sensible
>     regardless of the adjacent HW bug I'm dealing with (I think it is);
>     and

This patch alone (with your proposed commit message change) makes sense to me.
Since DWC MSI controller is a hierarchial interrupt controller and most of the
designs chose to use level triggered SPI to signal GIC, we never had to face an
issue. GIC would mask the interrupt first and then unmask it after handling. So
even if the DWC MSI is level/edge triggered, the behavior would mostly be the
same.

But we should model the interrupt as per the hardware design. So your patch is
doing the right thing.

> (b) I don't think I have a great publishable explanation of my HW bug(s)
>     yet.
> 

This is not a blocker for this patch IMO.

> I understand (b) is not really a great situation for public review and
> would understand if that delays/defers any action here. But I'm also not
> really an IRQ expert (though I have to dabble quite a lot) and am
> interested in (a) still.
> 
> (If it helps, I can try to summarize the above in a commit message, even
> if it's still a bit vague.)
> 

Your bug is not strictly relevant to this patch. Quoting the spec reference and
changing the commit message as per Bjorn's suggestion is enough.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

