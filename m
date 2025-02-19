Return-Path: <linux-pci+bounces-21783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D2EA3AFC8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 03:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE773AA660
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 02:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44547191F72;
	Wed, 19 Feb 2025 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+R6mxyn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46719007D
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739933318; cv=none; b=ZJKhBk/HXde54fQEy+9P4fiA6zs/5cp4nA5XS1Arj8cRal6gjfq7wvgYnqvZIOO3/gJjCnZHAHokYFMj4XoS5gYaeMri/Yvg7xvVi5/83RAIIOnE9X+9IOGEfn+wtx9N6eSljr6LLKtW63Gqvof2M1qVYv/5KV2kT9Eo1prCdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739933318; c=relaxed/simple;
	bh=whNrgrV3i7+5zOOXKm0Fl7LCINpbZPBvF4e0Ljc7vtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw0cjfjGbBZRkqE8oMQw/ek/dz+WLyLMgWb4aFsgrlrxk7szIsDw/ySHKSwXI6cSz3o1PxeZyBw1nmoPr7jFEyeUw5L6c8QUBxIB1twoZ/PmaxyRok3Ke+RdMv7oQRRgUWhw9EBvnVl8yXNfNw7hGRCQjt2GwM8pRVsuccFB2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+R6mxyn; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e04f2b1685so4353565a12.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 18:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739933314; x=1740538114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whNrgrV3i7+5zOOXKm0Fl7LCINpbZPBvF4e0Ljc7vtw=;
        b=l+R6mxyngMt2du6RrxkbEv+qMbOnY1eSsP/myIwUSRfr6G9pgrZoqEe78piYoRsFFQ
         F2ljrYY8p8Ecvezy/MieGscQ0wCXZh4yrzzENyKRo+9m5uHLugVB7IaaKSKxZbbeduT3
         fIITnp41j4pU1/tF5nIO9FRBR696YAnBz6yaikVG1ZnPxflKkuIhJYjBQM9PviPEApPz
         6u6mKSOJH2IJJxmGgOfZHbFBK9uoM7urA4YAsGGX5AC2iMprdr5HT3f+QPMJYL9X7l4w
         Yx6fk851NeLHBv6S41y1zC4FO1LfxLEpMlB+1165fCk5y2+k0FZJNDA9yDoZLvx5H0k4
         3pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739933314; x=1740538114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whNrgrV3i7+5zOOXKm0Fl7LCINpbZPBvF4e0Ljc7vtw=;
        b=lJT6WEIeQxvpHW03VV9vii4gm73K77t0Q/Jrxt2vDeocJCtEZUHPebhebi4GOr3yY1
         LmQtO0VYk33JerEv2Cx0PWR4ALuRGdTNpm7q6dt/KbRpjEueDwRC0LfDsAjG2GqTqE5u
         tKSNnzwRpspjo7xz/XIMPAJ0qMS8oQmjzQvYjiY81X/FVlS1g+1KceCf3AkkHlodltIx
         Y/fVDaG4nUJS6VVKbmQD4i9omNulG26v0ZJNNDIC0MOTnleM6lJlDKC6tIPBAM/xeQkO
         /qjA24wOdMOO1k04A/bzfEABsqloOP7tZ78PngSInAcvkDeA14HBXlCha3TcvEMIwAPI
         plrg==
X-Forwarded-Encrypted: i=1; AJvYcCVzwkreokBscVaxuj+2Rx4iKflnTqxbfD/rel3RdIhYelHfHRyiQ71pfwfe4KAEkay2kddY+SmDDGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXJ1Myg/dUH+XeDH3Jnap6EcivAxgehmUAhnPzv145pFy0OK4
	Zwg4XK0pFx3jG2K1ROWZ0pK2jHPFKBnheDDj/ZiOj+6LyaYBZ+JWVgjQz1YJK7Z5nCGmSGfSRDs
	U/pSAg66JcZiJqCA1QjQidg/Ab4ilyjMMBMlT
X-Gm-Gg: ASbGncv4k5NK0z9uJD+DEs8OmklEVM2NgotiEBvViPDXSXvhMrE2Ae39wHFfFOEaK9d
	O/mfmoO3+HhacVosFFJo4AIxngNyO9C21w0g7Ax39H2Fj1gQIGDcOOc6qKD5DalSmVDBo+MnUxd
	DOoxfC/wecWzF1Jl1joXCBV/XBM6A=
X-Google-Smtp-Source: AGHT+IEuQQASBsUaC+lpsQxUZiHt3/hxUDEcrm2Ks7E+/oz362q868epXuR9KYRnXFiHjyU4nLRqtrmrmnj8X/X7FQ8=
X-Received: by 2002:a05:6402:3547:b0:5dc:cf9b:b04a with SMTP id
 4fb4d7f45d1cf-5e035ff9d49mr34171058a12.1.1739933314551; Tue, 18 Feb 2025
 18:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-1-pandoh@google.com> <20250214023543.992372-3-pandoh@google.com>
 <8e94ccbf-497b-4097-87a5-761cbc7c205d@oracle.com>
In-Reply-To: <8e94ccbf-497b-4097-87a5-761cbc7c205d@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 18 Feb 2025 18:48:23 -0800
X-Gm-Features: AWEUYZkdRsKvV4tTrdxX4Bm5cyoLRyDY-YOdJzkw4dv9ELaTfQqVTxVTqAubNQs
Message-ID: <CAMC_AXVgYegnfc-vyKuxZS-Ck=aCJ95=HqdYNraVv99kXxw1QA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] PCI/AER: Use the same log level for all messages
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:25=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> It seems that the printk's alignment is wonky after the rebase.
> Checkpatch agrees with me here...

Odd. It passed checkpatch for me. These are the commands I used:

{Kernel home dir}$ scripts/checkpatch.pl {diff (e.g. downloaded from Patchw=
ork)}
{Kernel home dir}$ scripts/checkpatch.pl -f drivers/pci/pcie/aer.c

Maybe I'm not using it correctly. Could you paste your checkpatch
command/output?

Thanks,
Jon

