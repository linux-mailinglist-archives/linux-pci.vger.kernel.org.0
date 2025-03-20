Return-Path: <linux-pci+bounces-24213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6172CA6A166
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C930E464396
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCF21421D;
	Thu, 20 Mar 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVFsZKVO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B0B20B803
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459407; cv=none; b=rnKRZ9YXmipyoegPzxHupeVeDQezwDiM1aDtcDCnqTN+aLyT5VsXkE8vnCleR15bva0eX88tpeY9Tb3C28YcCi+Ixu4cFXck3GHjRfIVhkxAViBq9mAvtyTehzE9uTLWyBntoM+vE+yFJXtch1dcbLNRgCUeNHdu/Eu0K6vEKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459407; c=relaxed/simple;
	bh=7OAxyGGLfGu20i0e/DvkCBzREKQ3WqBXkvKmPAlqRZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLf1iUHZe1SJVHkbCwCr1cBWKhOajhLggG0aJBJhK5wqRpDjA2masQeHa5YgssFwyxvHZxkm67QQkVdtDzuC9ETCKKKaGQNryfbMsYb05nm+g4BoJPdIFxERhRU/Sxl7khCEodgdi9s7za0G+s9zetOCIBdYCINkMy7zzganXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVFsZKVO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso890016a12.0
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459404; x=1743064204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OAxyGGLfGu20i0e/DvkCBzREKQ3WqBXkvKmPAlqRZI=;
        b=uVFsZKVOrRUzfryPvkHO4qvMpaisc78gD32ZRZOerQ2drI03Z4pr7U9HxfpcXF2uZd
         xS8t99SUu2YQZGZoPuw8V4bDK4RtCibkTj2hADo+XXd8rT3qKiSPSn89pllKNqIWs/8N
         HX8/M5YAkAPzDeJLXyhxpigknNPWnen5j4/ttWYJqCoqjppuiOWyzR0rlb433JPlyt5L
         1BQF3PboHDlPe/i5qvAHBY121ITSRe6RR+YSt9iaWriOZp8rVL08W3NrduiJUtxywQCK
         Iv6jq3AUTapQqfzbIaTt+c8da8Pmq2Hbvc2DcZW3ejnNNHsLKX94DuKvZTTaND++iaN6
         NWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459404; x=1743064204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OAxyGGLfGu20i0e/DvkCBzREKQ3WqBXkvKmPAlqRZI=;
        b=aCJMT7vDipjpfy93m2i8KkNfpqERC0LNx1YsyVmC5wtQU+L8FhG1DTmMFrLi9hIhB7
         37oO+FBqBu718U9CFJTH7IgTCsKOMr8A0IvO8hio0ZF5U0ksFUj3+BdRlj+tROZq7ZW6
         Ybdy7dFPnhLCsnDb+2l6nRDhZIkNGoZY4A58gnj1WF6rr7vkjDSYFnhB1bLkUy8VJquc
         lZI+Xy3rDFl8Xj8bYnm0Jp4tWyWxPtfXN/JudmPK0ya5AoveFBt/NWCLv0pCLa5q/rA2
         3gTRxTbo4Y/OVDr9GRW6ZdBDVYH5PDwjymc7mlUKIkHTgmEInR3nN8eN8sThvGVC3oTk
         rqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYxqgywLRonfSt5WXXOG1nSME2T2bHvwqHl2a8pI4+KDe6QpwKmakVBJ7aj9sSW6D3VFiV1Q5ZMBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOAHp+szoi7wDlycXyb94D+M4zEpXhGqczyLu3RXXD+19C6UQ
	AZEDyo+u70DgdfxMRBmhN3tTPO+FLXz0SEqC+3x7JuviTB3ewMtLFl/Sh8fUCJsmOsygOMV7ctO
	O48pWj+s1MmUX6CWG0dR8ZU4Ei2SC/P/Z3kn/
X-Gm-Gg: ASbGnctA8eSbpRBkC1OpmnhvKWqzpCvfEU7J6dbnvU3PNDebrFXt3+ynOWr8xDfkGEV
	1uOBC2ijyF/UUs9t1PigI/9cd6U93sJqHVEPSUJnIZ5p1uQmuzBu1dHYEFKtB6nq0ItEqaXONH0
	P5w8XWkQPUKH6Jjnlae0vntV8=
X-Google-Smtp-Source: AGHT+IFamuQQoM5Pph2ELP5pw3eWhPtFtanEl5l+3nX+sAdIl4kyeMnWavlyAlaeBvBqP+vKJm6bmcH6XpXfI1MyJdA=
X-Received: by 2002:a05:6402:1d50:b0:5e7:8501:8c86 with SMTP id
 4fb4d7f45d1cf-5eb80f7347cmr5537703a12.22.1742459403408; Thu, 20 Mar 2025
 01:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com> <20250319084050.366718-4-pandoh@google.com>
 <9208619f-5640-47f8-ac46-898894198499@linux.intel.com>
In-Reply-To: <9208619f-5640-47f8-ac46-898894198499@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 01:29:52 -0700
X-Gm-Features: AQ5f1JrhRfgXdrEXpM-p0E85cd8AmB5fuOsab8n1hFye_1jjGDsnrAdc_nJkUwY
Message-ID: <CAMC_AXW04FfaVKYLc+h1kjRjYUrxqA97kLXf0z7shpS1k5O=nQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] PCI/AER: Move AER stat collection out of __aer_print_error()
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 8:23=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> pci_print_aer() also seems to do more than printing the AER stat. Why onl=
y
> care about stat collection in __aer_print_error(). If the motivation is
> to just improve the code readability, I am not sure it is worth the
> effort. Please correct me if my understanding is incorrect.

Bjorn had similar concerns. Hopefully my response[1] answers your questions=
.

[1] https://lore.kernel.org/linux-pci/CAMC_AXW85x_LRT5UTD0C_VvK8WTG6kbfvp5k=
_7RjnLzGM3Bg-g@mail.gmail.com/

Thanks,
Jon

