Return-Path: <linux-pci+bounces-29203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A68AD1A67
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7150F3A7355
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B7D1386B4;
	Mon,  9 Jun 2025 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9yh41e9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6594D8CE;
	Mon,  9 Jun 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749460806; cv=none; b=fxS+Pc0kV/IM7E1HUaPFqJolNF0WkPA4enX0tqD5Q0fHCdczuZXLmg6yZ0EO4TjAXXhUyucjoe9hZF9jZYM297IVGwt7nmpeDk2bQs1HS0jCeg/vLy0kUdlDC0PUoavURX1+fTh1G5DrGReVLPqqy9E/kFXWr9jMlL/ywdMpUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749460806; c=relaxed/simple;
	bh=htOQm7Xq+fWUO3nTFbXNEPNbtTHR88EFCIrvr9+Zonc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIwZb0y7OgDk1rbFD2wzxalqfbPU2X4hDmC7TPlVPBl+dSQkuw9SwuLmClO1Q18BYcGMqSwbvNp0yG2HdnIUk3KBWCfwSRoVUawO2uRAVpWAp+qmo9dgj/HiJtS0ZB7EotM7xF2k0oSWvjW7cC6x5VUgJz7eoJg+jFYHC31YS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9yh41e9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so3328057f8f.2;
        Mon, 09 Jun 2025 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749460803; x=1750065603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrTIGJgKEin+rAb5rJ/tjB+ybmgkfWUdGx0MI/8bDzw=;
        b=f9yh41e9HAXgtgigaAw1qIP+TgG9UNNrPpYjKCFCjKB+L5L5m6C+8bCwkbwEkhWT3H
         A3yWtf12ziQTkzGMnG7O6EiKNu7sFNzhBnvpCjGnqgUqMMJ54b+vggPozmPRfEaCWQAC
         OCSkEdiuPAdswBO0V+OZLklsYX1CarWGs0Qru8qVjHMFsBmCBUJjhyw3Tn9t8jWDAD08
         DFLnnDn81gnnanPYnXZ8LfoF1BCAiMh244kBWWGKgeF/4edxc1B3MJqJlyeeoWk0Uyrw
         j4sLhlLx6/4ZC4hyJP57WDRFPbZNf+8NnFvHzZLb/4ON59Ph7KPGwRwWM1wr4yVh1uGu
         aobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749460803; x=1750065603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrTIGJgKEin+rAb5rJ/tjB+ybmgkfWUdGx0MI/8bDzw=;
        b=oS3VszvSvPRcIZtkYTC8fF35iIy8ba4wvKdq4+49gk+j5E03QsAd9k2LwBuPiSBo+5
         UTZKpGsX/JtaqBumYU3PYawK1bur6HeU/zadDoOhAeJBPw+UBFVpyl1KXTB4XFLZVY7r
         6e5sIzSSdR2v3vFaaS5GHiqNQm5cUOBh0KH9n3FDi43ak4yrlHg1xvV+L6WSWsTrO0rF
         6S34ai4nqnLLcN2R8x1Yx7qUTSjnIKYbyMw+lq0dEBcRqBcP7bXj5v5YL9/7pQffzOzb
         mTFg6/mmQVTHv6LHhWPjiKbGWw67sWYtjqWTGCanNeYOO1gyANcRRv3NryBoUFMshPnv
         NYyw==
X-Forwarded-Encrypted: i=1; AJvYcCV1M0YfCxabXZUU3fX5+UCW0VMqtmOt0Dq4WccF6k3gSFNMwaXD0Hr/5YEQp/goPQVaZRLl1HDbimg=@vger.kernel.org, AJvYcCXZfCmcTkXlWRKD/yH49vK4s5sIUb0OaD2ycD+5yQIyqnD3uoXfbXyWkJeTWbMrlZweHgBA+pR561SV@vger.kernel.org
X-Gm-Message-State: AOJu0YxJDVA3MuvjvZ58699KeCUZZo+IRVcGv28yKmkHUSMLTLkP/bne
	ReD2M27QLVcPQUwBgkfCDgcOAxLkXf1h0f/cAcUHyubJ9HWoNn7+wMJ6
X-Gm-Gg: ASbGncvfrfjxRcsoeUfWHwp9dg4MmQBdYDPG8I7LIbSGTNqIfNqrvd6NSoPP1ZQ4LC5
	qukFMDmDZGeEcyMsZ8M3REoIJZkxI87YiBIumWK+JD8qgA8f1B1Jqa9jbPYnUS3nm992qoNchEG
	V3IEjd0MYcJ+/rqM/jTpHl/qxL2T5LPsfDrqylFX4y690/CEsqlBdFgMgpIZaJPPwSsrWUbQfBs
	h1XnLujpjb5rgR+/gbDxBOs+rh8p/hqK/cb+MjbJtod9Eqkwnua4H9zu0ZZJjgtYjak3g/8ESxx
	L4+jla4L57LTucLqP4XlnrEvji89mJAbYh69oH3hCYNVv+XP8RltYRJgX507buxLsioFZE+BuDT
	srNQcPYAWtKJ6IQ==
X-Google-Smtp-Source: AGHT+IGdm2nsIvS94v15QdeGpJXChy7R1SHK9uj7T8QqdLrHc0cy+IkhLjV616UFFFlT5mG7WRYbDA==
X-Received: by 2002:a05:6000:2087:b0:3a5:2f6a:ccd5 with SMTP id ffacd0b85a97d-3a531cbd83fmr8657735f8f.49.1749460803207;
        Mon, 09 Jun 2025 02:20:03 -0700 (PDT)
Received: from foxbook (adqh147.neoplus.adsl.tpnet.pl. [79.185.141.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c73d2sm103440375e9.30.2025.06.09.02.20.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Jun 2025 02:20:02 -0700 (PDT)
Date: Mon, 9 Jun 2025 11:19:59 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com,
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/4] Don't make noise about disconnected USB4 devices
Message-ID: <20250609111913.55153009@foxbook>
In-Reply-To: <20250609020223.269407-1-superm1@kernel.org>
References: <20250609020223.269407-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

General remarks:
- broken threading on 1/2 and 2/2
- some Cc missing on individual patch emails

On Sun,  8 Jun 2025 20:58:00 -0500, Mario Limonciello wrote:
> When a USB4 or TBT3 dock is disconnected a lot of warnings and errors
> are emitted related to the PCIe tunnels and XHCI controllers in th
> dock.

These patches will probably also trigger on any loss of PCIe link for
any reason: badly seated card, worn connector, EMI, etc.

Will there be any remaining message about dead PCIe links, or just
a silent disappearence? Like dev_info("USB disconnect ...") in USB.

> The messages are loud, but it's mostly because the functions that
> emit the messages don't check whether the device is actually alive.
> The PCIe hotplug services mark the device as perm dead, so that
> can be used to hide some of the messsages.
> 
> In the XHCI driver the device is marked as dying already, so that
> can also be used to hide messages.

Are PCI drivers expected to stay silent on sudden removal mid operation?
Is there no "safe ejection" procedure for those Thunderbolt devices?

> Mario Limonciello (4):
>   PCI: Don't show errors on inaccessible PCI devices
>   PCI: Fix runtime PM usage count underflow
>   usb: xhci: Avoid showing errors during surprise removal
>   usb: xhci: Avoid showing warnings for dying controller

Regards,
Michal

