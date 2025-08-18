Return-Path: <linux-pci+bounces-34225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B93B2B299
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 22:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28921684D95
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8EA22A4D6;
	Mon, 18 Aug 2025 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0cwNf+l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDE2264B1;
	Mon, 18 Aug 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549602; cv=none; b=D3tbsLlAK5yvdAoqgaEtPth4rH5uwi5UpJU9Ce9zJY9WJ4JUDG2ZYJ7wAIwGtJR69Y1kwCTg8mP2Z27K+fzMglJ92cRYisCX1dGcGWliSOpLOR0yq8tIaHg2FswynMpojCGw2FjCXo+JrDCbsKXU+SDsT0JRJWCjVRW63JBysAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549602; c=relaxed/simple;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=T7b7GG5ho5/5PbEzjghNa9OfPH9c7DYLjf8j0EiUb2tQz27+Y+TiaMZ5pOtzmOnLUMewvr+cmzP2f9bI72XXvQIV6hDw7FsdwmrppYj2+3WFXEGxveVvQ18qpbHe/ZtgNS0AFYnbjjBUYfnd9YqHs4CkG3q5o0+XW8QjtYUCjls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0cwNf+l; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e934724e512so1821186276.2;
        Mon, 18 Aug 2025 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755549600; x=1756154400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=K0cwNf+lvtJB5alhLKO2xsjCCSCcPOz+AWFHjotePZQUQgAQE4msH/cgrMUI11PwGf
         I2lfCgj5XPOSdVJ25H2EXTGH8uF5OMeDZM9t+h3FOP0PoMCQwpdQIKLx2yVr2HQEjzbw
         Gh0L1IskNrcdKWLISCN/3wPFWF/0JDhii2X0k42AQJTcavdEtrBOHvPbvp9we/CEgQuA
         YR0FSWJEQ6099nBmf8Ads5u2uWxgFTHMUfS8g+iTHD4z7G9iYsD9XeduDXvbf3vJui3G
         TEUfK/HLP8GDoG9H2vqgMIM4idKktl0TU/cTcUJSBi4O/4Lws3pA5pofopm9Vh0uBe9K
         DKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549600; x=1756154400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=lQnwXlpUj6olfi0UmeqD9IKj2JSrYbYU1rdEdrttigx2ONnJVemeSdZFjV17UZybHx
         tqTEkiectVnTfgTVLrHNzsgJgSMTYEWd4TBuNJS8Y035lpAIZ4Ao8qiA+yjFgQWdZNZd
         XZgnT6A/oxxgNrcI/Eokl+DOHqm3A2cNfKaD+rN6hlIQB4AQYbxA+4OyrS8INlJtqMvk
         eIsd/uDNF+j9wG4/kG15bh6qm+nkCCI6qBsFIHEsa+Fej1iddLuMuz1+Rgce2BeMorOY
         Tg9HcVhVThD3cABmMUqw6SnSvN9ii8qoLPtfnMugpsTgX5KtxDjTRE7QeyDnw8UA5SYo
         THUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOOPs1cW/zr1f64gYPqyJNkozMXs7dTWggtnJnMOpY6uNoxyp2iHG2tM2NmpmZYdOVxwwaDPiLiUYG4A==@vger.kernel.org, AJvYcCWLT1RwJMTuAfvig60HMcmjTFo7gf9kWrrwJ2sO4jCb/SWKjJsw+oIyHCsbPPcsGDFUWGxToQQl@vger.kernel.org, AJvYcCXnOGLrcN/7RuoRloY+E+XdVXZUDpt9ZaSY3LjmAE8LuL5Jeo9dHMLTsezVHhD0Ur8tYx/hIxrPpu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4EIA81wApp65d1vcN8K5jbmbf5rEdIQlzdnjh0NCSHprvMBv
	PB7Pw5nPYUYJqj4n7AIxoMFa2GwF6ihPPdQ8gHfe5oOh+lFXCCSL/Jz07GoEgFjXvvJKj988tal
	2bL0iNnrR990/2547jiX2+oEmXBWiABQ=
X-Gm-Gg: ASbGncvWHUic0D+ar7CUkQ6godb2b23zkx5qwjHjYETnDhFqFI3Awxwn87e0qQjOaSF
	5mNZjttBb/6UHKTqHx2Qn7blh7Nj+3Cnn6737176kmTSYp/p6hynpI80vi4j1MwuSwNLXnvSUay
	WgbQE2MpwD6uBBul+5vRYBEdy943a8Ss9oFD93wFCgUbJfDJU9HAJCB7FaI0SfdErQfbsVrt75i
	h2uEwoy
X-Google-Smtp-Source: AGHT+IHAkrMwRZwdoy3Q6/RtnyzaiM2nQ7nvYBpI05C2SR0hHHKABaQ1e/OsdyKPymfqcGip2s/dKheOtKjQqr4m2vE=
X-Received: by 2002:a05:6902:6d09:b0:e93:4b5c:d50d with SMTP id
 3f1490d57ef6-e94e6284bd7mr364154276.25.1755549600338; Mon, 18 Aug 2025
 13:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Tee <justintee8345@gmail.com>
Date: Mon, 18 Aug 2025 13:39:47 -0700
X-Gm-Features: Ac12FXzDVK05Bcq9rvaz1Jfc1bgieWIBNch0-7wIMNa4XPotGC44yPqhEIVj_vg
Message-ID: <CABPRKS_Ut8Z+rvM4+-E0YvEwUKbMb0SDpLBdH+g1sYEh+YcxFA@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI/ERR: Remove remnants of .link_reset() callback
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Riana Tauro <riana.tauro@intel.com>, 
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, 
	"Sean C. Dardis" <sean.c.dardis@intel.com>, Terry Bowman <terry.bowman@amd.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, Shahed Shaikh <shshaikh@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, 
	Edward Cree <ecree.xilinx@gmail.com>, linux-net-drivers@amd.com, 
	James Smart <james.smart@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"open list:EMULEX/BROADCOM LPFC FC/FCOE SCSI DRIVER" <linux-scsi@vger.kernel.org>, Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

