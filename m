Return-Path: <linux-pci+bounces-32839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED57CB0FADC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92DE3B0B8B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410C208994;
	Wed, 23 Jul 2025 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S+RwnfRZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3151339A4
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753298025; cv=none; b=aAwtB0gs+Atz9fi5IsB4Wp8j5LQox1SlB+quBZgNa3I8voNoaxQFLICLueCbPQEg9U7QIdaJVbKeyZujst4DVxS/1lprVvEk1A+rVN9k/qS9VW58RQbGa9yYjQ/yUFa8Si5p27+Tc3JZ7nM5DHW5wwkEm2JZif8dXXYvQ9tkByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753298025; c=relaxed/simple;
	bh=JKDF1Z8cdyHoCNNDMDQSp/oPrVWxJYqsqXYKwWddD5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMVTDr5j37VzoCWXGxtvLka82ebVa1i43H3x6TaxWub9ajNernEnVyrvZu8KCoCg0oGnyR2QVMJ+B0sPMRmStHtsNPc00xQO8PODUvr7yPN6o0DOcuZCzhyGXj+Ye1AIvrhgbT9k8ipzNqFAzCQw2qI7bw6gGXuDan72SmJZSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S+RwnfRZ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748d982e92cso211441b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753298023; x=1753902823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzcqWLVW669oK1A7bo54m0evV4oxKQmhFTEkp6aUrbk=;
        b=S+RwnfRZ7wPZUgPmRsytOmfzcimXqj80iGuKqSyQMA/YC/Uc5+t3ectsI9rik/oYKp
         NkRb4b0ECyZn+xIHqmYuPgQpcL32SgF9tLYQIKee6XQR4c/97fI0gwF8BXSkCSKjWowd
         830X2BRXIgyRmAg5LAqK0yRHMY7z1LvLTYmu6R284Y5aFduj7G1I64V09Pv5xxFq2DIN
         JbdBdj+pHre3/GlhzjLqOd7ldZZMZ0SqNIk9GZfjX4aGqVKQ70RlBb5cBaZOm2gYJDJ1
         Sndk9Es+zBdOGSJWG9s0WkpV/TnnYkR2DX26eDMeTAPs20Q1eyZ2Ozi9kcmeil1l29H5
         e4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753298023; x=1753902823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzcqWLVW669oK1A7bo54m0evV4oxKQmhFTEkp6aUrbk=;
        b=ujzxFpwBVOn71sNLcNnyNamgeyxlvuND2aCD0G3AsC3lGr4XOEhdpqiaf6YTVemtQN
         HodqMi0g/TDy2YLOXzrqfAbiDYlub5C+tXl+le45ADN9GBv71YgxlM1KLBdrmnCRGspF
         QPpT8/IcX3lBj61I3znTJvDNN0sANeI/+6sY/Iz+2wugUa26fQGY8EW/NwSKMkBfl3EZ
         jNrsGesvcsXI1zLQvbOkb5IERRAMVZ6BCwpbi+Dc4IB/NEZruGiObLl4p0tIMaK8Gmss
         S996YqF4TZVYbYJjyvlzqYUIRHXW7HgDgY8Cj1K+XBdzdhPFEdWQYHocwECftegGKnsC
         FeJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcpGcVV3/iHrVSFrJBzKLZvIcfQKBQVc7WGrz4qRgYU9Jr68jr2b6QATDjoGtC+S/qbenxN9uvYv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzDxHErxzm1wni0fnhm+iBTWFdTDEYbw3mh4jWMNSkPQLGgToo
	Y0qFxwXUVoHr0EL/asW7I4OoqybSZqWax43TBaXJlhEF5XRUgWm/wmdO2urwhQBRaUg=
X-Gm-Gg: ASbGnctTGBIOAAS32vSmUmWU30IQXVEetqNR5aBdE1XMR0zhzBKwgqc3HeYf9RSdiL5
	U+nK06CJOk5h9hA+0uk+1bgueJXrSj6ZgpBnHIAYK4H/VQZ/2K3GIDNh3JAmPdSqNd+5J8NcraC
	AQ/KAIeF20QEIJWfIN1XjzIwDvOIZSu9zC1Tp9FLA/ejQgt5DWhbwtfG9EJDuR3NKi++sa90Gs0
	m0W/MG6gHgWORSFE/4sJPIdH6GcJAoC5dF3r5z0rragFvFgRWLpCxd0nEPWJ7JP3phJLEx+j7Yb
	i1xVjg2JFdGTf4uqb5CnC1jcUKUps7ecbenFaatnrj9okqT68M7HbZqCnSAIfqp2QfBbsrZcseg
	34oMqrIFnE3snQVQHZQR/4bU8AgEIqZqBvG+lURwP1JzhpoBq
X-Google-Smtp-Source: AGHT+IFT3fORCS1uO3agAaI0DSJUuopjwqwOJ72j25HnjbQXpO526LvyCiEC/PVEA/MY4yroAH4+nw==
X-Received: by 2002:a05:6a00:9285:b0:74e:a9ba:55f with SMTP id d2e1a72fcca58-76035af7b5bmr6077752b3a.20.1753298022925;
        Wed, 23 Jul 2025 12:13:42 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-759cbc67a87sm10307680b3a.145.2025.07.23.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:13:42 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: ashishk@purestorage.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: [PATCH v2 0/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Wed, 23 Jul 2025 13:13:34 -0600
Message-ID: <20250723191334.35277-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2507091730410.56608@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2507091730410.56608@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025, Maciej W. Rozycki wrote:
>  I made a test once and left the system up for half a year or so.  The 
> LBMS bit was set once, a couple of days after system reset.  I cleared it 
> by hand and it never retriggered for the rest of the experiment, so this 
> single occasion must have been a glitch and not a link quality issue.

I guess you also did not observe unusual number of correctable errors? I wonder
if AER was under OS control & the relevant errors were unmasked (RxErr, BadTLP,
BadDLLP, Replay Rollover, Replay Timeout). If the link transitions from L0 to
Recovery state due to excessive LCRC failures I have seen it return at the same
speed many times. I won't be able to say what the LBMS behavior is in that case
for some time unless I get lucky & find one in our internal test pool.


