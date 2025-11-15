Return-Path: <linux-pci+bounces-41302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CEDC6032E
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 11:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 226F64E2279
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABAE28751A;
	Sat, 15 Nov 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqf0vtk/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A836257843
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763201530; cv=none; b=A1GXiQjJ9YEsQgB1aiuaQrN2KAsslEd0nc74WucWlGpczNlTHCr9xnbDYpeWtXc5bwSFsXqDnKTV5icpFg5yXxKB6sZ1A7X1gXwK6P/Vo7ncJsdZfXG82CSYiIN5rX/KRWReIWPP6uVllwx4uH6k/fWH+jFPxiZaUJdFQ0kCRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763201530; c=relaxed/simple;
	bh=tTipRfPoP0MF1Jl+BTl3lV1NSWbP9afYNktAm+9O+Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8dD338dhHpkcFt3c6H8dK11ViOvyVisSwhYOFg5hY0jfViG3cYlXzcog0G9pu/X7R1GfUxn4NLjsNR0e+8N8SqnexHCwZGhIh+5a5UhBB4gJwZEs7ejVGI7rFj/eknaoT9bBm2hTRYYZnCyRrdxV9Zeuioz9eRsIZHX8cPu9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqf0vtk/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc4b952cc9dso1668465a12.3
        for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763201527; x=1763806327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gm+ckSfEplX4Ke9EThg3ex6u+yrRtxkSfPzMWCL9PGA=;
        b=mqf0vtk/gVaIhgOrv3VS1rvyf90F/hoLmzEjS1UWDzlWVJdwvv9hp9rcdY8h7R9wKH
         HIzs5xtmcyLdWjyqCnQynXQMbDq8UG5rFySGrvmg7rU2Htt+5gBPtqOW1uxScYzXVTNt
         W3fCurx3lV8JLYRkCYJ6Ryx1rRg78lAgoCGdvd6aqDENyW0WU6nXDfcnmgrJ5wuwXQMr
         ucdvuzY2xofE3qf2q/WIi4kdow/ihz9R65je/gO6XiW8Wx1GfMCCUb6TJthUNheIDDuI
         mDJVbzg3q7pwxE6NEG4YZtOQp+Are8AEHH2LuT1nIzvhV9ICwb6vWD/8s9bcIlDmhob6
         Qc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763201527; x=1763806327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm+ckSfEplX4Ke9EThg3ex6u+yrRtxkSfPzMWCL9PGA=;
        b=xJMUr/561h/eCuNiElV4WEsb2l99BBph+4ygBqtsKkhq6lrE4AbWCDnszIiMmocssY
         pmR+kPDhHhlasAwKdvvDhEhXYymf2Zq4Oziw1CTBjEch+2orTdZSKPtURo6hNSLHDH9F
         pp8jAwILG16Tg8za3tmnpgOifMDqYR1JD85VZF7B3Heo8tL+O4rx2R9Pbe+JOUfi2ts8
         7VTgHOsi+sbisXDIT70q1nqM41iaBxOTT15M6MLCn21bzi8/J2TT3913h9Nc1VjSLUzq
         uiobVbDVzxyBfvehlN1nExHXOS6zuJPlMMTWeXcM1CpebvV0W9nhVkdppf4OvcBbPnx1
         fBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXI4N8NH/BAlucjaF8mmZQFq1eGviHcXRC2zwPUNgD6BZi9tBQfw9auuJhQGsJS88gzbv1wEVtofI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaE4asqpLGxgw5HJyHunRcJn1r/q9DA3aVcjZNBwDM1ZcoZ5nq
	y1HKSMMGrSqOfOQd2oxiuX/GYjgqmDu2cK38/9hPQ1vdRl9SL4YcJ58N
X-Gm-Gg: ASbGnct59rVEKaoJep8pGM8oi1K3BQLie6EYkNKosLL21M0DVuc/ldOkNp+Esbth6Aa
	joYAZQKLXPhm25glGGj3LPVuWJbCC5riZCBvnzG7GtwMSC3DRkIUKK61KLHGO5MiC+B9nuMFDa2
	PhGfrWCtQSQ+dB8bN+T5O8kFnZhkB2KGILPO3W6bIHGWeZjwt7tygP4p/h2xtMGettJZL5i+LQB
	e9CZMq4Q7LtrEiOukwZJWTkwMCRcbdtlE2UYcmZHzYCCqqyp47jL2ZBpnRCianCNhSJXUqYwfw+
	SG6UkfwpNUvm4dZnyaQQa7CwRJvwf3gIYWb/doWpuwqfcrh0Hl8bodaRH1d96N7dUQD270/AOQ2
	lZWpikdYgFyupAONHwmf7fuhb0BKwX9SNQCNyZot8ZwZCg/qgfhrgrrW69tBxi8l8DQT4pFazmQ
	==
X-Google-Smtp-Source: AGHT+IFOLT76Y53zANSgKQXjUT+7ysvQ4Xrl63BgxDn5v68pWGwdHgGSzDNQOkc+msl09UwqFa5XFw==
X-Received: by 2002:a05:7301:b0d:b0:2a4:3594:d552 with SMTP id 5a478bee46e88-2a4abb23c99mr1792869eec.31.1763201526899;
        Sat, 15 Nov 2025 02:12:06 -0800 (PST)
Received: from geday ([2804:7f2:800b:a121::dead:c001])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49dad0aefsm15522074eec.3.2025.11.15.02.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 02:12:06 -0800 (PST)
Date: Sat, 15 Nov 2025 07:11:59 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH 2/3] PCI: rockchip-host: comment danger of 5.0 GT/s speed
Message-ID: <aRhR79u5BPtRRFw3@geday>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <b04ed0deb42c914847dd28233010f9573d6b5902.1763197368.git.geraldogabriel@gmail.com>
 <c8a6d165-2cdd-cd0d-4bed-95dfa5ff30d2@manjaro.org>
 <aRhNIcGcQKp2ylqN@geday>
 <85d1543b-ea91-5f0f-59d6-e00fcf720938@manjaro.org>
 <aRhQMRjffbeCeArE@geday>
 <52931e25-0d6f-ca0a-7c26-2c65ab11432e@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52931e25-0d6f-ca0a-7c26-2c65ab11432e@manjaro.org>

On Sat, Nov 15, 2025 at 11:09:42AM +0100, Dragan Simic wrote:
> Please, wait a day or two before sending the v2, because that's
> standard procedure.  Sending more than one version in the same day
> is highly discouraged, because it doesn't give enough time to people
> for reviewing, and may cause people to look at a wrong version.

Yeah, you're right, sorry.

