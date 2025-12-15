Return-Path: <linux-pci+bounces-43028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DBCBC6F6
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 05:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E183018F46
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 04:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5056C32936D;
	Mon, 15 Dec 2025 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyGeK/+Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006132936F
	for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770635; cv=none; b=WsHsCxAGN+ffplh1qOoFvP1/h3qBO2l8FSl1CZbFyx7RyfMbfv2JaRAxDRuHL/1v+g68ZSH+pGFpSduGkBkGVNZYhZbatiiQFcTp0j0m3pgIralFXL5/7cMyxBB5TaP/haHtaDGewrTpcYpsI6DY66wqscuHoi3UoKwlzH+ArqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770635; c=relaxed/simple;
	bh=S+389PeuCqkfLtBhszvzL+jzMapl+LWCpRMiOC4oVPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeUvrZQdlrw5vR+spVc8CbsPfwEGhXVlEJK5P80XQNYQEPdR8yDE3Mal94Ev+oIUTL6dgbMAwYk26InlaD1dbeM5kdKx6TPNjAybcat1fwGTmXnHCqA3sKo+C+QYGlqSzHUXLbOz/yaQzAHSrQwlIiEXAAdX4dcKsy6z+WIQTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyGeK/+Z; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso3762871e87.3
        for <linux-pci@vger.kernel.org>; Sun, 14 Dec 2025 19:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765770630; x=1766375430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+389PeuCqkfLtBhszvzL+jzMapl+LWCpRMiOC4oVPc=;
        b=PyGeK/+Z0F571FY9BS/KcaVJnfiuerWjBvEc98NTWhRLarIzhewFT79Amf6DGk0CAV
         vGZn1Bgs7KyISDiAY8oq2WTwJ4pN9Xnf9SOXjKH3REWJDg90OOFJPx2inXQ1ieLjxoAc
         9OyPdI2Jg3Yqlm3N51s7cAYEgd5ljy7mYWbg08/aHYgEJJtkjcfZ3q+76EMUFHmE8kp+
         Q5/iLXaoCXneVqFAOXqFvo1oxufyqXPK6djl9Jw1l0XkHUjeu7JmkWVp/J/mnBLO891q
         9GV+bAgFIBu5iqmSdUxrRF4Ud1CmjqHQ9Q/3CAQmR+aEwBWPlay0VDAjwZZSMjFBNWAd
         q3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765770630; x=1766375430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+389PeuCqkfLtBhszvzL+jzMapl+LWCpRMiOC4oVPc=;
        b=tDAG/r23Uxrp1B1w/+ovfzStfnfGX3flWrI3xJIUPAUQrLD0YSABDdUH7eoPWBR28n
         pKBMhSWLuj80nbAB8lsACuwrRXgGEMWP9b1DD2M25sOSjw2bULOip1yTZLORlgQdfLLm
         MEuiLK6xOKzeOaJmABmC3PKV4jn+g+75SmDO3JeASnM65GZXxacM9FJDWZnx/4VxoHYF
         lYmZB3bdiJA7uhO+YRLH+qMoKeKMnX6Flg/mTKDOnfoWqlrrA/T+sMUB2MAMb+L5KLR9
         suuOQicdBhLWD/Y4i5iS/OyEUTdGGyclNuGePh2hvtk8tQn5N1lbv9pevQVTmfm2vl21
         DQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgMLfJorHyaDA2nJpmT0q4uDLsWdN2iVKfwhC8uKIaBMjnnbrSz5MvY51eseZsctJSGLQxoAYKxTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoB6DMSBtWh04N2m1bQ50JRZA7y7/44fyuL98tr89LlMC6/u5X
	veTEAILZnbbLh5kzFnZdA37IgLbWIhKUySlaqChveCrUzOY7e2+MVwl/13WvRuZajF1qaq0QzhF
	/1Wwz3ODdIwuLqou8zaA/xBW5ScrWoXA=
X-Gm-Gg: AY/fxX7zhG0NUq8MHxJWSn51C4xhCXuNJ8B1Ixz96OvoaR8/E6zNuNVTl2Q1hcyeD9O
	sU4+z26Et3s/DbBc97U22if/Q4laFWqfDBOCi8eSeSU9oJp2Dzu97Jt1yDdC1cikuQ73JiqMvu/
	KC5JrZmV1X+xt5BBZu7ql5itP7FhBoTMZC/UYHWun/H2Pw12dVhRN80GOuTWIVYWILO6GyPkso2
	9V29mj1Y0INt24cWluV/m4mPNGwMLFwfuAV/o9FmzC7Iw3Z5c/g3FQcwNG2Z9q4l5D5QGBlvg==
X-Google-Smtp-Source: AGHT+IECAzt3wD8vSK16CHJGC2zLopACY/NEPoA6iPBiNLtGFh0s2TjBshQkDMO5T6BIUVV7dHvvPD8uiZcKn+wTxg8=
X-Received: by 2002:a2e:bd01:0:b0:37b:a519:cc95 with SMTP id
 38308e7fff4ca-37fd088604fmr23242141fa.21.1765770629728; Sun, 14 Dec 2025
 19:50:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHP4M8Uy7HLiKjnMCdNG+QG+0cizN82c_G87AuzDL6qDCBG5vg@mail.gmail.com>
 <20251215045203.13d96d09.alex@shazbot.org>
In-Reply-To: <20251215045203.13d96d09.alex@shazbot.org>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Mon, 15 Dec 2025 09:20:17 +0530
X-Gm-Features: AQt7F2rfVrqkWgYywRRgP8IStfKB7RQWm0KwL-7zF7l2lzQR88vu2vuj_b0-35E
Message-ID: <CAHP4M8WeHz-3VbzKb_54C5UuWW-jtqvE=X37CSssUa5gti41GQ@mail.gmail.com>
Subject: Re: A lingering doubt on PCI-MMIO region of PCI-passthrough-device
To: Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thanks Alex.

So does something like the following happen :

i)
During bootup, guest starts pci-enumeration as usual.

ii)
Upon discovering the "passthrough-device", guest carves the physical
MMIO regions (as usual) in the guest's physical-address-space, and
starts-to/attempts to program the BARs with the
guest-physical-base-addresses carved out.

iii)
These attempts to program the BARs (lying in the
"passthrough-device"'s config-space), are intercepted by the
hypervisor instead (causing a VM-exit in the interim).

iv)
The hypervisor uses the above info to update the EPT, to ensure GPA =>
HPA conversions go fine when the guest tries to access the PCI-MMIO
regions later (once gurst is fully booted up). Also, the hypervisor
marks the operation as success (without "really" re-programming the
BARs).

v)
The VM-entry is called, and the guest resumes with the "impression"
that the BARs have been "programmed by guest".

Is the above sequencing correct at a bird's view level?


Once again, many thanks for the help !

Thanks and Regards,
Ajay

