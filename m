Return-Path: <linux-pci+bounces-31483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7DAF845B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 01:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2DA5622DC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477172C159A;
	Thu,  3 Jul 2025 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoVqakLO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FB1C07C3;
	Thu,  3 Jul 2025 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586141; cv=none; b=AXO/VqBnTe8Y/4pqPDQbK+hFPpT7g+0PIB5x5hfRyBLALHMC07WCTZMAaD9pUenMQlMw3ztzDKeeVcy7HvE1V+QG4JD7syE87taiazqVep8g+2D1txc6UvxjYKi+WIj6jyzyERGjNVwhWHhYST7oIpbS7wlgqDMQ3NbMcoqCdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586141; c=relaxed/simple;
	bh=lhR4RZPnwwTUQfyli8yukVHymruSc9mB3XDQlwCPzoM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GN0F55aTi5ntTHN0PDB97AYQJcdMvEhf1p9kU1h5q823eL9NlXmrt2FUwR18dGqIoOW3c6QT42QZnJxuhycF730cunzB9g4iZ0clXIZoAnlSUIZsn+x/yFcN+51fq3De7Or+vVYcu6A24/JjeUb5sYO28rSY6jr7mU8K4iseWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoVqakLO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso348453a91.1;
        Thu, 03 Jul 2025 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751586137; x=1752190937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKNinWMj37vCi2UqRrU909/WDXj3eScieF7WNVO/swg=;
        b=MoVqakLOxgy03J0BIArfgNbD2rFUJrBr4W0Lj715KPuUpbVAj+ZHE+ZCKPvojQ4zxi
         Uqu6XnTrorCSvnO4fckuunJGxvO/SaTQR3YPD54hUsNWZvq7JcskUWqzIvRnDlHJADPX
         7h/mhpTJZ1ZhF7szOWpvpGw+LoH6WT4apa75nSkSn6tbaQ0mNPdZuSMvdmMR8Z9sBvcv
         U41IQn6scHn0mX+34hgjgRc1V/P0tEowSPW1FGllPeQkG71pcdDYgBUULjjNERqENJLK
         38LxgRC3ZkGJrAtHEAbSd3Hif6SUcraGNt1n/zE4pC1QflRvG0dBc0u3fJD3Zc8W1B3e
         q+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751586137; x=1752190937;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qKNinWMj37vCi2UqRrU909/WDXj3eScieF7WNVO/swg=;
        b=VGx5c2Yuf6pIShZfpyi4iB8x/r0CfOg5+FGHUYbTj7e3fXh2bnLnrDxOik09E7JY/L
         R7RppcrnuRgr4PI0HslZpkAjhyMnPDhi3eS6jj+SyFqMZw+6czcamC/njm3QZI5C/PGP
         OriHkCHLGWKsE8YmJBhpV5YVvJVQWtQCKbkEvPmAKVoY2+1eSTpcrF6a2K2exfbyAl5P
         mUtBlWw4007EenuxArNDDG8Ri5YlWoFdpbB180LuD9XgAQbW5hB6kpmmHC7K6J3x5/2M
         AcagS0qQWdaytfzPqlTyUr2DEPVJ9yelDu991jRXBZCrsEVD2ERSQ2qB/it5KURMZjd0
         +HqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3fqqZrZWvbTdREmZLlYa5uPIuw9DbzzLZkp2PJPiVjW985nDTj1kf+SFpuPe6xdVfqVvcZJTpgsMI@vger.kernel.org, AJvYcCV3KD7pQjf/dK6qQGQReeL0LiqMXBDfbdvNXkvt51s0fYPQlfBPX2hY3zpYAfcZvxNe8q+5YUcQIXTtePNc@vger.kernel.org, AJvYcCViIJ3mzGNiZrRQG5n3T4ODtZ0RYP8+kukKo/3KOULjgQCdECr2J54+queFlY0Iqv5tp9mpXB3xX0E9@vger.kernel.org, AJvYcCWE3vT8sSPxbKAnrDQoqfunbeZW/iaWj4Y8C0CruGosDD4rGNNwOUALa6H3fgLKkYcxV7P+9dGE@vger.kernel.org, AJvYcCXVKFhi626QLEOaRC7GrvQKVsS8t/XegbTUp06tOD1K51mALdMvHe0CMRr+xo4IFc1s1zUuS6xcrnu+jm0oeSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvMngCyZAXeRA/YJe82r8QdMVQMZFJ9xdJSc1wvP8KlensPvoj
	ouwmnaswgRQVDyILgAJUgzzwTw48sSrtGT7V8OPEBlu/FKInUeF9l8Gu
X-Gm-Gg: ASbGncuBCXD43xUHzRq+AJHRFS3/1k3l/wphvFBCWibufRScUJNjUsxVURFuMWJN6xX
	8wZf9s+IZ0ZoWlqHIKYoItSbxAu2dhsyA17bwcoPRzOMVYRW6L7SYDui4Jpw2wqKIlfb6BAQyHg
	eT5PD5p0EvmzdCvO0GvAVuaNb9SwUGrDO82vbREp7DmWBwYDFbEPJZxB2Amky/3FA9RSDj58jgB
	uHbccOAs8jbJ+Q6CmgBmLdI62ZRfpCZ9g4/d9l5HYF7DqPP87l+J/uwhnTJk/ftoU3kkfXxDqre
	2XCxWqdHkmdICqnWidsDbk+dQtmkSKNpAY8ImLmHQHeoqXUjmrv8mgdn+zL6NjfhlXCqHf6u+3V
	PEEQeiE4I6EZ4I1Vf4vfkVtkAQ4yUz1mMiFTHTM5a
X-Google-Smtp-Source: AGHT+IFlCPvcGAkGD2bjF3k+rTOckARCfwGn6FP1B3780U9Hwhe3ozJbspQZY9UpgTuMJ228GOqlXQ==
X-Received: by 2002:a17:90b:3d43:b0:311:eb85:96f0 with SMTP id 98e67ed59e1d1-31aac53b7ccmr728829a91.29.1751586136990;
        Thu, 03 Jul 2025 16:42:16 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cd09a27sm3301175a91.33.2025.07.03.16.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 16:42:16 -0700 (PDT)
Date: Fri, 04 Jul 2025 08:41:59 +0900 (JST)
Message-Id: <20250704.084159.887748101305692803.fujita.tomonori@gmail.com>
To: dakr@kernel.org, ojeda@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com,
 gregkh@linuxfoundation.org, rafael@kernel.org, robh@kernel.org,
 saravanak@google.com, a.hindborg@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 david.m.ertman@intel.com, devicetree@vger.kernel.org, gary@garyguo.net,
 ira.weiny@intel.com, kwilczynski@kernel.org, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lossin@kernel.org, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 tmgross@umich.edu
Subject: Re: [PATCH v1 1/3] rust: device_id: make DRIVER_DATA_OFFSET
 optional
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <64cec618-b883-4330-b1ba-5172f7790fe3@kernel.org>
References: <20250623060951.118564-1-fujita.tomonori@gmail.com>
	<20250623060951.118564-2-fujita.tomonori@gmail.com>
	<64cec618-b883-4330-b1ba-5172f7790fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 00:15:19 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> On 6/23/25 8:09 AM, FUJITA Tomonori wrote:
>> Enable support for device ID structures that do not contain
>> context/data field (usually named `driver_data`), making the trait
>> usable in a wider range of subsystems and buses.
>> Several such structures are defined in
>> include/linux/mod_devicetable.h.
>> This refactoring is a preparation for enabling the PHY abstractions to
>> use device_id trait.
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Thanks a lot!

Miguel suggested that splitting the RawDeviceId trait might lead to a
cleaner design, and I also tried that approach [v2]. But just to
confirm ― do you prefer the original v1 approach instead?

https://lore.kernel.org/lkml/CANiq72k0sdUoBxVYghgh50+ZRV2gbDkgVjuZgJLtj=4s9852xg@mail.gmail.com/

[v2]: https://lore.kernel.org/rust-for-linux/20250701141252.600113-1-fujita.tomonori@gmail.com/ 

Either way works for me.

Sorry Miguel, I forgot to fix the comment typo you pointed out in v1. I'll correct it in v3.

