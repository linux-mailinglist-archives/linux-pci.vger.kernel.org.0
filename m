Return-Path: <linux-pci+bounces-33517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213EB1D243
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 08:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF021AA0C07
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 06:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9958817A2EA;
	Thu,  7 Aug 2025 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep8BEcEe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC72E36FE;
	Thu,  7 Aug 2025 06:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546599; cv=none; b=s4d2IHJVmGV32i0av4NMiRMilDd8nVnQQ4MAa7eXvnb+5YZ7FPq7uYDywus4VCPmVP6oXqqjr0Z3WtfC28wmA071A3g/ku3b7S22Czz3CNAbQuJAIX5vbZmiJl4Z/m+Ue1MtAOGr5YYhqS83Sd2Zybm0x8htjMaSTP8XU01ifYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546599; c=relaxed/simple;
	bh=Mgm3+Zt+sdADRkXhMMYxJzDIxJVuJ0elzR4ohr+MinQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oV5dTjA06Wvboh+SsESPfjUpH9gw5NBBYTJHdGOsvXEOlnFQ1tmOuO0fKVErU3CkhF2+Q30f6ENhrwD4sEjyEgXR9Gn7iMajnUWvoGiiCVoV2KzVTEyJrVlSjgEOyht86vRqcRsl41ZFb1ay8Ipx8/yVCBKMed9qA2N9hySj+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep8BEcEe; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76bed310fa1so604404b3a.2;
        Wed, 06 Aug 2025 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754546596; x=1755151396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mgm3+Zt+sdADRkXhMMYxJzDIxJVuJ0elzR4ohr+MinQ=;
        b=ep8BEcEenyTT3LQ+hDTcBUC8OjIvKXGQrcs7bCGBOn57C/OEJpAt0DYe7BErEA8ELS
         DDgpj8Mb7wM9jn85geTCk6sPo+vFfjddx7RhEr2W4PL0MdMnZwfqx1spSjPrf8MKaTnu
         sx5rRs/2UOb+752HRDTlQU4IK9IbKqVJubruAHZY0nKMjARWHU2TDp4FriSCa3ar2xZo
         qlIccQYSacJiredQ728ObzhdtNH1TF80Cvef+0Ak+6JLmmUuan3PxMQioVWNjO3bQ/Al
         i6oUBMzebEGzmBylqu8wrOJj/YSC7HeXp4q6G7EP9QvVPtQmUNOMlpwAHddE2T2bvJYC
         Z3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754546596; x=1755151396;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mgm3+Zt+sdADRkXhMMYxJzDIxJVuJ0elzR4ohr+MinQ=;
        b=k+FIrPO+RsE6/+n+n0jE59lOU5rj7zkahmhx4an/X3PILamOMhWfHFEvL7uuEuI10N
         4ZHbdT6LHt3QLX9UptQWmmoWfSc2CHwMTFa7HT1qxziEG1Y21ULsxZnt/ZjKxzVsGt5k
         S4jMfT2JHtprVcyZBjb4OpG2yftuGHGLjh8xqbkeO2einu/+RvtT9s6x6ZhsGC0dv5Pg
         qz+8+5W+r0ofHf1XFgZPb+uTz6WCoUOENTfwt927hCxu5r6CLGU5c0SoIq3gbpntChSU
         lA3wqw2LVPnmoby2pU5QB2FcKaVEQnFZk/ZKE4bfYRU1NHCtLYWdPTaFea1eq9HrF0jw
         CApw==
X-Forwarded-Encrypted: i=1; AJvYcCUf9Cmu/hSXbY90oUB0wbNZ0RVbZvQ7J0DqZ5udWe7qgSLTKD21RFOFShQgeD+RliZ38N1DNjG1rLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgxberv93ptVgOWxyuldTAeUFRw+aoKM0R5nWu6hgupMMnrT9x
	HSX/43qOp+nJjfEOcZBSp7JYuJ6uqDtBGimui1/O9tLxuKotRNU23H48
X-Gm-Gg: ASbGncvxtg4kkOKHT3G3lKiVOIr0B2ikRssJMSTv6dNf6M8YL57N+QNslpGsasR9fI4
	SldoctgG6tucnjev+qtZvMoAuxqGcPYBKP1QEStQGlM5/0vnGmK9e8dXCvUp04YzeYlfrk5mVL0
	AbdomM+HZSkhNB93t+knNhdjQUgXUSsl2Jj4W2JMBLH2t8uGZvxQaPzAaASpwms4AbQs1dMqbnb
	/vuuCk7dyf8H4OCHdXb16RByiZdMIAh+PXRm/YtEBDY7B4GgPUhP2+PRrgcSZ96Oi8FUhOtC0hL
	ttep07kcqqRA7XsiMAUAw+xcSWt910e0AZ7fst0D0dsnXQVdscfsKdCPrSHUOYNnv7g+xqk0i1b
	SaIkzIe3KHDsIcselOTv7
X-Google-Smtp-Source: AGHT+IH6lABCGe6nUJ3kPvVb563/6ouywKEcAdbkht5BNXwnbBe1ECADH5tMvk01xS+e301pC/fA/g==
X-Received: by 2002:a05:6a20:1611:b0:240:d12:775c with SMTP id adf61e73a8af0-240330fb815mr6956353637.36.1754546596218;
        Wed, 06 Aug 2025 23:03:16 -0700 (PDT)
Received: from ?IPv6:::1? ([2409:40e0:b:6bac:8000::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2ea6893csm2864209b3a.104.2025.08.06.23.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 23:03:15 -0700 (PDT)
Date: Thu, 07 Aug 2025 11:33:08 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
 ath10k@lists.infradead.org, Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: Packet loss with QCA9377 (ath10k) on ASUS VivoBook E410KA
User-Agent: Thunderbird for Android
In-Reply-To: <20250806204018.GA14933@bhelgaas>
References: <20250806204018.GA14933@bhelgaas>
Message-ID: <BBAB0136-BB7C-4D59-B29D-2F35FC29D7AC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'll tell the guy to clone the ath-next branch then and will inform you pre=
tty soon=2E

Bandhan

