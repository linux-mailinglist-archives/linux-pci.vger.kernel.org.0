Return-Path: <linux-pci+bounces-41049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E04C55A62
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FB83B4681
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 04:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2732940B;
	Thu, 13 Nov 2025 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="hvbFAPzY"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65644219E8
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763008238; cv=none; b=LI7TPTHnwn2iayYYbTdYTZE/Ddc1ejKgWPh6pJtXbv7VM8eMNGTXR7rOTJpCoenaWkLeQQwCP4YjTmAA+38ips3VLsYLzKPm2UiYYkuQnfSa+gIWbTyIPrrTV7b5/rG598ghSOjbzRQ5ZY3lTpk+XrXUqBqMBkLfnYo/50ZoUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763008238; c=relaxed/simple;
	bh=US+7v81osJ0uW032Oe8gE26I8oP3qC9+Og1pyzDZDAw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ufHD7wJVWMeAga4Eam0xc4UIHXYdAhe+93JA6NP1Gy4y8XnSnbdz5Dk6yL1aSnbGanVHHniaFK5wCX21Hfy8BRSk9W9Eo5rWTnFqnbvIIKvmscQgMc/ivwtvF/jR1JY78oFWnDvcPbLdWMWSFGhg9Q/y9rXcDhS3Kl5JFUlzwss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=hvbFAPzY; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <21398de7-3dd9-4c43-97d9-7c3002c401e5@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1763008228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Wd+y9phtR/SGFwJsQf0Udv3Ipd13kkGAbXUUrqrbUk=;
	b=hvbFAPzYbt0eJQ5weJEXwVaxyk2djG+MTVeHkQlEWYQJUn9zPtHR/1DGJyaJ7o4irzQG8b
	V4KBZEw7VChEdwK8/8V0zgIF3WF8/TDSKX8ms54snDdJlRwn+gdimq5R70dO9Zdhf9bJzN
	XHKYp1ngwDAYU4wQFftidsA7Wcjqis8CgacD7D0fBlWT8xUAH0Fa9un2siWnzUeKVqYhGk
	wHX8ALgMKMllFrToDRhLcb+LJPUxaSjrXQuPGvZVA6kUGLGo2/lIX0cRG8Rb3Alg59nsOI
	LwaDRRZCuHaTA5LcuRYvKJ4g6xfiBrPqtSiUExaxyBH2tg35e5uw2ZJSS5xTOQ==
Date: Thu, 13 Nov 2025 01:30:17 -0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 manivannan.sadhasivam@oss.qualcomm.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Valentine Burley <valentine.burley@collabora.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
 <4cp5pzmlkkht2ni7us6p3edidnk25l45xrp6w3fxguqcvhq2id@wjqqrdpkypkf>
 <36f05566-8c7a-485b-96e7-9792ab355374@packett.cool>
 <qy4cnuj2dfpfsorpke6vg3skjyj2hgts5hhrrn5c5rzlt6l6uv@b4npmattvfcm>
 <c27b5514-1691-448a-9823-8b35955b0fc6@packett.cool>
 <twn5ryedkpv76ph3i7xbovktz3abqszthl6cxhtv6uczbv4ap7@4wrmlczxzjll>
 <666481e9-4ce3-415f-bad4-e0b4ccf9a4d2@packett.cool>
Content-Language: en-US
In-Reply-To: <666481e9-4ce3-415f-bad4-e0b4ccf9a4d2@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/11/25 2:29 PM, Val Packett wrote:
> [..]
>
> Now testing with this drive and no arg:
>
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- 
> CommClk+
>                         ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt- 
> FltModeDis-
>
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- 
> ASPM_L1.1-
>                            T_CommonMode=0us LTR1.2_Threshold=156672ns
>
> Let's see how it goes.

Update: close to 2 days in, went AFK to eat and came back to a gdm login 
prompt once again. (This is the stock WD drive and no force.)

This does not seem to be related to L1ss.


~val


