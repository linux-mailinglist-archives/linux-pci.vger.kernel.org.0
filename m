Return-Path: <linux-pci+bounces-31130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE4AEEA4E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 00:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3E53E1CE8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26F2EBBBC;
	Mon, 30 Jun 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWsX5rPv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779AD2EBDEB;
	Mon, 30 Jun 2025 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751322536; cv=none; b=AsHwRc9J/JwAk7MwedCfUmfdYitAofgDd3jnCgaq8C7BlFSAyewvAGmo7UIIPtiNIA5WcqgulCA2gHGmRukBHmRruhXxJ5txBbInEjOztzr8S2nt64Xd8JThxHqfCpIGEnoElFwXS32oIyFieVDXhBr9s0x/WtQS3+9UeUj/7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751322536; c=relaxed/simple;
	bh=Xag5C87540GSrW72HBWHgaujiHZmcBDcLbme+rawpeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdTrHl5btsHxNH4uLBk7LMq6KcBwmJb2dq43mKfpvTa5nTHHCk88YJJXGOZuMCaiByXTSaJ+mBv09/z5sbosDLBYU7HwhC1UCKzLltIy2T7Vj7tIbhmN3w9RYg5tfcKO9Tb4zq/Y5av/rMzj61tPd3Ci8fmwYZn53lSKmPkxFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWsX5rPv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a4323fe8caso16886161cf.2;
        Mon, 30 Jun 2025 15:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751322533; x=1751927333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSaP5bu22sODePS3O3o6OuW/Yz/Yqp93mwqWTCEkiNY=;
        b=dWsX5rPvfLHl0doyYf9q0mB8cUwIsQG6WfDdP22s9uDvof9hQ95AtbnotSf4m7hNuH
         3ntbxIlUaNiXYE7ot2ztnh4b6XONcvjU8FPTTidyuL4afBl4uCsUwYBeJPLUFdP1bjzO
         KXfxUuJknrtVjVAnvRAE6VepCAhbpK/CecsUXa7oWjC4sr6s77aGiaNduANVN47YR2FI
         ihddLhM/quLpqpE+3p4Id48aaRZqvyjuOlg6iyetbsfcDgQUPnlOIZqgnaRuXYCHomiu
         FCpRM9eJpggY3sP2RUk1C/H0FhrZH0V3TPA4+4dEFK8Klob8w7mCwveivvpb2Jewih+S
         DAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751322533; x=1751927333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSaP5bu22sODePS3O3o6OuW/Yz/Yqp93mwqWTCEkiNY=;
        b=RCGVp9R296hP0lKgUQIsbMqAQr54LGUuaYjpeHLBY/Xv0nSaE4+WSjcktikxTJePRq
         eniAKT1w+j6e9rOMLaAuE4WQWog8G6LpFan329uQJsJ0RtjMCrw3zyYC9LDwTctWXLo4
         lGNY01eCbnug53ByStdFhzqUNh+dEdiOa5Iq+AoNBEukDALWFI5vfXu5tNUW/0EuNcXg
         sHe1vFLP24PCd/YgJBv8QnCazDoZ0Jp/ctmsmbjcLRPAnw+MzGcWen7/nr2yawYZmsCN
         WBG0uCKDP0FXi+GBGitBE/3bP3FpRwWT9bE/vvp66aoR6/yeYdvLGNmVl/f1y5VyeWil
         KITQ==
X-Forwarded-Encrypted: i=1; AJvYcCU75kou7yfluDBulTwzT8GVjgAoAg7z29NWesJhMBdM1RTfBPhZQpmZBEPL+IMwd+BVPZF5Y6C3XJEYnQI=@vger.kernel.org, AJvYcCW3Ll3xQaOg6OTHDACq2APQK3+Bg76dzKvYgwgvQJbUgDAmvJ5yFXrZrUZwDlSWmfMKN4rYJq8iVvB3@vger.kernel.org
X-Gm-Message-State: AOJu0YxzCsA4ofJ3dxX1l7BSEh9AdmW59Ikyz7OXso3Y6ZJqZO444zfC
	Pw47KTpess4KD9B57jUTvbIXnZUBoxPj/4IPzFeBx8ysF5T/c8FoYG2X0fPfBgUi
X-Gm-Gg: ASbGncspD+s7niXBamZys8fp07Ozvqo4YapWQ0fBymHF5TTv8J/3x3aWTtMzG38nLcB
	aqzYyKlKIx25pJa7O/+7aLouzytcFh3ilnO4i2hJARA8i/9tHZFMZV4Ggn2SQpAfzwxSP8ctg7I
	Dl6wa0Rn/iCu71JHWp9lQEaGyOWRdo0pl8/yK3O2OBLVe2x6onlzwNWnZNJXpjKmrV2bCH3vaba
	B76edyrA6Z1RVwC9Uhmxmr8ZUuHACa7gfxIVX0NO917bEH0vW4W8x57pkrKjt2jTMtGICxv/WzF
	o1tSdV7IN6cdZmx1yKHYZepPLeC9H884392/av9TjQg2Yw3UtQ==
X-Google-Smtp-Source: AGHT+IEMPUqeW45dRJW4czX3mdDVSLcJrOSDF/YCwt3dJID5kuK14Ei+8Rr00WsM+IEYTAg6AuZ/Vg==
X-Received: by 2002:a05:622a:1994:b0:4a3:d015:38c0 with SMTP id d75a77b69052e-4a7fcbc9f4bmr253146511cf.37.1751322533182;
        Mon, 30 Jun 2025 15:28:53 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4851::dead:c001])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc13a311sm66966841cf.25.2025.06.30.15.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 15:28:52 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:28:46 -0300
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
Message-ID: <aGMPnvF-TLsmA8rz@geday>
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

Hi again Heiko,

Since I don't use git-send-email and instead rely on mutt to send the
patches it seems I needed "git config format.from true" to properly
add the From: to the email body.

First try mangled From: email header, resulting in Valmantas' name
together with my email address :|

I've resent it (hopefully) corrected now.

Thanks!
Geraldo Nascimento

