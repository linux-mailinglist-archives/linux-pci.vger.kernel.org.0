Return-Path: <linux-pci+bounces-43550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B5CD775B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 00:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C815301AE12
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6633176EB;
	Mon, 22 Dec 2025 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swuj+OYA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCB30BF5C
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766446667; cv=none; b=EUmHVmBSNJO7k1feri29Y03snQ6K+9BWp+s3mjOoyHUSweLVAPyw0MlZdt2OzsTyFuCUYbjlmdpszlF42EPVHoidmp2+rNYwpzQ7vfxzg4FJbG0MNxWJ6MVResSiBFHSd+g4DVDRg03dQpy2jCLeqYr7IfDa7Oi3mccshEJ/EM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766446667; c=relaxed/simple;
	bh=nY66VQOhbvqdzZgeGL+/FZXbOwO7nvJBigVU8eFU+VU=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:Cc:To:
	 Message-Id; b=XOlxU8RPqEBiOuBolGXpMGpHA7Cw4EWvkR+WwlikLJxWjofrJlFDFQlNEuAYi0X5LggbDlf2ZpOkdIe68ld+/ZYY37QltHu++2y5mYjvT0ZhruBCEzooHwqMtM4G8JE1xh5XfEX3KjG8/G+xWrd5dI5FtzPD5DPOaX9YFCOGAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swuj+OYA; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4eda77e2358so36126581cf.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766446664; x=1767051464; darn=vger.kernel.org;
        h=message-id:to:cc:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJvGwq+7Pamxnffgvl/Xh+Dw+LtLBntFoSfEkNe0+74=;
        b=Swuj+OYAPk+niqiClQn7cXdOSe0RYifqTLp+49YcHpXFJ3F+z/+lKk+J7PqHN62TK7
         awYbXttrcjGQbiY83e9ngG2ZVc/eGpJ0jthG3RBiJKUxdCV/PGQoJGQOPFXr+a/Y+qhj
         aH5bSu/WOLyXSw+TJpiV+jQ1StOJUT3ccC9q+AUS0sQ+TE/rXK6GD35+vTcIslLfh4jH
         AJ/XO9jezw9gTciHuz+4LNpyfmwRsTM3gomXPBAwMKOowdO3nQjpsltbAuPuzkFB7lov
         9a+M/cEXeeZH+WG85yuADxvI4jeOEwKuAMzcZYrQxO5NnJn7o6cPI2qW7qTdHmKO39Fp
         7iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766446664; x=1767051464;
        h=message-id:to:cc:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FJvGwq+7Pamxnffgvl/Xh+Dw+LtLBntFoSfEkNe0+74=;
        b=XgKKPwSzzl41C8Y2O08QKbN4pUT36v/0aa33URIDsaRygi9ew7zBC/li3dm/0b+yZv
         qK7LMe3mft6FJ10H/OPIVj7NakLd6/Tuf9D3VkfglvJq7jN0uxkSGjfdDvD42zrlOcxt
         9MvRJYGYKXYcCedx6CZQm4x6/g7KxvH2kUbUOl7+xTxqjDa7mTPPGYR9jlXna5lt6m+9
         l2ht2u+fDURw7/SamE3HBZ70afPyLuh8NH356YWJzL7Ekqqi7ZL3v+8qmVZAXj8jZthe
         nrrV+fyr/CsJuZAOldqfdaWFGSJ79XOCJVOCIhbSN+tbnHKV0To3ttsnSI+I5Fl1vix3
         I16g==
X-Gm-Message-State: AOJu0YyDPqEp9ZNlj8tD7c66zCSN/RlUAWt7+2WlXm/196dV/XDGqWx+
	RGwQOPsvbir7gJDO6ZQH4u4kdQJ3dFzXLzlNiLyDeXZ7fCX82oHIsOV2pK02nw==
X-Gm-Gg: AY/fxX4yQwLTm756lcufD4gP7d2lD9z1nQJfp7/PI1nwpxxU15gY1egVboD6k3q8xcb
	xmDkG9eNBzg4Fz15VIgROd81Yo/qXyj3eXcYYc1UI1D/GT297q127e33hA8owQav+pCvWHS8A3f
	0H6O8T39RfYAjm2fIjikxtU594sS7U3fXsnxUVOXMJrZvuaZlm81h8jGJoqJDKQu5zw3p6tKxC+
	x1Agm1yTnujiLUx0AnWHv71Rv9gc+8LGf+h9kBaNQK5m31COYzR1LGfI04+OPu8v1T3Pv8ECYCz
	26ZQ4XQ3v3iFMhU1yC4Nd+1p6EIMBKsaw6/L2qSf6iSGpElTdIUoRXJbdtfgQLH2CM1l/lytupE
	VJlOj9JCf+FfHEI57FdkWGazm+wkOeENaVoyRk4TfYa0Xzqi7q/vZgM4s2BhnEVSRbWV/9iO7G8
	lupwKeon2YE3ZeSBrs238NX3Pr68ZMoIun4dmqbCLyk1X8HFij
X-Google-Smtp-Source: AGHT+IH04yosElyDXNujxX0PrNcUfcACTFFNNR9hYLNll/S61gWZPfwdzqxkwHHQqV8TVPhTPC/bVQ==
X-Received: by 2002:a05:622a:4d08:b0:4ee:1879:e473 with SMTP id d75a77b69052e-4f4abcf3b54mr205212151cf.32.1766446663663;
        Mon, 22 Dec 2025 15:37:43 -0800 (PST)
Received: from smtpclient.apple ([2600:4041:45af:2c00:59d7:91be:c779:cc7e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac62fa56sm93666341cf.17.2025.12.22.15.37.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 15:37:43 -0800 (PST)
From: Patrick Bianchi <patrick.w.bianchi@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Fwd: PCI Quirk - UGreen DXP8800 Plus
Date: Mon, 22 Dec 2025 18:37:32 -0500
References: <A005FF97-BB8D-49F6-994F-36C4A373FA59@gmail.com>
Cc: alex@shazbot.org,
 kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Message-Id: <26F3F2EE-37D4-4F73-9A51-EDD662EBEFF2@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)

Hello everyone.  At the advice of Bjorn Helgaas, I=E2=80=99m forwarding =
this message to all of you.  Hope it=E2=80=99s helpful for future kernel =
revisions!



Begin forwarded message:

From: Patrick Bianchi <patrick.w.bianchi@gmail.com>
Subject: PCI Quirk - UGreen DXP8800 Plus
Date: December 20, 2025 at 9:56:10=E2=80=AFPM EST
To: bhelgaas@google.com

Hello!

Let me start this off by saying that I=E2=80=99ve never submitted =
anything like this before and I am not 100% sure I=E2=80=99m even in the =
right place.  I was advised by a member on the Proxmox community forums =
to submit my findings/request to the PCI subsystem maintainer and they =
gave me a link to this e-mail.  If I=E2=80=99m in the wrong place, =
please feel free to redirect me.

I stumbled upon this thread =
(https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two=
-identical-devices.149003/) when looking for solutions to passing =
through the SATA controllers in my UGreen DXP8800 Plus NAS to a Proxmox =
VM.  In post #12 by user =E2=80=9Ccelemine1gig=E2=80=9D they explain =
that adding a PCI quirk and building a test kernel, which I did - over =
the course of three days and with a lot of help from Google Gemini!  =
I=E2=80=99m not very fluent in Linux or this type of thing at all, but =
I=E2=80=99m also not afraid to try by following some directions.  =
Thankfully, the proposed solution did work and now both of the NAS=E2=80=99=
s SATA controllers stay awake and are passed through to the VM.  I=E2=80=99=
ve pasted the quirk below.

I guess the end goal would be to have this added to future kernels so =
that people with this particular hardware combination don=E2=80=99t run =
into PCI reset problems and don=E2=80=99t have to build their own =
kernels at ever update.  Or at least that=E2=80=99s how I understand it =
from reading through that thread a few times.

I hope this was the right procedure for making this request.  Please let =
me know if there=E2=80=99s anything else you need from me.  Thank you!

-Patrick Bianchi



C:
/*
* Test patch for Asmedia SATA controller issues with PCI-pass-through
* Some Asmedia ASM1164 controllers do not seem to successfully
* complete a bus reset.
*/


