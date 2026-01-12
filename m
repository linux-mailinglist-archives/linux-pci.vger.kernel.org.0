Return-Path: <linux-pci+bounces-44554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE8FD1534E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413D53009A81
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 20:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD26332693D;
	Mon, 12 Jan 2026 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPBlMgcY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbBRSZu6"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFC31326C
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249502; cv=none; b=P3civxf2TkVltigvBsx+O6poWiUVLkqMKCt+KCYg/iLrimPZ73u5FGA+jVJasJkL16KsyJ6qvzyT0uskgJF8aaQ8iaIEeUSe4wsPvs9wwlfW95XCpzJx50MKr+Q/PykRfp7G99NPU0TFSN89w96fEM24Sq7defOakZG6Vf6Bb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249502; c=relaxed/simple;
	bh=/dklBrNC9dtNwtEkW3+1FasmVEQ+IfE0nrDRIZz1Bd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRxI6D00W21NN1DbCxA4bCgyJ5P8+iHCiptJMl4kdQ4d7PEezNZ8FQBp2bSv3VhkqSOeYlENp57TROoVPuyyciowyCgJZb/z7+oE4xgSy5QV/iYcfjHC031y1m5wpzpv4vZL4ugSCOML4GvNkFNMKDdKLKnHAJJXw5LqZh5VusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPBlMgcY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbBRSZu6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768249500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dklBrNC9dtNwtEkW3+1FasmVEQ+IfE0nrDRIZz1Bd0=;
	b=YPBlMgcYR1AhxpMC2c4AV0lSSr2rSnkBR6p+VuaUf0WCQVyOG9ba4cIpLYkrj6u2dLkNCE
	ojX8sOQaSyO6Qylltc9iu2cA+d0uc3a5ed6lzzK4pIJFEBvO1mLteq49SnRCauAYk/doAw
	iVX6BmAeimlpUD++jrtRkuOuUcoVEdI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-8aSEOndJPoOsCD5GaehBsg-1; Mon, 12 Jan 2026 15:24:59 -0500
X-MC-Unique: 8aSEOndJPoOsCD5GaehBsg-1
X-Mimecast-MFC-AGG-ID: 8aSEOndJPoOsCD5GaehBsg_1768249498
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a316ddbacso179268326d6.2
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 12:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768249498; x=1768854298; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/dklBrNC9dtNwtEkW3+1FasmVEQ+IfE0nrDRIZz1Bd0=;
        b=GbBRSZu6MZGUDxqWE7fhIhbEW9bhMMpJ/DcI32V6tI9zC1XF5rYAv6m+DyTJPWjMgB
         gAm2FahBJAt3d7EuPK31ZI1UPIpwslzYsgiUIlf/4BeyjbwZHmMehrdcUHTjwDnBFWyB
         RGMbkho+yI822NZjeNAuBB87Y+uzTm1kbMcW6IhbL82JkcBLbvYInNZhS+em+cBFSmUG
         7igwfFaP/R8H3pNCKHYWDGVk46QcHlG4Ka5t71kNJFt5UMTyqu76KW3mqGf4AYn39SBi
         BxZ+4ge0u9edqf6uSESdlBFvgPiBxuuLpmFq0EjYHbX/piFHHFOYsc62Mzveg3CPGGNU
         R9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249498; x=1768854298;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dklBrNC9dtNwtEkW3+1FasmVEQ+IfE0nrDRIZz1Bd0=;
        b=lDu/oxMquAD7zhmmmkPIjwspSkclVMiJ1Fey05c+o9c0O7A+auTkulZmJKqFv2Knj5
         lCV9K96tFYtmpV2uHvd1Gyl0vsPisnXmXJuL1JYfPDzBNRPJWtwIzyoHarajI+91Gznz
         h2eiY/vEwqBPOJaNHKx/5NhAn4bU2hynIQPItU4/RKJDcVIKK7TLtrkkjEPirkcqRyLZ
         8wmhUR1vCvnqZW+UkKTHnVVKXOSo6FY0mfLVneXOm2riMorbavZV+W8lhHWMlZFNvpFT
         iGUDAbkdJJN+fprxd8b05J+cBdGQmhls43A7NGpZkXLHqV8XvRcxR4EYJSHjcDNlzlLL
         4u7w==
X-Forwarded-Encrypted: i=1; AJvYcCURQQw0tT0PlqlTBUBpK9NvN2aQn9D6JcWncBWw0SKnSUCFhGw3OCyXylaN/chjRZ5/zE7ObdLouZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJ0tAl+mYQlsTxWF6+B4WH+q+R0r+jDHxlPnjQ2Hk65DlS+4d
	KOLKuy/iv6I45SV/+x099nEOG3fPuCsgGt9szmqRhUR5viZJ6jFY9VFbCRId4p1+CiCjE4YTfrI
	dRlD2SvkOeRhTtbvvmTA7POL4dBjJaCE2Uh0ngv9wukgEbltR3LcP5GnBqjR9uw==
X-Gm-Gg: AY/fxX41yiZzDYwqhZPNUcCADns8LKv4irhwcBXb2Xq0GuCJEcasW432sLbMjK70+Q+
	yYRJQsdBdmh67HIxR/k9lsyTMjbSBpZw6BM8oYe5SA2o+ah5N1ml1NdT3L3tlX/ltbU73oBvVEh
	ZrvZSluguTo4QM4M3Rn+v947Zp4YHUDEmzmD5wJMzLeh3eQZTtGarQ0+4T6T2VRgsqrNa6GceYW
	doKcOOyiucFALnmHAu2UkYkCDlecRdXcmUvfeDyfpnMA+gP70XpWebn2FCWxsnJbJ3MuRWcAvLQ
	6fYK74pkqvO3S03UmCdunIDeQ9MvnnDF5uDTm0bIO4d9qPrO4d0uYn57eU42Ndcu2CKcRRe+MlC
	woJmyoeCsKBdjXGxQuxVhaQN7kVhzAbkaThMO62HOYMFu1VmK/6KsNrdDgaAM1zm7Dp//43m9YO
	rKFw==
X-Received: by 2002:ad4:5d47:0:b0:882:3f45:c819 with SMTP id 6a1803df08f44-890842a26b0mr289707216d6.53.1768249498385;
        Mon, 12 Jan 2026 12:24:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3zFajB3/aY+UiopgOBI5CD0c+r+XVq0bnvAyZwWzkhQ2n7CYye6LaSk94UeTrl1wRZO91aw==
X-Received: by 2002:ad4:5d47:0:b0:882:3f45:c819 with SMTP id 6a1803df08f44-890842a26b0mr289706906d6.53.1768249497865;
        Mon, 12 Jan 2026 12:24:57 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffb75d7916sm128452951cf.7.2026.01.12.12.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 12:24:57 -0800 (PST)
Message-ID: <2105d279ce5df15bc15e29a5e21ab3c5b6e440a1.camel@redhat.com>
Subject: Re: [PATCH] fixup! genirq: Add interrupt redirection infrastructure
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Daniel Tsai	
 <danielsftsai@google.com>, Marek =?ISO-8859-1?Q?Beh=FAn?=
 <kabel@kernel.org>,  Krishna Chaitanya Chundru	 <quic_krichai@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring	 <robh@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Jingoo Han	 <jingoohan1@gmail.com>,
 Brian Masney <bmasney@redhat.com>, Eric Chanudet	 <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas	
 <jkangas@redhat.com>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-tegra@vger.kernel.org
Date: Mon, 12 Jan 2026 15:24:56 -0500
In-Reply-To: <87fr8bg6lv.ffs@tglx>
References: <20260109175227.1136782-1-rrendec@redhat.com>
	 <87fr8bg6lv.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello, Thomas!

On Sun, 2026-01-11 at 22:52 +0100, Thomas Gleixner wrote:
> Thanks for taking care of this, but this is not really the way how it
> works.
>=20
> $subject: fixup!.... is neither a valid nor a useful subject line.
>=20
> $subject is documented to be a concise summary of the change at hand, so
> in this case this should be something like:
>=20
> =C2=A0=C2=A0 [PATCH] genirq: Update effective affinity for redirected int=
errupts
>=20
> [snip]
>=20
> It also lacks a 'Fixes:' tag as the code is already merged, no?
>=20
>=20
> [snip]

Apologies, and thanks a lot for taking the time to provide such
detailed feedback!

I mistakenly assumed the original commit could still be *amended*, and
the format I used was a (failed) attempt at asking that. I didn't
realize the commit was immutable once included in the tip tree, and
didn't pay much attention to the commit message because I thought it
would be discarded anyway while amending.

In my defense, $subject: "fixup! <original commit subject>" is a format
recognized by `git rebase` and used on some subsystems to fix already
accepted patches *before* they are merged upstream. It just doesn't
apply here. Lesson learned!

I will re-send it using the standard format for fixing a commit that's
already merged, and follow all the suggestions you made.

--=20
Best regards,
Radu


