Return-Path: <linux-pci+bounces-26297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7426A9469F
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 06:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE36B1758E4
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDE31876;
	Sun, 20 Apr 2025 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5julNA1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD9184F
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745121711; cv=none; b=uQRpvNM3uGfKDsx0g0OSZ3dkfkJmT89wzu5yKk6nFpMn7SpHH4O9xm2OGVf2E/ZC5JvrgU1NiK46T53jPfZ/TR3ezTmY11FMmxbMTChS7BXegpzTQRsnfiErzer+NJly7EJazf1K2Vm8KcuNN0tlcoMuwvJGme8tFA7OWyPF+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745121711; c=relaxed/simple;
	bh=RZtdbUfIKfxTkmCM8R+J7evaChpX40eKMSCX+bILPXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s3ZzGald1mziODVH3R9cGGMQWjaaTh1RCarXNdYFG/kO9yYxoxqRk4kY7Y3TKz0J/Q++WHhIXGM1+pGGD2aDttfn7/Ee30Aj1gJz9RKj1FHGO6FW8jvhuCs42E+3ZXva+Rq9hL5GvqFG/G2MvvdAhjiJgR2evVMol++EBRTOQJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z5julNA1; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b0da25f5216so1823620a12.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 21:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745121709; x=1745726509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOrGRGfF/X+TBJyjdMVwiIdhbKamtHZWIXIJH1oh0q0=;
        b=Z5julNA1EXrGZK7LR5/nTRcx7wxScd25vfr5UQRCPTyx1rHfQHxkEPFy4S8w7qdIVu
         VbjJ+yp16ng14uLK2mv8cQ5rxRvVFpx4Tryycz2C4SLTflmlKGjmnk2Z3biRhEhpbu5v
         pAJ25zOARl4jxwYP63C73ikGXcpc/uNmCCnQi5TR0UYwaj7MkDemTRNLbu3sP8Q6FbmE
         U0Z3ITA7GiPpwJuUmXFHHZBKyRpVQjKldmKnxR5Yhkn441aHmqzF4Dnr7a2Kl0F/W5+T
         Ly2OTmoe9dvzBA+/T6/ZghC9Q0/fSRBB8zJAjY8oG9ppz+kt4LhMSupCrglvOU4XbHOM
         yBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745121709; x=1745726509;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOrGRGfF/X+TBJyjdMVwiIdhbKamtHZWIXIJH1oh0q0=;
        b=rRPgjbVErVyCSJX9tWsmcHatu56cMKSV2e09mXrVRwzen95MwBBY6xKam/mU4I4hry
         WDycJfJQpPaG2RiZqu/lIbe+uBhQhWYifzdBQO7oyjiKjW9V0cj+DgVnXggvdTry0Dvs
         lYr0iThUhq6hSQ+9jvBGmy1a3OmpbLkTpeSRsLMv/9SJWLdEq3DEcbt3KI68s37qUlYA
         oyvBulvr5QTuE6AtLXsyPRxkUOt4TRhRarNPaMcD/o+nTAUxOEvznJfk1YDOl4c+xA8U
         76y8TbddBCX98AKCKey+4Pgn8DL5D+URKLPwphElu0g7IrSiqmw5sa66fr/dlvAYdyUy
         4qgw==
X-Forwarded-Encrypted: i=1; AJvYcCXGmqj2LrdKiQC8PHH3RgAoqtGOIwNKkHj0dMWxAqLl24P9XlIfAf6s+ICqwHF334sxjAsp72lku0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfR/lO3Lv2YSgscuQmCfP9slYWS+nK0RZXqPulyjLTAS1nNSw8
	ULnfCLfmQrVVQX/h06yd3iNRu4vi2mT1gEcTHgfsgLE7QWLwD0UITqkpGhO3RQ==
X-Gm-Gg: ASbGncs92V8dzfAti/l+8wY8uq1VkDA5P0ULp0dHu3bmamprbSGXyrElq2EvM9Wr1zx
	0udGSEQhODVR3daLkW687Ajp4hgyI5a7cdOYewgzxRsCMBP1ZanVNY1yrcsvzw+RNJLwNYsTQ/z
	HrJ8mPlTcgWTraOvKsJwbNhHOsUEVJ+7IzUvaOznZxyR8J0T4iq7V4fUfS6Ug/ATztjOyyoX1mX
	mEfH4NSQOpJKxyo+S2ShuQe9oJ7rQaP56qnn6yiqCoqmgjwTdzEjDMJngr3UHEVROV19etFSVdB
	hTVbkcK4tWz4sQzL1o9IdXDqIOfQllrhdAq9T624Fswy8wVhwbb7og==
X-Google-Smtp-Source: AGHT+IHgO3P1rmN0JwAW7tDozFXf0SGXvXbGA0YI1vlldkxeH2TUY9CqJvFC2tNhbHLvji2fOpuPhg==
X-Received: by 2002:a17:90b:58cd:b0:2ee:9b09:7d3d with SMTP id 98e67ed59e1d1-3087bb6d168mr10943673a91.19.1745121709359;
        Sat, 19 Apr 2025 21:01:49 -0700 (PDT)
Received: from [127.0.1.1] ([36.255.17.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087dee8956sm4469659a91.8.2025.04.19.21.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 21:01:48 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com, kw@linux.com, Niklas Cassel <cassel@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250416142825.336554-2-cassel@kernel.org>
References: <20250416142825.336554-2-cassel@kernel.org>
Subject: Re: [PATCH RESEND] misc: pci_endpoint_test: Defer IRQ allocation
 until ioctl(PCITEST_SET_IRQTYPE)
Message-Id: <174512170695.5723.16265162524139108187.b4-ty@linaro.org>
Date: Sun, 20 Apr 2025 09:31:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 16 Apr 2025 16:28:26 +0200, Niklas Cassel wrote:
> Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
> and 'no_msi'") changed so that the default IRQ vector requested by
> pci_endpoint_test_probe() was no longer the module param 'irq_type',
> but instead test->irq_type. test->irq_type is by default
> IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).
> 
> However, the commit also changed so that after initializing test->irq_type
> to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
> the PCI device and vendor ID provides driver_data.
> 
> [...]

Applied, thanks!

[1/1] misc: pci_endpoint_test: Defer IRQ allocation until ioctl(PCITEST_SET_IRQTYPE)
      commit: 9d564bf7ab67ec326ec047d2d95087d8d888f9b1

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


