Return-Path: <linux-pci+bounces-33582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 926B4B1DF37
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4D8582C08
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A711E1A3F;
	Thu,  7 Aug 2025 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOO/r/nZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC951C8633;
	Thu,  7 Aug 2025 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604256; cv=none; b=tS+jsBjRoBq9Ec3xAWK68eh4LNv226XlMvImtohlP1cqyoHYpnZBQ6W6zO6LEbl00SIteSE5xGO3WBLq51WxVCcZqeL59lEfKOO3LFPFO66lgAPR5FR3d9crOq77zgghGUYeN/JvNqYhJXR5WvbAkj3s1RpIBkO9xa62bSiBf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604256; c=relaxed/simple;
	bh=ifGUVYPRQoynFHz12tbMQrqd7GTUJ+TmyWzhPo9UjYs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hxNh99Pjb+ab1X/zclnziDQbHUToZuAiothT1wZ+A95bz4htwuxEWupzBQGhpRPevN26Y5vWgfkPWZc06u4vEUDphcZubWmfBFZa/bnDuy5F8IExkG/t1LMQCwL6pxf5EW4XnPpt06eenRtrYqyS10Jkc0MD9HJ3oDMPGvwkIa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOO/r/nZ; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3214762071bso1825618a91.3;
        Thu, 07 Aug 2025 15:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754604254; x=1755209054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifGUVYPRQoynFHz12tbMQrqd7GTUJ+TmyWzhPo9UjYs=;
        b=YOO/r/nZPpZZXczfHBqcgDq8mVYivwEXuBhvMvN5iU2DjUbq96FLbpyYi/IUbBpCZj
         p3Oul0rX1k61H9xNqyiG01PVK/RSy475IHaJV92LbGfLUzNRON1Lo/TRZb4ZRiQo1wPK
         jBgA2EpnZC5uIZRLgrqWfeGhd/vbRleFli9o1LQKnwaNLn+L0Np1lQzR3m+63/b321QS
         byVRjwHSbL25M/wGW+pPay5NxHxiU3LIzo3UVRxqY7wQcypMhfcU/MlUJMS9iuEPVj4i
         RJiaBFuewlRDfPxA9yQKb7rlBdr+xfbRGihBVxiXtkHQCb1LpFT3Q1sUGs2VH3oqbfk6
         LFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604254; x=1755209054;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifGUVYPRQoynFHz12tbMQrqd7GTUJ+TmyWzhPo9UjYs=;
        b=MKMvekNoozwHBL13PvchI0innJqbon5KUvTlCsVwOT1sGL08SsIN0B2ob2DhBLGUj+
         7YrEtlV4VT/js/gW7HHVCy7qbcew98abxq0prGjIfKiiJlEHyyH6hjnzlLs+VZx9CrPN
         2lDqumyTuKBCo49UrKkiyPmbLMhTdghtzFYXITItPVF74PsoyUlwt1wPiZGHnOxwkExA
         eFO4GYQiL0xFkA1fOpw9//ZWIrN4MSG80WHhbxHZ7jL2Fk2gTf+ibnyDRUzSeY7kTW1n
         OPTdzscYWNc9dJG0IgouSrMltl0R3/WbulDCnWwNXduw2u/8dcTprkU+abtH+wcpoiOF
         f2oA==
X-Forwarded-Encrypted: i=1; AJvYcCUJXtymyg9pglF8cbMCnVta474C4h9NFEf3BwWqPo6uFuAivEbzniMPUOvgZC8orsxwi6EhdLujGnPGkLNR4/Q=@vger.kernel.org, AJvYcCVHPSGI9VMq/gl0OZa72kaJCfk4QNj73K1B7rqU7qFXPkoPXs6I9ysN5SOJbIdzlNRqGVNywDq4z1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkB2XhATY4dveuuxmEV7cwzXLH+VB1RQnrAgOhc2zBSzepCTf
	56ErG7r4hCFQ2T9TUFQ+AdoApLCLTq8lbuTQBo5woWC9Eqg8x12cn0uqLQnyijHqxYk=
X-Gm-Gg: ASbGnctTElZ4Ne9TK06ocxfERjdhN7Hpu+I+ekV8XPyJjpURhSJuloY7psG/SYuAGNk
	uAtUAsDr0m3YBkFUbFH6xe9XE25tuQ2J1TEfW21tmyjQim0p1m7UksIr07g/Gmc6ozEf52D/g6w
	yQx1kAtyebB5HjBC/x3l8MnqfZ6sjRpdVu00k/s8znoFjUFt2MhmGq4/YSfjza3aLTPVELGeTun
	BvBjqCpFfOZTwhDO+qxwqeUHZuhEs8CGp4g5DOFJEZ9O3aR3EroJqA48H7KoRpmRIPYef89hUiP
	OgSUbzDDS5cWDH5QpMF6wG0VvIQLzVra6M0eC6TRgdALBEms/E7xGqBd6bSigv/h75v2GYsm7gE
	7EoGEMdRD5wasDGEAbqfMnUkdd/4CtzkRjlDAA2q4XLFZgh99
X-Google-Smtp-Source: AGHT+IGGPVIaalaGEXnZpDCIqt2E6rbMu+NvzCNol0RFWT2Q1ikoELaGZ/qbA2/kE8Zg2b7t2+yCpA==
X-Received: by 2002:a17:90b:2ccc:b0:31f:484f:7075 with SMTP id 98e67ed59e1d1-32183e6d968mr799203a91.26.1754604253711;
        Thu, 07 Aug 2025 15:04:13 -0700 (PDT)
Received: from [127.0.0.1] ([115.187.48.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccead450sm18919860b3a.54.2025.08.07.15.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 15:04:13 -0700 (PDT)
Date: Fri, 08 Aug 2025 03:34:00 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
 ath10k@lists.infradead.org
Subject: Re: Packet loss with QCA9377 (ath10k) on ASUS VivoBook E410KA
User-Agent: Thunderbird for Android
In-Reply-To: <l3iebypcyxpqxod5os3mn6465cwdlbnmlkbjnx3vu5bzyb4vhl@3dxnam2a7c2t>
References: <20250806204018.GA14933@bhelgaas> <BBAB0136-BB7C-4D59-B29D-2F35FC29D7AC@gmail.com> <l3iebypcyxpqxod5os3mn6465cwdlbnmlkbjnx3vu5bzyb4vhl@3dxnam2a7c2t>
Message-ID: <176B76BC-6801-4C3F-A774-9611B43ED4AF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks, I will update you guys as soon as I get the logs=2E

