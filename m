Return-Path: <linux-pci+bounces-32203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D272B06929
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 00:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A963216E161
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA47262D;
	Tue, 15 Jul 2025 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZzGvKgHl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AB26E71A
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752617825; cv=none; b=sEdV+3AV8VaairfoLx1lOxTiC9VTdXzCo62UXD6Qs6qzT+gjsG7MYzu6oY6sPWitLRFip6EeeMRhhMASPWY2jXNT4yzA7FZ9GPqb+kKJz/1UoVwhUCD9jwiBqwAKp6Lb+2qLG6J4AW3Ybi2E9U+7u6L3H2TR7QSla41gM9+PS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752617825; c=relaxed/simple;
	bh=tMdoZBivQy3B+NItaHwOMyR9RE2Vd3YaDfvRU31vZT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb2o1I8a1BFg+OF5wMvm1CVXLULooBoI5raTr0svrJQpROobR6SmfndU3nqkrbsKexTlUE/ZIfdcchQPaxEIuLINiI4ERfSScb8brVUBkvDLihSoEJ3RQWmvtnONL8d4/k31Tyb8vTdwp+GjK2gkt0QwlmUKRfv1oxbX/HNMIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZzGvKgHl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7490cb9a892so3634218b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752617823; x=1753222623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/kIrHiKONJdy5Cuneuwy/QdepmnycAhgTTDDzUGMMs=;
        b=ZzGvKgHlGQ4j6Ypks24jX0/Oxij9l80u6M4wue/UKs6usct+buj7OHQv7kx78ZkqIr
         6zkjqWIKF3bwlDcvQV80gQ6biSabU5N8DDa19CzAyMvGVZWZwuz+WqUmRSUBC4JkhYJL
         kNomn0j0Kec+TgWFIMYHKjejwzYeePZURJ8FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752617823; x=1753222623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/kIrHiKONJdy5Cuneuwy/QdepmnycAhgTTDDzUGMMs=;
        b=KhkWiTb08i/j71d7LUaXddh9PyKSxfLPqvvLPr90cjKv7FkA0xicy5UARF6ZK732Tc
         UlSBHaHQVS8WAzT3c1Fg7CWcw8rI7UoV+cKw8zj34ecsr0WVbx5cdz3MkQdfKJEr2t8t
         fLTOrjfDBaO5gvWTumt3G42GqxNa2DKQQxPsycmHH3xuvmmWDcgFCHPXnm2LvMU+VEL5
         +emj3C1Xa+LNhq/aViSxttL71IjJP99hImHDt1NzZMwdJd16rUF0HH7fVAHcvbSaUgbd
         CuS7SpvdkuzCUetJVPjqqZhZqaHual4+hEfvth8WS5Vu4Lwzm3QUgPHJf1Oe0RMesym2
         483Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkUdAAT9voE1BPnxiV3V51Hwv6WXNXkNyxRQpCaBJKHYDfLsPZV8kUSl2llpgYfyuOUVwqHQfa/+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiTIFWJfXTBx5ZOOHL4wEWxbaIVl6xq3GvP10K+jInoWUTdS2
	VJWN/dTY3PkyPgqLOXPKvBLNYissuOA10uLyJAvoZnwiar4hhh1Jbv1usSrCwVerqQ==
X-Gm-Gg: ASbGncuih7OplDAlQzL6GMW5u4rsGy3GzqTTsgdF/pmYwaI/zDZer79svQ21z6+YP3+
	RO+rEI7v2/7aUlbriLR5tmFCD7LtdoaOVCDRI7xSgYkZFrKUfjRN/YArAqAe2Oy0/wAuEiVc7ia
	0Jvaa6gJm5HmLkLOU7ocToCmI9ZhaObsyucgPUk8eyRhG56ZKTgSWda1XifCpqzll+tnAduFSZM
	xA1oQDBi48i2Fhvi6QiYijIHfcCCQ5/AzOSqnpzEGTXfOtPVHg2PcUPMQ/7b0qLwK08j/5nJOI8
	j13WiqyJZTsYTapMlTUEocEnsb1f6mfT0gNmEEnNkJmwVy0Rabk2vY26NlBy19RcYdubxfUaW49
	aqxDSRqcFi99VEAt/c421QyPhCNewhzOuNRHvgG1UuALE1NHs/JyiFoJP6ld+
X-Google-Smtp-Source: AGHT+IEi35Q/9L2R45q9+Ckvy4VlsxjWRECWaXaVKZkJ79j9LtzQTdHiPF2AYMs8Ki3dyCacVtaadQ==
X-Received: by 2002:a17:903:1c1:b0:23c:8f17:7f45 with SMTP id d9443c01a7336-23e24f70e34mr8439895ad.50.1752617823417;
        Tue, 15 Jul 2025 15:17:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:3478:49c2:f75d:9f32])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de43352b5sm114969135ad.165.2025.07.15.15.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 15:17:02 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:17:00 -0700
From: Brian Norris <briannorris@chromium.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <aHbTXCYXbxLSQhgK@google.com>
References: <20250702223841.GA1905230@bhelgaas>
 <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>
 <aGXEcHTfT2k2ayAj@google.com>
 <aGc666o3EgtXQMGN@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGc666o3EgtXQMGN@lizhi-Precision-Tower-5810>

Hi Frank,

Thanks for the response.

On Thu, Jul 03, 2025 at 10:22:35PM -0400, Frank Li wrote:
> I saw AER and PME irq registed. But I have not seen irq increased. I am not
> sure how to inject an error to test it.

I've tested AER-like conditions via one of two ways:

1. force asserting PERST#, and then try to read a config register. This
   should generate Complection Timeouts at least, and possibly other
   errors. This method may not necessarily yield AER logs, as it may
   also reset the error reporting registers that the Linux AER driver
   would expect to read. But it probably should still trigger an
   interrupt.
   This depends on having access to PERST#; many SoCs provide this as a
   GPIO which you could potentially control, although I don't see this
   in the layerscape driver at the moment.
2. asserting HOT RESET in the DWC controller. This is especially
   implementation specific, as it depends on how (if at all) the hot
   reset signal is connected into your SoC.

Not sure if any of that helps you for testing. And maybe you want to
wire up your platform IRQs anyway.

Brian

