Return-Path: <linux-pci+bounces-21538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A62DA36B45
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 03:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193C4189463E
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2025 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12E74E09;
	Sat, 15 Feb 2025 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvi/krYb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AC614012;
	Sat, 15 Feb 2025 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585208; cv=none; b=rqBpW2xZm6cqtILOnPL0JAZQ/I6+csIutAs5mVH3rcjXrNOYYHsxxNF4LWl3+xrUzqxI0S3nS6FHG8408STRNHE0ae2BrUAkTGga5lBI4dL7ad+QBBWBsB8UUWASD0Z9k+k8nsYYcPcokyWr+ISDY3KRnRbehnTZhFuUhkBG+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585208; c=relaxed/simple;
	bh=XR7AOhY6S34dKewifz+km1VWG9yebCK5SGbtEbta3bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J2mOnQac5hwn4iJyAiaIFfy+bNzL5/nOk6tjQ3jOGUn9f6/9F8l6oBWoJhTVR0iHGBcGa33FvRDzWjOQcYvBQRsUV23SKpuGT9qInG3dbFlOxSDyXF7zkcdPXI/+siFbfzWIezNbGsmU68O50PJdCNPyUqR9NjmF40FzNY/27GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvi/krYb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so4999502a91.1;
        Fri, 14 Feb 2025 18:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739585206; x=1740190006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3HOnpJxe0NdKNGJOO+XqAJq7CFi8wQ7LHZoTb4qt4I=;
        b=Gvi/krYbtj42Fj/42FHOLNu+/TA/U9aawjV3cd7iUTolOSgStUMHWovB+Gp4aBLgLG
         rS+Hj0SkcaVetCOwFb3neew/Lxy4LwSEifovS8Pzee3LE8+AwTk4XtLxpU49zHIVUnuo
         9jbMiAJICcvexnNQFy0fcP7s8rLi5mkKpDunzOalC7DXeAuPBxPve0YCE1QUxwhTgP8m
         KiZDWc8/Xw463DiSsCHkWxc+aX6Y7GO18z+NKts1z5XvYlyCcQm4psDGIxSnep2Mx3z+
         MGgautbTX8QD0z2TH+KtleXjj1uhn0LSeAgLI6wX5bDF+eTs7kqht95nhT0b9Qes/0L0
         1ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739585206; x=1740190006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3HOnpJxe0NdKNGJOO+XqAJq7CFi8wQ7LHZoTb4qt4I=;
        b=dZ3ZmGKVQrK0r3hnhdvSIAcYxz6hhDzwIqv3Fsb96icQ2r4F2va4uS8aNOyq0TmcXe
         s13fnjumm+DB2ogr3FnKlm004dT3Rohxper1GzjtgOopqkwe1w0794AxswALJ6Oga+jK
         hE/ROHvSgWchyJWxZDbthcrlKMgBK8aP/GMSdb0iuzBetol4WwiOgScJAExFyLhMkElt
         oES8lnQbtriOYx+v2R5YJk2CTRl3zyBiwbyYeeZs1r4Twl+7Gb2l/cxGIPR0rZocpqRf
         24No9FCKJ+KmxnjbOwTsNUIx1m5cfkOyuDoRHdhYxA2t26WjYP7+n+yi5bkbA1eVAR3O
         pT+g==
X-Forwarded-Encrypted: i=1; AJvYcCUDzeL5o4QOQoMVll5J6tr8krGqJJ7F1jLFLlV+7Un1wETRwQICs9ivUnMVtvff/YCqwf/dDfZexRHnEKU=@vger.kernel.org, AJvYcCXF0bmtfo01x8bXyncJa74EhPCPyMaA+/UTedO3yOzvP4RugJfsCBzB16J8vPECZpj2xDiz5ZZPZw36@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+2EK92pM01FYH4vecQlKm9V5WcJzGbCeIocVmFIY94FCTe6/
	Wpd4UHIWsdSvJKVJGs3MGUBndPaZq3yfUfMeNaE8ug+Flro2UPCH
X-Gm-Gg: ASbGncuGJl3AgeUvkbujmNb7n+H92GrvQn3SubRjqEVBpAfgil7qBsJeZmkl0QPA1b6
	hsdsdh9xmI3ZlgcsxwX5vu0ojPmOY9z6A8+HZ6vI8Q7oIkz6guXzwD53QCMxQveszpPEKHvEcxg
	mIyMkOOtmGPQi+KeRL1DLxYyXSQ+RUZYP+6GRx0s/QybtjtvdfvkTysaFE2JPfZAboN8YGJXVdl
	ueoi9OY4YNuecEpINAK9ulzZrZWbNOB5J5RDs+z22x91VKXP21gi3xBtWdEYXOnlS2LhPX8wf32
	DMwroK82E8uaxi1a+GLPu5+o
X-Google-Smtp-Source: AGHT+IHop3S/O5egKSMDEHdYYSPIkN92gkImI2lM0f7ymUc+Yot11QLU/FVOBFAexTXqSZZLbgzItg==
X-Received: by 2002:a05:6a00:3e0c:b0:730:74f8:25b9 with SMTP id d2e1a72fcca58-732618d54b1mr2524363b3a.17.1739585205777;
        Fri, 14 Feb 2025 18:06:45 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242761538sm3914913b3a.139.2025.02.14.18.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 18:06:45 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	scott@spiteful.org,
	trintaeoitogc@gmail.com
Subject: Re: [RESEND PATCH] PCI: cpci: remove unused fields
Date: Fri, 14 Feb 2025 23:06:37 -0300
Message-Id: <20250215020637.217456-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213212627.GA129476@bhelgaas>
References: <20250213212627.GA129476@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bjorn Helgaas <helgaas@kernel.org> wrote:
> There are no implementations of ->set_power() or ->get_power(), are
> there?  If not, we can just remove them and the calls to them.
> 
> I don't see why we should add SLOT_ENABLED.
Are not implementations of set_power() and get_power(). 
I removed this funcions and in enable_slot(), disable_slot() and
cpci_get_power_status() I use a `flags` field that I create in
cpci_hp_controller_ops struct. I created this `flags` for store a power_status
and use this in enable_slot(), disable_slot() and cpci_get_power_status() that
before uses a set_power() and get_power(). I do this way, because I seeing this
patter in another pci subsystems. In adittion on this, the flags can be used
for store anothers values.

But the Christophe JAILLET <christophe.jaillet@wanadoo.fr> say:
"If neither get_power nor set_power where defined in any driver, then 
cpci_get_power_status() was always returning 1.
IIUC, now it may return 1 or 0 depending of if enable_slot() or 
disable_slot() have been called."

Do you think that is better we only return 1 in pci_get_power_status() and
remove SLOT_ENABLED and `flags` field?

Thanks,
Guilherme

