Return-Path: <linux-pci+bounces-21323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C44A33345
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E46188AFBF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12172063F4;
	Wed, 12 Feb 2025 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfZuJl/G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B351FF1D6
	for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402429; cv=none; b=sq7ZUPUudmqKsVjhzPoNJ4rryvSmmhnUiCqfaDQpXW1qbiGXTXjecME7OjqCOpHfTJb2jrTKrKwy0hz6EBt9zWyiB0SyQX62WFgLFVSTXVDWAM/B6hM6CbTtQRxovgT39cIfM28qORdbVuxu3sJiXdaFqmOEVZI3o+MrTrWwxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402429; c=relaxed/simple;
	bh=cSVnAf59UOPf1jwwMum2JZ8pyiM0G3p1u+5Z1eDAfmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdVIDnFl1YawX8HDyl0vACUHrMH6WF3OQj117LpV2sbkTNHsFHs3XFNzsmMape1XqDBkXPJYzjCXfV22409lN/YEf+MxyQ7LByrUF6y9ZZp4fXZPWD22CPL48zFBR2KJ0QUlHLSpRCVHSxOqJA4cTLbgues7JQT7OqUTkGDcXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfZuJl/G; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7c6fc35b3so35566566b.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2025 15:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739402426; x=1740007226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSVnAf59UOPf1jwwMum2JZ8pyiM0G3p1u+5Z1eDAfmc=;
        b=QfZuJl/G+KLmxNQUd0It9yzxQBapuy19yjIP0SUJVgqLeAEC2KF9FSiehZxcN2HNR4
         YZNDzE5DHwjN/b1bvs44wCiBzDOF3suVIKy9mGDfFFhDCPF1zpNhatlc8q6fyzQQunLe
         UpbSfh9rjBGesGN1Bf9/kY10AMC6p8Zs4tbAydotygntwIC7gxYPqEDRM/HpKX700ef7
         Cjgxjpdv1Y62peG2T9NL4pXBYn0SVf+O2WWL8kS2KcdOg8xchmzNIzslLhzTI8krSneB
         T12MdJ3DIan9+FVWnWFzXNBC7kkNcQ9C//kKWxiMrQ7dYlWWMr5cTDyuCM0EBDXOy+6+
         arEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739402426; x=1740007226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSVnAf59UOPf1jwwMum2JZ8pyiM0G3p1u+5Z1eDAfmc=;
        b=ubjlzrMw1huDYNdON8Jg1HllQnsmuYQf9ly3X3LmhybpYW6MCN0XuH/jrAm62cvVlg
         KuKlYUx5CjNbiWxyN1xwdDXjvIpqkiXHa8nZpTENVoZ2NtaNLsNxEAWFZMEXWbc3nFvC
         59v7OdT079sGifDauHf0SH6IWzCzCrdMIuI9jbfwIZz2SaSJC1qkMY6EC14hCmvYPwIt
         eu1urLrgU0+c8i9hIzBm40sE8GybwR0ks1sapQEXXIRY2x8J/RCrPgq+GFJTXWuSDyb1
         H5CyxVeNak384zwYd4u04sNDYXpGHUQNbYg87rfmQptF4tvvQQaxo2Ba12pXic+WrBpN
         9hjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoTNbfJY/A3INJwt0Ty6wcgmIBq03JanePSmUeca2i12OxJczFX45RNHxT8rGrB5DNV8zScVWizso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5YaP5kvm3LhyrQQ2VuQA8WKiChEZGoJ1Vhixm3hco2wKdRJg
	dD/uqvX4DyvD5B+GCMRGLE6fXRie4/H2rdh+81eEZYdiKXBA5er0zh3GD4Mc8eVvRmEdmbm8kIX
	5X8BAAbJ7Gu9eN5JgHIXM593aFZQEbSGnG5K2
X-Gm-Gg: ASbGncvT+YI2njzEEp3jZY6vYH7ASMae8kdJf2ULFq0QRWZlKKQ2v7TgB+bq9U3Ylg9
	QWSfX3kQc36f46uwl++R+rmdlMWpBXCMOhWOhM/J4RRAGViL3x2f+U47U3PuMCCTiaxOI9/qKkd
	1yDjdbuPLN5zLChfBaqqgmt8f7WW0=
X-Google-Smtp-Source: AGHT+IEDjlW6rn2w5Lvmj3FAH40z2Ff32OexFGrillh4sx1dISp5Ve8w6GKitVeDGqp5QZDbZNl72QpmKsEmvjxhVow=
X-Received: by 2002:a17:907:35c4:b0:ab7:fbb2:b47c with SMTP id
 a640c23a62f3a-ab7fbb2b6c7mr233689566b.35.1739402426374; Wed, 12 Feb 2025
 15:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-4-pandoh@google.com>
 <b04d2fc4-6b64-4d44-9af1-31e05918e196@oracle.com> <CAMC_AXUKSSYjRr39E-DehvpfH=b2eYksVwPVZ9BXSNMSU5bUrw@mail.gmail.com>
 <12d24891-c32e-4a84-a6ee-4501106a6957@oracle.com>
In-Reply-To: <12d24891-c32e-4a84-a6ee-4501106a6957@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Wed, 12 Feb 2025 15:20:15 -0800
X-Gm-Features: AWEUYZmWnC8xF23V6OiJzAX8OjZJZ_nGFfCq61G1BeFiJ3pvyF0IbVtRVJXLb2M
Message-ID: <CAMC_AXVsXRYi=Z7GGRuJB=EsheVy4sfkdEy=7_qSt_gM0Ftiag@mail.gmail.com>
Subject: Re: [PATCH 3/8] PCI/AER: Rename struct aer_stats to aer_info
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 2:13=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> Like I said, my preference would be to leave aer_stats as it is, but if
> we have to stick to one struct, I'd go with "aer_control" or "aer_report"=
.

Will change to aer_report in v2.

Thanks,
Jon

