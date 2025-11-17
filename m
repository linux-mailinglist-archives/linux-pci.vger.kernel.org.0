Return-Path: <linux-pci+bounces-41362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0C7C62A12
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 08:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4864B3AF431
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 07:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C11F2550CC;
	Mon, 17 Nov 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADrSGRUJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D76239E81
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763362963; cv=none; b=tY8J6yV+FEhJ8KHuVBFgVZVH/xg2ivYhC5cM85FBsQMWNS7F9TJQfxYofsISRiOXAClqLN8XTZPS3g3beXCqEinGSWdqEB+EFPCMmlLIzWxEqdKltKkNxRuXhEOUMjoDThF6PvVpiKmlLojK2C3jMuETLFe2KIfKxjJ9JOYVGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763362963; c=relaxed/simple;
	bh=pp9UOtcFxPjx8S/BV3HDsxkdaIllQ3lDh4Dw4F4JpiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8hSWo7TCtsHrPXpq2YBc0l4VVwCBCa2sszolnmEB5hVqPtMBpeARaHwNrd81N8o4RoUfc4070QgkgdxRNoHDmqpNslFDluQiOXF1m3wY1jvje7dFjK+mk2bJ/9KdXAopyehV2RamILSD+ltAUNUXxMgLMTTSkz2EhruACezMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADrSGRUJ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7ba55660769so2285441b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 16 Nov 2025 23:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763362961; x=1763967761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fASXZCo6zuX2fyCl4lSygWMZOBjiZpryb8F1RE8Zsso=;
        b=ADrSGRUJmEJE3HR0cpwzQ26Wka10LYrpZVJcRQjpaig3mY1025/fOi0I7kbz5Ej/cl
         j0xTZwwO9BfpAbcHuZHLgGpocSP4JM4Nym/7zQJSFEmVVMgFo+fCF4Bwg8Hh/rWI08K3
         lXBvXgHymHn9stY8ufdvk5sSBaVFrTN6qOPU8V2DPCDdqGMIlmewgyrZXR2EWJuOJFpY
         qfB/KnV2DfNK8FrAuLm8mlJp8FDabWgq3dn81X4heDXOK1EJu7rojmlYmrTiKsMBw7r3
         U0Xk4vlZw/iQ/cKthNqqIz1c1EDXDsCLI8/5x/09Ukv2Z97Kc+mpvkFe9bSsAP5pJhTF
         7CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763362961; x=1763967761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fASXZCo6zuX2fyCl4lSygWMZOBjiZpryb8F1RE8Zsso=;
        b=a2zGtXnZ0MY+tOKWHA868RbtlPko37adfHtjBDLqgkaA+0u1SY7EBdgRJF9t7F4dlu
         8Zs/GZEZWf1BsioMz4BXmi9vn4mxN9DTLf2E6kAXXuGTYzgGuayMgV/uHlDrJgk/T52b
         7jumPFWRFMNFDXvH16nukVaqA6+hfeExfZC3neU5WlarPFSllyzcB3cTckESO+Rr2eRS
         OJ4POw2uLy5MCfM5RYPIgFjr+w0rXFynfQofXG+cpWb/snjmmkOsWER8ar0ZgS8XMehl
         yCRWt4ReGh10eiHJhgr8h/fefguH/IS90cWT4rwxf4confRvmHK3il2fp8phhJMQwgZ7
         pCTw==
X-Forwarded-Encrypted: i=1; AJvYcCUKcKnsiLHbZQ11qsfMHydPVFGmEbDLl7A4/h+soX+AW2D82frWIkMn8JZFIHgxGyJ7gdjRmRnnP3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8dPdjOkF/WcYEDzx3Q1ZgikM4bIwoPM3JKSPnGAvPo/tJ5RBP
	Wve5b/z5CoN3MZ9uk+4ozBC7iPQEPFBTGt7fwOxTGLjDvioVvu1xGbhv
X-Gm-Gg: ASbGncus5IMCmJK9kzFanrJEGTFT5dliLDfdkoThkWhigU1MPlKC/gjwr8fDWk8FRvy
	5SUjXXkauN9WEdCsMlknFNFLhhn9Iv3XbXM37jb1QNO/tlxln4h6Z5f+VibDeh33HvnF5oDM7mV
	rGzC/Qj2DOgIRZgTnhJlSMuWULXxtfIxLCMsgqGuw54TsZLKK2cDrDUZYrbn9VvUEk8Z5MY3DQq
	kl6nHpisuHaNe5AWLdPodJQ5GGsp7AGe2EeSZegRLQVlSJ3wRsFytiAMBF2tONVb9ukozCPwUFB
	EOCJv6HR8NPxc/le6BfMaKMdu+etV/HROmYyB0xzIf93qxCBKEVLUhDpkj/ML0TtgRR1eHbcc1A
	JL4oBEnBRyy8niKr1WRYtj8NpDK3PRNXXxTur7xlVAa2XbpYcIgUvOuN9nTy03l8ZlzQJU6r6Jd
	wMNgXh5i2a
X-Google-Smtp-Source: AGHT+IHfnm3IzWza8gHcE5HGBty9zF9EvqIvnvTqildA2ZM0zlu5AsSzDpAQGo3gcaH0YBBS76BNfQ==
X-Received: by 2002:a05:701b:2412:b0:11b:9386:825b with SMTP id a92af1059eb24-11b938684dfmr2055518c88.48.1763362960827;
        Sun, 16 Nov 2025 23:02:40 -0800 (PST)
Received: from geday ([2804:7f2:800b:a807::dead:c001])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885e3sm44795481c88.0.2025.11.16.23.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 23:02:40 -0800 (PST)
Date: Mon, 17 Nov 2025 04:02:28 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/3] PCI: rockchip: 5.0 GT/s speed may be dangerous
Message-ID: <aRrIhA1uv_aIneOc@geday>
References: <cover.1763197368.git.geraldogabriel@gmail.com>
 <8f3cc1c1-7bf7-4610-b7ce-79ebd6f05a6e@rock-chips.com>
 <257951b7-c22e-9707-6aba-3dc5794306bb@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <257951b7-c22e-9707-6aba-3dc5794306bb@manjaro.org>

On Mon, Nov 17, 2025 at 04:57:11AM +0100, Dragan Simic wrote:
> Hello Shawn and Geraldo,
> 
> On Monday, November 17, 2025 04:42 CET, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > 在 2025/11/15 星期六 17:10, Geraldo Nascimento 写道:
> > > In recent interactions with Shawn Lin from Rockchip it came to my
> > > attention there's an unknown errata regarding 5.0 GT/s operational
> > > speed of their PCIe core. According to Shawn there's grave danger
> > > even if the odds are low. To contain any damage, let's cover the
> > > remaining corner-cases where the default would lead to 5.0 GT/s
> > > operation as well as add a comment to Root Complex driver core,
> > > documenting this danger.
> > 
> > I'm not sure just adding a warn would be a good choice. Could we totally
> > force to use gen1 and add a warn if trying to use Gen2.
> 
> I think that forcing 2.5 GT/s with an appropriate warning message
> is a good idea.  That would be like some quirk that gets applied
> automatically, to prevent data corruption, while warning people
> who attempt to "overclock" the PCIe interface.

Hi Shawn and Dragan,

Alright, I'll send v2 with this suggestion in mind. So that driving the
core at 5.0 GT/s will require patching and compiling own kernel.

> 
> > Meanwhile amend the commit message to add a reference
> > of RK3399 official datesheet[1] which says PCIe on RK3399 should only
> > support 2.5GT/s?
> > 
> > [1]https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
> 

Shawn, URLs have the bad habit of changing or simply disappearing, so I
don't think it's a good idea to put URL in the commit message.

Also, the datasheet just mentions that RK3399 supports only 2.5 GT/s,
it does not mention possible damage from driving the core at 5.0 GT/s.

> Also, rewording the patch summary as follows below may be good,
> because that would provide more details:
> 
>   PCI: rockchip: Warn about Gen2 5.0 GT/s on RK3399 being unsafe
> 
> Or, if we'll go with the automatic downgrading, like this:
> 
>   PCI: rockchip: Limit RK3399 to Gen1 2.5 GT/s to prevent breakage
> 

Dragan, these are good ones, thanks. Though I think I'll omit Gen1/Gen2
wording since I know how much Bjorn dislikes those terms.

Thanks,
Geraldo Nascimento

