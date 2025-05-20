Return-Path: <linux-pci+bounces-28120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05973ABDE95
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718953A6F5F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643CE1AA7BF;
	Tue, 20 May 2025 15:15:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B8C322E
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754129; cv=none; b=Q47BH8CRV8dtfwtBb1nf6dRM1yiv/mveJx5JjYUn7w1m4xJSlLo8nnKDs+hY1hYjGyrBnUM9PvV74twygjoTghGQ8DqI/yt7DcRZ1misVcDr7EWux4/DutD70twMOyQqjrqi54hg8A6ghkXs1CJlnKMeEqJgTsKKUPXvedQtWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754129; c=relaxed/simple;
	bh=AlkFLy1lTkuv0BjFR5k1fKsE79WV7GEuPqW+JhdSeHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unq/2vGLCoHduxckzSM5oiBqOC5KMB788LFxdNplpzasdcDniuNg2dIjK7AbwcHi34DcK/so1Zoca87Gkht68+x0cCm5SuicouWZNoJQjneEQZ1E6TdqoXo5h6zkMoMjJmbe+0/SuEIjHc+CoXbjTn1ogKNnSFHX1KE6xum30Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c3d06de3so3261898b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 08:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747754127; x=1748358927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bj4ErAgJJ0yi68sjNLsEV9fzMQgGvD98iH+6OJGM5Wo=;
        b=ePRnDzT2TOQtO90pe1RiozyLCzgYLQNmBGbqnM3q5UGK3YhHHzLRI24Jhm1WJO5Bnu
         d0pspRiBrXIwOa+8u0rAMEuWWdQzSCTKBDiti+zf/CKiJXJf2ewgQBE2nZj/4UUWrjMg
         WcZ0EPQ3cZ7vdnsltV952V2OxWH0jC4QOyCOX1I6BtRTIr2g2jfToKdmcTdUceZceCAP
         Ah7DR6dCeIZ5q1PlyNKi2RyhAroZpB54zZx75nBSFpZFaj+ZdqmsVmh3htJpCAwAfoCi
         wMGbXcQBFSHqkiilmJ7BDP992QLE7BXpGJmJc72ImMbCdF2UINt4eAI2rsyY+yumenGk
         IzpA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Ni7USffSDh3zyrDn+7xVQsVVxw/CvYTc6S8PbVzeE9dQI9mEz734cvexgO30OEA8d9TumGhl2Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAe3nMLsyW33sbuUzUlWaiEOoX+o4f28oAiDO+pWv3Yc6e9P7
	4K+9e3bJGY7mjCqaLFglz/P5fNNUY+zqoDhfCORjw6lSpXdqenWkxJy1
X-Gm-Gg: ASbGncvFmqJl3rycWtrXlBbjoot1bnvcTZP7+1NQ9WIpVPMZRr5BB1awBU4rnRWHzKN
	NCEsHG3BEO/M1HOvg6u5vyzkqkJNnX4kUXArQ5L7MKFplHe7A6RmGNuMW8X4bqoCySsc330bTwJ
	PuoMCnBJdui0LUPp+t2Bgoxd4qUHUEHTItGGmWhVcv+56gCzHYq6PQdGznHsU+lfc6vgS4us3yl
	nmHr3zTeqP80P6VfwOwitSG5106cfXtL8xXA/Zpx4X0Sx9Gqn0NeXTByYzQ87l468V/gFY/M0Cq
	pBK0t1/Nm1mjWYrSJzh8mFOYyAclQvtjM0rhMoCP6Tdp8nw9QXf4O0+gcHnqem7vC6ALvIQLWu1
	zXJNmiJRGzQ==
X-Google-Smtp-Source: AGHT+IHK7jB4boEWjFrvA+CYPENyBCZEv/ySfpDcmFyBVNfTubX2stTK5ubYzrQ3Ja9S/bjeTOhaJg==
X-Received: by 2002:a05:6a00:a06:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-742acc8e94cmr23819900b3a.2.1747754126697;
        Tue, 20 May 2025 08:15:26 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a982a0a4sm8325071b3a.101.2025.05.20.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:15:26 -0700 (PDT)
Date: Wed, 21 May 2025 00:15:24 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Fix errno typo
Message-ID: <20250520151524.GA2622460@rocinante>
References: <20250506095138.482485-2-cassel@kernel.org>
 <aCuYyWsMVdFypcu6@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCuYyWsMVdFypcu6@lizhi-Precision-Tower-5810>

Hello,

[...]
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Branch updated.  Thank you!

	Krzysztof

