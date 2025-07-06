Return-Path: <linux-pci+bounces-31587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7219AFA838
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 01:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649E4178D7B
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 23:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE7F1B0F33;
	Sun,  6 Jul 2025 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5qYZ6di"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949521311AC;
	Sun,  6 Jul 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751842888; cv=none; b=MV1NiZbOri/4Vrl0TUV2BKIG1EZnt7/ugN02K6gnSVlBs8RqL0RVrPJZlJ8N14mRm51yHYyQ2VJ/jxCg+mMN6dQ6rY4LNv4C6Zc6Hqt9rmH8Mt1QQt5+dTMuZLaweNhxPaDneizwpMxZlwKWerSRV0cI37A4TRgBbKmo3uv/3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751842888; c=relaxed/simple;
	bh=zturyjfI2N9e2c/AG3k9CJQA3JKr2kQzkhiHb/r8Khs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=squDh4mt7epzmptZHIzWYuIPlAI7qCAiRM/OCxvcVs5WjYCzxMQF6z+d9Jc9WGtwxj+TnFuwNUcvuUbOy9DN+uXooLml6OQ5/uuImXomQN2gcwpb9LgvrCjlbaELQBVhnoFJPmhgLOn3tnZCRYHJ9PY+TRT2jizNp9NmAa0OVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5qYZ6di; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so1928304a91.3;
        Sun, 06 Jul 2025 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751842887; x=1752447687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zturyjfI2N9e2c/AG3k9CJQA3JKr2kQzkhiHb/r8Khs=;
        b=Z5qYZ6diSUDxsKgALtcCuflZNpLxK2c/Fl/8uJiocyWKYLq6wBmlkyHICXpcU+xpEW
         y0VvrR1sc5LZwodW46Qig0gG/h4fm23NxYMN4fXkPauB2HAf+FnMm/re1jX6JK3PgT4D
         7+EB99VBgyPP3Q8tW/dOzLOPchYUSvey6L0ySzWfSWEr3gm3rk8qaR3Gya3FVA/nW+aL
         1XFlpKUo5n2pblBoQbA41qR26yOWYoK1H2b0FXuph/LVHYVlDPAmGwcojfr7KRbnJESR
         LFIeQ/jM71vDtP3RSAn08UH1EsWLJkssi8RTqCwCSGg51JFOrkN0Or7wAoA+tSJWtXQj
         4mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751842887; x=1752447687;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zturyjfI2N9e2c/AG3k9CJQA3JKr2kQzkhiHb/r8Khs=;
        b=ssnysp+NOfxptx6bDaCqcXr41I5sZMx+9q5dJi7PS18XSHa8MCRKJUuvCWwjdQRHa7
         h2yzLjTx35CqpXlOHXuWe7uKpoalnuotDND+EBYHB/+UPKdUxmvFEmAOWxTfAY6HK6Mo
         oTfm2WahdW0MSpfTDcDyAZvM5KxLilN491kK7TNjv6W4tVGD6MZ3cQJ8XKRPWPmEayw/
         g8lWH2deRkOK4w5nWpb7HqF0DvsoIhxmt8DtbOW2MT9VIdeXV48knJ0wO3re9Sg468FV
         BNbL6J7cx7B5hHIC/BsxfCsXr7itAeDFpnyM6AHpAJZzu1SeXhFqJXDZ4ISYXNFeDen6
         dSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhtRM5V8Z2CIplnweKlpCycpoYHjbdg4CN/3h84bYfttpxcaH2m04UzakPASPrWEosNpD/nlvs@vger.kernel.org, AJvYcCWFp/yZqABGTBUj2q2/UJ1kYcqw6dRgNTYAAyQ+m+vXPYJRCbKvqLSWjPWWSeZJCGPWyfLEU+v6olnP/7oFYKU=@vger.kernel.org, AJvYcCWpmJvRiSkUpcyMMuJ3ZIo0QNcFKsUEM6eQ8UrKIiMZKy+uIWkhWS3GJmsRSKNdKHQHs3d1l7W/0JYs@vger.kernel.org, AJvYcCXwBBxmeV67uUMP5JtRdSCgbWARx0g9fRMekNVUwDtkC3xA/dy6S4RUye94pTwly2Qh5L372TXk9JG+@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMGKFxoZB+3KIOqGR+XY8IrIS51kEMepkIOaUY8ApZl33bFF4
	wrolJlhFQKAn1gNh0tlPYQ3GiHbhiXIhuy/tNVkm10q4Ont02Xp4e/a1
X-Gm-Gg: ASbGnctdZcbaazlmtF0e/4llA3DrfQSunPF2ECA56EUrOUmqgELLNoFFUF0GPj+1cdl
	ivJ7JvB6MFIYy+KubqbhbM2XQZkQbqkiZTP36Hs9VksoWLhGVPF6/1/9Cow0GjR8qe4Gz0unKhl
	QUscEE9AMn1L91j+PFbd8gXi3rBpNa2g9dyr6Nx/No8wg9GY2yp3ti3S98iy2AXwFY5fJ16SyYl
	pZDiJIk50BTrVz01cgNCUPaWj3UVB+Q5nom9RRF71aZUkNpnXuo9gLDaO2ndGgjIeitPHIdEuKj
	pfmAV+gDJrODmZKNKt1V72iI6LTDykmftjNkM+77xIUHfzHLryT1rnp8NIhf/Uw1rG+P3gk/x1X
	pWGw=
X-Google-Smtp-Source: AGHT+IGAJIAPUxPwiRpQD8RGqbgSJ3Srthut5cwID5L28xg/vABhqLkk3Ayb4sm+d6UnVkJoYDakGQ==
X-Received: by 2002:a17:90b:3ece:b0:311:c1ec:7cfd with SMTP id 98e67ed59e1d1-31aba8d323amr7588550a91.26.1751842886617;
        Sun, 06 Jul 2025 16:01:26 -0700 (PDT)
Received: from [127.0.0.1] ([116.206.223.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431e1b0sm70869455ad.44.2025.07.06.16.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 16:01:26 -0700 (PDT)
Date: Mon, 07 Jul 2025 04:31:22 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Instability_in_ALL_stable_an?=
 =?US-ASCII?Q?d_LTS_distro_kernels_=28IRQ_=2316_be?=
 =?US-ASCII?Q?ing_disabled=2C_PCIe_bus_errors=2C_a?=
 =?US-ASCII?Q?th10k=5Fpci=29_in_Dell_Inspiron_5567?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250705195846.GA2011829@bhelgaas>
References: <20250705195846.GA2011829@bhelgaas>
Message-ID: <9D9D9375-1BD0-46EA-9E85-47A2D8325F98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

I have downloaded 6=2E16-rc4, and I have a bootable pendrive having the ar=
ch iso, but I really don't know how to rebuild the kernel on a bootable dri=
ve=2E

Any tips on how to do that?

Bandhan

