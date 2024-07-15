Return-Path: <linux-pci+bounces-10321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89465931C62
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 23:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436422846F1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 21:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911738174E;
	Mon, 15 Jul 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4xyRFUc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3C13AA2A;
	Mon, 15 Jul 2024 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077720; cv=none; b=fBOBWG6V7fcl0PRmS0Ao0dlgE0SSIB3jtLugWp/gnVgkLWikMUuCrpSsZXGuU+JVw7Scmyeg14jjtzaK05dcRTPbM2MtOzseqkHWr1zKqZ+GXP1RDVyL1lVLjySym2WTHyMLJsXkbBaQMehJyBtXq3yt1h+TB2VzIEVxy1/e5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077720; c=relaxed/simple;
	bh=Uh70xKxX3+mFPrDX/kE70rsVBc5GCAcwlqsL7wr2mnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ix1fKha9c8I3S4pXuwKG5FPqmZVfS85+SiHU/7V1pf+Zqs9Z78uFkjWUo/SMvilAOSBi/K4J2fKu5Rw4xm6AboU5N0gk5oseg2Gp0vLN+FbGBNfx11QeFKZT54CEvjaCiEOh4lQ1hcoxoB/ndpiffSggJDeHC3+MSZ36rfnSPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4xyRFUc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44caaf77c7eso25868151cf.3;
        Mon, 15 Jul 2024 14:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721077718; x=1721682518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xg52cnsRYDFLsxiQv0l8fuhhgGtnnB1PWzGQf27DmEc=;
        b=K4xyRFUcrhaB+K0LNBiIoMKOqshU314jPIHmYh2ZsHgQImk+QrkOVVbC31beuYO9st
         yxT7AE/4tCbwfwgS3jXHqIdD1eW/+1Xe2iNoCFC3nYfDAmTFAWSwPUZRUje5RxsLzO4k
         hW8HG0HkICVTSPkTvUteIwxXdnzvjaOuR/G3j5dsjTTOEAwknkht6GeCF7UiugfSW+28
         eXkhpdCYCTFpEraf/cl2gPiBppE+W98gmoA302SAPJ3q07S2/2VnWUeAVhmtFttIH4gb
         eA7dG/B64a3S7GgnYSn7tn+VhG3iJU2ZRkcu471nHBxrjZburdB5Ku/gFHgPtDJF9rn5
         fONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721077718; x=1721682518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg52cnsRYDFLsxiQv0l8fuhhgGtnnB1PWzGQf27DmEc=;
        b=doPS3fHHBS/aI9ihK5m50iZnYoajlYufmNJKsRFUCGdmgFDJWaIm9DmicjHd6bBMIJ
         WN3V2bWEv99fcez7T78A8UBFw1119ij2XzJD05yNPUH4YjKVT4cZFhpWFUvNc0wkYf7g
         rZCJKkNWnFDLyiv1FKEI/PcWfetqRiYq8CIfK+nSZSGPd13g3nEuuC+XSOrN5xOAlXhQ
         LVut6UYUk1vDzIZN7/oa9hTEAgT0d8brjz0gZr9eRSes7HLE6W6htE0HbJqXpCU9iZ1p
         4Dabe1rbp0auZE3x8Ht/RyTi4xhRYMRiZQKS+R1lRxWBHb8K3kJFg7Mr7Ezl4NYdw+IS
         Lusw==
X-Forwarded-Encrypted: i=1; AJvYcCVaA3VGF5Y/G8jeXtIRA3XNBz5pCNxLqGpe13lE4crrSjlaEI/iuxqtQs9gtYLOT4Whsq0iLsKQ1xu1fxZnDIAFjGJCoHAI+t7CRocT7/7rHKrTC7H3tkXyLvQCCD5igmaYGKikNNsX
X-Gm-Message-State: AOJu0YwbNqL5iKjE9VwkBfvPRQf8+DrlnTHFFwnt/pKLM3NHAkk0tdSU
	vClifjjcnAtGJJqjwq5Bk3HQbcUVVtvkBIcbVsI81TAlSFpZZS29
X-Google-Smtp-Source: AGHT+IGcMQSi6ArxHHMMJh/alK4lucEdIGS992m6FlQ+Hm+NO/rUt9RTFtrb9+8V4/v5EOEaKQiONQ==
X-Received: by 2002:a05:622a:2c3:b0:440:6ccb:e6d5 with SMTP id d75a77b69052e-44f7aeb38c6mr4494751cf.51.1721077717690;
        Mon, 15 Jul 2024 14:08:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-44f5b7eded2sm28534331cf.39.2024.07.15.14.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 14:08:36 -0700 (PDT)
Message-ID: <67b6fc09-7edc-4fae-859a-dc386d4deada@gmail.com>
Date: Mon, 15 Jul 2024 14:08:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] PCI: brcmstb: Don't conflate the reset rescal
 with phy ctrl
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240710221630.29561-1-james.quinlan@broadcom.com>
 <20240710221630.29561-9-james.quinlan@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240710221630.29561-9-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 15:16, Jim Quinlan wrote:
> We've been assuming that if an SOC has a "rescal" reset controller that we
> should automatically invoke brcm_phy_cntl(...).  This will not be true in
> future SOCs, so we create a bool "has_phy" and adjust the cfg_data
> appropriately (we need to give 7216 its own cfg_data structure instead of
> sharing one).
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


