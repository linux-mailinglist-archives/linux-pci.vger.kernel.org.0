Return-Path: <linux-pci+bounces-31740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA803AFDD3D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 04:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B823F48842E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BC919CCFC;
	Wed,  9 Jul 2025 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hesbc0OJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5092819C560;
	Wed,  9 Jul 2025 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026933; cv=none; b=CMX/MBDMAChKtDKhydWHns0w60ac+TD47rKNzWTrfDtNrmVRriBTRpz2TP4cVpyQqe9ne7kiOniOCYEWfIipUMrDaYnDbinD5AP/NqvT0P/nLY/idX2CF0HpUwShh0ajSPBddrYVKVFSjSF9jqZxDIVXzBmbPtv3JJmaXTIMkI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026933; c=relaxed/simple;
	bh=nXyAtH6Vo7+g/t59WIVyfnKJNBstAuGXzSwl60CYMv0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=C5D/VNed9wEg62X9ZJOfTLa1hA6mn6ZIcA1YEH4roakb8MgI/rL1FgoFi1N8Cu1s8jTfsh327uisZ21kAm5rIlvmCXRJjGSRRqusoo4zDbOBrLn1FrFpVt6pAZC4FKLoHJey9L7rgL1WZUvSl9XJEDnQTfrot9xTsmRTdGX4cxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hesbc0OJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e378ba4fso6029247b3a.1;
        Tue, 08 Jul 2025 19:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752026931; x=1752631731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/VGVZYtKjF4c+B+6eYx3LkCKFL+zh3OLRh1/+MrNXE=;
        b=hesbc0OJw5ofjmkxeXCK7TMeuN7gkR2Ai3RXz1PqPGB5+B00TqP4EHDBh61Omy++4J
         dDegZwGImuLbRewV6d9b4Ux2sGSvOk+KyOye2T6kSHHVbxsVlyV5ARSWOk3jYdej6+9S
         wsgER5mNN2Z2aDIOKagvGP5+kvfqK7azYIUPum3wb4NQ24Pen+aBJwOVujEaybfaxKOu
         4LyeHNHlwYpGfd211/UZDyAPU0aCQ1WjKXaqzEZo+EThgMElbYGU2TMELbWpXuoSZs7t
         xYPwdbFrG1c136Q136eRcHCrNEoBYD9Pma7MX/qbHG/m8F6N7PlKb1b5qYUEYNAy8WDw
         GN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026931; x=1752631731;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s/VGVZYtKjF4c+B+6eYx3LkCKFL+zh3OLRh1/+MrNXE=;
        b=xDYSaW+8nR7MtbyEF9a8nyAWFnD7CxSZb39Y08h1w+rsgB4+m3jgAn3uCSnX23kukS
         lEAnI/g102niJveIyDdK4tUFwErE0zZtFaXmltShjRxkesVRV+TFQOsjfZXnTaKNfHRh
         kELyOJ7WYmcpTX1PnYCNtXcTr6++CGlniIRyKE7IvlDIml6P1+6VD8F7r/n07YDTsTmT
         v3tRIx+ImCz3vN3/T938YoFPMWho0lihhAiiXSy8kv5tXnBa8FvfBIf1hYfFVonHIxCS
         dsS98yKu6ZauqoZ5+uAfQOFvKYU0dPZeCXTcxrMcy1bABQngFAEHHChFxva2dHXbBUAi
         z/yA==
X-Forwarded-Encrypted: i=1; AJvYcCV+GFcutsK86+IJouaj3vw6yBhx2FWkBRBUvSm05kIAcCuDtm8URD8eLD/VSdWsq0qROIb8n11Zh/fJ@vger.kernel.org, AJvYcCVUTK3hXOcSuUt3fU2WSDP1YnnA6QL2D7PvCHnOre2fsri94owckyUUzNNXDa9laU08XOy2Ms7c@vger.kernel.org, AJvYcCVyepMfCFqYeDVfOcf4+J8BYa2KQg3V4Fz4NcN+zt2zU5jsL/TQsXo6qYPpjbly+QzRJVlpjawTF0zuLRaD@vger.kernel.org, AJvYcCW9CAEAX2WxlhOFpyiCAOxBNNwkbcm6dKwrGz+JksV6Fo2d3ANh3rUPRswHGNu0KIDRcymLKylZujFA@vger.kernel.org, AJvYcCWFksmt61YUU6ZM4pyjZ/eVLZFAcRb+cU1VcX+63I5CE519WOlg4ecKCdKMPZouLdFxn4HGJogL5S4mupxFbOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymRkPOkozOeDKQ21gMJOtER26WypbYdKugCQWM4kSomWuslJzU
	LNKCaGazTuItTvzAgLBGjAtHPlvDANZ1AsALvzok4eEBVaoid67QxHcO
X-Gm-Gg: ASbGncs9aoqaivuTSZh4HTX5HxEay11+OGUX98aJlwwi8GoBJoznNg8CLR/d9iydxxA
	GTAGMOpGy8mW2s0UHCvLhCBsVE6bqV/Jtxj2wmywjFvoJWwxFDPxkLQXt4vToDIvrtS0rR+Ghng
	44CAVUHaUdVYoI/WmQk9UIvxegDgUiV+BnuTU3Y2smJtwb+4xFVIm7lcSnGz6Ej3JKSgGluh/5T
	+IB7G2mfa5FUdrBOALd5e3XTB+Z+XG5f9A8ch0/BY/EBXoY1CnJZlxxr+GCRDuvPtzWfpOFbZ4v
	vHw8TudY3w7TEAdpTc2E73sAfAHt3sl8MraiPU/npNHnwznMg7znc5YXIptr73SQch0MiWF4YT1
	HNG+bthzrOujYQkWcC+23q5oVPwT3Zy8fBjOgsiOn
X-Google-Smtp-Source: AGHT+IEIGSf25dPNswTvM6+TAL0qEe4dVXvWaxhtYqydnrR41gGNmbufL14jJTenr2yiaOEFprn84Q==
X-Received: by 2002:a05:6a20:431a:b0:226:b3f7:6797 with SMTP id adf61e73a8af0-22cd68c7667mr1053625637.12.1752026931394;
        Tue, 08 Jul 2025 19:08:51 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cccafsm13502599b3a.46.2025.07.08.19.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:08:50 -0700 (PDT)
Date: Wed, 09 Jul 2025 11:08:37 +0900 (JST)
Message-Id: <20250709.110837.298179611860747415.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: miguel.ojeda.sandonis@gmail.com, fujita.tomonori@gmail.com,
 kuba@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
 saravanak@google.com, alex.gaynor@gmail.com, ojeda@kernel.org,
 rafael@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 david.m.ertman@intel.com, devicetree@vger.kernel.org, gary@garyguo.net,
 ira.weiny@intel.com, kwilczynski@kernel.org, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lossin@kernel.org, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v3 0/3] rust: Build PHY device tables by using
 module_device_table macro
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <aG2g7HgDdvmFJpMz@pollux>
References: <DB6OOFKHIXQB.3PYJZ49GXH8MF@kernel.org>
	<CANiq72=Cbvrcwqt6PQHwwDVTx1vnVnQ7JBzzXk+K-7Va_OVHEQ@mail.gmail.com>
	<aG2g7HgDdvmFJpMz@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 00:51:24 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

>> Since it touched several subsystems and it is based on rust-next, I am
>> happy to do so, but driver-core makes sense given that is the main
>> change after all.
>> 
>> So if I don't see you picking it, I will eventually do it.
> 
> Checked again and the driver-core tree makes most sense, since we also need to
> fix up the ACPI device ID code, which is queued up in driver-core-next.
> 
> I also caught a missing change in rust/kernel/driver.rs, which most likely
> slipped through by not building with CONFIG_OF. :)

Oops, you are right. I mistakenly thought that CONFIG_OF was enabled
because kernel/of.rs was being compiled.


> Here's the diff to fix up both, I already fixed it up on my end -- no need to
> send a new version.

Thanks a lot!

