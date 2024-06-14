Return-Path: <linux-pci+bounces-8783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 329B7908209
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 04:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20571F21F7B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 02:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707131836C9;
	Fri, 14 Jun 2024 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDJ0eNAE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812618307E;
	Fri, 14 Jun 2024 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718333417; cv=none; b=LpE1akGFfXIr4ck1J7is1JOHrtAaki3y18/iKh+AipFiR1kNnqmFCEgukfOXomBnQvHEgZc7or9ueCKIgilpKrovkLKn6bXKTEsnBWZMfurWuSDOrPXSG39vL27f2TFL8i1HIjBki8Vz7m1SmxzCs8RXsloXQebvD48Pwc21GYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718333417; c=relaxed/simple;
	bh=IAJZxvbJIwzgrf3DKUUfUtr1PNpKvYmPVLhgR6gNrBw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cwg5H/jZ+zuxaQa5GU7khgNnA/NG9uKK2edzPeILiy+5+mcZBwyyNrxcy6TDh9H4cwwBkn3TIL8BjiJkFqFpaCrWokELQ76lrtdpAWFoBma6QNBxOWnfELuO7nUHGXYEpvldNLReKDdgP49wVXWFNHI9f3fNng8yctq9u0orFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDJ0eNAE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c2db1fc31fso284750a91.0;
        Thu, 13 Jun 2024 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718333415; x=1718938215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwMlmzHY79Ea6QwlaK2xtqK3QHqghlUYJgWlgauIHAc=;
        b=VDJ0eNAEeIolgPOOpTEuF4Hc40CHeSsSrHbebMVoFvoxOai91X0zPuCwTr0uJEr82a
         UYBxsmd7aoNTqa+2roFPXPLziT2FLY76PMb70DgSOgCRLVzjkbQ073BFzbg9qlo1gl+h
         AVca/pU5gQoa3BA0rPqJG9o6DHqfk7w0UTaCNbLLEeUCoDHkaekksy4xiNw75C1t3LpM
         jKDtIAXZtcSg7CAKH2qloU/1sPYAy13UxhhwNkAtr7vPG+iNL2pmlVeu0ylUZj4YpqPY
         LeptpTgiaATNz5vzDUIfp0Il7jAUUNg1dGx02J0NU7+7qH48dXFIwdubrs4CtUzLUE/q
         m48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718333415; x=1718938215;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cwMlmzHY79Ea6QwlaK2xtqK3QHqghlUYJgWlgauIHAc=;
        b=qGvvtwh05AfAhAL/RunbcS15kGCWFgqy2BwDE1npKNa5ilfKB+PhsWjN54PwhxeDtQ
         w3zUgu+iHi1JiykAq5nwPQTAWMJ7shRAh360soMI1t8kp1LaNhnfZLUtpd7AS4Slf9cM
         k3ByB5NGICc9C1hbeSyX6tX6tjClcLb1Uiu2REURq1/NJptcRrbikM6jTcEzw+sMTA6a
         TxVM6g5xRjYAq8cQPivqLLj1Sm5OEBSlq0678CobwEi4+JlD5czgcpUJ5Qqpj5T/G9z6
         lT9Ps8RG4rjxL8kUZ/eMQJQBqyN6EvCvTW2afUgGbcLOXqVwuFPS025X+OXMqHNtC1OR
         HrjA==
X-Forwarded-Encrypted: i=1; AJvYcCWGh+EmjnBOlBN3sCBMKcT5yZPpeKauVI+IGrP//WBvslcs8VgONdI4rrfUrxtkYzzK8FTLUceB4fwxt6k//pMj7mSzUJS/ruCvC4hHpHTj+adJbDHcJ+1hStesQSRggOrd
X-Gm-Message-State: AOJu0YxTBn7E10PN07uPraNFoLawNjVXI0Z3rnPWuPxrrRpHc4f5t/DI
	4yscTXNYGHT4oCtNR+PJohAjkfvJapOD9GfSETWUuaNmT//nULec
X-Google-Smtp-Source: AGHT+IGtlOnMbZ6qrIXOlXaCs8WWOgVzN5kzVufmW3zcJ3xPRFmbWMF3LOvpYyaOrS6uVJaJjitx0g==
X-Received: by 2002:a05:6a21:19f:b0:1b4:5605:dde7 with SMTP id adf61e73a8af0-1bae7dd3778mr1777254637.2.1718333415255;
        Thu, 13 Jun 2024 19:50:15 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6bf4fsm2045990b3a.169.2024.06.13.19.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 19:50:14 -0700 (PDT)
Date: Fri, 14 Jun 2024 11:50:03 +0900 (JST)
Message-Id: <20240614.115003.1270701076676027272.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net, naveenm@marvell.com,
 jdamato@fastly.com, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/7] net: tn40xx: add pci driver for
 Tehuti Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240613172522.2535254d@kernel.org>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
	<20240611045217.78529-3-fujita.tomonori@gmail.com>
	<20240613172522.2535254d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 17:25:22 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 11 Jun 2024 13:52:12 +0900 FUJITA Tomonori wrote:
>> This just adds the scaffolding for an ethernet driver for Tehuti
>> Networks TN40xx chips.
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks a lot!

> Minor notes below
> 
>> +TEHUTI TN40XX ETHERNET DRIVER
>> +M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>> +L:	netdev@vger.kernel.org
>> +S:	Supported
> 
> Keep in mind that Supported will soon mean you gotta run a test farm ;)
> https://netdev.bots.linux.dev/devices.html

I overlooked that. I change the status to "Maintained" in the next version.

>> +MODULE_DEVICE_TABLE(pci, tn40_id_table);
>> +MODULE_AUTHOR("Tehuti networks");
> 
> I don't see sign-offs from anyone else, so you can either put yourself
> as the author or just leave it out. People write code, not corporations.
> IOW authorship != copyright.

Understood. I'll leave it out.

