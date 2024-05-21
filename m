Return-Path: <linux-pci+bounces-7724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF578CB2EE
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 19:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78011C2196A
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFCF147C94;
	Tue, 21 May 2024 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBVc69XY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649C12F58F;
	Tue, 21 May 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716312896; cv=none; b=b62AbPVYJKIcxsTY1JsXcHdm6qe1mIcg9VFH9u3kchf5LHbonk0ssMsQYjTRqsNLakaS7bMybwXPRi4VtzI5p0Wl2VfiFqRs/ZLhB4FoKdvC5Pffn4NvE6uGm3GMovt9oSFiOeotJ996MYA/qV8XoZ+Y5ZoE5xU7y0UC9G5BAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716312896; c=relaxed/simple;
	bh=c2kHZM/T9HIIiKdVJZ1uKyZ5IQfEUIzPgC9/2aeKNBY=;
	h=From:Content-Type:Mime-Version:Subject:Date:Message-Id:Cc:To; b=hrPuEcfgsISot+MFttshaPgQHuymynYIistQjMwdHgJKLuMF+WXCdf/lgGeBeeWnRYwXF/HaOmHTFVHk12cc328fBbIOi3/HBUO7enYWJZZl5dQI3hR+zORe7gqH2pu5oYELSJZqhu2uocvjQs5Bf4+kR9liYbrC0elVTTaUbQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBVc69XY; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f12ed79fdfso1920360a34.0;
        Tue, 21 May 2024 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716312894; x=1716917694; darn=vger.kernel.org;
        h=to:cc:message-id:date:subject:mime-version:reply-to
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atIYRDSM21wXH5p/I8X6KQp3p9fC4TApzoZBDsjakTA=;
        b=FBVc69XYqzA++XLVz3iHSgpuDIpxNKBC/bn/yXOfAFq8ZF1dDgWcIBYUAhknQApD2y
         YKu++cOfnseNETm8RdR7GCkiA28yaPAipBQuDQjEFx3KEyvsqcTR4f0L3rvotCZGsMs0
         srGmkjyCQfhR7FDyv4u8yQotzjHck0ufwPwkM0WuuI4prrdRm4jgZBQsUxDl/BbZEZ+G
         6CUSDE9nbAVrlckDnja5aJDa0cbKZ1XANCvztNdC/4nVJOeTmUeivJCLFEKOgFbSDjOK
         Z+iRiYgwoGjkLufI3wy0mK3lci2O5wSIpydBavkPh0mRY/xCtSmJ7RP1I0D86oPfm8Tr
         1ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716312894; x=1716917694;
        h=to:cc:message-id:date:subject:mime-version:reply-to
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atIYRDSM21wXH5p/I8X6KQp3p9fC4TApzoZBDsjakTA=;
        b=CFRFAOXn1NndVNd3Jl7QgqSIZr5LvZILNDhHtB6v6+iLRo2eXcYvOVsdS7KPPVokcR
         KbElF2bCr54+k+0A50H7+Tll3oE2aKwjbOyBkghINRNrc/je/rp3DO+vJ3udkFcbgFFX
         hVImoKZ6CGANSW9BRzkI1tXEPaiW1bSVDvUuD7FoesTzn8sJ+GDy+KJ03BFWD/sSyIHb
         7QbbZO5iOvrBCM1EpNvwoMv/nwtlPqo9CaWPwEWQAD4YnEu2uoSRZrXorThK5TiXeN8b
         S2tKPODc/yXKyHj/4EhoSh8SL2uG3IxJva7vpcjz/p9dPB2SI5rZ7XCtD86B1iakWQdf
         LTPg==
X-Forwarded-Encrypted: i=1; AJvYcCW5eP6DL2F2QBVBzmYRMHA6TYfK+Q5upnIZ4ll7FwnS43L1DuU1zjBBzZf+OskFjSQRbZ6ySOmK6eRACRJ5ARKeH2ZYhpH7tRXmvf9adgQNQlAzv1wkhvB4SOjdXtm/9PJQR2dP
X-Gm-Message-State: AOJu0YwtUCalNJ9J7LlTw0vMAaK4jQfyfxI56H/uZWzqTFPUELY5O1K6
	J0efKRq8D3cD4qspTzp1Xz9X7Tv4pEOqyhRH9+gsAYfMzY/H2G7P
X-Google-Smtp-Source: AGHT+IFPexkjdG+xCYyOCQgEKVngyuytyilUlEOA53NHqJcCo6Mk2b95BY97THETx7qwEZZnfhWyiA==
X-Received: by 2002:a05:6871:215:b0:229:929a:b127 with SMTP id 586e51a60fabf-24172bdf8bamr40140060fac.37.1716312893110;
        Tue, 21 May 2024 10:34:53 -0700 (PDT)
Received: from smtpclient.apple ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24c62b40970sm81826fac.22.2024.05.21.10.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2024 10:34:52 -0700 (PDT)
From: Vishal Aslot <os.vaslot@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Reply-To: 20240325235914.1897647-3-dave.jiang@intel.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Date: Tue, 21 May 2024 12:34:40 -0500
Message-Id: <E1AAAE3F-E059-4C57-BC23-6B436A39430A@gmail.com>
Cc: Jonathan.Cameron@huawei.com,
 alison.schofield@intel.com,
 bhelgaas@google.com,
 dan.j.williams@intel.com,
 dave@stgolabs.net,
 ira.weiny@intel.com,
 linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org,
 lukas@wunner.de,
 vishal.l.verma@intel.com,
 Vikram Sethi <vikramsethi@gmail.com>
To: dave.jiang@intel.com
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi,
       For T2 and T3 persistent memory devices, wouldn=E2=80=99t we also =
need a way to trigger device cache flush and then disable out of =
cxl_reest_bus_function()?
       CXL Spec 3.1 (Aug =E2=80=9923), Section 9.3 which refers to =
system reset flow has RESETPREP VDMs to trigger device cache flush, put =
memory in safe state, etc. These devices would benefit from this in case =
of SBR as well, but it is root port specific so may be an ACPI method =
could be involved out of cxl_reset_bus_function()?

-Vishal=

