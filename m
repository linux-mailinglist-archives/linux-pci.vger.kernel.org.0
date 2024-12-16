Return-Path: <linux-pci+bounces-18529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B961E9F36AB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3D6161B40
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19982063C9;
	Mon, 16 Dec 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wk6qB7Kf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75E2063E0
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367719; cv=none; b=iINunPPfBdNFRtSIhtPiLAst9FRdA+3mYkgY9bSFrM5c6M40K4n48c78CzPT1VubReYT2PzA3T8h0P8xIcqAdLV7mhB+IkOMeZotCCP+d7bqY03Ka9sF6rR9lGeyLpgyJfi3LTNGDrzno3Xrs2+/JKsMpD+W7E9ZeaeoTPVM3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367719; c=relaxed/simple;
	bh=JVy1OakhjRBLAdA6bfdtQVTG5Be/+QvYNXigpOHTD3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiPaiR67pgDRElfjjySIszCbi9CGJJPJhQPJoiWsDtjNXqXZdQZvCFaCLhlbrt4TNaI3oapYZ+LA96wlwi/7pKo/yhgie/XP6oZ14MoamH6pJeVNMnxABPSaCrN/fXh7SUvV9nI1st0aW0xWXH50aAfBBbAmcm39VhmxwJYj2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wk6qB7Kf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21628b3fe7dso33682215ad.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 08:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734367717; x=1734972517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uf/C35BwQBTRlT0IeaFUKw9xJGt6H8iM2xKqt61L0Gc=;
        b=wk6qB7KfcPA62V34D7l/DQce+iYDhcODPnDK0/4cySZmO4TrlaCXZh6wy3Fii1Pum0
         CciDHmoWb0mbaCX6Y2wM+bkPDxagvGX0rIDC3peMWGU0N4kUA5Rl2MWhWC2HZxMgwUJZ
         4LoRX+uG7fJogSX//RB6GljG/9/9sy8A0q+ERPfTfg7VjuXuj3yblWqOlhvmONaq0EF5
         TXumy8N5yJ7Uj6BzkL6hfUITNAUqGKT9QrKjUsPOAmiMP0EjC+jx8EI9L0mLged1hHAl
         ej7bsb9yjodB85tF2iNX3dD829cLRwcSEerKqK6x8FvG+O/VYB7L4R3AkrHni7PGf9Lk
         tZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367717; x=1734972517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf/C35BwQBTRlT0IeaFUKw9xJGt6H8iM2xKqt61L0Gc=;
        b=Nm43cvkU+FV20n3Rl5HBj1ygnRftx/czPpYmf6gaJ+GNqkOabSAE3tWkqYrPC9S4zb
         TE5oWrN1z4QiQsL8D1HGuQExlhLjt1pJFSsNIDaISXhFoowulh6Plm52fYgoYgwLYdy5
         K4dOkd/+Gi8VWskRxK4JpL4eeVFtpLte0Jnh5j3kjMji9l0YKtP6Kh2X6tUw85KNraqI
         gYB/Cfupz/b9OmI8UuIUipcRnXrTBFGeeTv1mNGv0BNTmMPs/sIZLS7e7+GYT5IBrBE5
         N+/8POAFNcY6iE+6KREjhXsFdNLDSSKExioXs2z9UN1sPjQ+lWA7t+/B4EwN2dFeTXCI
         VtmA==
X-Forwarded-Encrypted: i=1; AJvYcCXiJ0DvfeWO4iPFICpYps7dAmtFKx1NYbLcis1wxlVCu+dUIBLdnUfoRk6NeUZKOXbO/joC3SLsMJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0q1ZZHYCpKtVl2Mmr9lY1Qet8FxcJvuBNkSN9Wc0AaRxG+9FV
	iPz632PuQXfRZa+jnKw+CZQkeFpKdjt0JCUN6UHWMR17x7l+OJv4sDVRnyZntg==
X-Gm-Gg: ASbGnctA4YzWK8JQfNMGl0yaiKfvOL26j4eqO/GwE+VvdTdNV5H3FPhA3LM2nyqpM+l
	WKl/+W1oGq/azJh+eC85XB8FKjmQ0Zgniyv2cePWyyG07VaKiTlGEB8Bh+1DPN4NSYljCrhIRxF
	SRzLwFlxB3QKezgh5na0cWFxsQ70/DcvjmLcfTOUSxmIBZKP+aIClaGvpJdyiKvBiAmaOxFhMz+
	IySgp/oEfEVS3DldPGNHT5HTevnLj63lepmUiDo1BrCeFXI42puMq16PxVYTytOnD5s
X-Google-Smtp-Source: AGHT+IEbjZhCC60l4mXiJWyw0YJq9ctEYxooGkv/o7bOg9yFa29PqtrzXCLZoknekW9tg22tCtP5pg==
X-Received: by 2002:a17:902:ccd2:b0:216:26f1:530b with SMTP id d9443c01a7336-21892a70579mr183783695ad.51.1734367717333;
        Mon, 16 Dec 2024 08:48:37 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e510a9sm44948185ad.167.2024.12.16.08.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:48:36 -0800 (PST)
Date: Mon, 16 Dec 2024 22:18:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241216164830.36lpu6gfnapsdar4@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
 <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>

On Mon, Dec 16, 2024 at 05:42:30PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> > > We need a PM core API that tells the device drivers when it is safe to powerdown
> > > the devices. The usecase here is with PCIe based NVMe devices but the problem is
> > > applicable to other devices as well.
> >
> > Maybe I'm misunderstanding things, but I think the important part is
> > to indicate when a suspend actually MUST put the device into D3.  Because
> > doing that should always be safe, but not always optimal.
> 
> I'm not aware of any cases when a device must be put into D3cold
> (which I think is what you mean) during system-wide suspend.
> 
> Suspend-to-idle on x86 doesn't require this, at least not for
> correctness.  I don't think any platforms using DT require it either.
> 

On suspend-to-idle, yes D3Cold doesn't make sense, but on suspend-to-ram it is
pretty much required. That applies to DT as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

